Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE519596633
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbiHQAAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiHQAAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:00:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524E92F52;
        Tue, 16 Aug 2022 17:00:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M6p6w0nC9z4x1N;
        Wed, 17 Aug 2022 10:00:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660694408;
        bh=o7nfJCUbCDgKqfrYEc24OxV82lJ1rSI15PYwGv+3BAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Ku3iI3GSn7/QgiAlR0Vnj75bbKpb+FbHu/nYWwJ2Mw01O/vE7QJNPqiOOT6KOS4J5
         G8j+zZPmoQ+a4SaGf5TS6Ty4NTzlMR3UbAngKBVu3GCB5wUv2se+v6us8e2wHjhyF8
         TKWf529mahGVOfTxdspjtp1BSFTJjPQl+CF6wyc0xuFveKKS9pxEOlLR6WBIKSk94v
         10LcoMoRuYPFipe84i3FEVwlQaXbCrDZuFstLAbDB7nr+PeKVJo7znUyQ3s7Wx7FXD
         Pjs/hJYgBqtfFpN44FHbJT6unVb7WwD/tnvSWxJr9EehBw/HbLpsSpW/wwhw/7qOle
         wm2LjVNvsXShA==
Date:   Wed, 17 Aug 2022 10:00:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>
Subject: linux-next: build failure after merge of the input tree
Message-ID: <20220817100007.2827652a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iZ5Mw3rLKR8TPHOWY2DaPOQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iZ5Mw3rLKR8TPHOWY2DaPOQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the input tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/input/misc/ibm-panel.c:195:19: error: initialization of 'void (*)(s=
truct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_cli=
ent *)' [-Werror=3Dincompatible-pointer-types]
  195 |         .remove =3D ibm_panel_remove,
      |                   ^~~~~~~~~~~~~~~~
drivers/input/misc/ibm-panel.c:195:19: note: (near initialization for 'ibm_=
panel_driver.remove')

Caused by commit

  95331e91e9da ("Input: Add IBM Operation Panel driver")

interacting with commit

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from v6.0-rc1.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Aug 2022 09:54:11 +1000
Subject: [PATCH] Input: fix up for "i2c: Make remove callback return void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/input/misc/ibm-panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-panel.c
index 54c657cd7809..094bcdb568f1 100644
--- a/drivers/input/misc/ibm-panel.c
+++ b/drivers/input/misc/ibm-panel.c
@@ -174,11 +174,9 @@ static int ibm_panel_probe(struct i2c_client *client,
 	return 0;
 }
=20
-static int ibm_panel_remove(struct i2c_client *client)
+static void ibm_panel_remove(struct i2c_client *client)
 {
 	i2c_slave_unregister(client);
-
-	return 0;
 }
=20
 static const struct of_device_id ibm_panel_match[] =3D {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/iZ5Mw3rLKR8TPHOWY2DaPOQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL8L4cACgkQAVBC80lX
0Gz+tQf/QcSV9ow+tD/z+OEozAvtm7HBkbXdWERWqXwOcVuQHObSXD1HvOsVBrBx
D5j6LY+AR0tBvNpBcWc3zTmz4ZtVOrf4vEdywNvsmVP8xTbGCftsPf9PRUhzem99
yNFF1PIw0aTdiBy8lfMcgccgKBVELWjOmPywssyY03GhzYaFwa2H37n0cxSyAto7
NpWfHV236+4tqIyu6Ft4jNHvzSUeBNvrqwYzfmG3aW7+AOUU8UqG90H056OFF2mL
Z8p3L60MUloZOYqKtcXVQ5Zkd5XwOkxUAKGBhfZHzdkt5ZSMTcGUu1cBdAE2nm3Y
7o5swplBma6zyPVvdFM9nw/a/rxqlA==
=uOxh
-----END PGP SIGNATURE-----

--Sig_/iZ5Mw3rLKR8TPHOWY2DaPOQ--
