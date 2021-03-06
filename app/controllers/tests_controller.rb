class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
    @test.timetables.build
  end

  # GET /tests/1/edit
  def edit
    @test.timetables.build
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url }
      format.json { head :no_content }
    end
  end


# registration

  def register
    # ajutiselt laseme mitu korda regada, et poleks vaja mitut timetable-t
    #if !Attempt.exists?(:user_id=>1, :timetable_id=>params[:id])
    if true then 
     # TODO! check if there is room!
     
     # get user, create attempt but dont start
     attempt= Attempt.new
     #attempt.user=current_user
     attempt.user_id=1
     attempt.timetable=Timetable.find(params[:id])
     attempt.registration_date=DateTime.now
     attempt.save
      flash[:notice]="Registration successful";
    else
      flash[:error] ="You have already registered for this test!"
    end
  end

  def unregister
    # get user and test to unregister from
    # should only be available while test is not started
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:title, :description, :duration, :hard_count, :medium_count, :easy_count, timetables_attributes: [:id, :registration_start, :registration_end, :start, :end, :slots, :location, :_destroy])
    end
end
