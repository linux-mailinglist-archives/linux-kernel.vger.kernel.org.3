Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7E53FEF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbiFGMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiFGMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C637D682D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:36:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a68-20020a25ca47000000b006605f788ff1so11567570ybg.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QWGH4BpFW5q+Xd27ZjfLsMf0ixYVsNcpsXx8SNZqClY=;
        b=kOB2WlHM9Q4hkncQrB1CGU3oEad4K7hDyb2T+NaVPvZ0BxM3cArEKcfyS0NJpANnBN
         0XY4wvuGl2uFI+2wWwnFptl4eLuQkifGCm3u70edruXTmseV3DZMXH0ZZUiq4YLnZnrG
         yQKuEeBedLrEfqoQa40thvzMpuetpThEhda4PL6luUUlM3KeyVEu2+PaNaKSwDxEs9Gd
         6wT21Wikf8ip4AfrHvw2rcjL3hsW5TCDVjE1vyS0exRWpTVaZFHAafaJ5jWymnhTVLgZ
         f7Q4hHQUGzhs13tIFHvLiDwgcUMGC3ITB1mRZ1bppNd5EFVIUXagwhN/PrS+EQvjX4xl
         +SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QWGH4BpFW5q+Xd27ZjfLsMf0ixYVsNcpsXx8SNZqClY=;
        b=x/rPkCTxqbIKy7uQh1P+oxlLswWNHa/C1q7e+X10e1MTDTWQ7iJON9pziEwM+3XkeM
         yuyUrbuTKK/royOW55zXpc48TI98LZdMSVQPZqtDUOWAgpPrIlfXx5c54HKGDRtLpNkv
         EFZ0B9az9MBSz7dk99pBXZ27YwRPyXpdriy81gk0YpyM0VE4ppG3Swd0K78TpvHmFzV+
         wZq1ryFMmOV7Jc8XtqFk5KjvEjXORVG9U0IpGvEL/Ok0zsfJv2MOi+LUrJxjCBIz/Aov
         prQq8ERHmSQKpL233mRo2ssGIWRYcR4J2PpYfbV9M4cgVvPL7LO048sqwBeGz/VQWqc/
         Cw3w==
X-Gm-Message-State: AOAM530WKZkxQ7moIViyLljOncAYpPtpojrkS+GLX20p2HSgP6b2Mj7v
        oJssT2rMCLqXGFZQA2A4oCxQf8SyJ1axCiVQ
X-Google-Smtp-Source: ABdhPJx6oTdQP1KjlaylWO8YxInKy6rT+AvT5zLIlU5TQX1OnI1ysmGyoRXuPcTkIlbxfV6k71uzgWkjJEpi/gAo
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:160a:0:b0:2fe:c81e:f2a9 with SMTP
 id 10-20020a81160a000000b002fec81ef2a9mr31775678yww.282.1654605380505; Tue,
 07 Jun 2022 05:36:20 -0700 (PDT)
Date:   Tue,  7 Jun 2022 13:32:48 +0100
In-Reply-To: <20220607123254.565579-1-vdonnefort@google.com>
Message-Id: <20220607123254.565579-2-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220607123254.565579-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v10 1/7] sched/fair: Provide u64 read for 32-bits arch helper
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
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

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..05614d9b919c 100644
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
@@ -3313,6 +3310,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
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
@@ -3423,27 +3425,9 @@ void set_task_rq_fair(struct sched_entity *se,
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
@@ -3796,12 +3780,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
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
 
@@ -3933,27 +3914,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -11422,10 +11369,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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
index 1f97f357aacd..bf4a0ec98678 100644
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
+		 * paired with u64_u32_store, ordering access		\
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
+	 * paired with u64_u32_load, ordering access to var and		\
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
-- 
2.36.1.255.ge46751e96f-goog

