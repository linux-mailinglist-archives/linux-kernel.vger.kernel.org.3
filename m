Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36534582AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiG0QYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiG0QXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:23:30 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68644A839
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:22:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162250euoutp015b48493fc2d08b74cf856093482699fe~FvDRSCS-l2263722637euoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162250euoutp015b48493fc2d08b74cf856093482699fe~FvDRSCS-l2263722637euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938970;
        bh=fvvRpLI+rNcYkgsSNNP5OdgEvIXUCTxqNm91OmSeBGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArgcF9LQ6ubqrs7Efni1u6qrEyECeCp4DZgfF9dDvWdHTKuS8gKcJn3pdqXlPU6Wp
         ErnCWSBYSR93hLdIeIj1J/2Ij3cojrChS5Fo48FrOAx8/PPZy0f/P4EAlrJT/Izp4l
         Vjo45cPVe2Z5NZ4PdIW3MKH5Zp3X+kCQu0KqKuGs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162248eucas1p2540724e9fb8d49be13dbc4ac015cfbe6~FvDPuzYui2169421694eucas1p2k;
        Wed, 27 Jul 2022 16:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CD.B3.09664.85661E26; Wed, 27
        Jul 2022 17:22:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9~FvDPFG7rG2171521715eucas1p2j;
        Wed, 27 Jul 2022 16:22:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727162248eusmtrp25f17f888a7e8551747c80de105acb76c~FvDPEMj6I0809408094eusmtrp27;
        Wed, 27 Jul 2022 16:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-e7-62e166585de4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.1E.09095.85661E26; Wed, 27
        Jul 2022 17:22:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162247eusmtip149c55ab1d2a689c64d53aa99c78100d0~FvDOxDbDe0050700507eusmtip1e;
        Wed, 27 Jul 2022 16:22:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Wed, 27 Jul 2022 18:22:36 +0200
Message-Id: <20220727162245.209794-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7oRaQ+TDC68MLNYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDIef9rGXPDL
        sqJ31xP2BsZV+l2MnBwSAiYSm34dZO1i5OIQEljBKDHzVxMzhPOFUaJx11E2COczo8S2OcfZ
        YFqOH78NlVjOCNR/Dsp5zijRceQpexcjBwebgJZEYyc7SIOIQLHEw3etLCA1zAIHmCQe3G4B
        myQsEC2xpncGM4jNIqAqsfLfCkYQm1fASmLDqaPMENvkJWZe+g42iFPAWmLzlHlMEDWCEidn
        PmEBsZmBapq3zga7W0JgPafEmyl9LBDNLhKLp0yFOltY4tXxLewQtozE/53zmSDsaomnN35D
        NbcwSvTvXM8G8oEE0La+MzkgJrOApsT6XdAAc5RY8Po5I0QFn8SNt4IQJ/BJTNo2nRkizCvR
        0SYEUa0ksfPnE6ilEhKXm+ZAHeYhsbKlgW0Co+IsJM/MQvLMLIS9CxiZVzGKp5YW56anFhvm
        pZbrFSfmFpfmpesl5+duYgQmwtP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeBOi7ycJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYJr4Uizd0FeW89yEoMYM
        840zdD6958x4VOibF+pTIRkz5/SkaPnH1nNf/Du8uPR26+JdE3/XZ+T+0rrq+GW1V/yseV/U
        jnrOthVdsfz816segppb711RlXJ58d7vdXyjkc3HvcUByxrCLeN5zq/fffniM20Fm6ftT6Pa
        U+Ze017Q2zLry7n7m7lKnzHtqk95fj+wfEvv2WcGO2MPLZv3R/+/Wnyqfpjk4a3Mv50nST4+
        P9fkiNHEpYqrpW9+2lfW2mpxNJj5u2X0G0WWA6o3a9at3HunWfWW3UR+Rye1vXvfsWouWc3F
        2cfttWrGeQXdSskg0Q/MRndnN3Nzn7taOlVPcyNrxXYtHcO5l5on7K9TYinOSDTUYi4qTgQA
        DWdG2vMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7oRaQ+TDO5u4bZYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIef9rGXPDLsqJ31xP2BsZV+l2MnBwSAiYS
        x4/fZuti5OIQEljKKPHi2xl2iISExO2FTYwQtrDEn2tdUEVPGSU+PlvI3MXIwcEmoCXR2MkO
        YooIVEqc/SILUsIscI5J4ubFa2wgvcICkRKrTx5hAbFZBFQlVv5bATaTV8BKYsOpo8wQ8+Ul
        Zl76DraXU8BaYvOUeUwgthBQzbMHH9kg6gUlTs58AjaHGai+eets5gmMArOQpGYhSS1gZFrF
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGLHbjv3cvINx3quPeocYmTgYDzFKcDArifAmRN9P
        EuJNSaysSi3Kjy8qzUktPsRoCnT3RGYp0eR8YMrIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
        SE8sSc1OTS1ILYLpY+LglGpg4ve433Lu26QfZle9RZJ3MEUr+maW8x0LKsg+zvbGmqNAlaWo
        9fupHe9OyCbsOSA1361jc7rgbb0JMn1/9/ceap2VuaSrhXuebqteVMGLC+17NzXMa072/CrD
        P/ONOE81b9rUE58uHrw07/Ik66W5dTN2KRf+K58m63tbruRfevLp/S+nxUk+Ftu/5LXj5ECZ
        rywSU68phhzkqd/107Ewjfl6q2K7Sq9xbuK/2vsvWj9rdXBscb13SOq3sPUjiT/VQr+3F3xW
        qFtx6JLeg91hd1nkbpn8XCa8TmNDFr/6CS4hd4PJVhd/H1+Z/Gy94XFpoTob15Ctq6M2TxZb
        O8lCxsLtNdsU6RdBb256bjCzUmIpzkg01GIuKk4EACYmOaBhAwAA
