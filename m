Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9ED56C834
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGIIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGIIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:55:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19457204
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657356927; x=1688892927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hrd+kJMCKfMCKVNFR0O9QIq4Bnce3qqGLashOG7p6pk=;
  b=VnCu0GRHkPRuyfGKB0Ie5OUlhFCPnGulUm5POkYyJFl42uj/5vbyuJUe
   OIL3z/X+O5+YpKX96FPaDgPCJ631LCul5krIUHk5ODaM7+T5NNUGZgseA
   2TBFgJN3RNrNnCkLLFVTgNwvyVmK/4lJ40u73NRFAhEo2yupnG1j8xhCM
   ZPHXkvcOXx5Ztn03/XFU553aqIvzfVF6QA3tWj9WkS18827FiXM97rfdm
   k+rgy1VHD3n2VF7bCA47wV0R2HJpMbFW5uNWYoIdTNmgU3TepmpiEaXuT
   q01K0fXyTlofnkoiPa2hn0Y+ECtGs74ta7eR8UnlZsOywPi+PUplAiWrt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348405104"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="348405104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 01:55:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="569210423"
Received: from wangqi7-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.168.82])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 01:55:23 -0700
Date:   Sat, 9 Jul 2022 16:55:19 +0800
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
Message-ID: <20220709085519.GA13764@chenyu5-mobl1>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
 <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
 <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
 <20220630041645.GA9253@chenyu5-mobl1>
 <a72bf17e-f633-87e1-1166-6a4bff122500@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72bf17e-f633-87e1-1166-6a4bff122500@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:46:08PM +0800, Abel Wu wrote:
> 
> On 6/30/22 12:16 PM, Chen Yu Wrote:
> > On Tue, Jun 28, 2022 at 03:58:55PM +0800, Abel Wu wrote:
> > > 
> > > On 6/27/22 6:13 PM, Abel Wu Wrote:
> > > There seems like not much difference except hackbench pipe test at
> > > certain groups (30~110).
> > OK, smaller LLC domain seems to not have much difference, which might
> > suggest that by leveraging load balance code path, the read/write
> > to LLC shared mask might not be the bottleneck. I have an vague
> > impression that during Aubrey's cpumask searching for idle CPUs
> > work[1], there is concern that updating the shared mask in large LLC
> > has introduced cache contention and performance degrading. Maybe we
> > can find that regressed test case to verify.
> > [1] https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
> 
> I just went through Aubrey's v1-v11 patches and didn't find any
> particular tests other than hackbench/tbench/uperf. Please let
> me know if I missed something, thanks!
>
I haven't found any testcase that could trigger the cache contention
issue. I thought we could stick with these testcases for now, especially
for tbench, it has detected a cache issue described in
https://lore.kernel.org/lkml/e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com
if I understand correctly.
> > > I am intended to provide better scalability
> > > by applying the filter which will be enabled when:
> > > 
> > >    - The LLC is large enough that simply traversing becomes
> > >      in-sufficient, and/or
> > > 
> > >    - The LLC is loaded that unoccupied cpus are minority.
> > > 
> > > But it would be very nice if a more fine grained pattern works well
> > > so we can drop the above constrains.
> > > 
> > We can first try to push a simple version, and later optimize it.
> > One concern about v4 is that, we changed the logic in v3, which recorded
> > the overloaded CPU, while v4 tracks unoccupied CPUs. An overloaded CPU is
> > more "stable" because there are more than 1 running tasks on that runqueue.
> > It is more likely to remain "occupied" for a while. That is to say,
> > nr_task = 1, 2, 3... will all be regarded as occupied, while only nr_task = 0
> > is unoccupied. The former would bring less false negative/positive.
> 
> Yes, I like the 'overloaded mask' too, but the downside is extra
> cpumask ops needed in the SIS path (the added cpumask_andnot).
> Besides, in this patch, the 'overloaded mask' is also unstable due
> to the state is maintained at core level rather than per-cpu, some
> more thoughts are in cover letter.
>
I see.
> > 
> > By far I have tested hackbench/schbench/netperf on top of Peter's sched/core branch,
> > with SIS_UTIL enabled. Overall it looks good, and netperf has especially
> > significant improvement when the load approaches overloaded(which is aligned
> > with your comment above). I'll re-run the netperf for several cycles to check the
> > standard deviation. And I'm also curious about v3's performance because it
> > tracks overloaded CPUs, so I'll also test on v3 with small modifications.
> 
> Thanks very much for your reviewing and testing.
> 
I modified your v3 patch a little bit, and the test result shows good improvement
on netperf and no significant regression on schbench/tbench/hackbench on this draft
patch. I would like to vote for your v3 version as it seems to be more straightforward,
what do you think of the following change:

