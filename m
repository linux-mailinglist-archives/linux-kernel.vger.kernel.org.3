Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AC472685
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhLMJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhLMJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:47:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB9C08E6DF;
        Mon, 13 Dec 2021 01:43:16 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:43:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639388593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svqrTD6VHoZJGnE0m0eOVSgUOVPAq5hRF1icC3qt9zI=;
        b=o3cV5E9VRMdMiykjf8WhQKAsI8cXpm+izneDUma8cT8g2FSPHqLlRkFPGtofoBC+cmGXl+
        rdqNIpLPkh58LtSCkBC4GdBRfcjSqTtSkbMmxDx1SVKEolRmRsPj+hrfK9t+DL6OGgKt6s
        VO46srkHFAT1m4Rz3zz6ez4tsbfe8f3HqzbDXd2QOg82Wp4AjymF/kbH/BOVZIC0UgBKrz
        J1La37DTL+bj9hANbCjd1LKK3O/0/GjfSf6stfR4boeG8622aY37VDQl2imAIdGGS3Zwbb
        qeIuXftkvP469iZPv9jdgnr+z0n5p6Fnw6BQYk2z0HhID8g3icV2vpa/lWNyvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639388593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svqrTD6VHoZJGnE0m0eOVSgUOVPAq5hRF1icC3qt9zI=;
        b=vgsYnllc3QLgQ3kZ4JMCAKhMs2FyrRyrWX/0oYpL1vN0g0GUZDVxXQBdulLlXp0+a6fl+K
        Mq7BymV46zXmfSDQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Replace CFS internal cpu_util() with
 cpu_util_cfs()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118164240.623551-1-dietmar.eggemann@arm.com>
References: <20211118164240.623551-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <163938859236.23020.740890235122745442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82762d2af31a60081162890983a83499c9c7dd74
Gitweb:        https://git.kernel.org/tip/82762d2af31a60081162890983a83499c9c7dd74
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 18 Nov 2021 17:42:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:10:00 +01:00

sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs()

cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
the DEADLINE utilization signal") to enable the access to CPU
utilization from the Schedutil CPUfreq governor.

Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
selection") added util_est support later.

The only thing cpu_util() is doing on top of what cpu_util_cfs() already
does is to clamp the return value to the [0..capacity_orig] capacity
range of the CPU. Integrating this into cpu_util_cfs() is not harming
the existing users (Schedutil and CPUfreq cooling (latter via
sched_cpu_util() wrapper)).

For straightforwardness, prefer to keep using `int cpu` as the function
parameter over using `struct rq *rq` which might avoid some calls to
cpu_rq(cpu) -> per_cpu(runqueues, cpu) -> RELOC_HIDE().
Update cfs_util()'s documentation and reuse it for cpu_util_cfs().
Remove cpu_util().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20211118164240.623551-1-dietmar.eggemann@arm.com
---
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              | 71 +++----------------------------
 kernel/sched/sched.h             | 44 +++++++++++++++++--
 4 files changed, 50 insertions(+), 69 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index beaa8be..fe53e51 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7166,7 +7166,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 unsigned long sched_cpu_util(int cpu, unsigned long max)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max,
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), max,
 				  ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e7af188..2677888 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -168,7 +168,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(rq), max,
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac5e554..095b0aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1502,7 +1502,6 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
-static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance,
 					int dst_running, int dst_weight);
 
@@ -1569,7 +1568,7 @@ static void update_numa_stats(struct task_numa_env *env,
 
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
-		ns->util += cpu_util(cpu);
+		ns->util += cpu_util_cfs(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
@@ -3240,7 +3239,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 		 * As is, the util number is not freq-invariant (we'd have to
 		 * implement arch_scale_freq_capacity() for that).
 		 *
-		 * See cpu_util().
+		 * See cpu_util_cfs().
 		 */
 		cpufreq_update_util(rq, flags);
 	}
@@ -5510,11 +5509,9 @@ static inline void hrtick_update(struct rq *rq)
 #endif
 
 #ifdef CONFIG_SMP
-static inline unsigned long cpu_util(int cpu);
-
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
+	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6459,58 +6456,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	return target;
 }
 
