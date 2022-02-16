Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2484B8717
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiBPLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:50:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiBPLuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:50:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F372560F6;
        Wed, 16 Feb 2022 03:49:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s16so1902534pgs.13;
        Wed, 16 Feb 2022 03:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9sH4Ya4Z/3kq4RhnFqriNyS1UnoAGX2fvLMWDQ5WWg=;
        b=QdiVKTeEOAvbArd8oOVN9+JePQlTCEB4PUGvUFdcWGQ91gAJ3rrtvk/XTlIR+J4Lvu
         s9rWVOg4Oh+m9VauUrP2omm+m4Gx7zkTQBRCXtKwlU6gjdTj83CTaVoICuy8ghe/92mZ
         lmNP2njcP+sgaxqss2o1ALmUd9vL9mELTk9iuFAaRbMn+Wt3hy2TnRUScaIALaxImJ96
         WT8wcDTVpbZjvV4YJ7ifvUY0CpmhrM2BRNJjkeE1tGvETvssuR3vWjJViIdvOYwf11ti
         ecc9/9yK+M3nU5caAQigusVZMoGMd5NViULRp8ru5E9/YYMMC/HSTXcWQLu6GjiGBed5
         s3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9sH4Ya4Z/3kq4RhnFqriNyS1UnoAGX2fvLMWDQ5WWg=;
        b=aezuUF5dq5mrsKT4enIDRG+lJK4YGuXDj8HIOcv0EeIB5cuvclTbHeEQouu0dg0Cdf
         GyZVg/vd/kGQ7jbgUE7uRV2LLW4/clPYmHC3Frjn1tGp5QdY+gnNdH+nSmDxVVUkW+/V
         Z1wwPFsPMLWRp70u2VxqzbNKcxSO05lcd+uqnFBpF0HHMCrFkOt+S9Ayo1nqu/rutS/a
         hZpcWaNSETANCGZTiK8ij0k+pQAcB0Sab9AIdPyBu2Y+NoJNS81ETKZ+ci8vtP6AwPKv
         5ktcdmv45Xd5MYn3P1+/Fn+vokfMfI/3hQvmVqHxm703hPs3PKO194UIFBfwUhkWwmV9
         wpLg==
X-Gm-Message-State: AOAM5334zie9xNBipRcfTL2FvSMYBV9HVnpatkANghKI4tTPziu/F4HA
        mOi321DJfiAWeYCOIojcF4615QK0/l3HTS4m
X-Google-Smtp-Source: ABdhPJyLuJomcv5qQ4l2ctZZBwJeMjoUZoQd7B7T2MYZ3KniHyAMViRu0AycbWYUTUiILO5zWfQ+xg==
X-Received: by 2002:a05:6a00:1d0c:b0:4e1:9846:3f34 with SMTP id a12-20020a056a001d0c00b004e198463f34mr2053850pfx.59.1645012189309;
        Wed, 16 Feb 2022 03:49:49 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:49 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 5/6] blk-ioprio: make ioprio pluggable and modular
Date:   Wed, 16 Feb 2022 19:48:08 +0800
Message-Id: <20220216114809.84551-6-jianchao.wan9@gmail.com>
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

Make blk-ioprio pluggable and modular. Then we can close or open
it through /sys/block/xxx/queue/qos and rmmod the module if we don't
need it which can release one blkcg policy slot.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
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
index d5d4197b7ed2..9cc8e4688953 100644
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
index f38eaa612929..f6a3995af285 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
-obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
+io-prio-y 			:= blk-ioprio.o
+obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= io-prio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3ae2aa557aef..f617f7ba311d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,7 +32,6 @@
 #include <linux/psi.h>
 #include <linux/part_stat.h>
 #include "blk.h"
-#include "blk-ioprio.h"
 #include "blk-throttle.h"
 
 /*
@@ -1195,10 +1194,6 @@ int blkcg_init_queue(struct request_queue *q)
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
index 2e7f10e1c03f..074cc0978d0b 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -17,7 +17,6 @@
 #include <linux/blk_types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include "blk-ioprio.h"
 #include "blk-rq-qos.h"
 
 /**
@@ -216,15 +215,23 @@ static void blkcg_ioprio_exit(struct rq_qos *rqos)
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
+	.name	= "io-prio",
 	.track	= blkcg_ioprio_track,
 	.exit	= blkcg_ioprio_exit,
+	.init	= blk_ioprio_init,
 };
 
-int blk_ioprio_init(struct request_queue *q)
+static int blk_ioprio_init(struct request_queue *q)
 {
 	struct blk_ioprio *blkioprio_blkg;
 	struct rq_qos *rqos;
@@ -234,36 +241,45 @@ int blk_ioprio_init(struct request_queue *q)
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
index 652cd754dbd3..ba43efed3565 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -825,10 +825,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
-	switch (id) {
-	case RQ_QOS_IOPRIO:
-		return "ioprio";
-	}
 	return "unknown";
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index f269bb9745ad..56525fe62500 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -454,7 +454,7 @@ int rq_qos_register(struct rq_qos_ops *ops)
 		goto out;
 	}
 
-	start = RQ_QOS_IOPRIO + 1;
+	start = 1;
 	ret = ida_simple_get(&rq_qos_ida, start, INT_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 6d691527cb51..bba829bbb461 100644
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

