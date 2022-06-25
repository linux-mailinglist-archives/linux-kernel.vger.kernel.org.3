Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9055AB40
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiFYPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiFYPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:16:00 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD501225;
        Sat, 25 Jun 2022 08:15:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VHLPCjX_1656170121;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VHLPCjX_1656170121)
          by smtp.aliyun-inc.com;
          Sat, 25 Jun 2022 23:15:51 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: blk_mq_tag_busy is no need to return a value
Date:   Sat, 25 Jun 2022 23:15:21 +0800
Message-Id: <1656170121-1619-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Currently "blk_mq_tag_busy" return value has no effect, so adjust it.
Some code implementations have also been adjusted to enhance
readability.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq-tag.c | 18 +++++++-----------
 block/blk-mq-tag.h | 10 ++++------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2dcd738..3cfffef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -37,29 +37,25 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
  * to get tag when first time, the other shared-tag users could reserve
  * budget for it.
  */
-bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
-		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
-			return true;
-		}
+		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+			return;
+		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
 	} else {
-		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
-		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
-			return true;
-		}
+		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+			return;
+		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
 	users = atomic_inc_return(&hctx->tags->active_queues);
 
 	blk_mq_update_wake_batch(hctx->tags, users);
-
-	return true;
 }
 
 /*
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 5668e28..91ff37e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -47,15 +47,13 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
+extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
-static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return false;
-
-	return __blk_mq_tag_busy(hctx);
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_tag_busy(hctx);
 }
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
-- 
1.8.3.1

