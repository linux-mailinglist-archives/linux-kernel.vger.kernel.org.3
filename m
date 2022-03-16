Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673E4DADA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbiCPJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiCPJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:39:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612991FCF1;
        Wed, 16 Mar 2022 02:38:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEE7B68AFE; Wed, 16 Mar 2022 10:38:19 +0100 (CET)
Date:   Wed, 16 Mar 2022 10:38:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     jaegeuk@kernel.org, chao@kernel.org, ulf.hansson@linaro.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH, alternative 1] block: remove REQ_OP_SECURE_ERASE erase
Message-ID: <20220316093819.GB7714@lst.de>
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
and thus skips parts of the two be discarded area.  There's only
two users of this feature:  f2fs just uses it by default for all
discards when supported from the F2FS_IOC_SEC_TRIM_FILE ioctl, and
the BLKSECDISCARD ioctl request it and fails if not supported.

Note that even if the rounding errors were to go away, a LBA based
"secure erase" can't actually work on flash media as it has the
same kind of rounding issues in the device due to the lack of
overwrite capabilities.  And eMMC is the only actual hardware
driver supporting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                    |  5 --
 block/blk-lib.c                     | 14 ++----
 block/blk-merge.c                   |  6 +--
 block/blk-mq-debugfs.c              |  1 -
 block/blk.h                         |  1 -
 block/bounce.c                      |  1 -
 block/ioctl.c                       |  3 --
 drivers/block/rnbd/rnbd-clt.c       |  2 -
 drivers/block/rnbd/rnbd-proto.h     |  6 ---
 drivers/block/rnbd/rnbd-srv-dev.h   |  5 --
 drivers/block/rnbd/rnbd-srv.c       |  3 +-
 drivers/block/xen-blkback/blkback.c |  6 +--
 drivers/block/xen-blkback/common.h  |  1 -
 drivers/block/xen-blkback/xenbus.c  |  6 +--
 drivers/block/xen-blkfront.c        | 15 ++----
 drivers/md/dm-ebs-target.c          |  1 -
 drivers/md/dm-linear.c              |  1 -
 drivers/md/dm-stripe.c              |  2 -
 drivers/md/dm-table.c               | 31 ------------
 drivers/md/dm.c                     |  4 --
 drivers/mmc/core/block.c            | 73 -----------------------------
 drivers/mmc/core/core.c             |  9 ----
 drivers/mmc/core/core.h             |  1 -
 drivers/mmc/core/queue.c            |  3 --
 fs/f2fs/file.c                      |  4 +-
 include/linux/bio.h                 |  3 --
 include/linux/blk_types.h           |  2 -
 include/linux/blkdev.h              |  7 +--
 include/linux/device-mapper.h       |  6 ---
 kernel/trace/blktrace.c             |  6 +--
 30 files changed, 13 insertions(+), 215 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 779b4a1f66ac2..dd623548ccac1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,7 +116,6 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(WRITE),
 	REQ_OP_NAME(FLUSH),
 	REQ_OP_NAME(DISCARD),
-	REQ_OP_NAME(SECURE_ERASE),
 	REQ_OP_NAME(ZONE_RESET),
 	REQ_OP_NAME(ZONE_RESET_ALL),
 	REQ_OP_NAME(ZONE_OPEN),
@@ -728,10 +727,6 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (!blk_queue_discard(q))
 			goto not_supported;
 		break;
-	case REQ_OP_SECURE_ERASE:
-		if (!blk_queue_secure_erase(q))
-			goto not_supported;
-		break;
 	case REQ_OP_WRITE_SAME:
 		if (!q->limits.max_write_same_sectors)
 			goto not_supported;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f09beadcbe30..dfcd629a8dffa 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -29,7 +29,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
-	unsigned int op;
 	sector_t bs_mask, part_offset = 0;
 
 	if (!q)
