class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    @pet = Pet.create(params[:pet])

    if params[:owner_name] == ""
      @pet.owner = Owner.find(params[:owner])

    else
      #binding.pry
      @pet_owner = Owner.create(name: params[:owner_name])
      @pet.owner = @pet_owner
      #binding.pry
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    # if !params[:pet].keys.include?("owner_ids")
    #   params[:pet]["owner_ids"] = []
    # end
      #######
    
    @pet = Pet.find(params[:id])
    #binding.pry
    @pet.update(params["pet"])
    @pet.owner = Owner.find(params["owner"]["id"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      
    end
    @pet.save
    redirect "pets/#{@pet.id}"
   
  end
end