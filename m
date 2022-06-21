Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D5552DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbiFUJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348775AbiFUJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:04:29 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81117E2B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:27 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id q13-20020adfab0d000000b0021b831e5b60so2144914wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HewmPXOmppnE+WSwuJjoMY97DEcqVrm8vM9g9IoIsOQ=;
        b=EplJZw4I9tJTp/1Yg+G6BMhFG03nQbMFs8EUYdopmBsnnqlR4mgD0lvx8mqfWXtQ6w
         c3J7BHuzQP3OARsUtVc6gQ28IVS7EGHT7axdM4/pmkIZXZRb6Iv5BRMMAnPj2NlvPLDp
         GN5+uCOk/yt81qs8vb1OejE+n+Tqs8/5yv0lTEjh3akaIykRiKPdNvvQMLHi9et+CL2K
         5DMu5G9a3BU8NKxN0PRS1rxqK72VV6SVxmq9xGXvjczFQ8aFM/+fCEQS0iYmD8aiDoR0
         gpKW7Bdqcm7ZEZLBMTwKhTuMjFm1UOz4Fmw5OnUhat/LvOc6Yd4SrQGTBvMzPt37pzcP
         L6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HewmPXOmppnE+WSwuJjoMY97DEcqVrm8vM9g9IoIsOQ=;
        b=KqNBMoWNpp/VhzPXvvNmbXjbMYFxqqYOQetJFOocS0/dn2BuL2sGnOaej7KoGwVI0Y
         PRN0ixc4/wBy4wEaMSWlPI6FMq/Ia2l+gUgeLikv7GGndq9bd83ERCNZ4viKbccuRnLc
         Bm55qnAZ1+7iweYr8/ZDaveD8Ytuh94fnaxMhfH+dIrudDb/dVIPYCGJX8ZpuqwdJa6s
         F7YARyiOXSEA6mUgt/QlX8LGQktDuSpcEMWp3M5FpJ09+MHQ7zIrAP0NPKbxDQF16bJ3
         i5P925s9dOk6hNdApiYv5w/lKw+MGHF3XDPKnD4Ef98KIQr4sH/KP2Aa3JqTQa4zBXue
         KOig==
X-Gm-Message-State: AOAM530RkJIg2I9ZqugNlH+MhuVx4DyXOkVKLD35EZadZAfzt5ekPiDj
        FJdog60NPnqKWu8R/OLhZSfgkOTKLhk1pTqv
X-Google-Smtp-Source: ABdhPJysd0UauzHB2RFrP2X/NLlaVjpJLMuayRz11adpVO26x6V140jXiBNX4hqFGtd9JS8jLnYGRULl55DvW7EZ
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3516:b0:39c:8091:31b6 with
 SMTP id h22-20020a05600c351600b0039c809131b6mr39443792wmq.164.1655802266271;
 Tue, 21 Jun 2022 02:04:26 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:04:08 +0100
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
Message-Id: <20220621090414.433602-2-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220621090414.433602-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v11 1/7] sched/fair: Provide u64 read for 32-bits arch helper
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78795a997d9c..56e56e2dcf93 100644
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
@@ -3352,6 +3349,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
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
@@ -3462,27 +3464,9 @@ void set_task_rq_fair(struct sched_entity *se,
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
@@ -3835,12 +3819,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
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
 
@@ -3972,27 +3953,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -6960,21 +6920,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
@@ -11425,10 +11372,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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
index 5b14b6b4495d..2b563f2002e6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -521,6 +521,45 @@ struct cfs_bandwidth { };
 
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
@@ -561,7 +600,7 @@ struct cfs_rq {
 	 */
 	struct sched_avg	avg;
 #ifndef CONFIG_64BIT
-	u64			load_last_update_time_copy;
+	u64			last_update_time_copy;
 #endif
 	struct {
 		raw_spinlock_t	lock ____cacheline_aligned;
-- 
2.37.0.rc0.104.g0611611a94-goog

