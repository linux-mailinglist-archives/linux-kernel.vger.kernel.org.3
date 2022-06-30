Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B1560FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiF3EQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiF3EQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:16:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DE33A37
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656562613; x=1688098613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U6CKboGE1dohT6a6IeHJmKeEoNuXm0Q4zYMmUvaMWio=;
  b=C9blt2iioVMKU/ItZP8edy0cZSWsjCjkzmgy4kWWA6qlwmBjBkLqqwwY
   zUpOUgSId1uDwLHqbIHIeS6Cz1axdluMw2vsDF6JnwxnaemkAiK4OkShi
   qkDXheBMfQUl19TEX8R1yVxVzmL/2ejFbBE103JZtfjVG0232oKwh5f16
   gwQmP8ICtM14Mq74FWmGxhb2Rk1BC7qmyfEjXZaE3w0xj3t6b0sADKCZW
   L1zWFAUATIKj5nJJ1oNUZ0l4IGgB62sJXEMzrCmaNscuExkaawmXXfI3k
   Pg1WmasHE/HTzzwjxH6wR/k3RG6aB+CHafeplOErzlAObXkRyPtnnjRjI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="280999783"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="280999783"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 21:16:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647704553"
Received: from zhijunze-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.168.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 21:16:49 -0700
Date:   Thu, 30 Jun 2022 12:16:45 +0800
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
Message-ID: <20220630041645.GA9253@chenyu5-mobl1>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
 <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
 <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:58:55PM +0800, Abel Wu wrote:
