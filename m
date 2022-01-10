Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B64894FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiAJJO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbiAJJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDCC0611FD;
        Mon, 10 Jan 2022 01:12:11 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id y9so10592173pgr.11;
        Mon, 10 Jan 2022 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=79z+e8U2E7T+KFfzG2ZOpnjLcxockDrhWWDyySilJSA=;
        b=Xs7/ZrRahdVQa7Nfoz3k+oUc/a8U+WPJCQU5VYGjw2t/JxZv9mct6lTWThtLnxLzkY
         T/yovAq17YyK0Uf72Q9Ai3+32BYsy3NmutJ1hfrx8/0KhTVc+O6UbP8oDWIR7xdNc53b
         rAzXSj6r0jLIs2r3y93FkYkIJ5XCi3hkllrSGsF0pVE8U+5rdndsqKlapBVeVCIQOODb
         LlIRbaZXRs96X3R14jHep/ePxdU8vlB566/T/LVUEKEnb2pH+Dufl9tPG8H/BRHURH+B
         izYTydxJ788WF42awsAfkcs0FPLsmyTQJvN/lbjmlLeSEGRiuX6gHzRQKTw+47cNv986
         2m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=79z+e8U2E7T+KFfzG2ZOpnjLcxockDrhWWDyySilJSA=;
        b=N7NkeA1q/LbTAoNyL3x2PzjaDkPHKNiz5zxcV/VbjLwR1QnPoaVSKx9Gm68qlV9cJk
         dmWhiZN+PSc/sGdwno9eqYnvceQ9Hn4csy1F9JjQXHEVF1ZQEHaw/z0r1+VMJq2m2s2k
         XIwP6xR9ClsoW89moHwqnkH656N+1qEV468q7uPdT72sz5HUnygbtAMgZ3Gs+jcNjPHx
         O66bOGd8a3DhYpquZO+IKnDYSuftodRAfCSoAr3uXDxIvepb3l5K29rmrdBNxa7opFoK
         avvlD2QRZhCkzmebV4RZJvNV/5GWD1YXDwlf6rjxu3Q8D/pK2L//gSBs1NQLAQcgmCEZ
         XYeA==
X-Gm-Message-State: AOAM531bJb165WuPwJ/wNJ84eYCoDg1c/NMJSVxmXWqGrBRHilYhJO0n
        AclPvYHAWqH7uyxXn8T5er8=
X-Google-Smtp-Source: ABdhPJySGRqxk+h5i1Ul+jsHfIYmcDThvDBfPN61ob4u2MUl8JioAd7588dD6VgxCaeKA/jDBlmFoA==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr65556903pgj.607.1641805931117;
        Mon, 10 Jan 2022 01:12:11 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:10 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] blk-wbt: make wbt pluggable
Date:   Mon, 10 Jan 2022 17:10:35 +0800
Message-Id: <20220110091046.17010-3-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

This patch makes wbt pluggable through /sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  8 ++------
 block/blk-sysfs.c      |  7 ++-----
 block/blk-wbt.c        | 30 +++++++++++++++++++++++++-----
 block/blk-wbt.h        |  8 ++++----
 5 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e3e8d54c836f..e225db3c271f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -820,8 +820,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_WBT:
-		return "wbt";
 	case RQ_QOS_LATENCY:
 		return "latency";
 	case RQ_QOS_COST:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index c2b9b41f8fd4..de82eb951bdd 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
@@ -86,11 +85,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 	return rqos;
 }
 
-static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
-{
-	return rq_qos_by_id(q, RQ_QOS_WBT);
-}
-
 static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 {
 	return rq_qos_by_id(q, RQ_QOS_LATENCY);
@@ -158,6 +152,8 @@ ssize_t queue_qos_store(struct request_queue *q, const char *page,
 			  size_t count);
 struct rq_qos *rq_qos_get(struct request_queue *q, int id);
 void rq_qos_put(struct rq_qos *rqos);
+int rq_qos_switch(struct request_queue *q, const struct rq_qos_ops *ops,
+		struct rq_qos *rqos);
 
 static inline struct rq_qos *rq_qos_by_name(struct request_queue *q,
 		const char *name)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 91f980985b1b..12399e491670 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -482,11 +482,8 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 		return -EINVAL;
 
 	rqos = wbt_rq_qos(q);
-	if (!rqos) {
-		ret = wbt_init(q);
-		if (ret)
-			return ret;
-	}
+	if (!rqos)
+		return -EOPNOTSUPP;
 
 	if (val == -1)
 		val = wbt_default_latency_nsec(q);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 88265ae4fa41..ce4b41e50564 100644
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
@@ -656,7 +663,7 @@ void wbt_enable_default(struct request_queue *q)
 		return;
 
 	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
-		wbt_init(q);
+		rq_qos_switch(q, &wbt_rqos_ops, NULL);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -696,6 +703,7 @@ static void wbt_exit(struct rq_qos *rqos)
 	struct rq_wb *rwb = RQWB(rqos);
 	struct request_queue *q = rqos->q;
 
+	rq_qos_deactivate(rqos);
 	blk_stat_remove_callback(q, rwb->cb);
 	blk_stat_free_callback(rwb->cb);
 	kfree(rwb);
@@ -806,7 +814,9 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 };
 #endif
 
+int wbt_init(struct request_queue *q);
 static struct rq_qos_ops wbt_rqos_ops = {
+	.name = "wbt",
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
@@ -815,6 +825,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.cleanup = wbt_cleanup,
 	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
+	.init = wbt_init,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
 #endif
@@ -838,9 +849,6 @@ int wbt_init(struct request_queue *q)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -850,7 +858,7 @@ int wbt_init(struct request_queue *q)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	rq_qos_add(q, &rwb->rqos);
+	rq_qos_activate(q, &rwb->rqos, &wbt_rqos_ops);
 	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
@@ -860,3 +868,15 @@ int wbt_init(struct request_queue *q)
 
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
index 2eb01becde8c..72e9602df330 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,7 +88,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct request_queue *);
+struct rq_qos *wbt_rq_qos(struct request_queue *q);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
@@ -101,12 +101,12 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline void wbt_track(struct request *rq, enum wbt_flags flags)
+static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 {
+	return NULL;
 }
-static inline int wbt_init(struct request_queue *q)
+static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
-	return -EINVAL;
 }
 static inline void wbt_disable_default(struct request_queue *q)
 {
-- 
2.17.1

