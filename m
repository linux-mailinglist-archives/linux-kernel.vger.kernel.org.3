Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6D4B3ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiBNBLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:11:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:11:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21760527D0;
        Sun, 13 Feb 2022 17:11:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxmQN60s3z4xdG;
        Mon, 14 Feb 2022 12:11:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644801102;
        bh=VzbAzvyPGcOnwuj9d/Abn7ku3LkVBKdNiAvwFmSRCWc=;
        h=Date:From:To:Cc:Subject:From;
        b=rGS3Pe7EW/xU3gVmhIrAdOM/T2Ea6If9E0hhNDQtyqcwIDDampBq+JJWypbPh0PCh
         7LZw2G2HVIT9f1n10sLQQhx2uxaZ03pTpPhJxQMJA3kUtg88/XD46bxuTzAVM66pKZ
         aSDqYOu3Y1xzHACRK3wrIN3HHGPzKKcPURQyLPTbQIIfMDpDjH80VEsiv08qutxCIo
         HOASNvZ3rgDDYgd5xlROFbYGzcXKFGBHxO1Fy8Hr3HPELA89h4VVO28ONzERk7b35o
         k+T8S9BavbFdk87vOIxKCF697IFWvucmZqBIpY6/BjOBFXpNu+T4M+UqoAqEyv1rXM
         0zTjLmuEtaQLg==
Date:   Mon, 14 Feb 2022 12:11:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: linux-next: manual merge of the block tree with the fscrypt tree
Message-ID: <20220214121139.2e5a4be5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6Qx5ut0wT8y./V7IZS_tqj0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6Qx5ut0wT8y./V7IZS_tqj0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/iomap/direct-io.c

between commit:

  489734ef94f4 ("iomap: support direct I/O with fscrypt using blk-crypto")

from the fscrypt tree and commit:

  07888c665b40 ("block: pass a block_device and opf to bio_alloc")

from the block tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/iomap/direct-io.c
index 20325b3926fa,e2ba13645ef2..000000000000
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@@ -185,10 -183,7 +185,9 @@@ static void iomap_dio_zero(const struc
  	int flags =3D REQ_SYNC | REQ_IDLE;
  	struct bio *bio;
 =20
- 	bio =3D bio_alloc(GFP_KERNEL, 1);
+ 	bio =3D bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
 +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 +				  GFP_KERNEL);
- 	bio_set_dev(bio, iter->iomap.bdev);
  	bio->bi_iter.bi_sector =3D iomap_sector(&iter->iomap, pos);
  	bio->bi_private =3D dio;
  	bio->bi_end_io =3D iomap_dio_bio_end_io;
@@@ -313,10 -307,7 +311,9 @@@ static loff_t iomap_dio_bio_iter(const=20
  			goto out;
  		}
 =20
- 		bio =3D bio_alloc(GFP_KERNEL, nr_pages);
+ 		bio =3D bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
 +		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 +					  GFP_KERNEL);
- 		bio_set_dev(bio, iomap->bdev);
  		bio->bi_iter.bi_sector =3D iomap_sector(iomap, pos);
  		bio->bi_write_hint =3D dio->iocb->ki_hint;
  		bio->bi_ioprio =3D dio->iocb->ki_ioprio;

--Sig_/6Qx5ut0wT8y./V7IZS_tqj0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJrEsACgkQAVBC80lX
0GxG4wgAlPzAE6GvmS3PjUCgOfDzMlxaACpkVu0rM1T9qYCS+ivMxsJVeBQBw517
kOxdD4CpyI5keO2Pg7D8YRTsRLxuDDfcb7Sbs/sazW50xnfH9I9xLogDZOt5NHRr
eF6RgHmfJ2cqauiAqy/esqWqIaGBqDo065Ha78905oTf50mtFGGnG6tSGM6EAp3M
wrJ6tSq2k6TKO3vyGPACoUhWqizewjQQYsRLC5D3IKDZy0pvg4jga3yUiDlG9oEG
j5av7vRv5TmQpTfjYYRSHtlg63YNkJN8hbIusT8iPqzj0DcNa5oyxxGkz771X+sn
z3PUmAMXFnvlVt0gnWbP2GEEich4hQ==
=q12c
-----END PGP SIGNATURE-----

--Sig_/6Qx5ut0wT8y./V7IZS_tqj0--
