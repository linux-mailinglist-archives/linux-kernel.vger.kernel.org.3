Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695E254EA08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378305AbiFPTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353050AbiFPTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014456213;
        Thu, 16 Jun 2022 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Ikvt2YFtng+Tcv7Pu2rsyFDnMTIkFfzesO1xEugM4JM=; b=R4xKSHUXNE4L79TM3BhlMPkKrP
        9y53CnGSkEO6zN2K0Sp0kfNAJ1eUnGRJPq32XVpwID/YBZAq9ZeS3nmuTKI+JnAaEGBi8+4vXzLEm
        m/CgjWB/apPvVVW+uxH/LYwC9G7ERRofH0h8Zh9m5WVCSHEWe/dsVjpn/AJ37NUncz+aR25vxkwDo
        9p+og1yuI4RUjSNl2DCe7sX0mvZ2yezIZBz9xCxhC2w/VQHRAWaPB57waHjQbZS+qUQSr4l7PZiF0
        D0M7d+V1Ss+ZOdhKDd2mjvdZvrJ7AqOZRp0jOUvnHSohECZGIGFZ8A/cCj3jjOiZijF4aPmi9b0ik
        +rrWIPwA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1z-0092im-Im; Thu, 16 Jun 2022 13:19:52 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1w-0006Fo-Mm; Thu, 16 Jun 2022 13:19:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jun 2022 13:19:43 -0600
Message-Id: <20220616191945.23935-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 13/15] md/raid5: Pivot raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raid5_make_request() loops through every page in the request,
finds the appropriate stripe and adds the bio for that page in the
disk.

This causes a great deal of contention on the hash_lock and extra
work seeing each stripe must be found once for every data disk.

The number of times a stripe must be found can be reduced by pivoting
raid5_make_request() so that it loops through every stripe and then
loops through every disk in that stripe to see if the bio must be
added. This reduces the number of times the hash lock must be taken
by a factor equal to the number of data disks.

To accomplish this, the logical sectors that have already been added
must be tracked. Tracking them is done with a bitmap: the bits
for all pages are set at the start of the request and each bit
is cleared once the bio is added to a stripe.

Finding the next sector to be done is then just a call to
find_first_bit() so that sectors that have been done can simply be
skipped.

One minor downside is that the maximum sectors for a request must be
limited so that the bitmap can be appropriately sized on the stack.
This limit is arbitrarily chosen to be 256 stripe pages which works out
to 1MB if PAGE_SIZE == DEFAULT_STRIPE_SIZE. This doesn't actually
restrict the maximum request further seeing the default block queue
settings are used which restricts the number of segments to 128 (which
results in request sizes that are approximately 512KB).

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 89 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b27b754ee18c..9e18dc9ae8b4 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -61,6 +61,8 @@
 #define cpu_to_group(cpu) cpu_to_node(cpu)
 #define ANY_GROUP NUMA_NO_NODE
 
