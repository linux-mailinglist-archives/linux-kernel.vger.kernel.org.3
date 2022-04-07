Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85D4F85EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbiDGRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbiDGRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:24:07 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06782186DC;
        Thu,  7 Apr 2022 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=S+r51FPP6n10yfgtvgNM7cq5++cCBWiReTm/0uolfQY=; b=rYlQCuelx0cDeN85iw8hh4CWvr
        LMbonNjYra2S9eW+CNjQD9KXGqbRr1Fb7DDvNPeI4frDJYTUjbAOJoy4GOqOdRnzt2m53OE1r3feS
        OpHYXB4oqTP9wITJxILkMQ11xCDerUtvyOpdf7Najb5IqOJsOOcHBorNqxl3SMMXryX5PoAYZ2MMh
        /lDd/oo1/lOeRjSqpoWhqvXSEdmid8zPpElTxESUaLWkGh7qNgzVIu86v3xp10cJ9g4BB3psd01T4
        u80uTGSE+00er1CVhP+/dQwDPBJvwOYtL4r2wDxDeYc9eZ2tCUA4dVdlFtO+R4x84gmeoGPiHgOif
        9WzlcTNA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG1-002CHm-9u; Thu, 07 Apr 2022 10:45:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG0-0002De-41; Thu, 07 Apr 2022 10:45:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:05 -0600
Message-Id: <20220407164511.8472-3-logang@deltatee.com>
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
Subject: [PATCH v1 2/8] md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stripe_add_to_batch_list() is better done in the loop in make_request
instead of inside add_stripe_bio(). This is clearer and allows for
storing the batch_head state outside the loop in a subsequent patch.

The call to add_stripe_bio() in retry_aligned_read() is for a read only
and thus wouldn't have added the batch anyway.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b794253efd15..e3c75b3b8923 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3504,8 +3504,6 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 	}
 	spin_unlock_irq(&sh->stripe_lock);
 
-	if (stripe_can_batch(sh))
-		stripe_add_to_batch_list(conf, sh);
 	return 1;
 
  overlap:
@@ -5918,6 +5916,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			goto retry;
 		}
 
+		if (stripe_can_batch(sh))
+			stripe_add_to_batch_list(conf, sh);
+
 		if (do_flush) {
 			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
 			/* we only need flush for one stripe */
-- 
2.30.2

