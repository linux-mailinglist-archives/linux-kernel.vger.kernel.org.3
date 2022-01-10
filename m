Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010214894EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbiAJJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbiAJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE048C06175C;
        Mon, 10 Jan 2022 01:12:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo6024503pjb.2;
        Mon, 10 Jan 2022 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzt0bzuRBlkO35+KYftsgi07H/oE3AzdNVwuKYsXxZs=;
        b=CPwAQj1mCmlC04HOlUdlK38+pfOGOXLbdnDpR6cnyfK+vlFQ6C+Rur4MHpt4ZN7nmC
         Bf0k4Mam86x141bOIzt1afIjzr/2ycQlpqZfSR1gnpZcG1BQovpPemlOelj9CKEysncp
         5sS5dn8aplErQDATGbAQNPHwu/+6CnBvMLcQcQ1V5awK7TICjP7YxpD/8UPDzF9ko+U9
         crEKi4qsmxX3wQ0P+k6Ua+ZcXv5sC/j/4AV5qsVY92pdA65arnpxJ9z1nCyp7URZtHuT
         w56TOKf/OErO+T6TIlbTMn3B3S4VrlSepmChenyGsedIZvK6kQmfilLPznItFZqvHs74
         5KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzt0bzuRBlkO35+KYftsgi07H/oE3AzdNVwuKYsXxZs=;
        b=Hf9jiHb6QOFDZwbrc1rAFuNxa4ao446miAkFrsyU3qjAU833sdsMB4UgdZt7Y+Xj5r
         ZNTNXQlqx5LRXuwUhlfreZqart7SFi4roS4MaCcxE0se4gO/QRX9C+E+lLvuhVcz6O/p
         SF49r8Ki6OXuVZ8Hh5AUNsTkEMmrgGFpkH6+1/1X63rMneRQvdu23wfRA4CuM+w+x0FM
         hTpeFQXVZXONiT89n3OrwtU0FZl2cptnlj6tSIqEM98+hZFBgg9cV4mtFaKBaE40/AHw
         HHlYGScNcpuXfbVJVAc0n2B5PdjW1KsGK6JaNMAHi5Tdx0ao+oUamHiWjEN3m9AIA/1B
         1PLA==
X-Gm-Message-State: AOAM531FuA/F795A9ussKNpX53Sf3BJHcT4AfCSbg6azBPgQmazOFvCD
        kKXT51cFB5dwk4FUj0zt/yc=
X-Google-Smtp-Source: ABdhPJy/eQapQuf+wbd8rg84L547vr+mzHjsjZ3/v13se8TuJJhFP7rAhcNiXVt1W02SsTw3vrF5fQ==
X-Received: by 2002:a17:902:744b:b0:14a:3d99:b524 with SMTP id e11-20020a170902744b00b0014a3d99b524mr2940153plt.27.1641805951398;
        Mon, 10 Jan 2022 01:12:31 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:30 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] blk-ioprio: make ioprio pluggable and modular
Date:   Mon, 10 Jan 2022 17:10:43 +0800
Message-Id: <20220110091046.17010-11-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Make blk-ioprio pluggable and modular. Then we can close or open
it through /sys/block/xxx/queue/qos and rmmod the module if we don't
need it which can release one blkcg policy slot.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig          |  2 +-
 block/Makefile         |  3 ++-
 block/blk-cgroup.c     |  5 -----
 block/blk-ioprio.c     | 50 ++++++++++++++++++++++++++++--------------
 block/blk-ioprio.h     | 19 ----------------
 block/blk-mq-debugfs.c |  4 ----
 block/blk-rq-qos.c     |  2 +-
 block/blk-rq-qos.h     |  2 +-
 8 files changed, 38 insertions(+), 49 deletions(-)
 delete mode 100644 block/blk-ioprio.h

diff --git a/block/Kconfig b/block/Kconfig
index 3e1a3487b55a..b3a2c656a64b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -145,7 +145,7 @@ config BLK_CGROUP_IOCOST
 	their share of the overall weight distribution.
 
 config BLK_CGROUP_IOPRIO
-	bool "Cgroup I/O controller for assigning an I/O priority class"
+	tristate "Cgroup I/O controller for assigning an I/O priority class"
 	depends on BLK_CGROUP
 	help
 	Enable the .prio interface for assigning an I/O priority class to
diff --git a/block/Makefile b/block/Makefile
index beacc3a03c8b..3f76836076b2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
-obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
+ioprio-y 			:= blk-ioprio.o
+obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= ioprio.o
 iolat-y 				:= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= iolat.o
 iocost-y 			:= blk-iocost.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fd874dfd38ed..c5dc44194314 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -31,7 +31,6 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include "blk.h"
