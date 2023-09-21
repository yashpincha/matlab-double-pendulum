function double_pendulum(l1, l2, m1, m2, tspan, theta1_0, theta1_prime_0, ...
    theta2_0, theta2_prime_0)

% Make some plots of double pendulum behavior.

% This function takes a bunch of inputs. See the my_double_pendulum
% function for an example of how to set them up.

% See also:
% MY_DOUBLE_PENDULUM

% Gravitational constant.
g = 9.8;

% Here's the step function that calculates the pendulum behavior.

    function yprime = my_local_pend(t, y) %#ok<INUSL>
        % Pendulum action step function
        
        % NOTE: I do not know why we are ignoring the "t" input argument!
        yprime = zeros(4, 1);
        
        a = (m1 + m2) * l1;
        b = m2 * l2 * cos(y(1) - y(3));
        c = m2 * l1 * cos(y(1) - y(3));
        d = m2 * l2;
        e = -m2 * l2 * y(4) * y(4) * sin(y(1) - y(3)) - g * (m1 + m2) * sin(y(1));
        f = m2 * l1 * y(2) * y(2) * sin(y(1) - y(3)) - m2 * g * sin(y(3));
        
        yprime(1) = y(2);
        yprime(3) = y(4);
        yprime(2) = (e*d-b*f) / (a*d-c*b);
        yprime(4) = (a*f-c*e) / (a*d-c*b);
        
    end

y_0 = [theta1_0 theta1_prime_0 theta2_0 theta2_prime_0];
[t, y] = ode45(@my_local_pend, [0, tspan], y_0);

% Here's the time series of each variable
[theta1, theta1_prime, theta2, theta2_prime] = deal(y(:,1), y(:,2), y(:,3), y(:,4));

% Position of mass 1 and mass 2

x1 = l1 * sin(y(:,1));
y1 = -l1 * cos(y(:,1));
x2 = l1 * sin(y(:,1)) + l2 * sin(y(:,3));
y2 = -l1 * cos(y(:,1)) - l2 * cos(y(:,3));

% Visualizing the result

% Plot the X/Y procession path

fig1 = figure;
ax = gca;
apply_plot_cosmetics(fig1, ax);
plot(x1, y1, 'linewidth', 2);
hold on
plot(x2, y2, 'r', 'linewidth', 2);
xlabel(ax, 'X', 'fontSize', 14);
ylabel(ax, 'Y', 'fontSize', 14);
title(ax, 'Chaotic Double Pendulum', 'fontsize', 14);

% Plot theta1 and theta2 vs time

fig2 = figure;
ax = gca;
apply_plot_cosmetics(fig2, ax);
plot(ax, theta1, 'linewidth', 2);
hold on
plot(ax, theta2, 'r', 'linewidth', 2);
legend(ax, '\theta_1', '\theta_2');
xlabel(ax, 'time', 'fontSize', 14);
ylabel(ax, 'theta', 'fontSize', 14);
title(ax, '\theta_1(t=0)=2.5 and \theta_2(t=0)=1.0','fontsize', 14);

% Plot theta1 prime and theta2 prime vs time

fig4 = figure;
ax = gca;
apply_plot_cosmetics(fig4, ax);
plot(t, [theta1_prime, theta2_prime]);
title(ax, 'theta1\_prime and theta2\_prime over time');
legend(ax, '\theta_1_prime', '\theta_2_prime');
xlabel(ax, 'Time');
ylabel(ax, 'theta primes');

% Actually we don't care; turn this off

function apply_plot_cosmetics(fig, ax)
set(fig, 'color', 'white');
set(ax, 'fontSize', 14);
end
end
