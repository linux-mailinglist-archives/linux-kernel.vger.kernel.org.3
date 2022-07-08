Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2756B5EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiGHJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiGHJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:44:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6B796A6;
        Fri,  8 Jul 2022 02:44:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfSzq2YbFz4xj2;
        Fri,  8 Jul 2022 19:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657273479;
        bh=dOThPvRv/B3YXUF/B31FdS2qXJrB/bxfQd3x43Yqbn4=;
        h=Date:From:To:Cc:Subject:From;
        b=QSwRgpgWE+eUCNkdJj7jeQlhUvSvqke8YhNF8hL6BfA+4Kqu1HN6DClvAbbLblMcN
         HL0nZM5o/jzKZ0LCyO7EGsSI+ZYwmOsdB7l0lPWbkV4mA5P0R6ZGGD+2vSVc7nnp/u
         //IBYr2aYEqLN6W7jpztkeshhFlaAInOJrDuTHkO36MX/Mvbeobe3+rkCM0KIFl3c3
         I3PxHQ8p39pl6R4VzzkjTYuCXuh1nVXML8ZMv2t/QZKr2oF8boMNXgUPqEryhdTVmp
         yGtc2fEJ0g8q6SzlyH2K2Ui46QB+XI+HbfsHfK3st0ZOD+9cHVHP2KeRyK2eQnsBC6
         HCNjvGAdD7ypA==
Date:   Fri, 8 Jul 2022 19:44:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>
Cc:     <linux-xfs@vger.kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220708194437.7eafe774@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2aJEc2Hu6P5l7_NRF=TJvZr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2aJEc2Hu6P5l7_NRF=TJvZr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

fs/xfs/xfs_notify_failure.c: In function 'xfs_dax_notify_ddev_failure':
fs/xfs/xfs_notify_failure.c:126:44: error: passing argument 1 of 'xfs_alloc=
_read_agf' from incompatible pointer type [-Werror=3Dincompatible-pointer-t=
ypes]
  126 |                 error =3D xfs_alloc_read_agf(mp, tp, agno, 0, &agf_=
bp);
      |                                            ^~
      |                                            |
      |                                            struct xfs_mount *
In file included from fs/xfs/xfs_notify_failure.c:12:
fs/xfs/libxfs/xfs_alloc.h:173:42: note: expected 'struct xfs_perag *' but a=
rgument is of type 'struct xfs_mount *'
  173 | int xfs_alloc_read_agf(struct xfs_perag *pag, struct xfs_trans *tp,=
 int flags,
      |                        ~~~~~~~~~~~~~~~~~~^~~
fs/xfs/xfs_notify_failure.c:126:25: error: too many arguments to function '=
xfs_alloc_read_agf'
  126 |                 error =3D xfs_alloc_read_agf(mp, tp, agno, 0, &agf_=
bp);
      |                         ^~~~~~~~~~~~~~~~~~
In file included from fs/xfs/xfs_notify_failure.c:12:
fs/xfs/libxfs/xfs_alloc.h:173:5: note: declared here
  173 | int xfs_alloc_read_agf(struct xfs_perag *pag, struct xfs_trans *tp,=
 int flags,
      |     ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  469a9c74c119 ("xfs: implement ->notify_failure() for XFS")

interacting with commit

  c4829aba9c8d ("xfs: pass perag to xfs_alloc_read_agf()")

from the xfs tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 Jul 2022 19:11:56 +1000
Subject: [PATCH] fix up for "xfs: pass perag to xfs_alloc_read_agf()"

interacting with "xfs: implement ->notify_failure() for XFS"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/xfs/xfs_notify_failure.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index aa8dc27c599c..f3c62c19475e 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -18,6 +18,7 @@
 #include "xfs_rmap_btree.h"
 #include "xfs_rtalloc.h"
 #include "xfs_trans.h"
+#include "xfs_ag.h"
=20
 #include <linux/mm.h>
 #include <linux/dax.h>
@@ -122,8 +123,10 @@ xfs_dax_notify_ddev_failure(
 		struct failure_info	notify;
 		struct xfs_agf		*agf;
 		xfs_agblock_t		agend;
+		struct xfs_perag	*pag;
=20
-		error =3D xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
+		pag =3D xfs_perag_get(mp, agno);
+		error =3D xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
 		if (error)
 			break;
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/2aJEc2Hu6P5l7_NRF=TJvZr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLH/IUACgkQAVBC80lX
0GzAwQf/QDQ41wvuFrkD+Cj1zDeDdse7zWLF1H+rIWgpT0Z6KK1f44T7Vv2tBkhW
l0ewa1BASdBZCz68xI6etd74uXQFNCqbs1lx4byHM+ek7wY3S7EtxPLkz58M2RYC
jfn9eUpDZ8mrBgJg09svExezX+0vMsDSYB76ayUuot6r6gSlHEVrdDzZXaz/kSZs
d0WqaCfJ5YqGjWryKQCisIo+Ju9vGylymP01jgu/8/NnhS26VhECc9RF8luENsLI
3xwbPjFGl52qLsfNe1W1SViiYNatcv2nD6pTTl/KpaiQqup6DrzugGD0yFTufFy9
1VgSfxY10mzAPv4l4us0prF1FZuS+A==
=iafo
-----END PGP SIGNATURE-----

--Sig_/2aJEc2Hu6P5l7_NRF=TJvZr--
