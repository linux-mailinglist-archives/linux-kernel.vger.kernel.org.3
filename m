Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B94C27B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiBXJKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiBXJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992481B0BC8;
        Thu, 24 Feb 2022 01:08:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p8so1307523pfh.8;
        Thu, 24 Feb 2022 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5LQ0vUCXrLQKiuwNSoC6HsUyh1U+MQASgrQFLzUvi8=;
        b=qSKqIz22gAesE14btwMqqMk/I4MTlibsgaxjj/yZsOfASCoxeDJzZeUmRrRcBuH6Fh
         N+lOjpOQcMzAbH1DIhIxTw13te56Xiv+bY7Jgp9ldF2X19Z7Tt6fsf02eZi1bHnKAYMz
         b2elipX+xsxW58edL4wAvv2fp+L75ir8GM1AKdj4kr45dPnRP7nyiudr68DdhbuyF5u5
         H566aIZzpxnD+TW2JOktv8tJaJhM8bUx3nlZFqfMk8YyKTEDMY55mxDnG0DgAaiUH4lU
         kRxpH8ZOIjz0QmQTr1okdCbU69KkSpVgNQT+YCyR1a+dxEpelvem9/8vo34hQ0I7KYYZ
         vb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5LQ0vUCXrLQKiuwNSoC6HsUyh1U+MQASgrQFLzUvi8=;
        b=NHspGRf2G3Uum7/+7yBNwlpnv6KXpaODPplrgCeiR82lXL5W0++DuLdzZopMJyL71m
         MYgBtQxYolnglKkvtcuCc1skKNDJryp0dbtFsq6XkmEwm6/KCrku9NmEI5HzEwookwXG
         aKggZPboLk/xvDaNiW0gUDoTJR6lJcps/cfQc9Y8GdASYE0wCgq2xY2ooDXn5LSK4Vcu
         pLseXWOoSCNUqQqhjgyCliV6qf42px+/ARBvBDsUvC8FU7nieQ2om0qlIFnaQs2cMi7C
         ppnFXTu3DLkwK++9DFJxhY/bJK6qdOSpC5jdg3bYm/mwsItNhq8hUCqtRRyuKntjSgZm
         IxKA==
X-Gm-Message-State: AOAM5309MsUxjpIZVN6ZypPM9vLPtek6mjPng3p/wC80EwU0qeQ1YfEC
        QNfj4gE5QU5/pGUnxnbJjZI=
X-Google-Smtp-Source: ABdhPJx6l+Ss2YtFSbAU/kp7rnEFu2KH73NSNDW9rsL0T3+pglueK9n1QooLrnKRRY9pMI2+076k+Q==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr1899906pfv.81.1645693736002;
        Thu, 24 Feb 2022 01:08:56 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:55 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 14/16] blk-wbt: cleanup the blk-wbt.h
Date:   Thu, 24 Feb 2022 17:06:52 +0800
Message-Id: <20220224090654.54671-15-jianchao.wan9@gmail.com>
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

There is not any wbt functions that need to be external, cleanup
the blk-wbt.h

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c         |  1 -
 block/blk-mq-sched.c       |  1 -
 block/blk-wbt.c            | 64 ++++++++++++++++++++++++++++-
 block/blk-wbt.h            | 83 --------------------------------------
 include/trace/events/wbt.h |  3 +-
 5 files changed, 65 insertions(+), 87 deletions(-)
 delete mode 100644 block/blk-wbt.h

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ad1d4d9762bd..c7142b60bb1a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -183,7 +183,6 @@
 #include <asm/local64.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
