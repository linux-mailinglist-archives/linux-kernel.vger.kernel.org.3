Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFCF46FC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhLJHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhLJHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:49:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C105C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 23:46:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvabM-0003H5-Aw; Fri, 10 Dec 2021 08:45:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvabL-003jMu-Is; Fri, 10 Dec 2021 08:45:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvabK-0002Np-GS; Fri, 10 Dec 2021 08:45:54 +0100
Date:   Fri, 10 Dec 2021 08:45:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: remove redundant initialization of variable
 timeout
Message-ID: <20211210074536.lawpsch2i5bwyew7@pengutronix.de>
References: <20211210002250.639251-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5yndpvfpnnutbpm"
Content-Disposition: inline
In-Reply-To: <20211210002250.639251-1-colin.i.king@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g5yndpvfpnnutbpm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 12:22:50AM +0000, Colin Ian King wrote:
> The variable timeout is being initialized with a value that is never
> read, it is being re-assigned the same value later on. Remove the
> redundant initialization and keep the latter assignment because it's
> closer to the use of the variable.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 98b34ea9f38e..8e00a4286145 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -271,7 +271,7 @@ static void atmel_pwm_disable(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  			      bool disable_clk)
>  {
>  	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
> -	unsigned long timeout =3D jiffies + 2 * HZ;
> +	unsigned long timeout;
> =20
>  	atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Did you spot this by using some static checker? If so, maybe attribute
it in the commit log?

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g5yndpvfpnnutbpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGzBZgACgkQwfwUeK3K
7Ancbwf/Y9NIGfzWvo0izlxUFno6IppPuEmbAsX1KzxbrjwHYR4EPTMvTKZ9uO51
839xuKr0RrXJ9U6mEns0tdc3AJ9YyFtTvz7eeRJKoTCtOAtJAxunOcAfzG1NY8ad
6g2T+//11dbuaYWI+lZSNep2+ZYmN5tj2wkfo/ujMOWWHFEbjOw4OyvItvCzJNiw
GTuuDrDewi+l/hzz9FBxROc7p4Tb6MZ51CvthADMR6z6tpeTyX0A7IOdtXWyMPTe
1C2JGwEq4cE3u9Wg9ANNMgMdfzcPywdGwkz1cO9qf8r8sA/Sm53F4RLTx9C98E+l
FbHjlJdKGtehZ9AJRaur6Kbd/gYtFA==
=kDwy
-----END PGP SIGNATURE-----

--g5yndpvfpnnutbpm--
