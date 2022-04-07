Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9544F8521
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbiDGQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiDGQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:47:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CFC1C7C06
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=GXFnpjQYBIWFRco3UvVRDWrcEOzkin/loJqwgahQP5M=; b=LjtLKi2PHqcacczp6eBGkdioNd
        rp+Gvt6m3C3jIYLAiFWAJ/7WRyjTWzW9D2sNHlIxbBYZEQiYq4uhteaSkjDbG8M29xWEv51G1Vw0S
        QeRx6CL9r5v4Ffah2e2cT40PYq/ENgPupl6tKckUvy3jSoMp3eVifiQOxna3e7v1ttKGiHrsxfFTc
        gZkgVoGcLblw+eoFH5xuQpUBqyw65aqHUv9OzPg1UtYavfrvIl+OZOPjk2vpL5vDGNbUPR/ms/Z7l
        7l0L3IkGDN2qF12c4ofg617HLXD+lA3Ml5o6ed32V1Pzs2Ou8Ff1i4gu4IGsGeYWkgjeeh6uykWPZ
        /cpYJyzg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG3-002CHk-8h; Thu, 07 Apr 2022 10:45:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG0-0002Dt-TO; Thu, 07 Apr 2022 10:45:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:10 -0600
Message-Id: <20220407164511.8472-8-logang@deltatee.com>
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
Subject: [PATCH v1 7/8] md/raid5: Check all disks in a stripe_head for reshape progress
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
---
 drivers/md/raid5.c | 47 +++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 52227dd91e89..1ddce09970fa 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5764,6 +5764,33 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 	bio_endio(bi);
 }
 
+static bool stripe_ahead_of_reshape(struct mddev *mddev, struct r5conf *conf,
+				    struct stripe_head *sh)
+{
+	sector_t max_sector = 0, min_sector = MaxSector;
+	int dd_idx, ret = 0;
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
+	if (mddev->reshape_backwards
+	    ? max_sector >= conf->reshape_progress
+	    : min_sector < conf->reshape_progress)
+		/* mismatch, need to try again */
+		ret = 1;
+
+	spin_unlock_irq(&conf->device_lock);
+
+	return ret;
+}
+
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	struct stripe_head *batch_last = NULL;
@@ -5877,28 +5904,18 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			break;
 		}
 
-		if (unlikely(previous)) {
+		if (unlikely(previous) &&
+		    stripe_ahead_of_reshape(mddev, conf, sh)) {
 			/*
-			 * Expansion might have moved on while waiting for a
-			 * stripe, so we must do the range check again.
+			 * Expansion moved on while waiting for a stripe.
 			 * Expansion could still move past after this
 			 * test, but as we are holding a reference to
 			 * 'sh', we know that if that happens,
 			 *  STRIPE_EXPANDING will get set and the expansion
 			 * won't proceed until we finish with the stripe.
 			 */
-			int must_retry = 0;
-			spin_lock_irq(&conf->device_lock);
-			if (mddev->reshape_backwards
-			    ? logical_sector >= conf->reshape_progress
-			    : logical_sector < conf->reshape_progress)
-				/* mismatch, need to try again */
-				must_retry = 1;
-			spin_unlock_irq(&conf->device_lock);
-			if (must_retry) {
-				raid5_release_stripe(sh);
-				goto schedule_and_retry;
-			}
+			raid5_release_stripe(sh);
+			goto schedule_and_retry;
 		}
 		if (read_seqcount_retry(&conf->gen_lock, seq)) {
 			/* Might have got the wrong stripe_head by accident */
-- 
2.30.2