X-CMS-MailID: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if a given sector is aligned to a zone is a common
operation that is performed for zoned devices. Add
bdev_is_zone_start helper to check for this instead of opencoding it
everywhere.

Convert the calculations on zone size to be generic instead of relying on
power_of_2 based logic in the block layer using the helpers wherever
possible.

The only hot path affected by this change for power_of_2 zoned devices
is in blk_check_zone_append() but bdev_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes. Note that the append
path cannot be accessed by direct raw access to the block device but only
through a filesystem abstraction.

Finally, allow non power of 2 zoned devices provided that their zone
capacity and zone size are equal. The main motivation to allow non
power_of_2 zoned device is to remove the unmapped LBA between zcap and
zsze for devices that cannot have a power_of_2 zcap.

To make this work bdev_get_queue(), bdev_zone_sectors() and
bdev_is_zoned() are moved earlier without modifications.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      | 24 +++++++++---
 include/linux/blkdev.h | 84 ++++++++++++++++++++++++++++++------------
 3 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3d286a256d3d..1f7e9a90e198 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -570,7 +570,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_aligned(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dce9c95b4bcd..a01a231ad328 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_aligned(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_aligned(bdev, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zone size", disk->disk_name);
+			return -ENODEV;
+		}
+
+		/*
+		 * Non power-of-2 zone size support was added to remove the
+		 * gap between zone capacity and zone size. Though it is technically
+		 * possible to have gaps in a non power-of-2 device, Linux requires
+		 * the zone size to be equal to zone capacity for non power-of-2
+		 * zoned devices.
+		 */
+		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
+			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
+				disk->disk_name);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 85b832908f28..1be805223026 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -634,6 +634,11 @@ static inline bool queue_is_mq(struct request_queue *q)
 	return q->mq_ops;
 }
 
+static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
+{
+	return bdev->bd_queue;	/* this is never NULL */
+}
+
 #ifdef CONFIG_PM
 static inline enum rpm_status queue_rpm_status(struct request_queue *q)
 {
@@ -665,6 +670,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
+static inline bool bdev_is_zoned(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return blk_queue_is_zoned(q);
+
+	return false;
+}
+
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!blk_queue_is_zoned(q))
+		return 0;
+	return q->limits.chunk_sectors;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -684,6 +708,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sec)
+{
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	u64 remainder = 0;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	if (is_power_of_2(zone_sectors))
+		return sec & (zone_sectors - 1);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	return remainder;
+}
+
+static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return bdev_offset_from_zone_start(bdev, sec) == 0;
+}
+
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
@@ -728,6 +776,18 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sec)
+{
+	return 0;
+}
+
+static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
@@ -891,11 +951,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
 
-static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-{
-	return bdev->bd_queue;	/* this is never NULL */
-}
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -1295,25 +1350,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
-static inline bool bdev_is_zoned(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
-}
-
-static inline sector_t bdev_zone_sectors(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!blk_queue_is_zoned(q))
-		return 0;
-	return q->limits.chunk_sectors;
-}
-
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1

