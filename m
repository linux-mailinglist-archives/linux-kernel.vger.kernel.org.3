Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA653078D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346967AbiEWCJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiEWCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:09:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAD133;
        Sun, 22 May 2022 19:09:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L613J3MSRz4xD2;
        Mon, 23 May 2022 12:09:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653271740;
        bh=CiEmx8nKzT8ta8NrvCP8vPpCku2ZXVt9I2OLm2rLFhU=;
        h=Date:From:To:Cc:Subject:From;
        b=ORr//P9BMTVEaZoyiEGqPzBl2ycHHp+39WWvAW5VJB0r+QRhNsVGpoUvIlJmqSfrd
         GuYN8gWyWZcMDOb+JJqaYbRaiF4LkRHonV5Fhd7X3bPXgAktrY8OudmtFE9fw2Kz5n
         YawthvBICs7RxPztfBbdQpiu4mkf2WtEE1TU94USB+sEIcIJ+hOXDUh0Vdt/2QElRm
         VpEnwHBbh+qjow1kc7Ra/hoXbUbranmeyrnaYvlswMJt5vLfxsDR7TPZPOm885yCFa
         PIoVKQkt993cefYxhVxHszDdHWoI6kKjzTeoZ+xE9CZY1lnsG8fdPyDCe2+etgfo24
         G49RuamZNypSQ==
Date:   Mon, 23 May 2022 12:08:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the modules tree with the kbuild tree
Message-ID: <20220523120859.570f7367@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fUSNPwCOFP=/1zJS5F602bs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fUSNPwCOFP=/1zJS5F602bs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  kernel/module/main.c

between commit:

  98d8a9b5e17d ("kbuild: link symbol CRCs at final link, removing CONFIG_MO=
DULE_REL_CRCS")

from the kbuild tree and commit:

  47889798da43 ("module: Move version support into a separate file")

from the modules tree.

I fixed it up (I used the latter version of this file and applied the
following patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 23 May 2022 12:04:00 +1000
Subject: [PATCH] fix up for "module: Move version support into a separate f=
ile"

interacting with "kbuild: link symbol CRCs at final link, removing CONFIG_M=
ODULE_REL_CRCS"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/module/version.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/module/version.c b/kernel/module/version.c
index adaedce1dc97..53f43ac5a73e 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -10,11 +10,6 @@
 #include <linux/printk.h>
 #include "internal.h"
=20
-static u32 resolve_rel_crc(const s32 *crc)
-{
-	return *(u32 *)((void *)crc + *crc);
-}
-
 int check_version(const struct load_info *info,
 		  const char *symname,
 			 struct module *mod,
@@ -43,10 +38,7 @@ int check_version(const struct load_info *info,
 		if (strcmp(versions[i].name, symname) !=3D 0)
 			continue;
=20
-		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
-			crcval =3D resolve_rel_crc(crc);
-		else
-			crcval =3D *crc;
+		crcval =3D *crc;
 		if (versions[i].crc =3D=3D crcval)
 			return 1;
 		pr_debug("Found checksum %X vs module %lX\n",
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/fUSNPwCOFP=/1zJS5F602bs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKK7LsACgkQAVBC80lX
0Gyx0Af/fZY/KsMdvqBxxNuoD7svOb9AOHMsQLxnqeetS2vBxrCEX1AZTVHZlxng
vFxG/HzynshlBFY3QFZOok3ohf51Y0eHUtKbZxJDu/ATfB99HPu5mY7ipqZo9EJ/
VSCCfhTk1qJNcuzwQpipE0QsJHEb9qRigK4H6sIiadZfxHBihLZMsrWaEPxzt/2K
TbeCMmQ7l1NyNgFrdOK+/hLguzgPVUAvEFWpV+vTKnLzxXjCU+1wdd3/XW+hr56V
79wO7+zLumbdFbc5MLkZsW+6cWcLJ8kIkzLCWfIpKY97QpI4Q+WPqtPDIIiAOYqq
oAsI2xmUMxdxYlzPGw8cLlBZDya5Jw==
=PgPn
-----END PGP SIGNATURE-----

--Sig_/fUSNPwCOFP=/1zJS5F602bs--
