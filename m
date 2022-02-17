Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28E94B991A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiBQGQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:16:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:16:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06CDB9D73;
        Wed, 16 Feb 2022 22:16:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jzl2v1ZRqz4xcP;
        Thu, 17 Feb 2022 17:16:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645078599;
        bh=yndhLuoCihi2mdNtpdhpTeQNtBOWIAtKU+vq2xv7kZM=;
        h=Date:From:To:Cc:Subject:From;
        b=OP19HA3UNVkyhBvi5gMYMXVf3XN95KH8cOwIXYqD5/JlqyRBKdn5w5BoBUv1lbxWt
         pBWSFl82PscDb+t2AKj9PgZp8yJnp7wGXjTq7s3yITefDu3hsYCCEWeKZkBSHyAq9P
         t45uw2KS/+gfMfv2oGBJk9+cSftfvIf2FsMqb6aL1HCG0SSAhXGJ8C+IcB7Vtq8QSA
         i4PCfamtt0gY0GJwTrq+1WW1t67fBy7EmluoxeEXbZd9I8xsu5bD+0+hH4cdCT4DvL
         EjLRMjjVODwpXSFuFIHQMRNivqxb0IhMjkQKs2upmVcQeyhLIl/VZfcXbLe26c2J+o
         tpXgn75GMWsCw==
Date:   Thu, 17 Feb 2022 17:16:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the maple tree with the memblock tree
Message-ID: <20220217171638.084b6321@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/By0+UJL6uInXq.l0EXI+5Gw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/By0+UJL6uInXq.l0EXI+5Gw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the maple tree got a conflict in:

  tools/testing/radix-tree/Makefile

between commit:

  5a198c3f9b0b ("tools: Move gfp.h and slab.h from radix-tree to lib")

from the memblock tree and commits:

  4af8015a7707 ("Maple Tree: Add new data structure")
  f6955b248f29 ("lib/test_maple_tree: Add testing for maple tree")

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

diff --cc tools/testing/radix-tree/Makefile
index c4ea4fbb0bfc,3e0fa6ae0e0a..000000000000
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@@ -4,9 -4,8 +4,9 @@@ CFLAGS +=3D -I. -I../../include -g -Og -W
  	  -fsanitize=3Dundefined
  LDFLAGS +=3D -fsanitize=3Daddress -fsanitize=3Dundefined
  LDLIBS+=3D -lpthread -lurcu
- TARGETS =3D main idr-test multiorder xarray
+ TARGETS =3D main idr-test multiorder xarray maple
 -CORE_OFILES :=3D xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bi=
tmap.o maple.o
 +CORE_OFILES :=3D xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bi=
tmap.o \
- 			 slab.o
++			 slab.o maple.o
  OFILES =3D main.o $(CORE_OFILES) regression1.o regression2.o regression3.=
o \
  	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
  	 iteration_check_2.o benchmark.o

--Sig_/By0+UJL6uInXq.l0EXI+5Gw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN6EYACgkQAVBC80lX
0GwC0QgApRlXYu9STYCVZBWHathn2O42JttqL60cDuHYQ0hwx5tjHwN6zAU8SLZq
HQsDMlaRvrPNVjGrV0IFspPF/EnuD+0EHcSUQVqOvU5N7rPq3oz3Sn09OlXPLiS6
TVvhNl9Lyvvb7LmxhIbVcCcqdwFSotnafAf7F2GQ4kDRKYF8h+qUyULrlSIKQ8FO
t+KxGNgZUZHJ3QNBP/aWcA/nKRQjqG0wv2NDtx8IQ5W6yTWO3PNqh3u3+kSl7jY0
WawQnNPZTChnzCX/ciWFXpUMBacn7dKWi1Bu99YhMrPgXkUIUEM6XaZCs5HbimYU
gqRNfvmV9KevFVQOW3/uITBK+w2V+Q==
=W4U+
-----END PGP SIGNATURE-----

--Sig_/By0+UJL6uInXq.l0EXI+5Gw--