-#include "blk-ioprio.h"
 #include "blk-throttle.h"
 
 /*
@@ -1204,10 +1203,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_ioprio_init(q);
-	if (ret)
-		goto err_destroy_all;
-
 	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 332a07761bf8..93d8ba698942 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -17,7 +17,6 @@
 #include <linux/blk_types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include "blk-ioprio.h"
 #include "blk-rq-qos.h"
 
 /**
@@ -209,15 +208,23 @@ static void blkcg_ioprio_exit(struct rq_qos *rqos)
 		container_of(rqos, typeof(*blkioprio_blkg), rqos);
 
 	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
+	rq_qos_deactivate(rqos);
 	kfree(blkioprio_blkg);
 }
 
+static int blk_ioprio_init(struct request_queue *q);
 static struct rq_qos_ops blkcg_ioprio_ops = {
+#if IS_MODULE(CONFIG_BLK_CGROUP_IOPRIO)
+	.owner	= THIS_MODULE,
+#endif
+	.flags	= RQOS_FLAG_CGRP_POL,
+	.name	= "ioprio",
 	.track	= blkcg_ioprio_track,
 	.exit	= blkcg_ioprio_exit,
+	.init	= blk_ioprio_init,
 };
 
-int blk_ioprio_init(struct request_queue *q)
+static int blk_ioprio_init(struct request_queue *q)
 {
 	struct blk_ioprio *blkioprio_blkg;
 	struct rq_qos *rqos;
@@ -227,36 +234,45 @@ int blk_ioprio_init(struct request_queue *q)
 	if (!blkioprio_blkg)
 		return -ENOMEM;
 
+	/*
+	 * No need to worry ioprio_blkcg_from_css return NULL as
+	 * the queue is frozen right now.
+	 */
+	rqos = &blkioprio_blkg->rqos;
+	rq_qos_activate(q, rqos, &blkcg_ioprio_ops);
+
 	ret = blkcg_activate_policy(q, &ioprio_policy);
 	if (ret) {
+		rq_qos_deactivate(rqos);
 		kfree(blkioprio_blkg);
-		return ret;
 	}
 
-	rqos = &blkioprio_blkg->rqos;
-	rqos->id = RQ_QOS_IOPRIO;
-	rqos->ops = &blkcg_ioprio_ops;
-	rqos->q = q;
-
-	/*
-	 * Registering the rq-qos policy after activating the blk-cgroup
-	 * policy guarantees that ioprio_blkcg_from_bio(bio) != NULL in the
-	 * rq-qos callbacks.
-	 */
-	rq_qos_add(q, rqos);
-
-	return 0;
+	return ret;
 }
 
 static int __init ioprio_init(void)
 {
-	return blkcg_policy_register(&ioprio_policy);
+	int ret;
+
+	ret = rq_qos_register(&blkcg_ioprio_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&ioprio_policy);
+	if (ret)
+		rq_qos_unregister(&blkcg_ioprio_ops);
+
+	return ret;
 }
 
 static void __exit ioprio_exit(void)
 {
 	blkcg_policy_unregister(&ioprio_policy);
+	rq_qos_unregister(&blkcg_ioprio_ops);
 }
 
 module_init(ioprio_init);
 module_exit(ioprio_exit);
+MODULE_AUTHOR("Bart Van Assche");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cgroup I/O controller for assigning an I/O priority class");
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
deleted file mode 100644
index a7785c2f1aea..000000000000
--- a/block/blk-ioprio.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _BLK_IOPRIO_H_
-#define _BLK_IOPRIO_H_
-
-#include <linux/kconfig.h>
-
-struct request_queue;
-
-#ifdef CONFIG_BLK_CGROUP_IOPRIO
-int blk_ioprio_init(struct request_queue *q);
-#else
-static inline int blk_ioprio_init(struct request_queue *q)
-{
-	return 0;
-}
-#endif
-
-#endif /* _BLK_IOPRIO_H_ */
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 14fda9a5e552..90610a0cd25a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -819,10 +819,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
-	switch (id) {
-	case RQ_QOS_IOPRIO:
-		return "ioprio";
-	}
 	return "unknown";
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 08ccd4a4e913..15852147ba73 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -459,7 +459,7 @@ int rq_qos_register(struct rq_qos_ops *ops)
 		goto out;
 	}
 
-	start = RQ_QOS_IOPRIO + 1;
+	start = 1;
 	ret = ida_simple_get(&rq_qos_ida, start, INT_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 4eef53f2c290..ee396367a5b2 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,7 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_IOPRIO,
+	RQ_QOS_UNUSED,
 };
 
 struct rq_wait {
-- 
2.17.1

