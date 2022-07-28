Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DA583C93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiG1Kzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiG1Kzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:55:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8414D37;
        Thu, 28 Jul 2022 03:55:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ltncd3Slrz4x1G;
        Thu, 28 Jul 2022 20:55:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659005745;
        bh=muYu5kZoW0xItd8KHdU3znK265ixoqRAZvzqYkR7v9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=X4xwE7y6aYt/cW6r3ZqeuaoxE8gcRrgBDPjoyh9hmGDWwzz+PtLCXnP3bgt8lu8Nt
         T5BPAa3JT15rz5VCtiiSmULxcU8/pSE3tX7o8N6yQ5EMGlNMulYwJ6cYlWSssvXMNu
         I1Kgtgm2HnWaOVpCsiSXGb7FI9uTd1JWERH/nCzFD1Dcj4w/C4ve18P2I1/tqWBc98
         SRLEyheY3jU8gSFozlQTDWexzPggvWyjvFHB/WBLZ8MZOJsO7pSuCYTR8upmq8k9UO
         c7eZoVYABPyPw0c9P6nKQsHZSE8aU9edYJoLd0xJnv9oswqC34pJd1HBXOqvpSnRpk
         Vz7/I8LWZMYQw==
Date:   Thu, 28 Jul 2022 20:55:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220728205404.645f7c12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PYm+ZwgZa.DoU7fyI=lOJl5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PYm+ZwgZa.DoU7fyI=lOJl5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/md/dm-verity-loadpin.c: In function 'dm_verity_loadpin_is_bdev_trus=
ted':
drivers/md/dm-verity-loadpin.c:61:13: error: implicit declaration of functi=
on 'dm_table_get_num_targets'; did you mean 'dm_table_resume_targets'? [-We=
rror=3Dimplicit-function-declaration]
   61 |         if (dm_table_get_num_targets(table) !=3D 1)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
      |             dm_table_resume_targets
drivers/md/dm-verity-loadpin.c:64:14: error: implicit declaration of functi=
on 'dm_table_get_target'; did you mean 'dm_table_add_target'? [-Werror=3Dim=
plicit-function-declaration]
   64 |         ti =3D dm_table_get_target(table, 0);
      |              ^~~~~~~~~~~~~~~~~~~
      |              dm_table_add_target
drivers/md/dm-verity-loadpin.c:64:12: error: assignment to 'struct dm_targe=
t *' from 'int' makes pointer from integer without a cast [-Werror=3Dint-co=
nversion]
   64 |         ti =3D dm_table_get_target(table, 0);
      |            ^

Caused by commit

  b6c1c5745ccc ("dm: Add verity helpers for LoadPin")

interacting with commits

  2aec377a2925 ("dm table: remove dm_table_get_num_targets() wrapper")
  564b5c5476cd ("dm table: audit all dm_table_get_target() callers")

from the device-mapper tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Jul 2022 20:28:41 +1000
Subject: [PATCH] fix up for "dm: Add verity helpers for LoadPin"

interacting with

  2aec377a2925 ("dm table: remove dm_table_get_num_targets() wrapper")
  564b5c5476cd ("dm table: audit all dm_table_get_target() callers")

from the device-mapper tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/md/dm-verity-loadpin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 10c18bc1652c..387ec43aef72 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -5,6 +5,7 @@
 #include <linux/dm-verity-loadpin.h>
=20
 #include "dm.h"
+#include "dm-core.h"
 #include "dm-verity.h"
=20
 #define DM_MSG_PREFIX	"verity-loadpin"
@@ -58,7 +59,7 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_devic=
e *bdev)
=20
 	table =3D dm_get_live_table(md, &srcu_idx);
=20
-	if (dm_table_get_num_targets(table) !=3D 1)
+	if (table->num_targets !=3D 1)
 		goto out;
=20
 	ti =3D dm_table_get_target(table, 0);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/PYm+ZwgZa.DoU7fyI=lOJl5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLiay8ACgkQAVBC80lX
0GwAfgf+Iu9REq677ofzIbNSNd8XqQNeXDlYKfJ7XDofS//QGl/rpw2bK8cPQb/m
qixESTKOXF9aJ0E+7vC3ZmujyFQazp/d+N28vlBYt/K2ZV324UuA6bdTYbdNtJw7
vvcLgYbVxPZ5IGB1zIjPldyjFeDCZWobUZ+HqarJXNR8YwjF59nikD82ZKL+k0gB
VzR7bpELc4Tf2n1yeENwfop+SP/KCxG9lt7u/wTptT632bI+g8dHIFoAQMX5nHcT
OaBOMkjFpNc1rDjj8+fw4jne1xEF2gPj4apeLlly0JzsAtmz4dqZb0SHr7k6wVw1
irwNlsh7dJ5MB6OSfkyoVDYyCqpH4w==
=oOz8
-----END PGP SIGNATURE-----

--Sig_/PYm+ZwgZa.DoU7fyI=lOJl5--
