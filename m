Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7443A49AFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457838AbiAYJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:17:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35864 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449145AbiAYJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:09:03 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JjgxM0YnMzccdv;
        Tue, 25 Jan 2022 17:08:07 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 17:08:55 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] block: update io_ticks when io hang
Date:   Tue, 25 Jan 2022 17:19:38 +0800
Message-ID: <20220125091938.1799001-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
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
 block/genhd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..df0656ffb4ad 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -913,12 +913,14 @@ ssize_t part_stat_show(struct device *dev,
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	part_stat_read_all(bdev, &stat);
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, bdev);
 	else
 		inflight = part_in_flight(bdev);
 
+	if (inflight)
+		update_io_ticks(bdev, jiffies, true);
+	part_stat_read_all(bdev, &stat);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
@@ -1174,12 +1176,14 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
-		part_stat_read_all(hd, &stat);
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
 			inflight = part_in_flight(hd);
 
+		if (inflight)
+			update_io_ticks(hd, jiffies, true);
+		part_stat_read_all(hd, &stat);
 		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
-- 
2.31.1