> 
> On 6/27/22 6:13 PM, Abel Wu Wrote:
> > 
> > On 6/24/22 11:30 AM, Chen Yu Wrote:
> > > > ...
> > > > > > @@ -9273,8 +9319,40 @@ find_idlest_group(struct
> > > > > > sched_domain *sd, struct task_struct *p, int this_cpu)
> > > > > >    static void sd_update_state(struct lb_env *env,
> > > > > > struct sd_lb_stats *sds)
> > > > > >    {
> > > > > > -    if (sds->sd_state == sd_has_icpus &&
> > > > > > !test_idle_cpus(env->dst_cpu))
> > > > > > -        set_idle_cpus(env->dst_cpu, true);
> > > > > > +    struct sched_domain_shared *sd_smt_shared = env->sd->shared;
> > > > > > +    enum sd_state new = sds->sd_state;
> > > > > > +    int this = env->dst_cpu;
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Parallel updating can hardly contribute accuracy to
> > > > > > +     * the filter, besides it can be one of the burdens on
> > > > > > +     * cache traffic.
> > > > > > +     */
> > > > > > +    if (cmpxchg(&sd_smt_shared->updating, 0, 1))
> > > > > > +        return;
> > > > > > +
> > > > > > +    /*
> > > > > > +     * There is at least one unoccupied cpu available, so
> > > > > > +     * propagate it to the filter to avoid false negative
> > > > > > +     * issue which could result in lost tracking of some
> > > > > > +     * idle cpus thus throughupt downgraded.
> > > > > > +     */
> > > > > > +    if (new != sd_is_busy) {
> > > > > > +        if (!test_idle_cpus(this))
> > > > > > +            set_idle_cpus(this, true);
> > > > > > +    } else {
> > > > > > +        /*
> > > > > > +         * Nothing changes so nothing to update or
> > > > > > +         * propagate.
> > > > > > +         */
> > > > > > +        if (sd_smt_shared->state == sd_is_busy)
> > > > > > +            goto out;
> > > > > > +    }
> > > > > > +
> > > > > > +    sd_update_icpus(this, sds->idle_cpu);
> > > > > I wonder if we could further enhance it to facilitate idle CPU scan.
> > > > > For example, can we propagate the idle CPUs in smt domain,
> > > > > to its parent
> > > > > domain in a hierarchic sequence, and finally to the LLC
> > > > > domain. If there is
> > > > 
> > > > In fact, it was my first try to cache the unoccupied cpus in SMT
> > > > shared domain, but the overhead of cpumask ops seems like a major
> > > > stumbling block.
> > > > 
> > > > > a cluster domain between SMT and LLC domain, the cluster
> > > > > domain idle CPU filter
> > > > > could benefit from this mechanism.
> > > > > https://lore.kernel.org/lkml/20220609120622.47724-3-yangyicong@hisilicon.com/
> > > > > 
> > > > 
> > > > Putting SIS into a hierarchical pattern is good for cache locality.
> > > > But I don't think multi-level filter is appropriate since it could
> > > > bring too much cache traffic in SIS,
> > > Could you please elaborate a little more about the cache traffic? I
> > > thought we
> > > don't save the unoccupied cpus in SMT shared domain, but to store it
> > > in middle
> > > layer shared domain, say, cluster->idle_cpus, this would reduce
> > > cache write
> > > contention compared to writing to llc->idle_cpus directly, because a
> > > smaller
> > > set of CPUs share the idle_cpus filter. Similarly, SIS can only scan
> > > the cluster->idle_cpus
> > > first, without having to query the llc->idle_cpus. This looks like
> > > splitting
> > > a big lock into fine grain small lock.
> > 
> > I'm afraid I didn't quite follow.. Did you mean replace the LLC filter
> > with multiple cluster filters? Then I agree with what you suggested
> > that the contention would be reduced. But there are other concerns:
> > 
> >    a. Is it appropriate to fake an intermediate sched_domain if
> >       cluster level doesn't available? How to identify the proper
> >       size of the faked sched_domain?
> > 
> >    b. The SIS path might touch more cachelines (multiple cluster
> >       filters). I'm not sure how much is the impact.
> > 
> > Whatever, this seems worth a try. :)
> > 
> 
> After a second thought, maybe it's a similar case of enabling SNC?
> I benchmarked with SNC disabled, so the LLC is relatively big. This
> time I enabled SNC on the same machine mentioned in cover letter, to
> make the filter more fine grained. Please see the following result.
> 
> a) hackbench-process-pipes
> 
> Amean     1        0.4380 (   0.00%)      0.4250 *   2.97%*
> Amean     4        0.6123 (   0.00%)      0.6153 (  -0.49%)
> Amean     7        0.7693 (   0.00%)      0.7217 *   6.20%*
> Amean     12       1.0730 (   0.00%)      1.0723 (   0.06%)
> Amean     21       1.8540 (   0.00%)      1.8817 (  -1.49%)
> Amean     30       2.8147 (   0.00%)      2.7297 (   3.02%)
> Amean     48       4.6280 (   0.00%)      4.4923 *   2.93%*
> Amean     79       8.0897 (   0.00%)      7.8773 (   2.62%)
> Amean     110     10.5320 (   0.00%)     10.1737 (   3.40%)
> Amean     141     13.0260 (   0.00%)     12.4953 (   4.07%)
> Amean     172     15.5093 (   0.00%)     14.3697 *   7.35%*
> Amean     203     17.9633 (   0.00%)     16.7853 *   6.56%*
> Amean     234     20.2327 (   0.00%)     19.2020 *   5.09%*
> Amean     265     22.1203 (   0.00%)     21.3353 (   3.55%)
> Amean     296     24.9337 (   0.00%)     23.8967 (   4.16%)
> 
> b) hackbench-process-sockets
> 
> Amean     1        0.6990 (   0.00%)      0.6520 *   6.72%*
> Amean     4        1.6513 (   0.00%)      1.6080 *   2.62%*
> Amean     7        2.5103 (   0.00%)      2.5020 (   0.33%)
> Amean     12       4.1470 (   0.00%)      4.0957 *   1.24%*
> Amean     21       7.0823 (   0.00%)      6.9237 *   2.24%*
> Amean     30       9.9510 (   0.00%)      9.7937 *   1.58%*
> Amean     48      15.8853 (   0.00%)     15.5410 *   2.17%*
> Amean     79      26.3313 (   0.00%)     26.0363 *   1.12%*
> Amean     110     36.6647 (   0.00%)     36.2657 *   1.09%*
> Amean     141     47.0590 (   0.00%)     46.4010 *   1.40%*
> Amean     172     57.5020 (   0.00%)     56.9897 (   0.89%)
> Amean     203     67.9277 (   0.00%)     66.8273 *   1.62%*
> Amean     234     78.3967 (   0.00%)     77.2137 *   1.51%*
> Amean     265     88.5817 (   0.00%)     87.6143 *   1.09%*
> Amean     296     99.4397 (   0.00%)     98.0233 *   1.42%*
> 
> c) hackbench-thread-pipes
> 
> Amean     1        0.4437 (   0.00%)      0.4373 (   1.43%)
> Amean     4        0.6667 (   0.00%)      0.6340 (   4.90%)
> Amean     7        0.7813 (   0.00%)      0.8177 *  -4.65%*
> Amean     12       1.2747 (   0.00%)      1.3113 (  -2.88%)
> Amean     21       2.4703 (   0.00%)      2.3637 *   4.32%*
> Amean     30       3.6547 (   0.00%)      3.2377 *  11.41%*
> Amean     48       5.7580 (   0.00%)      5.3140 *   7.71%*
> Amean     79       9.1770 (   0.00%)      8.3717 *   8.78%*
> Amean     110     11.7167 (   0.00%)     11.3867 *   2.82%*
> Amean     141     14.1490 (   0.00%)     13.9017 (   1.75%)
> Amean     172     17.3880 (   0.00%)     16.4897 (   5.17%)
> Amean     203     19.3760 (   0.00%)     18.8807 (   2.56%)
> Amean     234     22.7477 (   0.00%)     21.7420 *   4.42%*
> Amean     265     25.8940 (   0.00%)     23.6173 *   8.79%*
> Amean     296     27.8677 (   0.00%)     26.5053 *   4.89%*
> 
> d) hackbench-thread-sockets
> 
> Amean     1        0.7303 (   0.00%)      0.6817 *   6.66%*
> Amean     4        1.6820 (   0.00%)      1.6343 *   2.83%*
> Amean     7        2.6060 (   0.00%)      2.5393 *   2.56%*
> Amean     12       4.2663 (   0.00%)      4.1810 *   2.00%*
> Amean     21       7.2110 (   0.00%)      7.0873 *   1.71%*
> Amean     30      10.1453 (   0.00%)     10.0320 *   1.12%*
> Amean     48      16.2787 (   0.00%)     15.9040 *   2.30%*
> Amean     79      27.0090 (   0.00%)     26.5803 *   1.59%*
> Amean     110     37.5397 (   0.00%)     37.1200 *   1.12%*
> Amean     141     48.0853 (   0.00%)     47.7613 *   0.67%*
> Amean     172     58.7967 (   0.00%)     58.2570 *   0.92%*
> Amean     203     69.5303 (   0.00%)     68.8930 *   0.92%*
> Amean     234     79.9943 (   0.00%)     79.5347 *   0.57%*
> Amean     265     90.5877 (   0.00%)     90.1223 (   0.51%)
> Amean     296    101.2390 (   0.00%)    101.1687 (   0.07%)
> 
> e) netperf-udp
> 
> Hmean     send-64         202.37 (   0.00%)      202.46 (   0.05%)
> Hmean     send-128        407.01 (   0.00%)      402.86 *  -1.02%*
> Hmean     send-256        788.50 (   0.00%)      789.87 (   0.17%)
> Hmean     send-1024      3047.98 (   0.00%)     3036.19 (  -0.39%)
> Hmean     send-2048      5820.33 (   0.00%)     5776.30 (  -0.76%)
> Hmean     send-3312      8941.40 (   0.00%)     8809.25 *  -1.48%*
> Hmean     send-4096     10804.41 (   0.00%)    10686.95 *  -1.09%*
> Hmean     send-8192     17105.63 (   0.00%)    17323.44 *   1.27%*
> Hmean     send-16384    28166.17 (   0.00%)    28191.05 (   0.09%)
> Hmean     recv-64         202.37 (   0.00%)      202.46 (   0.05%)
> Hmean     recv-128        407.01 (   0.00%)      402.86 *  -1.02%*
> Hmean     recv-256        788.50 (   0.00%)      789.87 (   0.17%)
> Hmean     recv-1024      3047.98 (   0.00%)     3036.19 (  -0.39%)
> Hmean     recv-2048      5820.33 (   0.00%)     5776.30 (  -0.76%)
> Hmean     recv-3312      8941.40 (   0.00%)     8809.23 *  -1.48%*
> Hmean     recv-4096     10804.41 (   0.00%)    10686.95 *  -1.09%*
> Hmean     recv-8192     17105.55 (   0.00%)    17323.44 *   1.27%*
> Hmean     recv-16384    28166.03 (   0.00%)    28191.04 (   0.09%)
> 
> f) netperf-tcp
> 
> Hmean     64         838.30 (   0.00%)      837.61 (  -0.08%)
> Hmean     128       1633.25 (   0.00%)     1653.50 *   1.24%*
> Hmean     256       3107.89 (   0.00%)     3148.10 (   1.29%)
> Hmean     1024     10435.39 (   0.00%)    10503.81 (   0.66%)
> Hmean     2048     17152.34 (   0.00%)    17314.40 (   0.94%)
> Hmean     3312     21928.05 (   0.00%)    21995.97 (   0.31%)
> Hmean     4096     23990.44 (   0.00%)    24008.97 (   0.08%)
> Hmean     8192     29445.84 (   0.00%)    29245.31 *  -0.68%*
> Hmean     16384    33592.90 (   0.00%)    34096.68 *   1.50%*
> 
> g) tbench4 Throughput
> 
> Hmean     1        311.15 (   0.00%)      306.76 *  -1.41%*
> Hmean     2        619.24 (   0.00%)      615.00 *  -0.68%*
> Hmean     4       1220.45 (   0.00%)     1222.08 *   0.13%*
> Hmean     8       2410.93 (   0.00%)     2413.59 *   0.11%*
> Hmean     16      4652.09 (   0.00%)     4766.12 *   2.45%*
> Hmean     32      7809.03 (   0.00%)     7831.88 *   0.29%*
> Hmean     64      9116.92 (   0.00%)     9171.25 *   0.60%*
> Hmean     128    17732.63 (   0.00%)    20209.26 *  13.97%*
> Hmean     256    19603.22 (   0.00%)    19007.72 *  -3.04%*
> Hmean     384    19796.37 (   0.00%)    17396.64 * -12.12%*
> 
> 
> There seems like not much difference except hackbench pipe test at
> certain groups (30~110).
OK, smaller LLC domain seems to not have much difference, which might
suggest that by leveraging load balance code path, the read/write
to LLC shared mask might not be the bottleneck. I have an vague
impression that during Aubrey's cpumask searching for idle CPUs
work[1], there is concern that updating the shared mask in large LLC
has introduced cache contention and performance degrading. Maybe we
can find that regressed test case to verify.
[1] https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
> I am intended to provide better scalability
> by applying the filter which will be enabled when:
> 
>   - The LLC is large enough that simply traversing becomes
>     in-sufficient, and/or
> 
>   - The LLC is loaded that unoccupied cpus are minority.
> 
> But it would be very nice if a more fine grained pattern works well
> so we can drop the above constrains.
> 
We can first try to push a simple version, and later optimize it.
One concern about v4 is that, we changed the logic in v3, which recorded
the overloaded CPU, while v4 tracks unoccupied CPUs. An overloaded CPU is
more "stable" because there are more than 1 running tasks on that runqueue.
It is more likely to remain "occupied" for a while. That is to say,
nr_task = 1, 2, 3... will all be regarded as occupied, while only nr_task = 0
is unoccupied. The former would bring less false negative/positive.

