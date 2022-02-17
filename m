Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C374B96E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiBQDrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBQDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:47:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501EC0506;
        Wed, 16 Feb 2022 19:47:04 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jzghz3n30zbnZq;
        Thu, 17 Feb 2022 11:45:55 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 17 Feb 2022 11:47:01 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] block: update io_ticks when io hang
Date:   Thu, 17 Feb 2022 12:02:45 +0800
Message-ID: <20220217040245.3886752-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the inflight IOs are slow and no new IOs are issued, we expect
iostat could manifest the IO hang problem. However after
commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
precise counting"), io_tick and time_in_queue will not be updated until
the end of IO, and the avgqu-sz and %util columns of iostat will be zero.

Because it has using stat.nsecs accumulation to express time_in_queue
which is not suitable to change, and may %util will express the status
better when io hang occur. To fix io_ticks, we use update_io_ticks and
inflight to update io_ticks when diskstats_show and part_stat_show
been called.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 block/genhd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---
v2:
* add part_stat_lock() & part_stat_unlock() to protect update_io_ticks().
v1: https://www.spinics.net/lists/linux-block/msg78931.html

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..781dc78f97d8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -913,12 +913,17 @@ ssize_t part_stat_show(struct device *dev,
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	part_stat_read_all(bdev, &stat);
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, bdev);
 	else
 		inflight = part_in_flight(bdev);
 
+	if (inflight) {
+		part_stat_lock();
+		update_io_ticks(bdev, jiffies, true);
+		part_stat_unlock();
+	}
+	part_stat_read_all(bdev, &stat);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
@@ -1174,12 +1179,17 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
-		part_stat_read_all(hd, &stat);
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
 			inflight = part_in_flight(hd);
 
+		if (inflight) {
+			part_stat_lock();
+			update_io_ticks(hd, jiffies, true);
+			part_stat_unlock();
+		}
+		part_stat_read_all(hd, &stat);
 		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
-- 
2.31.1

