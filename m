Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0E4A86E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351513AbiBCOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:35 -0500
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:44563 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351453AbiBCOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:47:25 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id BE42EFA97A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:47:24 +0000 (GMT)
Received: (qmail 2492 invoked from network); 3 Feb 2022 14:47:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 3 Feb 2022 14:47:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs
Date:   Thu,  3 Feb 2022 14:46:52 +0000
Message-Id: <20220203144652.12540-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203144652.12540-1-mgorman@techsingularity.net>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

Zen* has multiple LLCs per node with local memory channels and due to
the allowed imbalance, it's far harder to tune some workloads to run
optimally than it is on hardware that has 1 LLC per node. This patch
allows an imbalance to exist up to the point where LLCs should be balanced
between nodes.

On a Zen3 machine running STREAM parallelised with OMP to have on instance
per LLC the results and without binding, the results are

                            5.17.0-rc0             5.17.0-rc0
                               vanilla       sched-numaimb-v5
MB/sec copy-16    162596.94 (   0.00%)   501967.12 ( 208.72%)
MB/sec scale-16   136901.28 (   0.00%)   376531.50 ( 175.04%)
MB/sec add-16     157300.70 (   0.00%)   569997.42 ( 262.36%)
MB/sec triad-16   151446.88 (   0.00%)   553204.54 ( 265.28%)

STREAM can use directives to force the spread if the OpenMP is new
enough but that doesn't help if an application uses threads and
it's not known in advance how many threads will be created.

Coremark is a CPU and cache intensive benchmark parallelised with
threads. When running with 1 thread per core, the vanilla kernel
allows threads to contend on cache. With the patch;

                               5.17.0-rc0             5.17.0-rc0
                                  vanilla       sched-numaimb-v5
Min       Score-16   368239.36 (   0.00%)   400876.92 (   8.86%)
Hmean     Score-16   388607.33 (   0.00%)   441447.30 *  13.60%*
Max       Score-16   408945.69 (   0.00%)   478826.87 (  17.09%)
Stddev    Score-16    15247.04 (   0.00%)    34061.76 (-123.40%)
CoeffVar  Score-16        3.92 (   0.00%)        7.67 ( -95.82%)

It can also make a big difference for semi-realistic workloads
like specjbb which can execute arbitrary numbers of threads without
advance knowledge of how they should be placed

                               5.17.0-rc0             5.17.0-rc0
                                  vanilla       sched-numaimb-v5
Hmean     tput-1      71631.55 (   0.00%)    70383.46 (  -1.74%)
Hmean     tput-8     582758.78 (   0.00%)   607290.89 *   4.21%*
Hmean     tput-16   1020372.75 (   0.00%)  1031257.25 (   1.07%)
Hmean     tput-24   1416430.67 (   0.00%)  1587576.33 *  12.08%*
Hmean     tput-32   1687702.72 (   0.00%)  1724207.51 (   2.16%)
Hmean     tput-40   1798094.90 (   0.00%)  1983053.56 *  10.29%*
Hmean     tput-48   1972731.77 (   0.00%)  2157461.70 (   9.36%)
Hmean     tput-56   2386872.38 (   0.00%)  2193237.42 (  -8.11%)
Hmean     tput-64   2536954.17 (   0.00%)  2588741.08 (   2.04%)
Hmean     tput-72   2585071.36 (   0.00%)  2654776.36 (   2.70%)
Hmean     tput-80   2960523.94 (   0.00%)  2894657.12 (  -2.22%)
Hmean     tput-88   3061408.57 (   0.00%)  2903167.72 (  -5.17%)
Hmean     tput-96   3052394.82 (   0.00%)  2872605.46 (  -5.89%)
Hmean     tput-104  2997814.76 (   0.00%)  3013660.26 (   0.53%)
Hmean     tput-112  2955353.29 (   0.00%)  3029122.16 (   2.50%)
Hmean     tput-120  2889770.71 (   0.00%)  2957739.88 (   2.35%)
Hmean     tput-128  2871713.84 (   0.00%)  2912410.18 (   1.42%)

In general, the standard deviation figures also are a lot more
stable.

