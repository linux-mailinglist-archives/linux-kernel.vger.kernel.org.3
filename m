Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D653BDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiFBSTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiFBSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:18:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16D4DF5B;
        Thu,  2 Jun 2022 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Z2bqpdyim3k54UNGywHdz6SV6HWQMMuMEb3NCguedfE=; b=tLUuTWJGMou4JoIsi68WxJ1Q00
        tOJduKuINR4axLQfI7zi1WbNIBU/njhnSODNlNjeNGr7NgjiG8TF14svzUIYoFwYbhkwYNxpJMbz5
        wN0WIWMTywYksQOpihXbT/9XQzfggILEir/tJRkyUImBW4gfV5NPFDSDFFZ8oeVgKFxVh/cTyxCx0
        FaNrxQPKZKiBIiJwo0FGYaQYZzIfrf2wCigKkirXuEbO6/lubkLymf/ECPXMzGI+H0PyH3Yk95Q9T
        u3i4+HVCRSxZhP9qEkMx73I3lcSqZbnSeOB7nyY/NoncoXDptztTGw5OwqNT9ATlyKQtMNoBSkevu
        DvOgZYUQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOo-00EPmZ-5d; Thu, 02 Jun 2022 12:18:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOn-000DDm-EL; Thu, 02 Jun 2022 12:18:21 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  2 Jun 2022 12:18:17 -0600
Message-Id: <20220602181818.50729-12-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602181818.50729-1-logang@deltatee.com>
References: <20220602181818.50729-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 11/11] md/raid5-ppl: Fix argument order in bio_alloc_bioset()
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
---
 drivers/md/raid5-ppl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 4f5bdb4cad2b..db49edec362a 100644
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

