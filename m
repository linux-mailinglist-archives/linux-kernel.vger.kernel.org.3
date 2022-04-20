Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B305090E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381926AbiDTT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381884AbiDTT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:58 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD314095;
        Wed, 20 Apr 2022 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Y305VOn5uSVqG7ZLxlVP+RdBS8eUiSPvZm9RD+YTK1o=; b=qLDKiAo39D8VStwKrfvtcxk6D5
        dXxnm2OinpeQgJgsg52JWhkzqPTtmY47iLKLY11Pt5HJxDhij8wggDE3XztLBk8Unafz1iuBcaxM5
        Gx0e9RchhtVybP+rXRJw1545DoiA1nLOoSNkmD4dQ8S8pbEVLJfSBlCtKPYf/U/gY3ZymwHHjvrUM
        54Gp+qngPwwmGJiIoWa6WNOXByW3uq8hBO3x0kH134TVBHTdEb6F2iZ4us1PAEpoUPtAhxd4hCfs2
        V3cZCgTu+x/fm4HABxiIFJmoTSoIAWQq82M4+QprLdxCZW0F1ppgiQIwz5ow9Aj78FVGegNjLDjJz
        ZZAAaNHQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPr-00CRsG-JX; Wed, 20 Apr 2022 13:55:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00096p-Jo; Wed, 20 Apr 2022 13:55:06 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:24 -0600
Message-Id: <20220420195425.34911-12-logang@deltatee.com>
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
Subject: [PATCH v2 11/12] md/raid5: Check all disks in a stripe_head for reshape progress
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
 drivers/md/raid5.c | 55 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1fa82d8fa89e..40a25c4b80bd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5823,6 +5823,42 @@ static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
 		return sector >= reshape_sector;
 }
 
+static bool range_ahead_of_reshape(struct mddev *mddev, sector_t min,
+				   sector_t max, sector_t reshape_sector)
+{
+	if (mddev->reshape_backwards)
+		return max < reshape_sector;
+	else
+		return min >= reshape_sector;
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
@@ -5883,26 +5919,17 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		return STRIPE_FAIL;
 	}
 
-	if (unlikely(previous)) {
-		/* expansion might have moved on while waiting for a
-		 * stripe, so we must do the range check again.
+	if (unlikely(previous) &&
+	    stripe_ahead_of_reshape(mddev, conf, sh)) {
+		/* Expansion moved on while waiting for a stripe.
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
-			raid5_release_stripe(sh);
-			return STRIPE_SCHEDULE_AND_RETRY;
-		}
+		raid5_release_stripe(sh);
+		return STRIPE_SCHEDULE_AND_RETRY;
 	}
 
 	if (read_seqcount_retry(&conf->gen_lock, seq)) {
-- 
2.30.2

