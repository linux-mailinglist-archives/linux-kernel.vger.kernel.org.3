Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EA597F77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiHRHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiHRHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:45:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF514F190
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:45:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaDo-0000J2-AM; Thu, 18 Aug 2022 09:45:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaDm-000T5y-RS; Thu, 18 Aug 2022 09:45:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaDm-00CU0p-5z; Thu, 18 Aug 2022 09:45:42 +0200
Date:   Thu, 18 Aug 2022 09:45:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: meson: Simplify probe function with dev_err_probe()
Message-ID: <20220818074539.j6vrkj622hpg5n7y@pengutronix.de>
References: <20220818072234.9640-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fayku33dtf3ylbe"
Content-Disposition: inline
In-Reply-To: <20220818072234.9640-1-zhaoxiao@uniontech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fayku33dtf3ylbe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2022 at 03:22:34PM +0800, zhaoxiao wrote:
> Switch to dev_err_probe() to remove all dev_err() -> return repeated
> patterns, simplifying and shortening the probe function.
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/pwm/pwm-meson.c | 53 ++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 57112f438c6d..43ce8d9a33d2 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -126,20 +126,16 @@ static int meson_pwm_request(struct pwm_chip *chip,=
 struct pwm_device *pwm)
> =20
>  	if (channel->clk_parent) {
>  		err =3D clk_set_parent(channel->clk, channel->clk_parent);
> -		if (err < 0) {
> -			dev_err(dev, "failed to set parent %s for %s: %d\n",
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "failed to set parent %s for %s\n",
>  				__clk_get_name(channel->clk_parent),
> -				__clk_get_name(channel->clk), err);
> -			return err;
> -		}
> +				__clk_get_name(channel->clk));
>  	}
> =20
>  	err =3D clk_prepare_enable(channel->clk);
> -	if (err < 0) {
> -		dev_err(dev, "failed to enable clock %s: %d\n",
> -			__clk_get_name(channel->clk), err);
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to enable clock %s\n",
> +			__clk_get_name(channel->clk));

It's wrong to use dev_err_probe in .request(). The function is only
supposed to be used in the .probe() call.

>  	return 0;
>  }
> @@ -166,24 +162,18 @@ static int meson_pwm_calc(struct meson_pwm *meson, =
struct pwm_device *pwm,
>  		duty =3D period - duty;
> =20
>  	fin_freq =3D clk_get_rate(channel->clk);
> -	if (fin_freq =3D=3D 0) {
> -		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> -		return -EINVAL;
> -	}
> +	if (fin_freq =3D=3D 0)
> +		return dev_err_probe(meson->chip.dev, -EINVAL, "invalid source clock f=
requency\n");
> =20
>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
> =20
>  	pre_div =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> -	if (pre_div > MISC_CLK_DIV_MASK) {
> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
> -		return -EINVAL;
> -	}
> +	if (pre_div > MISC_CLK_DIV_MASK)
> +		return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get period p=
re_div\n");
> =20
>  	cnt =3D div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> -	if (cnt > 0xffff) {
> -		dev_err(meson->chip.dev, "unable to get period cnt\n");
> -		return -EINVAL;
> -	}
> +	if (cnt > 0xffff)
> +		return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get period c=
nt\n");
> =20
>  	dev_dbg(meson->chip.dev, "period=3D%u pre_div=3D%u cnt=3D%u\n", period,
>  		pre_div, cnt);
> @@ -200,10 +190,8 @@ static int meson_pwm_calc(struct meson_pwm *meson, s=
truct pwm_device *pwm,
>  		/* Then check is we can have the duty with the same pre_div */
>  		duty_cnt =3D div64_u64(fin_freq * (u64)duty,
>  				     NSEC_PER_SEC * (pre_div + 1));
> -		if (duty_cnt > 0xffff) {
> -			dev_err(meson->chip.dev, "unable to get duty cycle\n");
> -			return -EINVAL;
> -		}
> +		if (duty_cnt > 0xffff)
> +			return dev_err_probe(meson->chip.dev, -EINVAL, "unable to get duty cy=
cle\n");
> =20
>  		dev_dbg(meson->chip.dev, "duty=3D%u pre_div=3D%u duty_cnt=3D%u\n",
>  			duty, pre_div, duty_cnt);
> @@ -509,11 +497,8 @@ static int meson_pwm_init_channels(struct meson_pwm =
*meson)
>  		channel->mux.hw.init =3D &init;
> =20
>  		channel->clk =3D devm_clk_register(dev, &channel->mux.hw);
> -		if (IS_ERR(channel->clk)) {
> -			err =3D PTR_ERR(channel->clk);
> -			dev_err(dev, "failed to register %s: %d\n", name, err);
> -			return err;
> -		}
> +		if (IS_ERR(channel->clk))
> +			return dev_err_probe(dev, PTR_ERR(channel->clk), "failed to register =
%s\n", name);

This is the first conversion that is OK, as meson_pwm_init_channels() is
(only) called by meson_pwm_probe().

> =20
>  		snprintf(name, sizeof(name), "clkin%u", i);

Here follows another return that could benefit for a conversion to
dev_err_probe. Currently it only returns an error code and doesn't emit
a message, but a message would be good.

> @@ -550,10 +535,8 @@ static int meson_pwm_probe(struct platform_device *p=
dev)
>  		return err;
> =20
>  	err =3D devm_pwmchip_add(&pdev->dev, &meson->chip);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err, "failed to register PWM chip\n");
> =20
>  	return 0;
>  }

This hunk is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5fayku33dtf3ylbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL97iAACgkQwfwUeK3K
7Aloowf8DNE8Ty+jmb5ZdrGY5MKJET0h1cpJIMOw+WsplfWN4AMck2XDGapTwCUy
K93fyvtByX2AJxlcHtUELqO2pATd0m/oS4SIHIhSeKCyZ4MND+FxGURycAPkWeJb
HXXiZXHGQYcY6UjbWQRJiCW3fzKcFxHlOaqVCoTSJoHsGzXJuEURtPVSLr5mRCk2
bod5upR4BKqOrISOxFBy301qstUusEQGJ2KtbqtMJoax2iKb4mQ7DiSBzbj7diJc
DbebzC43HhOVM9Bxx8ODIYLQa9dNxhFAtvEWYW7DjDifruZy6N8eRH/3KYMpHx3N
nhPMf669dNoAPNrQkyQyZlRqEeEZZA==
=+YW5
-----END PGP SIGNATURE-----

--5fayku33dtf3ylbe--
