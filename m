Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBB492312
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiARJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:47:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbiARJrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:47:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 606991FB;
        Tue, 18 Jan 2022 01:47:01 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5DC63F774;
        Tue, 18 Jan 2022 01:46:59 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:46:57 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH v2 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
Message-ID: <YeaMO6v2HZy3OVUv@FVFF7649Q05P>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-7-vincent.donnefort@arm.com>
 <265e98a5-d641-9ba9-3fac-4844ceaf643d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265e98a5-d641-9ba9-3fac-4844ceaf643d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 02:17:55PM +0100, Dietmar Eggemann wrote:
> On 12/01/2022 17:12, Vincent Donnefort wrote:
> 
> [...]
> 
> > +static inline unsigned long
> > +get_pd_busy_time(struct task_struct *p, struct cpumask *cpus,
> > +		 unsigned long pd_cap)
> > +{
> > +	unsigned long busy_time = 0;
> > +	int cpu;
> >  
> > -	/*
> > -	 * The capacity state of CPUs of the current rd can be driven by CPUs
> > -	 * of another rd if they belong to the same pd. So, account for the
> > -	 * utilization of these CPUs too by masking pd with cpu_online_mask
> > -	 * instead of the rd span.
> > -	 *
> > -	 * If an entire pd is outside of the current rd, it will not appear in
> > -	 * its pd list and will not be accounted by compute_energy().
> > -	 */
> >  	for_each_cpu(cpu, cpus) {
> > -		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> > -		unsigned long cpu_util, util_running = util_freq;
> > -		struct task_struct *tsk = NULL;
> > +		unsigned long util = cpu_util_next(cpu, p, -1);
> >  
> > -		/*
> > -		 * When @p is placed on @cpu:
> > -		 *
> > -		 * util_running = max(cpu_util, cpu_util_est) +
> > -		 *		  max(task_util, _task_util_est)
> > -		 *
> > -		 * while cpu_util_next is: max(cpu_util + task_util,
> > -		 *			       cpu_util_est + _task_util_est)
> > -		 */
> > -		if (cpu == dst_cpu) {
> > -			tsk = p;
> > -			util_running =
> > -				cpu_util_next(cpu, p, -1) + task_util_est(p);
> > -		}
> > +		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
> > +	}
> >  
> > -		/*
> > -		 * Busy time computation: utilization clamping is not
> > -		 * required since the ratio (sum_util / cpu_capacity)
> > -		 * is already enough to scale the EM reported power
> > -		 * consumption at the (eventually clamped) cpu_capacity.
> > -		 */
> > -		cpu_util = effective_cpu_util(cpu, util_running, ENERGY_UTIL,
> > -					      NULL);
> > +	return min(pd_cap, busy_time);
> 
> You're capping the busy_time (sum of effective_cpu_util() of CPUs in
> cpus) by pd capacity (cpumask_weight(cpus) * cpu_thermal_cap).
> 
> Before, each effective_cpu_util() was capped by cpu_thermal_cap
> individually: sum_util += min(effective_cpu_util(), cpu_thermal_cap)
> 
> Why did you change that? Because of the way you calculate busy time with
> the task: busy_time = min(pd_cap, busy_time + tsk_busy_time) ?

It avoids having to cap each CPU separately and also aligns with task_busy_time.
I guess we could argue this isn't the most accurate solution but without taking
this shortcut, we'd have to walk through all the CPUs again for the busy time
computation when testing the task placement. :/

But now reading it again makes me feel I might have not taken the right decision
and we'd prefer not fall into the case where the utilization of a single CPU is
too high but the global PD's is not. 

> 
> [...]
> 
> > @@ -6662,9 +6690,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  {
> >  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> >  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
> > +	unsigned long busy_time, tsk_busy_time, max_util, pd_cap;
> >  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> >  	int cpu, best_energy_cpu = prev_cpu, target = -1;
> > -	unsigned long cpu_cap, util, base_energy = 0;
> > +	unsigned long cpu_cap, cpu_thermal_cap, util;
> > +	unsigned long base_energy = 0;
> >  	struct sched_domain *sd;
> >  	struct perf_domain *pd;
> >  
> > @@ -6689,6 +6719,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  	if (!task_util_est(p))
> >  		goto unlock;
> >  
> > +	tsk_busy_time = get_task_busy_time(p, prev_cpu);
> > +
> >  	for (; pd; pd = pd->next) {
> >  		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> >  		bool compute_prev_delta = false;
> > @@ -6697,7 +6729,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  
> >  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> >  
> > -		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > +		/* Account thermal pressure for the energy estimation */
> > +		cpu = cpumask_first(cpus);
> > +		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> > +		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> > +
> > +		for_each_cpu(cpu, cpus) {
> > +			pd_cap += cpu_thermal_cap;
> > +
> > +			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > +				continue;
> > +
> >  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >  				continue;
> >  
> > @@ -6734,12 +6776,21 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  			continue;
> >  
> >  		/* Compute the 'base' energy of the pd, without @p */
> > -		base_energy_pd = compute_energy(p, -1, cpus, pd);
> > +		busy_time = get_pd_busy_time(p, cpus, pd_cap);
> > +		max_util = get_pd_max_util(p, -1, cpus, cpu_thermal_cap);
> 
> There is this issue now that we would iterate twice now over `cpus`
> here. To avoid this, I can only see the solution to introduce a
> 
>     struct eas_env {
>            unsigned long max_util;      (1)
>            unsigned long busy_time;     (2)
>            unsigned long busy_tsk_time; (3)
>            ...
>     }
> 
> replace get_pd_busy_time() and get_pd_max_util() with
> 
>     get_energy_params(struct eas_env *env, ...)

That'd be cleaner yeah, I'll give a try for a next version.

Thanks.

> 
> and make sure that (1)-(3) are calculated and returned here whereas only
> (1) is later for `if (compute_prev_delta)` and `if (max_spare_cap_cpu >=
> 0)`. E.g. by passing this switch with the env.
> This would allow the keep pd_cap within get_energy_params(). W/o struct
> eas_env, IMHO this function ends up with too many parameters.
> 
> That said, I haven't seen asymmetric CPU capacity processors with more
> than 6 CPUs in one PD (i.e. Frequency Domain)
> 
> [...]
