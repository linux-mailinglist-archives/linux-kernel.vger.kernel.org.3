Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4952358D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiEKObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiEKOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:31:26 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19059943
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:31:23 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 0F56D2A6E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:31:22 +0100 (IST)
Received: (qmail 7989 invoked from network); 11 May 2022 14:31:21 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 11 May 2022 14:31:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Date:   Wed, 11 May 2022 15:30:37 +0100
Message-Id: <20220511143038.4620-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220511143038.4620-1-mgorman@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
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

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 49 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03b1ad79d47d..602c05b22805 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9108,6 +9108,24 @@ static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
 	return running <= imb_numa_nr;
 }
 
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long adjust_numa_imbalance(int imbalance,
+				int dst_running, int imb_numa_nr)
+{
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
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
+
 /*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
@@ -9245,8 +9263,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
 
 		/*
@@ -9334,24 +9356,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -9436,7 +9440,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 */
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff >> 1;
+			env->imbalance = nr_diff;
 		} else {
 
 			/*
@@ -9445,7 +9449,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 */
 			env->migration_type = migrate_task;
 			env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus) >> 1);
+						 busiest->idle_cpus));
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
@@ -9454,6 +9458,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 				local->sum_nr_running + 1, env->sd->imb_numa_nr);
 		}
 
+		/* Number of tasks to move to restore balance */
+		env->imbalance >>= 1;
+
 		return;
 	}
 
-- 
2.34.1