Similarly, for embarassingly parallel problems like NPB-ep, there are
improvements due to better spreading across LLC when the machine is not
fully utilised.

                              vanilla    sched-numaimb-v5r12
Min       ep.D       31.79 (   0.00%)       26.11 (  17.87%)
Amean     ep.D       31.86 (   0.00%)       26.26 *  17.58%*
Stddev    ep.D        0.07 (   0.00%)        0.18 (-157.54%)
CoeffVar  ep.D        0.22 (   0.00%)        0.69 (-212.46%)
Max       ep.D       31.93 (   0.00%)       26.46 (  17.13%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 22 +++++++-------
 kernel/sched/topology.c        | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8054641c0a7b..56cffe42abbc 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -93,6 +93,7 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int imb_numa_nr;	/* Nr running tasks that allows a NUMA imbalance */
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4592ccf82c34..86abf97a8df6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1489,6 +1489,7 @@ struct task_numa_env {
 
 	int src_cpu, src_nid;
 	int dst_cpu, dst_nid;
+	int imb_numa_nr;
 
 	struct numa_stats src_stats, dst_stats;
 
@@ -1503,7 +1504,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int dst_weight);
+					int dst_running, int imb_numa_nr);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1884,7 +1885,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-							env->dst_stats.weight);
+						  env->imb_numa_nr);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -1949,8 +1950,10 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
+	if (sd) {
 		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -9003,10 +9006,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * This is an approximation as the number of running tasks may not be
  * related to the number of busy CPUs due to sched_setaffinity.
  */
-static inline bool
-allow_numa_imbalance(unsigned int running, unsigned int weight)
+static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
 {
-	return (running < (weight >> 2));
+	return running < imb_numa_nr;
 }
 
 /*
@@ -9146,7 +9148,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * allowed. If there is a real need of migration,
 			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
 				return NULL;
 		}
 
@@ -9238,9 +9240,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 #define NUMA_IMBALANCE_MIN 2
 
 static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int dst_weight)
+				int dst_running, int imb_numa_nr)
 {
-	if (!allow_numa_imbalance(dst_running, dst_weight))
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
 		return imbalance;
 
 	/*
@@ -9352,7 +9354,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				local->sum_nr_running + 1, local->group_weight);
+				local->sum_nr_running + 1, env->sd->imb_numa_nr);
 		}
 
 		return;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..e6cd55951304 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2242,6 +2242,59 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	/*
+	 * Calculate an allowed NUMA imbalance such that LLCs do not get
+	 * imbalanced.
+	 */
+	for_each_cpu(i, cpu_map) {
+		unsigned int imb = 0;
+		unsigned int imb_span = 1;
+
+		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *child = sd->child;
+
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
+			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+				struct sched_domain *top, *top_p;
+				unsigned int nr_llcs;
+
+				/*
+				 * For a single LLC per node, allow an
+				 * imbalance up to 25% of the node. This is an
+				 * arbitrary cutoff based on SMT-2 to balance
+				 * between memory bandwidth and avoiding
+				 * premature sharing of HT resources and SMT-4
+				 * or SMT-8 *may* benefit from a different
+				 * cutoff.
+				 *
+				 * For multiple LLCs, allow an imbalance
+				 * until multiple tasks would share an LLC
+				 * on one node while LLCs on another node
+				 * remain idle.
+				 */
+				nr_llcs = sd->span_weight / child->span_weight;
+				if (nr_llcs == 1)
+					imb = sd->span_weight >> 2;
+				else
+					imb = nr_llcs;
+				sd->imb_numa_nr = imb;
+
+				/* Set span based on the first NUMA domain. */
+				top = sd;
+				top_p = top->parent;
+				while (top_p && !(top_p->flags & SD_NUMA)) {
+					top = top->parent;
+					top_p = top->parent;
+				}
+				imb_span = top_p ? top_p->span_weight : sd->span_weight;
+			} else {
+				int factor = max(1U, (sd->span_weight / imb_span));
+
+				sd->imb_numa_nr = imb * factor;
+			}
+		}
+	}
+
 	/* Calculate CPU capacity for physical packages and nodes */
 	for (i = nr_cpumask_bits-1; i >= 0; i--) {
 		if (!cpumask_test_cpu(i, cpu_map))
-- 
2.31.1

