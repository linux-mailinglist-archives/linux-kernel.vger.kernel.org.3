Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82C4DADA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354947AbiCPJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiCPJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:40:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10CC2B1AB;
        Wed, 16 Mar 2022 02:38:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19B7D68AFE; Wed, 16 Mar 2022 10:38:56 +0100 (CET)
Date:   Wed, 16 Mar 2022 10:38:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     jaegeuk@kernel.org, chao@kernel.org, ulf.hansson@linaro.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH alternative 2] block: fix the REQ_OP_SECURE_ERASE handling
 to not leak erased data
Message-ID: <20220316093855.GC7714@lst.de>
References: <20220316093740.GA7714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316093740.GA7714@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for this "secure erase" is completely broken, given that
the blk-lib code aligns it to the discard granularity and alignment
and thus skips parts of the two be discarded area, leaking plenty of
securely erased data.  Fix this by adding a new blkdev_secure_erase
helper instead.

Note that even if with these rounding errors fixed, a LBA based
"secure erase" can't actually work on flash media.  As flash media
requires erase cycles before writing instead of overwrites there
usually will be copied of this data left somewhere on the media.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c                     | 55 +++++++++++++++++++++++------
 block/ioctl.c                       | 43 +++++++++++++++++-----
 drivers/block/xen-blkback/blkback.c | 15 ++++----
 fs/f2fs/file.c                      |  9 ++---
 include/linux/blkdev.h              |  4 +--
 5 files changed, 95 insertions(+), 31 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f09beadcbe30..5fc2c0bf5c940 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -29,7 +29,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
-	unsigned int op;
+	unsigned int op = REQ_OP_DISCARD;
 	sector_t bs_mask, part_offset = 0;
 
 	if (!q)
@@ -38,15 +38,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (flags & BLKDEV_DISCARD_SECURE) {
-		if (!blk_queue_secure_erase(q))
-			return -EOPNOTSUPP;
-		op = REQ_OP_SECURE_ERASE;
-	} else {
-		if (!blk_queue_discard(q))
-			return -EOPNOTSUPP;
-		op = REQ_OP_DISCARD;
-	}
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
 
 	/* In case the discard granularity isn't set by buggy device driver */
 	if (WARN_ON_ONCE(!q->limits.discard_granularity)) {
@@ -440,3 +433,45 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	unsigned int max_sectors =
+		bdev_get_queue(bdev)->limits.max_discard_sectors;
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
+	if (max_sectors == 0)
+		return -EOPNOTSUPP;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	blk_start_plug(&plug);
+	for (;;) {
+		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
+
+		bio = blk_next_bio(bio, 0, gfp);
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = REQ_OP_SECURE_ERASE;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_iter.bi_size = len;
+
+		sector += len << SECTOR_SHIFT;
+		nr_sects -= len << SECTOR_SHIFT;
+		if (!nr_sects) {
+			ret = submit_bio_wait(bio);
+			bio_put(bio);
+			break;
+		}
+		cond_resched();
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_secure_erase);
diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e46..0821142f921d7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -83,7 +83,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 #endif
 
 static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
-		unsigned long arg, unsigned long flags)
+		unsigned long arg)
 {
 	uint64_t range[2];
 	uint64_t start, len;
@@ -115,15 +115,43 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
-
-	err = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-				   GFP_KERNEL, flags);
-
+	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL, 0);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
 }
 
+static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
+		void __user *argp)
+{
+	uint64_t start, len;
+	uint64_t range[2];
+	int err;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+	if (!blk_queue_discard(bdev_get_queue(bdev)))
+		return -EOPNOTSUPP;
+	if (copy_from_user(range, argp, sizeof(range)))
+		return -EFAULT;
+
+	start = range[0];
+	len = range[1];
+	if ((start & 511) || (len & 511))
+		return -EINVAL;
+	if (start + len > bdev_nr_bytes(bdev))
+		return -EINVAL;
+
+	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	if (!err)
+		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
+						GFP_KERNEL);
+	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	return err;
+}
+
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -451,10 +479,9 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKROSET:
 		return blkdev_roset(bdev, mode, cmd, arg);
 	case BLKDISCARD:
-		return blk_ioctl_discard(bdev, mode, arg, 0);
+		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
-		return blk_ioctl_discard(bdev, mode, arg,
-				BLKDEV_DISCARD_SECURE);
+		return blk_ioctl_secure_erase(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 14e452896d04c..12f741068bcdf 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -970,7 +970,6 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	int status = BLKIF_RSP_OKAY;
 	struct xen_blkif *blkif = ring->blkif;
 	struct block_device *bdev = blkif->vbd.bdev;
-	unsigned long secure;
 	struct phys_req preq;
 
 	xen_blkif_get(blkif);
@@ -987,13 +986,15 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	}
 	ring->st_ds_req++;
 
-	secure = (blkif->vbd.discard_secure &&
-		 (req->u.discard.flag & BLKIF_DISCARD_SECURE)) ?
-		 BLKDEV_DISCARD_SECURE : 0;
+	if (blkif->vbd.discard_secure &&
+	    (req->u.discard.flag & BLKIF_DISCARD_SECURE))
+		err = blkdev_issue_secure_erase(bdev,
+				req->u.discard.sector_number,
+				req->u.discard.nr_sectors, GFP_KERNEL);
+	else
+		err = blkdev_issue_discard(bdev, req->u.discard.sector_number,
+				req->u.discard.nr_sectors, GFP_KERNEL, 0);
 
-	err = blkdev_issue_discard(bdev, req->u.discard.sector_number,
-				   req->u.discard.nr_sectors,
-				   GFP_KERNEL, secure);
 fail_response:
 	if (err == -EOPNOTSUPP) {
 		pr_debug("discard op failed, not supported\n");
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c98ef6af97d1..a83548ad7171f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3691,10 +3691,11 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 	if (!q)
 		return -ENXIO;
 
-	if (flags & F2FS_TRIM_FILE_DISCARD)
-		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
-						blk_queue_secure_erase(q) ?
-						BLKDEV_DISCARD_SECURE : 0);
+	if ((flags & F2FS_TRIM_FILE_DISCARD) && blk_queue_secure_erase(q))
+		ret = blkdev_issue_secure_erase(bdev, sector, nr_sects,
+						GFP_NOFS);
+	else if (flags & F2FS_TRIM_FILE_DISCARD)
+		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS, 0);
 
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 16b47035e4b06..6cfc60090b119 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -846,13 +846,13 @@ extern void blk_io_schedule(void);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
 
-#define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
-
 extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags);
 extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
+int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.30.2

