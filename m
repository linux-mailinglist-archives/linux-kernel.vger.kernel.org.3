Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35765575FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiGOLOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiGOLON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:14:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BD868B3;
        Fri, 15 Jul 2022 04:14:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkpdt1LT8z4xD2;
        Fri, 15 Jul 2022 21:14:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657883650;
        bh=prRPClwG5dDKLv8gzbu4Q7yzj5Dy8XbpxqLNQ+maTJY=;
        h=Date:From:To:Cc:Subject:From;
        b=J0x98ho3k2SunugagjeGmWpIzoF23Dpcb1wjPEzF2TriSl7nidRB9SSzhuB+Enm9n
         O24e0mM8zTX5o5IHlUCrURW0/I2orPLfSKazVpmfrRCPmPOpr8tGigvL3Yca6/T2b5
         IL3AiGnTkUv/vfepUurSd6VoGecelqMX6zJ9nPnVDsRm3F+RdcHfV6vFeIr8uVIFyQ
         MpVm4HFA/t2D6g8gKWW8gPvQQRtU5odizEOTNqTgXQwegarWye8K9zchzdh7u7FwUt
         x75cWzRSMozweS0L5IC2ZspnIV8OArM0uYpKuMgxKTGMXK2Ij0kn2LwwerMPLS3DaC
         hhOTXJQyq2avQ==
Date:   Fri, 15 Jul 2022 21:14:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the mm tree with the bitmap tree
Message-ID: <20220715211409.4fba48e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bPTZjtBukofTM.KiApIwdMX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bPTZjtBukofTM.KiApIwdMX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  include/linux/gfp.h

between commit:

  34973181c728 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/=
gfp.h>")

from the bitmap tree and commit:

  c2cda11cec4f ("mm: discard __GFP_ATOMIC")

from the mm tree.

I fixed it up (I used the former version of this file and then
applied the following merge resolution patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

=46rom 40347cfa3f5fe59fbf04be561c669f0dda06ea35 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Jul 2022 21:09:09 +1000
Subject: [PATCH] fix up for "headers/deps: mm: Split <linux/gfp_types.h> out
 of <linux/gfp.h>"

interacting with "mm: discard __GFP_ATOMIC"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/gfp_types.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index d88c46ca82e1..5088637fe5c2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -31,7 +31,7 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
 #define ___GFP_ZERO		0x100u
-#define ___GFP_ATOMIC		0x200u
+/* 0x200u unused */
 #define ___GFP_DIRECT_RECLAIM	0x400u
 #define ___GFP_KSWAPD_RECLAIM	0x800u
 #define ___GFP_WRITE		0x1000u
@@ -116,11 +116,8 @@ typedef unsigned int __bitwise gfp_t;
  *
  * %__GFP_HIGH indicates that the caller is high-priority and that granting
  * the request is necessary before the system can make forward progress.
- * For example, creating an IO context to clean pages.
- *
- * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
- * high priority. Users are typically interrupt handlers. This may be
- * used in conjunction with %__GFP_HIGH
+ * For example creating an IO context to clean pages and requests
+ * from atomic context.
  *
  * %__GFP_MEMALLOC allows access to all memory. This should only be used w=
hen
  * the caller guarantees the allocation will allow more memory to be freed
@@ -135,7 +132,6 @@ typedef unsigned int __bitwise gfp_t;
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency rese=
rves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
  */
-#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
 #define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
 #define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
 #define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
@@ -329,7 +325,7 @@ typedef unsigned int __bitwise gfp_t;
  * version does not attempt reclaim/compaction at all and is by default us=
ed
  * in page fault path, while the non-light is used by khugepaged.
  */
-#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
+#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
--=20
2.35.1



--=20
Cheers,
Stephen Rothwell

--Sig_/bPTZjtBukofTM.KiApIwdMX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRTAEACgkQAVBC80lX
0Gy49Af6A2F9dat4KXXGm3ecMouR8tOwjWvrlp47+EgVb8F0mXz9Y6uGHsIXqJ8V
kV9pQffJhdszurmNXV5940BmdZ+n/5T9RoasK+xb1G7CIGv8ESJ0TG1mF53Rna4d
ZwcS2KFskashx5YaCDKoXYsWdDOyq400jrg6nEfWmjSEVSjGxlxKYxJZXVun+YuG
SIyfD++RN64mlXGuhQBdZ5U3/Mvd+rgI7deAmysHjgSz/UhQuBgOZwC9ywvq5t4+
cD1cDu60Yb1/bmB/W+bLHJjDF6ICnl/5DUJSBXw7UfNaMJhuLCk4G5x8cUXc0g7f
bvmEo0rtivSuVdzHfdKWw6MAmn8XMA==
=Hm1y
-----END PGP SIGNATURE-----

--Sig_/bPTZjtBukofTM.KiApIwdMX--
