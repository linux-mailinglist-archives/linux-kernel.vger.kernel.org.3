Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC454DC48A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiCQLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiCQLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:13:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE81DBA8D;
        Thu, 17 Mar 2022 04:11:48 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KK4Dp3NtjzfYmZ;
        Thu, 17 Mar 2022 19:10:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 19:11:46 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 19:11:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <mpatocka@redhat.com>, <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 3/3] block: update nsecs[] in part_get_stat()
Date:   Thu, 17 Mar 2022 19:26:53 +0800
Message-ID: <20220317112653.1019490-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317112653.1019490-1-yukuai3@huawei.com>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
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

commit 86d7331299fd("block: update io_ticks when io hang") fixed that
%util will be zero for iostat when io is hanged, however, avgqu-sz is
still zero while it represents the number of io that are hunged. On the
other hand, for some slow device, if an io is started before and done
after diskstats is read, the avgqu-sz will be miscalculated.

To fix the problem, update 'nsecs[]' when part_stat_show() or
diskstats_show() is called. In order to do that, add 'stat_time' in
struct block_device and 'rq_stat_time' in struct request to record the
time. And during iteration, update 'nsecs[]' for each inflight request.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c              |  2 ++
 block/blk-mq.c            | 63 ++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.h            |  2 ++
 block/genhd.c             | 25 ++++++++++++++--
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  5 ++++
 6 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 13de871fa816..5dced478f190 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -487,9 +487,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev = I_BDEV(inode);
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
+	spin_lock_init(&bdev->bd_stat_lock);
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
+	bdev->stat_time = 0;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c33fb378b168..7a14d4058b14 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -149,6 +149,48 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
 	return mi.inflight[0] + mi.inflight[1];
 }
 
+static bool blk_mq_check_inflight_stat(struct request *rq, void *priv,
+				       bool reserved)
+{
+	struct mq_inflight *mi = priv;
+
+	if ((!mi->part->bd_partno || rq->part == mi->part) &&
+	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
+		u64 stat_time;
+
+		mi->inflight[rq_data_dir(rq)]++;
+		if (!rq->part)
+			return true;
+
+		stat_time = READ_ONCE(rq->stat_time_ns);
+		/*
+		 * This might fail if 'req->stat_time_ns' happen to be updated
+		 * in blk_account_io_done().
+		 */
+		if (likely(cmpxchg(&rq->stat_time_ns, stat_time,
+			    rq->part->stat_time) == stat_time)) {
+			int sgrp = op_stat_group(req_op(rq));
+			u64 duation = stat_time ?
+				rq->part->stat_time - stat_time :
+				rq->part->stat_time - rq->start_time_ns;
+
+			part_stat_add(rq->part, nsecs[sgrp], duation);
+		}
+	}
+
+	return true;
+}
+
+unsigned int blk_mq_in_flight_stat(struct request_queue *q,
+		struct block_device *part)
+{
+	struct mq_inflight mi = { .part = part };
+
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_stat, &mi);
+
+	return mi.inflight[0] + mi.inflight[1];
+}
+
 void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 		unsigned int inflight[2])
 {
@@ -368,6 +410,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->start_time_ns = ktime_get_ns();
 	else
 		rq->start_time_ns = 0;
+	rq->stat_time_ns = 0;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	rq->alloc_time_ns = alloc_time_ns;
@@ -874,7 +917,25 @@ static void __blk_account_io_done(struct request *req, u64 now)
 	part_stat_lock();
 	update_io_ticks(req->part, jiffies, true);
 	part_stat_inc(req->part, ios[sgrp]);
-	part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+
+	if (queue_is_mq(req->q)) {
+		u64 stat_time = READ_ONCE(req->stat_time_ns);
+
+		/*
+		 * This might fail if 'req->stat_time_ns' happen to be updated
+		 * in part_get_stat().
+		 */
+		if (likely(cmpxchg(&req->stat_time_ns, stat_time, now) ==
+			   stat_time)) {
+			u64 duation = stat_time ? now - stat_time :
+						  now - req->start_time_ns;
+
+			part_stat_add(req->part, nsecs[sgrp], duation);
+		}
+	} else {
+		part_stat_add(req->part, nsecs[sgrp],
+			      now - req->part->stat_time);
+	}
 	part_stat_unlock();
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 7d1acf8e1e51..37941f5f1d08 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -189,6 +189,8 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 
 unsigned int blk_mq_in_flight(struct request_queue *q,
 		struct block_device *part);
+unsigned int blk_mq_in_flight_stat(struct request_queue *q,
+		struct block_device *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 		unsigned int inflight[2]);
 
diff --git a/block/genhd.c b/block/genhd.c
index f2c7de2e7ca9..31603c7aff49 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -953,6 +953,19 @@ ssize_t part_size_show(struct device *dev,
 	return sprintf(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
 }
 
+static void part_set_stat_time(struct block_device *part)
+{
+	u64 now = ktime_get_ns();
+
+again:
+	part->stat_time = now;
+
+	if (part->bd_partno) {
+		part = bdev_whole(part);
+		goto again;
+	}
+}
+
 static unsigned int part_get_stat(struct block_device *bdev,
 				  struct disk_stats *stat)
 
@@ -960,10 +973,16 @@ static unsigned int part_get_stat(struct block_device *bdev,
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int inflight;
 
-	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, bdev);
-	else
+	if (queue_is_mq(q)) {
+		spin_lock(&bdev->bd_stat_lock);
+		part_stat_lock();
+		part_set_stat_time(bdev);
+		inflight = blk_mq_in_flight_stat(q, bdev);
+		part_stat_unlock();
+		spin_unlock(&bdev->bd_stat_lock);
+	} else {
 		inflight = part_in_flight(bdev);
+	}
 
 	if (inflight) {
 		part_stat_lock();
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e512da636e0f..e98f07d1741c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -108,6 +108,8 @@ struct request {
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
+	/* Time that I/O was accounted in part_get_stat() */
+	u64 stat_time_ns;
 
 #ifdef CONFIG_BLK_WBT
 	unsigned short wbt_flags;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c6ed4a559e6a..5cd399b5670d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -65,6 +65,11 @@ struct block_device {
 	struct super_block	*bd_fsfreeze_sb;
 
 	struct partition_meta_info *bd_meta_info;
+
+	/* Prevent part_get_stat() to be called concurrently */
+	spinlock_t		bd_stat_lock;
+	/* Will be set when part_stat_show() or diskstats_show() is called */
+	u64			stat_time;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
-- 
2.31.1