-#include "blk-wbt.h"
 
 #ifdef CONFIG_TRACEPOINTS
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba97823..25f65a5d5bb7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -16,7 +16,6 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
-#include "blk-wbt.h"
 
 /*
  * Mark a hardware queue as needing a restart. For shared queues, maintain
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 83e05417e25f..33072118929f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,14 +27,76 @@
 #include <linux/sysfs.h>
 
 #include "blk.h"
-#include "blk-wbt.h"
+#include "blk-stat.h"
 #include "blk-rq-qos.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
+enum wbt_flags {
+	WBT_TRACKED		= 1,	/* write, tracked for throttling */
+	WBT_READ		= 2,	/* read */
+	WBT_KSWAPD		= 4,	/* write, from kswapd */
+	WBT_DISCARD		= 8,	/* discard */
+
+	WBT_NR_BITS		= 4,	/* number of bits */
+};
+
+enum {
+	WBT_RWQ_BG		= 0,
+	WBT_RWQ_KSWAPD,
+	WBT_RWQ_DISCARD,
+	WBT_NUM_RWQ,
+};
+
+struct rq_wb {
+	/*
+	 * Settings that govern how we throttle
+	 */
+	unsigned int wb_background;		/* background writeback */
+	unsigned int wb_normal;			/* normal writeback */
+
+	/*
+	 * Number of consecutive periods where we don't have enough
+	 * information to make a firm scale up/down decision.
+	 */
+	unsigned int unknown_cnt;
+
+	u64 win_nsec;				/* default window size */
+	u64 cur_win_nsec;			/* current window size */
+
+	struct blk_stat_callback *cb;
+
+	u64 sync_issue;
+	void *sync_cookie;
+
+	unsigned int wc;
+
+	unsigned long last_issue;		/* last non-throttled issue */
+	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long min_lat_nsec;
+	struct rq_qos rqos;
+	struct rq_wait rq_wait[WBT_NUM_RWQ];
+	struct rq_depth rq_depth;
+};
+
 static struct rq_qos_ops wbt_rqos_ops;
 
+static inline struct rq_wb *RQWB(struct rq_qos *rqos)
+{
+	return container_of(rqos, struct rq_wb, rqos);
+}
+
+static inline unsigned int wbt_inflight(struct rq_wb *rwb)
+{
+	unsigned int i, ret = 0;
+
+	for (i = 0; i < WBT_NUM_RWQ; i++)
+		ret += atomic_read(&rwb->rq_wait[i].inflight);
+
+	return ret;
+}
+
 static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 {
 	return rq_qos_get(q, wbt_rqos_ops.id);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
deleted file mode 100644
index eb837dfd0ace..000000000000
--- a/block/blk-wbt.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef WB_THROTTLE_H
-#define WB_THROTTLE_H
-
-#include <linux/kernel.h>
-#include <linux/atomic.h>
-#include <linux/wait.h>
-#include <linux/timer.h>
-#include <linux/ktime.h>
-
-#include "blk-stat.h"
-#include "blk-rq-qos.h"
-
-enum wbt_flags {
-	WBT_TRACKED		= 1,	/* write, tracked for throttling */
-	WBT_READ		= 2,	/* read */
-	WBT_KSWAPD		= 4,	/* write, from kswapd */
-	WBT_DISCARD		= 8,	/* discard */
-
-	WBT_NR_BITS		= 4,	/* number of bits */
-};
-
-enum {
-	WBT_RWQ_BG		= 0,
-	WBT_RWQ_KSWAPD,
-	WBT_RWQ_DISCARD,
-	WBT_NUM_RWQ,
-};
-
-struct rq_wb {
-	/*
-	 * Settings that govern how we throttle
-	 */
-	unsigned int wb_background;		/* background writeback */
-	unsigned int wb_normal;			/* normal writeback */
-
-	/*
-	 * Number of consecutive periods where we don't have enough
-	 * information to make a firm scale up/down decision.
-	 */
-	unsigned int unknown_cnt;
-
-	u64 win_nsec;				/* default window size */
-	u64 cur_win_nsec;			/* current window size */
-
-	struct blk_stat_callback *cb;
-
-	u64 sync_issue;
-	void *sync_cookie;
-
-	unsigned int wc;
-
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
-	unsigned long min_lat_nsec;
-	struct rq_qos rqos;
-	struct rq_wait rq_wait[WBT_NUM_RWQ];
-	struct rq_depth rq_depth;
-};
-
-static inline struct rq_wb *RQWB(struct rq_qos *rqos)
-{
-	return container_of(rqos, struct rq_wb, rqos);
-}
-
-static inline unsigned int wbt_inflight(struct rq_wb *rwb)
-{
-	unsigned int i, ret = 0;
-
-	for (i = 0; i < WBT_NUM_RWQ; i++)
-		ret += atomic_read(&rwb->rq_wait[i].inflight);
-
-	return ret;
-}
-
-#ifdef CONFIG_BLK_WBT
-#else
-static inline void wbt_track(struct request *rq, enum wbt_flags flags)
-{
-}
-#endif /* CONFIG_BLK_WBT */
-
-#endif
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9c66e59d859c..b62e623ed067 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -6,7 +6,8 @@
 #define _TRACE_WBT_H
 
 #include <linux/tracepoint.h>
-#include "../../../block/blk-wbt.h"
+#include "../../../block/blk-stat.h"
+#include "../../../block/blk-rq-qos.h"
 
 /**
  * wbt_stat - trace stats for blk_wb
-- 
2.17.1