@@ -38,15 +37,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
@@ -98,7 +90,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, op, 0);
+		bio_set_op_attrs(bio, REQ_OP_DISCARD, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4de34a332c9fd..67c9e65a88ad2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -344,7 +344,6 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
@@ -405,7 +404,6 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 
 	switch (bio_op(rq->bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 		if (queue_max_discard_segments(rq->q) > 1) {
 			struct bio *bio = rq->bio;
 
@@ -588,9 +586,7 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	if (!q->limits.chunk_sectors ||
-	    req_op(rq) == REQ_OP_DISCARD ||
-	    req_op(rq) == REQ_OP_SECURE_ERASE)
+	if (!q->limits.chunk_sectors || req_op(rq) == REQ_OP_DISCARD)
 		return blk_queue_get_max_sectors(q, req_op(rq));
 
 	return min(blk_max_size_offset(q, offset, 0),
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c6..2756975f9161c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -116,7 +116,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(DISCARD),
 	QUEUE_FLAG_NAME(NOXMERGES),
 	QUEUE_FLAG_NAME(ADD_RANDOM),
-	QUEUE_FLAG_NAME(SECERASE),
 	QUEUE_FLAG_NAME(SAME_FORCE),
 	QUEUE_FLAG_NAME(DEAD),
 	QUEUE_FLAG_NAME(INIT_DONE),
diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d5..59c10afc3702a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -284,7 +284,6 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 		return true; /* non-trivial splitting decisions */
diff --git a/block/bounce.c b/block/bounce.c
index 7af1a72835b99..b6ef0f254bd34 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -178,7 +178,6 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
 		break;
 	case REQ_OP_WRITE_SAME:
diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e46..b93bbc43d8e51 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -452,9 +452,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		return blkdev_roset(bdev, mode, cmd, arg);
 	case BLKDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg, 0);
-	case BLKSECDISCARD:
-		return blk_ioctl_discard(bdev, mode, arg,
-				BLKDEV_DISCARD_SECURE);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c08971de369fc..8f4dd2216500d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1373,8 +1373,6 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	dev->queue->limits.discard_alignment	= dev->discard_alignment;
 	if (dev->max_discard_sectors)
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, dev->queue);
-	if (dev->secure_discard)
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, dev->queue);
 
 	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
 	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index de5d5a8df81d7..b791338d88d9d 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -246,9 +246,6 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
 	case RNBD_OP_DISCARD:
 		bio_opf = REQ_OP_DISCARD;
 		break;
-	case RNBD_OP_SECURE_ERASE:
-		bio_opf = REQ_OP_SECURE_ERASE;
-		break;
 	case RNBD_OP_WRITE_SAME:
 		bio_opf = REQ_OP_WRITE_SAME;
 		break;
@@ -281,9 +278,6 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	case REQ_OP_DISCARD:
 		rnbd_opf = RNBD_OP_DISCARD;
 		break;
-	case REQ_OP_SECURE_ERASE:
-		rnbd_opf = RNBD_OP_SECURE_ERASE;
-		break;
 	case REQ_OP_WRITE_SAME:
 		rnbd_opf = RNBD_OP_WRITE_SAME;
 		break;
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 0eb23850afb95..dcfb4970abeea 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -56,11 +56,6 @@ static inline int rnbd_dev_get_max_hw_sects(const struct rnbd_dev *dev)
 	return queue_max_hw_sectors(bdev_get_queue(dev->bdev));
 }
 
-static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
-{
-	return blk_queue_secure_erase(bdev_get_queue(dev->bdev));
-}
-
 static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
 {
 	if (!blk_queue_discard(bdev_get_queue(dev->bdev)))
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1ee808fc600cf..0300cf1290810 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -566,8 +566,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 		cpu_to_le32(rnbd_dev_get_discard_granularity(rnbd_dev));
 	rsp->discard_alignment =
 		cpu_to_le32(rnbd_dev_get_discard_alignment(rnbd_dev));
-	rsp->secure_discard =
-		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
+	rsp->secure_discard = 0;
 	rsp->rotational = !blk_queue_nonrot(q);
 	rsp->cache_policy = 0;
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 14e452896d04c..fb9e0a16cfc65 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -987,13 +987,9 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	}
 	ring->st_ds_req++;
 
-	secure = (blkif->vbd.discard_secure &&
-		 (req->u.discard.flag & BLKIF_DISCARD_SECURE)) ?
-		 BLKDEV_DISCARD_SECURE : 0;
-
 	err = blkdev_issue_discard(bdev, req->u.discard.sector_number,
 				   req->u.discard.nr_sectors,
-				   GFP_KERNEL, secure);
+				   GFP_KERNEL, 0);
 fail_response:
 	if (err == -EOPNOTSUPP) {
 		pr_debug("discard op failed, not supported\n");
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index bda5c815e4415..f732d0135f45a 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -225,7 +225,6 @@ struct xen_vbd {
 	/* Cached size parameter. */
 	sector_t		size;
 	unsigned int		flush_support:1;
-	unsigned int		discard_secure:1;
 	unsigned int		feature_gnt_persistent:1;
 	unsigned int		overflow_max_grants:1;
 };
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 62125fd4af4a7..3181a36592192 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -519,9 +519,6 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		vbd->flush_support = true;
 
-	if (q && blk_queue_secure_erase(q))
-		vbd->discard_secure = true;
-
 	vbd->feature_gnt_persistent = feature_persistent;
 
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
@@ -600,8 +597,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 		state = 1;
 		/* Optional. */
 		err = xenbus_printf(xbt, dev->nodename,
-				    "discard-secure", "%d",
-				    blkif->vbd.discard_secure);
+				    "discard-secure", "%d", 0);
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-secure (%d)", err);
 			return;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index ca71a0585333f..5daac78b09f11 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -557,10 +557,7 @@ static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_inf
 	ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
 	ring_req->u.discard.id = id;
 	ring_req->u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
