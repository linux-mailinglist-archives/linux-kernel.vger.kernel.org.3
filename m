Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EB4F85CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbiDGRYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbiDGRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:23:55 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1380BE08;
        Thu,  7 Apr 2022 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=635ylQUcdfFmtEy7PfYRtKd/q8+5RGAxrk1aQwRlsw8=; b=PzXQRQYpXdXhwt9mfTGGsdnyJz
        l0BTLXXaGHofw2ZqsBOF7SczKDAW+vTZzKlHQinURnmsNceWmWlSSy6xK8dCOTdA4dReoI3ZaTwe5
        whstDVfyrbkTNi2b3ycXVvkM/6RRecLsobqgJl9Q5ZWuuSTErhuTFXCbEZFIAZTcPU+BWZ4O3qShp
        7PAkXTLp1UjrnzfEOFMMbLg09XP/LUbsZwx/j79QQQMxjBFrw/dZGtMuorww51II/7Qju2ltmyiH9
        SPdif6fNoXFELntKTQmXINf9ZvM7uxbjHEn6E1o1xJ6bwhEcp/L52LDzTfPLuVwibdw1aNg3Ujtgh
        l6RzzhTg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-002CRm-Ow; Thu, 07 Apr 2022 10:57:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-0002QA-Aw; Thu, 07 Apr 2022 10:57:19 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:10 -0600
Message-Id: <20220407165713.9243-5-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407165713.9243-1-logang@deltatee.com>
References: <20220407165713.9243-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 4/7] md/raid5: Annotate rdev/replacement accesses when nr_pending is elevated
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of accesses to __rcu variables that should be safe
because nr_pending in the disk is known to be elevated.

Create a wrapper around rcu_dereference_protected() to annotate these
accesses and verify that nr_pending is non-zero.

This fixes a number of sparse warnings.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4815f5351818..0f29a2769cb3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2648,6 +2648,16 @@ static void shrink_stripes(struct r5conf *conf)
 	conf->slab_cache = NULL;
 }
 
+/*
+ * This helper wraps rcu_dereference_protected() and can be used when
+ * it is known that the nr_pending of the rdev is elevated.
+ */
+static struct md_rdev *rdev_pend_deref(struct md_rdev __rcu *rdev)
+{
+	return rcu_dereference_protected(rdev,
+			atomic_read(&rcu_access_pointer(rdev)->nr_pending));
+}
+
 static void raid5_end_read_request(struct bio * bi)
 {
 	struct stripe_head *sh = bi->bi_private;
@@ -2674,9 +2684,9 @@ static void raid5_end_read_request(struct bio * bi)
 		 * In that case it moved down to 'rdev'.
 		 * rdev is not removed until all requests are finished.
 		 */
-		rdev = conf->disks[i].replacement;
+		rdev = rdev_pend_deref(conf->disks[i].replacement);
 	if (!rdev)
-		rdev = conf->disks[i].rdev;
+		rdev = rdev_pend_deref(conf->disks[i].rdev);
 
 	if (use_new_offset(conf, sh))
 		s = sh->sector + rdev->new_data_offset;
@@ -2790,11 +2800,11 @@ static void raid5_end_write_request(struct bio *bi)
 
 	for (i = 0 ; i < disks; i++) {
 		if (bi == &sh->dev[i].req) {
-			rdev = conf->disks[i].rdev;
+			rdev = rdev_pend_deref(conf->disks[i].rdev);
 			break;
 		}
 		if (bi == &sh->dev[i].rreq) {
-			rdev = conf->disks[i].replacement;
+			rdev = rdev_pend_deref(conf->disks[i].replacement);
 			if (rdev)
 				replacement = 1;
 			else
@@ -2802,7 +2812,7 @@ static void raid5_end_write_request(struct bio *bi)
 				 * replaced it.  rdev is not removed
 				 * until all requests are finished.
 				 */
-				rdev = conf->disks[i].rdev;
+				rdev = rdev_pend_deref(conf->disks[i].rdev);
 			break;
 		}
 	}
@@ -5213,23 +5223,23 @@ static void handle_stripe(struct stripe_head *sh)
 			struct r5dev *dev = &sh->dev[i];
 			if (test_and_clear_bit(R5_WriteError, &dev->flags)) {
 				/* We own a safe reference to the rdev */
-				rdev = conf->disks[i].rdev;
+				rdev = rdev_pend_deref(conf->disks[i].rdev);
 				if (!rdev_set_badblocks(rdev, sh->sector,
 							RAID5_STRIPE_SECTORS(conf), 0))
 					md_error(conf->mddev, rdev);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGood, &dev->flags)) {
-				rdev = conf->disks[i].rdev;
+				rdev = rdev_pend_deref(conf->disks[i].rdev);
 				rdev_clear_badblocks(rdev, sh->sector,
 						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGoodRepl, &dev->flags)) {
-				rdev = conf->disks[i].replacement;
+				rdev = rdev_pend_deref(conf->disks[i].replacement);
 				if (!rdev)
 					/* rdev have been moved down */
-					rdev = conf->disks[i].rdev;
+					rdev = rdev_pend_deref(conf->disks[i].rdev);
 				rdev_clear_badblocks(rdev, sh->sector,
 						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
-- 
2.30.2

