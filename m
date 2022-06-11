Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FE54717A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbiFKDDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFKDDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:03:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702E2449C9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654916615; x=1686452615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CtHkXSCQazGi+7vvtW4Zw3djASiG0J85Gm0qMQ4wXgI=;
  b=AniEhak7gRzp2qVHxSTQspzWgQ8LXLd43WaKylJooPDkogoc+n4J+pfN
   zrrVUctQeQcqy56fxbUAZXid2/0nG16BqmrKTrdctox5heORBInhfmfbF
   4tLAeEg6L+HntvJa1QIoB9shVR5u20wodO8yeGVW+w/jFY01AlT3Yy6Vo
   EURPO5rLagBoLNnNkksPOzBRiCnfgviqU4eGMEwXn7HASrWiBvXbYZWlO
   /QWNeKy2U88sV4K4fb1PSCEWGL/4AxVezeN70Iuut7bFUJjXwARPN4k7b
   8pfcAa+490K0jeXF3RjphOT+PJWMiFpz1DljR9sGtal9kNIP7wHlIKNlp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260926710"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="260926710"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:03:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="638489590"
Received: from jixiao2x-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.172.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:03:25 -0700
Date:   Sat, 11 Jun 2022 11:03:22 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH v4 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <20220611030322.GA9562@chenyu5-mobl1>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-3-yangyicong@hisilicon.com>
 <c3fa2b4f5884e5ad4efda48b1bb2ab4f7a2e532a.camel@linux.intel.com>
 <4ab2c422-04ae-3199-ae2a-357c3270cd05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab2c422-04ae-3199-ae2a-357c3270cd05@huawei.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,