-	if (req_op(req) == REQ_OP_SECURE_ERASE && info->feature_secdiscard)
-		ring_req->u.discard.flag = BLKIF_DISCARD_SECURE;
-	else
-		ring_req->u.discard.flag = 0;
+	ring_req->u.discard.flag = 0;
 
 	/* Copy the request to the ring page. */
 	*final_ring_req = *ring_req;
@@ -863,11 +860,9 @@ static int blkif_queue_request(struct request *req, struct blkfront_ring_info *r
 	if (unlikely(rinfo->dev_info->connected != BLKIF_STATE_CONNECTED))
 		return 1;
 
-	if (unlikely(req_op(req) == REQ_OP_DISCARD ||
-		     req_op(req) == REQ_OP_SECURE_ERASE))
+	if (unlikely(req_op(req) == REQ_OP_DISCARD))
 		return blkif_queue_discard_req(req, rinfo);
-	else
-		return blkif_queue_rw_req(req, rinfo);
+	return blkif_queue_rw_req(req, rinfo);
 }
 
 static inline void flush_requests(struct blkfront_ring_info *rinfo)
@@ -949,8 +944,6 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 		rq->limits.discard_granularity = info->discard_granularity ?:
 						 info->physical_sector_size;
 		rq->limits.discard_alignment = info->discard_alignment;
-		if (info->feature_secdiscard)
-			blk_queue_flag_set(QUEUE_FLAG_SECERASE, rq);
 	}
 
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
@@ -1594,7 +1587,6 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
 				blk_queue_flag_clear(QUEUE_FLAG_DISCARD, rq);
-				blk_queue_flag_clear(QUEUE_FLAG_SECERASE, rq);
 			}
 			break;
 		case BLKIF_OP_FLUSH_DISKCACHE:
