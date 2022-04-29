Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D445155BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380842AbiD2Uj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380825AbiD2UjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:39:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C482D1C;
        Fri, 29 Apr 2022 13:36:03 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:36:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hpobYdb68wtjs4UYIvsEhJTNvi8fFPQosZ65XrwdJM=;
        b=O33cEJPw79As7f0WZ93MaoBbWJqpMbb7uYx1jGiD0vqIOEcx5hfdhfoyIu7gO4xEegyCLx
        SbyaISdX/JE4I+2jUK80Hz6Y1J2251Z7ZfRKP0HP/70TvB5DwqMIru1UZuFkhNnkW0l5Uv
        hW88nlBb1wJnyojOhJtXA2+x7QDLg/8FK655eaBmITKqaG16rtfDhj3Pq01gq38egobt9P
        GqyTYENs2ma/W3MpOM33pHgGMAfWFvT7hIxc5xC1VoXUdaSQ7lqJRAT/18g/eWZvcBiByE
        QJWTPfaO/+gkN+sJL5VBLYXX+1kvL2+m1tVvfU1cc3EETtVddNrJ+bWPqrfbjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hpobYdb68wtjs4UYIvsEhJTNvi8fFPQosZ65XrwdJM=;
        b=ilSHti+gsG3m/GQmb7DNR77r9P7bjZq4qVIgv1zHgbTjCtTe6jMmskdmvRLKdS83uM+My8
        OkAMjZwe9cmZ43CA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Refactor cpu_util_without()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318163656.954440-1-dietmar.eggemann@arm.com>
References: <20220318163656.954440-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <165126456076.4207.12214230176299764349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4e3c7d338a2260406ae22eaf6d77b639d59bdc7e
Gitweb:        https://git.kernel.org/tip/4e3c7d338a2260406ae22eaf6d77b639d59bdc7e
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 18 Mar 2022 17:36:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:29 +02:00

sched/fair: Refactor cpu_util_without()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220318163656.954440-1-dietmar.eggemann@arm.com
---
 kernel/sched/fair.c | 157 +++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 100 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c42012..7d38728 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6544,108 +6544,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -6653,16 +6564,40 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
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
@@ -6671,6 +6606,28 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 }
 
 /*
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
+/*
  * compute_energy(): Estimates the energy that @pd would consume if @p was
  * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
  * landscape of @pd's CPUs after the task migration, and uses the Energy Model
