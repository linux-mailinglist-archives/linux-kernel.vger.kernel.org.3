Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51814B6C27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiBOMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:38:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBOMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:38:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1E69CF9;
        Tue, 15 Feb 2022 04:38:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z16so12769836pfh.3;
        Tue, 15 Feb 2022 04:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9JKzhlpe/Ryr9ms2ULrsA5843xcMEOd+M5hqm0bYYXA=;
        b=qm6MD0++w0hZN0bSB19UhinnDXYyaH1SnhMuuNtACJIIGCUyGSbOEuxeIYpaDegXEQ
         mgHRhEXex1RzO1els8Hr7qV662qkhFoQYkMFspxtVkNFTEsUlLKF0dp/bME9Cnm4qXfQ
         /x1RPMwZ3NHt/fVIX7bjXfwY3jBB5PHghmI7cM6P4+Kk5tSJOdOeGZ3cafmzR2d+qbIO
         /Jab6E4cCjY+WCXo8Fkfjb272QN/sCuzSS9abto+jhImKvPTaFFbvCy4O5N2hcsCNUqr
         u7fDEYqbe/1NAh9FgTM3neAjlhGaCXXlMDKjAKbgy2y5RFr0esS0UIXBx50E5wn8pKv9
         vKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9JKzhlpe/Ryr9ms2ULrsA5843xcMEOd+M5hqm0bYYXA=;
        b=SSuKeHXi3kzKQ6K/h7UA77PNHgkjwWSrKX7RMuzyIEKEQnY4SaRKYiSVgyb4CdY/6Q
         AzddmfJ4vquU8wHLTslTjbvB+6yUdMZoXWX5YNTGo/2SuJIFYmcj22XyX+FtwEz7xpHE
         TWrRwIaGIh15odWBLGVeqwxobjTyP2mBAihiXhVY8ZCKDyLvK8ujJXQ/xRDu4sx7ZmKj
         MwpqVLd9WaGIAAeWQp5xpWf4VuR5So36BTgZ1ADfcwB1YBoHIcw4LAjri27SHkSeP/Ei
         25i8JKV34xf2R92MDd0GXezlx9geL64rxKa7ASJYDI+hAsdSEypK6s/J9LLHaCTw8b+A
         SDhg==
X-Gm-Message-State: AOAM5301aimTNmP7kv4eJlutUCU9madS+W4cINuDiw1mEQHocbPcWoV4
        YV++BnDHnpNp/twxCowkAvo=
X-Google-Smtp-Source: ABdhPJx2OFRKLyTNHJXkhPRYugtCjFYsaunm4zFTO2Xwa1jnJfgNFWEQqFSBmR/2blKx0AGTcILgyQ==
X-Received: by 2002:a63:1c0d:: with SMTP id c13mr3377334pgc.319.1644928722680;
        Tue, 15 Feb 2022 04:38:42 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:42 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 2/6] blk-wbt: make wbt pluggable
Date:   Tue, 15 Feb 2022 20:37:01 +0800
Message-Id: <20220215123705.58968-3-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215123705.58968-1-jianchao.wan9@gmail.com>
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
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

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  8 ++------
 block/blk-sysfs.c      |  7 ++-----
 block/blk-wbt.c        | 30 +++++++++++++++++++++++++-----
 block/blk-wbt.h        |  8 ++++----
 5 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 30f064872581..c7b17576a65f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,8 +823,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
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
index c02747db4e3b..f9021cf10d06 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -483,11 +483,8 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
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

