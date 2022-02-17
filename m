Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833584B967C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiBQDPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:15:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiBQDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31627828C;
        Wed, 16 Feb 2022 19:15:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d17so3885117pfl.0;
        Wed, 16 Feb 2022 19:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PO6QTLbmwgbeaFwMxrG1oK4/zim0ER7h1OgHbUIGmY0=;
        b=oQ0Ucfn9bqRVTFBOaKmocHV/p32+MGGIHIoYQ+AafT0IPac6LOqUNkk4/oF37YEQdJ
         KI+r7qsi+VmP9NF/Q2ot5b2U7mb2YRy6DABAsyn9z3PnmW3+8VPpwgbyt7Zhc6mVhz7T
         MccuSJ2KAkC6JUXs8pPGwKnjdlzVaOz7YX9tapKRj5DPS436JHjrK+F9tQQko3ZFPj/J
         xw/JqIY1NIQNC7GQn4qCRhNEkUB6hpCS/fGS2auidZyHjjNuX9Uv9Nibgn4r+5FbwlRY
         oW5tiCvSyaFSh4uaScKHGKeTSyVP9uTZs+VIbo9pZ06xyNgRJtQO3ouO7nd/kBxEYMyF
         OiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PO6QTLbmwgbeaFwMxrG1oK4/zim0ER7h1OgHbUIGmY0=;
        b=f/FBwqFOoLpE6T6Jpl8CCDFL/Zn+sY73DUXE71u1pizDgSslCsTVXsRIpdHHPK7T1O
         +7bKvEGFXMaBvrlVWiChb2CNZip+Sk6D6L/qUHB+Kie/FXbePG74St3ZC2WxMn+N7iiU
         ChmeZJZDQ7tGeitqWTvg2v0V1U9N0HeQu0UpHH7rsU2Qbu6QZ8RjfFyqMq47FK48e+ts
         PT4zG4SunZxs1mLnKOpj2Mr+RUWz4WZgYqZOFG2xg59QWcrqv2RL3yXYVDSw70ulqCTL
         i2nd4GWNAWc1OglzmQO0hbP1ConZwhlhZ2aHt+XcQJoo87Fh6jFbSGdIGYoGboKH30O5
         zAGg==
X-Gm-Message-State: AOAM530P64QYT0VbkPX2ORE4hGH8u7rZJqdpO3OHW6T0VIMmT6NGjgya
        bed0uTUXux9qKexJjOaAfzM=
X-Google-Smtp-Source: ABdhPJzGnKO9bHzhlkTtZOmhohr0GcwQTUiU9fD8GGJauE6Xj2rLY/lcHMYTLzlagh6l9poPqhxyYw==
X-Received: by 2002:a63:d116:0:b0:372:9961:4203 with SMTP id k22-20020a63d116000000b0037299614203mr830923pgg.361.1645067720415;
        Wed, 16 Feb 2022 19:15:20 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id cu21sm421018pjb.50.2022.02.16.19.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:15:20 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V4 2/6] blk-wbt: make wbt pluggable
Date:   Thu, 17 Feb 2022 11:13:45 +0800
Message-Id: <20220217031349.98561-3-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217031349.98561-1-jianchao.wan9@gmail.com>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes wbt pluggable through /sys/block/xxx/queue/qos.
Some queue_lock/unlock is added to protect rq_qos_by_id() in
wbt_rq_qos(). By default, wbt is enabled which is same with previous
code.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 -----
 block/blk-wbt.c        | 51 +++++++++++++++++++++++++++++++++++-------
 block/blk-wbt.h        |  6 +++++
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8b6d557e1ad6..a5d78b094234 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -826,8 +826,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_WBT:
-		return "wbt";
 	case RQ_QOS_LATENCY:
 		return "latency";
 	case RQ_QOS_COST:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 586c3f5ec152..171a83d6de45 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
@@ -96,11 +95,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 	return rqos;
 }
 
-static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
-{
-	return rq_qos_id(q, RQ_QOS_WBT);
-}
-
 static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 {
 	return rq_qos_id(q, RQ_QOS_LATENCY);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0c119be0e813..8aa85303bbbc 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -31,6 +31,13 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
+static struct rq_qos_ops wbt_rqos_ops;
+
+struct rq_qos *wbt_rq_qos(struct request_queue *q)
+{
+	return rq_qos_by_id(q, wbt_rqos_ops.id);
+}
+
 static inline void wbt_clear_state(struct request *rq)
 {
 	rq->wbt_flags = 0;
@@ -628,9 +635,13 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 
 void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = wbt_rq_qos(q);
 	if (rqos)
 		RQWB(rqos)->wc = write_cache_on;
+	spin_unlock_irq(&q->queue_lock);
 }
 
 /*
@@ -638,14 +649,20 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
  */
 void wbt_enable_default(struct request_queue *q)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = wbt_rq_qos(q);
 
 	/* Throttling already enabled? */
 	if (rqos) {
 		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
+
+		spin_unlock_irq(&q->queue_lock);
 		return;
 	}
+	spin_unlock_irq(&q->queue_lock);
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
@@ -692,6 +709,7 @@ static void wbt_exit(struct rq_qos *rqos)
 	struct rq_wb *rwb = RQWB(rqos);
 	struct request_queue *q = rqos->q;
 
+	rq_qos_deactivate(rqos);
 	blk_stat_remove_callback(q, rwb->cb);
 	blk_stat_free_callback(rwb->cb);
 	kfree(rwb);
@@ -702,15 +720,21 @@ static void wbt_exit(struct rq_qos *rqos)
  */
 void wbt_disable_default(struct request_queue *q)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
 	struct rq_wb *rwb;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = wbt_rq_qos(q);
 	if (!rqos)
-		return;
+		goto out;
+
 	rwb = RQWB(rqos);
 	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
 		blk_stat_deactivate(rwb->cb);
 		rwb->enable_state = WBT_STATE_OFF_DEFAULT;
 	}
+out:
+	spin_unlock_irq(&q->queue_lock);
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
@@ -803,6 +827,7 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 #endif
 
 static struct rq_qos_ops wbt_rqos_ops = {
+	.name = "blk-wbt",
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
@@ -811,6 +836,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.cleanup = wbt_cleanup,
 	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
+	.init = wbt_init,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
 #endif
@@ -834,9 +860,6 @@ int wbt_init(struct request_queue *q)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -846,7 +869,7 @@ int wbt_init(struct request_queue *q)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	rq_qos_add(q, &rwb->rqos);
+	rq_qos_activate(q, &rwb->rqos, &wbt_rqos_ops);
 	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
@@ -856,3 +879,15 @@ int wbt_init(struct request_queue *q)
 
 	return 0;
 }
+
+static __init int wbt_mod_init(void)
+{
+	return rq_qos_register(&wbt_rqos_ops);
+}
+
+static __exit void wbt_mod_exit(void)
+{
+	return rq_qos_unregister(&wbt_rqos_ops);
+}
+module_init(wbt_mod_init);
+module_exit(wbt_mod_exit);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 2eb01becde8c..e0d051cb00f7 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,6 +88,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
+struct rq_qos *wbt_rq_qos(struct request_queue *q);
 int wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
@@ -101,6 +102,11 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
+static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
+{
+	return NULL;
+}
+
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-- 
2.17.1