On Fri, Jun 10, 2022 at 02:39:38PM +0800, Yicong Yang wrote:
> On 2022/6/10 6:47, Tim Chen wrote:
> > On Thu, 2022-06-09 at 20:06 +0800, Yicong Yang wrote:
> >> From: Barry Song <song.bao.hua@hisilicon.com>
> >>
> >> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> >> have lower latency when synchronizing and accessing shared resources like
> >> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> >> target CPU before scanning the whole LLC to gain lower latency.
> >>
> >> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this patch
> >> doesn't consider SMT for this moment.
> >>
> >> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> >> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> >>
> >> With this patch, We noticed enhancement on tbench within one numa or cross
> >> two numa.
> >>
> >> On numa 0:
> >>                             5.19-rc1                patched
> >> Hmean     1        350.27 (   0.00%)      406.88 *  16.16%*
> >> Hmean     2        702.01 (   0.00%)      808.22 *  15.13%*
> >> Hmean     4       1405.14 (   0.00%)     1614.34 *  14.89%*
> >> Hmean     8       2830.53 (   0.00%)     3169.02 *  11.96%*
> >> Hmean     16      5597.95 (   0.00%)     6224.20 *  11.19%*
> >> Hmean     32     10537.38 (   0.00%)    10524.97 *  -0.12%*
> >> Hmean     64      8366.04 (   0.00%)     8437.41 *   0.85%*
> >> Hmean     128     7060.87 (   0.00%)     7150.25 *   1.27%*
> >>
> >> On numa 0-1:
> >>                             5.19-rc1                patched
> >> Hmean     1        346.11 (   0.00%)      408.47 *  18.02%*
> >> Hmean     2        693.34 (   0.00%)      805.78 *  16.22%*
> >> Hmean     4       1384.96 (   0.00%)     1602.49 *  15.71%*
> >> Hmean     8       2699.45 (   0.00%)     3069.98 *  13.73%*
> >> Hmean     16      5327.11 (   0.00%)     5688.19 *   6.78%*
> >> Hmean     32     10019.10 (   0.00%)    11862.56 *  18.40%*
> >> Hmean     64     13850.57 (   0.00%)    17748.54 *  28.14%*
> >> Hmean     128    12498.25 (   0.00%)    15541.59 *  24.35%*
> >> Hmean     256    11195.77 (   0.00%)    13854.06 *  23.74%*
> > 
> > Yicong,
> > 
> > Have you tried any workload where tasks don't share data
> > with each other but have sleep/wakeup?  That's the case
> > where we actually want to spread the tasks out among the clusters
> > to void contention for L2 cache.
> > 
> > Will be nice to make sure there's no regression there for
> > such workload.
> > 
> 
> Any certain workload you'd like me test? I'm willing to do :)
> 
> I've tested this patch with MySQL as well (like in v2). This won't hurt
> the MySQL case with SIS_PROP but observed some improvement with SIS_UTIL
> posted in [1]. We leverage the nr to suppress redundant scanning in the
> current approach and seems SIS_UTIL is more efficient in this case.
> 
> 			 5.19-rc1		   patched	 patched+SIS_UTIL[1]
> TPS-16threads		  6215.11	  6172.74 (-0.68%)	  6217.33 (0.04%)
> QPS-16threads		124302.21	123454.68 (-0.68%)	124346.52 (0.04%)
> avg-lat-16threads	     2.57	     2.59 (-0.65%)	     2.57 (0.00%)
> TPS-24threads		  8726.40	  8690.87 (-0.41%)	  8833.08 (1.22%)
> QPS-24threads		174527.88	173817.42 (-0.41%)	176661.54 (1.21%)
> avg-lat-24threads	     2.75	     2.76 (-0.36%)	     2.71 (1.33%)
> TPS-32threads		  9555.42	  9514.86 (-0.42%)	 10010.87 (4.77%)
> QPS-32threads		191108.37	190297.28 (-0.42%)	200217.35 (4.55%)
> avg-lat-32threads	     3.35	     3.36 (-0.30%)	     3.20 (4.58%)
> TPS-64threads		 10290.10	 10324.75 (0.34%)	 10819.77 (5.15%)
> QPS-64threads		205802.05	206494.95 (0.34%)	216395.40 (4.90%)
> avg-lat-64threads	     6.22	     6.20 (0.38%)	     5.92 (4.88%)
> 
>
Thanks for the testings. I'm refining the patch according to Mel's suggestion and
will send it out later. Some minor nits below. 
> > Code itself looks good.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > 
> 
> Thanks.
> 
> [1] https://lore.kernel.org/lkml/20220428182442.659294-1-yu.c.chen@intel.com/
> 
> >>
> >> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 41 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 77b2048a9326..6d173e196ad3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6327,6 +6327,40 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> >>  
> >>  #endif /* CONFIG_SCHED_SMT */
> >>  
> >> +#ifdef CONFIG_SCHED_CLUSTER
> >> +/*
> >> + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> >> + */
> >> +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
> >> +			       int target, int *nr)
> >> +{
> >> +	struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> >> +	int cpu, idle_cpu;
> >> +
> >> +	/* TODO: Support SMT system with cluster topology */
> >> +	if (!sched_smt_active() && sd) {
> >> +		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> >> +			if (!--*nr)
> >> +				break;
Maybe I understand it incorrectly, here we changed the value of nr. Then if
we did not find any idle CPU in the cluster, nr is set to 0. Then in the LLC scan,
since there is 'if (--nr <= 0)', the LLC scan terminates.
Is the policy like: if we can not find one idle CPU in the cluster, we give
up scan for one in the LLC?
[cut]
> >> +
> >>  /*
> >>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
If we add logic for cluster scan, might need to update the comment as well.
> >>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> >> @@ -6375,6 +6409,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>  		time = cpu_clock(this);
> >>  	}
> >>  
> >> +	idle_cpu = scan_cluster(p, cpus, target, &nr);
> >> +	if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >> +		return idle_cpu;
> >> +
> >>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>  		if (has_idle_core) {
> >>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >> @@ -6382,7 +6420,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>  				return i;
> >>  
> >>  		} else {
> >> -			if (!--nr)
> >> +			if (--nr <= 0)
May I know the reason to change this? I thought this could be a seperate patch.

thanks,
Chenyu
> >>  				return -1;
> >>  			idle_cpu = __select_idle_cpu(cpu, p);
> >>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >> @@ -6481,7 +6519,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	/*
> >>  	 * If the previous CPU is cache affine and idle, don't be stupid:
> >>  	 */
> >> -	if (prev != target && cpus_share_cache(prev, target) &&
> >> +	if (prev != target && cpus_share_resources(prev, target) &&
> >>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >>  	    asym_fits_capacity(task_util, prev))
> >>  		return prev;
> >> @@ -6507,7 +6545,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	p->recent_used_cpu = prev;
> >>  	if (recent_used_cpu != prev &&
> >>  	    recent_used_cpu != target &&
> >> -	    cpus_share_cache(recent_used_cpu, target) &&
> >> +	    cpus_share_resources(recent_used_cpu, target) &&
> >>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >>  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >>  	    asym_fits_capacity(task_util, recent_used_cpu)) {
> > 
> > 
> > .
> > 
