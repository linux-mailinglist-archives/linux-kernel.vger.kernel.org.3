Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38B5090E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381960AbiDTT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381877AbiDTT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:57 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982B1208E;
        Wed, 20 Apr 2022 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=VK+5QNMcF70KuSsGQWmdoeeUasVGtef6jeUVy60gHrc=; b=EHBhk1aL+kitC5UugHkxMYjmDX
        LiT+HNA1uqLg+gY2XnsAA1CADxF6x0BJ+/SEpwlZJ8uAGe6TA2MvA+nx+yIkcF0G3FoMNwM/44DQt
        uremYGjBqFxT61vvCwYUR0ImgzILHPmMbvuEALInh6kmmiQNY0I7NKvsvuAPcZc4pP2PByFmhBXpO
        EgyFIaRSWdYc8rKUxKsopycT92jhHrTGbeKfr1uRMBQBH1fYd/D4y4JX3n3NSiUFtwSELKtwwalcs
        Iait0MSttU4xUJzr0Oi1Km0lee2xVUHPqm4H0gEB/pnfc9eQw+rDf3gw0TaAsxdc7Bfg5wVuTtBCE
        mO5tX6NA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPr-00CRsX-Iy; Wed, 20 Apr 2022 13:55:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00096z-T1; Wed, 20 Apr 2022 13:55:06 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:25 -0600
Message-Id: <20220420195425.34911-13-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
References: <20220420195425.34911-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 12/12] md/raid5: Pivot raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raid5_make_request() loops through every page in the request,
finds the appropriate stripe and adds the bio for that page in the disk.

This causes a great deal of contention on the hash_lock seeing the
lock for that hash must be taken for every single page.

The number of times the lock is taken can be reduced by pivoting
raid5_make_request() so that it loops through every stripe and then
loops through every disk in that stripe to see if the bio must be
added. This reduces the number of times the lock must be taken by
a factor equal to the number of data disks.

To accomplish this, store the minimum and maxmimum disk sector that
has already been finished and continue to the next logical sector if
it is found that the disk sector has already been done. Then add a
add_all_stripe_bios() to check all the bios for overlap and add them
all if none of them overlap.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 92 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/md/raid5.h |  1 +
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 40a25c4b80bd..f86866cb15be 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3571,6 +3571,48 @@ static bool add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 	return true;
 }
 
