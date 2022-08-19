Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C9599765
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbiHSIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHSIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:22:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DBD86714
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:22:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOxH8-0004of-3W; Fri, 19 Aug 2022 10:22:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOxH5-000g1u-IS; Fri, 19 Aug 2022 10:22:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOxH4-00Chdh-N7; Fri, 19 Aug 2022 10:22:38 +0200
Date:   Fri, 19 Aug 2022 10:22:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     thierry.reding@gmail.com, heiko@sntech.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: rockchip: Convert to use dev_err_probe()
Message-ID: <20220819082235.ygyw3spkbpookzyy@pengutronix.de>
References: <20220819070756.14895-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ashbpe5mzbtgjqm"
Content-Disposition: inline
In-Reply-To: <20220819070756.14895-1-zhaoxiao@uniontech.com>
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


--2ashbpe5mzbtgjqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 03:07:56PM +0800, zhaoxiao wrote:
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  v3: 1.There is no need to assign it to 'ret', and use PTR_ERR(pc->pclk) =
directly.
>      2.add the return before dev_err_probe().
>  drivers/pwm/pwm-rockchip.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f3647b317152..eda1bd49d260 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -328,18 +328,12 @@ static int rockchip_pwm_probe(struct platform_devic=
e *pdev)
>  	else
>  		pc->pclk =3D pc->clk;
> =20
> -	if (IS_ERR(pc->pclk)) {
> -		ret =3D PTR_ERR(pc->pclk);
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(pc->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pc->pclk), "Can't get APB clk=
\n");
> =20
>  	ret =3D clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n"=
);
> =20
>  	ret =3D clk_prepare_enable(pc->pclk);
>  	if (ret) {

Still missing two dev_err() that are unconverted ...

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ashbpe5mzbtgjqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL/SEgACgkQwfwUeK3K
7AmYCAf+JNAnIXa6WEgqFlr9kJ6eRLkB5TuFo0vd5ix980QQR+G0ouBvA6+aiEyP
vagnbM2Ln+ld6ZJGCqgAKwbQcjXTB5x2QZ7r0m4lDetPJKXyHbp5wG0OxAgubbrt
tA1u1h6gV98fN5nQhJ21AmP27ysF8zAr50aK7oq0T+6T0AKTDzT0cjeZTdFbX2zb
td/aTKo9RZ9CotP9OXpXPuQV2z/wvsmnqzSwhAG1oyqPq6hDU2BcMGbZdx6fOzTm
Tlist939BIzup5wRGA1rFceLYb3A4esTq0/TrnGYiwWXxk3E33eWJw/GQYlQ/DgQ
eudXywcnEeJJ321bqFFVKwIPxImj8A==
=eUfy
-----END PGP SIGNATURE-----

--2ashbpe5mzbtgjqm--
