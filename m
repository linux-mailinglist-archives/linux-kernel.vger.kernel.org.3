Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED6B4846FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiADR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:27:38 -0500
Received: from foss.arm.com ([217.140.110.172]:34076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235633AbiADR1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:27:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D823513A1;
        Tue,  4 Jan 2022 09:27:36 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1AF3F774;
        Tue,  4 Jan 2022 09:27:35 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 3/4] sched/fair: Remove task_util from effective
 utilization in feec()
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
References: <20211209161159.1596018-1-vincent.donnefort@arm.com>
 <20211209161159.1596018-4-vincent.donnefort@arm.com>
Message-ID: <d0cdf2cf-d098-627f-3a43-7d36f73a4c8f@arm.com>
Date:   Tue, 4 Jan 2022 18:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209161159.1596018-4-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 17:11, Vincent Donnefort wrote:
> The energy estimation in find_energy_efficient_cpu() (feec()) relies on
> the computation of the effective utilization for each CPU of a perf domain
> (PD). This effective utilization is then used as an estimation of the busy
> time for this pd. The function effective_cpu_util() which gives this value,
> scales the utilization relative to IRQ pressure on the CPU to take into
> account that the IRQ time is hidden from the task clock. The IRQ scaling is
> as follow:
> 
>    effective_cpu_util = irq + (cpu_cap - irq)/cpu_cap * util

effective_cpu_util stands for cpu_util (effective_cpu_util(...,
ENERGY_UTIL, ...),  right? (1)

> Where util is the sum of CFS/RT/DL utilization, cpu_cap the capacity of
> the CPU and irq the IRQ avg time.
> 
> If now we take as an example a task placement which doesn't raise the OPP
> on the candidate CPU, we can write the energy delta as:
> 
>   delta = OPPcost/cpu_cap * (effective_cpu_util(cpu_util + task_util) -
>                              effective_cpu_util(cpu_util))
>         = OPPcost/cpu_cap * (cpu_cap - irq)/cpu_cap * task_util
> 
> We end-up with an energy delta depending on the IRQ avg time, which is a
> problem: first the time spent on IRQs by a CPU has no effect on the
> additional energy that would be consumed by a task. Second, we don't want
> to favour a CPU with a higher IRQ avg time value.
> 
> Nonetheless, we need to take the IRQ avg time into account. If a task
> placement raises the PD's frequency, it will increase the energy cost for
> the entire time where the CPU is busy. A solution is to only use
> effective_cpu_util() with the CPU contribution part. The task contribution
> is added separately and scaled according to prev_cpu's IRQ time.

This whole idea looks like a follow-up of commit 0372e1cf70c2
("sched/fair: Fix task utilization accountability in compute_energy()").

I forgot why we still use cpu_util_next(cpu, p, dst_cpu) for
FREQUENCY_UTIL though?

> No change for the FREQUENCY_UTIL component of the energy estimation. We

OK, it indirectly says so. (1)

[...]

> @@ -6599,23 +6599,83 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>  	return min(util, capacity_orig_of(cpu));
>  }
>  
> +/*
> + * Compute the task busy time for compute_energy(). This time cannot be
> + * injected directly into effective_cpu_util() because of the IRQ scaling.
> + * The latter only makes sense with the most recent CPUs where the task has
> + * run.
> + */
> +static inline unsigned long
> +task_busy_time(struct task_struct *p, int prev_cpu)
> +{
> +	unsigned long cpu_cap = arch_scale_cpu_capacity(prev_cpu);

s/cpu_cap/max_cap ... to stay consistent

> +	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));

What about irq >= max_cap ?

effective_cpu_util() has the following condition:

if (unlikely(irq >= max_cap))
    return max_cap;

[...]

> + * The contribution of the task @p for which we want to estimate the energy
> + * cost is removed (by cpu_util_next()) and must be compted separalyte (see

s/compted separalyte/calculated separately ?

[...]

> +static inline unsigned long
> +pd_task_busy_time(struct task_struct *p, struct perf_domain *pd,
> +		  unsigned long cpu_cap, unsigned long tsk_busy_time,
> +		  unsigned long *pd_tsk_busy_time)
> +{
> +	unsigned long max_cap, pd_cap = 0, pd_busy_time = 0;
> +	struct cpumask *pd_mask = perf_domain_span(pd);
> +	int cpu;
> +
> +	max_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));

In case we use 'sched, drivers: Remove max param from
effective_cpu_util()/sched_cpu_util()'

https://gitlab.arm.com/linux-arm/linux-de/-/commit/150e753e861285e82e9d7c593f1f26075c34e124

we would not have to have max_cap for effective_cpu_util(). This would
make the code easier to understand since we already have to pass pd_cap
and cpu_cap (cpu_thermal_cap) now.

