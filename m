Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945F4C27A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiBXJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiBXJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C451A1281;
        Thu, 24 Feb 2022 01:08:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so1215412pga.5;
        Thu, 24 Feb 2022 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7D0XaFfUffPOg1PdRjYQovfR0/U/xSVfFKy5GYaOVfE=;
        b=Wbyhn4tMRWHYwy+0lhRYBa45FX7OdWdFBRWGV9p/65ZYYvpEWCA2L1yVRSQb6pg3S6
         +88IPVYWHxluNfg7dXwIomEL5GFnKR7ev0KIlskq46enUDzil/QxI6NZF/JNx7Kn7l89
         gWh5YIkPoIbspwuh4tesfC0u02YAszhwkRIbC31q9Emzb42+sL2HsiN+PvfIdoQorlZ2
         LZDjDwV+QVoPaPDNM2ub1o76qnxpFW1Tdlx1OTiB4jO7Lh7fFR4uYj4iYEGt3zmGyirB
         3A4l9H+BTBECD6zEgfjrueBR8lRkMXr+oGcdX7ErGRgxw+dTIbQb20Z6ZUJsrfHuCNZ1
         A1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7D0XaFfUffPOg1PdRjYQovfR0/U/xSVfFKy5GYaOVfE=;
        b=KjS2E0WdeZmyJLjyVAE8fPYDSQMxXGYUerDyh/s8Ofj2vOCOGTXaCnmBV+qgG3mjnt
         +XAMuGsFfAEUv0nbhtStoNvqvXbqKc7qJDc28Pn5bzV37XMRBhxRSjQ6HxsK9lOlJ/rs
         VvGTa7ND0pDx8MbTqYuwQTeVuL7LoiwdEe+dCXGvQ3yXRCx9lHLYXKDd/sZi6upqTKCZ
         wLXNTH4pJjj/obsnH2CSPDTvA2m/bF6S6sVkil3qe5YdzW8WWTSaBG/DyD8efCj1isho
         D8IeAVn1UaUj34DZn8u4FPHCVFqaVvKQ5XvWAxX07TFec4cY3dPbHvL6NHyhRluepCSJ
         aPBw==
X-Gm-Message-State: AOAM533jvmBBCeavBXskoWkviu1G+q1DjyLa6mZVqAdQke3brzXqUBr+
        xVLo9Ze6zkShVNHezduFLow=
X-Google-Smtp-Source: ABdhPJy46BJAK9qEonIDnZ6kZGQbivQlaMLPE53RPC00SKgUCmrl8SP7ucl85Y6RAKEzY6h3CVmqSg==
X-Received: by 2002:a63:8a4b:0:b0:340:47d6:4e6a with SMTP id y72-20020a638a4b000000b0034047d64e6amr1571599pgd.89.1645693716528;
        Thu, 24 Feb 2022 01:08:36 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:36 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 06/16] blk-ioprio: make ioprio pluggable
Date:   Thu, 24 Feb 2022 17:06:44 +0800
Message-Id: <20220224090654.54671-7-jianchao.wan9@gmail.com>
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

Use new blk-rq-qos API to make blk-ioprio pluggable.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-cgroup.c     |  5 ----
 block/blk-ioprio.c     | 53 ++++++++++++++++++++++++------------------
 block/blk-ioprio.h     | 19 ---------------
 block/blk-mq-debugfs.c |  4 ----
 block/blk-rq-qos.c     |  2 +-
 block/blk-rq-qos.h     |  2 +-
 6 files changed, 33 insertions(+), 52 deletions(-)
 delete mode 100644 block/blk-ioprio.h

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
index 2e7f10e1c03f..947aae54d295 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -17,7 +17,6 @@
 #include <linux/blk_types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include "blk-ioprio.h"
 #include "blk-rq-qos.h"
 
 /**
@@ -45,6 +44,7 @@ static const char *policy_name[] = {
 };
 
 static struct blkcg_policy ioprio_policy;
+static struct rq_qos_ops blkcg_ioprio_ops;
 
 /**
  * struct ioprio_blkg - Per (cgroup, request queue) data.
@@ -216,15 +216,11 @@ static void blkcg_ioprio_exit(struct rq_qos *rqos)
 		container_of(rqos, typeof(*blkioprio_blkg), rqos);
 
 	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
+	rq_qos_deactivate(rqos);
 	kfree(blkioprio_blkg);
 }
 
-static struct rq_qos_ops blkcg_ioprio_ops = {
-	.track	= blkcg_ioprio_track,
-	.exit	= blkcg_ioprio_exit,
-};
-
-int blk_ioprio_init(struct request_queue *q)
+static int blk_ioprio_init(struct request_queue *q)
 {
 	struct blk_ioprio *blkioprio_blkg;
 	struct rq_qos *rqos;
@@ -234,35 +230,48 @@ int blk_ioprio_init(struct request_queue *q)
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
 
+static struct rq_qos_ops blkcg_ioprio_ops = {
+	.name	= "ioprio",
+	.track	= blkcg_ioprio_track,
+	.exit	= blkcg_ioprio_exit,
+	.init	= blk_ioprio_init,
+};
+
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
index 27ca6185ad59..a35f2d6dd422 100644
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
index c43436c2ead1..03f2e654cd17 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -433,7 +433,7 @@ int rq_qos_register(struct rq_qos_ops *ops)
 		goto out;
 	}
 
-	start = RQ_QOS_IOPRIO + 1;
+	start = 1;
 	ret = idr_alloc(&rq_qos_idr, ops, start, INT_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index ab95a366710d..5a26eb128456 100644
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

