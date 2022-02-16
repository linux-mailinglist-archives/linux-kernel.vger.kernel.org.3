Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B5A4B8718
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiBPLuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:50:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiBPLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:50:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667B1CEB29;
        Wed, 16 Feb 2022 03:49:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so6198209pja.3;
        Wed, 16 Feb 2022 03:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRrgwOHWLiM1Q+J4i60wpnw6sWhrdkcW+cGlMVFX6jM=;
        b=GFzblecDliUi6HFrmTuyPU60rqHXFp+G8qiTodPaZMvbFdnRcbNUlbNgpzniJzWOOT
         A64lU+z7qxke0RNVFnqmbWw9wbnDfozkJyIZmhuYiGqLA/rKGq/Q7lCg0AjfuGV+iK0Q
         b0cEAOQrVGlYNDsE6g+bfYqMXQtr7nHAZRo2OKKuwiqgxmZNyeviNAdIKw34WbsUwr7a
         tOpefCBwV6UhXmI2FRndFPel7rOVj2+U/4D6PS/rc8h54qWV+z29+vr9EUnMHuu06I1M
         xCtSLypxDpTZTkW2ncF3VyK3phW/Gz1A10Wb+BGNzU3SWMoCTX1HvATHCAsxsWXRcz9N
         caTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRrgwOHWLiM1Q+J4i60wpnw6sWhrdkcW+cGlMVFX6jM=;
        b=aoMiDu0N1EYN/b7LSYcTb9ugpHmaiXTkHA0gFg5CDjOMmNtedxurSZxOQy5MoAiNF/
         i8nP1DdqOgpx92NM5fIbJxo3gJkT0WDgH3TEH0uUhWw+wwKnPvrH7AfBjSdVxAeG5ejd
         BhDY57dlb0ZmjoQ1rbOAqbjP2EJcH2R0l2tUe6YgoqZ3Gw/1xnSHUfubXH11hNTLNcsV
         uJHkDBq2HVrQENnSXOp4bCrkbT9ScfSuQmxoNogtLRxJq3qNb3cheW9/LdO+MMv+8ZVV
         tbzmd4v7/Cr43xwb6R1jJuUx8GBBsGWRXgk6Y7cUpo7xlddnz0nHjtX/yqhLI5BGqhCZ
         NurQ==
X-Gm-Message-State: AOAM531WqpdsQydQkM6rTHrlg/GM6BQG1Y7KPQgl2NYk/3ai7OdN65p0
        pltYH0aLce3X08AloKk3WVuGVAmry1TIYWcP
X-Google-Smtp-Source: ABdhPJzgDAgMFW1bjTKE3h4NjmPmpSD2L0ngBHK20EB1jYJ2Y8E3MSbHEGcmp53c8sO5W7VbDvFjNg==
X-Received: by 2002:a17:903:1249:b0:14e:e477:5019 with SMTP id u9-20020a170903124900b0014ee4775019mr2181392plh.53.1645012191999;
        Wed, 16 Feb 2022 03:49:51 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:51 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 6/6] blk: export the sysfs for switching qos
Date:   Wed, 16 Feb 2022 19:48:09 +0800
Message-Id: <20220216114809.84551-7-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216114809.84551-1-jianchao.wan9@gmail.com>
References: <20220216114809.84551-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And also remove the unused interfaces.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 10 +-------
 block/blk-rq-qos.h     | 54 ++----------------------------------------
 block/blk-sysfs.c      |  2 ++
 3 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ba43efed3565..9079541e92f1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,11 +823,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
-static const char *rq_qos_id_to_name(enum rq_qos_id id)
-{
-	return "unknown";
-}
-
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 	debugfs_remove_recursive(rqos->debugfs_dir);
@@ -837,9 +832,6 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name;
-
-	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
@@ -848,7 +840,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
+	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
 					       rqos->q->rqos_debugfs_dir);
 
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index bba829bbb461..498abefea9b4 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -13,10 +13,6 @@
 
 struct blk_mq_debugfs_attr;
 
-enum rq_qos_id {
-	RQ_QOS_UNUSED,
-};
-
 struct rq_wait {
 	wait_queue_head_t wait;
 	atomic_t inflight;
@@ -25,7 +21,7 @@ struct rq_wait {
 struct rq_qos {
 	const struct rq_qos_ops *ops;
 	struct request_queue *q;
-	enum rq_qos_id id;
+	int id;
 	refcount_t ref;
 	wait_queue_head_t waitq;
 	bool dying;
@@ -70,7 +66,7 @@ struct rq_depth {
 };
 
 static inline struct rq_qos *rq_qos_id(struct request_queue *q,
-				       enum rq_qos_id id)
+				       int id)
 {
 	struct rq_qos *rqos;
 	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
@@ -99,52 +95,6 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs)
-		blk_mq_debugfs_register_rqos(rqos);
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	blk_mq_debugfs_unregister_rqos(rqos);
-}
-
 int rq_qos_register(struct rq_qos_ops *ops);
 void rq_qos_unregister(struct rq_qos_ops *ops);
 void rq_qos_activate(struct request_queue *q,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f..c02747db4e3b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -574,6 +574,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(queue_qos, "qos");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -633,6 +634,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
+	&queue_qos_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
-- 
2.17.1