From 277b60b7cd055d5be93188a552da50fdfe53214c Mon Sep 17 00:00:00 2001
From: Abel Wu <wuyun.abel@bytedance.com>
Date: Fri, 8 Jul 2022 02:16:47 +0800
Subject: [PATCH] sched/fair: Introduce SIS_FILTER to skip overloaded CPUs
 during SIS

Currently SIS_UTIL is used to limit the scan depth of idle CPUs in
select_idle_cpu(). There could be another optimization to filter
the overloaded CPUs so as to further speed up select_idle_cpu().
Launch the CPU overload check in periodic tick, and take consideration
of nr_running, avg_util and runnable_avg of that CPU. If the CPU is
overloaded, add it into per LLC overload cpumask, so select_idle_cpu()
could skip those overloaded CPUs. Although this detection is in periodic
tick, checking the pelt signal of the CPU would make the 'overloaded' state
more stable and reduce the frequency to update the LLC shared mask,
so as to mitigate the cache contention in the LLC.

The following results are tested on top of latest sched/core tip.
The baseline is with SIS_UTIL enabled, and compared it with both SIS_FILTER
/SIS_UTIL enabled. Positive %compare stands for better performance.

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1 group 	 1.00 (  0.59)	 -1.35 (  0.88)
process-pipe    	2 groups 	 1.00 (  0.38)	 -1.49 (  0.04)
process-pipe    	4 groups 	 1.00 (  0.45)	 +0.10 (  0.91)
process-pipe    	8 groups 	 1.00 (  0.11)	 +0.03 (  0.38)
process-sockets 	1 group 	 1.00 (  3.48)	 +2.88 (  7.07)
process-sockets 	2 groups 	 1.00 (  2.38)	 -3.78 (  2.81)
process-sockets 	4 groups 	 1.00 (  0.26)	 -1.79 (  0.82)
process-sockets 	8 groups 	 1.00 (  0.07)	 -0.35 (  0.07)
threads-pipe    	1 group 	 1.00 (  0.87)	 -0.21 (  0.71)
threads-pipe    	2 groups 	 1.00 (  0.63)	 +0.34 (  0.45)
threads-pipe    	4 groups 	 1.00 (  0.18)	 -0.02 (  0.50)
threads-pipe    	8 groups 	 1.00 (  0.08)	 +0.46 (  0.05)
threads-sockets 	1 group 	 1.00 (  0.80)	 -0.08 (  1.06)
threads-sockets 	2 groups 	 1.00 (  0.55)	 +0.06 (  0.85)
threads-sockets 	4 groups 	 1.00 (  1.00)	 -2.13 (  0.18)
threads-sockets 	8 groups 	 1.00 (  0.07)	 -0.41 (  0.08)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	28 threads	 1.00 (  0.50)	 +0.19 (  0.53)
TCP_RR          	56 threads	 1.00 (  0.33)	 +0.31 (  0.35)
TCP_RR          	84 threads	 1.00 (  0.23)	 +0.15 (  0.28)
TCP_RR          	112 threads	 1.00 (  0.20)	 +0.03 (  0.21)
TCP_RR          	140 threads	 1.00 (  0.17)	 +0.20 (  0.18)
TCP_RR          	168 threads	 1.00 (  0.17)	+112.84 ( 40.35)
TCP_RR          	196 threads	 1.00 ( 16.66)	 +0.39 ( 15.72)
TCP_RR          	224 threads	 1.00 ( 10.28)	 +0.05 (  9.97)
UDP_RR          	28 threads	 1.00 ( 16.15)	 -0.13 (  0.93)
UDP_RR          	56 threads	 1.00 (  7.76)	 +1.24 (  0.44)
UDP_RR          	84 threads	 1.00 ( 11.68)	 -0.49 (  6.33)
UDP_RR          	112 threads	 1.00 (  8.49)	 -0.21 (  7.77)
UDP_RR          	140 threads	 1.00 (  8.49)	 +2.05 ( 19.88)
UDP_RR          	168 threads	 1.00 (  8.91)	 +1.67 ( 11.74)
UDP_RR          	196 threads	 1.00 ( 19.96)	 +4.35 ( 21.37)
UDP_RR          	224 threads	 1.00 ( 19.44)	 +4.38 ( 16.61)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	28 threads	 1.00 (  0.12)	 +0.57 (  0.12)
loopback        	56 threads	 1.00 (  0.11)	 +0.42 (  0.11)
loopback        	84 threads	 1.00 (  0.09)	 +0.71 (  0.03)
loopback        	112 threads	 1.00 (  0.03)	 -0.13 (  0.08)
loopback        	140 threads	 1.00 (  0.29)	 +0.59 (  0.01)
loopback        	168 threads	 1.00 (  0.01)	 +0.86 (  0.03)
loopback        	196 threads	 1.00 (  0.02)	 +0.97 (  0.21)
loopback        	224 threads	 1.00 (  0.04)	 +0.83 (  0.22)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1 mthread	 1.00 (  0.00)	 -8.82 (  0.00)
normal          	2 mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	4 mthreads	 1.00 (  0.00)	+17.02 (  0.00)
normal          	8 mthreads	 1.00 (  0.00)	 -4.84 (  0.00)

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h |  6 +++++
 kernel/sched/core.c            |  1 +
 kernel/sched/fair.c            | 47 ++++++++++++++++++++++++++++++++++
 kernel/sched/features.h        |  1 +
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        |  3 ++-
 6 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..c03076850a67 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,8 +82,14 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+	unsigned long	overloaded_cpus[];
 };
 
