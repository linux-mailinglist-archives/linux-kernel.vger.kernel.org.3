Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA295834B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiG0VJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiG0VIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:08:38 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F826172C;
        Wed, 27 Jul 2022 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=N86PqOtjDvG/g7ndFdJfPIZiuOCV5VsO4RcvoXZYnhQ=; b=UgTo7s9L6+ThimjzMBBrfHk8ZQ
        E/phm0HAJzOYP2XvayuV2MkUXae2tbFQ/7As5vtP9hRCKIAzQWXkROFlQdxJsigMCPqiT5SP1c1Dr
        uGfdXjwle2fwtxUz/2KG3ZyfZ60DNcJMMbiCCtH6M7n+qRlYsLytT20rBiQ5jPKeF7cSsZhPzjU0U
        8YwZuQg0cAqd4iKZPeyxi8r7vElDmbcFIKvZDXKyCBO2f2egfEpiupMimVaYXaQWFS8Xv4VzSeFKg
        /3ihF8Lddcm2Au6tvqPX4S8F4r/6DxHYI/GYCAl+ZhSvXpQKkf+8ZmBe0CSoEhpu98ifR5l0FuqLY
        PVsfZ5PA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEG-001pyG-GH; Wed, 27 Jul 2022 15:06:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEF-000VI6-2L; Wed, 27 Jul 2022 15:06:03 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 27 Jul 2022 15:05:59 -0600
Message-Id: <20220727210600.120221-5-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727210600.120221-1-logang@deltatee.com>
References: <20220727210600.120221-1-logang@deltatee.com>
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
Subject: [PATCH 4/5] md/raid5: Move stripe_request_ctx up
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move stripe_request_ctx up. No functional changes intended.

This will be necessary in the next patch to release the batch_last
in the context before sleeping.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e09fa55960cc..0a8687fd1748 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -755,6 +755,33 @@ static bool has_failed(struct r5conf *conf)
 	return degraded > conf->max_degraded;
 }
 
+enum stripe_result {
+	STRIPE_SUCCESS = 0,
+	STRIPE_RETRY,
+	STRIPE_SCHEDULE_AND_RETRY,
+	STRIPE_FAIL,
+};
+
+struct stripe_request_ctx {
+	/* a reference to the last stripe_head for batching */
+	struct stripe_head *batch_last;
+
+	/* first sector in the request */
+	sector_t first_sector;
+
+	/* last sector in the request */
+	sector_t last_sector;
+
+	/*
+	 * bitmap to track stripe sectors that have been added to stripes
+	 * add one to account for unaligned requests
+	 */
+	DECLARE_BITMAP(sectors_to_do, RAID5_MAX_REQ_STRIPES + 1);
+
+	/* the request had REQ_PREFLUSH, cleared after the first stripe_head */
+	bool do_flush;
+};
+
 /*
  * Block until another thread clears R5_INACTIVE_BLOCKED or
  * there are fewer than 3/4 the maximum number of active stripes
@@ -5874,33 +5901,6 @@ static bool stripe_ahead_of_reshape(struct mddev *mddev, struct r5conf *conf,
 	return ret;
 }
 
-enum stripe_result {
-	STRIPE_SUCCESS = 0,
-	STRIPE_RETRY,
-	STRIPE_SCHEDULE_AND_RETRY,
-	STRIPE_FAIL,
-};
-
-struct stripe_request_ctx {
-	/* a reference to the last stripe_head for batching */
-	struct stripe_head *batch_last;
-
-	/* first sector in the request */
-	sector_t first_sector;
-
-	/* last sector in the request */
-	sector_t last_sector;
-
-	/*
-	 * bitmap to track stripe sectors that have been added to stripes
-	 * add one to account for unaligned requests
-	 */
-	DECLARE_BITMAP(sectors_to_do, RAID5_MAX_REQ_STRIPES + 1);
-
-	/* the request had REQ_PREFLUSH, cleared after the first stripe_head */
-	bool do_flush;
-};
-
 static int add_all_stripe_bios(struct r5conf *conf,
 		struct stripe_request_ctx *ctx, struct stripe_head *sh,
 		struct bio *bi, int forwrite, int previous)
-- 
2.30.2

