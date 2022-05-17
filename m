Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D146952A1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbiEQMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbiEQMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:51:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B4658B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:50:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CECA21CDB;
        Tue, 17 May 2022 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652791857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2aI46vMnNz3uUrd9qpzyboR/zbC1WD1SbCf4hZBU9I=;
        b=QsUgQUVD4rgf3UNUpNkszMg0sEMKg2v20uippMxcXu7VnOLrZRz6GXc24omwWWwVS8fyD3
        o4MfGUqlF2/7GIetev15lAgIzdx9yX6xLjMsCVBlFjuBk68wcIlVC5qnKp892KAFdFRk6a
        2phL2pUY+gnWVfivzKVE9+miI2KXrg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652791857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2aI46vMnNz3uUrd9qpzyboR/zbC1WD1SbCf4hZBU9I=;
        b=ssZ2HiwUAzLH8AfRJHX6kkEKZz8WXLFDuzikqgOxoTDfoMfdvOqaJzUGSKvUyhFT2w+3CJ
        vafTZx1l184yuvDQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4B182C141;
        Tue, 17 May 2022 12:50:54 +0000 (UTC)
Date:   Tue, 17 May 2022 13:50:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <20220517125047.GR20579@suse.de>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220428182442.659294-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:24:42AM +0800, Chen Yu wrote:
> Introduce the quadratic function:
> 
> y = a - bx^2
> 
> x is the sum_util ratio [0, 100] of this LLC domain, and y is the percentage
> of CPUs to be scanned in the LLC domain. The number of CPUs to search drops
> as sum_util increases. When sum_util hits 85% or above, the scan stops.
> Choosing 85% is because it is the threshold of an overloaded LLC sched group
> (imbalance_pct = 117). Choosing quadratic function is because:
> 
> [1] Compared to the linear function, it scans more aggressively when the
>     sum_util is low.
> [2] Compared to the exponential function, it is easier to calculate.
> [3] It seems that there is no accurate mapping between the sum of util_avg
>     and the number of CPUs to be scanned. Use heuristic scan for now.
> 
> The steps to calculate scan_nr are as followed:
> [1] scan_percent = 100 - (x/8.5)^2
>     when utilization reaches 85%, scan_percent becomes 0.
> [2] scan_nr = nr_llc * scan_percent / 100
> [3] scan_nr = max(scan_nr, 0)
> 
> For a platform with 112 CPUs per LLC, the number of CPUs to scan is:
> sum_util%   0    5   15   25  35  45  55   65   75   85 ...
> scan_ns   112  112  108  103  92  80  64   47   24    0 ...
> 
> Furthermore, to minimize the overhead of calculating the metrics in
> select_idle_cpu(), borrow the statistics from periodic load balance.
> As mentioned by Abel, on a platform with 112 CPUs per LLC, the
> sum_util calculated by periodic load balance after 112ms would decay
> to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%, thus bringing a delay in
> reflecting the latest utilization. But it is a trade-off.
> Checking the util_avg in newidle load balance would be more frequent,
> but it brings overhead - multiple CPUs write/read the per-LLC shared
> variable and introduces cache false sharing. And Tim also mentioned
> that, it is allowed to be non-optimal in terms of scheduling for the
> short term variations, but if there is a long term trend in the load
> behavior, the scheduler can adjust for that.
> 

Seems fair other than the 85% is hardcoded based on an imbalance_pct of
117. If that value should ever change, it'll drift apart.

> SIS_UTIL is disabled by default. When it is enabled, the select_idle_cpu()
> will use the nr_scan calculated by SIS_UTIL instead of the one from
> SIS_PROP. Later SIS_UTIL and SIS_PROP could be made mutually exclusive.
> 

I agree with Peter, this should be enabled by default. I am somewhat
embarassed that I initially queued this patch blindly for testing when it
was mailed thinking "I would like to have some results before reviewing"
and then when I sit down to do the review, the results are all useless
because the feature was disabled. My initial thinking starting the review
was "Weird, none of these results are conclusive in any way."

I don't think you need to explicitly check for both being enabled given
that it's a sched_feat. Someone poking in there is meant to be debugging
something but the vast majority of people will never go looking.

> Limitations:
> [1]
> This patch is based on the util_avg, which is very sensitive to the CPU
> frequency invariance. The util_avg would decay quite fast when the
> CPU is idle, if the max frequency has been limited by the user.
> Patch [3] should be applied if turbo is disabled manually on Intel
> platforms.
> 

It is worth mentioning in the changelog if there is a patch that this
implicitly depends upon. It affects the ordering patches should be merged
or bisections for a regression may unfairly identify your patch as the
source of the problem.

At least then if they merge in the wrong order there will something
obvious to check.

> [2]
> There may be unbalanced tasks among CPUs due to CPU affinity. For example,
> suppose the LLC domain is composed of 8 CPUs, and 7 tasks are bound to
> CPU0~CPU6, while CPU7 is idle:
> 
>           CPU0    CPU1    CPU2    CPU3    CPU4    CPU5    CPU6    CPU7
> util_avg  1024    1024    1024    1024    1024    1024    1024    0
> 
> Since the util_avg ratio is 87.5%( = 7/8 ), which is higher than 85%,
> select_idle_cpu() will not scan, thus CPU7 is undetected.
> 
> A possible workaround to mitigate this problem is that the nr_scan should
> be increased if idle CPUs are detected during periodic load balance. And the
> problem could be mitigated by idle load balance that, CPU7 might pull some
> tasks on it.
> 

