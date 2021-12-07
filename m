Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6951446B312
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhLGGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLGGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:43:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8FDC061746;
        Mon,  6 Dec 2021 22:39:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7Vyg0MYFz4xQs;
        Tue,  7 Dec 2021 17:39:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638859180;
        bh=humB7gWFwfA270cwVh2wojrWP0TKdp3OiDLKYZtRPnA=;
        h=Date:From:To:Cc:Subject:From;
        b=GfgR35k+u2/2zOaEt7XXchYfX0EIy4ekSyInc11HkTmsxBKGx6gkSP8rOIUYehy0S
         AKjYHcA6RElLCBuw/X9ObpIA/EvY/i7KBVArVHWdycdSirnSOInjnKmYkVkigr4Y7E
         nCyBc7POu5rW3VkZyyXG+Frb1f9xuQv33O4iqUGpL4MQAf/57t2FEl7n5ibpokZ6zz
         ri21lhV5d12fElxEU1sxZxbWOiJ0Uf/I31LnhaHWiRY0bdRJ9lNGxhVHMsEVnJo2F6
         rVsrWf6sPpbd4MQ8KcP1JsOxqbhKUqiaYQASq9uPLIPHo/skZKTphoaa5MdhX2fZK/
         zUpT+QOwz/hKQ==
Date:   Tue, 7 Dec 2021 17:39:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the akpm-current tree with the nvdimm
 tree
Message-ID: <20211207173938.6d619ba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/84qZdFr4wbM0tH=9_lDSYQj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/84qZdFr4wbM0tH=9_lDSYQj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/memremap.c

between commit:

  b80892ca022e ("memremap: remove support for external pgmap refcounts")

from the nvdimm tree and commit:

  30156644eb0d ("mm/memremap: add ZONE_DEVICE support for compound pages")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memremap.c
index 643965da13a6,d591f3aa8884..000000000000
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@@ -110,8 -136,33 +136,9 @@@ bool pfn_zone_device_reserved(unsigned=20
  }
 =20
  #define for_each_device_pfn(pfn, map, i) \
- 	for (pfn =3D pfn_first(map, i); pfn < pfn_end(map, i); pfn =3D pfn_next(=
pfn))
+ 	for (pfn =3D pfn_first(map, i); pfn < pfn_end(map, i); \
+ 	     pfn =3D pfn_next(map, pfn))
 =20
 -static void dev_pagemap_kill(struct dev_pagemap *pgmap)
 -{
 -	if (pgmap->ops && pgmap->ops->kill)
 -		pgmap->ops->kill(pgmap);
 -	else
 -		percpu_ref_kill(pgmap->ref);
 -}
 -
 -static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 -{
 -	if (pgmap->ops && pgmap->ops->cleanup) {
 -		pgmap->ops->cleanup(pgmap);
 -	} else {
 -		wait_for_completion(&pgmap->done);
 -		percpu_ref_exit(pgmap->ref);
 -	}
 -	/*
 -	 * Undo the pgmap ref assignment for the internal case as the
 -	 * caller may re-enable the same pgmap.
 -	 */
 -	if (pgmap->ref =3D=3D &pgmap->internal_ref)
 -		pgmap->ref =3D NULL;
 -}
 -
  static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
  {
  	struct range *range =3D &pgmap->ranges[range_id];
@@@ -271,8 -322,7 +298,7 @@@ static int pagemap_range(struct dev_pag
  	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
  				PHYS_PFN(range->start),
  				PHYS_PFN(range_len(range)), pgmap);
- 	percpu_ref_get_many(&pgmap->ref,
- 		pfn_end(pgmap, range_id) - pfn_first(pgmap, range_id));
 -	percpu_ref_get_many(pgmap->ref, pfn_len(pgmap, range_id));
++	percpu_ref_get_many(&pgmap->ref, pfn_len(pgmap, range_id));
  	return 0;
 =20
  err_add_memory:

--Sig_/84qZdFr4wbM0tH=9_lDSYQj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGvAaoACgkQAVBC80lX
0Gyjxwf/fC88/ynoW8DLyhtK3lZ9jy3dm5hULz7+yHDKGTMVTTP81IcehBpXbxu5
J+zGqt2b0MfMoJLuQgvwOmWlNq1cJKfalh4k6zBOAtEScErkg5T10PEe5XMzFYi2
wkzftiRZMw2B5ITsAlXQVfB/HQKREOlwMuLv305WteGSc/hhDgRJqjrrE3g7xUQy
NBa2/O5Qhd3uZZdLzP8o/LWUhNwvdAv/gPrUS0E3HDoWtiBR2mHNQEPc7VpARJZq
7L4pcPcdSo7g6Ry09CqHNBSX/G1SW4wQNdcr3TAW40NdOKjWWp+SPuKPw+Qx2Pm3
bAAU5/9FoBlt8uphi4HbemdrnARNDw==
=6Hy0
-----END PGP SIGNATURE-----

--Sig_/84qZdFr4wbM0tH=9_lDSYQj--
