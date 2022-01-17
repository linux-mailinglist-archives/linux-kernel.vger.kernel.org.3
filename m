Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40154490952
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiAQNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:18:07 -0500
Received: from foss.arm.com ([217.140.110.172]:58228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbiAQNSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:18:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52FD81FB;
        Mon, 17 Jan 2022 05:18:05 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD7453F774;
        Mon, 17 Jan 2022 05:18:03 -0800 (PST)
Subject: Re: [PATCH v2 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-7-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <265e98a5-d641-9ba9-3fac-4844ceaf643d@arm.com>
Date:   Mon, 17 Jan 2022 14:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112161230.836326-7-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 17:12, Vincent Donnefort wrote:

[...]

> +static inline unsigned long
> +get_pd_busy_time(struct task_struct *p, struct cpumask *cpus,
> +		 unsigned long pd_cap)
> +{
> +	unsigned long busy_time = 0;
> +	int cpu;
>  
> -	/*
> -	 * The capacity state of CPUs of the current rd can be driven by CPUs
> -	 * of another rd if they belong to the same pd. So, account for the
> -	 * utilization of these CPUs too by masking pd with cpu_online_mask
> -	 * instead of the rd span.
> -	 *
> -	 * If an entire pd is outside of the current rd, it will not appear in
> -	 * its pd list and will not be accounted by compute_energy().
> -	 */
>  	for_each_cpu(cpu, cpus) {
> -		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> -		unsigned long cpu_util, util_running = util_freq;
> -		struct task_struct *tsk = NULL;
> +		unsigned long util = cpu_util_next(cpu, p, -1);
>  
> -		/*
> -		 * When @p is placed on @cpu:
> -		 *
> -		 * util_running = max(cpu_util, cpu_util_est) +
> -		 *		  max(task_util, _task_util_est)
> -		 *
> -		 * while cpu_util_next is: max(cpu_util + task_util,
> -		 *			       cpu_util_est + _task_util_est)
> -		 */
> -		if (cpu == dst_cpu) {
> -			tsk = p;
> -			util_running =
> -				cpu_util_next(cpu, p, -1) + task_util_est(p);
> -		}
> +		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
> +	}
>  
> -		/*
> -		 * Busy time computation: utilization clamping is not
> -		 * required since the ratio (sum_util / cpu_capacity)
> -		 * is already enough to scale the EM reported power
> -		 * consumption at the (eventually clamped) cpu_capacity.
> -		 */
> -		cpu_util = effective_cpu_util(cpu, util_running, ENERGY_UTIL,
> -					      NULL);
> +	return min(pd_cap, busy_time);

You're capping the busy_time (sum of effective_cpu_util() of CPUs in
cpus) by pd capacity (cpumask_weight(cpus) * cpu_thermal_cap).

Before, each effective_cpu_util() was capped by cpu_thermal_cap
individually: sum_util += min(effective_cpu_util(), cpu_thermal_cap)

Why did you change that? Because of the way you calculate busy time with
the task: busy_time = min(pd_cap, busy_time + tsk_busy_time) ?

[...]

> @@ -6662,9 +6690,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
> +	unsigned long busy_time, tsk_busy_time, max_util, pd_cap;
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
>  	int cpu, best_energy_cpu = prev_cpu, target = -1;
> -	unsigned long cpu_cap, util, base_energy = 0;
> +	unsigned long cpu_cap, cpu_thermal_cap, util;
> +	unsigned long base_energy = 0;
>  	struct sched_domain *sd;
>  	struct perf_domain *pd;
>  
> @@ -6689,6 +6719,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	if (!task_util_est(p))
>  		goto unlock;
>  
> +	tsk_busy_time = get_task_busy_time(p, prev_cpu);
> +
>  	for (; pd; pd = pd->next) {
>  		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
>  		bool compute_prev_delta = false;
> @@ -6697,7 +6729,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  
>  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
>  
> -		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> +		/* Account thermal pressure for the energy estimation */
> +		cpu = cpumask_first(cpus);
> +		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> +		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> +
> +		for_each_cpu(cpu, cpus) {
> +			pd_cap += cpu_thermal_cap;
> +
> +			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +				continue;
> +
>  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  				continue;
>  
> @@ -6734,12 +6776,21 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			continue;
>  
>  		/* Compute the 'base' energy of the pd, without @p */
> -		base_energy_pd = compute_energy(p, -1, cpus, pd);
> +		busy_time = get_pd_busy_time(p, cpus, pd_cap);
> +		max_util = get_pd_max_util(p, -1, cpus, cpu_thermal_cap);

There is this issue now that we would iterate twice now over `cpus`
here. To avoid this, I can only see the solution to introduce a

    struct eas_env {
           unsigned long max_util;      (1)
           unsigned long busy_time;     (2)
           unsigned long busy_tsk_time; (3)
           ...
    }

replace get_pd_busy_time() and get_pd_max_util() with

    get_energy_params(struct eas_env *env, ...)

and make sure that (1)-(3) are calculated and returned here whereas only
(1) is later for `if (compute_prev_delta)` and `if (max_spare_cap_cpu >=
0)`. E.g. by passing this switch with the env.
This would allow the keep pd_cap within get_energy_params(). W/o struct
eas_env, IMHO this function ends up with too many parameters.

That said, I haven't seen asymmetric CPU capacity processors with more
than 6 CPUs in one PD (i.e. Frequency Domain)

[...]
