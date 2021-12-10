Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8F46FA00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhLJEtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:49:53 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28299 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhLJEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:49:46 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J9JJ33z8zzbhxp;
        Fri, 10 Dec 2021 12:45:55 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 12:46:09 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <song@kernel.org>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <mcgrof@kernel.org>, <mcroce@microsoft.com>
CC:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <drbd-dev@lists.linbit.com>,
        <linfeilong@huawei.com>
Subject: [PATCH v2 1/3] md: Fix undefined behaviour in is_mddev_idle
Date:   Fri, 10 Dec 2021 13:17:05 +0800
Message-ID: <20211210051707.2202646-2-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210051707.2202646-1-lijinlin3@huawei.com>
References: <20211210051707.2202646-1-lijinlin3@huawei.com>
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

UBSAN reports this problem:

[ 5984.281385] UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
[ 5984.281390] signed integer overflow:
[ 5984.281393] -2147483291 - 2072033152 cannot be represented in type 'int'
[ 5984.281400] CPU: 25 PID: 1854 Comm: md101_resync Kdump: loaded Not tainted 4.19.90
[ 5984.281404] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDDA
[ 5984.281406] Call trace:
[ 5984.281415]  dump_backtrace+0x0/0x310
[ 5984.281418]  show_stack+0x28/0x38
[ 5984.281425]  dump_stack+0xec/0x15c
[ 5984.281430]  ubsan_epilogue+0x18/0x84
[ 5984.281434]  handle_overflow+0x14c/0x19c
[ 5984.281439]  __ubsan_handle_sub_overflow+0x34/0x44
[ 5984.281445]  is_mddev_idle+0x338/0x3d8
[ 5984.281449]  md_do_sync+0x1bb8/0x1cf8
[ 5984.281452]  md_thread+0x220/0x288
[ 5984.281457]  kthread+0x1d8/0x1e0
[ 5984.281461]  ret_from_fork+0x10/0x18

When the stat aacum of the disk is greater than INT_MAX, its
value becomes negative after casting to 'int', which may lead
to overflow after subtracting a positive number. In the same
way, when the value of sync_io is greater than INT_MAX,
overflow may also occur. These situations will lead to
undefined behavior.

Otherwise, if the stat accum of the disk is close to INT_MAX
when creating raid arrays, the initial value of last_events
would be set close to INT_MAX when mddev initializes IO
event counters. 'curr_events - rdev->last_events > 64' will
always false during synchronization. If all the disks of mddev
are in this case, is_mddev_idle() will always return 1, which
may cause non-sync IO is very slow.

To address these problems, need to use 64bit signed integer
type for sync_io, last_events, and curr_events.

In all the drivers that come with the kernel, the sync_io
variable in struct gendisk is only used for the md driver
currently. It should be more suitable in struct md_rdev, so
add the sync_io variable in struct md_rdev, and use it to
replace. We modify md_sync_acct() and md_sync_acct_bio()
to fit for this change as well. md_sync_acct_bio() need
access to the rdev, so we set bio->bi_bdev to rdev before
calling it, and reset bio->bi_bdev to bdev in this function.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 drivers/md/md.c       |  6 +++---
 drivers/md/md.h       | 13 +++++++++----
 drivers/md/raid1.c    |  4 ++--
 drivers/md/raid10.c   | 24 ++++++++++++------------
 drivers/md/raid5.c    |  4 ++--
 include/linux/genhd.h |  1 -
 6 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5111ed966947..f1b71a92801e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 {
 	struct md_rdev *rdev;
 	int idle;
-	int curr_events;
+	s64 curr_events;
 
 	idle = 1;
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
-		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			      atomic_read(&disk->sync_io);
+		curr_events = (s64)part_stat_read_accum(disk->part0, sectors) -
+			      atomic64_read(&rdev->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
 		 * disk_stats is counted when it completes.
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 53ea7a6961de..584e357e0940 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -50,7 +50,7 @@ struct md_rdev {
 
 	sector_t sectors;		/* Device size (in 512bytes sectors) */
 	struct mddev *mddev;		/* RAID array if running */
-	int last_events;		/* IO event timestamp */
+	s64 last_events;		/* IO event timestamp */
 
 	/*
 	 * If meta_bdev is non-NULL, it means that a separate device is
@@ -138,6 +138,8 @@ struct md_rdev {
 		unsigned int size;	/* Size in sectors of the PPL space */
 		sector_t sector;	/* First sector of the PPL space */
 	} ppl;
+
+	atomic64_t sync_io;		/* counter of sync IO (unit sectors) */
 };
 enum flag_bits {
 	Faulty,			/* device is known to have a fault */
@@ -549,14 +551,17 @@ static inline int mddev_trylock(struct mddev *mddev)
 }
 extern void mddev_unlock(struct mddev *mddev);
 
-static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
+static inline void md_sync_acct(struct md_rdev *rdev, unsigned long nr_sectors)
 {
-	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
+	atomic64_add(nr_sectors, &rdev->sync_io);
 }
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
 {
-	md_sync_acct(bio->bi_bdev, nr_sectors);
+	struct md_rdev *rdev = (void *)bio->bi_bdev;
+
+	bio_set_dev(bio, rdev->bdev);
+	md_sync_acct(rdev, nr_sectors);
 }
 
 struct md_personality
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7dc8026cf6ee..74c42dabe57c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2232,7 +2232,7 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 
 		wbio->bi_end_io = end_sync_write;
 		atomic_inc(&r1_bio->remaining);
-		md_sync_acct(conf->mirrors[i].rdev->bdev, bio_sectors(wbio));
+		md_sync_acct(conf->mirrors[i].rdev, bio_sectors(wbio));
 
 		submit_bio_noacct(wbio);
 	}
