Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E524B8710
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiBPLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiBPLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:49:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387C254A6C;
        Wed, 16 Feb 2022 03:49:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso6180760pjt.4;
        Wed, 16 Feb 2022 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDL1Twe60USf2xgj32O/RXOb50fO7TEYwGE3ZcD02zk=;
        b=KnMzaOd+VovKQw2Nl5RMC92jnkyzsrDUqZWcCnGdcMAuIHYguXZ5lA6YoIn3llND2f
         oLBOujP3f+cXshFSbKXy0MHeQjtSuON0B14CaFftLaFlLxE0SbYgMndX2dY7xDNS/cCR
         /OIQ/o9za8388+pEQSX+OYHN57RfnOZxDvaM9xd1uRnfbda7xkcjt7Wz7yWu7ylEjV1a
         IuAlJNauhczUd6K2arLLKFsT4nKmHrqa8AO6hpWnIegcRwP2B8jfnmxOuP+fkzf8hum7
         XzVFQ8VUvjrWEdvEgla4GzPKRb0nnsF7mSvAYkqMafZ3Ero1dLq0uZPlKrSiUsOwI6Kg
         PvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDL1Twe60USf2xgj32O/RXOb50fO7TEYwGE3ZcD02zk=;
        b=Svd1VJJXpvFBIQ5b/ERBLXxix5T+kU4eLHgh4iCmYLR+KraT1AGb7YfRv64l8AdHah
         6d5OBd1GXZ1wTUf49dt4lUmlQlGXkmfxZ30LXXf63AeTFmDX/3T2q+WZxAwnTRCBzOrc
         Q8wRMM+kVuXPl2O7prM08MQENdZA9El02sztwT+nnz4L06xDqT87t5aQJI9UrVScYVn+
         WD3J0rNn2YSjeyh4baSS6AFqkIqkWVHPhJZD6O+8mMzwLz0TsNeMA3SJ83Zrk5kT0SMW
         NuhVMPe9NTMlC8ZnifOjbUpjjdvcMafA5Kot95/0FGneXP8Hou7dkY6cOSYvmXz8QnVd
         tCqA==
X-Gm-Message-State: AOAM533xlhZtr+4PoIOkyr0hJYjk2GmaRjAKbgBf9c6N7zTEzN2p2MsW
        V7PshGrsnRiGLL/V8aOqMJo=
X-Google-Smtp-Source: ABdhPJyYcKg75iUjRIxJJ7O1CYyRuOfPhCNBAy8KUNiwUVO33lBoPNaievp5mhLaCaFm4Lmu05VShw==
X-Received: by 2002:a17:90b:1a85:b0:1b9:fdd7:ae07 with SMTP id ng5-20020a17090b1a8500b001b9fdd7ae07mr1273573pjb.190.1645012181163;
        Wed, 16 Feb 2022 03:49:41 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:40 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 2/6] blk-wbt: make wbt pluggable
Date:   Wed, 16 Feb 2022 19:48:05 +0800
Message-Id: <20220216114809.84551-3-jianchao.wan9@gmail.com>
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

This patch makes wbt pluggable through /sys/block/xxx/queue/qos.
Some queue_lock/unlock is added to protect rq_qos_by_id() in
wbt_rq_qos().

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 -----
 block/blk-wbt.c        | 52 +++++++++++++++++++++++++++++++++++-------
 block/blk-wbt.h        |  7 +++++-
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4da803bf5617..5094c2d3700a 100644
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
index 0c119be0e813..ad637fcf3919 100644
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
 
@@ -802,7 +826,9 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 };
 #endif
 
+int wbt_init(struct request_queue *q);
 static struct rq_qos_ops wbt_rqos_ops = {
+	.name = "wbt",
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
@@ -811,6 +837,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.cleanup = wbt_cleanup,
 	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
+	.init = wbt_init,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
 #endif
@@ -834,9 +861,6 @@ int wbt_init(struct request_queue *q)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -846,7 +870,7 @@ int wbt_init(struct request_queue *q)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	rq_qos_add(q, &rwb->rqos);
+	rq_qos_activate(q, &rwb->rqos, &wbt_rqos_ops);
 	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
@@ -856,3 +880,15 @@ int wbt_init(struct request_queue *q)
 
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
index 2eb01becde8c..998e23f8bb57 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -87,7 +87,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 
 #ifdef CONFIG_BLK_WBT
-
+struct rq_qos *wbt_rq_qos(struct request_queue *q);
 int wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
@@ -101,6 +101,11 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
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

