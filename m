Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6531A514C77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbiD2OQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357581AbiD2OQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:16:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFF820F62
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:13:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B29111FB;
        Fri, 29 Apr 2022 07:13:06 -0700 (PDT)
Received: from localhost.localdomain (FVFF7649Q05P.cambridge.arm.com [10.1.32.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC5693F774;
        Fri, 29 Apr 2022 07:13:04 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v8 2/7] sched/fair: Decay task PELT values during wakeup migration
Date:   Fri, 29 Apr 2022 15:11:43 +0100
Message-Id: <20220429141148.181816-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429141148.181816-1-vincent.donnefort@arm.com>
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before being migrated to a new CPU, a task sees its PELT values
synchronized with rq last_update_time. Once done, that same task will also
have its sched_avg last_update_time reset. This means the time between
the migration and the last clock update will not be accounted for in
util_avg and a discontinuity will appear. This issue is amplified by the
PELT clock scaling. It takes currently one tick after the CPU being idle
to let clock_pelt catching up clock_task.

This is especially problematic for asymmetric CPU capacity systems which
need stable util_avg signals for task placement and energy estimation.

Ideally, this problem would be solved by updating the runqueue clocks
before the migration. But that would require taking the runqueue lock
which is quite expensive [1]. Instead estimate the missing time and update
the task util_avg with that value.

To that end, we need sched_clock_cpu() but it is a costly function. Limit
the usage to the case where the source CPU is idle as we know this is when
the clock is having the biggest risk of being outdated. In this such case,
let's call it cfs_idle_lag the delta time between the rq_clock_pelt value
at rq idle and cfs_rq idle. And rq_idle_lag the delta between "now" and
the rq_clock_pelt at rq idle.

The estimated PELT clock is then:

   last_update_time + (the cfs_rq's last_update_time)
   cfs_idle_lag + (delta between cfs_rq's update and rq's update)
   rq_idle_lag (delta between rq's update and now)

  last_update_time = cfs_rq_clock_pelt()
                   = rq_clock_pelt() - cfs->throttled_clock_pelt_time

  cfs_idle_lag = rq_clock_pelt()@rq_idle -
                 rq_clock_pelt()@cfs_rq_idle

  rq_idle_lag = sched_clock_cpu() - rq_clock()@rq_idle

The rq_clock_pelt() from last_update_time being the same as
rq_clock_pelt()@cfs_rq_idle, we can write:

  estimation = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
               sched_clock_cpu() - rq_clock()@rq_idle

The clocks being not accessible without the rq lock taken, some timestamps
are created:

      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
      rq_clock()@rq_idle             is rq->enter_idle
      cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle

The rq_idle_lqg part of the missing time is however an estimation that
doesn't take into account IRQ and Paravirt time.

[1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index abd1feeec0c2..4e9e0d453a00 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3330,21 +3330,15 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
 }
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+static inline bool load_avg_is_decayed(struct sched_avg *sa)
 {
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
+	if (sa->load_sum)
 		return false;
 
-	if (cfs_rq->avg.util_sum)
+	if (sa->util_sum)
 		return false;
 
-	if (cfs_rq->avg.runnable_sum)
-		return false;
-
-	if (child_cfs_rq_on_list(cfs_rq))
+	if (sa->runnable_sum)
 		return false;
 
 	/*
@@ -3352,9 +3346,23 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
-		      cfs_rq->avg.util_avg ||
-		      cfs_rq->avg.runnable_avg);
+	SCHED_WARN_ON(sa->load_avg ||
+		      sa->util_avg ||
+		      sa->runnable_avg);
+
+	return true;
+}
+
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (!load_avg_is_decayed(&cfs_rq->avg))
+		return false;
+
+	if (child_cfs_rq_on_list(cfs_rq))
+		return false;
 
 	return true;
 }
@@ -3694,6 +3702,79 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void migrate_se_pelt_lag(struct sched_entity *se)
+{
+	u64 throttled = 0, now;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+	bool is_idle;
+
+	if (load_avg_is_decayed(&se->avg))
+		return;
+
+	cfs_rq = cfs_rq_of(se);
+	rq = rq_of(cfs_rq);
+
+	rcu_read_lock();
+	is_idle = is_idle_task(rcu_dereference(rq->curr));
+	rcu_read_unlock();
+
+	/*
+	 * The lag estimation comes with a cost we don't want to pay all the
+	 * time. Hence, limiting to the case where the source CPU is idle and
+	 * we know we are at the greatest risk to have an outdated clock.
+	 */
+	if (!is_idle)
+		return;
+
+	/*
+	 * estimated "now" is:
+	 *   last_update_time + (the cfs_rq's last_update_time)
+	 *   cfs_idle_lag + (delta between cfs_rq's update and rq's update)
+	 *   rq_idle_lag (delta between rq's update and now)
+	 *
+	 *   last_update_time = cfs_rq_clock_pelt()
+	 *                    = rq_clock_pelt() - cfs->throttled_clock_pelt_time
+	 *
+	 *   cfs_idle_lag = rq_clock_pelt()@rq_idle -
+	 *                  rq_clock_pelt()@cfs_rq_idle
+	 *
+	 *   rq_idle_lag = sched_clock_cpu() - rq_clock()@rq_idle
+	 *
+	 *   The rq_clock_pelt() from last_update_time being the same as
+	 *   rq_clock_pelt()@cfs_rq_idle, we can write:
+	 *
+	 *     now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
+	 *           sched_clock_cpu() - rq_clock()@rq_idle
+	 *
+	 *   Where:
+	 *      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
+	 *      rq_clock()@rq_idle             is rq->enter_idle
+	 *      cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle
+	 */
+
+#ifdef CONFIG_CFS_BANDWIDTH
+	throttled = u64_u32_load(cfs_rq->throttled_pelt_idle);
+	/* The clock has been stopped for throttling */
+	if (throttled == U64_MAX)
+		return;
+#endif
+	now = u64_u32_load(rq->clock_pelt_idle);
+	now -= throttled;
+
+	/* An update happened while computing lag */
+	if (now < cfs_rq_last_update_time(cfs_rq))
+		return;
+
+	now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
+
+	__update_load_avg_blocked_se(now, se);
+}
+#else
+static void migrate_se_pelt_lag(struct sched_entity *se) {}
+#endif
+
 /**
  * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
  * @now: current time, as per cfs_rq_clock_pelt()
@@ -4429,6 +4510,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
+
+	if (cfs_rq->nr_running == 0)
+		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
 /*
@@ -6946,6 +7030,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+	struct sched_entity *se = &p->se;
+
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
 	 * deal with this by subtracting the old and adding the new
@@ -6953,7 +7039,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * the task on the new runqueue.
 	 */
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
@@ -6965,25 +7050,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * rq->lock and can modify state directly.
 		 */
 		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(&p->se);
+		detach_entity_cfs_rq(se);
 
 	} else {
+		remove_entity_load_avg(se);
+
 		/*
-		 * We are supposed to update the task to "current" time, then
-		 * its up to date and ready to go to new CPU/cfs_rq. But we
-		 * have difficulty in getting what current time is, so simply
-		 * throw away the out-of-date time. This will result in the
-		 * wakee task is less decayed, but giving the wakee more load
-		 * sounds not bad.
+		 * Here, the task's PELT values have been updated according to
+		 * the current rq's clock. But if that clock hasn't been
+		 * updated in a while, a substantial idle time will be missed,
+		 * leading to an inflation after wake-up on the new rq.
+		 *
+		 * Estimate the missing time from the cfs_rq last_update_time
+		 * and update sched_avg to improve the PELT continuity after
+		 * migration.
 		 */
-		remove_entity_load_avg(&p->se);
+		migrate_se_pelt_lag(se);
 	}
 
 	/* Tell new CPU we are migrated */
-	p->se.avg.last_update_time = 0;
+	se->avg.last_update_time = 0;
 
 	/* We have migrated, no longer consider this task hot */
-	p->se.exec_start = 0;
+	se->exec_start = 0;
 
 	update_scan_period(p, new_cpu);
 }
@@ -8149,6 +8238,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);
 
