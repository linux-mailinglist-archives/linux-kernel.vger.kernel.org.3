Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84B25090D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381880AbiDTT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiDTT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97313F36;
        Wed, 20 Apr 2022 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Tc/4updu0oXiBoTJVCaXt56ab14DRILkwn0ElXxLw4k=; b=osP4/WJYBYQbjKitA+IgBIZBj2
        8u2yO6Kx//0FaaIKxTzh2hJROz8PJ26zI2sWKDWaeLflVsjC1u+0PEbZVpMZPs62KmPYsg8ht3MR5
        6F5tlAZbLsJm9IfGvxrE3zodddmyeC/QU3dEK1/qJWpwe5NeweksYIqYnxjk5emXsg2HlX+a3d+rY
        4haCV8HrI0KI/aKZexNZi48stTTi3P1NGgH1vowRbmrQqNONqUeMj0I8YPR7RsvWkliFwg9uaV9Dj
        i30MoeUWwfoKDWnXkAxZi382c3zF4PiHEvAIqJna6hDhzgT1xkuW3kGN2FtTtG0HsP71D5Yh/vCs4
        EHBIfiVA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00CRsE-AT; Wed, 20 Apr 2022 13:55:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPo-00096C-Sb; Wed, 20 Apr 2022 13:55:04 -0600
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
Date:   Wed, 20 Apr 2022 13:54:14 -0600
Message-Id: <20220420195425.34911-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
References: <20220420195425.34911-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few uses of an ugly ternary operator in raid5_make_request()
to check if a sector is a head of a reshape sector.

Factor this out into a simple helper called ahead_of_reshape().

This appears to fix the first bio_wouldblock_error() check which appears
to have comparison operators that didn't match the check below which
causes a schedule. Besides this, no functional changes intended.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7f7d1546b9ba..97b23c18402b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5787,6 +5787,15 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 	bio_endio(bi);
 }
 
+static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
+			     sector_t reshape_sector)
+{
+	if (mddev->reshape_backwards)
+		return sector < reshape_sector;
+	else
+		return sector >= reshape_sector;
+}
+
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	struct r5conf *conf = mddev->private;
@@ -5843,9 +5852,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
 	if ((bi->bi_opf & REQ_NOWAIT) &&
 	    (conf->reshape_progress != MaxSector) &&
-	    (mddev->reshape_backwards
-	    ? (logical_sector > conf->reshape_progress && logical_sector <= conf->reshape_safe)
-	    : (logical_sector >= conf->reshape_safe && logical_sector < conf->reshape_progress))) {
+	    !ahead_of_reshape(mddev, logical_sector, conf->reshape_progress) &&
+	    ahead_of_reshape(mddev, logical_sector, conf->reshape_safe)) {
 		bio_wouldblock_error(bi);
 		if (rw == WRITE)
 			md_write_end(mddev);
@@ -5874,14 +5882,12 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			 * to check again.
 			 */
 			spin_lock_irq(&conf->device_lock);
-			if (mddev->reshape_backwards
-			    ? logical_sector < conf->reshape_progress
-			    : logical_sector >= conf->reshape_progress) {
+			if (ahead_of_reshape(mddev, logical_sector,
+					     conf->reshape_progress)) {
 				previous = 1;
 			} else {
-				if (mddev->reshape_backwards
-				    ? logical_sector < conf->reshape_safe
-				    : logical_sector >= conf->reshape_safe) {
+				if (ahead_of_reshape(mddev, logical_sector,
+						     conf->reshape_safe)) {
 					spin_unlock_irq(&conf->device_lock);
 					schedule();
 					do_prepare = true;
@@ -5912,9 +5918,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				 */
 				int must_retry = 0;
 				spin_lock_irq(&conf->device_lock);
-				if (mddev->reshape_backwards
-				    ? logical_sector >= conf->reshape_progress
-				    : logical_sector < conf->reshape_progress)
+				if (!ahead_of_reshape(mddev, logical_sector,
+						      conf->reshape_progress))
 					/* mismatch, need to try again */
 					must_retry = 1;
 				spin_unlock_irq(&conf->device_lock);
-- 
2.30.2

