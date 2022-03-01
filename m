Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2714C914C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiCARSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiCARSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:18:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8E124BC7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:17:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8305E1042;
        Tue,  1 Mar 2022 09:17:40 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6FB43F73D;
        Tue,  1 Mar 2022 09:17:38 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Refactor cpu_util_without()
Date:   Tue,  1 Mar 2022 18:17:27 +0100
Message-Id: <20220301171727.812157-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except the 'task has no contribution or is new' condition at the
beginning of cpu_util_without(), a cpu_util_next(..., dst_cpu = -1)
call can replace the rest of this function.

The UTIL_EST specific check for a race between select_task_rq_fair()
and detach_task() in case of an enqueued or running WF_EXEC task has
to be moved to cpu_util_next().
This was initially introduced by commit c469933e7721
("sched/fair: Fix cpu_util_wake() for 'execl' type workloads").
UnixBench's `execl` throughput tests were run on the dual socket 40
CPUs Intel E5-2690 v2 machine to make sure the regression doesn't
occur again.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

There is still a lot of CPU utilization related code. cpu_util_without()
and cpu_util_next() are very similar. In fact the former can be
refactored to use a call to the latter to be able to remove some
redundancy.

 kernel/sched/fair.c | 143 ++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 84 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 16874e112fe6..c084c2e29e40 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6511,6 +6511,64 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	return target;
 }
 
+/*
+ * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
+ * to @dst_cpu.
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	/*
+	 * If @p migrates from @cpu to another, remove its contribution. Or,
+	 * if @p migrates from another CPU to @cpu, add its contribution. In
+	 * the other cases, @cpu is not impacted by the migration, so the
+	 * util_avg should already be correct.
+	 */
+	if (task_cpu(p) == cpu && dst_cpu != cpu)
+		lsub_positive(&util, task_util(p));
+	else if (task_cpu(p) != cpu && dst_cpu == cpu)
+		util += task_util(p);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * During wake-up, the task isn't enqueued yet and doesn't
+		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
+		 * so just add it (if needed) to "simulate" what will be
+		 * cpu_util after the task has been enqueued.
+		 */
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+
+		/*
+		 * Despite the following checks we still have a small window
+		 * for a possible race, when an execl's select_task_rq_fair()
+		 * races with LB's detach_task():
+		 *
+		 *   detach_task()
+		 *     p->on_rq = TASK_ON_RQ_MIGRATING;
+		 *     ---------------------------------- A
+		 *     deactivate_task()                   \
+		 *       dequeue_task()                     + RaceTime
+		 *         util_est_dequeue()              /
+		 *     ---------------------------------- B
+		 *
+		 * The additional check on "current == p" it's required to
+		 * properly fix the execl regression and it helps in further
+		 * reducing the chances for the above race.
+		 */
+		if (unlikely(task_on_rq_queued(p) || current == p))
+			lsub_positive(&util_est, _task_util_est(p));
+
+		util = max(util, util_est);
+	}
+
+	return min(util, capacity_orig_of(cpu));
+}
+
 /*
  * cpu_util_without: compute cpu utilization without any contributions from *p
  * @cpu: the CPU which utilization is requested
@@ -6526,19 +6584,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  */
 static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
-	struct cfs_rq *cfs_rq;
-	unsigned int util;
-
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		return cpu_util_cfs(cpu);
 
-	cfs_rq = &cpu_rq(cpu)->cfs;
-	util = READ_ONCE(cfs_rq->avg.util_avg);
-
-	/* Discount task's util from CPU's util */
-	lsub_positive(&util, task_util(p));
-
 	/*
 	 * Covered cases:
 	 *
@@ -6560,82 +6609,8 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	 *    estimation of the spare capacity on that CPU, by just
 	 *    considering the expected utilization of tasks already
 	 *    runnable on that CPU.
-	 *
-	 * Cases a) and b) are covered by the above code, while case c) is
-	 * covered by the following code when estimated utilization is
-	 * enabled.
 	 */
-	if (sched_feat(UTIL_EST)) {
-		unsigned int estimated =
-			READ_ONCE(cfs_rq->avg.util_est.enqueued);
-
-		/*
-		 * Despite the following checks we still have a small window
-		 * for a possible race, when an execl's select_task_rq_fair()
-		 * races with LB's detach_task():
-		 *
-		 *   detach_task()
-		 *     p->on_rq = TASK_ON_RQ_MIGRATING;
-		 *     ---------------------------------- A
-		 *     deactivate_task()                   \
-		 *       dequeue_task()                     + RaceTime
-		 *         util_est_dequeue()              /
-		 *     ---------------------------------- B
-		 *
-		 * The additional check on "current == p" it's required to
-		 * properly fix the execl regression and it helps in further
-		 * reducing the chances for the above race.
-		 */
-		if (unlikely(task_on_rq_queued(p) || current == p))
-			lsub_positive(&estimated, _task_util_est(p));
-
-		util = max(util, estimated);
-	}
-
-	/*
-	 * Utilization (estimated) can exceed the CPU capacity, thus let's
-	 * clamp to the maximum CPU capacity to ensure consistency with
-	 * cpu_util.
-	 */
-	return min_t(unsigned long, util, capacity_orig_of(cpu));
-}
-
-/*
- * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
- * to @dst_cpu.
- */
-static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
-{
-	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
-	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
-
-	/*
-	 * If @p migrates from @cpu to another, remove its contribution. Or,
-	 * if @p migrates from another CPU to @cpu, add its contribution. In
-	 * the other cases, @cpu is not impacted by the migration, so the
-	 * util_avg should already be correct.
-	 */
-	if (task_cpu(p) == cpu && dst_cpu != cpu)
-		lsub_positive(&util, task_util(p));
-	else if (task_cpu(p) != cpu && dst_cpu == cpu)
-		util += task_util(p);
-
-	if (sched_feat(UTIL_EST)) {
-		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
-
-		/*
-		 * During wake-up, the task isn't enqueued yet and doesn't
-		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
-		 * so just add it (if needed) to "simulate" what will be
-		 * cpu_util after the task has been enqueued.
-		 */
-		if (dst_cpu == cpu)
-			util_est += _task_util_est(p);
-
-		util = max(util, util_est);
-	}
-
-	return min(util, capacity_orig_of(cpu));
+	return cpu_util_next(cpu, p, -1);
 }
 
 /*
-- 
2.25.1

