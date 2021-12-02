Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2746640E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358172AbhLBM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:56:17 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29083 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358146AbhLBM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:56:09 -0500
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J4bQK6Q7Wz1DJpp;
        Thu,  2 Dec 2021 20:50:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 20:52:44 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 20:52:43 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@infradead.org>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v4 2/2] block: cancel all throttled bios in del_gendisk()
Date:   Thu, 2 Dec 2021 21:04:40 +0800
Message-ID: <20211202130440.1943847-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202130440.1943847-1-yukuai3@huawei.com>
References: <20211202130440.1943847-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throttled bios can't be issued after del_gendisk() is done, thus
it's better to cancel them immediately rather than waiting for
throttle is done.

For example, if user thread is throttled with low bps while it's
issuing large io, and the device is deleted. The user thread will
wait for a long time for io to return.

Noted this patch is mainly from revertion of commit 32e3374304c7
("blk-throttle: remove tg_drain_bios") and commit b77412372b68
("blk-throttle: remove blk_throtl_drain").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 73 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fdd57878e862..e60f690e01ad 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2256,6 +2256,75 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
+/*
+ * Dispatch all bios from all children tg's queued on @parent_sq.  On
+ * return, @parent_sq is guaranteed to not have any active children tg's
+ * and all bios from previously active tg's are on @parent_sq->bio_lists[].
+ */
+static void tg_drain_bios(struct throtl_service_queue *parent_sq)
+{
+	struct throtl_grp *tg;
+
+	while ((tg = throtl_rb_first(parent_sq))) {
+		struct throtl_service_queue *sq = &tg->service_queue;
+		struct bio *bio;
+
+		throtl_dequeue_tg(tg);
+
+		while ((bio = throtl_peek_queued(&sq->queued[READ])))
+			tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		while ((bio = throtl_peek_queued(&sq->queued[WRITE])))
+			tg_dispatch_one_bio(tg, bio_data_dir(bio));
+	}
+}
+
+/**
+ * blk_throtl_cancel_bios - cancel throttled bios
+ * @q: request_queue to cancel throttled bios for
+ *
+ * This function is called to error all currently throttled bios on @q.
+ */
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct throtl_data *td = q->td;
+	struct bio_list bio_list_on_stack;
+	struct blkcg_gq *blkg;
+	struct cgroup_subsys_state *pos_css;
+	struct bio *bio;
+	int rw;
+
+	bio_list_init(&bio_list_on_stack);
+
+	/*
+	 * hold queue_lock to prevent concurrent with dispatching
+	 * throttled bios by timer.
+	 */
+	spin_lock_irq(&q->queue_lock);
+
+	/*
+	 * Drain each tg while doing post-order walk on the blkg tree, so
+	 * that all bios are propagated to td->service_queue.  It'd be
+	 * better to walk service_queue tree directly but blkg walk is
+	 * easier.
+	 */
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
+		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
+
+	/* finally, transfer bios from top-level tg's into the td */
+	tg_drain_bios(&td->service_queue);
+
+	/* all bios now should be in td->service_queue, cancel them */
+	for (rw = READ; rw <= WRITE; rw++)
+		while ((bio = throtl_pop_queued(&td->service_queue.queued[rw],
+						NULL)))
+			bio_list_add(&bio_list_on_stack, bio);
+
+	spin_unlock_irq(&q->queue_lock);
+	if (!bio_list_empty(&bio_list_on_stack))
+		while ((bio = bio_list_pop(&bio_list_on_stack)))
+			bio_io_error(bio);
+}
+
 int blk_throtl_init(struct request_queue *q)
 {
 	struct throtl_data *td;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 175f03abd9e4..9d67d5139954 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -160,12 +160,14 @@ static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+#define blk_throtl_cancel_bios(q)  do { } while (0)
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
 void blk_throtl_charge_bio_split(struct bio *bio);
 bool __blk_throtl_bio(struct bio *bio);
+void blk_throtl_cancel_bios(struct request_queue *q);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
diff --git a/block/genhd.c b/block/genhd.c
index 8e9cbf23c510..24fa3356d164 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -28,6 +28,7 @@
 
 #include "blk.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 static struct kobject *block_depr;
 
@@ -619,6 +620,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_throtl_cancel_bios(q);
 	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
-- 
2.31.1

