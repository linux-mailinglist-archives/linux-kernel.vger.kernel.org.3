Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAD55396D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbiFUSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiFUSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:15:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10625E9B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655835300; x=1687371300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L95+c4KoMIm+BfVsqgZIpShLYwQYkpfeCjJhb3/0P68=;
  b=BAaXSyumGMa5e1aD8rFqMmDo+ndnjc7x7m7NG1Xmgb0XryDaqf5+f2TT
   sksx43lDCkwKJf8OjP9tP9RIF8BP7KhRfnp70a+/G8Bn7nZjxTcm2NbCM
   UrWGG0f8MUDsJouBsawHZJ+wQATnioQbz/1nOQUeXDezhaloe+eDWMUVh
   p9n41Hkp2OuViWKEImJFxy/a7RyFfjjzwU5b65Q4rRL26yOjKxkY9Glhy
   N9o8ZKb8Zkvschbj2LJPcanoqbdzIFLl6muQ9lv7KkWuXb6IoetY76BUR
   AKBIkY+cg8Q9mg4b9GHNj4he8s2An/KZ+bCrZI2GChdRepcU3BH5DXIRv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366523509"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="366523509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:14:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="643755946"
Received: from hlin7-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.70])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:14:46 -0700
Date:   Wed, 22 Jun 2022 02:14:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Message-ID: <20220621181442.GA37168@chenyu5-mobl1>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619120451.95251-7-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
On Sun, Jun 19, 2022 at 08:04:50PM +0800, Abel Wu wrote:
> Try to improve efficiency of SIS domain search by filtering out busy
> cores, and as a result the more overloaded the system is, the less
> cpus will be scanned.
> 
> The filter is supposed to contain unoccupied cpus of the LLC. And we
> propagate these cpus to the filter one at a time at core granule.
> This can help spreading load to different cores given that the search
> depth is limited. The chosen cpu to be propagated is guaranteed to be
> unoccupied at that time.
> 
> When idle cpu exists, the last one is preferred in order not to
> conflict with periodic load balancing during which the first idle
> cpu (if any) is chosen to be fed with tasks.
>
Maybe the content in cover letter could be copied into this git log for
future reference?
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 20 ++++++++
>  kernel/sched/fair.c            | 90 +++++++++++++++++++++++++++++++---
>  kernel/sched/topology.c        | 12 ++++-
>  3 files changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 3e99ac98d766..b93edf587d84 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -103,6 +103,10 @@ struct sched_group;
>   * load balancing on each SMT domain inside the LLC, the state will be
>   * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
>   * exist.
> + *
> + * For SMT domains, the state is updated during load balancing at SMT
> + * level. Upper levels are ignored due to the long intervals that make
> + * information out-of-date quickly.
Reuse the data from load balance to select the unoccupied candidate
is applicable IMO, which is also aligned with SIS_UTIL path. And I have
a question regarding the update frequency. In v3 patch, the update is
based on periodic tick, which is triggered at most every 1ms(CONFIG_HZ_1000).
Then the periodic SMT load balance is launched every smt_weight ms, usually 2ms.
I expect the 2ms is of the same scale unit as 1ms, and since task tick based
update is acceptable, would excluding the CPU_NEWLY_IDLE balance from this patch
reduce the overhead meanwhile not bring too much inaccuracy? 
>   */
>  enum sd_state {
>  	sd_has_icores,
> @@ -113,7 +117,18 @@ enum sd_state {
>  struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
> +
> +	int		updating;
>  	int		state;	/* see enum sd_state */
> +
> +	/*
> +	 * Record unoccupied cpus for SIS domain search.
> +	 *
> +	 * NOTE: this field is variable length. (Allocated dynamically
> +	 * by attaching extra space to the end of the structure,
> +	 * depending on how many CPUs the kernel has booted up with)
> +	 */
> +	unsigned long   idle_cpus[];
>  };
>  
>  struct sched_domain {
> @@ -199,6 +214,11 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
>  	return to_cpumask(sd->span);
>  }
>  
> +static inline struct cpumask *sched_domain_icpus(struct sched_domain_shared *sds)
> +{
> +	return to_cpumask(sds->idle_cpus);
> +}
> +
>  extern void partition_sched_domains_locked(int ndoms_new,
>  					   cpumask_var_t doms_new[],
>  					   struct sched_domain_attr *dattr_new);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2ca37fdc6c4d..d55fdcedf2c0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6241,6 +6241,28 @@ static inline bool test_idle_cpus(int cpu)
>  	return sd_get_state(cpu) != sd_is_busy;
>  }
>  
> +static void sd_update_icpus(int core, int icpu)
> +{
> +	struct sched_domain_shared *sds;
> +	struct cpumask *icpus;
> +
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, core));
> +	if (!sds)
> +		return;
> +
> +	icpus = sched_domain_icpus(sds);
> +
> +	/*
> +	 * XXX: The update is racy between different cores.
> +	 * The non-atomic ops here is a tradeoff of accuracy
> +	 * for easing the cache traffic.
> +	 */
> +	if (icpu == -1)
> +		cpumask_andnot(icpus, icpus, cpu_smt_mask(core));
> +	else if (!cpumask_test_cpu(icpu, icpus))
> +		__cpumask_set_cpu(icpu, icpus);
> +}
> +
>  /*
>   * Scans the local SMT mask to see if the entire core is idle, and records this
>   * information in sd_llc_shared->has_idle_cores.
> @@ -6340,6 +6362,10 @@ static inline bool test_idle_cpus(int cpu)
>  	return true;
>  }
>  
> +static inline void sd_update_icpus(int core, int icpu)
> +{
> +}
> +
>  static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
>  	return __select_idle_cpu(core, p);
> @@ -6370,7 +6396,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (!this_sd)
>  		return -1;
>  
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +	cpumask_and(cpus, has_idle_core ? sched_domain_span(sd) :
> +		    sched_domain_icpus(sd->shared), p->cpus_ptr);
>  
>  	if (sched_feat(SIS_PROP) && !has_idle_core) {
>  		u64 avg_cost, avg_idle, span_avg;
> @@ -8342,6 +8369,7 @@ struct sd_lb_stats {
>  	unsigned int prefer_sibling; /* tasks should go to sibling first */
>  
>  	int sd_state;
> +	int idle_cpu;
>  
>  	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
>  	struct sg_lb_stats local_stat;	/* Statistics of the local group */
> @@ -8362,6 +8390,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  		.total_load = 0UL,
>  		.total_capacity = 0UL,
>  		.sd_state = sd_is_busy,
> +		.idle_cpu = -1,
>  		.busiest_stat = {
>  			.idle_cpus = UINT_MAX,
>  			.group_type = group_has_spare,
> @@ -8702,10 +8731,18 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
> -static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq, int cpu)
>  {
> -	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
> +	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq)) {
> +		/*
> +		 * Prefer idle cpus than unoccupied ones. This
> +		 * is achieved by only allowing the idle ones
> +		 * unconditionally overwrite the preious record
> +		 * while the occupied ones can't.
> +		 */
> +		sds->idle_cpu = cpu;
>  		sds->sd_state = sd_has_icpus;
> +	}
>  }
>  
>  /**
> @@ -8741,7 +8778,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		sgs->sum_nr_running += nr_running;
>  
>  		if (update_core)
> -			sd_classify(sds, rq);
> +			sd_classify(sds, rq, i);
>  
>  		if (nr_running > 1)
>  			*sg_status |= SG_OVERLOAD;
> @@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		 * No need to call idle_cpu() if nr_running is not 0
>  		 */
>  		if (!nr_running && idle_cpu(i)) {
> +			/*
> +			 * Prefer the last idle cpu by overwriting
> +			 * preious one. The first idle cpu in this
> +			 * domain (if any) can trigger balancing
> +			 * and fed with tasks, so we'd better choose
> +			 * a candidate in an opposite way.
> +			 */
> +			sds->idle_cpu = i;
Does it mean, only 1 idle CPU in the smt domain would be set to the
idle cpu mask at one time? For SMT4/8 we might lose track of the
idle siblings.
>  			sgs->idle_cpus++;
> +
>  			/* Idle cpu can't have misfit task */
>  			continue;
>  		}
> @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> -		set_idle_cpus(env->dst_cpu, true);
> +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
> +	enum sd_state new = sds->sd_state;
> +	int this = env->dst_cpu;
> +
> +	/*
> +	 * Parallel updating can hardly contribute accuracy to
> +	 * the filter, besides it can be one of the burdens on
> +	 * cache traffic.
> +	 */
> +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
> +		return;
> +
> +	/*
> +	 * There is at least one unoccupied cpu available, so
> +	 * propagate it to the filter to avoid false negative
> +	 * issue which could result in lost tracking of some
> +	 * idle cpus thus throughupt downgraded.
> +	 */
> +	if (new != sd_is_busy) {
> +		if (!test_idle_cpus(this))
> +			set_idle_cpus(this, true);
> +	} else {
> +		/*
> +		 * Nothing changes so nothing to update or
> +		 * propagate.
> +		 */
> +		if (sd_smt_shared->state == sd_is_busy)
> +			goto out;
> +	}
> +
> +	sd_update_icpus(this, sds->idle_cpu);
I wonder if we could further enhance it to facilitate idle CPU scan.
For example, can we propagate the idle CPUs in smt domain, to its parent
domain in a hierarchic sequence, and finally to the LLC domain. If there is
a cluster domain between SMT and LLC domain, the cluster domain idle CPU filter
could benefit from this mechanism.
https://lore.kernel.org/lkml/20220609120622.47724-3-yangyicong@hisilicon.com/

