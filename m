Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703658C8DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbiHHM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiHHM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96DA19E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x10so8484292plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Za5JZ6apq/3ijjFIXcXnlKC42lXs2Lrgf85Jb4PG6Y=;
        b=SDxIPdLAoVvxJBcCM/Jim1gzMK7Eu+iKdtghi6HplgiyVVSTmEAe4ajs8RGQOmFVVJ
         k1b8CP0blCzByTSoGuvObxROnu4P5ebQ+b+FLM2EB0P2ljlD/cC3gjH/E7gYXDuFwbk/
         SC1ClDRxhgDjiSzf22VfxOfbtPfutFkiiPVYD/LsmuvmTj6K9JBx68lR03NsBkYGfFWO
         xUMAv9fOreAUJobtkJ22eFYLpqGk+Ajo9wTBbqorxxDMX/F3jBjCcSrT11fzF0FN1Qth
         /X6opSe2a30h2m0dDZi0g5ARGxv6ULxI15Ox3pSI8KKFv56vbXBhBxl2csxOOdx+Ul59
         Rqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Za5JZ6apq/3ijjFIXcXnlKC42lXs2Lrgf85Jb4PG6Y=;
        b=I1RzKAjyrk9mRZNzTLhcvjqiS6vbjDyVdIPWdEgBrUtT5rM1sjggrM/nHK73G4DotO
         J6i3eOCmHElmJnRmHg7MBClWc8Jz5Gt8u7trUM6oioeSEXil24PQD9kSfzr5+1bN8qro
         pSa/4s8TKx3Z13tSoGyKhbzwhAXDMhlf9KOqMEQRMHza08h1l9JB6AzOzFO/n0u7FFgj
         AVTz3lIMolDNkpLxD7RYw4jY1MF49523Skmm+nxY3JO5C4IUWlhcrix5niO6k6kVAW6M
         s76wvT8J/wUmg8K+zZ9rmT4TS787IHZ20cCKwhozmAT7n3CXWEgYy9XEcXHrvtjhNpe2
         gYqA==
X-Gm-Message-State: ACgBeo0AmKNKs5/mQiQG++dvweFEj/iGqPs0a4CyIk7OHEksuWsu91Iv
        8WX0l4LIUuo1yNXMl8V9BwZTEXKAFhSrcQ==
X-Google-Smtp-Source: AA6agR5e7h34vecteEXvBc1EI2QK4IWAebohDLEXhBcYxnjr4ih0VmsxqmsvwcXw7PqPXd7QvyXBOg==
X-Received: by 2002:a17:903:41c3:b0:16f:3180:a3c9 with SMTP id u3-20020a17090341c300b0016f3180a3c9mr18475357ple.90.1659963507424;
        Mon, 08 Aug 2022 05:58:27 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:26 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 6/9] sched/fair: fix another detach on unattached task corner case
Date:   Mon,  8 Aug 2022 20:57:42 +0800
Message-Id: <20220808125745.22566-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This patch move detach/attach_entity_cfs_rq() functions up to be together
with other load tracking functions to avoid to use another #ifdef CONFIG_SMP.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 132 +++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f52e7dc7f22d..4bc76d95a99d 100644
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
@@ -4086,6 +4084,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
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
@@ -4308,11 +4371,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -11519,62 +11579,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
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

