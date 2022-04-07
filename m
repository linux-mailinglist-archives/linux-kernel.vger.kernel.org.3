Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5614F8522
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiDGQra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiDGQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:47:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D01C7B97
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=hnwyp44gPiKRkRVvUhzcljMO9JeoPP9ZZWxoPK4J/7A=; b=PVfzazSzCmmdxIjJq7KA2p85I3
        BlMcdw4YBoYfMtr7W4osyQKgIlJJ41KC8IAD9jzOiAeRkfn8A8FMt0AuEWsgU+PpZmi67kvDwZYhD
        NhX5REbJMvRgXYstb2SHkXp1lM+fHvtZL0zI9wgxjBxRltuN+42gN06w6fmlSV0qy89olXmN68IrU
        IO2dE9bg5DStihZA9kzSkuxwEPNRTA2dYXF3mmvyStMN/wMMOkajDUqtta2OdVQqQ403v5FY7kUXo
        vHN1AofhDMka92JbrYOboTj0yD9+5d+GD1Fy0k8d+89j8jNVSflPhsnVuqR/8zzm4JMG6nUvsWsgC
        YKgckQPw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG2-002CHl-Dl; Thu, 07 Apr 2022 10:45:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG1-0002Dx-2o; Thu, 07 Apr 2022 10:45:17 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:11 -0600
Message-Id: <20220407164511.8472-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407164511.8472-1-logang@deltatee.com>
References: <20220407164511.8472-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, shli@kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 8/8] md/raid5: Pivot raid5_make_request()
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

To accomplish this, store the disk sector that has currently been
finished and continue to the next logical sector if the disk sector
has already been done. Then add a add_all_stripe_bios() to check all
the bios for overlap and add them all if none of them overlap.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/md/raid5.h |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1ddce09970fa..6b098819f7db 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3523,6 +3523,48 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 	return 1;
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
@@ -5796,7 +5838,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	struct stripe_head *batch_last = NULL;
 	struct r5conf *conf = mddev->private;
 	int dd_idx;
-	sector_t new_sector;
+	sector_t new_sector, disk_sector = MaxSector;
 	sector_t logical_sector, last_sector;
 	struct stripe_head *sh;
 	const int rw = bio_data_dir(bi);
@@ -5855,6 +5897,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			md_write_end(mddev);
 		return true;
 	}
+
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
@@ -5892,6 +5935,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		new_sector = raid5_compute_sector(conf, logical_sector,
 						  previous,
 						  &dd_idx, NULL);
+		if (disk_sector != MaxSector && new_sector <= disk_sector)
+			continue;
+
 		pr_debug("raid456: raid5_make_request, sector %llu logical %llu\n",
 			(unsigned long long)new_sector,
 			(unsigned long long)logical_sector);
@@ -5924,7 +5970,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		}
 
 		if (test_bit(STRIPE_EXPANDING, &sh->state) ||
-		    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
+		    !add_all_stripe_bios(sh, bi, logical_sector,
+					 last_sector, rw, previous)) {
 			/*
 			 * Stripe is busy expanding or add failed due to
 			 * overlap. Flush everything and wait a while.
@@ -5934,6 +5981,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			goto schedule_and_retry;
 		}
 
+		disk_sector = new_sector;
+
 		if (stripe_can_batch(sh)) {
 			stripe_add_to_batch_list(conf, sh, batch_last);
 			if (batch_last)
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 9e8486a9e445..6f1ef9c75504 100644
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

