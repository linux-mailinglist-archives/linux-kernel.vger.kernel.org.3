Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558715090E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381957AbiDTT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350703AbiDTT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FF14019;
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Vm/ulxm5akqPzXRbyuYV6shpoL3L01EFuT6X2nbDUsY=; b=Y1lXibcYmfxAjKEvhIJcHpd+6p
        V1dsMeJTt2tQiRQJUjATezlU/9tbUf9RAud3dcAanXsxxWbGTv1AbGhXDT1QOPqe3Rlmp/SDXXUI1
        yCh0lzGamZzxpO8ahSWKCMxWPVjd/XeXL3JF2q0Tf0v5k3HxE/FCS2rQ+H2maddWR3i5p6x82lfNl
        nyoii6AN2tmkJm9my6WvD1e9R/efzdBWv5a9tXbx2bzxYNYuhc2QNQ8VHF3zqJ1/0qcHq5KvJH9yD
        rhGNZWXavcbh97vqcz5SSy8rZUzWTfbD9uefj1G4h3DEeSVXqKdWMVl4RqRAsQgxeIMV+knVBOIkT
        CewNFR1Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00CRsG-B6; Wed, 20 Apr 2022 13:55:07 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00096Q-LZ; Wed, 20 Apr 2022 13:55:05 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:19 -0600
Message-Id: <20220420195425.34911-7-logang@deltatee.com>
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
Subject: [PATCH v2 06/12] md/raid5: Drop the do_prepare flag in raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_to_wait() can be reasonably called after schedule instead of
setting a flag and preparing in the next loop iteration.

This means that prepare_to_wait() will be called before
read_seqcount_begin(), but there shouldn't be any reason that
the order matters here. On the first iteration of the loop
prepare_to_wait() is already called first.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5a7334ba0997..b9f618356446 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5915,7 +5915,6 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	const int rw = bio_data_dir(bi);
 	enum stripe_result res;
 	DEFINE_WAIT(w);
-	bool do_prepare;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
 		int ret = log_handle_flush_request(conf, bi);
@@ -5973,12 +5972,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
 		int seq;
 
-		do_prepare = false;
 	retry:
 		seq = read_seqcount_begin(&conf->gen_lock);
-		if (do_prepare)
-			prepare_to_wait(&conf->wait_for_overlap, &w,
-				TASK_UNINTERRUPTIBLE);
 
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi, seq);
@@ -5988,7 +5983,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			goto retry;
 		} else if (res == STRIPE_SCHEDULE_AND_RETRY) {
 			schedule();
-			do_prepare = true;
+			prepare_to_wait(&conf->wait_for_overlap, &w,
+					TASK_UNINTERRUPTIBLE);
 			goto retry;
 		}
 	}
-- 
2.30.2

