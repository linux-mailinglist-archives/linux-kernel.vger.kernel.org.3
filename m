Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E04C2793
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiBXJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiBXJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC319DEBD;
        Thu, 24 Feb 2022 01:08:30 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o26so560683pgb.8;
        Thu, 24 Feb 2022 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQWIdijd8YwqRIfHznzt1wRRlGBAE5pmKuYQxNsoRdY=;
        b=AhWfUFH5g+cUmjdw5aN0o59ZH1C6Hs6qtAYSccQENEhwPFLZfzMzegv6vDLTJzNkUl
         taW0b1N6lmriA7dZ941LEQqrxIGw2NFN1j3PxzlZX5/9Wr8j/boEd5dl35PiHdiJAnfH
         pupr3CcEePDia+1MF/Fbc707XyvHxV5HD84GgQl/t8i6O7BKN89yWiuxBOizQl4eA8r8
         D4AjEmIqufou02R4TBf5bwPeNnZAQkPLFcrLltK2yXOrXHfKbELvy0f++S37e1qLv3sL
         Haax4SnTmWnGBKmRly6lFnK2D643d7EC1TT7J+WhaqfuBE5ae244H6wy7Tt583C8zxfQ
         BQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQWIdijd8YwqRIfHznzt1wRRlGBAE5pmKuYQxNsoRdY=;
        b=no0YjpkzBoOIsHFz2Z0HsH5nCqZhavyAUg0ZhnUyX+LM59pIZQ2pdorZRZR7uv/TME
         pTeQWLxGy2Cg7zNWbHTzk1kakNkMHE+eaxmGSe8VxPncz01Ad0qWElYJSXcER03pAgvH
         ojbevFFQLyHShJ6QCgJ4VMKDEQkarNlgsD/hptpdhy0irDm2JfbERaDPALJldgHRBC4t
         JXrjeghvvds4C+Ndxye6V0i1n/znYc08XmqIxOFb+QnpycYHb7S0IXDfQq4czbPJKuxd
         4iY/EpRLLgZjESaEsyPYTGwaT5F/035VsAQzIN5vKeUkYMQh/dwjNbWBu303+8Z2ldmQ
         eIgg==
X-Gm-Message-State: AOAM532XnKnKtPvyu2kisdAS/ktcz4+a37TQjIvUaIE4ykHCB2vrVmhw
        ivfTZeBzUsJ1u6tgk6Dqgeo=
X-Google-Smtp-Source: ABdhPJydnrUAn3e0HiHtwM3ROWY+XfD2DFDxK3+Kt4DTkObc4fOrvDhAONg9UEzxMjQqyNSkhs2S6g==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr1690820pfm.3.1645693709907;
        Thu, 24 Feb 2022 01:08:29 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:29 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 03/16] blk-wbt: make wbt pluggable
Date:   Thu, 24 Feb 2022 17:06:41 +0800
Message-Id: <20220224090654.54671-4-jianchao.wan9@gmail.com>
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

This patch makes wbt pluggable through /sys/block/xxx/queue/qos.
Some queue_lock/unlock is added to protect rq_qos_by_id() in
wbt_rq_qos(). By default, wbt is enabled which is same with previous
code.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 -----
 block/blk-sysfs.c      |  6 ++---
 block/blk-wbt.c        | 56 +++++++++++++++++++++++++++++++++++++-----
 block/blk-wbt.h        |  6 +++++
 5 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 24d47bc90b4a..073ca7fca9b3 100644
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
index aa6ef12637a0..8ce3f48b16b9 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
@@ -76,11 +75,6 @@ static inline struct rq_qos *rq_qos_id(struct request_queue *q,
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
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f..c713d6b305cc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -463,7 +463,7 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 {
-	if (!wbt_rq_qos(q))
+	if (!wbt_opened(q))
 		return -EINVAL;
 
 	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
@@ -472,7 +472,6 @@ static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 				  size_t count)
 {
-	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
 
@@ -482,8 +481,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	rqos = wbt_rq_qos(q);
-	if (!rqos) {
+	if (!wbt_opened(q)) {
 		ret = wbt_init(q);
 		if (ret)
 			return ret;
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0c119be0e813..44a920d83475 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -31,6 +31,22 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
+static struct rq_qos_ops wbt_rqos_ops;
+
+static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
+{
+	return rq_qos_get(q, wbt_rqos_ops.id);
+}
+
+bool wbt_opened(struct request_queue *q)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+
+	rq_qos_put(rqos);
+
+	return !!rqos;
+}
+
 static inline void wbt_clear_state(struct request *rq)
 {
 	rq->wbt_flags = 0;
@@ -425,19 +441,27 @@ static void wbt_update_limits(struct rq_wb *rwb)
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
+	u64 nsec;
+
 	if (!rqos)
 		return 0;
-	return RQWB(rqos)->min_lat_nsec;
+
+	nsec = RQWB(rqos)->min_lat_nsec;
+	rq_qos_put(rqos);
+
+	return  nsec;
 }
 
 void wbt_set_min_lat(struct request_queue *q, u64 val)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
+
 	if (!rqos)
 		return;
 	RQWB(rqos)->min_lat_nsec = val;
 	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
 	wbt_update_limits(RQWB(rqos));
+	rq_qos_put(rqos);
 }
 
 
@@ -629,8 +653,11 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (rqos)
+
+	if (rqos) {
 		RQWB(rqos)->wc = write_cache_on;
+		rq_qos_put(rqos);
+	}
 }
 
 /*
@@ -644,6 +671,8 @@ void wbt_enable_default(struct request_queue *q)
 	if (rqos) {
 		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
+
+		rq_qos_put(rqos);
 		return;
 	}
 
@@ -692,6 +721,7 @@ static void wbt_exit(struct rq_qos *rqos)
 	struct rq_wb *rwb = RQWB(rqos);
 	struct request_queue *q = rqos->q;
 
+	rq_qos_deactivate(rqos);
 	blk_stat_remove_callback(q, rwb->cb);
 	blk_stat_free_callback(rwb->cb);
 	kfree(rwb);
@@ -704,13 +734,16 @@ void wbt_disable_default(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	struct rq_wb *rwb;
+
 	if (!rqos)
 		return;
+
 	rwb = RQWB(rqos);
 	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
 		blk_stat_deactivate(rwb->cb);
 		rwb->enable_state = WBT_STATE_OFF_DEFAULT;
 	}
+	rq_qos_put(rqos);
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
@@ -803,6 +836,7 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 #endif
 
 static struct rq_qos_ops wbt_rqos_ops = {
+	.name = "wbt",
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
 	.track = wbt_track,
@@ -811,6 +845,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.cleanup = wbt_cleanup,
 	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
+	.init = wbt_init,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
 #endif
@@ -834,9 +869,6 @@ int wbt_init(struct request_queue *q)
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
 
-	rwb->rqos.id = RQ_QOS_WBT;
-	rwb->rqos.ops = &wbt_rqos_ops;
-	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
@@ -846,7 +878,7 @@ int wbt_init(struct request_queue *q)
 	/*
 	 * Assign rwb and add the stats callback.
 	 */
-	rq_qos_add(q, &rwb->rqos);
+	rq_qos_activate(q, &rwb->rqos, &wbt_rqos_ops);
 	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
@@ -856,3 +888,15 @@ int wbt_init(struct request_queue *q)
 
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
index 2eb01becde8c..f128dcf662db 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,6 +88,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
+bool wbt_opened(struct request_queue *q);
 int wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
@@ -101,6 +102,11 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
+bool wbt_opened(struct request_queue *q)
+{
+	return false;
+}
+
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-- 
2.17.1

