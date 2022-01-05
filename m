Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167AC484CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiAEDlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:41:32 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31070 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiAEDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:41:32 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JTFYl2xWYz1DKSn;
        Wed,  5 Jan 2022 11:38:03 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:41:28 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 11:41:28 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next V2] blk-mq: fix tag_get wait task can't be awakened
Date:   Wed, 5 Jan 2022 11:56:44 +0800
Message-ID: <20220105035644.3311480-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of shared tags, there might be more than one hctx which
allocates tag from single tags, and each hctx is limited to allocate at
most:
        hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);

tag idle detection is lazy, and may be delayed for 30sec, so there
could be just one real active hctx(queue) but all others are actually
idle and still accounted as active because of the lazy idle detection.
Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
forever on this real active hctx.

Fix this by recalculating wake_batch when inc or dec active_queues.

Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/blk-mq-tag.c      | 27 ++++++++++++++++++++++++++-
 include/linux/sbitmap.h | 11 +++++++++++
 lib/sbitmap.c           | 22 +++++++++++++++++++---
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index ae722f8b13fb..df072153c81b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -15,6 +15,21 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
+/*
+ * Recalculate wakeup batch when tag is shared by hctx.
+ */
+static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
+		unsigned int users)
+{
+	if (!users)
+		return;
+
+	sbitmap_queue_recalculate_wake_batch(&tags->bitmap_tags,
+			users);
+	sbitmap_queue_recalculate_wake_batch(&tags->breserved_tags,
+			users);
+}
+
 /*
  * If a previously inactive queue goes active, bump the active user count.
  * We need to do this before try to allocate driver tag, then even if fail
@@ -23,10 +38,16 @@
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
+	unsigned int users;
+
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
-	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
 		atomic_inc(&hctx->tags->active_queues);
 
+		users = atomic_read(&hctx->tags->active_queues);
+		blk_mq_update_wake_batch(hctx->tags, users);
+	}
+
 	return true;
 }
 
@@ -47,12 +68,16 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
+	unsigned int users;
 
 	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return;
 
 	atomic_dec(&tags->active_queues);
 
+	users = atomic_read(&hctx->tags->active_queues);
+	blk_mq_update_wake_batch(hctx->tags, users);
+
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e40d019c3d9d..62ead1e69e17 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -378,6 +378,17 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 	sbitmap_free(&sbq->sb);
 }
 
+/**
+ * sbitmap_queue_recalculate_wake_batch() - Recalculate wake batch
+ * @sbq: Bitmap queue to Recalculate wake batch.
+ * @users: Number of shares.
+ *
+ * Like sbitmap_queue_update_wake_batch(), this will calculate wake batch
+ * by depth. This interface is for sharing tags.
+ */
+void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
+					    unsigned int users);
+
 /**
  * sbitmap_queue_resize() - Resize a &struct sbitmap_queue.
  * @sbq: Bitmap queue to resize.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af88d1346dd7..aeee5fbd998d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -392,10 +392,9 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
 
-static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
-					    unsigned int depth)
+static inline void __sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
+					    unsigned int wake_batch)
 {
-	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
 	int i;
 
 	if (sbq->wake_batch != wake_batch) {
@@ -411,6 +410,23 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
 	}
 }
 
+static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
+					    unsigned int depth)
+{
+	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
+
+	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
+}
+
+void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
+					    unsigned int users)
+{
+	unsigned int wake_batch = clamp_t(unsigned int,
+			(sbq->sb.depth + users - 1) / users, 4U, SBQ_WAKE_BATCH);
+	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
+
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 {
 	sbitmap_queue_update_wake_batch(sbq, depth);
-- 
2.22.0

