Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393A52EA02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiETKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbiETKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:36:03 -0400
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A873BA4D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:36:01 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 71C11C0BB4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:36:00 +0100 (IST)
Received: (qmail 31180 invoked from network); 20 May 2022 10:36:00 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 May 2022 10:36:00 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Date:   Fri, 20 May 2022 11:35:18 +0100
Message-Id: <20220520103519.1863-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520103519.1863-1-mgorman@techsingularity.net>
References: <20220520103519.1863-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imbalance limitations are applied inconsistently at fork time
and at runtime. At fork, a new task can remain local until there are
too many running tasks even if the degree of imbalance is larger than
NUMA_IMBALANCE_MIN which is different to runtime. Secondly, the imbalance
figure used during load balancing is different to the one used at NUMA
placement. Load balancing uses the number of tasks that must move to
restore imbalance where as NUMA balancing uses the total imbalance.

In combination, it is possible for a parallel workload that uses a small
number of CPUs without applying scheduler policies to have very variable
run-to-run performance.

[lkp@intel.com: Fix build breakage for arc-allyesconfig]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 81 +++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03b1ad79d47d..0b3646be88b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1043,6 +1043,33 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
+#ifdef CONFIG_NUMA
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long
+adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
+{
+	/*
+	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
+	 * threshold. Above this threshold, individual tasks may be contending
+	 * for both memory bandwidth and any shared HT resources.  This is an
+	 * approximation as the number of running tasks may not be related to
+	 * the number of busy CPUs due to sched_setaffinity.
+	 */
+	if (dst_running > imb_numa_nr)
+		return imbalance;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the destination is lightly loaded.
+	 */
+	if (imbalance <= NUMA_IMBALANCE_MIN)
+		return 0;
+
+	return imbalance;
+}
+#endif /* CONFIG_NUMA */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
@@ -1536,8 +1563,6 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
-static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int imb_numa_nr);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -9098,16 +9123,6 @@ static bool update_pick_idlest(struct sched_group *idlest,
 	return true;
 }
 
-/*
- * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
- * This is an approximation as the number of running tasks may not be
- * related to the number of busy CPUs due to sched_setaffinity.
- */
-static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
-{
-	return running <= imb_numa_nr;
-}
-
 /*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
@@ -9224,6 +9239,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 		break;
 
 	case group_has_spare:
+#ifdef CONFIG_NUMA
 		if (sd->flags & SD_NUMA) {
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
@@ -9237,7 +9253,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			idlest_cpu = cpumask_first(sched_group_span(idlest));
 			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
 				return idlest;
-#endif
+#endif /* CONFIG_NUMA_BALANCING */
 			/*
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
@@ -9245,9 +9261,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * allowed. If there is a real need of migration,
 			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
+			if (!adjust_numa_imbalance(imbalance,
+						   local_sgs.sum_nr_running + 1,
+						   sd->imb_numa_nr)) {
 				return NULL;
+			}
 		}
+#endif /* CONFIG_NUMA */
 
 		/*
 		 * Select group with highest number of idle CPUs. We could also
@@ -9334,24 +9355,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
-#define NUMA_IMBALANCE_MIN 2
-
-static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int imb_numa_nr)
-{
-	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
-		return imbalance;
-
-	/*
-	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the destination is lightly loaded.
-	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
-		return 0;
-
-	return imbalance;
-}
-
 /**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
@@ -9436,7 +9439,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 */
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff >> 1;
+			env->imbalance = nr_diff;
 		} else {
 
 			/*
@@ -9444,15 +9447,21 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * idle cpus.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus) >> 1);
+			env->imbalance = max_t(long, 0,
+					       (local->idle_cpus - busiest->idle_cpus));
 		}
 
+#ifdef CONFIG_NUMA
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				local->sum_nr_running + 1, env->sd->imb_numa_nr);
+							       local->sum_nr_running + 1,
+							       env->sd->imb_numa_nr);
 		}
+#endif
+
+		/* Number of tasks to move to restore balance */
+		env->imbalance >>= 1;
 
 		return;
 	}
-- 
2.34.1

