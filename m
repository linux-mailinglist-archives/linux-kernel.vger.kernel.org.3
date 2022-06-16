Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA754EA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378313AbiFPTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377330AbiFPTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F6562C7;
        Thu, 16 Jun 2022 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=nalZ0QkEDN9kZmOnE+xFNb1DntyjDrSZVhBHWEqhODw=; b=IqwxvKeSKZHMHi2o8LSfDhlkfn
        lGvvPY5KNSoRo826V5LkLGPVZrI6KTCfOgMW3ddmMfwMUK8YdUxKIfZhYmIfMAT/yFZETxXYENFGy
        LjoEKpab6CnDLwc2T4XRu53JwjFs8ktWjMjByigTtO9sv02k0Cpkpl7/Pw3bePvnp16QOlKV9F/HG
        amnU6qilxOwJ9o8fmLPv+4ypt8RKAojllZO7xAsNOXsxLBsEUdfycAJrj8ekRLN2IfUBcU3Ev8IBz
        uUtvY3nClIejndCq9L7xzwDTAoz+SggviUFoA+LPZW3Wz5ONi5x2b2NnCAmDfSiWJ6RU/5wDnV5lz
        yDFJBRgQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1z-0092ij-Rr; Thu, 16 Jun 2022 13:19:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1w-0006Fg-CF; Thu, 16 Jun 2022 13:19:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 16 Jun 2022 13:19:41 -0600
Message-Id: <20220616191945.23935-12-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 11/15] md/raid5: Refactor add_stripe_bio()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out two helper functions from add_stripe_bio(): one to check for
overlap (stripe_bio_overlaps()), and one to actually add the bio to the
stripe (__add_stripe_bio()). The latter function will always succeed.

This will be useful in the next patch so that overlap can be checked for
multiple disks before adding any

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 86 ++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 34f8d6c18bd3..f12773c2387a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3415,39 +3415,32 @@ schedule_reconstruction(struct stripe_head *sh, struct stripe_head_state *s,
 		s->locked, s->ops_request);
 }
 
-/*
- * Each stripe/dev can have one or more bion attached.
- * toread/towrite point to the first in a chain.
- * The bi_next chain must be in order.
- */
-static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
-			  int forwrite, int previous)
+static bool stripe_bio_overlaps(struct stripe_head *sh, struct bio *bi,
+				int dd_idx, int forwrite)
 {
-	struct bio **bip;
 	struct r5conf *conf = sh->raid_conf;
-	int firstwrite=0;
+	struct bio **bip;
 
-	pr_debug("adding bi b#%llu to stripe s#%llu\n",
-		(unsigned long long)bi->bi_iter.bi_sector,
-		(unsigned long long)sh->sector);
+	pr_debug("checking bi b#%llu to stripe s#%llu\n",
+		 bi->bi_iter.bi_sector, sh->sector);
 
-	spin_lock_irq(&sh->stripe_lock);
 	/* Don't allow new IO added to stripes in batch list */
 	if (sh->batch_head)
-		goto overlap;
-	if (forwrite) {
+		return true;
+
+	if (forwrite)
 		bip = &sh->dev[dd_idx].towrite;
-		if (*bip == NULL)
-			firstwrite = 1;
-	} else
+	else
 		bip = &sh->dev[dd_idx].toread;
+
 	while (*bip && (*bip)->bi_iter.bi_sector < bi->bi_iter.bi_sector) {
 		if (bio_end_sector(*bip) > bi->bi_iter.bi_sector)
-			goto overlap;
-		bip = & (*bip)->bi_next;
+			return true;
+		bip = &(*bip)->bi_next;
 	}
+
 	if (*bip && (*bip)->bi_iter.bi_sector < bio_end_sector(bi))
-		goto overlap;
+		return true;
 
 	if (forwrite && raid5_has_ppl(conf)) {
 		/*
@@ -3476,9 +3469,30 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		}
 
 		if (first + conf->chunk_sectors * (count - 1) != last)
-			goto overlap;
+			return true;
 	}
 
+	return false;
+}
+
+static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
+			     int dd_idx, int forwrite, int previous)
+{
+	struct r5conf *conf = sh->raid_conf;
+	struct bio **bip;
+	int firstwrite = 0;
+
+	if (forwrite) {
+		bip = &sh->dev[dd_idx].towrite;
+		if (!*bip)
+			firstwrite = 1;
+	} else {
+		bip = &sh->dev[dd_idx].toread;
+	}
+
+	while (*bip && (*bip)->bi_iter.bi_sector < bi->bi_iter.bi_sector)
+		bip = &(*bip)->bi_next;
+
 	if (!forwrite || previous)
 		clear_bit(STRIPE_BATCH_READY, &sh->state);
 
@@ -3505,8 +3519,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 	}
 
 	pr_debug("added bi b#%llu to stripe s#%llu, disk %d.\n",
-		(unsigned long long)(*bip)->bi_iter.bi_sector,
-		(unsigned long long)sh->sector, dd_idx);
+		 (*bip)->bi_iter.bi_sector, sh->sector, dd_idx);
 
 	if (conf->mddev->bitmap && firstwrite) {
 		/* Cannot hold spinlock over bitmap_startwrite,
@@ -3514,7 +3527,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		 * we have added to the bitmap and set bm_seq.
 		 * So set STRIPE_BITMAP_PENDING to prevent
 		 * batching.
-		 * If multiple add_stripe_bio() calls race here they
+		 * If multiple __add_stripe_bio() calls race here they
 		 * much all set STRIPE_BITMAP_PENDING.  So only the first one
 		 * to complete "bitmap_startwrite" gets to set
 		 * STRIPE_BIT_DELAY.  This is important as once a stripe
@@ -3532,14 +3545,27 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
 	}
-	spin_unlock_irq(&sh->stripe_lock);
+}
 
-	return 1;
+/*
+ * Each stripe/dev can have one or more bios attached.
+ * toread/towrite point to the first in a chain.
+ * The bi_next chain must be in order.
+ */
+static bool add_stripe_bio(struct stripe_head *sh, struct bio *bi,
+			   int dd_idx, int forwrite, int previous)
+{
+	spin_lock_irq(&sh->stripe_lock);
 
- overlap:
-	set_bit(R5_Overlap, &sh->dev[dd_idx].flags);
+	if (stripe_bio_overlaps(sh, bi, dd_idx, forwrite)) {
+		set_bit(R5_Overlap, &sh->dev[dd_idx].flags);
+		spin_unlock_irq(&sh->stripe_lock);
+		return false;
+	}
+
+	__add_stripe_bio(sh, bi, dd_idx, forwrite, previous);
 	spin_unlock_irq(&sh->stripe_lock);
-	return 0;
+	return true;
 }
 
 static void end_reshape(struct r5conf *conf);
-- 
2.30.2