+			/* sync clock_pelt_idle with last update */
+			if (cfs_rq->nr_running == 0)
+				update_idle_cfs_rq_clock_pelt(cfs_rq);
+
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
 		}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 4ff2ed4f8fa1..9aed92262bd9 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,23 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_pelt - rq->lost_idle_time;
+}
+
+/* The rq is idle, we can sync to clock_task */
+static inline void _update_idle_rq_clock_pelt(struct rq *rq)
+{
+	rq->clock_pelt  = rq_clock_task(rq);
+
+	u64_u32_store(rq->enter_idle, rq_clock(rq));
+	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
+}
+
 /*
  * The clock_pelt scales the time to reflect the effective amount of
  * computation done during the running delta time but then sync back to
@@ -76,8 +93,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 {
 	if (unlikely(is_idle_task(rq->curr))) {
-		/* The rq is idle, we can sync to clock_task */
-		rq->clock_pelt  = rq_clock_task(rq);
+		_update_idle_rq_clock_pelt(rq);
 		return;
 	}
 
@@ -130,17 +146,26 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 */
 	if (util_sum >= divider)
 		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+
+	_update_idle_rq_clock_pelt(rq);
 }
 
-static inline u64 rq_clock_pelt(struct rq *rq)
+#ifdef CONFIG_CFS_BANDWIDTH
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
-	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
-
-	return rq->clock_pelt - rq->lost_idle_time;
+	/*
+	 * Make sure that pending update of rq->clock_pelt_idle and
+	 * rq->enter_idle are visible during update_blocked_average() before
+	 * updating cfs_rq->throttled_pelt_idle.
+	 */
+	smp_wmb();
+	if (unlikely(cfs_rq->throttle_count))
+		u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
+	else
+		u64_u32_store(cfs_rq->throttled_pelt_idle,
+			      cfs_rq->throttled_clock_pelt_time);
 }
 
-#ifdef CONFIG_CFS_BANDWIDTH
 /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
@@ -150,6 +175,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
 #else
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	return rq_clock_pelt(rq_of(cfs_rq));
@@ -204,6 +230,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e2cf6e48b165..ea9365e1a24e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -641,6 +641,10 @@ struct cfs_rq {
 	int			runtime_enabled;
 	s64			runtime_remaining;
 
+	u64			throttled_pelt_idle;
+#ifndef CONFIG_64BIT
+	u64                     throttled_pelt_idle_copy;
+#endif
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
@@ -1013,6 +1017,12 @@ struct rq {
 	u64			clock_task ____cacheline_aligned;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
+	u64			clock_pelt_idle;
+	u64			enter_idle;
+#ifndef CONFIG_64BIT
+	u64			clock_pelt_idle_copy;
+	u64			enter_idle_copy;
+#endif
 
 	atomic_t		nr_iowait;
 
-- 
2.25.1

