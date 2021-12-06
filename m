Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A446960B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbhLFM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:58:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4205 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbhLFM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:58:35 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73FV4rZ7z688JV;
        Mon,  6 Dec 2021 20:50:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:55:04 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 12:55:02 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 2/3] blk-mq: Delete busy_iter_fn
Date:   Mon, 6 Dec 2021 20:49:49 +0800
Message-ID: <1638794990-137490-3-git-send-email-john.garry@huawei.com>
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

Typedefs busy_iter_fn and busy_tag_iter_fn are now identical, so delete
busy_iter_fn to reduce duplication.

It would be nicer to delete busy_tag_iter_fn, as the name busy_iter_fn is
less specific.

However busy_tag_iter_fn is used in many different parts of the tree,
unlike busy_iter_fn which is just use in block/, so just take the
straightforward path now, so that we could rename later treewide.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 block/blk-mq-tag.c     | 6 +++---
 block/blk-mq-tag.h     | 2 +-
 include/linux/blk-mq.h | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d3cf91d764d5..58b80d4b7a07 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -215,7 +215,7 @@ void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
 
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
-	busy_iter_fn *fn;
+	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
 };
@@ -274,7 +274,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_iter_fn *fn, void *data, bool reserved)
+			busy_tag_iter_fn *fn, void *data, bool reserved)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
@@ -457,7 +457,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * called for all requests on all queues that share that tag set and not only
  * for requests associated with @q.
  */
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index df787b5a23bd..5668e28be0b7 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -28,7 +28,7 @@ extern void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 extern void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
 
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv);
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 17ebf29e42d8..772f8f921526 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -470,7 +470,6 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef bool (busy_iter_fn)(struct request *, void *, bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 
 /**
-- 
2.26.2

