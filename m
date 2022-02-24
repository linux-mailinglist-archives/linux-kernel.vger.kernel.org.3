Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26954C279F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiBXJJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiBXJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC641A02A7;
        Thu, 24 Feb 2022 01:08:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q1so1146451plx.4;
        Thu, 24 Feb 2022 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uoP7wXyeblwzayPXVHQ1z0JW6TP8fvO+buqRA0F2cHo=;
        b=GL/daupG7qcVsle7TnNCJfjJBxXccDltckxk33WmlmeT7SICgGXSTxlQDv7lDVNdvb
         uC6JwPJQbg5Rhio30dWb73nmWQLb7Ds3IBTz829ShtfU4pLesGBdkpD+ztvgVrCtmola
         0ttfBiTdZEM+spj/TDreZ+qhyQp+otB2/6CDW/XQLEXC5HAYeRK3bbqjJYHOR5JiZmbw
         Mn+8RM/lkt9Lp6+t7V25k0bDtcM8ZMnhVKmCbs145FgIT1k0Layyrijp52e680FuYbXo
         74qXv+fjvNFli16WpKepS8R7IweXkeXfVtIqtlpjTxp0tvgwwkz25SfqIenN8WJp3tPp
         0pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uoP7wXyeblwzayPXVHQ1z0JW6TP8fvO+buqRA0F2cHo=;
        b=8JHd8JBTYaVnUtbQXlyPDzP0mRnLvzy6V1yIvBlV+EIGyjGNVriDDJ+stSIWAoamoc
         W4fJnDzLPCvDSpQi5mMggKYoSMUJtx4omh134qjODqWrE4UaXg9+4PFGS7hq++QqLrl7
         rHhcYpG4tiaqcED0SIdsVL1gSPaYEqx5xlIPFQf2FbPnAOJWOhYi12AH3tcELILcM6IH
         2+mGtGaiDCecYKCQDhV4YtxgD0h6b9ITfDl4cm/TKKf4jeb2Y5RNmHf4sO5UHJJj8P37
         1N129u5Sf1G0oCX5//tGBuu1ztYb4Fm0JC0vknH+RL3JSktoKBKMEgQOOG0gz+6ccSnm
         jCcA==
X-Gm-Message-State: AOAM530rzLF+0De0Tfe32+MdBEs/CRdILP6O4uITluFl682vAMm9z7N1
        EVkY7Gay93Mpa+4RrhGvzpA=
X-Google-Smtp-Source: ABdhPJw+gXMgSc/t/r5GMXt3uwZNfS8HZLDU2lmgABLWg6dNtNJKnN4+vdIcc9t+kbrXETRuUZ2GSg==
X-Received: by 2002:a17:902:ee45:b0:14f:b66c:dbad with SMTP id 5-20020a170902ee4500b0014fb66cdbadmr1885052plo.73.1645693714254;
        Thu, 24 Feb 2022 01:08:34 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:33 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 05/16] blk-iocost: make iocost pluggable
Date:   Thu, 24 Feb 2022 17:06:43 +0800
Message-Id: <20220224090654.54671-6-jianchao.wan9@gmail.com>
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

Use new blk-rq-qos API to make blk-iocost pluggable.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c     | 80 ++++++++++++++++++++++++------------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  1 -
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 769b64394298..886c03383444 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -660,10 +660,7 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 	return container_of(rqos, struct ioc, rqos);
 }
 
-static struct ioc *q_to_ioc(struct request_queue *q)
-{
-	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
-}
+static struct rq_qos_ops ioc_rqos_ops;
 
 static const char *q_name(struct request_queue *q)
 {
@@ -2810,6 +2807,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	rq_qos_deactivate(rqos);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2820,15 +2818,6 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
-static struct rq_qos_ops ioc_rqos_ops = {
-	.throttle = ioc_rqos_throttle,
-	.merge = ioc_rqos_merge,
-	.done_bio = ioc_rqos_done_bio,
-	.done = ioc_rqos_done,
-	.queue_depth_changed = ioc_rqos_queue_depth_changed,
-	.exit = ioc_rqos_exit,
-};
-
 static int blk_iocost_init(struct request_queue *q)
 {
 	struct ioc *ioc;
@@ -2856,10 +2845,7 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -2883,10 +2869,9 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -2894,6 +2879,17 @@ static int blk_iocost_init(struct request_queue *q)
 	return 0;
 }
 
+static struct rq_qos_ops ioc_rqos_ops = {
+	.name = "iocost",
+	.throttle = ioc_rqos_throttle,
+	.merge = ioc_rqos_merge,
+	.done_bio = ioc_rqos_done_bio,
+	.done = ioc_rqos_done,
+	.queue_depth_changed = ioc_rqos_queue_depth_changed,
+	.exit = ioc_rqos_exit,
+	.init = blk_iocost_init,
+};
+
 static struct blkcg_policy_data *ioc_cpd_alloc(gfp_t gfp)
 {
 	struct ioc_cgrp *iocc;
@@ -2934,7 +2930,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
-	struct ioc *ioc = q_to_ioc(blkg->q);
+	struct ioc *ioc = rqos_to_ioc(rq_qos_get(blkg->q, ioc_rqos_ops.id));
 	struct ioc_now now;
 	struct blkcg_gq *tblkg;
 	unsigned long flags;
@@ -2990,6 +2986,7 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
+		rq_qos_put(&ioc->rqos);
 	}
 	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
@@ -3162,6 +3159,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
@@ -3172,14 +3170,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
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
-
+	ioc = rqos_to_ioc(rqos);
 	spin_lock_irq(&ioc->lock);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
@@ -3272,10 +3268,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	rq_qos_put(rqos);
 	blkdev_put_no_open(bdev);
 	return nbytes;
 einval:
 	ret = -EINVAL;
+	rq_qos_put(rqos);
 err:
 	blkdev_put_no_open(bdev);
 	return ret;
@@ -3329,6 +3327,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3339,14 +3338,12 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
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
-
+	ioc = rqos_to_ioc(rqos);
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
@@ -3397,11 +3394,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	rq_qos_put(rqos);
 	blkdev_put_no_open(bdev);
 	return nbytes;
 
 einval:
 	ret = -EINVAL;
+	rq_qos_put(rqos);
 err:
 	blkdev_put_no_open(bdev);
 	return ret;
@@ -3441,12 +3440,23 @@ static struct blkcg_policy blkcg_policy_iocost = {
 
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
index 102bc5814cda..27ca6185ad59 100644
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
index ecd1d1692a7d..ab95a366710d 100644
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

