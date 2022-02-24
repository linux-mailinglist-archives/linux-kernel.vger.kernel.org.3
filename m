Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C94C27B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiBXJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiBXJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CD19E735;
        Thu, 24 Feb 2022 01:08:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gi6so1456566pjb.1;
        Thu, 24 Feb 2022 01:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zmbcy8aiObBrWmKB+z0WqF9bDwGnayIFUcTM4Axg/fA=;
        b=LcNwVTnKozs+rJz/BMRG8xRvtwNcoVmqfMhAjUJh4orXsGpK2VOUDowIyx9TLZ7aMx
         cSLJ9GFHHplDBLZFFOU4RSsBUEED9+drOUOuBsRYiG/GwqHJhQeG3AlJkW1Ug7v6nRF0
         Kdsm5CzR+hiwuZojBg3/hE7R81kGJacnyFI6/7iTWfr7iQs4JVGPQOyNqVFqVyZqrynk
         /kJxSTh2dj/N5zUzIbq0w8PNIsaPGiR+IfBgi8Ma0IqxMzR6mQztd3TakvBqzP+Fwr7V
         eKpwuCG1vZlegNyBlXiqj1smP1HPYjvGOtlmQl3OGE5q0QIYguv4vEfQeL8yI+z2orGl
         GLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zmbcy8aiObBrWmKB+z0WqF9bDwGnayIFUcTM4Axg/fA=;
        b=Zf8gHDDJcwOaGH1IjYn3tMHO0CksPNgqjA7ioMAngaT/U7Witc644S+/u/23lMWh2/
         zWRxowl7maBvWEq/XV5hKiXchwUiNGM6blFOj7Akrmu7GjDJ9ZuRmsPoL7FiSCS3Amwf
         qb9HsPSnawVhtRxhbzHbdeun/pwFAxyf8SCTDqTsJce//P9umLAsEoHTwiiyE0rhnJns
         EG0k9X/Dzz5u8B6F5LD0plBzT+cPZKi18CNpu5bs4JfjoXdevSVNB62F1Tk2ltEsyK3X
         wxCONOWId8lJ3Qos8Tm9fvET4aJIsmOsKlA/rfU6KLWvoTlLp/94hs6gzqvwuAiJWho7
         YQeA==
X-Gm-Message-State: AOAM5319gCUvv3LaF/hai6shWobtAdbSzpvNmusczvx53wwjkfAt51S0
        4OV5Iv20aXt8D3G657RLItQ=
X-Google-Smtp-Source: ABdhPJxCUvbTuavaIhEhy8khMEBaD44S/0B9g7uGRZ5bUJZ7Kr9SQZAN4J47OJOfWFvPjJ4Gsalr8w==
X-Received: by 2002:a17:902:8d84:b0:14f:83f2:8c0d with SMTP id v4-20020a1709028d8400b0014f83f28c0dmr1752840plo.110.1645693723630;
        Thu, 24 Feb 2022 01:08:43 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:43 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 09/16] blk-wbt: show wbt_lat_us sysfs interface only when wbt is opened
Date:   Thu, 24 Feb 2022 17:06:47 +0800
Message-Id: <20220224090654.54671-10-jianchao.wan9@gmail.com>
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

Add 'wbt_lat_us' to block device' queue sysfs only when we open
'wbt' blk-rq-qos policy. And do some code cleanup as we needn't
to export those wbt interfaces.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-sysfs.c |  71 ----------------
 block/blk-wbt.c   | 201 +++++++++++++++++++++++++++-------------------
 block/blk-wbt.h   |  28 -------
 block/blk.h       |   6 ++
 4 files changed, 125 insertions(+), 181 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 052b5f03fc73..1b321edd7ba7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -20,12 +20,6 @@
 #include "blk-wbt.h"
 #include "blk-throttle.h"
 
-struct queue_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct request_queue *, char *);
-	ssize_t (*store)(struct request_queue *, const char *, size_t);
-};
-
 static ssize_t
 queue_var_show(unsigned long var, char *page)
 {
@@ -47,19 +41,6 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 	return count;
 }
 
-static ssize_t queue_var_store64(s64 *var, const char *page)
-{
-	int err;
-	s64 v;
-
-	err = kstrtos64(page, 10, &v);
-	if (err < 0)
-		return err;
-
-	*var = v;
-	return 0;
-}
-
 static ssize_t queue_requests_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->nr_requests, page);
