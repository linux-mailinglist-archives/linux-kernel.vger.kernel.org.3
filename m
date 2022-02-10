Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BF4B068C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiBJGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiBJGr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:47:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50264DC5;
        Wed,  9 Feb 2022 22:48:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvS4F5rqCz4xdJ;
        Thu, 10 Feb 2022 17:47:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644475678;
        bh=td1kwnruqGnsMEqEKZXdiubcxx9JjEhXWqXjQMDC40w=;
        h=Date:From:To:Cc:Subject:From;
        b=bNFirlc2F62z+TBdsiG1HQg1njp4uzIH2tCX18Ckf1EIhnAASsWuaKqLQbq8WOcW9
         KCn6mBmNFNjdB1W3aqKc1I5/NzTE1De2lFYwY56/K08FZObhov7WHQPtjhrvge/NnF
         kwlPPVBhoSlJ46yGAZgGZTOdEAMdQfQ+tWconO4T51JnMxvFCFuTKaOO76M5Tfjm1H
         SDUsThkwzG1xSIRtfSxi0fmrvJL7LBEVrz/viCB5NXpsjfNAIUZ9JVI5Fv9EVvY5sL
         9etSpgOBN9aq5tKkAjp0BQHt/HTkElEJAOWzvI8aKSSISicDjrFsqiTj7yB4axhBIz
         CspKvNmQo1ekg==
Date:   Thu, 10 Feb 2022 17:47:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the akpm-current tree with the memblock
 tree
Message-ID: <20220210174757.551a76c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_mW0RoHFD7s=vAev_6fW7_f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_mW0RoHFD7s=vAev_6fW7_f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  tools/testing/radix-tree/linux/gfp.h

between commit:

  5a198c3f9b0b ("tools: Move gfp.h and slab.h from radix-tree to lib")

from the memblock tree and commit:

  752fdadfaf92 ("mm: discard __GFP_ATOMIC")

from the akpm-current tree.

I fixed it up (I deleted the file and then added the following merge fix
patch) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 10 Feb 2022 17:44:54 +1100
Subject: [PATCH] fix pu for "tools: Move gfp.h and slab.h from radix-tree t=
o lib"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/include/linux/gfp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/include/linux/gfp.h b/tools/include/linux/gfp.h
index b238dbc9eb85..56eec4445bc9 100644
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@ -12,7 +12,6 @@
 #define __GFP_FS		0x80u
 #define __GFP_NOWARN		0x200u
 #define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
 #define __GFP_ACCOUNT		0x100000u
 #define __GFP_DIRECT_RECLAIM	0x400000u
 #define __GFP_KSWAPD_RECLAIM	0x2000000u
@@ -20,7 +19,7 @@
 #define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
=20
 #define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
=20
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/_mW0RoHFD7s=vAev_6fW7_f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEtR0ACgkQAVBC80lX
0GxkNQgAhkdruj1fMatkNFv2d8MbItyhAsd9jMNAI8c7rmB4Cp9W0M7AitG/fo4y
LcSiET0VWp5Qv6JsYs7dppqgTpVm62W6lUp9WcpG3YAK9CDbswLFuT6NtAlAgQul
J/islTJdI+BnKTEGF2cMqJgn/GBe9yH6erPhFR+T0kF05ZhbefRgLqX/Bj+vZ5Fe
AcMfPR3giEq0oblVERmMPyli9BMi2OsWIwhFUqjXy+EpXU1U4U0mKd2EgQWd5uK4
eX+ciDschMUPyOpWJkWC2h8nqs7ehn+IunEiKdeVz/fotzfG89q7W+zjDgB9qHZr
GhxsHR6JEgrL108uUFay+KpwAXNSjQ==
=fBDw
-----END PGP SIGNATURE-----

--Sig_/_mW0RoHFD7s=vAev_6fW7_f--
