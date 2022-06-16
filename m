Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2254EA09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378320AbiFPTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377584AbiFPTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30059563B9;
        Thu, 16 Jun 2022 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=XipH9iAJdASipp0LhFoe2s+U+0gG0U4iLjVccbFrlCk=; b=FivJ8zhelgL8koM3/scbGZ3aoM
        Em4KvatN3cse7OraBxBcOr8uUYTQhsKOZPFa6rpeCJbaW0B+8R4GZdrnOCdV69thVlE4i1M4ckfUt
        TexynLjoHYQ5E5pMYrV4fgaiotk0ckJZ2KvtBdllFj831FygoQjFDvsLLSKp9ysCQO/hFyNTgUMSG
        fvTIAOlzRE5XtGA+Yfnuvcknd2YqrlYfgbI031Qvrav0+pe41di0xao3h5MXhzqV6E/w2mg1UxyLz
        RzS1VPQQztU6jsbO8IYeUV3rMtCmFgFTQ9Y/fax3b8VBZqO7rSMx7+WZUi94nkWecL4WZ9NnvSKAK
        YSETGYpA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1z-0092ii-0e; Thu, 16 Jun 2022 13:19:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1w-0006Fs-RM; Thu, 16 Jun 2022 13:19:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jun 2022 13:19:44 -0600
Message-Id: <20220616191945.23935-15-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 14/15] md/raid5: Improve debug prints
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debug print for raid5_make_request() so that each request is
printed and add the logical sector number to the debug print in
__add_stripe_bio().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9e18dc9ae8b4..e48c16bfe657 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3520,8 +3520,9 @@ static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 				sh->overwrite_disks++;
 	}
 
-	pr_debug("added bi b#%llu to stripe s#%llu, disk %d.\n",
-		 (*bip)->bi_iter.bi_sector, sh->sector, dd_idx);
+	pr_debug("added bi b#%llu to stripe s#%llu, disk %d, logical %llu\n",
+		 (*bip)->bi_iter.bi_sector, sh->sector, dd_idx,
+		 sh->dev[dd_idx].sector);
 
 	if (conf->mddev->bitmap && firstwrite) {
 		/* Cannot hold spinlock over bitmap_startwrite,
@@ -6093,6 +6094,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		   DIV_ROUND_UP(ctx.last_sector - logical_sector,
 				RAID5_STRIPE_SECTORS(conf)));
 
+	pr_debug("raid456: %s, logical %llu to %llu\n", __func__,
+		 bi->bi_iter.bi_sector, ctx.last_sector);
+
 	/* Bail out if conflicts with reshape and REQ_NOWAIT is set */
 	if ((bi->bi_opf & REQ_NOWAIT) &&
 	    (conf->reshape_progress != MaxSector) &&
-- 
2.30.2