While a valid concern, it's no worse than what is there now and I think
this case is unlikely. It could naturally happen if there was 6 busy tasks
running entirely in userspace which is harmless. Normal load balancing
would use CPU7 if there was any stacking on CPU0 to CPU6 or NEWLY_IDLE
ILB on CPU7 would pull something if there was any other activity on CPU7.

> [3]
> Prateek mentioned that we should scan aggressively in an LLC domain
> with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
> negligible. The current patch aims to propose a generic solution and only
> considers the util_avg. A follow-up change could enhance the scan policy
> to adjust the scan_percent according to the CPU number in LLC.
> 

Yes, anything along those lines is a separate patch.

> v2->v3:
>  - Use 85% as the threshold again, because the CPU frequency invariance issue
>    has been fixed and the patch is queued for 5.19.
> 

Note in changelog exactly what this fix is in case the patches go in the
wrong order.

>  - Stop the scan if 85% is reached, rather than scanning for at least 4 CPUs.
>    According to the feedback from Yicong, it might be better to stop scanning
>    entirely when the LLC is overloaded.
> 

I think only workloads like hackbench benefit from "search 4 CPUs"
heuristic because the machine is heavily overloaded with tasks that are
rapidly idling. Be wary of a patch that sets it back to 4 with hackbench
being the only justification.

> Link: https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net #1
> Link: https://lore.kernel.org/lkml/20220207135253.GF23216@worktop.programming.kicks-ass.net #2
> Link: https://lore.kernel.org/lkml/20220407234258.569681-1-yu.c.chen@intel.com #3
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 56 ++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h        |  1 +
>  3 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..816df6cc444e 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -81,6 +81,7 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +	int		nr_idle_scan;
>  };
>  
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 23c7d0f617ee..50c9d5b2b338 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6327,6 +6327,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	struct sched_domain_shared *sd_share;
>  	struct rq *this_rq = this_rq();
>  	int this = smp_processor_id();
>  	struct sched_domain *this_sd;
> @@ -6366,6 +6367,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> +	if (sched_feat(SIS_UTIL)) {
> +		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> +		if (sd_share) {
> +			/* because !--nr is the condition to stop scan */
> +			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> +			/* overloaded LLC is unlikely to have idle cpu/core */
> +			if (nr == 1)
> +				return -1;
> +		}
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -9267,6 +9279,46 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  	return idlest;
>  }
>  
> +static inline void update_idle_cpu_scan(struct lb_env *env,
> +					unsigned long sum_util)
> +{

Don't inline. This is a long function with one callsite, the compiler
should be able to figure it out.

> +	struct sched_domain_shared *sd_share;
> +	int nr_scan, nr_llc, llc_util_pct;
> +
> +	if (!sched_feat(SIS_UTIL))
> +		return;

Move the CPU_NEWLY_IDLE check here because it's essentially a free check
and avoids the per_cpu lookup.

Also comment on why CPU_NEWLY_IDLE is ignored. I assume it's because you
are updating sd_shared which is a shared cache line write and
CPU_NEWLY_IDLE can fire way more frequently than periodic load
balancing.

> +	/*
> +	 * Update the number of CPUs to scan in LLC domain, which could
> +	 * be used as a hint in select_idle_cpu(). The update of this hint
> +	 * occurs during periodic load balancing, rather than frequent
> +	 * newidle balance.
> +	 */
> +	nr_llc = per_cpu(sd_llc_size, env->dst_cpu);
> +	if (env->idle == CPU_NEWLY_IDLE ||
> +	    env->sd->span_weight != nr_llc)
> +		return;
> +

This caught me because nr_llc made me think it was "the number
of last level caches in a NUMA node" because that's what it means
in kernel/sched/topology.c. This is the number of CPUs sharing an
LLC to llc_weight would be appropriate given that it's compared to
span_weight. It's not mandatory for me but it's preferable.

> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> +	if (!sd_share)
> +		return;
> +
> +	/*
> +	 * The number of CPUs to search drops as sum_util increases, when
> +	 * sum_util hits 85% or above, the scan stops.
> +	 * The reason to choose 85% as the threshold is because this is the
> +	 * imbalance_pct when a LLC sched group is overloaded.
> +	 * let y = 100 - (x/8.5)^2 = 100 - x^2/72
> +	 * y is the percentage of CPUs to be scanned in the LLC
> +	 * domain, x is the ratio of sum_util compared to the
> +	 * CPU capacity, which ranges in [0, 100], thus
> +	 * nr_scan = nr_llc * y / 100
> +	 */
> +	llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
> +	nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
> +	nr_scan = max(nr_scan, 0);

Peter commented on this already.

> +	WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> +}

To avoid excessive unnecessary cache line bounces;

	if (nr_scan != sd_share->nr_idle_scan)
		WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);

I expect the two very common values represent "machine is mostly idle
scan everything" and "machine is heavily overloaded, scan nothing" and
I'm betting the cost of the branch is less than the cost of rewriting
the same values.

-- 
Mel Gorman
SUSE Labs
