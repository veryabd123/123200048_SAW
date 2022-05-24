function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 24-May-2022 21:47:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('heart.csv'); % untuk mengimpor data dari exel
opts.SelectedVariableNames = (1:13);
data = readmatrix('heart.csv',opts);
set(handles.uitable1,'data',data); % memasukan data exel ke table
datavariabel = [ 1 0.15; % deklarasi nilai atribut 
    1 0.15;
    1 0.30;
    1 0.25;
    1 0.15];
set(handles.uitable4,'data',datavariabel); %menampilkan data dalam bentuk tabel


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('heart.csv'); % memasukan data exel ke table
opts.SelectedVariableNames = (3:7);
data = readmatrix('heart.csv',opts);
k = [1,1,1,1,1]; % deklarasi nilai atribut
w =[0.15,0.20,0.30,0.25,0.10]; % deklarasi bobot atribut
%tahapan 1. normalisasi matriks
[m n]=size (data); %matriks m x n dengan ukuran sebanyak variabel data(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1,%statement untuk kriteria dengan atribut keuntungan
 R(:,j)=data(:,j)./max(data(:,j));
    else
 R(:,j)=min(data(:,j))./data(:,j);
    end;
end;
%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:))
end;

[rank,rowRank] = sort(V,'descend'); % pengurutan data dari yg terbesar
baris = length(rank); 
dataTable = cell(baris,2); % menampilkan data hasil dalam bentuk tabel
for row = 1:baris
    dataTable{row, 1} = rowRank(row);
    dataTable{row, 2} = rank(row);
end
set(handles.uitable2,'Data',dataTable);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
imshow('download.jpg'); %untuk menampilkan gambar dari file 