@@ -2080,7 +2072,6 @@ static int blkfront_resume(struct xenbus_device *dev)
 			 */
 			if (req_op(shadow[j].request) == REQ_OP_FLUSH ||
 			    req_op(shadow[j].request) == REQ_OP_DISCARD ||
-			    req_op(shadow[j].request) == REQ_OP_SECURE_ERASE ||
 			    shadow[j].request->cmd_flags & REQ_FUA) {
 				/*
 				 * Flush operations don't contain bios, so
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 7ce5d509b9403..be726c119c60e 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -334,7 +334,6 @@ static int ebs_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = 1;
 	ti->num_discard_bios = 1;
-	ti->num_secure_erase_bios = 0;
 	ti->num_write_same_bios = 0;
 	ti->num_write_zeroes_bios = 0;
 	return 0;
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 1b97a11d71517..44f3ed19d22c8 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -59,7 +59,6 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = 1;
 	ti->num_discard_bios = 1;
-	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
 	ti->private = lc;
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index e566115ec0bb8..fa44a732c9109 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -156,7 +156,6 @@ static int stripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = stripes;
 	ti->num_discard_bios = stripes;
-	ti->num_secure_erase_bios = stripes;
 	ti->num_write_same_bios = stripes;
 	ti->num_write_zeroes_bios = stripes;
 
@@ -283,7 +282,6 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_REMAPPED;
 	}
 	if (unlikely(bio_op(bio) == REQ_OP_DISCARD) ||
-	    unlikely(bio_op(bio) == REQ_OP_SECURE_ERASE) ||
 	    unlikely(bio_op(bio) == REQ_OP_WRITE_ZEROES) ||
 	    unlikely(bio_op(bio) == REQ_OP_WRITE_SAME)) {
 		target_bio_nr = dm_bio_get_target_bio_nr(bio);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e22..20e5c3772037b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1936,34 +1936,6 @@ static bool dm_table_supports_discards(struct dm_table *t)
 	return true;
 }
 
-static int device_not_secure_erase_capable(struct dm_target *ti,
-					   struct dm_dev *dev, sector_t start,
-					   sector_t len, void *data)
-{
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return !blk_queue_secure_erase(q);
-}
-
-static bool dm_table_supports_secure_erase(struct dm_table *t)
-{
-	struct dm_target *ti;
-	unsigned int i;
-
-	for (i = 0; i < dm_table_get_num_targets(t); i++) {
-		ti = dm_table_get_target(t, i);
-
-		if (!ti->num_secure_erase_bios)
-			return false;
-
-		if (!ti->type->iterate_devices ||
-		    ti->type->iterate_devices(ti, device_not_secure_erase_capable, NULL))
-			return false;
-	}
-
-	return true;
-}
-
 static int device_requires_stable_pages(struct dm_target *ti,
 					struct dm_dev *dev, sector_t start,
 					sector_t len, void *data)
@@ -2000,9 +1972,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	} else
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 
-	if (dm_table_supports_secure_erase(t))
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
-
 	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
 		wc = true;
 		if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_FUA)))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 997ace47bbd54..6325f7907a643 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1369,7 +1369,6 @@ static bool is_abnormal_io(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE_ZEROES:
 		r = true;
@@ -1389,9 +1388,6 @@ static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 	case REQ_OP_DISCARD:
 		num_bios = ti->num_discard_bios;
 		break;
-	case REQ_OP_SECURE_ERASE:
-		num_bios = ti->num_secure_erase_bios;
-		break;
 	case REQ_OP_WRITE_SAME:
 		num_bios = ti->num_write_same_bios;
 		break;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4e61b28a002f6..7c5db18c8a8c7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1127,76 +1127,6 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
-				       struct request *req)
-{
-	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
-	int err = 0, type = MMC_BLK_SECDISCARD;
-	blk_status_t status = BLK_STS_OK;
-
-	if (!(mmc_can_secure_erase_trim(card))) {
-		status = BLK_STS_NOTSUPP;
-		goto out;
-	}
-
-	from = blk_rq_pos(req);
-	nr = blk_rq_sectors(req);
-
-	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
-		arg = MMC_SECURE_TRIM1_ARG;
-	else
-		arg = MMC_SECURE_ERASE_ARG;
-
-retry:
-	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 INAND_CMD38_ARG_EXT_CSD,
-				 arg == MMC_SECURE_TRIM1_ARG ?
-				 INAND_CMD38_ARG_SECTRIM1 :
-				 INAND_CMD38_ARG_SECERASE,
-				 card->ext_csd.generic_cmd6_time);
-		if (err)
-			goto out_retry;
-	}
-
-	err = mmc_erase(card, from, nr, arg);
-	if (err == -EIO)
-		goto out_retry;
-	if (err) {
-		status = BLK_STS_IOERR;
-		goto out;
-	}
-
-	if (arg == MMC_SECURE_TRIM1_ARG) {
-		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					 INAND_CMD38_ARG_EXT_CSD,
-					 INAND_CMD38_ARG_SECTRIM2,
-					 card->ext_csd.generic_cmd6_time);
-			if (err)
-				goto out_retry;
-		}
-
-		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
-		if (err == -EIO)
-			goto out_retry;
-		if (err) {
-			status = BLK_STS_IOERR;
-			goto out;
-		}
-	}
-
-out_retry:
-	if (err && !mmc_blk_reset(md, card->host, type))
-		goto retry;
-	if (!err)
-		mmc_blk_reset_success(md, type);
-out:
-	blk_mq_end_request(req, status);
-}
-
 static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -2292,9 +2222,6 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 		case REQ_OP_DISCARD:
 			mmc_blk_issue_discard_rq(mq, req);
 			break;
-		case REQ_OP_SECURE_ERASE:
-			mmc_blk_issue_secdiscard_rq(mq, req);
-			break;
 		case REQ_OP_FLUSH:
 			mmc_blk_issue_flush(mq, req);
 			break;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e132..11276b0186dd4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1837,15 +1837,6 @@ int mmc_can_sanitize(struct mmc_card *card)
 	return 0;
 }
 
-int mmc_can_secure_erase_trim(struct mmc_card *card)
-{
-	if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN) &&
-	    !(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN))
-		return 1;
-	return 0;
-}
-EXPORT_SYMBOL(mmc_can_secure_erase_trim);
-
 int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 			    unsigned int nr)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index f5f3f623ea492..14c3ae1e36ff1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -107,7 +107,6 @@ int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 int mmc_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
-int mmc_can_secure_erase_trim(struct mmc_card *card);
 int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 			unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c69b2d9df6f16..d32d3b8764847 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -47,7 +47,6 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 		return MMC_ISSUE_SYNC;
 	case REQ_OP_FLUSH:
 		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
@@ -189,8 +188,6 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	/* granularity must not be greater than max. discard */
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = SECTOR_SIZE;
-	if (mmc_can_secure_erase_trim(card))
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 }
 
 static unsigned short mmc_get_max_segments(struct mmc_host *host)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c98ef6af97d1..825d5512875c5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3692,9 +3692,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		return -ENXIO;
 
 	if (flags & F2FS_TRIM_FILE_DISCARD)