Furthermore, even if there is no cluster domain, would a 'virtual' middle
sched domain would help reduce the contention?
Core0(CPU0,CPU1),Core1(CPU2,CPU3) Core2(CPU4,CPU5) Core3(CPU6,CPU7)
We can create cpumask1, which is composed of Core0 and Core1, and cpumask2
which is composed of Core2 and Core3. The SIS would first scan in cpumask1,
if idle cpu is not found, scan cpumask2. In this way, the CPUs in Core0 and
Core1 only updates cpumask1, without competing with Core2 and Core3 on cpumask2.


thanks,
Chenyu
> +	sd_smt_shared->state = new;
> +out:
> +	xchg(&sd_smt_shared->updating, 0);
>  }
>  
>  /**
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8739c2a5a54e..d3cd7cf5a136 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1641,6 +1641,16 @@ sd_init(struct sched_domain_topology_level *tl,
>  		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>  		atomic_inc(&sd->shared->ref);
>  		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +
> +		/*
> +		 * Initialize SMT domains to be busy, so that we don't
> +		 * need to propagate idle cpus to LLC domains which are
> +		 * default to fully busy (no cpus set). This will be
> +		 * updated in the first load balancing on SMT domains
> +		 * if necessary.
> +		 */
> +		if (sd->flags & SD_SHARE_CPUCAPACITY)
> +			WRITE_ONCE(sd->shared->state, sd_is_busy);
>  	}
>  
>  	sd->private = sdd;
> @@ -2106,7 +2116,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>  
>  			*per_cpu_ptr(sdd->sd, j) = sd;
>  
> -			sds = kzalloc_node(sizeof(struct sched_domain_shared),
> +			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>  					GFP_KERNEL, cpu_to_node(j));
>  			if (!sds)
>  				return -ENOMEM;
> -- 
> 2.31.1
> 