+static int add_all_stripe_bios(struct stripe_head *sh, struct bio *bi,
+		sector_t first_logical_sector, sector_t last_sector,
+		int forwrite, int previous)
+{
+	int dd_idx;
+	int ret = 1;
+
+	spin_lock_irq(&sh->stripe_lock);
+
+	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
+		struct r5dev *dev = &sh->dev[dd_idx];
+
+		clear_bit(R5_BioReady, &dev->flags);
+
+		if (dd_idx == sh->pd_idx)
+			continue;
+
+		if (dev->sector < first_logical_sector ||
+		    dev->sector >= last_sector)
+			continue;
+
+		if (stripe_bio_overlaps(sh, bi, dd_idx, forwrite)) {
+			set_bit(R5_Overlap, &dev->flags);
+			ret = 0;
+			continue;
+		}
+
+		set_bit(R5_BioReady, &dev->flags);
+	}
+
+	if (!ret)
+		goto out;
+
+	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++)
+		if (test_bit(R5_BioReady, &sh->dev[dd_idx].flags))
+			__add_stripe_bio(sh, bi, dd_idx, forwrite, previous);
+
+out:
+	spin_unlock_irq(&sh->stripe_lock);
+	return ret;
+}
+
 static void end_reshape(struct r5conf *conf);
 
 static void stripe_set_idx(sector_t stripe, struct r5conf *conf, int previous,
@@ -5869,6 +5911,10 @@ enum stripe_result {
 struct stripe_request_ctx {
 	bool do_flush;
 	struct stripe_head *batch_last;
+	sector_t disk_sector_done;
+	sector_t start_disk_sector;
+	bool first_wrap;
+	sector_t last_sector;
 };
 
 static enum stripe_result make_stripe_request(struct mddev *mddev,
@@ -5908,6 +5954,36 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 	new_sector = raid5_compute_sector(conf, logical_sector, previous,
 					  &dd_idx, NULL);
+
+	/*
+	 * This is a tricky algorithm to figure out which stripe_heads that
+	 * have already been visited and exit early if the stripe_head has
+	 * already been done. (Seeing all disks are added to a stripe_head
+	 * once in add_all_stripe_bios().
+	 *
+	 * To start with, the disk sector of the last stripe that has been
+	 * completed is stored in ctx->disk_sector_done. If the new_sector is
+	 * less than this value, the stripe_head has already been done.
+	 *
+	 * There's one issue with this: if the request starts in the middle of
+	 * a chunk, all the stripe heads before the starting offset will be
+	 * missed. To account for this, set the first_wrap boolean to true
+	 * if new_sector is less than the starting sector. Clear the
+	 * boolean once the start sector is hit for the second time.
+	 * When first_wrap is set, ignore the disk_sector_done.
+	 */
+	if (ctx->start_disk_sector == MaxSector) {
+		ctx->start_disk_sector = new_sector;
+	} else if (new_sector < ctx->start_disk_sector) {
+		ctx->first_wrap = true;
+	} else if (new_sector == ctx->start_disk_sector) {
+		ctx->first_wrap = false;
+		ctx->start_disk_sector = 0;
+		return STRIPE_SUCCESS;
+	} else if (!ctx->first_wrap && new_sector <= ctx->disk_sector_done) {
+		return STRIPE_SUCCESS;
+	}
+
 	pr_debug("raid456: %s, sector %llu logical %llu\n", __func__,
 		 new_sector, logical_sector);
 
@@ -5939,7 +6015,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	}
 
 	if (test_bit(STRIPE_EXPANDING, &sh->state) ||
-	    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
+	    !add_all_stripe_bios(sh, bi, logical_sector, ctx->last_sector, rw,
+				 previous)) {
 		/*
 		 * Stripe is busy expanding or add failed due to
 		 * overlap. Flush everything and wait a while.
@@ -5949,6 +6026,9 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		return STRIPE_SCHEDULE_AND_RETRY;
 	}
 
+	if (new_sector > ctx->disk_sector_done)
+		ctx->disk_sector_done = new_sector;
+
 	if (stripe_can_batch(sh)) {
 		stripe_add_to_batch_list(conf, sh, ctx->batch_last);
 		if (ctx->batch_last)
@@ -5977,8 +6057,10 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	struct r5conf *conf = mddev->private;
-	sector_t logical_sector, last_sector;
-	struct stripe_request_ctx ctx = {};
+	sector_t logical_sector;
+	struct stripe_request_ctx ctx = {
+		.start_disk_sector = MaxSector,
+	};
 	const int rw = bio_data_dir(bi);
 	enum stripe_result res;
 	DEFINE_WAIT(w);
@@ -6021,7 +6103,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 
 	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
-	last_sector = bio_end_sector(bi);
+	ctx.last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
 	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
@@ -6036,7 +6118,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
-	while (logical_sector < last_sector) {
+	while (logical_sector < ctx.last_sector) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
 		if (res == STRIPE_FAIL) {
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 638d29863503..e73b58844f83 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -308,6 +308,7 @@ enum r5dev_flags {
 	R5_Wantwrite,
 	R5_Overlap,	/* There is a pending overlapping request
 			 * on this block */
+	R5_BioReady,    /* The current bio can be added to this disk */
 	R5_ReadNoMerge, /* prevent bio from merging in block-layer */
 	R5_ReadError,	/* seen a read error here recently */
 	R5_ReWrite,	/* have tried to over-write the readerror */
-- 
2.30.2

