Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF25027BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352012AbiDOJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351948AbiDOJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:59:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE01BA32E;
        Fri, 15 Apr 2022 02:56:31 -0700 (PDT)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfsB64NWrzhXZ3;
        Fri, 15 Apr 2022 17:54:38 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 7/8] blk-mq: record how many tags are needed for splited bio
Date:   Fri, 15 Apr 2022 18:10:52 +0800
Message-ID: <20220415101053.554495-8-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220415101053.554495-1-yukuai3@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Currently, each time 8(or wake batch) requests is done, 8 waiters will
be woken up, this is not necessary because we only need to make sure
wakers will use up 8 tags. For example, if we know in advance that a
thread need 8 tags, then wake up one thread is enough, and this can also
avoid unnecessary context switch.

On the other hand, sequential io is much faster than random io, thus
it's better to issue split io continuously.

This patch tries to provide such information that how many tags will
be needed for huge io, and it will be used in next patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c      |  1 +
 block/blk-mq.c          | 24 +++++++++++++++++++++---
 block/blk-mq.h          |  2 ++
 include/linux/sbitmap.h |  2 ++
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d02710cf3355..70ce98a5c32b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -165,6 +165,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			return BLK_MQ_NO_TAG;
 	}
 
+	wait.nr_tags += data->nr_split;
 	do {
 		struct sbitmap_queue *bt_prev;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a889f01d2cdf..ac614a379a6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2760,12 +2760,14 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
 					       struct bio *bio,
-					       unsigned int nsegs)
+					       unsigned int nsegs,
+					       unsigned int nr_split)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.nr_tags	= 1,
 		.cmd_flags	= bio->bi_opf,
+		.nr_split	= nr_split,
 		.preempt	= (bio->bi_opf & REQ_PREEMPT),
 	};
 	struct request *rq;
@@ -2824,6 +2826,19 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
+static inline unsigned int caculate_sectors_split(struct bio *bio)
+{
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
+		return 0;
+	default:
+		return (bio_sectors(bio) - 1) /
+			queue_max_sectors(bio->bi_bdev->bd_queue);
+	}
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2844,11 +2859,14 @@ void blk_mq_submit_bio(struct bio *bio)
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct request *rq;
 	unsigned int nr_segs = 1;
+	unsigned int nr_split = 0;
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	if (blk_may_split(q, bio))
+	if (blk_may_split(q, bio)) {
+		nr_split = caculate_sectors_split(bio);
 		__blk_queue_split(q, &bio, &nr_segs);
+	}
 
 	if (!bio_integrity_prep(bio))
 		return;
@@ -2857,7 +2875,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq) {
 		if (!bio)
 			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs, nr_split);
 		if (unlikely(!rq))
 			return;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1a85bd1045d8..9bad3057c1f3 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -156,6 +156,8 @@ struct blk_mq_alloc_data {
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
+	/* number of ios left after this io is handled */
+	unsigned int nr_split;
 	/* true if blk_mq_get_tag() will try to preempt tag */
 	bool preempt;
 	struct request **cached_rq;
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index ca00ccb6af48..1abd8ed5d406 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -596,12 +596,14 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
 void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
 
 struct sbq_wait {
+	unsigned int nr_tags;
 	struct sbitmap_queue *sbq;	/* if set, sbq_wait is accounted */
 	struct wait_queue_entry wait;
 };
 
 #define DEFINE_SBQ_WAIT(name)							\
 	struct sbq_wait name = {						\
+		.nr_tags = 1,							\
 		.sbq = NULL,							\
 		.wait = {							\
 			.private	= current,				\
-- 
2.31.1

