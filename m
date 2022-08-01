Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D0586382
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiHAE2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbiHAE2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4213E98
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y15so9378159plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VD5PsrnG4Eo2WXx0muZETZVU+kr0DPpaUqCGnet6TY0=;
        b=wg/w1zmVzPXaoyqzfbUFv01AVeSQuUx8CVIjAL6m28X3Udr+v4ZkGmsmO32oYYX60d
         vh4rpephJtA3bHshRJF9m1uW3FvUACwcJabMVkML3DgIFjcHg63KoStgSjGrgTcKUUXB
         u4wMFQeb7W8sD+ZeQj44QHlLsw8an7EGlm9YFj2IbLxy7++Ds/g9G4zMOTNCcgxax7eu
         /a2e5wKtTtEJfmI/9pkBMtR7kw6zaOEHLYNXfMFA0mgJuzwxwlHa2Y52Zsl0XZCZOuja
         526qaxH0fVFmVFs9M8UlovuOJXL8nAoaBNjn3uQ7NtEQzWWLkKYi6IC/QaxcarAej7xF
         tyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VD5PsrnG4Eo2WXx0muZETZVU+kr0DPpaUqCGnet6TY0=;
        b=IAn+Xt1UauDdSrXaMEPykm6Jr42U/69LS8iiZrYEGiC05IzzmsYf5bfX/cC6YIxJoI
         jIzn5sfRPI7JEPScMnrsr+b5w3FiN4vgM6BgbE43dP/ODaOGDazMP82k4/ABEZ/FBc7F
         ePfnsF89ZEAvcDqinPTdp/li24b4Uk4upKFEHtemrqt/ExdAH7rMsKqL0qR6dqSIZga3
         QIN4+o4U9Vo04oXuu2ViZxyU9wUX9RtOWpUTIjsbnFu5nT5ZewYyBGyPNOOXEf3CVS4M
         +5Gj8b35Z3IxoZiQa6HIDeRgT1fJhJONO8Apz3ZbbS7q7hI6qZtTqgEglihL96zJEvpO
         +qGg==
X-Gm-Message-State: ACgBeo2+Hl92TtuVBj6PC2atNjQL2/J22kJuDzv/GfieOGe7LvlyQCwg
        1z7ZVvL4xmghHgxqg0/AOCK+SkwZG16HjA==
X-Google-Smtp-Source: AA6agR6P07LcCCzOCMJXZBS47PS1QPJFgLj2NzynLVaUyXNbNegJoEt57FQ2iktN11CeHV2nQ4LQ4A==
X-Received: by 2002:a17:902:6943:b0:16c:ba81:1842 with SMTP id k3-20020a170902694300b0016cba811842mr14937571plt.24.1659328104223;
        Sun, 31 Jul 2022 21:28:24 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:24 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 06/10] sched/fair: fix another detach on unattached task corner case
Date:   Mon,  1 Aug 2022 12:27:41 +0800
Message-Id: <20220801042745.7794-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
fixed two load tracking problems for new task, including detach on
unattached new task problem.

There still left another detach on unattached task problem for the task
which has been woken up by try_to_wake_up() and waiting for actually
being woken up by sched_ttwu_pending().

try_to_wake_up(p)
  cpu = select_task_rq(p)
  if (task_cpu(p) != cpu)
    set_task_cpu(p, cpu)
      migrate_task_rq_fair()
        remove_entity_load_avg()       --> unattached
        se->avg.last_update_time = 0;
      __set_task_cpu()
  ttwu_queue(p, cpu)
    ttwu_queue_wakelist()
      __ttwu_queue_wakelist()

task_change_group_fair()
  detach_task_cfs_rq()
    detach_entity_cfs_rq()
      detach_entity_load_avg()   --> detach on unattached task
  set_task_rq()
  attach_task_cfs_rq()
    attach_entity_cfs_rq()
      attach_entity_load_avg()

The reason of this problem is similar, we should check in detach_entity_cfs_rq()
that se->avg.last_update_time != 0, before do detach_entity_load_avg().

This patch move detach/attach_entity_cfs_rq() functions upper to be
together with other load tracking functions to avoid to use another
CONFIG_SMP, which also simplify the code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 133 ++++++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba8b937854b4..a32da4e71ddf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -874,9 +874,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 void post_init_entity_util_avg(struct task_struct *p)
 {
 }
-static void update_tg_load_avg(struct cfs_rq *cfs_rq)
-{
-}
 #endif /* CONFIG_SMP */
 
 /*
@@ -3176,6 +3173,7 @@ void reweight_task(struct task_struct *p, int prio)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -4022,7 +4020,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	decayed |= propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
-
 		/*
 		 * DO_ATTACH means we're here from enqueue_entity().
 		 * !last_update_time means we've passed through
@@ -4085,6 +4082,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+/*
+ * Propagate the changes of the sched_entity across the tg tree to make it
+ * visible to the root
+ */
+static void propagate_entity_cfs_rq(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	if (cfs_rq_throttled(cfs_rq))
+		return;
+
+	if (!throttled_hierarchy(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+
+	/* Start to propagate at parent */
+	se = se->parent;
+
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+
+		update_load_avg(cfs_rq, se, UPDATE_TG);
+
+		if (cfs_rq_throttled(cfs_rq))
+			break;
+
+		if (!throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
+	}
+}
+#else
+static void propagate_entity_cfs_rq(struct sched_entity *se) { }
+#endif
+
+static void detach_entity_cfs_rq(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	/*
+	 * In case the task sched_avg hasn't been attached:
+	 * - A forked task which hasn't been woken up by wake_up_new_task().
+	 * - A task which has been woken up by try_to_wake_up() but is
+	 *   waiting for actually being woken up by sched_ttwu_pending().
+	 */
+	if (!se->avg.last_update_time)
+		return;
+
+	/* Catch up with the cfs_rq and remove our load when we leave */
+	update_load_avg(cfs_rq, se, 0);
+	detach_entity_load_avg(cfs_rq, se);
+	update_tg_load_avg(cfs_rq);
+	propagate_entity_cfs_rq(se);
+}
+
+static void attach_entity_cfs_rq(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	/* Synchronize entity with its cfs_rq */
+	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
+	attach_entity_load_avg(cfs_rq, se);
+	update_tg_load_avg(cfs_rq);
+	propagate_entity_cfs_rq(se);
+}
+
 static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->avg.runnable_avg;
@@ -4307,11 +4369,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
-
-static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
-static inline void
-detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
+static inline void detach_entity_cfs_rq(struct sched_entity *se) {}
+static inline void attach_entity_cfs_rq(struct sched_entity *se) {}
 
 static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 {
@@ -11522,62 +11581,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	return false;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-/*
- * Propagate the changes of the sched_entity across the tg tree to make it
- * visible to the root
- */
-static void propagate_entity_cfs_rq(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
-		list_add_leaf_cfs_rq(cfs_rq);
-
-	/* Start to propagate at parent */
-	se = se->parent;
-
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
-	}
-}
-#else
-static void propagate_entity_cfs_rq(struct sched_entity *se) { }
-#endif
-
-static void detach_entity_cfs_rq(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-	/* Catch up with the cfs_rq and remove our load when we leave */
-	update_load_avg(cfs_rq, se, 0);
-	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
-	propagate_entity_cfs_rq(se);
-}
-
-static void attach_entity_cfs_rq(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
-	propagate_entity_cfs_rq(se);
-}
-
 static void detach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-- 
2.36.1

