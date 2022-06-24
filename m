Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DC5558F17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiFXDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFXDap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:30:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7F51E4B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656041444; x=1687577444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+4eN+cEF69t4ZGwy7ZsRs3xDCdXCa0ROUXCC/DmnpU=;
  b=j3xAKikM3oBxMTqZ8AtqJfCwWJT6+4JijNs7b3ye9i/qr5RvACu4QBMe
   qs8avBxrA7PQy8ycwgHz8ZFTgbdfKztVp0/uEIFv3mPGItt4q9nl6wTli
   aY41vqPZcvjqTqoDOUsvD+7IfYqBRUxKCIW8LkBipvdCLJMLH1sQr9bIb
   3cmGkTHcPuQx2kjMgqn/aYUlE8zWkJ6S7klM6ZEves8CSqSg25MWLl7Gx
   Y+e/5WnMyP4MChoOzRydbTbA5zKiJjJhwX+UhIhrC4rzwtrK0wzQ1cjej
   oxy76c5v9ZvRCm+EELCJRP0iQPCJ1T83eEn36sCN+siBFqfU4s5+sTADn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306377597"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306377597"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:30:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834946140"
Received: from fenghuah-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.168.81])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:30:41 -0700
Date:   Fri, 24 Jun 2022 11:30:32 +0800
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
Subject: Re: [External] Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS
 search
Message-ID: <20220624033032.GA14945@chenyu5-mobl1>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:52:19AM +0800, Abel Wu wrote:
> Hi Chen, thanks for your comments!
> 
> On 6/22/22 2:14 AM, Chen Yu Wrote:
> > > ...
> > Reuse the data from load balance to select the unoccupied candidate
> > is applicable IMO, which is also aligned with SIS_UTIL path. And I have
> > a question regarding the update frequency. In v3 patch, the update is
> > based on periodic tick, which is triggered at most every 1ms(CONFIG_HZ_1000).
> > Then the periodic SMT load balance is launched every smt_weight ms, usually 2ms.
> > I expect the 2ms is of the same scale unit as 1ms, and since task tick based
> > update is acceptable, would excluding the CPU_NEWLY_IDLE balance from this patch
> > reduce the overhead meanwhile not bring too much inaccuracy?
> 
> I doubt periodic balancing entry is enough. The ms-scale could still
> be too large for wakeup path. Say one cpu becomes newly idle just after
> an update, then it keeps untouchable until next update which is nearly
> 2ms (even worse in SMT4/8 case) wasting time-slices to do nothing. So
> newly-idle update is important to keep the filter fresh. And the false
> positive correction is there to avoid excessive updates due to newly
> idle, by allowing the false positive cpus to stay in the filter for a
> little longer.

> 
> > > @@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> > >   		 * No need to call idle_cpu() if nr_running is not 0
> > >   		 */
> > >   		if (!nr_running && idle_cpu(i)) {
> > > +			/*
> > > +			 * Prefer the last idle cpu by overwriting
> > > +			 * preious one. The first idle cpu in this
> > > +			 * domain (if any) can trigger balancing
> > > +			 * and fed with tasks, so we'd better choose
> > > +			 * a candidate in an opposite way.
> > > +			 */
> > > +			sds->idle_cpu = i;
> > Does it mean, only 1 idle CPU in the smt domain would be set to the
> > idle cpu mask at one time? For SMT4/8 we might lose track of the
> > idle siblings.
> 
> Yes. The intention of one-at-a-time propagation is
> 1) help spreading out load to different cores
> 2) reduce some update overhead
> In this way, if the filter contains several cpus of a core, ideally
> we can sure about that at least one of them is actually unoccupied.
> For SMT4/8 we still have newly idle balance to make things right.
> 
> > >   			sgs->idle_cpus++;
> > > +
> > >   			/* Idle cpu can't have misfit task */
> > >   			continue;
> > >   		}
> > > @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> > >   static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
> > >   {
> > > -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> > > -		set_idle_cpus(env->dst_cpu, true);
> > > +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
> > > +	enum sd_state new = sds->sd_state;
> > > +	int this = env->dst_cpu;
> > > +
> > > +	/*
> > > +	 * Parallel updating can hardly contribute accuracy to
> > > +	 * the filter, besides it can be one of the burdens on
> > > +	 * cache traffic.
> > > +	 */
> > > +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
> > > +		return;
> > > +
> > > +	/*
> > > +	 * There is at least one unoccupied cpu available, so
> > > +	 * propagate it to the filter to avoid false negative
> > > +	 * issue which could result in lost tracking of some
> > > +	 * idle cpus thus throughupt downgraded.
> > > +	 */
> > > +	if (new != sd_is_busy) {
> > > +		if (!test_idle_cpus(this))
> > > +			set_idle_cpus(this, true);
> > > +	} else {
> > > +		/*
> > > +		 * Nothing changes so nothing to update or
> > > +		 * propagate.
> > > +		 */
> > > +		if (sd_smt_shared->state == sd_is_busy)
> > > +			goto out;
> > > +	}
> > > +
> > > +	sd_update_icpus(this, sds->idle_cpu);
> > I wonder if we could further enhance it to facilitate idle CPU scan.
> > For example, can we propagate the idle CPUs in smt domain, to its parent
> > domain in a hierarchic sequence, and finally to the LLC domain. If there is
> 
> In fact, it was my first try to cache the unoccupied cpus in SMT
> shared domain, but the overhead of cpumask ops seems like a major
> stumbling block.
> 
> > a cluster domain between SMT and LLC domain, the cluster domain idle CPU filter
> > could benefit from this mechanism.
> > https://lore.kernel.org/lkml/20220609120622.47724-3-yangyicong@hisilicon.com/
> 
> Putting SIS into a hierarchical pattern is good for cache locality.
> But I don't think multi-level filter is appropriate since it could
> bring too much cache traffic in SIS, 
Could you please elaborate a little more about the cache traffic? I thought we
don't save the unoccupied cpus in SMT shared domain, but to store it in middle
layer shared domain, say, cluster->idle_cpus, this would reduce cache write
contention compared to writing to llc->idle_cpus directly, because a smaller
set of CPUs share the idle_cpus filter. Similarly, SIS can only scan the cluster->idle_cpus
first, without having to query the llc->idle_cpus. This looks like splitting
a big lock into fine grain small lock.
> and it could be expected to be
> a disaster for netperf/tbench or the workloads suffering frequent
> context switches.
>
So this overhead comes from the NEWLY_IDLE case?

thanks,
Chenyu
> > 
> > Furthermore, even if there is no cluster domain, would a 'virtual' middle
> > sched domain would help reduce the contention?
> > Core0(CPU0,CPU1),Core1(CPU2,CPU3) Core2(CPU4,CPU5) Core3(CPU6,CPU7)
> > We can create cpumask1, which is composed of Core0 and Core1, and cpumask2
> > which is composed of Core2 and Core3. The SIS would first scan in cpumask1,
> > if idle cpu is not found, scan cpumask2. In this way, the CPUs in Core0 and
> > Core1 only updates cpumask1, without competing with Core2 and Core3 on cpumask2.
> > 
> Yes, this is the best case, but the worst case is something that
> we probably can't afford.
> 
> Thanks & BR,
> Abel
