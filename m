Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEDE490434
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiAQIoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:44:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35847 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiAQIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:56 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JclmH1yNszccYn;
        Mon, 17 Jan 2022 16:43:11 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:43:54 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 16:43:53 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RESEND 2/3] blk-mq: record how many hctx failed to get driver tag while sharing a tag set
Date:   Mon, 17 Jan 2022 16:54:54 +0800
Message-ID: <20220117085455.2269760-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220117085455.2269760-1-yukuai3@huawei.com>
References: <20220117085455.2269760-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hctx will be recorded when getting driver tag failed, and will be
cleared when hctx becomes idle. The clearing is too late and can be
optimized, however, let's just use the easy way here for now because
clearing it in time seems rather complicated.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c |  8 +++++++-
 block/blk-mq-tag.h |  6 +++---
 block/blk-mq.c     | 13 ++++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 77c723bdfd5c..d4d212c6c32e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -163,8 +163,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		if (!data->q->elevator)
+			blk_mq_dtag_wait(data->hctx);
 		return BLK_MQ_NO_TAG;
+	}
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -191,6 +194,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		if (!data->q->elevator)
+			blk_mq_dtag_wait(data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 3fe013aee9a2..d5f98a3e6f91 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -47,9 +47,9 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_wait(struct blk_mq_hw_ctx *hctx);
+extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx);
-extern void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_dtag_wait(struct blk_mq_hw_ctx *hctx);
 extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
@@ -57,7 +57,7 @@ static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return false;
 
-	return __blk_mq_tag_wait(hctx);
+	return __blk_mq_tag_busy(hctx);
 }
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d73bc219a7fa..8d90e686ee8b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1471,8 +1471,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
-			if (blk_mq_hw_queue_mapped(hctx))
+			if (blk_mq_hw_queue_mapped(hctx)) {
 				blk_mq_tag_idle(hctx);
+				blk_mq_dtag_idle(hctx);
+			}
 		}
 	}
 	blk_queue_exit(q);
@@ -1569,8 +1571,10 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 	}
 
 	tag = __sbitmap_queue_get(bt);
-	if (tag == BLK_MQ_NO_TAG)
+	if (tag == BLK_MQ_NO_TAG) {
+		blk_mq_dtag_wait(rq->mq_hctx);
 		return false;
+	}
 
 	rq->tag = tag + tag_offset;
 	return true;
@@ -3416,8 +3420,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	struct request *flush_rq = hctx->fq->flush_rq;
 
-	if (blk_mq_hw_queue_mapped(hctx))
+	if (blk_mq_hw_queue_mapped(hctx)) {
 		blk_mq_tag_idle(hctx);
+		blk_mq_dtag_idle(hctx);
+	}
 
 	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
 			set->queue_depth, flush_rq);
@@ -3743,6 +3749,7 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 		} else {
 			blk_mq_tag_idle(hctx);
+			blk_mq_dtag_idle(hctx);
 			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
 		}
 	}
-- 
2.31.1

