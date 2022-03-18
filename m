Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5E4DDF29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiCRQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiCRQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:38:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 220B51AE619
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:37:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DADBC1515;
        Fri, 18 Mar 2022 09:37:08 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F1B13F7B4;
        Fri, 18 Mar 2022 09:37:07 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Refactor cpu_util_without()
Date:   Fri, 18 Mar 2022 17:36:56 +0100
Message-Id: <20220318163656.954440-1-dietmar.eggemann@arm.com>
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
beginning of cpu_util_without(), which it shares with the load and
runnable counterpart functions, a cpu_util_next(..., dst_cpu = -1)
call can replace the rest of it.

The UTIL_EST specific check that task util_est has to be subtracted
from the CPU one in case of an enqueued (or current (to cater for the
wakeup - lb race)) task has to be moved to cpu_util_next().
This was initially introduced by commit c469933e7721
("sched/fair: Fix cpu_util_wake() for 'execl' type workloads").
UnixBench's `execl` throughput tests were run on the dual socket 40
CPUs Intel E5-2690 v2 to make sure it doesn't regress again.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

There is still a lot of CPU utilization related code. cpu_util_without()
and cpu_util_next() are very similar. In fact the former can be
refactored to use a call to the latter to be able to remove some
redundancy.

v1->v2:

(1) Reword comments in cpu_util_next() so they also apply when called
    by cpu_util_without().

(2) Incorporate comment from cpu_util_without() into comments in 
    cpu_util_next().

I kept the '|| current == p' part in the UTIL_EST specific check to
close the wakeup - lb race for WF_EXEC tasks even though I couldn't
recreate it, neither on mainline nor on commit c469933e7721 (v4.20).

 kernel/sched/fair.c | 157 ++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 100 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89d21fda106c..1c3cf84bb81a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6543,108 +6543,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /*
- * cpu_util_without: compute cpu utilization without any contributions from *p
- * @cpu: the CPU which utilization is requested
- * @p: the task which utilization should be discounted
- *
- * The utilization of a CPU is defined by the utilization of tasks currently
- * enqueued on that CPU as well as tasks which are currently sleeping after an
- * execution on that CPU.
- *
- * This method returns the utilization of the specified CPU by discounting the
- * utilization of the specified task, whenever the task is currently
- * contributing to the CPU utilization.
- */
-static unsigned long cpu_util_without(int cpu, struct task_struct *p)
-{
-	struct cfs_rq *cfs_rq;
-	unsigned int util;
-
-	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return cpu_util_cfs(cpu);
-
-	cfs_rq = &cpu_rq(cpu)->cfs;
-	util = READ_ONCE(cfs_rq->avg.util_avg);
-
-	/* Discount task's util from CPU's util */
-	lsub_positive(&util, task_util(p));
-
-	/*
-	 * Covered cases:
-	 *
-	 * a) if *p is the only task sleeping on this CPU, then:
-	 *      cpu_util (== task_util) > util_est (== 0)
-	 *    and thus we return:
-	 *      cpu_util_without = (cpu_util - task_util) = 0
-	 *
-	 * b) if other tasks are SLEEPING on this CPU, which is now exiting
-	 *    IDLE, then:
-	 *      cpu_util >= task_util
-	 *      cpu_util > util_est (== 0)
-	 *    and thus we discount *p's blocked utilization to return:
-	 *      cpu_util_without = (cpu_util - task_util) >= 0
-	 *
-	 * c) if other tasks are RUNNABLE on that CPU and
-	 *      util_est > cpu_util
-	 *    then we use util_est since it returns a more restrictive
-	 *    estimation of the spare capacity on that CPU, by just
-	 *    considering the expected utilization of tasks already
-	 *    runnable on that CPU.
-	 *
-	 * Cases a) and b) are covered by the above code, while case c) is
-	 * covered by the following code when estimated utilization is
-	 * enabled.
-	 */
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
+ * Predicts what cpu_util(@cpu) would return if @p was removed from @cpu
+ * (@dst_cpu = -1) or migrated to @dst_cpu.
  */
 static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
-	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	/*
-	 * If @p migrates from @cpu to another, remove its contribution. Or,
-	 * if @p migrates from another CPU to @cpu, add its contribution. In
-	 * the other cases, @cpu is not impacted by the migration, so the
-	 * util_avg should already be correct.
+	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
+	 * contribution. If @p migrates from another CPU to @cpu add its
+	 * contribution. In all the other cases @cpu is not impacted by the
+	 * migration so its util_avg is already correct.
 	 */
 	if (task_cpu(p) == cpu && dst_cpu != cpu)
 		lsub_positive(&util, task_util(p));
@@ -6652,16 +6563,40 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 		util += task_util(p);
 
 	if (sched_feat(UTIL_EST)) {
+		unsigned long util_est;
+
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
 		/*
-		 * During wake-up, the task isn't enqueued yet and doesn't
-		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
-		 * so just add it (if needed) to "simulate" what will be
-		 * cpu_util after the task has been enqueued.
+		 * During wake-up @p isn't enqueued yet and doesn't contribute
+		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
+		 * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
+		 * has been enqueued.
+		 *
+		 * During exec (@dst_cpu = -1) @p is enqueued and does
+		 * contribute to cpu_rq(cpu)->cfs.util_est.enqueued.
+		 * Remove it to "simulate" cpu_util without @p's contribution.
+		 *
+		 * Despite the task_on_rq_queued(@p) check there is still a
+		 * small window for a possible race when an exec
+		 * select_task_rq_fair() races with LB's detach_task().
+		 *
+		 *   detach_task()
+		 *     deactivate_task()
+		 *       p->on_rq = TASK_ON_RQ_MIGRATING;
+		 *       -------------------------------- A
+		 *       dequeue_task()                    \
+		 *         dequeue_task_fair()              + Race Time
+		 *           util_est_dequeue()            /
+		 *       -------------------------------- B
+		 *
+		 * The additional check "current == p" is required to further
+		 * reduce the race window.
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
+		else if (unlikely(task_on_rq_queued(p) || current == p))
+			lsub_positive(&util_est, _task_util_est(p));
 
 		util = max(util, util_est);
 	}
@@ -6669,6 +6604,28 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	return min(util, capacity_orig_of(cpu));
 }
 
+/*
+ * cpu_util_without: compute cpu utilization without any contributions from *p
+ * @cpu: the CPU which utilization is requested
+ * @p: the task which utilization should be discounted
+ *
+ * The utilization of a CPU is defined by the utilization of tasks currently
+ * enqueued on that CPU as well as tasks which are currently sleeping after an
+ * execution on that CPU.
+ *
+ * This method returns the utilization of the specified CPU by discounting the
+ * utilization of the specified task, whenever the task is currently
+ * contributing to the CPU utilization.
+ */
+static unsigned long cpu_util_without(int cpu, struct task_struct *p)
+{
+	/* Task has no contribution or is new */
+	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return cpu_util_cfs(cpu);
+
+	return cpu_util_next(cpu, p, -1);
+}
+
 /*
  * compute_energy(): Estimates the energy that @pd would consume if @p was
  * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
-- 
2.25.1

