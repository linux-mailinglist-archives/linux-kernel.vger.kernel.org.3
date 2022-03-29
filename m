Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC494EAA82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiC2J1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiC2J1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239098590;
        Tue, 29 Mar 2022 02:25:59 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSPJz5LcpzfZY9;
        Tue, 29 Mar 2022 17:24:19 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:57 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Date:   Tue, 29 Mar 2022 17:40:44 +0800
Message-ID: <20220329094048.2107094-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329094048.2107094-1-yukuai3@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the splited bio is handled first, and then continue to split
the original bio. This patch tries to split the original bio thoroughly,
so that it can be known in advance how many tags will be needed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bio.c               |  2 +
 block/blk-merge.c         | 90 ++++++++++++++++++++++++++++-----------
 block/blk-mq.c            |  7 ++-
 block/blk.h               |  3 +-
 include/linux/blk_types.h |  4 ++
 5 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index cdd7b2915c53..ac7ce8b4ba42 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -258,6 +258,8 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
 	bio->bi_status = 0;
+	bio->bi_nr_segs = 0;
+	bio->bi_nr_split = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
 	bio->bi_iter.bi_idx = 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..340860746cac 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -309,44 +309,85 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
-/**
- * __blk_queue_split - split a bio and submit the second half
- * @q:       [in] request_queue new bio is being queued at
- * @bio:     [in, out] bio to be split
- * @nr_segs: [out] number of segments in the first bio
- *
- * Split a bio into two bios, chain the two bios, submit the second half and
- * store a pointer to the first half in *@bio. If the second bio is still too
- * big it will be split by a recursive call to this function. Since this
- * function may allocate a new bio from q->bio_split, it is the responsibility
- * of the caller to ensure that q->bio_split is only released after processing
- * of the split bio has finished.
- */
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
-		       unsigned int *nr_segs)
+static struct bio *blk_queue_split_one(struct request_queue *q, struct bio *bio)
 {
 	struct bio *split = NULL;
+	unsigned int nr_segs = 1;
 
-	switch (bio_op(*bio)) {
+	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
+		split = blk_bio_discard_split(q, bio, &q->bio_split, &nr_segs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
-				nr_segs);
+		split = blk_bio_write_zeroes_split(q, bio, &q->bio_split,
+				&nr_segs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
+		split = blk_bio_segment_split(q, bio, &q->bio_split, &nr_segs);
 		break;
 	}
 
 	if (split) {
 		/* there isn't chance to merge the splitted bio */
-		split->bi_opf |= REQ_NOMERGE;
+		split->bi_opf |= (REQ_NOMERGE | REQ_SPLIT);
+		split->bi_nr_segs = nr_segs;
+
+		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
+	} else {
+		bio->bi_nr_segs = nr_segs;
+	}
+
+	return split;
+}
+
+static unsigned short blk_queue_split_all(struct request_queue *q,
+					  struct bio *bio)
+{
+	struct bio *split = NULL;
+	struct bio *first = NULL;
+	unsigned short nr_split = 1;
+	unsigned short total;
 
-		bio_chain(split, *bio);
-		trace_block_split(split, (*bio)->bi_iter.bi_sector);
+	if (!current->bio_list)
+		return 1;
+
+	while ((split = blk_queue_split_one(q, bio))) {
+		if (!first)
+			first = split;
+
+		nr_split++;
+		submit_bio_noacct(split);
+	}
+
+	total = nr_split;
+	while (first) {
+		first->bi_nr_split = --total;
+		first = first->bi_next;
+	}
+
+	return nr_split;
+}
+
+/**
+ * __blk_queue_split - split a bio, store the first and submit others
+ * @q:       [in] request_queue new bio is being queued at
+ * @bio:     [in, out] bio to be split
+ *
+ * Split a bio into several bios, chain all the bios, store a pointer to the
+ * first in *@bio, and submit others. Since this function may allocate a new
+ * bio from q->bio_split, it is the responsibility of the caller to ensure
+ * that q->bio_split is only released after processing of the split bio has
+ * finished.
+ */
+void __blk_queue_split(struct request_queue *q, struct bio **bio)
+{
+	struct bio *split = blk_queue_split_one(q, *bio);
+
+	if (split) {
+		split->bi_nr_split = blk_queue_split_all(q, *bio);
+		(*bio)->bi_opf |= REQ_SPLIT;
 		submit_bio_noacct(*bio);
 		*bio = split;
 	}
@@ -365,10 +406,9 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 void blk_queue_split(struct bio **bio)
 {
 	struct request_queue *q = bdev_get_queue((*bio)->bi_bdev);
-	unsigned int nr_segs;
 
 	if (blk_may_split(q, *bio))
-		__blk_queue_split(q, bio, &nr_segs);
+		__blk_queue_split(q, bio);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e6f24fa4a4c2..cad207d2079e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2817,8 +2817,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	if (blk_may_split(q, bio))
-		__blk_queue_split(q, &bio, &nr_segs);
+	if (blk_may_split(q, bio)) {
+		if (!(bio->bi_opf & REQ_SPLIT))
+			__blk_queue_split(q, &bio);
+		nr_segs = bio->bi_nr_segs;
+	}
 
 	if (!bio_integrity_prep(bio))
 		return;
diff --git a/block/blk.h b/block/blk.h
index 8ccbc6e07636..cd478187b525 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -303,8 +303,7 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
-void __blk_queue_split(struct request_queue *q, struct bio **bio,
-			unsigned int *nr_segs);
+void __blk_queue_split(struct request_queue *q, struct bio **bio);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dd0763a1c674..702f6b83dc88 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -250,6 +250,8 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
+	unsigned int		bi_nr_segs;
+	unsigned int		bi_nr_split;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
@@ -416,6 +418,7 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_SPLIT,		/* io is split */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -440,6 +443,7 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_SPLIT		(1ULL << __REQ_SPLIT)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.31.1

