Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE3490432
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiAQIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:43:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35846 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiAQInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:55 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JclmG5FY8zccYZ;
        Mon, 17 Jan 2022 16:43:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:43:53 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 16:43:53 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RESEND 1/3] blk-mq: add new interfaces to track if hctx failed to get driver tag
Date:   Mon, 17 Jan 2022 16:54:53 +0800
Message-ID: <20220117085455.2269760-2-yukuai3@huawei.com>
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

Prepare to allow hardware queue to get more tag while sharing a tag set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 37 +++++++++++++++++++++++++++++++++++++
 block/blk-mq-tag.h     | 24 +++++++++++++++++++++---
 include/linux/blk-mq.h | 12 ++++++++++++
 include/linux/blkdev.h |  2 ++
 5 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c..3841fe26cda1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -454,6 +454,8 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
 		   atomic_read(&tags->active_queues));
+	seq_printf(m, "pending_queues=%d\n",
+		   atomic_read(&tags->pending_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e55a6834c9a6..77c723bdfd5c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -73,6 +73,43 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
+/*
+ * Called when hctx failed to get driver tag
+ */
+void __blk_mq_dtag_wait(struct blk_mq_hw_ctx *hctx)
+{
+	if (blk_mq_is_shared_tags(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+
+		if (!test_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags) &&
+		    !test_and_set_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags))
+			atomic_inc(&hctx->tags->pending_queues);
+	} else {
+		if (!test_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state) &&
+		    !test_and_set_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+			atomic_inc(&hctx->tags->pending_queues);
+	}
+}
+
+/* Called when busy queue goes inactive */
+void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+
+	if (blk_mq_is_shared_tags(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+
+		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_WAIT,
+					&q->queue_flags))
+			return;
+	} else {
+		if (!test_and_clear_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+			return;
+	}
+
+	atomic_dec(&tags->pending_queues);
+}
+
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 5668e28be0b7..3fe013aee9a2 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -47,15 +47,17 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
-extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+extern bool __blk_mq_tag_wait(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return false;
 
-	return __blk_mq_tag_busy(hctx);
+	return __blk_mq_tag_wait(hctx);
 }
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
@@ -66,6 +68,22 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	__blk_mq_tag_idle(hctx);
 }
 
+static inline void blk_mq_dtag_wait(struct blk_mq_hw_ctx *hctx)
+{
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+		return;
+
+	__blk_mq_dtag_wait(hctx);
+}
+
+static inline void blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+		return;
+
+	__blk_mq_dtag_idle(hctx);
+}
+
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d319ffa59354..68b1602d9d60 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -666,6 +666,9 @@ enum {
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
 
+	/* hw queue is waiting for driver tag */
+	BLK_MQ_S_DTAG_WAIT	= 4,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
@@ -724,7 +727,16 @@ struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
 
+	/*
+	 * If multiple queues share a tag set, record the number of queues that
+	 * issued io recently.
+	 */
 	atomic_t active_queues;
+	/*
+	 * If multiple queues share a tag set, record the number of queues that
+	 * can't get driver tag.
+	 */
+	atomic_t pending_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c95df26fc26..787bfb18ce79 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -412,6 +412,8 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_HCTX_WAIT	30	/* at least one blk-mq hctx can't get
+					   driver tag */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.31.1

