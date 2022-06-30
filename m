Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E64562EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiGAIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiGAItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850110563;
        Fri,  1 Jul 2022 01:48:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1RczVcR2w2M2J6hcA0P3igvEMpy4P58hHI7DTqqesM=;
        b=T7HNK/wubtXLmmpvDbbZ7LJkD74guNkYkeGyN1tZ2ZBG0lyHSZAHffqsa3BaJGfABW4pM/
        ZOOAfimDZG31pSSpEGbhNFT2QEr3uqpqwia0SgHLp6hOaHGSELPWPZTeMzhRUEKmk4cwl/
        lp1GC4fVd0WNPu3TP0WbEqWdI3xSYZ91H4KiQ0df4PPzuc+oZedeplie8rQ9NYdlfn5y2o
        rZ2ZlPUg8pzKhE9JP2wntLmY9ZrokeuIRrxvA1b+SGCQdcE7lmhQyPzUkhaq4qcAXew9WF
        EYicT1y9OGZ+vI7NnvvdK/1VG/P9VQQ/xd11Rz+eaHeuFmc3Oo7hZxddQpR8vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1RczVcR2w2M2J6hcA0P3igvEMpy4P58hHI7DTqqesM=;
        b=OwIfj7+4lGwB4Pv+0ASJLY+cfuH6zWdPhF4ZascKUoGgGkPeEGFb69Z4JIgAvb4Txm9DKM
        5KzKBeTkCuVOyvDA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Provide u64 read for 32-bits arch helper
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621090414.433602-2-vdonnefort@google.com>
References: <20220621090414.433602-2-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <165660183873.15455.5943024107040202491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d05b43059dfa115037cd37bc276a8316391def28
Gitweb:        https://git.kernel.org/tip/d05b43059dfa115037cd37bc276a8316391def28
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 21 Jun 2022 10:04:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:46 +02:00

sched/fair: Provide u64 read for 32-bits arch helper

Introducing macro helpers u64_u32_{store,load}() to factorize lockless
accesses to u64 variables for 32-bits architectures.

Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
accommodate the later where the copy lies outside of the structure
(cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
use the _copy() version of those helpers.

Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
therefore, have a small penalty for 32-bits machines in set_task_rq_fair()
and init_cfs_rq().

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20220621090414.433602-2-vdonnefort@google.com
---
 kernel/sched/fair.c  | 84 +++++++------------------------------------
 kernel/sched/sched.h | 41 ++++++++++++++++++++-
 2 files changed, 54 insertions(+), 71 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f80ae86..8dc0903 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -612,11 +612,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
-#ifndef CONFIG_64BIT
-	smp_wmb();
-	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
-#endif
+	u64_u32_store(cfs_rq->min_vruntime,
+		      max_vruntime(cfs_rq->min_vruntime, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -3348,6 +3345,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
+	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
+				 cfs_rq->last_update_time_copy);
+}
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
@@ -3458,27 +3460,9 @@ void set_task_rq_fair(struct sched_entity *se,
 	if (!(se->avg.last_update_time && prev))
 		return;
 
-#ifndef CONFIG_64BIT
-	{
-		u64 p_last_update_time_copy;
-		u64 n_last_update_time_copy;
-
-		do {
-			p_last_update_time_copy = prev->load_last_update_time_copy;
-			n_last_update_time_copy = next->load_last_update_time_copy;
-
-			smp_rmb();
-
-			p_last_update_time = prev->avg.last_update_time;
-			n_last_update_time = next->avg.last_update_time;
+	p_last_update_time = cfs_rq_last_update_time(prev);
+	n_last_update_time = cfs_rq_last_update_time(next);
 
-		} while (p_last_update_time != p_last_update_time_copy ||
-			 n_last_update_time != n_last_update_time_copy);
-	}
-#else
-	p_last_update_time = prev->avg.last_update_time;
-	n_last_update_time = next->avg.last_update_time;
-#endif
 	__update_load_avg_blocked_se(p_last_update_time, se);
 	se->avg.last_update_time = n_last_update_time;
 }
@@ -3831,12 +3815,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	}
 
 	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
-
-#ifndef CONFIG_64BIT
-	smp_wmb();
-	cfs_rq->load_last_update_time_copy = sa->last_update_time;
-#endif
-
+	u64_u32_store_copy(sa->last_update_time,
+			   cfs_rq->last_update_time_copy,
+			   sa->last_update_time);
 	return decayed;
 }
 
@@ -3968,27 +3949,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	}
 }
 
-#ifndef CONFIG_64BIT
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-	u64 last_update_time_copy;
-	u64 last_update_time;
-
-	do {
-		last_update_time_copy = cfs_rq->load_last_update_time_copy;
-		smp_rmb();
-		last_update_time = cfs_rq->avg.last_update_time;
-	} while (last_update_time != last_update_time_copy);
-
-	return last_update_time;
-}
-#else
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->avg.last_update_time;
-}
-#endif
-
 /*
  * Synchronize entity load avg of dequeued entity without locking
  * the previous rq.
@@ -6968,21 +6928,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
 		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		u64 min_vruntime;
-
-#ifndef CONFIG_64BIT
-		u64 min_vruntime_copy;
-
-		do {
-			min_vruntime_copy = cfs_rq->min_vruntime_copy;
-			smp_rmb();
-			min_vruntime = cfs_rq->min_vruntime;
-		} while (min_vruntime != min_vruntime_copy);
-#else
-		min_vruntime = cfs_rq->min_vruntime;
-#endif
 
-		se->vruntime -= min_vruntime;
+		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
 
 	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
@@ -11508,10 +11455,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
-#ifndef CONFIG_64BIT
-	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
-#endif
+	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 02c9705..8a3c8a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -520,6 +520,45 @@ struct cfs_bandwidth { };
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+/*
+ * u64_u32_load/u64_u32_store
+ *
+ * Use a copy of a u64 value to protect against data race. This is only
+ * applicable for 32-bits architectures.
+ */
+#ifdef CONFIG_64BIT
+# define u64_u32_load_copy(var, copy)       var
+# define u64_u32_store_copy(var, copy, val) (var = val)
+#else
+# define u64_u32_load_copy(var, copy)					\
+({									\
+	u64 __val, __val_copy;						\
+	do {								\
+		__val_copy = copy;					\
+		/*							\
+		 * paired with u64_u32_store_copy(), ordering access	\
+		 * to var and copy.					\
+		 */							\
+		smp_rmb();						\
+		__val = var;						\
+	} while (__val != __val_copy);					\
+	__val;								\
+})
+# define u64_u32_store_copy(var, copy, val)				\
+do {									\
+	typeof(val) __val = (val);					\
+	var = __val;							\
+	/*								\
+	 * paired with u64_u32_load_copy(), ordering access to var and	\
+	 * copy.							\
+	 */								\
+	smp_wmb();							\
+	copy = __val;							\
+} while (0)
+#endif
+# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
+# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -560,7 +599,7 @@ struct cfs_rq {
 	 */
 	struct sched_avg	avg;
 #ifndef CONFIG_64BIT
-	u64			load_last_update_time_copy;
+	u64			last_update_time_copy;
 #endif
 	struct {
 		raw_spinlock_t	lock ____cacheline_aligned;
