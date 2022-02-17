Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84324B9676
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiBQDP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:15:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiBQDPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:41 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456032A8D14;
        Wed, 16 Feb 2022 19:15:26 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u16so3798842pfg.12;
        Wed, 16 Feb 2022 19:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uOTJgTBT+ZIFMt1y2Z/+FupjRD5j4eNAIs2Pma1Hy3I=;
        b=YIbUE8otRKvbmcesWSrWQB75hDiB+nmxST822Wh6HoISAKDMDKyR5B8XEot9SPkKXe
         R5Ark5XhlTpsEJ9ciJsNDXuvuRxGvkHVh7nwoyQaJhkoCz1VvF+hpEUjZMtKHY0kZdNh
         9TxKPAiHCms67THSbbK1w5CrHChGn2b/aRkXfRJ/m78LoS0PqxA0UALakS3Lwe0DIV9X
         FrLh8sdQpC7M3sh/tB75XNqsWqRy/4SwMOtg931mdfEW/6Tp3u/jA10HbtgLrSkIu4kT
         lTWRetDCAWpbFx8dHNq3yrD6FBazsw67WBoZYjGK2xtfz9JUZ8I9+KwOFdJ+PLmjVYFu
         n2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uOTJgTBT+ZIFMt1y2Z/+FupjRD5j4eNAIs2Pma1Hy3I=;
        b=6NPc+sgC3AV+7csbD1z+zpwKI8olv1oF2bNuNY37uhwvJAaNC6jLlaa8cbQTW+jexC
         If7MWU3/akPdeAHRXy49/3RVtV3tx4zApg167SqO1afJ4/+0hXAD4zoThN2w/xlFMVWQ
         RKwRYpw4PiE4RpF97ArLq+HNrft1k59nyteAVSE1g6bQc3OGLaXm6ipWPg9Caif9Yhs1
         73hvtgTQQXXqwi4fw9P55N3PYxv6zjEmaEfBK1sJmrPk8ZQbv+5ndtDegDRWoSO+565P
         YOsd9giUMtFAEUXydnkqFcsHOXn7qcONVu1/D7fJtWMSWrAezVwA9bn1zayUHKqSeah1
         JruA==
X-Gm-Message-State: AOAM5318/b+1GlAU5QjUcTOJZSLtZBqhXk0KK4157UsXaXEe3F+zwnlq
        REKw4lefS0+SOCEASEGU3xc=
X-Google-Smtp-Source: ABdhPJwkb9z/0Ah9SRYfxtAtCNW1P+lPYlCpfrDneiLoIqPOfqz7fapvVT6iuEnzkMTbbq/+vXlM3w==
X-Received: by 2002:a05:6a00:b51:b0:4c7:c1a3:3911 with SMTP id p17-20020a056a000b5100b004c7c1a33911mr1156277pfo.13.1645067725657;
        Wed, 16 Feb 2022 19:15:25 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id cu21sm421018pjb.50.2022.02.16.19.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:15:25 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V4 4/6] blk-iocost: make iocost pluggable
Date:   Thu, 17 Feb 2022 11:13:47 +0800
Message-Id: <20220217031349.98561-5-jianchao.wan9@gmail.com>
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

Make blk-iocost pluggable. Then we can close or open it through
/sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c     | 52 ++++++++++++++++++++++++++----------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  1 -
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 769b64394298..5a3a45985b49 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -660,9 +660,10 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 	return container_of(rqos, struct ioc, rqos);
 }
 
+static struct rq_qos_ops ioc_rqos_ops;
 static struct ioc *q_to_ioc(struct request_queue *q)
 {
-	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
+	return rqos_to_ioc(rq_qos_by_id(q, ioc_rqos_ops.id));
 }
 
 static const char *q_name(struct request_queue *q)
@@ -2810,6 +2811,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	rq_qos_deactivate(rqos);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2820,13 +2822,18 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static int blk_iocost_init(struct request_queue *q);
+
 static struct rq_qos_ops ioc_rqos_ops = {
+	.name = "blk-iocost",
+	.flags = RQOS_FLAG_CGRP_POL,
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
 	.done = ioc_rqos_done,
 	.queue_depth_changed = ioc_rqos_queue_depth_changed,
 	.exit = ioc_rqos_exit,
+	.init = blk_iocost_init,
 };
 
 static int blk_iocost_init(struct request_queue *q)
@@ -2856,10 +2863,7 @@ static int blk_iocost_init(struct request_queue *q)
 	}
 
 	rqos = &ioc->rqos;
-	rqos->id = RQ_QOS_COST;
-	rqos->ops = &ioc_rqos_ops;
-	rqos->q = q;
-
+	rq_qos_activate(q, rqos, &ioc_rqos_ops);
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2883,10 +2887,9 @@ static int blk_iocost_init(struct request_queue *q)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	rq_qos_add(q, rqos);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
 	if (ret) {
-		rq_qos_del(q, rqos);
+		rq_qos_deactivate(rqos);
 		free_percpu(ioc->pcpu_stat);
 		kfree(ioc);
 		return ret;
@@ -3162,6 +3165,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
@@ -3172,12 +3176,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
-	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
+	if (!rqos) {
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3329,6 +3331,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3339,12 +3342,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
-	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
+	if (!rqos) {
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3441,12 +3442,23 @@ static struct blkcg_policy blkcg_policy_iocost = {
 
 static int __init ioc_init(void)
 {
-	return blkcg_policy_register(&blkcg_policy_iocost);
+	int ret;
+
+	ret = rq_qos_register(&ioc_rqos_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iocost);
+	if (ret)
+		rq_qos_unregister(&ioc_rqos_ops);
+
+	return ret;
 }
 
 static void __exit ioc_exit(void)
 {
 	blkcg_policy_unregister(&blkcg_policy_iocost);
+	rq_qos_unregister(&ioc_rqos_ops);
 }
 
 module_init(ioc_init);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 918870b8de5b..45da42e9e242 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -826,8 +826,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_COST:
-		return "cost";
 	case RQ_QOS_IOPRIO:
 		return "ioprio";
 	}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2a919db52fef..6d691527cb51 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
 
-- 
2.17.1

