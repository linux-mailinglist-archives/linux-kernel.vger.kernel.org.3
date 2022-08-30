Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39F5A71CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH3XaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiH3XaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:30:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781191D30D;
        Tue, 30 Aug 2022 16:30:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHNnv6hmPz4x2c;
        Wed, 31 Aug 2022 09:30:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661902213;
        bh=nZiFcBzoPRPqOBAcboAXaZBiFUhEoLtntesBmzKEALE=;
        h=Date:From:To:Cc:Subject:From;
        b=qfDt+aknN3UqbRDGKzIG+IAx62iR6uyl+D4BfaWy9cUtj1m3uEbSJ2hVGniBeMa1C
         q9FbdF8cZ7KNwGLxIkeBAfnWHuZd7eAIq6LRuUYki5S3JaX0zYmX1vo4shjERCnZJO
         cQrLaUSU1GfJIVws9xN6T5TkgdrKdalkCX12hvCIcqUDpHM4RfILNUmxb+r2b2lyoV
         8jo/rn+sLc2fhPYhwT2jemy4KNrc7T5NE4FLB53bqwKoFkl8VMbIQMjdZmMalKqArO
         cOOaCBKSHHhXBrDzTX0cDQMdCRev3RF8OtA2iFUW+hs9cl6EQWZ5zxPxAujTwZNSjd
         9U6PkG+3ldwMg==
Date:   Wed, 31 Aug 2022 09:30:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20220831093010.10ce62a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BtptTS27sYo9AeOKZ/Kd146";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BtptTS27sYo9AeOKZ/Kd146
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/emc2305.c:615:21: error: initialization of 'void (*)(struct i=
2c_client *)' from incompatible pointer type 'int (*)(struct i2c_client *)'=
 [-Werror=3Dincompatible-pointer-types]
  615 |         .remove   =3D emc2305_remove,
      |                     ^~~~~~~~~~~~~~
drivers/hwmon/emc2305.c:615:21: note: (near initialization for 'emc2305_dri=
ver.remove')

Caused by commit

  324745b64626 ("hwmon: (emc2305) add support for EMC2301/2/3/5 RPM-based P=
WM Fan Speed Controller.")

interacting with commit

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree.

=46rom Uwe:

> There is an immutable tag that can be merged into your tree to
> resolve the conflict before you send your changes to Linux at
>
>	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_re=
move_callback_void-immutable

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 Aug 2022 09:22:50 +1000
Subject: [PATCH] hwmon: (emc2305) fix up for "i2c: Make remove callback ret=
urn void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/emc2305.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 9f6546ea3d69..df4c5816f661 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -597,13 +597,12 @@ static int emc2305_probe(struct i2c_client *client, c=
onst struct i2c_device_id *
 	return 0;
 }
=20
-static int emc2305_remove(struct i2c_client *client)
+static void emc2305_remove(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
=20
 	if (IS_REACHABLE(CONFIG_THERMAL))
 		emc2305_unset_tz(dev);
-	return 0;
 }
=20
 static struct i2c_driver emc2305_driver =3D {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/BtptTS27sYo9AeOKZ/Kd146
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOnYIACgkQAVBC80lX
0Gya/wf+I9HGI2aPUPInGxvaOl9UpIvgFhsYk+yvE6tQ4ZdnLzXVAMeMnrSn6hcp
+WYk33Uvj/+9W01MLXm8XdvMlrITXr0vQ6jscNYGi+lUdpw9uSIEp+xL1uZT7Y9a
rjiAqDGAI+h+WP9mPT+q0MmNIGcPMIv0ccggByuAYuZ7KxnggYh0wnQtxaN3bJ79
uAzUV5U10yN208mFqgbHcN8nuE3txL8tiOBs/DSXgqGTMpRP9vXAxixeR2vy0g8r
B6G0TOo3CKpa+p/r1jTn6JP2kyNHVPDNK3sY9czMWMh79DZSleUjKE1znLa/ZfE+
+ILgYt+LoyUU0J5Js157YpC7WAk7FA==
=j+va
-----END PGP SIGNATURE-----

--Sig_/BtptTS27sYo9AeOKZ/Kd146--