@@ -2791,7 +2791,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		if (rdev && bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
 			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
-			bio_set_dev(bio, rdev->bdev);
+			bio->bi_bdev = (void *)rdev;
 			if (test_bit(FailFast, &rdev->flags))
 				bio->bi_opf |= MD_FAILFAST;
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index dde98f65bd04..fc1e6c0996de 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2407,7 +2407,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 		atomic_inc(&r10_bio->remaining);
-		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
+		md_sync_acct(conf->mirrors[d].rdev, bio_sectors(tbio));
 
 		if (test_bit(FailFast, &conf->mirrors[d].rdev->flags))
 			tbio->bi_opf |= MD_FAILFAST;
@@ -2430,7 +2430,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 			bio_copy_data(tbio, fbio);
 		d = r10_bio->devs[i].devnum;
 		atomic_inc(&r10_bio->remaining);
-		md_sync_acct(conf->mirrors[d].replacement->bdev,
+		md_sync_acct(conf->mirrors[d].replacement,
 			     bio_sectors(tbio));
 		submit_bio_noacct(tbio);
 	}
@@ -2562,12 +2562,12 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		wbio2 = NULL;
 	if (wbio->bi_end_io) {
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
-		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
+		md_sync_acct(conf->mirrors[d].rdev, bio_sectors(wbio));
 		submit_bio_noacct(wbio);
 	}
 	if (wbio2) {
 		atomic_inc(&conf->mirrors[d].replacement->nr_pending);
-		md_sync_acct(conf->mirrors[d].replacement->bdev,
+		md_sync_acct(conf->mirrors[d].replacement,
 			     bio_sectors(wbio2));
 		submit_bio_noacct(wbio2);
 	}
@@ -3486,7 +3486,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				from_addr = r10_bio->devs[j].addr;
 				bio->bi_iter.bi_sector = from_addr +
 					rdev->data_offset;
-				bio_set_dev(bio, rdev->bdev);
+				bio->bi_bdev = (void *)rdev;
 				atomic_inc(&rdev->nr_pending);
 				/* and we write to 'i' (if not in_sync) */
 
@@ -3508,7 +3508,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 					bio->bi_iter.bi_sector = to_addr
 						+ mrdev->data_offset;
-					bio_set_dev(bio, mrdev->bdev);
+					bio->bi_bdev = (void *)mrdev;
 					atomic_inc(&r10_bio->remaining);
 				} else
 					r10_bio->devs[1].bio->bi_end_io = NULL;
@@ -3529,7 +3529,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 				bio->bi_iter.bi_sector = to_addr +
 					mreplace->data_offset;
-				bio_set_dev(bio, mreplace->bdev);
+				bio->bi_bdev = (void *)mreplace;
 				atomic_inc(&r10_bio->remaining);
 				break;
 			}
@@ -3684,7 +3684,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			if (test_bit(FailFast, &rdev->flags))
 				bio->bi_opf |= MD_FAILFAST;
 			bio->bi_iter.bi_sector = sector + rdev->data_offset;
-			bio_set_dev(bio, rdev->bdev);
+			bio->bi_bdev = (void *)rdev;
 			count++;
 
 			rdev = rcu_dereference(conf->mirrors[d].replacement);
@@ -3706,7 +3706,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			if (test_bit(FailFast, &rdev->flags))
 				bio->bi_opf |= MD_FAILFAST;
 			bio->bi_iter.bi_sector = sector + rdev->data_offset;
-			bio_set_dev(bio, rdev->bdev);
+			bio->bi_bdev = (void *)rdev;
 			count++;
 			rcu_read_unlock();
 		}
@@ -4865,7 +4865,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 
 	read_bio = bio_alloc_bioset(GFP_KERNEL, RESYNC_PAGES, &mddev->bio_set);
 
-	bio_set_dev(read_bio, rdev->bdev);
+	read_bio->bi_bdev = (void *)rdev;
 	read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
 			       + rdev->data_offset);
 	read_bio->bi_private = r10_bio;
@@ -4921,7 +4921,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		if (!rdev2 || test_bit(Faulty, &rdev2->flags))
 			continue;
 
-		bio_set_dev(b, rdev2->bdev);
+		b->bi_bdev = (void *)rdev2;
 		b->bi_iter.bi_sector = r10_bio->devs[s/2].addr +
 			rdev2->new_data_offset;
 		b->bi_end_io = end_reshape_write;
@@ -5016,7 +5016,7 @@ static void reshape_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		}
 		atomic_inc(&rdev->nr_pending);
 		rcu_read_unlock();
-		md_sync_acct_bio(b, r10_bio->sectors);
+		md_sync_acct(rdev, r10_bio->sectors);
 		atomic_inc(&r10_bio->remaining);
 		b->bi_next = NULL;
 		submit_bio_noacct(b);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9c1a5877cf9f..b932282ff50a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1167,7 +1167,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rdev) {
 			if (s->syncing || s->expanding || s->expanded
 			    || s->replacing)
-				md_sync_acct(rdev->bdev, RAID5_STRIPE_SECTORS(conf));
+				md_sync_acct(rdev, RAID5_STRIPE_SECTORS(conf));
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
@@ -1234,7 +1234,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rrdev) {
 			if (s->syncing || s->expanding || s->expanded
 			    || s->replacing)
-				md_sync_acct(rrdev->bdev, RAID5_STRIPE_SECTORS(conf));
+				md_sync_acct(rrdev, RAID5_STRIPE_SECTORS(conf));
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 74c410263113..6b84444111e4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -150,7 +150,6 @@ struct gendisk {
 	struct list_head slave_bdevs;
 #endif
 	struct timer_rand_state *random;
-	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct kobject integrity_kobj;
-- 
2.27.0

