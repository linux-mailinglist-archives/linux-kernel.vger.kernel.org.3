Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176885A1E27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiHZB1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiHZB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:27:09 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABEA7225;
        Thu, 25 Aug 2022 18:27:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNGOONg_1661477190;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNGOONg_1661477190)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 09:27:00 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: determine in advance whether batch alloc can be performed
Date:   Fri, 26 Aug 2022 09:26:30 +0800
Message-Id: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Some conditions for judging whether batch alloc can be performed are
included in "blk_mq_get_tags", and this function is only used by
"__blk_mq_alloc_requests_batch".

This patch introduced a helper "can_do_batch_alloc" to prepend the
judgment condition and avoid unnecessary function calls.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq-tag.c |  3 ---
 block/blk-mq.c     | 11 ++++++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 8e3b36d..cda3987 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -115,9 +115,6 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 	struct sbitmap_queue *bt = &tags->bitmap_tags;
 	unsigned long ret;
 
-	if (data->shallow_depth ||data->flags & BLK_MQ_REQ_RESERVED ||
-	    data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		return 0;
 	ret = __sbitmap_queue_get_batch(bt, nr_tags, offset);
 	*offset += tags->nr_reserved_tags;
 	return ret;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c1e6b6..330c618 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -437,6 +437,15 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq_list_pop(data->cached_rq);
 }
 
+static inline bool can_do_batch_alloc(struct blk_mq_alloc_data *data)
+{
+	if (data->nr_tags > 1 && !(data->shallow_depth ||
+		data->flags & BLK_MQ_REQ_RESERVED ||
+		data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+		return true;
+	return false;
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
@@ -480,7 +489,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
-	if (data->nr_tags > 1) {
+	if (can_do_batch_alloc(data)) {
 		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
 		if (rq)
 			return rq;
-- 
1.8.3.1