+static inline struct cpumask *sdo_mask(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->overloaded_cpus);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d3e2c5a7c1b7..452eb63ee6f6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5395,6 +5395,7 @@ void scheduler_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
+	update_overloaded_rq(rq);
 
 	rq_unlock(rq, &rf);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f80ae86bb404..34b1650f85f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6323,6 +6323,50 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+/* derived from group_is_overloaded() */
+static inline bool rq_overloaded(struct rq *rq, int cpu, unsigned int imbalance_pct)
+{
+	if (rq->nr_running - rq->cfs.idle_h_nr_running <= 1)
+		return false;
+
+	if ((SCHED_CAPACITY_SCALE * 100) <
+			(cpu_util_cfs(cpu) * imbalance_pct))
+		return true;
+
+	if ((SCHED_CAPACITY_SCALE * imbalance_pct) <
+			(cpu_runnable(rq) * 100))
+		return true;
+
+	return false;
+}
+
+void update_overloaded_rq(struct rq *rq)
+{
+	struct sched_domain_shared *sds;
+	struct sched_domain *sd;
+	int cpu;
+
+	if (!sched_feat(SIS_FILTER))
+		return;
+
+	cpu = cpu_of(rq);
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (unlikely(!sd))
+		return;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (unlikely(!sds))
+		return;
+
+	if (rq_overloaded(rq, cpu, sd->imbalance_pct)) {
+		/* avoid duplicated write, mitigate cache contention */
+		if (!cpumask_test_cpu(cpu, sdo_mask(sds)))
+			cpumask_set_cpu(cpu, sdo_mask(sds));
+	} else {
+		if (cpumask_test_cpu(cpu, sdo_mask(sds)))
+			cpumask_clear_cpu(cpu, sdo_mask(sds));
+	}
+}
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6383,6 +6427,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (sched_feat(SIS_FILTER) && !has_idle_core && sd->shared)
+		cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..1bebdb87c2f4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_FILTER, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 02c970501295..316127ab1ec7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1812,6 +1812,8 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
 
 extern int group_balance_cpu(struct sched_group *sg);
 
+void update_overloaded_rq(struct rq *rq);
+
 #ifdef CONFIG_SCHED_DEBUG
 void update_sched_domain_debugfs(void);
 void dirty_sched_domain_sysctl(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..0d149e76a3b3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1641,6 +1641,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		cpumask_clear(sdo_mask(sd->shared));
 	}
 
 	sd->private = sdd;
@@ -2106,7 +2107,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.25.1

