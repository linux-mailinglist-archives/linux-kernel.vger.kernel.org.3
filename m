Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31EB46452E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbhLAC72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:59:28 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28134 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbhLAC7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:59:22 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J3kDH6rP1z1DJ7J;
        Wed,  1 Dec 2021 10:53:19 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 10:56:00 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <song@kernel.org>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <mcgrof@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>
Subject: [PATCH] md: Fix unexpected behaviour in is_mddev_idle
Date:   Wed, 1 Dec 2021 11:27:12 +0800
Message-ID: <20211201032712.3684503-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of curr_events may be INT_MAX when mddev initializes IO event
counters. Then, rdev->last_events will be set as INT_MAX. 
If all the rdevs of mddev are in this case, 
'curr_events - rdev->last_events > 64' will always false, and
is_mddev_idle() will always return 1, which may cause non-sync IO very
slow.

Fix by using atomic64_t type for sync_io, and using long type for
curr_events/last_events.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 drivers/md/md.c       | 6 +++---
 drivers/md/md.h       | 4 ++--
 include/linux/genhd.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5111ed966947..f47035838c43 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 {
 	struct md_rdev *rdev;
 	int idle;
-	int curr_events;
+	long curr_events;
 
 	idle = 1;
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
-		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			      atomic_read(&disk->sync_io);
+		curr_events = (long)part_stat_read_accum(disk->part0, sectors) -
+			      atomic64_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
 		 * disk_stats is counted when it completes.
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 53ea7a6961de..3f8327c42b7b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -50,7 +50,7 @@ struct md_rdev {
 
 	sector_t sectors;		/* Device size (in 512bytes sectors) */
 	struct mddev *mddev;		/* RAID array if running */
-	int last_events;		/* IO event timestamp */
+	long last_events;		/* IO event timestamp */
 sync_io
 	/*
 	 * If meta_bdev is non-NULL, it means that a separate device is
@@ -551,7 +551,7 @@ extern void mddev_unlock(struct mddev *mddev);
 
 static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
 {
-	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
+	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
 }
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 74c410263113..efa7884de11b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -150,7 +150,7 @@ struct gendisk {
 	struct list_head slave_bdevs;
 #endif
 	struct timer_rand_state *random;
-	atomic_t sync_io;		/* RAID */
+	atomic64_t sync_io;		/* RAID */
 	struct disk_events *ev;
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
-- 
2.31.1

