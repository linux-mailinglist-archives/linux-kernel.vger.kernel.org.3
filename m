Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC158BA40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiHGIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiHGIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:34:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48ED101
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:34:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbk9-0000Qr-CE; Sun, 07 Aug 2022 10:34:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbk4-002G32-Pe; Sun, 07 Aug 2022 10:34:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbk6-00A6DT-67; Sun, 07 Aug 2022 10:34:38 +0200
Date:   Sun, 7 Aug 2022 10:34:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
Message-ID: <20220807083438.qqe3mzp43aytxbcl@pengutronix.de>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyr72olrnz2pj6sn"
Content-Disposition: inline
In-Reply-To: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyr72olrnz2pj6sn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Bartlomiej Zolnierkiewicz from Cc:, the address bounced in the
past]

at a quick glance this looks nice. I wonder if it makes sense to split
the patch. For example the change

-	ctx->pwm =3D devm_of_pwm_get(dev, dev->of_node, NULL);
+	ctx->pwm =3D devm_pwm_get(dev, NULL);

could stand alone. Also I think this change is the relevant part in
patch #1 that makes patches #2 and #3 possible.

When this patch doesn't get split, the series needs some coordination,
as patch #1 is for hwmon and patches #2 and #3 are for pwm.

Splitting the series into:

	hwmon: (pwm-fan) Use of devm_pwm_get() instead of devm_of_pwm_get()
	pwm: core: Get rid of unused devm_of_pwm_get()
	pwm: core: Make of_pwm_get() static

for pwm and the remainder of this patch for hwmon might make application
of the changes here easier to coordinate.

But still: Thanks for your effort and
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cyr72olrnz2pj6sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLveRsACgkQwfwUeK3K
7AlYvAf9Fs6FxfhGO/8+92dqWG12KLB3savGpw7vewwC23P4tEeDe47oGyush1I+
dtNJIS7tOxBRoAFOHGkhSXVTW6tT/lDpA41tzt7mZ8mQvBpbeFR4UM1YeSEDs+m8
o0x680woxrqdtqmwNvNyOa7ssUuxL0VpNVIOCXAoUsjKlFPEljvG/0hEofXpWoSa
BG5t68iIXjTcAC60DpqPE8ww9Gk5qD/BnMqp//nNS20r0EfPO/BBooeKvV8Du1XZ
PqM4TqPpwZk1GlKrMS9OIFlyNCbD/Qya8AJKAKmKqCMzARw+Sm+0aTsI8bkK6jC5
UJbLdfFNuY2z4iKJ13TUo3ewsMQ1Tg==
=/6F+
-----END PGP SIGNATURE-----

--cyr72olrnz2pj6sn--
