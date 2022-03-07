Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E534CF09B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCGES7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiCGES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:18:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45538201AA;
        Sun,  6 Mar 2022 20:18:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBlYh5f8jz4xYy;
        Mon,  7 Mar 2022 15:18:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646626680;
        bh=w/kZuaG75G/nOsIW4P4LPNLuypol+n96hKvXUKsbCAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=QKrb9MX6CDhy2blKdNBiYvLoh3uITG2ih9mzs7W8itBbh/+Y/vcq/6ILJTMXclZqe
         Sh5McKCANFRK7Td+c9BUWGxq25BAhauPo9MdFfs8Q37/hU5z4Vc6O0SHgBD++1C+2+
         tSHbI6FWp/B4af+YiFeDFXppAvdlqTZvrOcRv6/IsefhbpZ4OJD4JaLuC1iuS5iqK4
         sBN1m9dP8sBzolMikZkgunpNt91q3iHnO5UAyEBUtqICV5x/DPcfpi/CD2W/tmPmiH
         sCvfvMfZUmcLrfIRbZ0l3qHmIfxVRJ+jxez2My7WxFPJaTkalbWX8xnAVrOD90Z525
         0O8+pma2w2JLQ==
Date:   Mon, 7 Mar 2022 15:18:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the scsi tree with the block tree
Message-ID: <20220307151800.311dfe54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/./cI0clFVjA1biqxnYb+Rdr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/./cI0clFVjA1biqxnYb+Rdr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/block/drbd/drbd_worker.c

between commit:

  472278508dce ("drbd: use bvec_kmap_local in drbd_csum_bio")

from the block tree and commit:

  a34592ff6b78 ("scsi: drbd: Remove WRITE_SAME support")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/block/drbd/drbd_worker.c
index 1b48c8172a07,934bfb5d98d0..000000000000
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@@ -326,14 -326,9 +326,9 @@@ void drbd_csum_bio(struct crypto_shash=20
  	bio_for_each_segment(bvec, bio, iter) {
  		u8 *src;
 =20
 -		src =3D kmap_atomic(bvec.bv_page);
 -		crypto_shash_update(desc, src + bvec.bv_offset, bvec.bv_len);
 -		kunmap_atomic(src);
 +		src =3D bvec_kmap_local(&bvec);
 +		crypto_shash_update(desc, src, bvec.bv_len);
 +		kunmap_local(src);
-=20
- 		/* REQ_OP_WRITE_SAME has only one segment,
- 		 * checksum the payload only once. */
- 		if (bio_op(bio) =3D=3D REQ_OP_WRITE_SAME)
- 			break;
  	}
  	crypto_shash_final(desc, digest);
  	shash_desc_zero(desc);

--Sig_/./cI0clFVjA1biqxnYb+Rdr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlh3gACgkQAVBC80lX
0GyUogf9G3PXmrTuzrjwZy2uB7YNCnwxUfs/i/Y61K5hnP+JpA+5p903NaSoS2eh
u8/xVLZUyarg39x8Gh/YDkVJFsGMMo9xcwHpCmNEURH6IttAklXECDsK08g6Ivrm
+EC3y17S8Z8nGxcOH7x0QBroGrAq3gXT2sRMGgCyoKyHOEhYgAW/xhFUg1WiVQby
8RHwYVbTQd+cPhvtHlKCoh+n5yas1K5MX5ixu+jF6EnddJa6ZaHQ+mt+jtwjzQGP
BLcQ3BKT+ade3pKHv5pziIJJY5h2WDZwF7NqxDme5kL03aTn5y2eGAnfB+4Tv7A8
XMCTvc9vbE8LCb+iYcs4ZOR0rCwLUA==
=jY7g
-----END PGP SIGNATURE-----

--Sig_/./cI0clFVjA1biqxnYb+Rdr--
