Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6524EB639
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiC2Wzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiC2Wzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:55:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442003FBC8;
        Tue, 29 Mar 2022 15:53:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSlH50HVgz4xXS;
        Wed, 30 Mar 2022 09:53:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648594433;
        bh=qrPpwiIAHCeNksQ+JywLn4vMgsBDZMaO6IN6ibWBE3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=YPl1T+okG12rswtu1rgYIqDT83KXLsSzupa1J6st5lSPj0vbfnblEIIjwQvsg9bPf
         /c7ZLaq3BMyoJikuG8+3G8+EF1KHtqiRs4ebKYXViPfBpLiFJir7GYzOjepT90JL06
         VUqdT2v4Dh898KNpql+Bx1Y4KA0w9qGXwkB54PFmxdLL+Ie0NHIEVW5wMOiDij7eGS
         CCwpkda3QlR8LcmpxunRGPWVsNKIyD9n7DvUAeX5B/A44HToQDjUC5CG6ewhrlZZ82
         9l2Q10bTYcOsu6SSTnX2sGJ4u6lLnjvS706CeDwoibBiCzVImWAnBjzogNEnXWE4SL
         12eVkELlr4dLA==
Date:   Wed, 30 Mar 2022 09:53:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the device-mapper tree with Linus' tree
Message-ID: <20220330095351.31ae6bf1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3Dm3ZIsBFncRF__QydqiTNF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3Dm3ZIsBFncRF__QydqiTNF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  drivers/md/dm.c

between commit:

  a773187e37fa ("scsi: dm: Remove WRITE_SAME support")

from Linus' tree and commit:

  259a97ec4818 ("dm: optimize is_abnormal_io for normal rw IO")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/md/dm.c
index ad2e0bbeb559,853185992c5c..000000000000
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@@ -1413,17 -1504,21 +1493,20 @@@ static void __send_changing_extent_only
 =20
  static bool is_abnormal_io(struct bio *bio)
  {
- 	bool r =3D false;
+ 	unsigned int op =3D bio_op(bio);
 =20
- 	switch (bio_op(bio)) {
- 	case REQ_OP_DISCARD:
- 	case REQ_OP_SECURE_ERASE:
- 	case REQ_OP_WRITE_ZEROES:
- 		r =3D true;
- 		break;
+ 	if (op !=3D REQ_OP_READ && op !=3D REQ_OP_WRITE && op !=3D REQ_OP_FLUSH)=
 {
+ 		switch (op) {
+ 		case REQ_OP_DISCARD:
+ 		case REQ_OP_SECURE_ERASE:
 -		case REQ_OP_WRITE_SAME:
+ 		case REQ_OP_WRITE_ZEROES:
+ 			return true;
+ 		default:
+ 			break;
+ 		}
  	}
 =20
- 	return r;
+ 	return false;
  }
 =20
  static bool __process_abnormal_io(struct clone_info *ci, struct dm_target=
 *ti,

--Sig_/3Dm3ZIsBFncRF__QydqiTNF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJDjf8ACgkQAVBC80lX
0Gw7Lwf/WU0Ot/E0KOVq7oTE1DLF/PnS9vlugBWs1Onkrh40KtXQgEFDHoN7zU78
a0q+ods8eQ9lVpDxob2C/2zJpfQJ+BIHoBMmLapvX1h8uq7cHAUjDhBGiPiIb8wK
ujz13QHFH2Jr1kZhWUE/FQDqkXauhX7n/7EP9tX+RvnIj4fNe6DinYu9Fd7sq3T1
qoh6xlbLKKotA6Z4itDp3wJI0Kl5Q1N0ByISBp/OuJdwFeRbbKpE16OSxcoV+YmA
UXpP+cu7VUst4dS3yAt+rmNsv82ygiItVk2BEhnZ+zkHQiu6eLGJvTf3vfCeTh7z
JGptJjazV874NZhNGcvDuR634VPArQ==
=RHAT
-----END PGP SIGNATURE-----

--Sig_/3Dm3ZIsBFncRF__QydqiTNF--
