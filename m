Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262355F211
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiF1Xrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiF1Xrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:47:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9131387AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67E37B8210E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13242C341C8;
        Tue, 28 Jun 2022 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656460056;
        bh=53mXwbi49s8zWq2OJGvJkwTI8FumVuSeqxQjgBaYmYc=;
        h=From:To:Cc:Subject:Date:From;
        b=mVnK5DLhNZXPdhOP/lPSu8JBsgAPIoA0nfQtGaRY18xGxY/z2Ho6QarvDVd1TC/qL
         cM5pid4KDdMZCjnfhrE4AAfe3Hwm4qL4JNFXJK6VBV27ABq0ByG8/cHjDUi/jSci2g
         mp4v/U0OvL9J145lyd0YxSNRrH34/MOFoeMVqAfIuAydkr8ZSYc11oJW53dfaiL2Pc
         zxFtywvX2KUGgb0iVJhptT0rlRpvhJBWizUIvz+Ub19x9KcUMFryHNLaXOWXEskaYL
         gtlRp0kM1eByncAnSIJktR7GPSUVgtED5a/OlKitIVQMQOvRqTesZ1CY1VMP2GX4VL
         HS1pIAdzRHKkw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: enforce single zone capacity
Date:   Tue, 28 Jun 2022 16:47:31 -0700
Message-Id: <20220628234733.3330502-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify the complicated per-zone capacity, let's support
only one capacity for entire zoned device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 19 ++++++-------------
 fs/f2fs/segment.h |  3 +++
 fs/f2fs/super.c   | 33 ++++++++++++---------------------
 4 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c9a31934b948..1d97d06e0d87 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1235,7 +1235,6 @@ struct f2fs_dev_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_blkz;		/* Total number of zones */
 	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
-	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
 #endif
 };
 
@@ -1673,6 +1672,7 @@ struct f2fs_sb_info {
 	unsigned int meta_ino_num;		/* meta inode number*/
 	unsigned int log_blocks_per_seg;	/* log2 blocks per segment */
 	unsigned int blocks_per_seg;		/* blocks per segment */
+	unsigned int unusable_blocks_per_sec;	/* unusable blocks per section */
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 874c1b9c41a2..447b03579049 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4895,7 +4895,7 @@ static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
 static inline unsigned int f2fs_usable_zone_segs_in_sec(
 		struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
+	unsigned int dev_idx, zone_idx;
 
 	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
 	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
@@ -4904,18 +4904,12 @@ static inline unsigned int f2fs_usable_zone_segs_in_sec(
 	if (is_conv_zone(sbi, zone_idx, dev_idx))
 		return sbi->segs_per_sec;
 
-	/*
-	 * If the zone_capacity_blocks array is NULL, then zone capacity
-	 * is equal to the zone size for all zones
-	 */
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->segs_per_sec;
 
 	/* Get the segment count beyond zone capacity block */
-	unusable_segs_in_sec = (sbi->blocks_per_blkz -
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx]) >>
-				sbi->log_blocks_per_seg;
-	return sbi->segs_per_sec - unusable_segs_in_sec;
+	return sbi->segs_per_sec - (sbi->unusable_blocks_per_sec >>
+						sbi->log_blocks_per_seg);
 }
 
 /*
@@ -4944,12 +4938,11 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 	if (is_conv_zone(sbi, zone_idx, dev_idx))
 		return sbi->blocks_per_seg;
 
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-	sec_cap_blkaddr = sec_start_blkaddr +
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
+	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
 	/*
 	 * If segment starts before zone capacity and spans beyond
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3f277dfcb131..813a892cd979 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,6 +101,9 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
+#define CAP_BLKS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
+	 (sbi)->unusable_blocks_per_sec)
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cf9cf24f9b56..faf9a767d05a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1522,7 +1522,6 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
-		kfree(FDEV(i).zone_capacity_blocks);
 #endif
 	}
 	kvfree(sbi->devs);
@@ -3673,24 +3672,29 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct f2fs_report_zones_args {
+	struct f2fs_sb_info *sbi;
 	struct f2fs_dev_info *dev;
-	bool zone_cap_mismatch;
 };
 
 static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
 	struct f2fs_report_zones_args *rz_args = data;
+	block_t unusable_blocks = (zone->len - zone->capacity) >>
+					F2FS_LOG_SECTORS_PER_BLOCK;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
 
 	set_bit(idx, rz_args->dev->blkz_seq);
-	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
-						F2FS_LOG_SECTORS_PER_BLOCK;
-	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
-		rz_args->zone_cap_mismatch = true;
-
+	if (!rz_args->sbi->unusable_blocks_per_sec) {
+		rz_args->sbi->unusable_blocks_per_sec = unusable_blocks;
+		return 0;
+	}
+	if (rz_args->sbi->unusable_blocks_per_sec != unusable_blocks) {
+		f2fs_err(rz_args->sbi, "F2FS supports single zone capacity\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -3731,26 +3735,13 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
-	/* Get block zones type and zone-capacity */
-	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
-					FDEV(devi).nr_blkz * sizeof(block_t),
-					GFP_KERNEL);
-	if (!FDEV(devi).zone_capacity_blocks)
-		return -ENOMEM;
-
+	rep_zone_arg.sbi = sbi;
 	rep_zone_arg.dev = &FDEV(devi);
-	rep_zone_arg.zone_cap_mismatch = false;
 
 	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
 				  &rep_zone_arg);
 	if (ret < 0)
 		return ret;
-
-	if (!rep_zone_arg.zone_cap_mismatch) {
-		kfree(FDEV(devi).zone_capacity_blocks);
-		FDEV(devi).zone_capacity_blocks = NULL;
-	}
-
 	return 0;
 }
 #endif
-- 
2.37.0.rc0.161.g10f37bed90-goog

