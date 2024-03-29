function ret = cd1(rbm_w, visible_data)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_data> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% The returned value is the gradient approximation produced by CD-1. It's of the same shape as <rbm_w>.

    visible_data = sample_bernoulli(visible_data);
%     
    hidden_probabilities = visible_state_to_hidden_probabilities(rbm_w, visible_data);
%     
    hidden_sample = sample_bernoulli(hidden_probabilities);
%     
    data_goodness = configuration_goodness_gradient(visible_data, hidden_sample);
    
    visible_probabilities = hidden_state_to_visible_probabilities(rbm_w, hidden_sample);
    
    visible_sample = sample_bernoulli(visible_probabilities);
    
    hidden_probabilities = visible_state_to_hidden_probabilities(rbm_w, visible_sample);
    
%     hidden_probabilities_sample = sample_bernoulli(hidden_probabilities);
    reconstruction_goodness = configuration_goodness_gradient(visible_sample, hidden_probabilities);

    ret = data_goodness - reconstruction_goodness;
end
