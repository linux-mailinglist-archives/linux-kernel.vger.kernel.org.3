Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC44654EA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbiFPTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377972AbiFPTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:57 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C756380;
        Thu, 16 Jun 2022 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=HjuLlnYUox4U67JGg6P48vjgRva2IywSj89prt0c6Ag=; b=gt26t8i2QN6xx2/zXveKjCTbI0
        nj06bydHWcXEr5F9HZgJ/QMYN/0KXuWlIbmlg4ioXNH2kWiDgbJOiYjeV6XhchRfwKH0F2YChaN2L
        8Hwz/GT1OEdngBIELvkdoqVMJNQEvfdcn6XHP9uWgIk4bQVvQrbP6xPX7fdhppwvOkS8lU6nq4Zxx
        aQen8YaSUMVE+yVaaLLY/H87lJOp64dob0TqOTtC+i9e57PBvM1CMWyjlW0dTK6uTLOQhDJ4EeqO8
        v6QkFugFh2J4Px1YApFTCXSX8uZEDyd0dpadRcAPTWC4cTUPkWhj0Nw7cOBJ8KKpQWvDMIhbnrHI0
        o1/egDbg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1z-0092ik-RT; Thu, 16 Jun 2022 13:19:54 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1w-0006Fk-He; Thu, 16 Jun 2022 13:19:48 -0600
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
Date:   Thu, 16 Jun 2022 13:19:42 -0600
Message-Id: <20220616191945.23935-13-logang@deltatee.com>
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
Subject: [PATCH v3 12/15] md/raid5: Check all disks in a stripe_head for reshape progress
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing if a previous stripe has had reshape expand past it, use
the earliest or latest logical sector in all the disks for that stripe
head. This will allow adding multiple disks at a time in a subesquent
patch.

To do this cleaner, refactor the check into a helper function called
stripe_ahead_of_reshape().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f12773c2387a..b27b754ee18c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5818,6 +5818,40 @@ static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
 					  sector >= reshape_sector;
 }
 
+static bool range_ahead_of_reshape(struct mddev *mddev, sector_t min,
+				   sector_t max, sector_t reshape_sector)
+{
+	return mddev->reshape_backwards ? max < reshape_sector :
+					  min >= reshape_sector;
+}
+
+static bool stripe_ahead_of_reshape(struct mddev *mddev, struct r5conf *conf,
+				    struct stripe_head *sh)
+{
+	sector_t max_sector = 0, min_sector = MaxSector;
+	bool ret = false;
+	int dd_idx;
+
+	for (dd_idx = 0; dd_idx < sh->disks; dd_idx++) {
+		if (dd_idx == sh->pd_idx)
+			continue;
+
+		min_sector = min(min_sector, sh->dev[dd_idx].sector);
+		max_sector = min(max_sector, sh->dev[dd_idx].sector);
+	}
+
+	spin_lock_irq(&conf->device_lock);
+
+	if (!range_ahead_of_reshape(mddev, min_sector, max_sector,
+				     conf->reshape_progress))
+		/* mismatch, need to try again */
+		ret = true;
+
+	spin_unlock_irq(&conf->device_lock);
+
+	return ret;
+}
+
 enum stripe_result {
 	STRIPE_SUCCESS = 0,
 	STRIPE_RETRY,
@@ -5882,27 +5916,18 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		return STRIPE_FAIL;
 	}
 
-	if (unlikely(previous)) {
+	if (unlikely(previous) &&
+	    stripe_ahead_of_reshape(mddev, conf, sh)) {
 		/*
-		 * Expansion might have moved on while waiting for a
-		 * stripe, so we must do the range check again.
+		 * Expansion moved on while waiting for a stripe.
 		 * Expansion could still move past after this
 		 * test, but as we are holding a reference to
 		 * 'sh', we know that if that happens,
 		 *  STRIPE_EXPANDING will get set and the expansion
 		 * won't proceed until we finish with the stripe.
 		 */
-		int must_retry = 0;
-		spin_lock_irq(&conf->device_lock);
-		if (!ahead_of_reshape(mddev, logical_sector,
-				      conf->reshape_progress))
-			/* mismatch, need to try again */
-			must_retry = 1;
-		spin_unlock_irq(&conf->device_lock);
-		if (must_retry) {
-			ret = STRIPE_SCHEDULE_AND_RETRY;
-			goto out_release;
-		}
+		ret = STRIPE_SCHEDULE_AND_RETRY;
+		goto out_release;
 	}
 
 	if (read_seqcount_retry(&conf->gen_lock, seq)) {
-- 
2.30.2

