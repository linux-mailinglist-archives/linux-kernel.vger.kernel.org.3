Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12CC574159
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiGNCJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGNCIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:08:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F3E0DB;
        Wed, 13 Jul 2022 19:08:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjyZy0x1Cz4xZB;
        Thu, 14 Jul 2022 12:08:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657764522;
        bh=PLlu6kAAk+tOj3LaXYtsyS4k3FmmUCS2SfhxWX06/TM=;
        h=Date:From:To:Cc:Subject:From;
        b=K3Ctr/kuMrq8L+BSOZbyBvt5+T0JXXSUkdTE7QTxvei2jYKZjoUL/XZgsc0GblSvt
         Sxdpc9yHuzbL+w9m184y2ypqvVmmZU7qreRjP2tpjwY6pJIoLLpsfAyIujMA84Jkx1
         BYJUeKOpAICq+Kc27/w5h57cflny7mwCvgfb4dwyizGlPFrZo+J4FGUsSCKZhwIWUx
         Je19yGXPQ4IW1UP2lGdOerbTOCeQUifsByfd4a0PlkZSzwu4XArBqHUIMV8BIhNl2q
         uFUmdgcUMSYO4Ri/pc00nHw/Jz3Ittr3EXz1j5o7kLX2IMIjTfzWGjOoSabzT1/ouE
         RUPxxx/WDgNiw==
Date:   Thu, 14 Jul 2022 12:08:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220714120840.1e1f8c63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RKj+l2Y+.C/kq_gtcYpT_7U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEXHASH_WORD,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RKj+l2Y+.C/kq_gtcYpT_7U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  block/bio.c

between commits:

  35006342b739 ("block: ensure iov_iter advances for added pages")
  248022ffae3f ("block: ensure bio_iov_add_page can't fail")
  7b1ccdf617ca ("block: fix leaking page ref on truncated direct io")
  9a6469060316 ("block: convert to advancing variants of iov_iter_get_pages=
{,_alloc}()")

from the vfs tree and commits:

  5a044eef1265 ("block: ensure iov_iter advances for added pages")
  ac3c48e32c04 ("block: ensure bio_iov_add_page can't fail")
  44b6b0b0e980 ("block: fix leaking page ref on truncated direct io")

from the block tree.

Commits 35006342b739 and 5a044eef1265 are the same patch as are
248022ffae3f and ac3c48e32c04.  Commits 7b1ccdf617ca and 44b6b0b0e980
are slightly different.  Then 9a6469060316 touches the same code :-(

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/bio.c
index d3bc05ed0783,6659442eb101..000000000000
--- a/block/bio.c
+++ b/block/bio.c
@@@ -1199,8 -1199,8 +1199,8 @@@ static int __bio_iov_iter_get_pages(str
  	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
  	struct page **pages =3D (struct page **)bv;
  	ssize_t size, left;
- 	unsigned len, i;
+ 	unsigned len, i =3D 0;
 -	size_t offset;
 +	size_t offset, trim;
  	int ret =3D 0;
 =20
  	/*

--Sig_/RKj+l2Y+.C/kq_gtcYpT_7U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLPeqgACgkQAVBC80lX
0Gx53gf/ci1liNDJAqaT7M4TDHdM9tRmw52b1cfdFtPVaIt9ykDx1nFR/XH3gScc
WYfKc4I5CQvtNfQ5EYVgcsqvDS4QwexAuAh+0n4leIa0TJ7ndknT8lxm2YbXIcC/
FfxxJokrsyxOwJcayBfOX2rbXASE1WmQUEudxCj0A4eyzLQnKjHjCLwL9LzPgGqn
Dz+/sWnNPem3Jr/WO25B2vw531cXZtVV3jPPzGJ1AWzX0e6t3G8hVQRTGwIE16dx
5TsWq3ybU7UXya5i/3viO7QHzx6fhx+dPFLq8hN9Emob1ocgd3PDMgw/cNiK1ipQ
62zZv+xzFAO4vHQ1s4H9I1wRHBi1xQ==
=iw9R
-----END PGP SIGNATURE-----

--Sig_/RKj+l2Y+.C/kq_gtcYpT_7U--
