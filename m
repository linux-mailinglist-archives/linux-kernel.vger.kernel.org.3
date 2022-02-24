Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD34C27A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiBXJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiBXJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C501A1282;
        Thu, 24 Feb 2022 01:08:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so1440966pjb.3;
        Thu, 24 Feb 2022 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AuluerhpzeQIcBXmxiBmKQ+X+SpLxPtw1drteUshKMY=;
        b=B2diqjSOxXtUCjEFhM9V1IP0uJtCxJ/TqFRZCDy2av2INUqUHZ1PxgCwcSIDErdVJf
         VDePKC4SNejNwqEI8EBvVTzNHqWQSSyAqZbLZdal2KKCxifyERQW0QsN8oNa1B82lV44
         Z8XqIgBlONPQm5L/N2CGxKpV4VFeFsdGV+Zc8zSG6SWo+tniMocR1T5OiccJhiEsQozi
         3CrWr1cR676duJPQIsEcTEv7tFu/mPiAov4OEubS2y5ZrNexWCkPfV6ID1CsAQkDSDcb
         yMsIH3imLIysxfuUL90osoYoUSMZplP9NP54UYy6jzV1etkv4h2w6EZr52g0M88R8VI2
         O0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AuluerhpzeQIcBXmxiBmKQ+X+SpLxPtw1drteUshKMY=;
        b=QmWkpnz8fJfpb+moKLmH2Fa9kzYxXP5TS9x4xjTsgNOeF5AkEkedA63Qzt2l0tPwDq
         Z3tH15w9XK0J9t78A4h0QVGnmX7FBSj/Xv9Pr/4YFiegfRuw6nnR/qbnCBfRHN9Sf9bM
         8ZIqFB7pWz2gIc+7td0Hj6MuuNHP0ZSPsy+AHoizIsfS/Z8lciDyAtP1y+o0CG3lsugc
         4Rgdk9BQLv6wgnPG75x+dswKkdes9TkvLwBU4yb/lRdW6un+Tasp96Q7dVn6Qv/G4jiL
         uXFjxxTFu2sTSsuOjRI05dg6GRqnqN/4yqZ/jnZM4zpA1vUJNMMzf7xI33plCm9iRB6o
         jrqw==
X-Gm-Message-State: AOAM5319sUlK7xiA/f3tTD9FVG1/Uuha9hCylWR8F2sIMPcrWcXCW91P
        J49U0zuulL+dTV5QheCUpyI=
X-Google-Smtp-Source: ABdhPJyKcGQ/MMv3EJApvBJPC0uD3mXlsGUvdxgYc5F8cVlPdCxKX9Nli4oqtFUeeuG9L/bm7W+tfQ==
X-Received: by 2002:a17:902:e883:b0:14f:fa85:2af2 with SMTP id w3-20020a170902e88300b0014ffa852af2mr1629520plg.40.1645693718789;
        Thu, 24 Feb 2022 01:08:38 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:38 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 07/16] blk/rq-qos: get rid of unused interfaces of rqos
Date:   Thu, 24 Feb 2022 17:06:45 +0800
Message-Id: <20220224090654.54671-8-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes here

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 13 +--------
 block/blk-rq-qos.h     | 63 +-----------------------------------------
 2 files changed, 2 insertions(+), 74 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a35f2d6dd422..7e3c3cc1b1a9 100644
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
@@ -837,12 +832,6 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name;
-
-	if (rqos->ops->name)
-		dir_name = rqos->ops->name;
-	else
-		dir_name = rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
@@ -851,7 +840,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
+	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
 					       rqos->q->rqos_debugfs_dir);
 
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 5a26eb128456..58aba16c7d32 100644
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
@@ -62,69 +58,12 @@ struct rq_depth {
 	unsigned int default_depth;
 };
 
-static inline struct rq_qos *rq_qos_id(struct request_queue *q,
-				       enum rq_qos_id id)
-{
-	struct rq_qos *rqos;
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->id == id)
-			break;
-	}
-	return rqos;
-}
-
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
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
-- 
2.17.1

