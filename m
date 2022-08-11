Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1772458FE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiHKObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiHKOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFE6D57E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143050euoutp02187d276d16a0a311fb0df06240c9bd04~KUMwxL6ds1916719167euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811143050euoutp02187d276d16a0a311fb0df06240c9bd04~KUMwxL6ds1916719167euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228250;
        bh=OX60KjudRLvNZCiTdE3cUfkGk6srYbDq6kJdBqLbD0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7AzQ2byruGaGJ5QCusbSl/QUmKVeZjAjPNEJ/gt11ESpJHgTpiKCLu6bE8BwEjfa
         H6Lg89Nsn9JgbkutuWFKg1oaAC9uFkgLPHXT4dK0rZffIwjZnYuj1InkFkkvyrEx6p
         S6PpK2/Yj2qOg719to05b49EkMVrOpcAnGAAj5HE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143048eucas1p277bf654881b519a9eeebb4fd14817ae0~KUMvJDs-h1007210072eucas1p2V;
        Thu, 11 Aug 2022 14:30:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.EF.10067.89215F26; Thu, 11
        Aug 2022 15:30:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143048eucas1p10e3ae3ef0c93228e9598e1a1a613f6e1~KUMuipDMR0779607796eucas1p1g;
        Thu, 11 Aug 2022 14:30:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143048eusmtrp150ece03c3fbe6de438b4d5451a893407~KUMuhy_yl2320623206eusmtrp1W;
        Thu, 11 Aug 2022 14:30:48 +0000 (GMT)
X-AuditID: cbfec7f4-5ce7da8000002753-4b-62f5129809d6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.10.09038.89215F26; Thu, 11
        Aug 2022 15:30:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143047eusmtip181ce57f2cd123cd0d1000b17febb9dd1~KUMuJcH4f3243132431eusmtip1B;
        Thu, 11 Aug 2022 14:30:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v10 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Thu, 11 Aug 2022 16:30:33 +0200
Message-Id: <20220811143043.126029-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7ozhL4mGbz+oWux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2PC
        nR/MBa/VKw5Pf87UwLhDoYuRk0NCwERi2qkJjF2MXBxCAisYJX4+msMM4XxhlDi2dTVU5jOj
        xO5rnxlhWj5OmM8EkVjOKPF3/3oWCOcFo8Tb5n1ADgcHm4CWRGMnO0iDiEC6xPoFy8FqmAXu
        MEl8v9fDBpIQFoiR2Lt9GzOIzSKgKnHg1FywBl4BK4nz889CbZOXmHnpO1icU8BaYsKii0wQ
        NYISJ2c+YQGxmYFqmrfOZoao384p0b1OC8J2kVgx5wkThC0s8er4FnYIW0bi9OQeFgi7WuLp
        jd9gP0sItDBK9O9czwbygATQsr4zOSAms4CmxPpd+hBRR4mutakQJp/EjbeCEAfwSUzaNp0Z
        Iswr0dEmBDFbSWLnzydQOyUkLjfNgdrpITF3yV/mCYyKs5C8MgvJK7MQ1i5gZF7FKJ5aWpyb
        nlpslJdarlecmFtcmpeul5yfu4kRmA5P/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuEtW/Q5SYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVAOTf51GrMrrSLY7
        fSc6Hv9a0frG786x8PpJR/dP4Aq/pmcyR70t5qLHycqHAr8Lzp47JZ0rwLz4h6PC5frDZ1K9
        ip5uM9P6/enS6aKoCQct/7GmXnTctSa97n1t7L07LXceBPxzKgjtTc5W3J29w99Yn/u2bLmO
        z/J1/wtmRTHsNWrMPXBhlcqqL8X2h7fM4XuVPT1XzUqnpVFsZUDK+3DGzac5LVPZeE/X3+3c
        IXvj760zixoaNijXTzEr5AndvDvVWNL9uX/Rfv580Q+9C7OV0nge2z/7Gv49PvGsq60jT5z4
        c9e+BjtbltUZT40Kl7Y4FvLr/6w4uZ3j6NWgUwcCr+Q0H4+bwdodJmyxqVuJpTgj0VCLuag4
        EQDEMdhS9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7ozhL4mGezZw2yx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PCnR/MBa/VKw5Pf87UwLhDoYuR
        k0NCwETi44T5TF2MXBxCAksZJa7dm8QMkZCQuL2wiRHCFpb4c62LDaLoGaNEz6m9rF2MHBxs
        AloSjZ3sIKaIQK7EwSOBICXMAm+YJDqv72EB6RUWiJK4MP8cK4jNIqAqceDUXHYQm1fASuL8
        /LNQ8+UlZl76DhbnFLCWmLDoIhOILQRUM6HjGFS9oMTJmU/AZjID1Tdvnc08gVFgFpLULCSp
        BYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjd9uxn1t2MK589VHvECMTB+MhRgkOZiUR
        3rJFn5OEeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+YPPJK4g3NDEwNTcwsDUwtzYyVxHk9
        CzoShQTSE0tSs1NTC1KLYPqYODilGphc5n4TPzal8eZiEYcrKZExM6p7tzS83XXy66HgNt8n
        RUcbOZ8rmIkFnOBzTko9cH+PdKpN9GuP8+8ZjB9mRRzbfWb/r0lGtcKF3jNbRXoNhNJeqfhc
        jryQnHSw8V7ajj+e+R8PzN6bWn6cNfTah1+avHuf7ZQtj1g8+0e5q+GO5z8yCvzUTu9c/DFt
        DavkxbdzNvVJ2C7ytxW96OAirvpx7vQpQc9OXGbJ2e2oJhjG0FZ0wmWZ5AoFExaJrR3Ls4MP
        tqvW6pe6T+t4+aPphkFa3nmjNXm/WZOUq7b5Hv2ZsylR7CmX0aru3h2T7qX7JNfMTzL55rd6
        iZf/v1utR1/qSF9Wtuiv2VQQdd8wbIESS3FGoqEWc1FxIgCgSbVVZgMAAA==
X-CMS-MailID: 20220811143048eucas1p10e3ae3ef0c93228e9598e1a1a613f6e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143048eucas1p10e3ae3ef0c93228e9598e1a1a613f6e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143048eucas1p10e3ae3ef0c93228e9598e1a1a613f6e1
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143048eucas1p10e3ae3ef0c93228e9598e1a1a613f6e1@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
power-of-2(po2) based arithmetic in the block layer using the helpers
wherever possible.

The only hot path affected by this change for zoned devices with po2
zone size is in blk_check_zone_append() but bdev_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes.

Finally, allow zoned devices with non po2 zone sizes provided that their
zone capacity and zone size are equal. The main motivation to allow zoned
devices with non po2 zone size is to remove the unmapped LBA between
zone capcity and zone size for devices that cannot have a po2 zone
capacity.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      | 24 ++++++++++++++++++------
 include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590..1cb519220ffb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -563,7 +563,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dce9c95b4bcd..6806c69c81dc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_start(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
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
+			pr_warn("%s: Invalid zero zone size", disk->disk_name);
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
+			pr_err("%s: Invalid zone capacity %lld with non power-of-2 zone size %lld",
+			       disk->disk_name, zone->capacity, zone->len);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84e7881262e3..d0d66a0db224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -704,6 +704,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
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
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
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
@@ -748,6 +772,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
+static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
-- 
2.25.1

