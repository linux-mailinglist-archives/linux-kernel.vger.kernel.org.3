Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCF519582
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiEDCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiEDCjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:39:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11117A99;
        Tue,  3 May 2022 19:35:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtLXc5BZWz4xR1;
        Wed,  4 May 2022 12:35:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651631728;
        bh=XpFSs3KZ/F/CYqhArlyJEAcGaiDhgsZ9RU2Sk+s5tHE=;
        h=Date:From:To:Cc:Subject:From;
        b=X86FtbT/F5+nqtIZnrsh3J2sTc4MDTt5ktJcqbVZiFk0pO8dCeo0s/KgdeUHM5tpG
         gp1PzCmHEjNxdt7R7jJ0j/xPtz5219yPtounJZvIEaugTIqIlasCqRUXQgYqZ3xWA+
         Tm25OJZnDnzZ+Tcs/fl8IipgZc7+Eb9Gfiln//+t/GHeWvjpN6IK3yuiekH6vdFAL9
         blUh/F202ImJOXWvs0hHGCMop5Y9Msndzoa1ygXqK8zw9PDrv7rF/1S6X2szsrelDe
         eODI0uI+LnIU4/X0Kuiuqqv0XVzUxOcJYeHBMiBicXZQiO2l7oclxWyKhNNewOdaRu
         9Hx8b/Cv5fdxg==
Date:   Wed, 4 May 2022 12:35:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the battery tree
Message-ID: <20220504123527.537c9b3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_96lf0jbh_3j8FNN7WT+lIF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_96lf0jbh_3j8FNN7WT+lIF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the battery tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/power/supply/bq27xxx_battery.c: In function 'bq27xxx_battery_update=
':
drivers/power/supply/bq27xxx_battery.c:1767:14: error: unused variable 'has=
_ci_flag' [-Werror=3Dunused-variable]
 1767 |         bool has_ci_flag =3D di->opts & BQ27XXX_O_HAS_CI;
      |              ^~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  698502318f51 ("power: supply: bq27xxx: expose battery data when CI=3D1")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 4 May 2022 12:31:47 +1000
Subject: [PATCH] power: supply: bq27xxx: remove unused variable

Fixes: 698502318f51 ("power: supply: bq27xxx: expose battery data when CI=
=3D1")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/power/supply/bq27xxx_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 9adc7f43bbfd..35e6a394c0df 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1764,7 +1764,6 @@ static int bq27xxx_battery_read_health(struct bq27xxx=
_device_info *di)
 void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache =3D {0, };
-	bool has_ci_flag =3D di->opts & BQ27XXX_O_HAS_CI;
 	bool has_singe_flag =3D di->opts & BQ27XXX_O_ZERO;
=20
 	cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/_96lf0jbh_3j8FNN7WT+lIF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJx5m8ACgkQAVBC80lX
0Gx1JAf9Gwm/lhHOJODRfVOKbmn7JpnXJ9z26p2AHbNgtYazXUYTZGQqWRi/TgAa
VCX6Xo+xgUITeo5hFpmBP4KG/REq/xKjRsJtLOzdgdmndt3y4XpNF297Nedy2PoG
Mm+RCxEynP14pVCOBU0gVvz9wXvqfjlHtrS1XGO+u5nDPDh+CP18RssW1gaav1Fr
d40Qofc5nlXjLIsX3bBF/Vbzqo5fsn+EcpWEIg7sH5yxSau4bXOC1TTBcEAN6H1s
uzIGr855g+90hQB1XUjIY/iE7T5TE0b/cSlqs1egBCEQ7Dos4FQUueDBawPaVR3/
Y/IGx3A/moxVCg8v/Vry7ZaU2qNrOw==
=hNhw
-----END PGP SIGNATURE-----

--Sig_/_96lf0jbh_3j8FNN7WT+lIF--
