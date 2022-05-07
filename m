Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75D51E7DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446517AbiEGOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiEGOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:48:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B592FFFC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651934661; x=1683470661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wl8xKx7yEcUthjjKxHjQQm0SgUj3gDSDsQbcNQD4HY=;
  b=hkbWFyrBuj6I/rSS17F+EbJw+efMELVU51VMZfi6VqqVwzBCTkGI/9Yl
   PZOn68HyqghHGbq+LPdjtVDWnc8wCBofLazSoLFTLQrpw0Nehzss/jLnl
   KcsPPvcWJBODy5LRh63Q4gVSk93un58y3nENOcSt7sf4Sho6mMZ0t3+1f
   7o55bhYnqly6uoK6mG8ecqFEscU7q0Rv+WsvaHRply71VOw/9CbR7wq7v
   ceFIZiUTt82eALFewGZxT+lzEgvungOkLOHpdkAXV60SMehTQuLuWD/xR
   vfI2TXtx0SgCDkr9QObO7I9qDfQqCqEa91E0ULyQTTCRFrzUJ1oCKoPOr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="355149523"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="355149523"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 07:44:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="564311983"
Received: from hongl-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.245])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 07:44:14 -0700
Date:   Sat, 7 May 2022 22:44:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
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
Message-ID: <20220507144410.GA8992@chenyu5-mobl1>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <20220506083839.GI2501@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506083839.GI2501@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 10:38:39AM +0200, Peter Zijlstra wrote:
> 
> So in general I'm liking this.
>
Thanks Peter for the review. 
> But we appear to be in the position where there's two patches touching
> this code, the other by Abel Wu.
> 
> However, I'm thinking that this patch is the simpler and parts of Wu's
> patch can be done of top of this.
> 
> Specifically, Wu's patch reminds of me some of my earlier experiments
> that added an additional cpumask to the SIS path and there I found that
> the cache-miss from accessing an additional mask was hurting enough to
> negate a lot of the benefit it brought.
> 
I'll look at Abel Wu's proposal to see if we can co-work on that.
> On Fri, Apr 29, 2022 at 02:24:42AM +0800, Chen Yu wrote:
> 
> > It would be ideal to have a crystal ball to answer this question:
> > How many CPUs must a wakeup path walk down, before it can find an idle
> > CPU? Many potential metrics could be used to predict the number.
> > One candidate is the sum of util_avg in this LLC domain. The benefit
> > of choosing util_avg is that it is a metric of accumulated historic
> > activity, which seems to be smoother than instantaneous metrics
> > (such as rq->nr_running). Besides, choosing the sum of util_avg
> > would help predict the load of the LLC domain more precisely, because
> > SIS_PROP uses one CPU's idle time to estimate the total LLC domain idle
> > time. As Peter suggested[2], the lower the util_avg is, the
> > more select_idle_cpu() should scan for idle CPU, and vice versa.
> > 
> > Introduce the quadratic function:
> > 
> > y = a - bx^2
> > 
> > x is the sum_util ratio [0, 100] of this LLC domain, and y is the percentage
> > of CPUs to be scanned in the LLC domain. The number of CPUs to search drops
> > as sum_util increases. When sum_util hits 85% or above, the scan stops.
> > Choosing 85% is because it is the threshold of an overloaded LLC sched group
> > (imbalance_pct = 117). Choosing quadratic function is because:
> > 
> > [1] Compared to the linear function, it scans more aggressively when the
> >     sum_util is low.
> > [2] Compared to the exponential function, it is easier to calculate.
> > [3] It seems that there is no accurate mapping between the sum of util_avg
> >     and the number of CPUs to be scanned. Use heuristic scan for now.
> > 
> > The steps to calculate scan_nr are as followed:
> > [1] scan_percent = 100 - (x/8.5)^2
> >     when utilization reaches 85%, scan_percent becomes 0.
> > [2] scan_nr = nr_llc * scan_percent / 100
> > [3] scan_nr = max(scan_nr, 0)
> > 
> > For a platform with 112 CPUs per LLC, the number of CPUs to scan is:
> > sum_util%   0    5   15   25  35  45  55   65   75   85 ...
> > scan_ns   112  112  108  103  92  80  64   47   24    0 ...
> > 
> > Furthermore, to minimize the overhead of calculating the metrics in
> > select_idle_cpu(), borrow the statistics from periodic load balance.
> > As mentioned by Abel, on a platform with 112 CPUs per LLC, the
> > sum_util calculated by periodic load balance after 112ms would decay
> > to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%, thus bringing a delay in
> > reflecting the latest utilization. But it is a trade-off.
> > Checking the util_avg in newidle load balance would be more frequent,
> > but it brings overhead - multiple CPUs write/read the per-LLC shared
> > variable and introduces cache false sharing. And Tim also mentioned
> > that, it is allowed to be non-optimal in terms of scheduling for the
> > short term variations, but if there is a long term trend in the load
> > behavior, the scheduler can adjust for that.
> > 
> > SIS_UTIL is disabled by default. When it is enabled, the select_idle_cpu()
> > will use the nr_scan calculated by SIS_UTIL instead of the one from
> > SIS_PROP. Later SIS_UTIL and SIS_PROP could be made mutually exclusive.
> 
> This; I'm thinking that it should default-enable, otherwise what's the
> point. And ideally we're remove SIS_PROP after a few releases if this
> works out.
> 
Ok, will change it to enabled by default.
> A few more notes below.. mostly minor nits.
> 
> > ---
> >  include/linux/sched/topology.h |  1 +
> >  kernel/sched/fair.c            | 56 ++++++++++++++++++++++++++++++++++
> >  kernel/sched/features.h        |  1 +
> >  3 files changed, 58 insertions(+)
> > 
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index 56cffe42abbc..816df6cc444e 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -81,6 +81,7 @@ struct sched_domain_shared {
> >  	atomic_t	ref;
> >  	atomic_t	nr_busy_cpus;
> >  	int		has_idle_cores;
> > +	int		nr_idle_scan;
> >  };
> >  
> >  struct sched_domain {
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 23c7d0f617ee..50c9d5b2b338 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6327,6 +6327,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  {
> >  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > +	struct sched_domain_shared *sd_share;
> >  	struct rq *this_rq = this_rq();
> >  	int this = smp_processor_id();
> >  	struct sched_domain *this_sd;
> > @@ -6366,6 +6367,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  		time = cpu_clock(this);
> >  	}
> >  
> > +	if (sched_feat(SIS_UTIL)) {
> > +		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> > +		if (sd_share) {
> > +			/* because !--nr is the condition to stop scan */
> > +			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> > +			/* overloaded LLC is unlikely to have idle cpu/core */
> > +			if (nr == 1)
> > +				return -1;
> > +		}
> > +	}
> > +
> >  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >  		if (has_idle_core) {
> >  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > @@ -9267,6 +9279,46 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >  	return idlest;
> >  }
> >  
> > +static inline void update_idle_cpu_scan(struct lb_env *env,
> > +					unsigned long sum_util)
> > +{
> > +	struct sched_domain_shared *sd_share;
> > +	int nr_scan, nr_llc, llc_util_pct;
> > +
> > +	if (!sched_feat(SIS_UTIL))
> > +		return;
> > +	/*
> > +	 * Update the number of CPUs to scan in LLC domain, which could
> > +	 * be used as a hint in select_idle_cpu(). The update of this hint
> > +	 * occurs during periodic load balancing, rather than frequent
> > +	 * newidle balance.
> > +	 */
> > +	nr_llc = per_cpu(sd_llc_size, env->dst_cpu);
> > +	if (env->idle == CPU_NEWLY_IDLE ||
> > +	    env->sd->span_weight != nr_llc)
> > +		return;
> > +
> > +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> > +	if (!sd_share)
> > +		return;
> > +
> > +	/*
> > +	 * The number of CPUs to search drops as sum_util increases, when
> > +	 * sum_util hits 85% or above, the scan stops.
> > +	 * The reason to choose 85% as the threshold is because this is the
> > +	 * imbalance_pct when a LLC sched group is overloaded.
> > +	 * let y = 100 - (x/8.5)^2 = 100 - x^2/72
> > +	 * y is the percentage of CPUs to be scanned in the LLC
> > +	 * domain, x is the ratio of sum_util compared to the
> > +	 * CPU capacity, which ranges in [0, 100], thus
> > +	 * nr_scan = nr_llc * y / 100
> > +	 */
> > +	llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
> > +	nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
> > +	nr_scan = max(nr_scan, 0);
> 
> The comment and code don't nicely match up, which makes it much harder
> to read than is needed. Given the comment, I would expect the code to
> look a little like:
> 
> 	x = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
> 	y = 100 - (x*x)/72;
> 	nr_scan = max(0, (nr_llc * y) / 100);
> 
> Now a pet peeve of mine, computers *SUCK* at '100', that's just not a
> good number for them, and AFAICT there's no reason what*so*ever to use
> 100 here, we're free to pick any random number. So lets be silly and
> pick SCHED_CAPACITY_SCALE :-)
> 
> 	x = sum_util / nr_llc;
> 	y = SCHED_CAPACITY_SCALE - (x*x)/737;
> 	nr_scan = max(0, (nr_llc * y) / SCHED_CAPACITY_SCALE);
> 
> How's that?
> 
Ok, will change it to this. I calculated the parameter from scratch
using 72.25 instead of 72, the parameter becomes 740. I'll do some test
based on this formula.
> (In general, forget about percentages; that's just a daft human
> convention because humans like 100 due to having 10 digits or something,
> fractions work on any base.)
> 
Thanks for the guidance.
> > +	WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> > +}
> > +
> >  /**
> >   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
> >   * @env: The load balancing environment.
> > @@ -9279,6 +9331,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	struct sched_group *sg = env->sd->groups;
> >  	struct sg_lb_stats *local = &sds->local_stat;
> >  	struct sg_lb_stats tmp_sgs;
> > +	unsigned long sum_util = 0;
> >  	int sg_status = 0;
> >  
> >  	do {
> > @@ -9311,6 +9364,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		sds->total_load += sgs->group_load;
> >  		sds->total_capacity += sgs->group_capacity;
> >  
> > +		sum_util += sgs->group_util;
> >  		sg = sg->next;
> >  	} while (sg != env->sd->groups);
> >  
> > @@ -9336,6 +9390,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> >  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> >  	}
> > +
> > +	update_idle_cpu_scan(env, sum_util);
> >  }
> >  
> >  #define NUMA_IMBALANCE_MIN 2
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index 1cf435bbcd9c..69be099019f4 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> >   */
> >  SCHED_FEAT(SIS_PROP, true)
> > +SCHED_FEAT(SIS_UTIL, false)
> 
> As said above, flip those. Otherwise there's no point in merging this,
> nobody will use it.
Ok, will do in next version.


Thanks,
Chenyu
