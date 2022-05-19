Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91352DB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiESRgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbiESRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:36:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0965933B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652981783; x=1684517783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XjcimBLPuQ/Rzrqjo5hyzSgoPc5wEwaCOTcZb9Chnrw=;
  b=dC2xtuI1Wp1JQRCpoHykG1JsTR1QkDGZfazx/YGwxOFc1TeepUUzjsPX
   v55eqGcPBlcy5lf/16xrxdcXMP+M6axew3TtYLHoft0rKgSCiLKA4StZk
   mL8BNYvPLLQJX1xqcdF/ciHs7ZcaAMJImb9P4ZjuFsw8ZrMjuICGMf6Yr
   FiHo9g9KKDsxpr0Xi0S9LcDEyKsq0YkU81Ikz7XBpD6Wn3T6e9bG45P04
   IF59ecc2HI/AHpspuHO0ROFp99jecdZ2AkXkvquw0SuVlFcuBD5YebGkg
   NB7JKKkcS0cww97ji8Rh/xA/NqnAkz4acUOoEBkypb5OPnPe1UDriysan
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272258582"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272258582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598698822"
Received: from hzhan51-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.30.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 10:36:15 -0700
Date:   Fri, 20 May 2022 01:36:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mel Gorman <mgorman@suse.de>
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
Message-ID: <20220519173609.GA20380@chenyu5-mobl1>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <20220517125047.GR20579@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517125047.GR20579@suse.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,
On Tue, May 17, 2022 at 01:50:47PM +0100, Mel Gorman wrote:
> On Fri, Apr 29, 2022 at 02:24:42AM +0800, Chen Yu wrote:
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
> 
> Seems fair other than the 85% is hardcoded based on an imbalance_pct of
> 117. If that value should ever change, it'll drift apart.
> 
OK, I can change the calculation based on imbalance_pct rather than hard code
to 85%.
> > SIS_UTIL is disabled by default. When it is enabled, the select_idle_cpu()
> > will use the nr_scan calculated by SIS_UTIL instead of the one from
> > SIS_PROP. Later SIS_UTIL and SIS_PROP could be made mutually exclusive.
> > 
> 
> I agree with Peter, this should be enabled by default. I am somewhat
> embarassed that I initially queued this patch blindly for testing when it
> was mailed thinking "I would like to have some results before reviewing"
> and then when I sit down to do the review, the results are all useless
> because the feature was disabled. My initial thinking starting the review
> was "Weird, none of these results are conclusive in any way."
> 
Thank you for the review and testing this change, and sorry for the inconvenience.
> I don't think you need to explicitly check for both being enabled given
> that it's a sched_feat. Someone poking in there is meant to be debugging
> something but the vast majority of people will never go looking.
> 
OK, I'll change it to enabled by default.
> > Limitations:
> > [1]
> > This patch is based on the util_avg, which is very sensitive to the CPU
> > frequency invariance. The util_avg would decay quite fast when the
> > CPU is idle, if the max frequency has been limited by the user.
> > Patch [3] should be applied if turbo is disabled manually on Intel
> > platforms.
> > 
> 
> It is worth mentioning in the changelog if there is a patch that this
> implicitly depends upon. It affects the ordering patches should be merged
> or bisections for a regression may unfairly identify your patch as the
> source of the problem.
> 
> At least then if they merge in the wrong order there will something
> obvious to check.
>
OK, I'll keep this informantion in the changelog. And the patch mentioned
has been queued for 5.19. 
> > [2]
> > There may be unbalanced tasks among CPUs due to CPU affinity. For example,
> > suppose the LLC domain is composed of 8 CPUs, and 7 tasks are bound to
> > CPU0~CPU6, while CPU7 is idle:
> > 
> >           CPU0    CPU1    CPU2    CPU3    CPU4    CPU5    CPU6    CPU7
> > util_avg  1024    1024    1024    1024    1024    1024    1024    0
> > 
> > Since the util_avg ratio is 87.5%( = 7/8 ), which is higher than 85%,
> > select_idle_cpu() will not scan, thus CPU7 is undetected.
> > 
> > A possible workaround to mitigate this problem is that the nr_scan should
> > be increased if idle CPUs are detected during periodic load balance. And the
> > problem could be mitigated by idle load balance that, CPU7 might pull some
> > tasks on it.
> > 
> 
> While a valid concern, it's no worse than what is there now and I think
> this case is unlikely. It could naturally happen if there was 6 busy tasks
> running entirely in userspace which is harmless. Normal load balancing
> would use CPU7 if there was any stacking on CPU0 to CPU6 or NEWLY_IDLE
> ILB on CPU7 would pull something if there was any other activity on CPU7.
> 
Yes agreed.
> > [3]
> > Prateek mentioned that we should scan aggressively in an LLC domain
> > with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
> > negligible. The current patch aims to propose a generic solution and only
> > considers the util_avg. A follow-up change could enhance the scan policy
> > to adjust the scan_percent according to the CPU number in LLC.
> > 
> 
> Yes, anything along those lines is a separate patch.
> 
OK, I'm working with Prateek on this, to collect test data and make the search
policy more friendly to small LLC size platform.
> > v2->v3:
> >  - Use 85% as the threshold again, because the CPU frequency invariance issue
> >    has been fixed and the patch is queued for 5.19.
> > 
> 
> Note in changelog exactly what this fix is in case the patches go in the
> wrong order.
> 
OK, will do.
> >  - Stop the scan if 85% is reached, rather than scanning for at least 4 CPUs.
> >    According to the feedback from Yicong, it might be better to stop scanning
> >    entirely when the LLC is overloaded.
> > 
> 
> I think only workloads like hackbench benefit from "search 4 CPUs"
> heuristic because the machine is heavily overloaded with tasks that are
> rapidly idling. Be wary of a patch that sets it back to 4 with hackbench
> being the only justification.
> 
Yes, this is also my concern. As Prateek mentioned, in a LLC with 16 CPUs, and when
the system is extremely overloaded, there is slight regression on hackbench, because
with this patch applied, the SIS would gives up scanning CPUs, while SIS_PROP would
scan at least 4 CPUs.
> >  }
> >
[snip]  
> > +static inline void update_idle_cpu_scan(struct lb_env *env,
> > +					unsigned long sum_util)
> > +{
> 
> Don't inline. This is a long function with one callsite, the compiler
> should be able to figure it out.
> 
OK, will do in next version.
> > +	struct sched_domain_shared *sd_share;
> > +	int nr_scan, nr_llc, llc_util_pct;
> > +
> > +	if (!sched_feat(SIS_UTIL))
> > +		return;
> 
> Move the CPU_NEWLY_IDLE check here because it's essentially a free check
> and avoids the per_cpu lookup.
> 
OK.
> Also comment on why CPU_NEWLY_IDLE is ignored. I assume it's because you
> are updating sd_shared which is a shared cache line write and
> CPU_NEWLY_IDLE can fire way more frequently than periodic load
> balancing.
> 
Yes, I'll add the comment here.
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
> 
> This caught me because nr_llc made me think it was "the number
> of last level caches in a NUMA node" because that's what it means
> in kernel/sched/topology.c. This is the number of CPUs sharing an
> LLC to llc_weight would be appropriate given that it's compared to
> span_weight. It's not mandatory for me but it's preferable.
> 
OK, I'll change it to llc_weight.
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
> Peter commented on this already.
> 
> > +	WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> > +}
> 
> To avoid excessive unnecessary cache line bounces;
> 
> 	if (nr_scan != sd_share->nr_idle_scan)
> 		WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> 
> I expect the two very common values represent "machine is mostly idle
> scan everything" and "machine is heavily overloaded, scan nothing" and
> I'm betting the cost of the branch is less than the cost of rewriting
> the same values.
> 
OK, will do in next version.

thanks,
Chenyu
