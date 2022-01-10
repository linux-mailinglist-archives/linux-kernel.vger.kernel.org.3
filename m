Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5D4894E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiAJJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbiAJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:34 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F525C034003;
        Mon, 10 Jan 2022 01:12:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso21772344pje.0;
        Mon, 10 Jan 2022 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QjwJsbeo9uruskPn1+c6wYleKO50y4VIL3hXZvxsfXw=;
        b=pDEp4cMPc15aOxBiVGfQ2kYpyXV6sApSCvQAi/bjfVt9RR3uLDYSYYlC/7oQAKXkPR
         nJ/aXZXEtNncN/QuW9J1PG4g/BilOgBqAkfPNxKDKG+oYkpsUKrrka57SEjvKk9+h3PG
         8oMG6CSirJW+sfC8a4V6OEeTcT04bKq6jm/9CoF77mqhtaZW+UqBzhYuTZ7rJ6xbvYjv
         U7C8AnQmm//Qs41GGwjdpYARTkn7uWda7bFphipUQKedULWkrJOXyLCNapyQSbr3WAj6
         XnvqACxcdjtQLrBNDBOPztnTjBS63qVWqSugAD7joAPTYZZBV4J8T8RJvQypIUkFf0bs
         H3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QjwJsbeo9uruskPn1+c6wYleKO50y4VIL3hXZvxsfXw=;
        b=B4fM7kDiEKj7SCevx/M9oawwaHO5xdDbDoxFGbOh0ZOAFhl8QPmv5FL5r9Qg90PQB4
         +6CDAtRe8q6uVd6e7NDiIGPHR60pWj9pJ8mdrQ8nRzqob9lvghE/mEL/q2sqegNh4Soo
         2EaBqPaJo8fInbzKElSUzqe6I1OpswcGgCpELycXYwp2I2pLvtUO7ywj/Q1uLqRV6iVj
         UEll+mZyyYKutOZNNvikEPvp4drhRe6S/lb079VCuh0Pdze5OXLshb56QXOo/mJRo2Mh
         e4NQidrBxKnfAMqXUXoYVkLKOQFchCknIQCUqZa6HF+yol/5zZ1U3P5dQ5k324vo1dX/
         KXlQ==
X-Gm-Message-State: AOAM530jLzugSXn5viF96tsl9HlXiOpZsRO71/gT5dC7kHcBFej0humi
        aNdNY0HAy5o2kjg4LyXpxcA=
X-Google-Smtp-Source: ABdhPJzsX9cn3Gn+g4gyD5G4S35HOBCNDc3n08Ncy9yx+YyV808IIIbCHLq6OizQJbZ/8SJTD9K4Eg==
X-Received: by 2002:a17:902:e74e:b0:149:7c20:c69b with SMTP id p14-20020a170902e74e00b001497c20c69bmr64501735plf.82.1641805946151;
        Mon, 10 Jan 2022 01:12:26 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:25 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] blk-iocost: make iocost pluggable and modular
Date:   Mon, 10 Jan 2022 17:10:41 +0800
Message-Id: <20220110091046.17010-9-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Make blk-iocost pluggable and modular. Then we can close or open
it through /sys/block/xxx/queue/qos and rmmod the module if we don't
need it which can release one blkcg policy slot.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig          |  2 +-
 block/Makefile         |  4 ++--
 block/blk-iocost.c     | 53 ++++++++++++++++++++++++++----------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  1 -
 5 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index e1b1bff5c1e9..3e1a3487b55a 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -134,7 +134,7 @@ config BLK_CGROUP_FC_APPID
 	  application specific identification into the FC frame.
 
 config BLK_CGROUP_IOCOST
-	bool "Enable support for cost model based cgroup IO controller"
+	tristate "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
 	select BLK_RQ_ALLOC_TIME
 	select BLK_BIO_IOCOST
diff --git a/block/Makefile b/block/Makefile
index ccf61c57e1d4..8950913cbcc9 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,8 +20,8 @@ obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 iolat-y 				:= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= iolat.o
-
-obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
+iocost-y 			:= blk-iocost.o
+obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index cfc0e305c32e..afa52354d42b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -660,9 +660,10 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 	return container_of(rqos, struct ioc, rqos);
 }
 
+static struct rq_qos_ops ioc_rqos_ops;
 static struct ioc *q_to_ioc(struct request_queue *q)
 {
-	return rqos_to_ioc(rq_qos_by_id(q, RQ_QOS_COST));
+	return rqos_to_ioc(rq_qos_by_id(q, ioc_rqos_ops.id));
 }
 
 static const char *q_name(struct request_queue *q)
@@ -2810,6 +2811,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	rq_qos_deactivate(rqos);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2820,13 +2822,20 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static int blk_iocost_init(struct request_queue *q);
 static struct rq_qos_ops ioc_rqos_ops = {
+#if IS_MODULE(CONFIG_BLK_CGROUP_IOCOST)
+	.owner = THIS_MODULE,
+#endif
+	.name = "iocost",
+	.flags = RQOS_FLAG_CGRP_POL | RQOS_FLAG_RQ_ALLOC_TIME,
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
 	.done = ioc_rqos_done,
 	.queue_depth_changed = ioc_rqos_queue_depth_changed,
 	.exit = ioc_rqos_exit,
+	.init = blk_iocost_init,
 };
 
 static int blk_iocost_init(struct request_queue *q)
@@ -2856,10 +2865,7 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -2883,10 +2889,9 @@ static int blk_iocost_init(struct request_queue *q)
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
@@ -3173,12 +3178,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
 	if (!rqos) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	ioc = rqos_to_ioc(rqos);
@@ -3257,10 +3260,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	if (enable) {
 		blk_stat_enable_accounting(ioc->rqos.q);
-		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
 		ioc->enabled = true;
 	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
 		ioc->enabled = false;
 	}
 
@@ -3344,12 +3345,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
 	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	ioc = rqos_to_ioc(rqos);
@@ -3449,13 +3448,27 @@ static struct blkcg_policy blkcg_policy_iocost = {
 
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
 module_exit(ioc_exit);
+MODULE_AUTHOR("Tejun Heo");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cost model based cgroup IO controller");
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 57c33f4730f2..14fda9a5e552 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -820,8 +820,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_COST:
-		return "cost";
 	case RQ_QOS_IOPRIO:
 		return "ioprio";
 	}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 6ca46c69e325..4eef53f2c290 100644
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