@@ -461,56 +442,6 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
-{
-	if (!wbt_opened(q))
-		return -EINVAL;
-
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
-}
-
-static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
-				  size_t count)
-{
-	ssize_t ret;
-	s64 val;
-
-	ret = queue_var_store64(&val, page);
-	if (ret < 0)
-		return ret;
-	if (val < -1)
-		return -EINVAL;
-
-	if (!wbt_opened(q)) {
-		ret = wbt_init(q);
-		if (ret)
-			return ret;
-	}
-
-	if (val == -1)
-		val = wbt_default_latency_nsec(q);
-	else if (val >= 0)
-		val *= 1000ULL;
-
-	if (wbt_get_min_lat(q) == val)
-		return count;
-
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
-	wbt_set_min_lat(q, val);
-
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
-
-	return count;
-}
-
 static ssize_t queue_wc_show(struct request_queue *q, char *page)
 {
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
@@ -604,7 +535,6 @@ QUEUE_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
-QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
@@ -661,7 +591,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
-	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 44a920d83475..bbec3b394273 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -24,7 +24,9 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/swap.h>
+#include <linux/sysfs.h>
 
+#include "blk.h"
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
 
@@ -38,15 +40,6 @@ static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 	return rq_qos_get(q, wbt_rqos_ops.id);
 }
 
-bool wbt_opened(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-
-	rq_qos_put(rqos);
-
-	return !!rqos;
-}
-
 static inline void wbt_clear_state(struct request *rq)
 {
 	rq->wbt_flags = 0;
@@ -438,33 +431,6 @@ static void wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
-u64 wbt_get_min_lat(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	u64 nsec;
-
-	if (!rqos)
-		return 0;
-
-	nsec = RQWB(rqos)->min_lat_nsec;
-	rq_qos_put(rqos);
-
-	return  nsec;
-}
-
-void wbt_set_min_lat(struct request_queue *q, u64 val)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-
-	if (!rqos)
-		return;
-	RQWB(rqos)->min_lat_nsec = val;
-	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
-	wbt_update_limits(RQWB(rqos));
-	rq_qos_put(rqos);
-}
-
-
 static bool close_io(struct rq_wb *rwb)
 {
 	const unsigned long now = jiffies;
@@ -660,32 +626,7 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 	}
 }
 
-/*
- * Enable wbt if defaults are configured that way
- */
-void wbt_enable_default(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-
-	/* Throttling already enabled? */
-	if (rqos) {
-		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
-			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
-
-		rq_qos_put(rqos);
-		return;
-	}
-
-	/* Queue not registered? Maybe shutting down... */
-	if (!blk_queue_registered(q))
-		return;
-
-	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
-		wbt_init(q);
-}
-EXPORT_SYMBOL_GPL(wbt_enable_default);
-
-u64 wbt_default_latency_nsec(struct request_queue *q)
+static u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
 	 * We default to 2msec for non-rotational storage, and 75msec
@@ -716,7 +657,67 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
 	wbt_update_limits(RQWB(rqos));
 }
 
-static void wbt_exit(struct rq_qos *rqos)
+static ssize_t wbt_lat_show(struct request_queue *q, char *page)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+	ssize_t ret;
+
+	ret = sprintf(page, "%llu\n", div_u64(RQWB(rqos)->min_lat_nsec, 1000));
+
+	rq_qos_put(rqos);
+
+	return ret;
+}
+
+static ssize_t wbt_lat_store(struct request_queue *q, const char *page,
+				  size_t count)
+{
+	struct rq_qos *rqos;
+	struct rq_wb *rwb;
+	ssize_t ret;
+	s64 val;
+
+	ret = kstrtos64(page, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val < -1)
+		return -EINVAL;
+
+	if (val == -1)
+		val = wbt_default_latency_nsec(q);
+	else if (val >= 0)
+		val *= 1000ULL;
+
+	rqos = wbt_rq_qos(q);
+	rwb = RQWB(rqos);
+
+	if (rwb->min_lat_nsec == val)
+		goto out;
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	rwb->min_lat_nsec = val;
+	rwb->enable_state = WBT_STATE_ON_MANUAL;
+	wbt_update_limits(rwb);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
+out:
+	rq_qos_put(rqos);
+	return count;
+}
+
+static struct queue_sysfs_entry wbt_attr =
+	__ATTR(wbt_lat_usec, 0644, wbt_lat_show, wbt_lat_store);
+
+static void __wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
 	struct request_queue *q = rqos->q;
@@ -727,6 +728,12 @@ static void wbt_exit(struct rq_qos *rqos)
 	kfree(rwb);
 }
 