> +
> +	/* see compute_energy() */
> +	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {

Somehow unrelated ... We now use cpu_online_mask 3 times per PD to
iterate over the CPUs. cpu_online_mask can change during the run-queue
selection.

We could reuse `select_idle_mask` to create one cpumask at the beginning
of feec() and pass it down the fucntions:

See `sched/fair: Rename select_idle_mask to select_rq_mask` and
`sched/fair: Use the same cpumask per-PD throughout
find_energy_efficient_cpu()`

https://gitlab.arm.com/linux-arm/linux-de/-/commit/ec5bc27a298dd1352dbaff5809743128fa351075

https://gitlab.arm.com/linux-arm/linux-de/-/commit/f73b19968a65b07b0ad5bd1dff721ed1a675a24b

> +		unsigned long util = cpu_util_next(cpu, p, -1);
> +
> +		pd_cap += cpu_cap;
> +		pd_busy_time += effective_cpu_util(cpu, util, max_cap,
> +						     ENERGY_UTIL, NULL);
> +	}
> +
> +	pd_busy_time = min(pd_cap, pd_busy_time);
> +	*pd_tsk_busy_time = min(pd_cap, pd_busy_time + tsk_busy_time);

We do `sum_util += min(cpu_util, _cpu_cap (cpu_thermal_cap))` in
compute_energy() so far but now you sum up PD capacity (pd_cap) first
and then compare the sum_util (i.e. pd_busy_time) with pd_cap. Why?

cpu_util = effective_cpu_util(..., FREQUENCY_UTIL, ...) still uses
min(cpu_util, _cpu_cap).

> +
> +	return pd_busy_time;

This function seems to be a little bit overloaded. It's called
pd_task_busy_time but returns `pd` busy time and `pd + task` busy time.

In case we could calculate pd_cap pd_task_busy_time() then this function
can only return pd_busy_time and pd_tsk_busy_time could also calculate
outside the function.

See `XXX: Calculate pd_cap & pd_tsk_busy_time outside pd_task_busy_time()`

https://gitlab.arm.com/linux-arm/linux-de/-/commit/4512d681fe32eb5e2862c4c5d5a03b1d84129e26

[...]

> @@ -6628,34 +6688,11 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  	 */
>  	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
>  		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> -		unsigned long cpu_util, util_running = util_freq;
> +		unsigned long cpu_util;
>  		struct task_struct *tsk = NULL;
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
> +		if (cpu == dst_cpu)
>  			tsk = p;
> -			util_running =
> -				cpu_util_next(cpu, p, -1) + task_util_est(p);
> -		}
> -
> -		/*
> -		 * Busy time computation: utilization clamping is not
> -		 * required since the ratio (sum_util / cpu_capacity)
> -		 * is already enough to scale the EM reported power
> -		 * consumption at the (eventually clamped) cpu_capacity.
> -		 */
> -		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
> -					      ENERGY_UTIL, NULL);
> -
> -		sum_util += min(cpu_util, _cpu_cap);
>  
>  		/*
>  		 * Performance domain frequency: utilization clamping
> @@ -6664,12 +6701,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  		 * NOTE: in case RT tasks are running, by default the
>  		 * FREQUENCY_UTIL's utilization can be max OPP.
>  		 */
> -		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
> +		cpu_util = effective_cpu_util(cpu, util_freq, max_cap,
>  					      FREQUENCY_UTIL, tsk);
> -		max_util = max(max_util, min(cpu_util, _cpu_cap));
> +		max_util = max(max_util, min(cpu_util, cpu_cap));
>  	}

It's hard to understand since it is unbalanced that `busy time` is
calculated in pd_busy_time() whereas `max_util` is still calculated in
compute_energy().

IMHO it would be much easier to understand if there would be a
pd_max_util() as well so that we could do:

  busy_time = get_pd_busy_time()
  max_util = get_pd_max_util(..., -1, ...)
  base_energy = compute_energy(..., max_util, busy_time, ...)

  busy_time = min(busy_time + tsk_busy_time, pd_cap);
  if (compute_prev_delta)
      max_util = get_pd_max_util(..., prev_cpu, ...)
      prev_delta = compute_energy(..., max_util, busy_time, ...)
  ...

See `XXX: Split get_pd_max_util() from compute_energy()`

https://gitlab.arm.com/linux-arm/linux-de/-/commit/6d79929ee7c8675a127158187786dd1d6b6dd355

[...]

> @@ -6783,13 +6824,27 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
>  			continue;
>  
> +		/* Account thermal pressure for the energy estimation */
> +		cpu_thermal_cap = arch_scale_cpu_capacity(
> +					cpumask_first(perf_domain_span(pd)));
> +		cpu_thermal_cap -= arch_scale_thermal_pressure(
> +					cpumask_first(perf_domain_span(pd)));

Yes, we should calculate cpu_thermal_cap only once per PD. Can you make
this a little bit more easy to read by getting `cpu =
cpumask_first(perf_domain_span(pd));` first?

[...]