+#define RAID5_MAX_REQ_STRIPES 256
+
 static bool devices_handle_discard_safely = false;
 module_param(devices_handle_discard_safely, bool, 0644);
 MODULE_PARM_DESC(devices_handle_discard_safely,
@@ -5862,10 +5864,69 @@ enum stripe_result {
 struct stripe_request_ctx {
 	/* a reference to the last stripe_head for batching */
 	struct stripe_head *batch_last;
+
+	/* first sector in the request */
+	sector_t first_sector;
+
+	/* last sector in the request */
+	sector_t last_sector;
+
+	/* bitmap to track stripe sectors that have been added to stripes */
+	DECLARE_BITMAP(sectors_to_do, RAID5_MAX_REQ_STRIPES);
+
 	/* the request had REQ_PREFLUSH, cleared after the first stripe_head */
 	bool do_flush;
 };
 
+static int add_all_stripe_bios(struct r5conf *conf,
+		struct stripe_request_ctx *ctx, struct stripe_head *sh,
+		struct bio *bi, int forwrite, int previous)
+{
+	int dd_idx;
+	int ret = 1;
+
+	spin_lock_irq(&sh->stripe_lock);
+
+	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
+		struct r5dev *dev = &sh->dev[dd_idx];
+
+		if (dd_idx == sh->pd_idx || dd_idx == sh->qd_idx)
+			continue;
+
+		if (dev->sector < ctx->first_sector ||
+		    dev->sector >= ctx->last_sector)
+			continue;
+
+		if (stripe_bio_overlaps(sh, bi, dd_idx, forwrite)) {
+			set_bit(R5_Overlap, &dev->flags);
+			ret = 0;
+			continue;
+		}
+	}
+
+	if (!ret)
+		goto out;
+
+	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
+		struct r5dev *dev = &sh->dev[dd_idx];
+
+		if (dd_idx == sh->pd_idx || dd_idx == sh->qd_idx)
+			continue;
+
+		if (dev->sector < ctx->first_sector ||
+		    dev->sector >= ctx->last_sector)
+			continue;
+
+		__add_stripe_bio(sh, bi, dd_idx, forwrite, previous);
+		clear_bit((dev->sector - ctx->first_sector) >>
+			  RAID5_STRIPE_SHIFT(conf), ctx->sectors_to_do);
+	}
+
+out:
+	spin_unlock_irq(&sh->stripe_lock);
+	return ret;
+}
+
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -5937,7 +5998,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	}
 
 	if (test_bit(STRIPE_EXPANDING, &sh->state) ||
-	    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
+	    !add_all_stripe_bios(conf, ctx, sh, bi, rw, previous)) {
 		/*
 		 * Stripe is busy expanding or add failed due to
 		 * overlap. Flush everything and wait a while.
@@ -5979,11 +6040,12 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	struct r5conf *conf = mddev->private;
-	sector_t logical_sector, last_sector;
+	sector_t logical_sector;
 	struct stripe_request_ctx ctx = {};
 	const int rw = bio_data_dir(bi);
 	enum stripe_result res;
 	DEFINE_WAIT(w);
+	int s;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
 		int ret = log_handle_flush_request(conf, bi);
@@ -6023,9 +6085,14 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 
 	logical_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
-	last_sector = bio_end_sector(bi);
+	ctx.first_sector = logical_sector;
+	ctx.last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
+	bitmap_set(ctx.sectors_to_do, 0,
+		   DIV_ROUND_UP(ctx.last_sector - logical_sector,
+				RAID5_STRIPE_SECTORS(conf)));
+
 	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
 	if ((bi->bi_opf & REQ_NOWAIT) &&
 	    (conf->reshape_progress != MaxSector) &&
@@ -6038,7 +6105,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
-	while (logical_sector < last_sector) {
+	while (1) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
 		if (res == STRIPE_FAIL)
@@ -6066,7 +6133,12 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			continue;
 		}
 
-		logical_sector += RAID5_STRIPE_SECTORS(conf);
+		s = find_first_bit(ctx.sectors_to_do, RAID5_MAX_REQ_STRIPES);
+		if (s == RAID5_MAX_REQ_STRIPES)
+			break;
+
+		logical_sector = ctx.first_sector +
+			(s << RAID5_STRIPE_SHIFT(conf));
 	}
 
 	finish_wait(&conf->wait_for_overlap, &w);
@@ -7923,7 +7995,12 @@ static int raid5_run(struct mddev *mddev)
 		    mddev->queue->limits.discard_granularity < stripe)
 			blk_queue_max_discard_sectors(mddev->queue, 0);
 
-		blk_queue_max_hw_sectors(mddev->queue, UINT_MAX);
+		/*
+		 * Requests require having a bitmap for each stripe.
+		 * Limit the max sectors based on this.
+		 */
+		blk_queue_max_hw_sectors(mddev->queue,
+			RAID5_MAX_REQ_STRIPES << RAID5_STRIPE_SHIFT(conf));
 	}
 
 	if (log_init(conf, journal_dev, raid5_has_ppl(conf)))
-- 
2.30.2

