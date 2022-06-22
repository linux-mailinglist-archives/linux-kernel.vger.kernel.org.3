Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312DE55557F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbiFVUuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiFVUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:50:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CF3EF27
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:50:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u15so9116269ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHXPpmGBZdWvyxJmjdrgfrKKRqzgpyVWDxj3Vo4u3a8=;
        b=amKj6GxTy79R1fQyEaKL/UbiJB+b7qC0lpa79+GG3RNmYt5sNwRzoWmFKndZ5GtSto
         25mDi4yacnKCgTp3UlvpdhTAADuUa9T5XQ9SGMKoMNy75ZO6H7mzCBDY5vmqdsJEhGEP
         9EtbwC3ORKDaZvhefaNNbOP47aMPcroYnTI484BN+egnnZi4XhoMOZWtlP6uVo+RBoqS
         oZ026JONzAFv9vBGnFiQayoxuBsG7nIytyQhgZ7jv0mystORbsNYReCihNuZLTnGeQ2U
         Sn5bvNh8WCwYFddXaKRY9Npmjg8fZADdDu+Ds2F9j8M1Ta2X+dGNRAkA1yN3uiEMwUJ8
         wa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHXPpmGBZdWvyxJmjdrgfrKKRqzgpyVWDxj3Vo4u3a8=;
        b=RQAPlqmgGOCgi7ItBUCLRU4rS6qDNcluGqT1tngnsHC74gRbmx4RbYNbUU1LId6LeU
         VrJ9ZnxwUIq1lFjiBApLYZjwW2Ld3fwwHHHnfEOvvuCKEjmYTvHd5Rn5ai+Rzg8b+nyX
         J2+CAwv64igDgOtb/+SA0pltKHowvMGA5gstdFCObRo9LgCtdc3LX7P0+edOQcF2ckb9
         WniiHCdXbqAmkQ4JWFsLiEpDqpwthAwefo7ot9OuydPSJfHrEU+8IEffwuPzw52RZgSj
         ww3zi2CF6AEAKEEKtRQRYIK864NjnnpPFBCI7RBW8mLoEErgHhMvYnO2tdEGcm7ucd/7
         jIeQ==
X-Gm-Message-State: AJIora8SWY82Cgupf/poLAUKeA34vMNZXc8tof4ULRChArbVH7CJVlMR
        3mUBE6RFfy763B5gV69PRPf/5A==
X-Google-Smtp-Source: AGRyM1uhNDH7Tmmo2hHrTQe2MuMLk8efymrGKpDNFJyYZlQwkDyFJsjamDPwgxnQFT2jP77skKEDVA==
X-Received: by 2002:a17:907:7b86:b0:711:d2c8:ab18 with SMTP id ne6-20020a1709077b8600b00711d2c8ab18mr4827993ejc.580.1655931003525;
        Wed, 22 Jun 2022 13:50:03 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm16539896edd.47.2022.06.22.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:50:02 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
Date:   Wed, 22 Jun 2022 22:49:32 +0200
Message-Id: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We usually do all our bitmap IO in units of PAGE_SIZE.

With very small or oddly sized external meta data, or with
PAGE_SIZE != 4k, it can happen that our last on-disk bitmap page
is not fully PAGE_SIZE aligned, so we may need to adjust the size
of the IO.

We used to do that with
  min_t(unsigned int, PAGE_SIZE,
	last_allowed_sector - current_offset);
And for just the right diff, (unsigned int)(diff) will result in 0.

A bio of length 0 will correctly be rejected with an IO error
(and some scary WARN_ON_ONCE()) by the scsi layer.

Do the calculation properly.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c | 49 +++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 9e060e49b3f8..bd2133ef6e0a 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -974,25 +974,58 @@ static void drbd_bm_endio(struct bio *bio)
 	}
 }
 
+/* For the layout, see comment above drbd_md_set_sector_offsets(). */
+static inline sector_t drbd_md_last_bitmap_sector(struct drbd_backing_dev *bdev)
+{
+	switch (bdev->md.meta_dev_idx) {
+	case DRBD_MD_INDEX_INTERNAL:
+	case DRBD_MD_INDEX_FLEX_INT:
+		return bdev->md.md_offset + bdev->md.al_offset -1;
+	case DRBD_MD_INDEX_FLEX_EXT:
+	default:
+		return bdev->md.md_offset + bdev->md.md_size_sect -1;
+	}
+}
+
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
 	struct drbd_device *device = ctx->device;
 	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
-	struct bio *bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op,
-					   GFP_NOIO, &drbd_md_io_bio_set);
 	struct drbd_bitmap *b = device->bitmap;
+	struct bio *bio;
 	struct page *page;
+	sector_t last_bm_sect;
+	sector_t first_bm_sect;
+	sector_t on_disk_sector;
 	unsigned int len;
 
-	sector_t on_disk_sector =
-		device->ldev->md.md_offset + device->ldev->md.bm_offset;
-	on_disk_sector += ((sector_t)page_nr) << (PAGE_SHIFT-9);
+	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
+	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
 
 	/* this might happen with very small
 	 * flexible external meta data device,
 	 * or with PAGE_SIZE > 4k */
-	len = min_t(unsigned int, PAGE_SIZE,
-		(drbd_md_last_sector(device->ldev) - on_disk_sector + 1)<<9);
+	last_bm_sect = drbd_md_last_bitmap_sector(device->ldev);
+	if (first_bm_sect <= on_disk_sector && last_bm_sect >= on_disk_sector) {
+		sector_t len_sect = last_bm_sect - on_disk_sector + 1;
+		if (len_sect < PAGE_SIZE/SECTOR_SIZE)
+			len = (unsigned int)len_sect*SECTOR_SIZE;
+		else
+			len = PAGE_SIZE;
+	} else {
+		if (__ratelimit(&drbd_ratelimit_state)) {
+			drbd_err(device, "Invalid offset during on-disk bitmap access: "
+				 "page idx %u, sector %llu\n", page_nr, on_disk_sector);
+		}
+		ctx->error = -EIO;
+		bm_set_page_io_err(b->bm_pages[page_nr]);
+		if (atomic_dec_and_test(&ctx->in_flight)) {
+			ctx->done = 1;
+			wake_up(&device->misc_wait);
+			kref_put(&ctx->kref, &drbd_bm_aio_ctx_destroy);
+		}
+		return;
+	}
 
 	/* serialize IO on this page */
 	bm_page_lock_io(device, page_nr);
@@ -1007,6 +1040,8 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		bm_store_page_idx(page, page_nr);
 	} else
 		page = b->bm_pages[page_nr];
+	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
+			&drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = on_disk_sector;
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
-- 
2.36.1

