Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688B5478B57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhLQM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:26:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55171 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLQM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:26:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFpBX16Thz4xgr;
        Fri, 17 Dec 2021 23:26:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639744004;
        bh=n55WYm3Kkk9VniZa6wLs4zNFMLAVbXlaOc9QQH8RsQs=;
        h=Date:From:To:Cc:Subject:From;
        b=AVW1cRbFtBC8Odoj0imrt7/ZDDtE/WBes5TFAJdUYtc9DzN1dCWYrNR38mbvEQqtY
         LMJ6pElQx/NyMTVKgUadbKyrCrP9D+JBWAOyOSDMJN8fCNKCol+kkM0vW1pxY6hs0Q
         hOW70BL2Ij+v+Tzpx3rXsw5vfKLCn2GM6EUrz/B6C6VSnsSTh14nWRFj8LQ5yZMUaB
         LzNZma2ie0vX1PkfEljNmRyqoo7IvS95CIVqOO8Q/k0tQDmLMjVFbXCdwfxlXnGl5O
         dDIMguLnj3EBqcdjmMrlB4Y2UMOsIeVToOI/NUI7OMYyygb3raFPj0/NSbBEqCNjFd
         WHBR/WI7ayljw==
Date:   Fri, 17 Dec 2021 23:26:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20211217232641.0148710c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.d4b.TwFU=_K8EIepP8oTuV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.d4b.TwFU=_K8EIepP8oTuV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/vmalloc.c: In function '__vmalloc_area_node':
mm/vmalloc.c:2983:11: error: implicit declaration of function 'memalloc_nof=
s_save' [-Werror=3Dimplicit-function-declaration]
 2983 |   flags =3D memalloc_nofs_save();
      |           ^~~~~~~~~~~~~~~~~~
mm/vmalloc.c:2985:11: error: implicit declaration of function 'memalloc_noi=
o_save' [-Werror=3Dimplicit-function-declaration]
 2985 |   flags =3D memalloc_noio_save();
      |           ^~~~~~~~~~~~~~~~~~
mm/vmalloc.c:2995:3: error: implicit declaration of function 'memalloc_nofs=
_restore' [-Werror=3Dimplicit-function-declaration]
 2995 |   memalloc_nofs_restore(flags);
      |   ^~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:2997:3: error: implicit declaration of function 'memalloc_noio=
_restore' [-Werror=3Dimplicit-function-declaration]
 2997 |   memalloc_noio_restore(flags);
      |   ^~~~~~~~~~~~~~~~~~~~~

Caused by commit

  0256fe4b2ffb ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")

I have applied the following fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Dec 2021 23:15:05 +1100
Subject: [PATCH] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc fix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 01eabaf5417b..eb6e527a6b77 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -38,6 +38,7 @@
 #include <linux/pgtable.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
=20
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/.d4b.TwFU=_K8EIepP8oTuV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8ggEACgkQAVBC80lX
0GyuTAgAjAd3s2Ua8CLXkTCJFPpMOesE0CSKDbq0oEEcIbMCBBVhO5gYiz+n8M6l
PoKYPnaPVOrjwKKklE5WwRNSG9vPzg0R0aytWje5Q4nwa8zeqMjmWMkRJd8vzozG
Vs5jeUvjQ83vFx3T54g/1ByuTjuTOqvjB/kJypzdqEYgxz3susAwSuIdrDOveREw
frQN6RqbtcZjgp5oKg9IDs8xYLs4da1AXS7sq5WrYoXZRoAwtH9eGsPJmhLiCGxr
3es6XoUyK2tShuN56VUIFG5rDssm26P5NLDy74PPLak3+42hNnl8Z048HUxF2rtB
hEM+6PQylkQMMxRvvW7kbMHlDhrFqQ==
=Wxc3
-----END PGP SIGNATURE-----

--Sig_/.d4b.TwFU=_K8EIepP8oTuV--
