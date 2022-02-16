Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE54B8714
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiBPLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:50:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiBPLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:50:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C159255789;
        Wed, 16 Feb 2022 03:49:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso6180950pjt.4;
        Wed, 16 Feb 2022 03:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/BO+Owg3YijmylK7t1XTOPvhHZDRNI4YZ1y+bPLKuc=;
        b=oUclNyyNbNEFDL8a1EB4uhsGPrriY8QKiDFAtdIolxtXaCPZsa9Owb5K0fVpDwxh5F
         Ja474iJDWtl1Zt7+lBjEiGfuSkiX7PV+y3p+6LkYae/TzZD66wikkWTCSA4UitHPtITA
         TJrdqA9YLa7TTQylLMhmOraiqYQBJRtLswI8KSFDFbMK+JOwO7kL3s9P5lRbf/5EDIZ1
         33sPzqvN5cSNTjFCUaKnAY7pmNSP1ARnBGwhEn5OFgkoaID7P0+02tovhi0GMmI5IoLB
         Ac7aHu3UeVbOtKUenIKxEWpJyproyZQZJX0G0ZHq34umKdbFCJWdMKb2vO1dXVsKNB19
         C3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/BO+Owg3YijmylK7t1XTOPvhHZDRNI4YZ1y+bPLKuc=;
        b=n6urMyPXdPfX57lZ+AvP2Bl7CbRSm+wKL98EF4Pl8uai9skWfzFLzGA2+6QnHSy3wy
         ZQdY8oHDBoH8n+mepRP+EHJ6b0aEGFX/WxBsuzmHed7io6taRP8ZQw3n98E9rMGuhS0L
         YfyBtO7TXEQmigLnvj11nhB3ps1NXkFQWyyj38addtZbAyZaWlKTWamBxOT6NPRlQ5Nx
         fDAToiSXG2lDM1a1ufLLTDBYkdyQlukLfrKoNC+ND0SSHSn0d1jiLr8vh+gFe7fpSV6A
         8DEfeN4CXZOYC5Ih/ngcEXuR/uUr4MyrjUMJRyd4z+ZpgGYNGBZfGHbiGsbqIm9bT5pM
         BoIQ==
X-Gm-Message-State: AOAM530qw8Y7NA61mWWmPdXEqvRUnahoVgCql34zY+x99hD16F3MhVAo
        4kTe5dTICvL6b6waGyWGvoA=
X-Google-Smtp-Source: ABdhPJx8Mlag9h5oMSwDg9Rz81/G2w6S6xq0QGtH6Xq8Vn5QkfkBiZNmyjWph9PCuDQISN+znXZqdw==
X-Received: by 2002:a17:902:7293:b0:14e:e9f3:24a2 with SMTP id d19-20020a170902729300b0014ee9f324a2mr2523738pll.72.1645012186581;
        Wed, 16 Feb 2022 03:49:46 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:46 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 4/6] blk-iocost: make iocost pluggable
Date:   Wed, 16 Feb 2022 19:48:07 +0800
Message-Id: <20220216114809.84551-5-jianchao.wan9@gmail.com>
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

Make blk-iocost pluggable. Then we can close or open it through
/sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c     | 49 ++++++++++++++++++++++++++----------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  1 -
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 769b64394298..73978b540e37 100644
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
@@ -2820,13 +2822,17 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static int blk_iocost_init(struct request_queue *q);
 static struct rq_qos_ops ioc_rqos_ops = {
+	.name = "iocost",
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
@@ -2856,10 +2862,7 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -2883,10 +2886,9 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -3162,6 +3164,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
@@ -3172,12 +3175,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
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
@@ -3329,6 +3330,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3339,12 +3341,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
 	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3441,12 +3441,23 @@ static struct blkcg_policy blkcg_policy_iocost = {
 
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
index ec1f74bdea74..652cd754dbd3 100644
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

