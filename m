Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573CE564E76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiGDHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:13:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D125C8;
        Mon,  4 Jul 2022 00:13:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LbxqD1Gm7z4xYD;
        Mon,  4 Jul 2022 17:13:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656918808;
        bh=rNMV18RoA02WXR6CDlIMsxUHFLans2UslU2k8yRD6Hk=;
        h=Date:From:To:Cc:Subject:From;
        b=nvBcU36SSL241AGmC5Y3FSH9vyKyKN97VD315eo+WkOfk9DVR+maCSlwzdhAchfPs
         eEQAlaskk4nvmU5IBn77NCXRTZzNipSs/MVXenzDZ3OFf9BeOr49QcTBs5WJncHZ0t
         wvWFEp4xSvLMhw01bu4OETkK1rb1c12m/rwcBRnkbRJCYvuWdsJ+64y+tX5iEwfq87
         cwLK2OhAPmvOckiE9sa+pzPdnjOfXjcwIxCh6r0QQAPCWc77xIPMCd0EYp2Qd6dwaC
         z/xMBvsQd7ck4lxQbxlA45TOX3wjaShZlb9d3JpBnn/qZ4oKhqGxmYE4Kgk/bRThAW
         xjRmagF/Es4Bw==
Date:   Mon, 4 Jul 2022 17:13:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the mm tree with the bitmap tree
Message-ID: <20220704171326.59870c5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lqi/Pl8BxwDD7lgXDN=eNXz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lqi/Pl8BxwDD7lgXDN=eNXz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  include/linux/gfp.h

between commit:

  db0e627fee42 ("mm: split include/linux/gfp.h")

from the bitmap tree and commit:

  199520d04b35 ("mm: discard __GFP_ATOMIC")

from the mm tree.

I fixed it up (I used the former version of this files and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 4 Jul 2022 17:09:47 +1000
Subject: [PATCH] fix up for "mm: split include/linux/gfp.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/gfp_flags.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp_flags.h b/include/linux/gfp_flags.h
index 846cc8151340..6338c093cc38 100644
--- a/include/linux/gfp_flags.h
+++ b/include/linux/gfp_flags.h
@@ -17,7 +17,7 @@
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
 #define ___GFP_ZERO		0x100u
-#define ___GFP_ATOMIC		0x200u
+/* 0x200u unused */
 #define ___GFP_DIRECT_RECLAIM	0x400u
 #define ___GFP_KSWAPD_RECLAIM	0x800u
 #define ___GFP_WRITE		0x1000u
@@ -102,11 +102,8 @@
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
@@ -121,7 +118,6 @@
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency rese=
rves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
  */
-#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
 #define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
 #define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
 #define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
@@ -315,7 +311,7 @@
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

--Sig_/lqi/Pl8BxwDD7lgXDN=eNXz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLCkxYACgkQAVBC80lX
0GzTfAf+KZixKNgf8pfjeWra/3pJGOeOoXVTe0jism8vy2Q4re/i23Pj3j+RZvwQ
qr0bgCg9IglAGP6LCGs/ONPUPWUevdNWzWYuIwtcIZUdpX61ucmf1UNK3+US0tmO
B1Tmwu1+SfN53QCMCuphJjau+E999zwK12RvqwCWfdFyAYHQG4amAZzT//v1Cmbs
Ihwmg+3LNYa3ZFtyzl6bL+hUlvZsTro5OYunsTw+fzGprePoEUs2gm28wbgpKmD0
5bvyQS6Ta4FR1iUQ+X63pZtDE9uCbHs9TNQYvwWaMEQ9FlYcwnux1nfjZ+vglDU3
snbYmdMxVUb+Ier1qZNCaLNY6NHAMg==
=UjSv
-----END PGP SIGNATURE-----

--Sig_/lqi/Pl8BxwDD7lgXDN=eNXz--
