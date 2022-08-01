Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209BA586385
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiHAE3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiHAE2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E1F13E0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso11070748pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvQvdg1vIjzkFTrlMknrP1X+3K0scOovc4jDGCZM+94=;
        b=QIQ9iLPpsRUCeZ1EYh7NYfSGZ48dZtim7NYNjhN4A6WQWl1WLWQuOtjvV5QDVSy79u
         YbHj7i7Lb6QxXmxljjy9Kbc3pAa3ooyd6me8M7DT5GizI6d5vevGtZkwpXD5IPa1ZxxM
         PSGlcSQOojomlOorHSY+mcdduFDViTJzMMWbk9P3CB8sVLd3lkHzLKvJ94h4hWfS7vAf
         Ms0k5S7CYqpVxBvM0Gh7Ohb+XByP4qodVZRydTY1GuhurkhQw8v1GWFQRkUofURVKo7n
         KQkst9vEfLsr1SJu5YN5PfQzNpl0GctoiKo0KkjXUTUTBTdiNazia2oCD0f61WYhtbvU
         QxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvQvdg1vIjzkFTrlMknrP1X+3K0scOovc4jDGCZM+94=;
        b=OeFOdqH5HbcfgsjvtfdfzA62EyozNW9V34yNNZ4olp0wYLjRpkd5Zx1vgXKBtTrBN1
         gMKTygmSKOj1f+GZzOUumtACr9wPNmnFsfs7v8mnmqrmoh9R5BwI6dBK0+M3Gd9amXqc
         fGqX6kV1wjf5RuP90ihaWh4sDKvRMR56+vqDqvEg7XJACAG9JdaciRZ2jpWJCF2QTd2f
         EjrYn0Hd+JTDa3YczF3tpJ8WHiGiSh019uMVThdggrpUwX1wJ3lCx//+OVmAKkMRTZUY
         rUZbvHJz4XxdYbNJ7KONt91SZm6Q1Rgsq0Mxzgc8a4sC0+7RBC3CwGgypnqsN5c5bFWJ
         5CnQ==
X-Gm-Message-State: ACgBeo26fxksZa0nxNe02bxidfncjiv6pZ81rqzF1yjkqXHvKL1EtIaP
        8UwnWlicb8LxvFwl+TkPylBa3A==
X-Google-Smtp-Source: AA6agR4zMUHRA6SGw0k9rjg/qI5h65RxbGjqVMadDKDGilpXXOADiAMOqeRAJ4BIDz8aeCD2uYux3A==
X-Received: by 2002:a17:90a:e7d1:b0:1f5:665:4607 with SMTP id kb17-20020a17090ae7d100b001f506654607mr2242827pjb.77.1659328112261;
        Sun, 31 Jul 2022 21:28:32 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:31 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 08/10] sched/fair: refactor detach/attach_entity_cfs_rq using update_load_avg()
Date:   Mon,  1 Aug 2022 12:27:43 +0800
Message-Id: <20220801042745.7794-9-zhouchengming@bytedance.com>
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

Since update_load_avg() now support DO_ATTACH and DO_DETACH flags to
attach or detach entity sched_avg to the cfs_rq, we can using it to
refactor detach/attach_entity_cfs_rq() functions.

Note we can attach a task with last_update_time!=0 from switched_to_fair()
since we want to decay sched_avg when running in !fair class.

So this patch move last_update_time condition check to enqueue_entity()
for task which migrate CPU or change cgroup.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 68 ++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad20a939227d..b8cb826bd755 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4019,21 +4019,10 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
 
-	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
-		/*
-		 * DO_ATTACH means we're here from enqueue_entity().
-		 * !last_update_time means we've passed through
-		 * migrate_task_rq_fair() indicating we migrated.
-		 *
-		 * IOW we're enqueueing a task on a new CPU.
-		 */
+	if (flags & DO_ATTACH) {
 		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
 	} else if (flags & DO_DETACH) {
-		/*
-		 * DO_DETACH means we're here from dequeue_entity()
-		 * and we are migrating task out of the CPU.
-		 */
 		detach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
 	} else if (decayed) {
@@ -4082,44 +4071,31 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Propagate the changes of the sched_entity across the tg tree to make it
  * visible to the root
  */
-static void propagate_entity_cfs_rq(struct sched_entity *se)
+static void propagate_entity_cfs_rq(struct sched_entity *se, int flags)
 {
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
+	struct cfs_rq *cfs_rq;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		update_load_avg(cfs_rq, se, flags);
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 
 		if (!throttled_hierarchy(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
+
+		flags = UPDATE_TG;
 	}
 }
-#else
-static void propagate_entity_cfs_rq(struct sched_entity *se) { }
-#endif
 
 static void detach_entity_cfs_rq(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
 	/*
 	 * In case the task sched_avg hasn't been attached:
 	 * - A forked task which hasn't been woken up by wake_up_new_task().
@@ -4130,21 +4106,18 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 		return;
 
 	/* Catch up with the cfs_rq and remove our load when we leave */
-	update_load_avg(cfs_rq, se, 0);
-	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
-	propagate_entity_cfs_rq(se);
+	propagate_entity_cfs_rq(se, DO_DETACH | UPDATE_TG);
 }
 
 static void attach_entity_cfs_rq(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	int flags = DO_ATTACH | UPDATE_TG;
+
+	if (!sched_feat(ATTACH_AGE_LOAD))
+		flags |= SKIP_AGE_LOAD;
 
-	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
-	propagate_entity_cfs_rq(se);
+	/* Synchronize entity with its cfs_rq and attach our load */
+	propagate_entity_cfs_rq(se, flags);
 }
 
 static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
@@ -4479,6 +4452,15 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
 	bool curr = cfs_rq->curr == se;
+	int action = UPDATE_TG;
+
+	/*
+	 * !last_update_time means we've passed through migrate_task_rq_fair()
+	 * or task_change_group_fair() indicating we migrated cfs_rq. IOW we're
+	 * enqueueing a task on a new CPU or moving task to a new cgroup.
+	 */
+	if (!se->avg.last_update_time)
+		action |= DO_ATTACH;
 
 	/*
 	 * If we're the current task, we must renormalise before calling
@@ -4507,7 +4489,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 	update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
@@ -4581,6 +4563,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	int action = UPDATE_TG;
 
+	/*
+	 * When we are migrating task out of the CPU, we should
+	 * detach entity sched_avg from the cfs_rq.
+	 */
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
-- 
2.36.1

