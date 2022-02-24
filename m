Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834964C27C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiBXJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiBXJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D21B372A;
        Thu, 24 Feb 2022 01:09:01 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 195so1214826pgc.6;
        Thu, 24 Feb 2022 01:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lC/QRqanujut9YVkFlgqgARRMRZBexuuSYRLcGbZXQ=;
        b=HJMY322fGBraD+Lri+RbvpNXBMNETrF9CoduJ2S1CFuUx7CMrSm3ENOeauE6dhqxAM
         dXnXz5Jz2wlIoePlV09JO9MJ4bfHaGe70b2PCjuov1gmCMzkbsFug776tAimBuhfx2Sl
         iIjRN73Tok5EVFyQ0IdEKYYFxrKuzgygJKt9o9j9Z4B4GgQrTdvaEjH4atr+SfJdy8JM
         lyrVlRCiRSS/yWL3e9IUriqzp9u1Ci0nH1UNQ8syu4+FztaIVBPtmSN59AidBKCMfAWQ
         Ksm0YKazBy2Ememh97Iw+gW7DfxvqRV4/fzspAuUlkQVugguzzLR+aGGxbDqpG5nKVpF
         Xp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lC/QRqanujut9YVkFlgqgARRMRZBexuuSYRLcGbZXQ=;
        b=0GT8DFUHiB0NA+4pTjBfvvfSqZQZP/Xqb5ijcAVHh3PNPRqPU+J+rhfqEJ8EB+8Gg+
         z60h5+qFYaTOAxChjv2AxZSxKB6YVTU/pRkufGh/P3Deznv8zEoDfijUXLVTAHK+m6So
         4t38033gbvch5O9BoGphUjTYjduWHodtrCCy1e98xcVIn2uTE3EUgbnvpRxwr6bOmQlD
         5h43sRGngnIURvDhlUuy3v2FvYXIvdTHZpWjsTF+56eeKnWAAW/EI0LoZD+U9XxHvfQn
         YP5wyCs5bm1C5R8LNF1ptSetcOqn/ldufnmRObJxzI5e/v4fIMA/M+7a9nfFjiaNEOGi
         Ygbw==
X-Gm-Message-State: AOAM533AhTvX/8PCIqECGq3iYhmoHu+MQI6eveFf984EHjB8wWYvtP0B
        FIMoceaG76+ZqnMMaXDimXU=
X-Google-Smtp-Source: ABdhPJyr7UgIZcW5glKz4gMUjz8dogEypUmez6QS/YMM5Hx3YpB3bmXHY7kGT8F5/xrtP77xCxjCzg==
X-Received: by 2002:a62:8895:0:b0:4e1:78b:5ab7 with SMTP id l143-20020a628895000000b004e1078b5ab7mr1985830pfd.67.1645693740481;
        Thu, 24 Feb 2022 01:09:00 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:09:00 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 16/16] blk/rq-qos: add config to control the whole blk-rq-qos framework
Date:   Thu, 24 Feb 2022 17:06:54 +0800
Message-Id: <20220224090654.54671-17-jianchao.wan9@gmail.com>
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

This patch makes the whole blk-rq-qos framework be able to be
configured by CONFIG_BLK_RQ_QOS. There is no functional changes
in this patch.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/Kconfig          |  7 +++++++
 block/Makefile         |  3 ++-
 block/blk-mq.c         |  4 +---
 block/blk-rq-qos.c     |  1 +
 block/blk-rq-qos.h     | 16 ++++++++++++++++
 block/blk-sysfs.c      |  4 ++++
 include/linux/blkdev.h |  6 ++++--
 7 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index d5d4197b7ed2..b9d2a2dcbe56 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -38,6 +38,9 @@ config BLK_DEV_BSG_COMMON
 config BLK_ICQ
 	bool
 
+config BLK_RQ_QOS
+	bool
+
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
@@ -99,6 +102,7 @@ config BLK_DEV_THROTTLING_LOW
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
+	select BLK_RQ_QOS
 	help
 	Enabling this option enables the block layer to throttle buffered
 	background writeback from the VM, making it more smooth and having
