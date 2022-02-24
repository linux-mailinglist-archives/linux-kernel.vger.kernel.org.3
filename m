Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED94C27B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiBXJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiBXJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:58 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11381B0C60;
        Thu, 24 Feb 2022 01:08:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y11so1317590pfa.6;
        Thu, 24 Feb 2022 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fr1oc9aiM5IuazGXh8FH+9jR6J4CALktC/QzvGySMfM=;
        b=EzVYR5sLz7ZtycsqAOHYPCP4Y8VM+OtxWJWvVO/hdJmQHZxZ/IGq7ltR7jhP+IqNPZ
         o6LD0XssBNbTw9wB4PDX8r5MpRs1+BZtVFJdVfplaTouXeJJtWGyL+0vFVTtCTwgD79P
         AdcXUB6VjplvCjR6M5OOnE0GsHd84TL0CAFW5ITFQXnhjchDXcRyfue+/XEqwCEV924b
         hMRhBK94K1TabPCgbsGNPmwe6ifZdziZFATWiMSl6kUCGlY8VXe12bsnla+vc2SEmdFy
         yFDZrLgX7uTBhmv49tThNgISdOVaEuNFmr0Txbtqyef6XD3nwrvyUMT348NwtwrZKCIq
         aVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fr1oc9aiM5IuazGXh8FH+9jR6J4CALktC/QzvGySMfM=;
        b=gBI+OfiTtXEXz+fe0879luTPmj+F7tDw61eR2Giq2iUaC7lqJ7UY0Y9qhcGshP/ay1
         dJvB2fXa0ZLsl0O+lFr6VKulwR1r55tDTkzUZHHTkb4cog0tCdTDcQ+KIOfj9jX8Bopu
         akKnz56bnBR4rO9aKcHT4qdTJrue4g9t1reiYMFTWTfsnPYhrXsdkX/0Kotly/i2+dyb
         Sfyx6DExWONNa/7JzcHPwHS6NB1wH7Gp5kOlfUFwpyIIBIo6UpIQu9/L6O5pQiDpdCkC
         MNUEjdbUDiUrphVxbs6CSNYccUtj3BiiHKY+TgXouJ15CYVJFQZ94y4MWuf0MKlbvHzh
         7sVA==
X-Gm-Message-State: AOAM533KU8k6fp6dO4FBhvvsYTBlegKa8olDievDxFzT7+Po9YRu99gZ
        ZiExl8H0CeqIaaL2BTHtL50=
X-Google-Smtp-Source: ABdhPJwMVtV5k8X6K+5G7sf39AG2sl6lVFr7fy6wo+LNUKWKjgH03Sv7m2rbaXW8ESgDG9m3YkJmlg==
X-Received: by 2002:a63:5f42:0:b0:373:d440:496e with SMTP id t63-20020a635f42000000b00373d440496emr1563283pgb.529.1645693738216;
        Thu, 24 Feb 2022 01:08:58 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:57 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 15/16] blk/rq-qos: move the rqos debugfs code to blk-rq-qos.c
Date:   Thu, 24 Feb 2022 17:06:53 +0800
Message-Id: <20220224090654.54671-16-jianchao.wan9@gmail.com>
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

This is no functional change in this patch.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 42 ++++++------------------------------------
 block/blk-mq-debugfs.h | 17 ++++-------------
 block/blk-rq-qos.c     | 38 +++++++++++++++++++++++++++++++++++---
 block/blk-rq-qos.h     |  1 +
 4 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4c9dafd16a08..71e6a097361b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -13,7 +13,6 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