-/**
- * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
- * @cpu: the CPU to get the utilization of
- *
- * The unit of the return value must be the one of capacity so we can compare
- * the utilization with the capacity of the CPU that is available for CFS task
- * (ie cpu_capacity).
- *
- * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
- * recent utilization of currently non-runnable tasks on a CPU. It represents
- * the amount of utilization of a CPU in the range [0..capacity_orig] where
- * capacity_orig is the cpu_capacity available at the highest frequency
- * (arch_scale_freq_capacity()).
- * The utilization of a CPU converges towards a sum equal to or less than the
- * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
- * the running time on this CPU scaled by capacity_curr.
- *
- * The estimated utilization of a CPU is defined to be the maximum between its
- * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
- * currently RUNNABLE on that CPU.
- * This allows to properly represent the expected utilization of a CPU which
- * has just got a big task running since a long sleep period. At the same time
- * however it preserves the benefits of the "blocked utilization" in
- * describing the potential for other tasks waking up on the same CPU.
- *
- * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
- * higher than capacity_orig because of unfortunate rounding in
- * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
- * the average stabilizes with the new running time. We need to check that the
- * utilization stays within the range of [0..capacity_orig] and cap it if
- * necessary. Without utilization capping, a group could be seen as overloaded
- * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
- * available capacity. We allow utilization to overshoot capacity_curr (but not
- * capacity_orig) as it useful for predicting the capacity required after task
- * migrations (scheduler-driven DVFS).
- *
- * Return: the (estimated) utilization for the specified CPU
- */
-static inline unsigned long cpu_util(int cpu)
-{
-	struct cfs_rq *cfs_rq;
-	unsigned int util;
-
-	cfs_rq = &cpu_rq(cpu)->cfs;
-	util = READ_ONCE(cfs_rq->avg.util_avg);
-
-	if (sched_feat(UTIL_EST))
-		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
-
-	return min_t(unsigned long, util, capacity_orig_of(cpu));
-}
-
 /*
  * cpu_util_without: compute cpu utilization without any contributions from *p
  * @cpu: the CPU which utilization is requested
@@ -6531,7 +6476,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return cpu_util(cpu);
+		return cpu_util_cfs(cpu);
 
 	cfs_rq = &cpu_rq(cpu)->cfs;
 	util = READ_ONCE(cfs_rq->avg.util_avg);
@@ -6595,7 +6540,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	/*
 	 * Utilization (estimated) can exceed the CPU capacity, thus let's
 	 * clamp to the maximum CPU capacity to ensure consistency with
-	 * the cpu_util call.
+	 * cpu_util.
 	 */
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
@@ -6627,7 +6572,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 		 * During wake-up, the task isn't enqueued yet and doesn't
 		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
 		 * so just add it (if needed) to "simulate" what will be
-		 * cpu_util() after the task has been enqueued.
+		 * cpu_util after the task has been enqueued.
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
@@ -8689,7 +8634,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		struct rq *rq = cpu_rq(i);
 
 		sgs->group_load += cpu_load(rq);
-		sgs->group_util += cpu_util(i);
+		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -9707,7 +9652,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util(cpu_of(rq));
+			util = cpu_util_cfs(i);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eb97115..de53be9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2966,16 +2966,52 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
-static inline unsigned long cpu_util_cfs(struct rq *rq)
+/**
+ * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
+ * @cpu: the CPU to get the utilization for.
+ *
+ * The unit of the return value must be the same as the one of CPU capacity
+ * so that CPU utilization can be compared with CPU capacity.
+ *
+ * CPU utilization is the sum of running time of runnable tasks plus the
+ * recent utilization of currently non-runnable tasks on that CPU.
+ * It represents the amount of CPU capacity currently used by CFS tasks in
+ * the range [0..max CPU capacity] with max CPU capacity being the CPU
+ * capacity at f_max.
+ *
+ * The estimated CPU utilization is defined as the maximum between CPU
+ * utilization and sum of the estimated utilization of the currently
+ * runnable tasks on that CPU. It preserves a utilization "snapshot" of
+ * previously-executed tasks, which helps better deduce how busy a CPU will
+ * be when a long-sleeping task wakes up. The contribution to CPU utilization
+ * of such a task would be significantly decayed at this point of time.
+ *
+ * CPU utilization can be higher than the current CPU capacity
+ * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
+ * of rounding errors as well as task migrations or wakeups of new tasks.
+ * CPU utilization has to be capped to fit into the [0..max CPU capacity]
+ * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
+ * could be seen as over-utilized even though CPU1 has 20% of spare CPU
+ * capacity. CPU utilization is allowed to overshoot current CPU capacity
+ * though since this is useful for predicting the CPU capacity required
+ * after task migrations (scheduler-driven DVFS).
+ *
+ * Return: (Estimated) utilization for the specified CPU.
+ */
+static inline unsigned long cpu_util_cfs(int cpu)
 {
-	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
+	struct cfs_rq *cfs_rq;
+	unsigned long util;
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	if (sched_feat(UTIL_EST)) {
 		util = max_t(unsigned long, util,
-			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
+			     READ_ONCE(cfs_rq->avg.util_est.enqueued));
 	}
 
-	return util;
+	return min(util, capacity_orig_of(cpu));
 }
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
