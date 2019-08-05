module pcontrol_m
        use io_m
        use rigid_body_m
        use time_m
        implicit none 
        integer, parameter :: input_fd = 3 
        integer :: nbodies = 0
        type(rigid_body_t), target, dimension(:), allocatable :: bodies1, bodies2
        type(rigid_body_t), pointer, dimension(:) :: current, tmp
        type(time_t) :: sim_time

        public :: parse_args
contains
        subroutine parse_args()
                implicit none
                character(len = 255) :: filename
                integer :: narg

                narg=command_argument_count()
                if ( narg /= 1 ) then
                        call usage()
                        call end_program(1)
                end if

                call get_command_argument(1, filename)
                call open_read(filename, input_fd)
                print *, "Succefully loaded input file"

        end subroutine parse_args

        subroutine usage()
                print *, "Usage ./main.x inputfile"
        end subroutine usage

        subroutine end_program(ec)
                implicit none
                integer :: ec
                if (ec == 0) then
                        stop
                else
                        error stop
                endif
        end subroutine end_program

        subroutine parse_input()
                implicit none
                character(len = 255) :: id
                integer :: stat = 0, I

                do while( stat == 0 )
                read (input_fd, *, IOSTAT=stat) id
                if (id == "BODIES") then
                        read (input_fd, *, IOSTAT=stat) nbodies
                        allocate(bodies1(nbodies)) 
                        allocate(bodies2(nbodies))
                        current =>  bodies1
                        tmp     =>  bodies2
                        do I=1,nbodies
                        call read_rigid_body(input_fd, current(i), stat)        
                        call print_rigid_body(current(i))
                        end do
                        id = "NONE"
                else if (id == "TIME") then
                        call read_time(input_fd, sim_time, stat)
                        call print_time(sim_time)
                        id = "NONE"
                end if
                end do
        end subroutine parse_input

        subroutine simulate()
                implicit none
                

                ! update bodies in tmp
                ! swap tmp to current
                ! update time step



        end subroutine simulate

end module pcontrol_m

