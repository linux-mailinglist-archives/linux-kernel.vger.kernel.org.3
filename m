Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87E45AE558
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiIFK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiIFK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:27:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494CC5FD1;
        Tue,  6 Sep 2022 03:26:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMM4j2VRCz4xGD;
        Tue,  6 Sep 2022 20:26:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662460006;
        bh=L2xKkds7fkPogfw87puWZAy1Lx+vC472R8pSsgR8InU=;
        h=Date:From:To:Cc:Subject:From;
        b=QGf2/rg+Rj6b1p1JcMgKYAmsXQ+8ymg7WWgwrYZpzH1qQRoXx/e0IW2cAaGuAaGe9
         CGmKT8Hc24P1Sp6BXsCq0ZeSU8OlIQNWeuDIWKL8Tza7/2OIcbQ/RqXQQkgq+pIVxI
         f0uI8Xvhn96En8q0QSTugwmQF8AZWsDsS8jwROLf3ETaoP7Dpp5mgIWyTlq4fM0F+6
         /iNAHqEPYPwiOEOWmwzPhIfjzVGlmwkwCqK8CFpib2SBb9Zkp4a/5UCMQjAGX9vrQn
         vJdZp2YI43mzfZZRF5IbTJebsomSYg4lGxLvfOIWC0h1l16+Y2PxFekGojzATPgV7k
         vktk0D2zY3+TQ==
Date:   Tue, 6 Sep 2022 20:26:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Alexander Potapenko <glider@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the slab tree
Message-ID: <20220906202644.6552d26c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+_elwJPqf+hB9eyh+0sj/EJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+_elwJPqf+hB9eyh+0sj/EJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/slub.c

between commits:

  a0c3b940023e ("mm/slub: move kmalloc_large_node() to slab_common.c")
  d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than order-1 page t=
o page allocator")

from the slab tree and commit:

  47dd2b0d3e37 ("mm: kmsan: call KMSAN hooks from SLUB code")

from the mm tree.

I fixed it up (I used the former version of this file and applied the
following patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Sep 2022 19:42:49 +1000
Subject: [PATCH] mm/slab: fix up for "mm: kmsan: call KMSAN hooks from SLUB=
 code"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/slab_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6a76c496e7e0..2e28a551b8d3 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -901,6 +901,7 @@ void free_large_kmalloc(struct folio *folio, void *obje=
ct)
=20
 	kmemleak_free(object);
 	kasan_kfree_large(object);
+	kmsan_kfree_large(object);
=20
 	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
 			      -(PAGE_SIZE << order));
@@ -1078,6 +1079,7 @@ static void *__kmalloc_large_node(size_t size, gfp_t =
flags, int node)
 	ptr =3D kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
+	kmsan_kmalloc_large(ptr, size, flags);
=20
 	return ptr;
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+_elwJPqf+hB9eyh+0sj/EJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXIGQACgkQAVBC80lX
0GyBOAf/Vg03dObWEj/3kfLPWjm9JLyg9tCaLGI1pARaJuSYutTjHT2JGe4QBnGl
xKw6BgrV47fE61AxFGviYJHQUTaK86goB3X7dMNYZIeEkCBsG+XdLppI2aq5UbvA
KndgNFRJFF8PJwGXUCinHCXBtL8DdW/7/AuihBzqE4+qvTFwCXTsQx7z/4oDWtlr
vFs+7/Kcnp1nCuzz36EX8gYHotCvZhfUEUFklClNiE/5geln0ZNeI0BwmZFKdSzb
O6dA9JIZ93mt7mQg4xOXQ0UWot1WstOS91MTHOR6lGEPuhZYlRuHQUf+3c7BZnTF
lxSD9j5FTCuSit8FpER2M/D9AIuUcA==
=UYZP
-----END PGP SIGNATURE-----

--Sig_/+_elwJPqf+hB9eyh+0sj/EJ--