+static void wbt_exit(struct rq_qos *rqos)
+{
+	sysfs_remove_file(&rqos->q->kobj, &wbt_attr.attr);
+	__wbt_exit(rqos);
+}
+
 /*
  * Disable wbt, if enabled by default.
  */
@@ -835,26 +842,10 @@ static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 };
 #endif
 
-static struct rq_qos_ops wbt_rqos_ops = {
-	.name = "wbt",
-	.throttle = wbt_wait,
-	.issue = wbt_issue,
-	.track = wbt_track,
-	.requeue = wbt_requeue,
-	.done = wbt_done,
-	.cleanup = wbt_cleanup,
-	.queue_depth_changed = wbt_queue_depth_changed,
-	.exit = wbt_exit,
-	.init = wbt_init,
-#ifdef CONFIG_BLK_DEBUG_FS
-	.debugfs_attrs = wbt_debugfs_attrs,
-#endif
-};
-
-int wbt_init(struct request_queue *q)
+static int wbt_init(struct request_queue *q)
 {
 	struct rq_wb *rwb;
-	int i;
+	int i, ret;
 
 	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
 	if (!rwb)
@@ -886,9 +877,54 @@ int wbt_init(struct request_queue *q)
 	wbt_queue_depth_changed(&rwb->rqos);
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 
-	return 0;
+	ret = sysfs_create_file(&q->kobj, &wbt_attr.attr);
+	if (ret < 0)
+		__wbt_exit(&rwb->rqos);
+
+	return ret;
 }
 
+static struct rq_qos_ops wbt_rqos_ops = {
+	.name = "wbt",
+	.throttle = wbt_wait,
+	.issue = wbt_issue,
+	.track = wbt_track,
+	.requeue = wbt_requeue,
+	.done = wbt_done,
+	.cleanup = wbt_cleanup,
+	.queue_depth_changed = wbt_queue_depth_changed,
+	.exit = wbt_exit,
+	.init = wbt_init,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.debugfs_attrs = wbt_debugfs_attrs,
+#endif
+};
+
+/*
+ * Enable wbt if defaults are configured that way
+ */
+void wbt_enable_default(struct request_queue *q)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+
+	/* Throttling already enabled? */
+	if (rqos) {
+		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
+
+		rq_qos_put(rqos);
+		return;
+	}
+
+	/* Queue not registered? Maybe shutting down... */
+	if (!blk_queue_registered(q))
+		return;
+
+	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
+		wbt_init(q);
+}
+EXPORT_SYMBOL_GPL(wbt_enable_default);
+
 static __init int wbt_mod_init(void)
 {
 	return rq_qos_register(&wbt_rqos_ops);
@@ -898,5 +934,6 @@ static __exit void wbt_mod_exit(void)
 {
 	return rq_qos_unregister(&wbt_rqos_ops);
 }
+
 module_init(wbt_mod_init);
 module_exit(wbt_mod_exit);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index f128dcf662db..b9ed3f373b5a 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,32 +88,16 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-bool wbt_opened(struct request_queue *q);
-int wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
-u64 wbt_get_min_lat(struct request_queue *q);
-void wbt_set_min_lat(struct request_queue *q, u64 val);
-
 void wbt_set_write_cache(struct request_queue *, bool);
 
-u64 wbt_default_latency_nsec(struct request_queue *);
-
 #else
 
-bool wbt_opened(struct request_queue *q)
-{
-	return false;
-}
-
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-static inline int wbt_init(struct request_queue *q)
-{
-	return -EINVAL;
-}
 static inline void wbt_disable_default(struct request_queue *q)
 {
 }
@@ -123,18 +107,6 @@ static inline void wbt_enable_default(struct request_queue *q)
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
 {
 }
-static inline u64 wbt_get_min_lat(struct request_queue *q)
-{
-	return 0;
-}
-static inline void wbt_set_min_lat(struct request_queue *q, u64 val)
-{
-}
-static inline u64 wbt_default_latency_nsec(struct request_queue *q)
-{
-	return 0;
-}
-
 #endif /* CONFIG_BLK_WBT */
 
 #endif
diff --git a/block/blk.h b/block/blk.h
index 1a314257b6a3..2ec7510c080c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,6 +14,12 @@ struct elevator_type;
 
 extern struct dentry *blk_debugfs_root;
 
+struct queue_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct request_queue *, char *);
+	ssize_t (*store)(struct request_queue *, const char *, size_t);
+};
+
 struct blk_flush_queue {
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
-- 
2.17.1

