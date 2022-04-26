Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8D50F9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348481AbiDZKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348556AbiDZKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:12:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB7221F8EA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:35:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF2501424;
        Tue, 26 Apr 2022 02:35:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.41.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A2DE3F73B;
        Tue, 26 Apr 2022 02:35:24 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 2/7] sched/fair: Decay task PELT values during wakeup migration
Date:   Tue, 26 Apr 2022 10:35:01 +0100
Message-Id: <20220426093506.3415588-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426093506.3415588-1-vincent.donnefort@arm.com>
References: <20220426093506.3415588-1-vincent.donnefort@arm.com>
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
the migration and the last clock update (B) will not be accounted for in
util_avg and a discontinuity will appear. This issue is amplified by the
PELT clock scaling. If the clock hasn't been updated while the CPU is
idle, clock_pelt will not be aligned with clock_task and that time (A)
will be also lost.

   ---------|----- A -----|-----------|------- B -----|>
        clock_pelt   clock_task     clock            now

This is especially problematic for asymmetric CPU capacity systems which
need stable util_avg signals for task placement and energy estimation.

Ideally, this problem would be solved by updating the runqueue clocks
before the migration. But that would require taking the runqueue lock
which is quite expensive [1]. Instead estimate the missing time and update
the task util_avg with that value:

  A + B = clock_task - clock_pelt + sched_clock_cpu() - clock

sched_clock_cpu() is a costly functinon. Limit the usage to the case where
the source CPU is idle as we know this is when the clock is having the
biggest risk of being outdated.

Neither clock_task, clock_pelt nor clock can be accessed without the
runqueue lock. We then need to store those values in a timestamp variable
which can be accessed during the migration. rq's enter_idle will give the
wall-clock time when the rq went idle. We have then:

  B = sched_clock_cpu() - rq->enter_idle.

Then, to catch-up the PELT clock scaling (A), two cases:

  * !CFS_BANDWIDTH: We can simply use clock_task(). This value is stored
    in rq's clock_pelt_idle, before the rq enters idle. The estimated time
    is then:

      rq->clock_pelt_idle + sched_clock_cpu() - rq->enter_idle.

  * CFS_BANDWIDTH: We can't catch-up with clock_task because of the
    throttled_clock_task_time offset. cfs_rq's clock_pelt_idle is then
    giving the PELT clock when the cfs_rq becomes idle. This gives:

      A = rq->clock_pelt_idle - cfs_rq->clock_pelt_idle

    And gives the following estimated time:

      cfs_rq->last_update_time +
      rq->clock_pelt_idle - cfs_rq->clock_pelt_idle + (A)
      sched_clock_cpu() - rq->enter_idle (B)

The (B) part of the missing time is however an estimation that doesn't
take into account IRQ and Paravirt time.

[1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index abd1feeec0c2..1256e2c0e2e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3694,6 +3694,48 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void migrate_se_pelt_lag(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+	bool is_idle;
+	u64 now;
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
+#ifdef CONFIG_CFS_BANDWIDTH
+	now = u64_u32_load(cfs_rq->clock_pelt_idle);
+	/* The clock has been stopped for throttling */
+	if (now == U64_MAX)
+		return;
+
+	now += cfs_rq_last_update_time(cfs_rq);
+	now -= u64_u32_load(rq->clock_pelt_idle);
+#else
+	now = u64_u32_load(rq->clock_pelt_idle);
+#endif
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
@@ -4429,6 +4471,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
+
+	if (cfs_rq->nr_running == 0)
+		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
 /*
@@ -6946,6 +6991,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+	struct sched_entity *se = &p->se;
+
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
 	 * deal with this by subtracting the old and adding the new
@@ -6953,7 +7000,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * the task on the new runqueue.
 	 */
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
@@ -6965,25 +7011,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 4ff2ed4f8fa1..0380f750adbe 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -103,6 +103,14 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	rq->clock_pelt += delta;
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_pelt - rq->lost_idle_time;
+}
+
 /*
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
@@ -130,17 +138,24 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 */
 	if (util_sum >= divider)
 		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
-}
 
-static inline u64 rq_clock_pelt(struct rq *rq)
-{
-	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
+	 /* The rq is idle, we can sync with clock_task */
+	rq->clock_pelt = rq_clock_task(rq);
 
-	return rq->clock_pelt - rq->lost_idle_time;
+	u64_u32_store(rq->enter_idle, rq_clock(rq));
+	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
+{
+	if (unlikely(cfs_rq->throttle_count))
+		u64_u32_store(cfs_rq->clock_pelt_idle, U64_MAX);
+	else
+		u64_u32_store(cfs_rq->clock_pelt_idle,
+			      rq_clock_pelt(rq_of(cfs_rq)));
+}
+
 /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
@@ -150,6 +165,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
 #else
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	return rq_clock_pelt(rq_of(cfs_rq));
@@ -204,6 +220,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e2cf6e48b165..07014e8cbae2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -641,6 +641,10 @@ struct cfs_rq {
 	int			runtime_enabled;
 	s64			runtime_remaining;
 
+	u64			clock_pelt_idle;
+#ifndef CONFIG_64BIT
+	u64                     clock_pelt_idle_copy;
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

