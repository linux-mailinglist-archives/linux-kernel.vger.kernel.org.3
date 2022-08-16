Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A8595D05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiHPNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiHPNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA75B7B7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:44 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131543euoutp02d482448d16b462db66c145b9fe6a2502~L1ZmcCjap2682226822euoutp02_
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816131543euoutp02d482448d16b462db66c145b9fe6a2502~L1ZmcCjap2682226822euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655743;
        bh=OX60KjudRLvNZCiTdE3cUfkGk6srYbDq6kJdBqLbD0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uU1GTasffkW5v4q0SUtLabNzjfCdmTP9DxvPnnHDR8LKFvl622BbY7M+Xfabgr/pA
         8/yhfbjv+k+oBaqpCsQg7Ix1IEP7nGWYeOgsyVtf+yO5fVNxKnbiWDmCzQk25cA2m+
         JQualadWQzpyxv1OJZ7jOlZInPta8xAopMYlef4g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816131541eucas1p2aff989b25c95badd2db9213297931e91~L1Zk4YiuE0840008400eucas1p2-;
        Tue, 16 Aug 2022 13:15:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.65.09580.D789BF26; Tue, 16
        Aug 2022 14:15:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131540eucas1p2f8d8579f4050da3257ee0150c194e0af~L1ZkKcmr00994909949eucas1p2R;
        Tue, 16 Aug 2022 13:15:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131540eusmtrp2819aada079e9a6630d3566cedda642fe~L1ZkJjO1F0621306213eusmtrp2F;
        Tue, 16 Aug 2022 13:15:40 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-dd-62fb987d91d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.21.09038.C789BF26; Tue, 16
        Aug 2022 14:15:40 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131540eusmtip20d307f27b4dd6b50de556d5484750539~L1ZjzaQhb1363513635eusmtip2g;
        Tue, 16 Aug 2022 13:15:40 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Tue, 16 Aug 2022 15:15:26 +0200
Message-Id: <20220816131536.189406-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87q1M34nGXScU7FYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlTHh
        zg/mgtfqFYenP2dqYNyh0MXIySEhYCJx8tt91i5GLg4hgRWMEl8vvmeEcL4wShx+fJkdwvnM
        KPFnwipmmJaOR3+YIRLLGSU+/twO5bxglJgyrxmon4ODTUBLorGTHaRBRCBdYkrLSxaQGmaB
        O0wSp95tBUsIC8RIHPryhgXEZhFQlZjRPI8JpJdXwEpiyepyiGXyEjMvfQcr5xSwlvjXsAqs
        nFdAUOLkzCdgNjNQTfPW2WA3SAjs5pR4d6GbEaLZReJjyyomCFtY4tXxLewQtozE/53zoeLV
        Ek9v/IZqbmGU6N+5ng3kCAmgbX1nckBMZgFNifW79CHKHSVWdc9nhajgk7jxVhDiBD6JSdum
        M0OEeSU62oQgqpUkdv58ArVUQuJy0xwWCNtDYuWhJ2wTGBVnIXlmFpJnZiHsXcDIvIpRPLW0
        ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwIZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawkwiv44keS
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqaG6GkBbyOX
        HF99qnGCnzpfuBxTxJ4Phx00xXsWaZ+5Eh65M+znlaAdygs50r+7TzhledyiTtgi7zvrzNnV
        W9/uemjo1a4kmLz0WDdLzZR/l/6Z7z9v/idi19EU7gNrPpVw12bODd7z3WPG1oLW/3kRfkbi
        yV89/F1869j/LJ95VSdF4FfE3ORXEenTZsvcvvIj8QLbhYDHpyvnv/OaaZbltdqu0rPUojfB
        Z3H10bk3732ed5hh5emYEP00zUe8n1xaV0/aFNaXuPzat9BZjzh2//queUT4Sc/1rywF9vFi
        ay6dKw4PmKplqGPK+zBAc66p//YkiZfBEvxOt99GvN/QFuHnohXzaeI6X+0LpjpKLMUZiYZa
        zEXFiQDZqsfN9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7o1M34nGTTdMbBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHhzg/mgtfqFYenP2dqYNyh0MXI
        ySEhYCLR8egPcxcjF4eQwFJGietds1kgEhIStxc2MULYwhJ/rnWxQRQ9Y5SYeLyZqYuRg4NN
        QEuisZMdpEZEIFdi0bIOVpAaZoE3TBIf5n9iAkkIC0RJLL28nQ3EZhFQlZjRPA+sl1fASmLJ
        6nKI+fISMy99B5vDKWAt8a9hFdgNQkAlbccuM4PYvAKCEidnPgGLMwPVN2+dzTyBUWAWktQs
        JKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN327GfW3Ywrnz1Ue8QIxMH4yFGCQ5m
        JRFewRc/koR4UxIrq1KL8uOLSnNSiw8xmgKdPZFZSjQ5H5g88kriDc0MTA1NzCwNTC3NjJXE
        eT0LOhKFBNITS1KzU1MLUotg+pg4OKUamCpO21nyt3EaPBNRWLty/t2lF9j+CyY21nFceKWx
        LNScMWDfpn3PmPlcHNt+tp8ve3nh3oTYeacDE1fGLbhZxKO/c8NFkdX5G+NWb194UbuzOvTs
        nSkd4ufOL7FZXnNx+sTlOSVmz29IOTN9ubLi/d+rNen5wn9LA9xZ3t9n28CaMfGMiFd0B/um
        ffN+XGvzndx44+aCSd0ykb+fXTy0OHaHCdMPndoVzlkvdrxOYus7sdZr3UGP3gmXRF1KZ3T1
        BHz6WFg4PTOh+5fdjejKFInnvzuPe6+P+VZ0ft6PrbGOUmKT7L8oVq/QyfU4Em36wdi5nXOq
        1Opwm3bnif1TrRyyPTJ/T+SseP2t/Y3Wzk4lluKMREMt5qLiRAC1x/4eZgMAAA==
X-CMS-MailID: 20220816131540eucas1p2f8d8579f4050da3257ee0150c194e0af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131540eucas1p2f8d8579f4050da3257ee0150c194e0af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131540eucas1p2f8d8579f4050da3257ee0150c194e0af
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131540eucas1p2f8d8579f4050da3257ee0150c194e0af@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

