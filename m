Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1046960C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbhLFM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:58:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4206 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbhLFM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:58:37 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73K72bFNz689QL;
        Mon,  6 Dec 2021 20:54:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:55:07 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 12:55:04 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Date:   Mon, 6 Dec 2021 20:49:50 +0800
Message-ID: <1638794990-137490-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kashyap reports high CPU usage in blk_mq_queue_tag_busy_iter() and callees
using megaraid SAS RAID card since moving to shared tags [0].

Previously, when shared tags was shared sbitmap, this function was less
than optimum since we would iter through all tags for all hctx's,
yet only ever match upto tagset depth number of rqs.

Since the change to shared tags, things are even less efficient if we have
parallel callers of blk_mq_queue_tag_busy_iter(). This is because in
bt_iter() -> blk_mq_find_and_get_req() there would be more contention on
accessing each request ref and tags->lock since they are now shared among
all HW queues.

Optimise by having separate calls to bt_for_each() for when we're using
shared tags. In this case no longer pass a hctx, as it is no longer
relevant, and teach bt_iter() about this.

Ming suggested something along the lines of this change, apart from a
different implementation.

[0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reported-and-tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 block/blk-mq-tag.c | 59 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 58b80d4b7a07..e55a6834c9a6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -215,6 +215,7 @@ void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
 
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
+	struct request_queue *q;
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
@@ -238,11 +239,18 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct blk_mq_tags *tags = hctx->tags;
+	struct request_queue *q = iter_data->q;
+	struct blk_mq_tag_set *set = q->tag_set;
 	bool reserved = iter_data->reserved;
+	struct blk_mq_tags *tags;
 	struct request *rq;
 	bool ret = true;
 
+	if (blk_mq_is_shared_tags(set->flags))
+		tags = set->shared_tags;
+	else
+		tags = hctx->tags;
+
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
 	/*
@@ -253,7 +261,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
-	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+	if (rq->q == q && (!hctx || rq->mq_hctx == hctx))
 		ret = iter_data->fn(rq, iter_data->data, reserved);
 	blk_mq_put_rq_ref(rq);
 	return ret;
@@ -262,6 +270,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 /**
  * bt_for_each - iterate over the requests associated with a hardware queue
  * @hctx:	Hardware queue to examine.
+ * @q:		Request queue to examine.
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each request
@@ -273,14 +282,16 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @reserved:	Indicates whether @bt is the breserved_tags member or the
  *		bitmap_tags member of struct blk_mq_tags.
  */
-static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_tag_iter_fn *fn, void *data, bool reserved)
+static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct request_queue *q,
+			struct sbitmap_queue *bt, busy_tag_iter_fn *fn,
+			void *data, bool reserved)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.q = q,
 	};
 
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
@@ -460,9 +471,6 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
@@ -471,19 +479,34 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
-
-		/*
-		 * If no software queues are currently mapped to this
-		 * hardware queue, there's nothing to check
-		 */
-		if (!blk_mq_hw_queue_mapped(hctx))
-			continue;
+	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
+		struct blk_mq_tags *tags = q->tag_set->shared_tags;
+		struct sbitmap_queue *bresv = &tags->breserved_tags;
+		struct sbitmap_queue *btags = &tags->bitmap_tags;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(NULL, q, bresv, fn, priv, true);
+		bt_for_each(NULL, q, btags, fn, priv, false);
+	} else {
+		struct blk_mq_hw_ctx *hctx;
+		int i;
+
+		queue_for_each_hw_ctx(q, hctx, i) {
+			struct blk_mq_tags *tags = hctx->tags;
+			struct sbitmap_queue *bresv = &tags->breserved_tags;
+			struct sbitmap_queue *btags = &tags->bitmap_tags;
+
+			/*
+			 * If no software queues are currently mapped to this
+			 * hardware queue, there's nothing to check
+			 */
+			if (!blk_mq_hw_queue_mapped(hctx))
+				continue;
+
+			if (tags->nr_reserved_tags)
+				bt_for_each(hctx, q, bresv, fn, priv, true);
+			bt_for_each(hctx, q, btags, fn, priv, false);
+		}
 	}
 	blk_queue_exit(q);
 }
-- 
2.26.2

