Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF8567D77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGFErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFErD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:47:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB51C928;
        Tue,  5 Jul 2022 21:47:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ld6TF1kgYz4xD9;
        Wed,  6 Jul 2022 14:46:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657082818;
        bh=37dZnU5e8vGCV4yrp5k6NCnfhctKFwY0o/cpzafXxhc=;
        h=Date:From:To:Cc:Subject:From;
        b=DqyQxraeXDz+EgAagnLf057oT+FE6d8ZBwjVke0GFG1V0YjkL75sYQImEq9Lx6v1X
         mZTNKYTvuMWyRxN3/kyx1J4xekZdoFoGzQxh1AiQN6ff0HteWtOBGwl4AM3j1uohd4
         NOrGZF+Kt2K9x/F9BUL24qnp6iFNQIkB8y+rrLgLz47xWDr4KgBQYf9HC+owt4HY5s
         CIn4pJpiJJz5TM9YvTtdxpqc9agVtgMzKLET1AUfMO7+SvHZqj0xU0NmJWyJEYRaub
         KB+W+8qagd84+8JOyD7+lpNJgMxdVLyfLyAYlh9XND2wFTYnb7+ZZF/rRk0zBbnft8
         smgRgHilgrl0A==
Date:   Wed, 6 Jul 2022 14:46:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: linux-next: manual merge of the vfio tree with the vfio-fixes tree
Message-ID: <20220706144652.1b254c76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NHzqA7IVgl+jcg=a+E2Na51";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NHzqA7IVgl+jcg=a+E2Na51
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfio tree got a conflict in:

  drivers/vfio/vfio.c

between commit:

  afe4e376ac5d ("vfio: Move IOMMU_CAP_CACHE_COHERENCY test to after we know=
 we have a group")

from the vfio-fixes tree and commit:

  3b498b665621 ("vfio: Use device_iommu_capable()")

from the vfio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vfio/vfio.c
index e60b06f2ac22,bd84ca7c5e35..100a3d84380c
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@@ -549,16 -551,6 +551,16 @@@ static struct vfio_group *vfio_group_fi
  	if (!iommu_group)
  		return ERR_PTR(-EINVAL);
 =20
 +	/*
 +	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
 +	 * restore cache coherency. It has to be checked here because it is only
 +	 * valid for cases where we are using iommu groups.
 +	 */
- 	if (!iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY)) {
++	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY)) {
 +		iommu_group_put(iommu_group);
 +		return ERR_PTR(-EINVAL);
 +	}
 +
  	group =3D vfio_group_get_from_iommu(iommu_group);
  	if (!group)
  		group =3D vfio_create_group(iommu_group, VFIO_IOMMU);

--Sig_/NHzqA7IVgl+jcg=a+E2Na51
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLFE70ACgkQAVBC80lX
0GwWyQgAiu66Ldsd3ExZ3lzoPIS72M1dv5BWBmvFD5E4fR/p8LTVtyCmq2OVM/Cq
7ulguEnOYuGi8r0LKWtd167E6BtcJshvwcukwfmBGgzQr50tPNoRDvzlZggWyB5r
JYSge6uMHKymacBZt/yhg5IXSumLPllx09kdy+ewePks581+6AiKIYPGmMx8tKXQ
3Sm84cblVJc11BcPeG6j6YTTxKntBOHh+Ya80MTfXPFlOPueCf3DtMo7AgB9v72H
4I59zBu+6aefEM6fs8A4bvq4jeY7+MGBmpvT8/SFv/s//bQcTm9YvwnAgwlCRKxT
xruFqlV8mgTUyS2gp7V236wE4A6S9g==
=B/S1
-----END PGP SIGNATURE-----

--Sig_/NHzqA7IVgl+jcg=a+E2Na51--