@@ -116,6 +120,7 @@ config BLK_WBT_MQ
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP
+	select BLK_RQ_QOS
 	help
 	Enabling this option enables the .latency interface for IO throttling.
 	The IO controller will attempt to maintain average IO latencies below
@@ -138,6 +143,7 @@ config BLK_CGROUP_IOCOST
 	depends on BLK_CGROUP
 	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
+	select BLK_RQ_QOS
 	help
 	Enabling this option enables the .weight interface for cost
 	model based proportional IO control.  The IO controller
@@ -147,6 +153,7 @@ config BLK_CGROUP_IOCOST
 config BLK_CGROUP_IOPRIO
 	bool "Cgroup I/O controller for assigning an I/O priority class"
 	depends on BLK_CGROUP
+	select BLK_RQ_QOS
 	help
 	Enable the .prio interface for assigning an I/O priority class to
 	requests. The I/O priority class affects the order in which an I/O
diff --git a/block/Makefile b/block/Makefile
index f38eaa612929..07af1b2f6fe0 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,9 +8,10 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
+			genhd.o ioprio.o badblocks.o partitions/ \
 			disk-events.o blk-ia-ranges.o
 
+obj-$(CONFIG_BLK_RQ_QOS) 	+= blk-rq-qos.o
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c1cd32c72fd..9780bfb25046 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1248,12 +1248,10 @@ EXPORT_SYMBOL(blk_execute_rq);
 
 static void __blk_mq_requeue_request(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-
 	blk_mq_put_driver_tag(rq);
 
 	trace_block_rq_requeue(rq);
-	rq_qos_requeue(q, rq);
+	rq_qos_requeue(rq->q, rq);
 
 	if (blk_mq_request_started(rq)) {
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 0572dd584c53..92df1dca74cc 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/debugfs.h>
 #include "blk-rq-qos.h"
 
 static DEFINE_IDR(rq_qos_idr);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 463c64d28e8b..dc7071139247 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -2,6 +2,8 @@
 #ifndef RQ_QOS_H
 #define RQ_QOS_H
 
+#ifdef CONFIG_BLK_RQ_QOS
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blk_types.h>
@@ -167,4 +169,18 @@ static inline void rq_qos_setting_changed(struct request_queue *q)
 
 void rq_qos_exit(struct request_queue *);
 
+#else
+
+#define rq_qos_cleanup(q, bio)
+#define rq_qos_done(q, rq)
+#define rq_qos_issue(q, rq)
+#define rq_qos_requeue(q, rq)
+#define rq_qos_done_bio(q, bio)
+#define rq_qos_throttle(q, bio)
+#define rq_qos_track(q, rq, bio)
+#define rq_qos_merge(q, rq, bio)
+#define rq_qos_setting_changed(q)
+#define rq_qos_exit(q)
+
+#endif /* CONFIG_BLK_RQ_QOS */
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4563283dae07..784b4d8416d5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -503,7 +503,9 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+#ifdef CONFIG_BLK_RQ_QOS
 QUEUE_RW_ENTRY(queue_qos, "qos");
+#endif
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -562,7 +564,9 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
+#ifdef CONFIG_BLK_RQ_QOS
 	&queue_qos_entry.attr,
+#endif
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 126aac824ccc..8d6dff40fe73 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -194,8 +194,9 @@ struct request_queue {
 	struct percpu_ref	q_usage_counter;
 
 	struct blk_queue_stats	*stats;
+#ifdef CONFIG_BLK_RQ_QOS
 	struct rq_qos		*rq_qos;
-
+#endif
 	const struct blk_mq_ops	*mq_ops;
 
 	/* sw queues */
@@ -230,8 +231,9 @@ struct request_queue {
 	int			id;
 
 	spinlock_t		queue_lock;
+#ifdef CONFIG_BLK_RQ_QOS
 	spinlock_t		rqos_lock;
-
+#endif
 	struct gendisk		*disk;
 
 	/*
-- 
2.17.1

