Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952804C27BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiBXJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiBXJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E11A58EA;
        Thu, 24 Feb 2022 01:08:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e13so1150060plh.3;
        Thu, 24 Feb 2022 01:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmaXXXHQ/i9EKjoTmBwkF1G8tSqW4N88V6hDi2C1HD4=;
        b=WllXDIs36ZGrqgYryRhKFoGDVLxNIPINwv2Zi90yrKkz5EbSNgByCMuJ+sgA59vqnp
         5dx71I2ov1cHh0W7QNsCqVRE8Q9JnYKrh/F4pygfB6qbbZkY9SmB46DUyet8jcxwOsVx
         nJIUnA6CAkb65lMkE1fWgVZjn+rA3AcTY/a1abM0nZy4J5oRSLdOjmc8nM++SxdkdgMR
         lY4EFIv+mROsTXCNymkXFsob7MpIFXWd6HvnrkJWvRPM0RFiG2E60cu29EvHuw8O4Xk9
         sbmRKBW6arYUHzX8MBV8/S980aftF+d1PZEJTXB+6tQjnJlObjAA6Mp04BNQ1cHSluKx
         lE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmaXXXHQ/i9EKjoTmBwkF1G8tSqW4N88V6hDi2C1HD4=;
        b=K0SD9+g5Xlyt6YCfRYfLex6BWN0gFXf7kW0lW1hiYDszDk29mCV8HV0wuvnRWL6VzX
         apKZhHR/xor+AxXsaKGFxsrZGjqkYoTU7jadjKz4/P2ibg9fR8oMFU2qEwBoN6uEcbqQ
         OaS6gW9HCELDQr7oLY6H+PQbzvS3xEnm6wXppQnXd2sMTkoKv4fJSd667ErRRi2a+M71
         ncL7zF7U7JKCGimg8gVFmIdVbjqLfOaLSgvivtnqERg+fmmoEbqyppIm54DUzvUDkBs4
         f3s+WK7vh9+S9OmDJW3mmV7X6nB89t66ufv7TqPRJ52hiv6AW74RFv/+5tAoIY/34Pa9
         ykqw==
X-Gm-Message-State: AOAM531X+msPq3wHsDn6Mn1QTlkJ2I3PoqrQDo+BskNkV8mkwJRKfSYa
        XFfCVoXMyd/NCAMUkXE2CIaLEn3wwuXZyA==
X-Google-Smtp-Source: ABdhPJyZ5JcKXcufTNixaR7yYQQ8MLaW9hd9LGIlINMFtjycdxiT3SSTgVnP9PPAF8kueMeyYylhHQ==
X-Received: by 2002:a17:902:d88f:b0:14d:696e:949f with SMTP id b15-20020a170902d88f00b0014d696e949fmr1651500plz.8.1645693731092;
        Thu, 24 Feb 2022 01:08:51 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:50 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 12/16] blk/rq-qos: change queue_depth_changed to setting_changed
Date:   Thu, 24 Feb 2022 17:06:50 +0800
Message-Id: <20220224090654.54671-13-jianchao.wan9@gmail.com>
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

Change the callback .queue_depth_changed() to .setting_changed().
Then all of the queue setting changes can be involved.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c   |  4 ++--
 block/blk-rq-qos.c   |  6 +++---
 block/blk-rq-qos.h   |  8 ++++----
 block/blk-settings.c |  2 +-
 block/blk-wbt.c      | 12 +++++++-----
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 886c03383444..ad1d4d9762bd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2793,7 +2793,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	put_cpu_ptr(ccs);
 }
 
-static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
+static void ioc_rqos_setting_changed(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
@@ -2885,7 +2885,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
 	.done = ioc_rqos_done,
-	.queue_depth_changed = ioc_rqos_queue_depth_changed,
+	.setting_changed = ioc_rqos_setting_changed,
 	.exit = ioc_rqos_exit,
 	.init = blk_iocost_init,
 };
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 03f2e654cd17..236ecb2af845 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -104,11 +104,11 @@ void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 	} while (rqos);
 }
 
-void __rq_qos_queue_depth_changed(struct rq_qos *rqos)
+void __rq_qos_setting_changed(struct rq_qos *rqos)
 {
 	do {
-		if (rqos->ops->queue_depth_changed)
-			rqos->ops->queue_depth_changed(rqos);
+		if (rqos->ops->setting_changed)
+			rqos->ops->setting_changed(rqos);
 		rqos = rqos->next;
 	} while (rqos);
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 58aba16c7d32..3d7df14edde3 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -42,7 +42,7 @@ struct rq_qos_ops {
 	void (*done)(struct rq_qos *, struct request *);
 	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
-	void (*queue_depth_changed)(struct rq_qos *);
+	void (*setting_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
 	int (*init)(struct request_queue *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
@@ -94,7 +94,7 @@ void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
-void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
+void __rq_qos_setting_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
@@ -152,7 +152,7 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 		__rq_qos_merge(q->rq_qos, rq, bio);
 }
 
-static inline void rq_qos_queue_depth_changed(struct request_queue *q)
+static inline void rq_qos_setting_changed(struct request_queue *q)
 {
 	/*
 	 * It is called by external module, protect the rqos list with
@@ -160,7 +160,7 @@ static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 	 */
 	mutex_lock(&q->sysfs_lock);
 	if (q->rq_qos)
-		__rq_qos_queue_depth_changed(q->rq_qos);
+		__rq_qos_setting_changed(q->rq_qos);
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b880c70e22e4..bceb1925e978 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -777,7 +777,7 @@ EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
 {
 	q->queue_depth = depth;
-	rq_qos_queue_depth_changed(q);
+	rq_qos_setting_changed(q);
 }
 EXPORT_SYMBOL(blk_set_queue_depth);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6c0a85ddb107..3a3a683009c4 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -650,10 +650,12 @@ static int wbt_data_dir(const struct request *rq)
 	return -1;
 }
 
-static void wbt_queue_depth_changed(struct rq_qos *rqos)
+static void wbt_setting_changed(struct rq_qos *rqos)
 {
-	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
-	wbt_update_limits(RQWB(rqos));
+	if (RQWB(rqos)->rq_depth.queue_depth != blk_queue_depth(rqos->q)) {
+		RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->q);
+		wbt_update_limits(RQWB(rqos));
+	}
 }
 
 static ssize_t wbt_lat_show(struct request_queue *q, char *page)
@@ -841,7 +843,7 @@ static int wbt_init(struct request_queue *q)
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
-	wbt_queue_depth_changed(&rwb->rqos);
+	wbt_setting_changed(&rwb->rqos);
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 
 	ret = sysfs_create_file(&q->kobj, &wbt_attr.attr);
@@ -859,7 +861,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.requeue = wbt_requeue,
 	.done = wbt_done,
 	.cleanup = wbt_cleanup,
-	.queue_depth_changed = wbt_queue_depth_changed,
+	.setting_changed = wbt_setting_changed,
 	.exit = wbt_exit,
 	.init = wbt_init,
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.17.1

