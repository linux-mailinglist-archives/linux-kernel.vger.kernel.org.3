Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160765A8E35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiIAGRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiIAGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:17:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C855119C7F;
        Wed, 31 Aug 2022 23:17:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJ9nP581Tz4x7X;
        Thu,  1 Sep 2022 16:17:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662013050;
        bh=iLuja9fvDy9QMhQLbhFUTMNzuxhgjY/cOCw2doxtaaI=;
        h=Date:From:To:Cc:Subject:From;
        b=fPPAU58hKsqnDJqjIv23XFhcgPU8Vhft4qvQo/x9dQXC13P6IaG2rzgLEvg7FS4hq
         zqP5YceJxF6bN53YZjtoIu7VgGPRP9MR9r7UCrj49kqhdS6NHgx52VatKoLy7CgVUF
         BkOZg7rMgMe1760+yIRKECBWvw0r1mLkGI6szkquF63SBR6Zi+IbtmyhCJnCTlL/E6
         8ZPcCGSEEYYXZasGsnlmfmzFWQQOFSDrMT28i5UfCym9umBtiInxpEGdZkXPTSQw7a
         KE/k15RGT2zGIAe0IL2bkYFXWJl49TGo38UxVlOSEECmDLeVjDRtl18RaO2ttdw5Dd
         KScNl1XzvgG7A==
Date:   Thu, 1 Sep 2022 16:17:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the block tree
Message-ID: <20220901161722.739d2013@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BwiORinp9_1=EAlF+gYXM=A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BwiORinp9_1=EAlF+gYXM=A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  block/blk-map.c

between commit:

  e88811bc43b9 ("block: use on-stack page vec for <=3D UIO_FASTIOV")

from the block tree and commit:

  2e9a2aa23dad ("block, bio, fs: convert most filesystems to pin_user_pages=
_fast()")

from the mm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk-map.c
index f3768876d618,4e333ad9776d..000000000000
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@@ -273,14 -254,8 +273,14 @@@ static int bio_map_user_iov(struct requ
  		size_t offs, added =3D 0;
  		int npages;
 =20
 -		bytes =3D dio_w_iov_iter_pin_pages_alloc(iter, &pages, LONG_MAX,
 -						       &offs);
 +		if (nr_vecs <=3D ARRAY_SIZE(stack_pages)) {
 +			pages =3D stack_pages;
- 			bytes =3D iov_iter_get_pages2(iter, pages, LONG_MAX,
++			bytes =3D dio_w_iov_iter_pin_pages(iter, pages, LONG_MAX,
 +							nr_vecs, &offs);
 +		} else {
- 			bytes =3D iov_iter_get_pages_alloc2(iter, &pages,
++			bytes =3D dio_w_iov_iter_pin_pages_alloc(iter, &pages,
 +							LONG_MAX, &offs);
 +		}
  		if (unlikely(bytes <=3D 0)) {
  			ret =3D bytes ? bytes : -EFAULT;
  			goto out_unmap;
@@@ -315,9 -290,8 +315,9 @@@
  		 * release the pages we didn't map into the bio, if any
  		 */
  		while (j < npages)
- 			put_page(pages[j++]);
+ 			dio_w_unpin_user_page(pages[j++]);
 -		kvfree(pages);
 +		if (pages !=3D stack_pages)
 +			kvfree(pages);
  		/* couldn't stuff something into bio? */
  		if (bytes) {
  			iov_iter_revert(iter, bytes);

--Sig_/BwiORinp9_1=EAlF+gYXM=A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMQTnIACgkQAVBC80lX
0GzjyQf/Ypjm0mgnag80cyUeXYuNl5PxExbF8FGpYWr/mG2I08eItCO08HSaAiyO
1uJsJnagP4qPXD6nlWIsLY6U47NStd0vS0c3gHnpjMKT5eFu644ASgBwSun/+y3q
Qc3r7BPEDzPNqaUrCFwRCLFVSKdXNvHyTNA5WyyqfSWTHwglT2YyVYqvhX7AyXHD
Om/o2e0wvBkuyGtP4fENF2SAhcyE2qejuZ7auwwraZNQZMZVEkq3ifCqfbmjKNAB
9Eb1Xq081z4v691yDp2WGzWsw6QrUUJaomYjqfxHT+ieAmK9LT8uZHGafgJatoxv
Na+yJQW7xOQWsiTKvVXO2VyrkaHO4w==
=tZvs
-----END PGP SIGNATURE-----

--Sig_/BwiORinp9_1=EAlF+gYXM=A--