-		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
-						blk_queue_secure_erase(q) ?
-						BLKDEV_DISCARD_SECURE : 0);
+		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS, 0);
 
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 117d7f248ac96..68fd79c45e2c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -54,7 +54,6 @@ static inline bool bio_has_data(struct bio *bio)
 	if (bio &&
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
-	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
 	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
 		return true;
 
@@ -64,7 +63,6 @@ static inline bool bio_has_data(struct bio *bio)
 static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
-	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
 }
@@ -183,7 +181,6 @@ static inline unsigned bio_segments(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
 		return 0;
 	case REQ_OP_WRITE_SAME:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fe065c394fff6..a2983f77f3532 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -352,8 +352,6 @@ enum req_opf {
 	REQ_OP_FLUSH		= 2,
 	/* discard sectors */
 	REQ_OP_DISCARD		= 3,
-	/* securely erase sectors */
-	REQ_OP_SECURE_ERASE	= 5,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
 	/* write the zero filled sector many times */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 16b47035e4b06..505a11f9a03bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -395,7 +395,6 @@ struct request_queue {
 #define QUEUE_FLAG_DISCARD	8	/* supports DISCARD */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
-#define QUEUE_FLAG_SECERASE	11	/* supports secure erase */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 #define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
@@ -437,8 +436,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
-#define blk_queue_secure_erase(q) \
-	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
@@ -647,7 +644,7 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
-	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
+	if (unlikely(op == REQ_OP_DISCARD))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
@@ -846,8 +843,6 @@ extern void blk_io_schedule(void);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
 
-#define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
-
 extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags);
 extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e87..a6347ca31594e 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -310,12 +310,6 @@ struct dm_target {
 	 */
 	unsigned num_discard_bios;
 
-	/*
-	 * The number of secure erase bios that will be submitted to the target.
-	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
-	 */
-	unsigned num_secure_erase_bios;
-
 	/*
 	 * The number of WRITE SAME bios that will be submitted to the target.
 	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 21dea90eaa935..546c9e00d67a3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -237,7 +237,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	what |= MASK_TC_BIT(op_flags, META);
 	what |= MASK_TC_BIT(op_flags, PREFLUSH);
 	what |= MASK_TC_BIT(op_flags, FUA);
-	if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
+	if (op == REQ_OP_DISCARD)
 		what |= BLK_TC_ACT(BLK_TC_DISCARD);
 	if (op == REQ_OP_FLUSH)
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
@@ -1908,10 +1908,6 @@ void blk_fill_rwbs(char *rwbs, unsigned int op)
 	case REQ_OP_DISCARD:
 		rwbs[i++] = 'D';
 		break;
-	case REQ_OP_SECURE_ERASE:
-		rwbs[i++] = 'D';
-		rwbs[i++] = 'E';
-		break;
 	case REQ_OP_FLUSH:
 		rwbs[i++] = 'F';
 		break;
-- 
2.30.2

