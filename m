Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2114D1FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349509AbiCHSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348376AbiCHSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:21:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D225855756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:20:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A20A31655;
        Tue,  8 Mar 2022 10:20:17 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.88.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 537CB3FA45;
        Tue,  8 Mar 2022 10:20:16 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 2/7] sched/fair: Decay task PELT values during migration
Date:   Tue,  8 Mar 2022 18:19:52 +0000
Message-Id: <20220308181957.280354-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308181957.280354-1-vincent.donnefort@arm.com>
References: <20220308181957.280354-1-vincent.donnefort@arm.com>
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

Neither clock_task, clock_pelt nor clock can be accessed without the
runqueue lock. The new cfs_rq last_update_lag is therefore created and
encode those three values when the last_update_time value for that very
same cfs_rq is updated.

  last_update_lag = clock - clock_task + clock_pelt

And we can then write the missing time as follow:

  A + B = sched_clock_cpu() - last_update_lag

The B. part of the missing time is however an estimation that doesn't take
into account IRQ and Paravirt time.

Now we have an estimation for A + B, we can create an estimator for the
PELT value at the time of the migration. We need for this purpose to
inject last_update_time which is a combination of both clock_pelt and
lost_idle_time. The latter is a time value which is completely lost form a
PELT point of view and must be ignored. And finally, we can write:

  rq_clock_pelt_estimator() = last_update_time + A + B
                            = last_update_time +
                                   sched_clock_cpu() - last_update_lag

This estimation has a cost, mostly due to sched_clock_cpu(). Limit the
usage to the case where the source CPU is idle as we know this is when the
clock is having the biggest risk of being outdated.

[1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99ea9540ece4..1f83616a44d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3625,6 +3625,22 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void update_cfs_rq_lag(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+
+	u64_u32_store(cfs_rq->last_update_lag,
+#ifdef CONFIG_CFS_BANDWIDTH
+		      /* Timer stopped by throttling */
+		      unlikely(cfs_rq->throttle_count) ? U64_MAX :
+#endif
+		      rq->clock - rq->clock_task + rq->clock_pelt);
+}
+#else
+static void update_cfs_rq_lag(struct cfs_rq *cfs_rq) {}
+#endif
+
 /**
  * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
  * @now: current time, as per cfs_rq_clock_pelt()
@@ -3688,6 +3704,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 			   cfs_rq->last_update_time_copy,
 			   sa->last_update_time);
 #endif
+	update_cfs_rq_lag(cfs_rq);
 
 	return decayed;
 }
@@ -6852,6 +6869,44 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 
 static void detach_entity_cfs_rq(struct sched_entity *se);
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void migrate_se_pelt_lag(struct sched_entity *se)
+{
+	u64 now, last_update_lag;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+	bool is_idle;
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
+	last_update_lag = u64_u32_load(cfs_rq->last_update_lag);
+
+	/* The clock has been stopped for throttling */
+	if (last_update_lag == U64_MAX)
+		return;
+
+	now = se->avg.last_update_time - last_update_lag +
+	      sched_clock_cpu(cpu_of(rq));
+
+	__update_load_avg_blocked_se(now, se);
+}
+#else
+static void migrate_se_pelt_lag(struct sched_entity *se) {}
+#endif
+
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -6859,6 +6914,9 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
 	 * deal with this by subtracting the old and adding the new
@@ -6866,8 +6924,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * the task on the new runqueue.
 	 */
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct sched_entity *se = &p->se;
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
@@ -6878,25 +6934,28 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
+		 * Estimate the missing time from the rq clock and update
+		 * sched_avg to improve the PELT continuity after migration.
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f1a445efdc63..982691ffe9a1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -608,6 +608,12 @@ struct cfs_rq {
 	struct sched_avg	avg;
 #ifndef CONFIG_64BIT
 	u64			last_update_time_copy;
+#endif
+#ifdef CONFIG_NO_HZ_COMMON
+	u64			last_update_lag;
+#ifndef CONFIG_64BIT
+	u64                     last_update_lag_copy;
+#endif
 #endif
 	struct {
 		raw_spinlock_t	lock ____cacheline_aligned;
-- 
2.25.1

