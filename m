Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58995090CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381944AbiDTT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381853AbiDTT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35914008;
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=r4Vq1d0T34q+iSgyurra75zDOgfwBQsKG4gqaeEAplU=; b=CNGXxhIsebsykcxUuU2h1E8zlv
        +8TjhfWouh6sucEIzz+gsZ36yYn7kbJb5NNctNP5+VEy9p3Fa9cb8Exd0dBTRs/P/MbDKSAaQMOPB
        9KTeTw5tGtoF6U54+BEnb9StqWHaXmomlNDIGad5hSqkKbCT9p4CIJiGn34PLhWLA7OplVHXdlwMT
        nYFVO7vZequFzyhvq54gODWYJ/dk2jqLHCINhQ9yNzbL61PLxbqIp1PL7k0U2ZwFbl8RCBTZttUYI
        n8665+kWmXqf40ERN2nyr4T3Y2Kc8e9Ep78YSZgbHX5ZZhTUb9tgv1Psa1LbGaXbkaTu4h41460of
        DePlg/Zw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00CRsX-80; Wed, 20 Apr 2022 13:55:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00096T-Q8; Wed, 20 Apr 2022 13:55:05 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:20 -0600
Message-Id: <20220420195425.34911-8-logang@deltatee.com>
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
Subject: [PATCH v2 07/12] md/raid5: Move read_seqcount_begin() into make_stripe_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that prepare_to_wait() isn't in the way, move read_sequcount_begin()
into make_stripe_request().

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b9f618356446..1bce9075e165 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5804,13 +5804,15 @@ struct stripe_request_ctx {
 
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
-		sector_t logical_sector, struct bio *bi, int seq)
+		sector_t logical_sector, struct bio *bi)
 {
 	const int rw = bio_data_dir(bi);
 	struct stripe_head *sh;
 	sector_t new_sector;
 	int previous = 0;
-	int dd_idx;
+	int seq, dd_idx;
+
+	seq = read_seqcount_begin(&conf->gen_lock);
 
 	if (unlikely(conf->reshape_progress != MaxSector)) {
 		/* spinlock is needed as reshape_progress may be
@@ -5970,13 +5972,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
-		int seq;
-
 	retry:
-		seq = read_seqcount_begin(&conf->gen_lock);
-
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
-					  bi, seq);
+					  bi);
 		if (res == STRIPE_FAIL) {
 			break;
 		} else if (res == STRIPE_RETRY) {
-- 
2.30.2

