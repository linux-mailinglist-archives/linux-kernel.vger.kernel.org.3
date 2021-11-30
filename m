Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FCE462D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhK3G7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhK3G7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:59:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46920C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:55:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx3G-0007hK-U1; Tue, 30 Nov 2021 07:55:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx31-001sG0-MU; Tue, 30 Nov 2021 07:55:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx30-0002GI-Oi; Tue, 30 Nov 2021 07:55:26 +0100
Date:   Tue, 30 Nov 2021 07:55:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     b.zolnierkie@samsung.com, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH] hwmon: (pwm-fan) Let ctx->pwm_value be assigned only in
 __set_pwm
Message-ID: <20211130065526.jqm7ix62y6om7ovw@pengutronix.de>
References: <20211130030046.3920-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kzo772oogs6uy5np"
Content-Disposition: inline
In-Reply-To: <20211130030046.3920-1-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzo772oogs6uy5np
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 30, 2021 at 11:00:46AM +0800, Billy Tsai wrote:
> This patch is used to fix the bug when pwm_fan_probe the pwm_value will
> be out of sync with the PWM hardware drivers.
>=20
> Fixes: 86585c61972f ("hwmon: (pwm-fan) stop using legacy PWM functions an=
d some cleanups")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/hwmon/pwm-fan.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 17518b4cab1b..f12b9a28a232 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -336,8 +336,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			return ret;
>  	}
> =20
> -	ctx->pwm_value =3D MAX_PWM;
> -
>  	pwm_init_state(ctx->pwm, &ctx->pwm_state);

Ah, I see. The effect is that the FAN is supposed to be running at full
speed after probe, but this isn't asserted.

So the patch is fine, but I suggest to make the commit log a bit more
frightening. Something like:

	hwmon: (pwm-fan) Ensure the fan going on in .probe()
=09
	Before commit 86585c61972f ("hwmon: (pwm-fan) stop using legacy
	PWM functions and some cleanups") pwm_apply_state() was called
	unconditionally in pwm_fan_probe(). In this commit this direct
	call was replaced by a call to __set_pwm(ct, MAX_PWM) which
	however is a noop if ctx->pwm_value already matches the value to
	set.

	After probe the fan is supposed to run at full speed, and the
	internal driver state suggests it does, but this isn't asserted
	and depending on bootloader and pwm low-level driver, the fan
	might just be off.

	So drop setting pwm_value to MAXX_PWM to ensure the check in
	__set_pwm doesn't make it exit early and the fan goes on as
	intended.

	Cc: stable@vger.kernel.org
	Fixes: 86585c61972f ("hwmon: (pwm-fan) stop using legacy PWM functions and=
 some cleanups")

Best regards and thanks for cleaning up after me,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kzo772oogs6uy5np
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGlytsACgkQwfwUeK3K
7AmbfQf/ULb5MZ07B1LqrI7BhZdH5LEjc3kawWoyUenFHh8NdmDFtHJpINKiHr1I
9mrhZYZV4KoL4lY7v+G1wjD0cigsGzJjT2Lw8TvJSaHc1OuXoe6frZY4cmdY5eVK
bOmiS4RFzorfbRs1+QE93Ud7z99WZMRDbPES8oy4JKueOvdfuxPKqji8jOUwEbRU
6fM5WKxcOqbIsywfAfSFg0XvOv7SYaXmmt0WfEFph/iz3PxalRkPrOGWIv9ghz99
w9A5AmAEZEeR9HXKl72BSD+az1tfeIod4CfjkJa8z3nZWYAA1IghovJSqqJwiF6Q
w1oE747LakNbAZ2Vd7jbsD6robGk+A==
=4lfg
-----END PGP SIGNATURE-----

--kzo772oogs6uy5np--
