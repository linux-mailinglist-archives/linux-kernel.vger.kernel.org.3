Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639AD4A86E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351433AbiBCOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:31 -0500
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:60949 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351489AbiBCOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:47:15 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 92656CCD28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:47:14 +0000 (GMT)
Received: (qmail 1893 invoked from network); 3 Feb 2022 14:47:14 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 3 Feb 2022 14:47:14 -0000
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
Subject: [PATCH 1/2] sched/fair: Improve consistency of allowed NUMA balance calculations
Date:   Thu,  3 Feb 2022 14:46:51 +0000
Message-Id: <20220203144652.12540-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203144652.12540-1-mgorman@techsingularity.net>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are inconsistencies when determining if a NUMA imbalance is allowed
that should be corrected.

o allow_numa_imbalance changes types and is not always examining
  the destination group so both the type should be corrected as
  well as the naming.
o find_idlest_group uses the sched_domain's weight instead of the
  group weight which is different to find_busiest_group
o find_busiest_group uses the source group instead of the destination
  which is different to task_numa_find_cpu
o Both find_idlest_group and find_busiest_group should account
  for the number of running tasks if a move was allowed to be
  consistent with task_numa_find_cpu

Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..4592ccf82c34 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9003,9 +9003,10 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * This is an approximation as the number of running tasks may not be
  * related to the number of busy CPUs due to sched_setaffinity.
  */
-static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+static inline bool
+allow_numa_imbalance(unsigned int running, unsigned int weight)
 {
-	return (dst_running < (dst_weight >> 2));
+	return (running < (weight >> 2));
 }
 
 /*
@@ -9139,12 +9140,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 				return idlest;
 #endif
 			/*
-			 * Otherwise, keep the task on this node to stay close
-			 * its wakeup source and improve locality. If there is
-			 * a real need of migration, periodic load balance will
-			 * take care of it.
+			 * Otherwise, keep the task close to the wakeup source
+			 * and improve locality if the number of running tasks
+			 * would remain below threshold where an imbalance is
+			 * allowed. If there is a real need of migration,
+			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
 				return NULL;
 		}
 
@@ -9350,7 +9352,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, busiest->group_weight);
+				local->sum_nr_running + 1, local->group_weight);
 		}
 
 		return;
-- 
2.31.1

