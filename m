Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD551938C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiEDBoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiEDBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:44:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325891A80F;
        Tue,  3 May 2022 18:40:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtKKF1wQhz4xTX;
        Wed,  4 May 2022 11:40:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651628434;
        bh=QxQ5k3WeRy9fAPYUqZ8f27VNj5G0iGKr5OMkwJuFqZU=;
        h=Date:From:To:Cc:Subject:From;
        b=ZzrTCVnG49PdQY6hsudTqAGovpdIRJR5tPZ6yz2ifD5EL087CmVZFkve8QTptVqd0
         zy3NIx4Ph2jgL2BADQXz5wbykwSuxUyZB1Li1jklyjXOfhAsB4hosWeQM+kuaAo7Z4
         cZ/rJ8X1Ra3NsT9+EdoQfkzw01AI+7866YbklF1zWSDCq64Webx+YvEkRKrYqzGC+1
         4zZlHZiVDmhrwZuCK8qHZhVi/x46O3saXsq6yjPMDgkElpe4MpL9Wy1L22zSkgkMUF
         nelLrkGAC9wzTpDn30yrceS0iq7pkw23QrCl2iGCFb1cQEE4siqQtYnWG6r7qlMun6
         sSOr5qcOlKVRQ==
Date:   Wed, 4 May 2022 11:40:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220504114031.40747e03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hX0vgwFIKurJsaX.xISZtGw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hX0vgwFIKurJsaX.xISZtGw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/block/xen-blkback/xenbus.c: In function 'xen_blkbk_discard':
drivers/block/xen-blkback/xenbus.c:578:31: error: unused variable 'q' [-Wer=
ror=3Dunused-variable]
  578 |         struct request_queue *q =3D bdev_get_queue(bdev);
      |                               ^
cc1: all warnings being treated as errors

Caused by commit

  c899b2353386 ("xen-blkback: use bdev_discard_alignment")

I have applied the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 4 May 2022 11:26:59 +1000
Subject: [PATCH] xen-blkback: remove unused variable

Fixes: c899b2353386 ("xen-blkback: use bdev_discard_alignment")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/xen-blkback/xenbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback=
/xenbus.c
index 04c90cb8955f..97de13b14175 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -575,7 +575,6 @@ static void xen_blkbk_discard(struct xenbus_transaction=
 xbt, struct backend_info
 	int err;
 	int state =3D 0;
 	struct block_device *bdev =3D be->blkif->vbd.bdev;
-	struct request_queue *q =3D bdev_get_queue(bdev);
=20
 	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
 		return;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/hX0vgwFIKurJsaX.xISZtGw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJx2Y8ACgkQAVBC80lX
0GwNhQf47figcnswL2Xb/amERNfqXFce8a5yN7B8wxqYYEckDD27lB3L6irl7zrE
V7HGi/B219Pw5Cml7SKBk/pldokFeDd7y1ERUFqeVySDqMSsKuZeAv4W2y6v26cR
z5iFoZ/gfkE/sS38t0nhwCvRBwpaeoSfedLaMylmn9blS93JINvcSmSQK7gTjZ0S
o2jgnkcntsf3ZeFlnaD61aWmeVY7Kkcnqb/qYLtmAh4Wikep6csJIusxZdJepymE
0+V88MPV/uWg6ruBLXIrAHV8JlZQP9Opbu38QD0V5FLlHQYGHJfrrNBdkluCWYCe
QlvuQowqct6uWLCLofON175y0XRd
=YgK5
-----END PGP SIGNATURE-----

--Sig_/hX0vgwFIKurJsaX.xISZtGw--
