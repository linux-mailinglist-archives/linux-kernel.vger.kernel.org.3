Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D085A204C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiHZF06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:26:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30122A6C6C;
        Thu, 25 Aug 2022 22:26:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDSxl4tL1z4wgv;
        Fri, 26 Aug 2022 15:26:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661491613;
        bh=6fcG9onYyD/Nbqd1jqnGyknew1f2WvEwaGM1fgFYeW8=;
        h=Date:From:To:Cc:Subject:From;
        b=TTgmdJAamCSPtPeFQAdhHqHYH8UcAaDNXo8lejbtHTo2RTAeDUPgcnrY0CYcj5cBh
         AmRg/wu601NbjIuamd8Ql0iuqTS77ykdBNrVFzVR0uV355QELJlNMpBf5SQ3xs/7sN
         VZVBrJr8ceamH8IqGExLAA82Lk3mQEF5ujElT0YThZhFzO7mPQ+5XbgP9JvGUan5oN
         49VqFQCM5V/R3O6O9oCSbV0I8340KgJf2MdkmUMrCAenZVjfTZCATvpBwWVK36aZnv
         Zx452KOvMp6ud+fMczfXzEfsadZPWLSKIJFDoXeH2n3NHajVk9ihpgRwV+Ls06jypn
         /kqqvTcGIch/Q==
Date:   Fri, 26 Aug 2022 15:26:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20220826152650.2c55e482@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pt.EyoV_KiVpO//lk/pLu.E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pt.EyoV_KiVpO//lk/pLu.E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pinctrl/pinctrl-cy8c95x0.c:1371:27: error: initialization of 'void =
(*)(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2=
c_client *)' [-Werror=3Dincompatible-pointer-types]
 1371 |         .remove         =3D cy8c95x0_remove,
      |                           ^~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-cy8c95x0.c:1371:27: note: (near initialization for =
'cy8c95x0_driver.remove')

Caused by commit

  e6cbbe42944d ("pinctrl: Add Cypress cy8c95x0 support")

interacting with commit

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 26 Aug 2022 15:20:29 +1000
Subject: [PATCH] pinctrl: fixup for "i2c: Make remove callback return void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-c=
y8c95x0.c
index a29df0920f4f..05791212822e 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1352,14 +1352,12 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	return ret;
 }
=20
-static int cy8c95x0_remove(struct i2c_client *client)
+static void cy8c95x0_remove(struct i2c_client *client)
 {
 	struct cy8c95x0_pinctrl *chip =3D i2c_get_clientdata(client);
=20
 	if (!IS_ERR_OR_NULL(chip->regulator))
 		regulator_disable(chip->regulator);
-
-	return 0;
 }
=20
 static struct i2c_driver cy8c95x0_driver =3D {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Pt.EyoV_KiVpO//lk/pLu.E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIWZoACgkQAVBC80lX
0GwyoQf+K3lskLtGcSNNWW/fgt95/GEUcAe2L9+WXziZvSey4Dqb3fSgaqQWbUS+
t9IrQ2ZF3POCdycx9Op43EEcCGDj59v5IWOgXV03NfClztoRkqVUIZ9X7Xvyh3Hl
dX68zlbAurHPmsROF4BCLKFmyo7YzrKGhavoKAtApu8H5DcRvuq8HN4crzhqQB3o
GVM9xTGcgRzhO+ZP7yJ+8VEWJLKjNfQnVjJrEazy58EBiNwvawUBGcikferuIcWb
LZzWGbXX4UxwcWQSiI+60V9cyo8+4yAGQaCxEW6ldaHhUsawiu1CB9dTYsUtjn/2
z7ZdDF3GQ2ikOuJf0D0wfOoXLVzSCA==
=Kel7
-----END PGP SIGNATURE-----

--Sig_/Pt.EyoV_KiVpO//lk/pLu.E--
