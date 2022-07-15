Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE435759D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiGODJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiGODJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:09:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165727B16;
        Thu, 14 Jul 2022 20:09:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkbt60vgmz4xbm;
        Fri, 15 Jul 2022 13:09:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657854542;
        bh=7BwLNlroG6v3sM9DCELXiBe/wL7sCsIzP8f78nOCOcU=;
        h=Date:From:To:Cc:Subject:From;
        b=uPLUlGbfNywSVBFtEduHMbhvVOErInrR9tB8Mn4g/oXj/gN7XfBAkZF+O2JYLpERH
         vy+vNg4mcFAgi1PmWj+Fm6/dNMt442/XZiC1XYA0iBHrleYMmsmFeFSb2gHoq12G8r
         3x2UengZ1twS1eAOjp9vacFf70IohPhh+a20CG82jQFLZBlOUGbKGnzIDSmuDQ9yZl
         m+kCDt9mA9UyzJY2QCu2jL48uYmaGfZBNYCT8EyXlg+UTC95C1/FqsMGNwHRXGKd+i
         os/w45wbuF2ic01nhtISUOwyUWIVWSUHmN3iUrHBc8yJu/jdPxXqd2mg9IPQ4Vtbms
         /QqdhxrBxNC/w==
Date:   Fri, 15 Jul 2022 13:09:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220715130900.75322a55@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MI8Y+eEld9Tan6HyyvPZ5OJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MI8Y+eEld9Tan6HyyvPZ5OJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/fops.c

between commit:

  91b94c5d6ae5 ("iocb: delay evaluation of IS_SYNC(...) until we want to ch=
eck IOCB_DSYNC")

from the vfs tree and commit:

  16458cf3bd15 ("block: Use the new blk_opf_t type")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/fops.c
index 7a40bc87d80f,29066ac5a2fa..000000000000
--- a/block/fops.c
+++ b/block/fops.c
@@@ -32,14 -32,14 +32,14 @@@ static int blkdev_get_block(struct inod
  	return 0;
  }
 =20
- static unsigned int dio_bio_write_op(struct kiocb *iocb)
+ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
  {
- 	unsigned int op =3D REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+ 	blk_opf_t opf =3D REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 =20
  	/* avoid the need for a I/O completion work item */
 -	if (iocb->ki_flags & IOCB_DSYNC)
 +	if (iocb_is_dsync(iocb))
- 		op |=3D REQ_FUA;
- 	return op;
+ 		opf |=3D REQ_FUA;
+ 	return opf;
  }
 =20
  static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,

--Sig_/MI8Y+eEld9Tan6HyyvPZ5OJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLQ2k0ACgkQAVBC80lX
0GwBLwf/T/ovlmLquJjZlA3K3kRnAtD+HQlNKyjlf2++Nk/hOY7Ncib+vU+HJBDK
YMzasHrtm2QmbL07IatADeE7qADFia5BqcTF1jlM2A7QIo6AkzMQgm8H2gHEi6Hn
tZ8YPlhqPI27pTdpG2nYhtdmRLo1wcEnWkmpdJDdTh/jTtIVUTXsNIuH9o3mfx3y
DWULaVgz3oPtQ7oVVFeQp2CaZDX/214PrXqoYnns59KmjUEVxDrfnP6tu+fRToro
mdzd10t8fbHja55vMT836L+0cNuLvmbVyOtKGlXz445Qst1sH7hkwYMywjJPAt9t
Xa/5oy2W2YMKHX1j7/BQkPV5YkTpmA==
=x2Rv
-----END PGP SIGNATURE-----

--Sig_/MI8Y+eEld9Tan6HyyvPZ5OJ--
