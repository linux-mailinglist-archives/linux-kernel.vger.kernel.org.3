Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351B4B9901
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiBQGM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:12:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBQGM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:12:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF2F1AF3;
        Wed, 16 Feb 2022 22:12:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jzkxl2s5Jz4xNq;
        Thu, 17 Feb 2022 17:12:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645078331;
        bh=IIxohzdVx8GweK2Y3k45JqmhFu+BJpv7EWKPoCEdnO0=;
        h=Date:From:To:Cc:Subject:From;
        b=lcUFRKIyCYJ8WU22GSwGxtQl+grwzzwg6sxTyT+l/lNqqKemYWtJFyN15eK4/NLsQ
         msNEkkYwoJA/iNZnX6cFrdFj+BfEB6soyZLqjI4JUfxR/6Uh5CcHll8QbAvEStzlrt
         UJiYbvBIqUCxG3VKlgDz6CZSUTebkHqU3hxI8BrTqjBXQnosubQx9GEemljXEsszZ+
         zASUAjlQcV1e7iArkDN0aS6h24hl4b12ZQbyI3qXATnq3Uw+U/6033l/TeykxHm99X
         TavGOTPjSj+DRQZ6jvpeABZOHomc7xlqoO+rMCt7yLx6/dVEelpFZwRVOUbifZhony
         mncQTkzvr9CEA==
Date:   Thu, 17 Feb 2022 17:12:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the maple tree with the memblock tree
Message-ID: <20220217171210.5164c2f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gt1k4cHag+JdX1TQm=xiz+p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gt1k4cHag+JdX1TQm=xiz+p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the maple tree got a conflict in:

  tools/include/linux/slab.h

between commit:

  5a198c3f9b0b ("tools: Move gfp.h and slab.h from radix-tree to lib")

from the memblock tree and commit:

  3a77b4e41d4f ("radix tree test suite: Add support for slab bulk APIs")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/include/linux/slab.h
index f41d8a0eb1a4,d7aed1cc6978..000000000000
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@@ -35,4 -24,8 +35,8 @@@ struct kmem_cache *kmem_cache_create(co
  			unsigned int align, unsigned int flags,
  			void (*ctor)(void *));
 =20
+ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **=
list);
+ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t si=
ze,
+ 			  void **list);
+=20
 -#endif		/* SLAB_H */
 +#endif		/* _TOOLS_SLAB_H */

--Sig_/gt1k4cHag+JdX1TQm=xiz+p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN5zoACgkQAVBC80lX
0GxrYgf/cZV4MkHwnu+kgnamM01epwoBLchSffnRTneyS4UorSlWF0rWnO5cnQbf
S9f1OcQMUkTgRtJgD0kQA+OCZChQMF5aef3/nZAhLM2HedOSVmQVf9JWggCi0maU
X6cwRY8NOjN/5S2X4LSrMe6zp7pfsLVg/OYWTpX4ipQgjc/Nb9KeJz6CuJ4Uortt
Zi0fhv4SB57OhKG+vVrG1n6oOuULWzN8T3x6yP5CI/58sMZRt0NPz/+DTAGMWv3m
UciHDXcpzFJF+Wt7jADrbhaQ40OxDf9MxvaUENKKQi9FTiDx4uOzcL+NXP1NGE93
d9JRGwVCE4Q63FfXeDuooOyu3cps8Q==
=d3bP
-----END PGP SIGNATURE-----

--Sig_/gt1k4cHag+JdX1TQm=xiz+p--