-#include "blk-rq-qos.h"
 
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
@@ -691,7 +690,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static void debugfs_create_files(struct dentry *parent, void *data,
+void blk_mq_debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	if (IS_ERR_OR_NULL(parent))
@@ -709,7 +708,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	blk_mq_debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
 	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
@@ -742,7 +741,7 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 
-	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
+	blk_mq_debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
 }
 
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -755,7 +754,7 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	blk_mq_debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -802,7 +801,7 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	blk_mq_debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -811,35 +810,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
-void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-{
-	debugfs_remove_recursive(rqos->debugfs_dir);
-	rqos->debugfs_dir = NULL;
-}
-
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
-{
-	struct request_queue *q = rqos->q;
-
-	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
-		return;
-
-	if (!q->rqos_debugfs_dir)
-		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
-							 q->debugfs_dir);
-
-	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
-					       rqos->q->rqos_debugfs_dir);
-
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
-}
-
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
-{
-	debugfs_remove_recursive(q->rqos_debugfs_dir);
-	q->rqos_debugfs_dir = NULL;
-}
-
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 					struct blk_mq_hw_ctx *hctx)
 {
@@ -858,7 +828,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+	blk_mq_debugfs_create_files(hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
 }
 
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index a68aa6041a10..ed805dca934c 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -31,10 +31,8 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q);
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
-
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
-void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
+void blk_mq_debugfs_create_files(struct dentry *parent, void *data,
+				 const struct blk_mq_debugfs_attr *attr);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -78,15 +76,8 @@ static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hc
 {
 }
 
-static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
-{
-}
-
-static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-{
-}
-
-static inline void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
+void blk_mq_debugfs_create_files(struct dentry *parent, void *data,
+				 const struct blk_mq_debugfs_attr *attr)
 {
 }
 #endif
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 236ecb2af845..0572dd584c53 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -295,6 +295,31 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	finish_wait(&rqw->wait, &data.wq);
 }
 
+#ifdef CONFIG_BLK_DEBUG_FS
+static void rq_qos_debugfs_unregister(struct rq_qos *rqos)
+{
+	debugfs_remove_recursive(rqos->debugfs_dir);
+	rqos->debugfs_dir = NULL;
+}
+
+static void rq_qos_debugfs_register(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+
+	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
+		return;
+
+	if (!q->rqos_debugfs_dir)
+		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
+							 q->debugfs_dir);
+
+	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
+					       rqos->q->rqos_debugfs_dir);
+
+	blk_mq_debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+}
+#endif
+
 void rq_qos_exit(struct request_queue *q)
 {
 	/*
@@ -306,7 +331,10 @@ void rq_qos_exit(struct request_queue *q)
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
 	}
-	blk_mq_debugfs_unregister_queue_rqos(q);
+#ifdef CONFIG_BLK_DEBUG_FS
+	debugfs_remove_recursive(q->rqos_debugfs_dir);
+	q->rqos_debugfs_dir = NULL;
+#endif
 }
 
 static struct rq_qos *rq_qos_by_name(struct request_queue *q,
@@ -383,8 +411,10 @@ void rq_qos_activate(struct request_queue *q,
 	}
 	spin_unlock_irq(&q->rqos_lock);
 
+#ifdef CONFIG_BLK_DEBUG_FS
 	if (rqos->ops->debugfs_attrs)
-		blk_mq_debugfs_register_rqos(rqos);
+		rq_qos_debugfs_register(rqos);
+#endif
 }
 
 void rq_qos_deactivate(struct rq_qos *rqos)
@@ -406,7 +436,9 @@ void rq_qos_deactivate(struct rq_qos *rqos)
 		}
 	}
 	spin_unlock_irq(&q->rqos_lock);
-	blk_mq_debugfs_unregister_rqos(rqos);
+#ifdef CONFIG_BLK_DEBUG_FS
+	rq_qos_debugfs_unregister(rqos);
+#endif
 }
 
 static struct rq_qos_ops *rq_qos_op_find(const char *name)
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 3d7df14edde3..463c64d28e8b 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -8,6 +8,7 @@
 #include <linux/atomic.h>
 #include <linux/wait.h>
 #include <linux/blk-mq.h>
+#include <linux/debugfs.h>
 
 #include "blk-mq-debugfs.h"
 
-- 
2.17.1

