Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E8575F54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiGOKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiGOKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:25:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989C82F89;
        Fri, 15 Jul 2022 03:25:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LknZ03WwZz4xMW;
        Fri, 15 Jul 2022 20:25:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657880744;
        bh=4vjOOOwfoF4KOdfvvxHNqQQD9CGszcxtnLonMPLZijg=;
        h=Date:From:To:Cc:Subject:From;
        b=DWtUwNJP9HPBg/4QOFjEtH1xKL0L7JEfLue3r5ApubZ+VyHt4SNHhvMIKkmNxAaRN
         Kn8lo2JJ98cc141pjxNnk0Ngf1GE5xsFnQL/MUUilleU8AZWxrOnMnq15ozlMUtvRi
         KZ3BXTbdE9HogIMIOwvTdjQx9tOmMRboYNN1gZngNWiffms3abOe/J+drYZqpfsfbB
         P3VglX9q5c017d7WB5iwEEdzrnuCoKXVl15dacqArj35QG4/urzyiZVJBH5I6l1rRA
         5w2X6lBMz6+mpgt9zprkRBp0XotDuApRmUfzTiPj5joZxOdZHkUyqHZzwqOmGtT3FW
         eTIp6US/+Q51w==
Date:   Fri, 15 Jul 2022 20:25:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with the arm64 tree
Message-ID: <20220715202543.4062514e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sUAzOhAiNBY2NoANo9iAbkc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sUAzOhAiNBY2NoANo9iAbkc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  include/linux/gfp.h

between commit:

  70c248aca9e7 ("mm: kasan: Skip unpoisoning of user pages")

from the arm64 tree and commit:

  34973181c728 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/=
gfp.h>")

from the bitmap tree.

I fixed it up (I used the latter version of this files and applied the
following merge resolution patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Jul 2022 19:45:25 +1000
Subject: [PATCH] fix up for "mm: kasan: Skip unpoisoning of user pages"

interacting with "headers/deps: mm: Split <linux/gfp_types.h> out of
<linux/gfp.h>"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/gfp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 06fc85cee23f..d88c46ca82e1 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -340,7 +340,7 @@ typedef unsigned int __bitwise gfp_t;
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | \
-			 __GFP_SKIP_KASAN_POISON)
+			 __GFP_SKIP_KASAN_POISON | __GFP_SKIP_KASAN_UNPOISON)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/sUAzOhAiNBY2NoANo9iAbkc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRQKcACgkQAVBC80lX
0Gz0Vwf/aHEnJuOQ1ytugT/PfKOau5wXvMxSZ47sMS1EuXR3h2/dkS/L6xLn+z6h
lfN59c10aExt4pnFP4AftZN7Yd3nqpMnLyOKvyj0ArVlt610rjb3wwSfGftbxY1l
IgQhn3/RXNAQ7ndaQwKXFa1i4jbGtnhqlAp2OLNSylNrBGnR5XDyzTH/dE1V4G38
eF0ZC2g/rA5QUh4QTTZiZXsUQBtoJRyfJjmdlmpAOKJOhY47W7nCwZpqwbfVXCPV
uaxSJJ19OS7KQLCKZOe0Ham3SQFR/FrKJSOdtZcB3VAbpGFa9WYmO1hDFl1eLf6V
9msetJPxWjSx5zMYismORSU57hzvHQ==
=wMuj
-----END PGP SIGNATURE-----

--Sig_/sUAzOhAiNBY2NoANo9iAbkc--
