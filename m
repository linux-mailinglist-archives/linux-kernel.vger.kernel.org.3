Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0194B0A39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiBJKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiBJKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:04:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38595CF2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:04:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6Im-00011D-CV; Thu, 10 Feb 2022 11:03:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6Ii-00FgSL-CN; Thu, 10 Feb 2022 11:03:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6Ig-00EMKr-Tm; Thu, 10 Feb 2022 11:03:42 +0100
Date:   Thu, 10 Feb 2022 11:03:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Song Chen <chensong_2000@189.cn>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: introduce pwm_ops::apply
Message-ID: <20220210100342.q2t4ykgyymjzr3fj@pengutronix.de>
References: <1644483902-9200-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c2eicqlj24ajfowz"
Content-Disposition: inline
In-Reply-To: <1644483902-9200-1-git-send-email-chensong_2000@189.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2eicqlj24ajfowz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 05:05:02PM +0800, Song Chen wrote:
> Introduce apply in pwm_ops to replace legacy operations,
> like enable, disable, config and set_polarity.
>=20
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  drivers/staging/greybus/pwm.c | 46 +++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 891a6a672378..e1889cf979b2 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -204,43 +204,35 @@ static void gb_pwm_free(struct pwm_chip *chip, stru=
ct pwm_device *pwm)
>  	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>  }
> =20
> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			 int duty_ns, int period_ns)
> -{
> -	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> -
> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
> -};
> -
> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -			       enum pwm_polarity polarity)
> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			const struct pwm_state *state)
>  {
> +	int ret;
>  	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> =20
> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
> -};
> -
> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> +	/* set period and duty cycle*/
> +	ret =3D gb_pwm_config_operation(pwmc, pwm->hwpwm, state->duty_cycle, st=
ate->period);

gb_pwm_config_operation's 3rd parameter is an u32, so you're loosing
bits here as state->duty_cycle is a u64. Ditto for period.

Also it would be nice if you go from

	.duty_cycle =3D A, .period =3D B, .enabled =3D 1

to

	.duty_cycle =3D C, .period =3D D, .enabled =3D 0

that C/D wasn't visible on the output pin. So please disable earlier
(but keep enable at the end).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c2eicqlj24ajfowz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIE4vsACgkQwfwUeK3K
7AkEpgf+NdtDJKYavGime3N4rxugOTI4u9kbDL4z7GiAYjXWb3aqvB8ZsjirVc7i
o5Iyf7fCb0IP/4Vc2N6ndkRlBlr8FGcsgC7MlRq3T89Z5eJvpbAlWzIxFovJclmE
9TwGI0GHXH8It4I4p2hB0mtSwwyfuwB6vj+v8kEv+13niJA3MuIFaWWW5SayW0Ep
HF4ovCusOjE7Q3L7r8ebGNUoLz3Ku0u8EPoqc5/gnqUz9lmGrwpPB/rGJerJyLuq
RCDmQSB2+/ChdzV9Lb8adWrDv81fnxi7Va9wTwqFPXR/cAXkko9gGow/RioUL3g0
df5QN/eWXnu0TUW5XBEv2l3NvffGAw==
=MnRK
-----END PGP SIGNATURE-----

--c2eicqlj24ajfowz--
