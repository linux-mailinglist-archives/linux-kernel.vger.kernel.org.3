Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981F4DC488
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiCQLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiCQLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:13:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7961CAF1D;
        Thu, 17 Mar 2022 04:11:48 -0700 (PDT)
Received: from kwepemi500018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK4D8262TzCqjx;
        Thu, 17 Mar 2022 19:09:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500018.china.huawei.com (7.221.188.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 19:11:46 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 19:11:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <mpatocka@redhat.com>, <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/3] block: factor out common code for part_stat_show() and diskstats_show()
Date:   Thu, 17 Mar 2022 19:26:52 +0800
Message-ID: <20220317112653.1019490-3-yukuai3@huawei.com>
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

part_stat_show() and diskstats_show() are very similar, just factor out
common code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 130 +++++++++++++++++++-------------------------------
 1 file changed, 49 insertions(+), 81 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e5307f512185..f2c7de2e7ca9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -53,6 +53,30 @@ static atomic64_t diskseq;
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
 
+#define part_stat_info(inflight, stat) \
+	"%lu %lu %llu %u " \
+	"%lu %lu %llu %u " \
+	"%u %u %u " \
+	"%lu %lu %llu %u " \
+	"%lu %u" \
+	"\n", \
+	(stat).ios[STAT_READ], (stat).merges[STAT_READ], \
+	(unsigned long long)(stat).sectors[STAT_READ], \
+	(unsigned int)div_u64((stat).nsecs[STAT_READ], NSEC_PER_MSEC), \
+	(stat).ios[STAT_WRITE], (stat).merges[STAT_WRITE], \
+	(unsigned long long)(stat).sectors[STAT_WRITE], \
+	(unsigned int)div_u64((stat).nsecs[STAT_WRITE], NSEC_PER_MSEC), \
+	(inflight), jiffies_to_msecs((stat).io_ticks), \
+	(unsigned int)div_u64((stat).nsecs[STAT_READ] + \
+			      (stat).nsecs[STAT_WRITE] + \
+			      (stat).nsecs[STAT_DISCARD] + \
+			      (stat).nsecs[STAT_FLUSH], NSEC_PER_MSEC), \
+	(stat).ios[STAT_DISCARD], (stat).merges[STAT_DISCARD], \
+	(unsigned long long)(stat).sectors[STAT_DISCARD], \
+	(unsigned int)div_u64((stat).nsecs[STAT_DISCARD], NSEC_PER_MSEC), \
+	(stat).ios[STAT_FLUSH], \
+	(unsigned int)div_u64((stat).nsecs[STAT_FLUSH], NSEC_PER_MSEC)
+
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
 	struct block_device *bdev = disk->part0;
@@ -929,17 +953,13 @@ ssize_t part_size_show(struct device *dev,
 	return sprintf(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
 }
 
-ssize_t part_stat_show(struct device *dev,
-		       struct device_attribute *attr, char *buf)
+static unsigned int part_get_stat(struct block_device *bdev,
+				  struct disk_stats *stat)
+
 {
-	struct block_device *bdev = dev_to_bdev(dev);
 	struct request_queue *q = bdev_get_queue(bdev);
-	struct disk_stats stat;
 	unsigned int inflight;
 
-	if (!blk_queue_io_stat(q))
-		return sprintf(buf, "io accounting is disabled\n");
-
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, bdev);
 	else
@@ -950,35 +970,23 @@ ssize_t part_stat_show(struct device *dev,
 		update_io_ticks(bdev, jiffies, true);
 		part_stat_unlock();
 	}
-	part_stat_read_all(bdev, &stat);
-	return sprintf(buf,
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8u"
-		"\n",
-		stat.ios[STAT_READ],
-		stat.merges[STAT_READ],
-		(unsigned long long)stat.sectors[STAT_READ],
-		(unsigned int)div_u64(stat.nsecs[STAT_READ], NSEC_PER_MSEC),
-		stat.ios[STAT_WRITE],
-		stat.merges[STAT_WRITE],
-		(unsigned long long)stat.sectors[STAT_WRITE],
-		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
-		inflight,
-		jiffies_to_msecs(stat.io_ticks),
-		(unsigned int)div_u64(stat.nsecs[STAT_READ] +
-				      stat.nsecs[STAT_WRITE] +
-				      stat.nsecs[STAT_DISCARD] +
-				      stat.nsecs[STAT_FLUSH],
-						NSEC_PER_MSEC),
-		stat.ios[STAT_DISCARD],
-		stat.merges[STAT_DISCARD],
-		(unsigned long long)stat.sectors[STAT_DISCARD],
-		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC),
-		stat.ios[STAT_FLUSH],
-		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
+	part_stat_read_all(bdev, stat);
+
+	return inflight;
+}
+
+ssize_t part_stat_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct disk_stats stat;
+	unsigned int inflight;
+
+	if (!blk_queue_io_stat(bdev_get_queue(bdev)))
+		return sprintf(buf, "io accounting is disabled\n");
+
+	inflight = part_get_stat(bdev, &stat);
+	return sprintf(buf, part_stat_info(inflight, stat));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
@@ -1212,51 +1220,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			continue;
 		if (!blk_queue_io_stat(gp->queue))
 			continue;
-		if (queue_is_mq(gp->queue))
-			inflight = blk_mq_in_flight(gp->queue, hd);
-		else
-			inflight = part_in_flight(hd);
-
-		if (inflight) {
-			part_stat_lock();
-			update_io_ticks(hd, jiffies, true);
-			part_stat_unlock();
-		}
-		part_stat_read_all(hd, &stat);
-		seq_printf(seqf, "%4d %7d %pg "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
-			   "%u %u %u "
-			   "%lu %lu %lu %u "
-			   "%lu %u"
-			   "\n",
-			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), hd,
-			   stat.ios[STAT_READ],
-			   stat.merges[STAT_READ],
-			   stat.sectors[STAT_READ],
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_WRITE],
-			   stat.merges[STAT_WRITE],
-			   stat.sectors[STAT_WRITE],
-			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
-							NSEC_PER_MSEC),
-			   inflight,
-			   jiffies_to_msecs(stat.io_ticks),
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
-						 stat.nsecs[STAT_WRITE] +
-						 stat.nsecs[STAT_DISCARD] +
-						 stat.nsecs[STAT_FLUSH],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_DISCARD],
-			   stat.merges[STAT_DISCARD],
-			   stat.sectors[STAT_DISCARD],
-			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
-						 NSEC_PER_MSEC),
-			   stat.ios[STAT_FLUSH],
-			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
-						 NSEC_PER_MSEC)
-			);
+
+		inflight = part_get_stat(hd, &stat);
+		seq_printf(seqf, "%4d %7d %pg ",
+			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), hd);
+		seq_printf(seqf, part_stat_info(inflight, stat));
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

