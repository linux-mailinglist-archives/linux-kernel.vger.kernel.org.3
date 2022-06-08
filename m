Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA25438FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiFHQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiFHQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:08 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667231FE4E2;
        Wed,  8 Jun 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=K5M/bNqtaBIwPVRtDLnFoTNPvmJ/ZCoFjJV3JlUzG3Y=; b=e1mBpbuP0272reJp2/n3fzJ3mF
        xgqsjLNp+OzAJ83hIs+/y5VzWKomCAdGnv9i4IdYou7X56qa0jUJ7BigQLQBubBgaJoUV9wXGPpOH
        dEo6URhT7MTOV8LoMeeqvSuv+tgRb1Tz7PxWm+U1I4fakdvoldNBpFos1+DBZ1G1nqVMyueuZNWgh
        brIdez2WQTLx38DRm19KBVjkXPY6PVVM7hrVSH7GzIlTpKCTeXffvXYwm9kulWOMrlbhj3MrKx/8e
        5BuYP4UFxIs4WtbWtbUUSd/DcYsUveJqPs5UN/Zv0TwkvIsFzl8JPiqRUVwNyUxhLfmhZzsBts6ie
        rxIWPZSA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXK-0026n6-HP; Wed, 08 Jun 2022 10:28:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXG-000bdG-4x; Wed, 08 Jun 2022 10:27:58 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Wed,  8 Jun 2022 10:27:46 -0600
Message-Id: <20220608162756.144600-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608162756.144600-1-logang@deltatee.com>
References: <20220608162756.144600-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 01/11] md/raid5-ppl: Fix argument order in bio_alloc_bioset()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_alloc_bioset() takes a block device, number of vectors, the
OP flags, the GFP mask and the bio set. However when the prototype
was changed, the callisite in ppl_do_flush() had the OP flags and
the GFP flags reversed. This introduced some sparse error:

  drivers/md/raid5-ppl.c:632:57: warning: incorrect type in argument 3
				    (different base types)
  drivers/md/raid5-ppl.c:632:57:    expected unsigned int opf
  drivers/md/raid5-ppl.c:632:57:    got restricted gfp_t [usertype]
  drivers/md/raid5-ppl.c:633:61: warning: incorrect type in argument 4
  				    (different base types)
  drivers/md/raid5-ppl.c:633:61:    expected restricted gfp_t [usertype]
				    gfp_mask
  drivers/md/raid5-ppl.c:633:61:    got unsigned long long

The sparse error introduction may not have been reported correctly by
0day due to other work that was cleaning up other sparse errors in this
area.

Fixes: 609be1066731 ("block: pass a block_device and opf to bio_alloc_bioset")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-ppl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 973e2e06f19c..0a2e4806b1ec 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -629,9 +629,9 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 		if (bdev) {
 			struct bio *bio;
 
-			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
+			bio = bio_alloc_bioset(bdev, 0,
 					       REQ_OP_WRITE | REQ_PREFLUSH,
-					       &ppl_conf->flush_bs);
+					       GFP_NOIO, &ppl_conf->flush_bs);
 			bio->bi_private = io;
 			bio->bi_end_io = ppl_flush_endio;
 
-- 
2.30.2