By far I have tested hackbench/schbench/netperf on top of Peter's sched/core branch,
with SIS_UTIL enabled. Overall it looks good, and netperf has especially
significant improvement when the load approaches overloaded(which is aligned
with your comment above). I'll re-run the netperf for several cycles to check the
standard deviation. And I'm also curious about v3's performance because it
tracks overloaded CPUs, so I'll also test on v3 with small modifications.

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	group-1 	 1.00 (  0.00)	 -0.16 (  0.00)
process-pipe    	group-2 	 1.00 (  0.00)	 +0.47 (  0.00)
process-pipe    	group-4 	 1.00 (  0.00)	 -0.56 (  0.00)
process-pipe    	group-8 	 1.00 (  0.00)	 +3.29 (  0.00)
process-sockets 	group-1 	 1.00 (  0.00)	 -1.85 (  0.00)
process-sockets 	group-2 	 1.00 (  0.00)	 -5.67 (  0.00)
process-sockets 	group-4 	 1.00 (  0.00)	 -0.14 (  0.00)
process-sockets 	group-8 	 1.00 (  0.00)	 -0.29 (  0.00)
threads-pipe    	group-1 	 1.00 (  0.00)	 +2.17 (  0.00)
threads-pipe    	group-2 	 1.00 (  0.00)	 +3.26 (  0.00)
threads-pipe    	group-4 	 1.00 (  0.00)	 -0.32 (  0.00)
threads-pipe    	group-8 	 1.00 (  0.00)	 +3.36 (  0.00)
threads-sockets 	group-1 	 1.00 (  0.00)	 -0.91 (  0.00)
threads-sockets 	group-2 	 1.00 (  0.00)	 -0.91 (  0.00)
threads-sockets 	group-4 	 1.00 (  0.00)	 +0.27 (  0.00)
threads-sockets 	group-8 	 1.00 (  0.00)	 -0.55 (  0.00)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	mthread-1	 1.00 (  0.00)	 -3.12 (  0.00)
normal          	mthread-2	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	mthread-4	 1.00 (  0.00)	 -2.63 (  0.00)
normal          	mthread-8	 1.00 (  0.00)	 -7.22 (  0.00)

thanks,
Chenyu
> > 
> > Thanks & BR,
> > Abel
