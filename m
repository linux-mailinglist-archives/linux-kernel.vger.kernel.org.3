Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797124894FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiAJJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbiAJJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16189C061757;
        Mon, 10 Jan 2022 01:12:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m13so12667588pji.3;
        Mon, 10 Jan 2022 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lE5PHQYmUvEqvSpisgi3VasZwT8tgz/FJ17TpKqMMY=;
        b=hYISV7/FT/xXa9WAfxYaQavkfEd79VcEhIpJzFbQZnLGItS+7h2qG0tmAQA3UQA+Gg
         4jnPoex++S4yCyOKFmUUBPRN0aRobJkhbW4cNfI4Q3xwMrfj2yqyvlb9wc4gIv5wmDFf
         bibZN2gN0UwJd8GErMrdxAdj8iDWHyeSX9tK8Ka3TEnUor7HUapIMwO94pvA91DFfoQc
         iT736brWPhy4FeQEESZpjBXNkMmbh1QH8sKNtJUIQX2GIp9mOLYRKuBLA6gvvfKsbNkP
         76vmevuyPLHkVxjo/1NsLDRZSDMFJ/3DBVe5SDNaS/gpBKzTfRlfIiyNA47sULI94NRl
         wVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lE5PHQYmUvEqvSpisgi3VasZwT8tgz/FJ17TpKqMMY=;
        b=HM765KrvcBM97pKC0VQ5G7F93i2yFW1T9FwSPxyGcBm46hOgUv1nQwd8P+LL5+dYnr
         kqJp5q/L+2SpJFvBbS5qkyTBiqBRwkClOZKH/xZ1Q33oY5kjORXdoXBVpaIuqOcOPuCj
         I7UTG5rnsWPw6m/Qlb8ni/i2xoKe6WyFThLm2Tmn8MvVoT/DMeePeeAjDIUWYNhe9lYm
         A7OcMJstT/wv6V9DTOirxYMSIkZqtYo98WaSZerUia4KR/1hUql/c4sVcjEIb0ig6dxN
         eVSUGOnLEKjByH4lX4Q1W8opbvdv3RZQ29foGyCE/HDm5xVEGSWYjgM47PfzIhqX5IjT
         S+jg==
X-Gm-Message-State: AOAM532g24gQ2Sk6TB2y0+SCuP5nq6gzVqZbJR6vXqSVpP9t8UQDsUGe
        rMsD9S4R1HCu2PCLDVzltZQ=
X-Google-Smtp-Source: ABdhPJzVCbbXY+GPZ285lAOvjIJJgS49A7vVnkOb4wPTmUy8WPlrMcdMWKhLvEPuP5tAW107PE7tOg==
X-Received: by 2002:a17:903:3015:b0:14a:2206:8cdc with SMTP id o21-20020a170903301500b0014a22068cdcmr7666910pla.55.1641805938642;
        Mon, 10 Jan 2022 01:12:18 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:18 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] blk-iolatency: make iolatency pluggable and modular
Date:   Mon, 10 Jan 2022 17:10:38 +0800
Message-Id: <20220110091046.17010-6-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Make blk-iolatency pluggable and modular. Then we can close or open
it through /sys/block/xxx/queue/qos and rmmod the module if we don't
need it which can release one blkcg policy slot.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig          |  2 +-
 block/Makefile         |  4 +++-
 block/blk-cgroup.c     |  6 ------
 block/blk-iolatency.c  | 39 +++++++++++++++++++++++++++++++--------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 ------
 block/blk.h            |  6 ------
 7 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index c6ce41a5e5b2..1c0d05df2aec 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -111,7 +111,7 @@ config BLK_WBT_MQ
 	Enable writeback throttling by default for request-based block devices.
 
 config BLK_CGROUP_IOLATENCY
-	bool "Enable support for latency based cgroup IO protection"
+	tristate "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP
 	help
 	Enabling this option enables the .latency interface for IO throttling.
diff --git a/block/Makefile b/block/Makefile
index 44df57e562bf..ccf61c57e1d4 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -18,7 +18,9 @@ obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
-obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
+iolat-y 				:= blk-iolatency.o
+obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= iolat.o
+
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fb56d74f1c8e..fd874dfd38ed 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1212,12 +1212,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_iolatency_init(q);
-	if (ret) {
-		blk_throtl_exit(q);
-		goto err_destroy_all;
-	}
-
 	return 0;
 
 err_destroy_all:
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 6593c7123b97..6aaf0775e484 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -90,6 +90,12 @@ struct blk_iolatency {
 	atomic_t enabled;
 };
 
+static struct rq_qos_ops blkcg_iolatency_ops;
+static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
+{
+	return rq_qos_by_id(q, blkcg_iolatency_ops.id);
+}
+
 static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
 {
 	return container_of(rqos, struct blk_iolatency, rqos);
@@ -646,13 +652,21 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	rq_qos_deactivate(rqos);
 	kfree(blkiolat);
 }
 
+static int blk_iolatency_init(struct request_queue *q);
 static struct rq_qos_ops blkcg_iolatency_ops = {
+#if IS_MODULE(CONFIG_BLK_CGROUP_IOLATENCY)
+	.owner = THIS_MODULE,
+#endif
+	.name = "iolat",
+	.flags = RQOS_FLAG_CGRP_POL,
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
+	.init = blk_iolatency_init,
 };
 
 static void blkiolatency_timer_fn(struct timer_list *t)
@@ -727,15 +741,10 @@ int blk_iolatency_init(struct request_queue *q)
 		return -ENOMEM;
 
 	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	rq_qos_add(q, rqos);
-
+	rq_qos_activate(q, rqos, &blkcg_iolatency_ops);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
 	if (ret) {
-		rq_qos_del(q, rqos);
+		rq_qos_deactivate(rqos);
 		kfree(blkiolat);
 		return ret;
 	}
@@ -1046,13 +1055,27 @@ static struct blkcg_policy blkcg_policy_iolatency = {
 
 static int __init iolatency_init(void)
 {
-	return blkcg_policy_register(&blkcg_policy_iolatency);
+	int ret;
+
+	ret = rq_qos_register(&blkcg_iolatency_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iolatency);
+	if (ret)
+		rq_qos_unregister(&blkcg_iolatency_ops);
+
+	return ret;
 }
 
 static void __exit iolatency_exit(void)
 {
 	blkcg_policy_unregister(&blkcg_policy_iolatency);
+	rq_qos_unregister(&blkcg_iolatency_ops);
 }
 
 module_init(iolatency_init);
 module_exit(iolatency_exit);
+MODULE_AUTHOR("Josef Bacik");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Latency based cgroup IO protection");
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9c786b63c847..57c33f4730f2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -820,8 +820,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_LATENCY:
-		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
 	case RQ_QOS_IOPRIO:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index de82eb951bdd..6ca46c69e325 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
@@ -85,11 +84,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 	return rqos;
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
-{
-	return rq_qos_by_id(q, RQ_QOS_LATENCY);
-}
-
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
diff --git a/block/blk.h b/block/blk.h
index ccde6e6f1736..e2e4fbb9a58d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -436,12 +436,6 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 		__blk_queue_bounce(q, bio);	
 }
 
-#ifdef CONFIG_BLK_CGROUP_IOLATENCY
-extern int blk_iolatency_init(struct request_queue *q);
-#else
-static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
-#endif
-
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.17.1

