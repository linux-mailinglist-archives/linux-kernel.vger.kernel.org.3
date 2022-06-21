Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE1553979
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiFUSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFUSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:23:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88246140DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655835831; x=1687371831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LYVTVlSJIBG1S5Y04zXIHfn4ltGmqCW1Ha+CJAnkACU=;
  b=j5BsFrxZ2nO8qs+AoTw44GZ1EV6XyJbYFqHPgnJ/3K3PeqICUyiNUlMh
   jlSWXp+l9ks9P6YxJclA2RlgrbEgMrgCvCNMOJEIMUnhPV2BGaSQRyIUW
   REl2QF3f0efqX8x10zHiKYoQmLq2q/XCtwpqqVTfr9Xf0bpd06wyspxLN
   xHGIsX9iFzWAhuSWryrYtDUleM4bDMT2PKqtTiQmETc6l53ptMrYTgWi3
   ie/opI57hIJsPXN6vE5fkBjZ1TvRhiK8ZrWzdIbryPr3bzzTDv+txNINv
   uUQSqcatTTXpmXQ43rVqIIs3qx0qF80ZVf/whJAcQl/mHyOKJmCfDwP1W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344194481"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344194481"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:23:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="620589165"
Received: from hlin7-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:23:46 -0700
Date:   Wed, 22 Jun 2022 02:23:42 +0800
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
Subject: Re: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Message-ID: <20220621182342.GA50611@chenyu5-mobl1>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-8-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619120451.95251-8-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 08:04:51PM +0800, Abel Wu wrote:
> Now when updating core state, there are two main problems that could
> pollute the SIS filter:
> 
>   - The updating is before task migration, so if dst_cpu is
>     selected to be propagated which might be fed with tasks
>     soon, the efforts we paid is no more than setting a busy
>     cpu into the SIS filter. While on the other hand it is
>     important that we update as early as possible to keep the
>     filter fresh, so it's not wise to delay the update to the
>     end of load balancing.
> 
>   - False negative propagation hurts performance since some
>     idle cpus could be out of reach. So in general we will
>     aggressively propagate idle cpus but allow false positive
>     continue to exist for a while, which may lead to filter
>     being fully polluted.
> 
> Pains can be relieved by a force correction when false positive
> continuously detected.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h |  7 +++++
>  kernel/sched/fair.c            | 51 ++++++++++++++++++++++++++++++++--
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index b93edf587d84..e3552ce192a9 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -91,6 +91,12 @@ struct sched_group;
>   *	search, and is also used as a fallback state of the other
>   *	states.
>   *
> + * - sd_may_idle
> + *	This state implies the unstableness of the SIS filter, and
> + *	some bits of it may out of date. This state is only used in
> + *	SMT domains as an intermediate state between sd_has_icpus
> + *	and sd_is_busy.
> + *
>   * - sd_is_busy
>   *	This state indicates there are no unoccupied cpus in this
>   *	domain. So for LLC domains, it gives the hint on whether
> @@ -111,6 +117,7 @@ struct sched_group;
>  enum sd_state {
>  	sd_has_icores,
>  	sd_has_icpus,
> +	sd_may_idle,
>  	sd_is_busy
>  };
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d55fdcedf2c0..9713d183d35e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8768,6 +8768,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
> +		bool update = update_core && (env->dst_cpu != i);
>  
>  		sgs->group_load += cpu_load(rq);
>  		sgs->group_util += cpu_util_cfs(i);
> @@ -8777,7 +8778,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		nr_running = rq->nr_running;
>  		sgs->sum_nr_running += nr_running;
>  
> -		if (update_core)
> +		/*
> +		 * The dst_cpu is not preferred since it might
> +		 * be fed with tasks soon.
> +		 */
> +		if (update)
maybe if (update_core && (env->dst_cpu != i)) so that the comment would
be near the code logic and meanwhile without introducing a update variable?
>  			sd_classify(sds, rq, i);
>  
>  		if (nr_running > 1)
> @@ -8801,7 +8806,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  			 * and fed with tasks, so we'd better choose
>  			 * a candidate in an opposite way.
>  			 */
> -			sds->idle_cpu = i;
> +			if (update)
> +				sds->idle_cpu = i;
>  			sgs->idle_cpus++;
>  
>  			/* Idle cpu can't have misfit task */
> @@ -9321,7 +9327,7 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  {
>  	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>  	enum sd_state new = sds->sd_state;
> -	int this = env->dst_cpu;
> +	int icpu = sds->idle_cpu, this = env->dst_cpu;
>  
>  	/*
>  	 * Parallel updating can hardly contribute accuracy to
> @@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>  		return;
>  
> +	/*
> +	 * The dst_cpu is likely to be fed with tasks soon.
> +	 * If it is the only unoccupied cpu in this domain,
> +	 * we still handle it the same way as as_has_icpus
> +	 * but turn the SMT into the unstable state, rather
> +	 * than waiting to the end of load balancing since
> +	 * it's also important that update the filter as
> +	 * early as possible to keep it fresh.
> +	 */
> +	if (new == sd_is_busy) {
> +		if (idle_cpu(this) || sched_idle_cpu(this)) {
available_idle_cpu()?

thanks,
Chenyu
> +			new = sd_may_idle;
> +			icpu = this;
> +		}
> +	}
> +
>  	/*
>  	 * There is at least one unoccupied cpu available, so
>  	 * propagate it to the filter to avoid false negative
> @@ -9338,6 +9360,12 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  	 * idle cpus thus throughupt downgraded.
>  	 */
>  	if (new != sd_is_busy) {
> +		/*
> +		 * The sd_may_idle state is taken into
> +		 * consideration as well because from
> +		 * here we couldn't actually know task
> +		 * migrations would happen or not.
> +		 */
>  		if (!test_idle_cpus(this))
>  			set_idle_cpus(this, true);
>  	} else {
> @@ -9347,9 +9375,26 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  		 */
>  		if (sd_smt_shared->state == sd_is_busy)
>  			goto out;
> +
> +		/*
> +		 * Allow false positive to exist for some time
> +		 * to make a tradeoff of accuracy of the filter
> +		 * for relieving cache traffic.
> +		 */
> +		if (sd_smt_shared->state == sd_has_icpus) {
> +			new = sd_may_idle;
> +			goto update;
> +		}
> +
> +		/*
> +		 * If the false positive issue has already been
> +		 * there for a while, a correction of the filter
> +		 * is needed.
> +		 */
>  	}
>  
>  	sd_update_icpus(this, sds->idle_cpu);
> +update:
>  	sd_smt_shared->state = new;
>  out:
>  	xchg(&sd_smt_shared->updating, 0);
> -- 
> 2.31.1
> 
