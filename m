Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6562C58B505
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiHFKXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:22:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413A13D58
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 03:22:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGxJ-0002Wp-Ve; Sat, 06 Aug 2022 12:22:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGxF-0024dX-NW; Sat, 06 Aug 2022 12:22:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGxH-009uYH-Br; Sat, 06 Aug 2022 12:22:51 +0200
Date:   Sat, 6 Aug 2022 12:22:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH 8/8] pwm: dwc: add PWM bit unset in get_state call
Message-ID: <20220806102248.66htxhfia4irpx5t@pengutronix.de>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-9-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5pk4sbymvf2ijox"
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-9-ben.dooks@sifive.com>
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


--u5pk4sbymvf2ijox
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 05, 2022 at 05:50:33PM +0100, Ben Dooks wrote:
> If we are not in PWM mode, then the output is technically a 50%
> output based on a single timer instead of the high-low based on
> the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
> and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.
>=20
> This may only be an issue on initialisation, as the rest of the
> code currently assumes we're always going to have the extended
> PWM mode using two counters.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/pwm/pwm-dwc.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 5edfb8f8acbf..49e666be7afd 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -171,23 +171,35 @@ static void dwc_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  {
>  	struct dwc_pwm *dwc =3D to_dwc_pwm(chip);
>  	u64 duty, period;
> +	u32 ctrl, ld, ld2;
> =20
>  	pm_runtime_get_sync(chip->dev);
> =20
> -	state->enabled =3D !!(dwc_pwm_readl(dwc,
> -				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
> +	ctrl =3D dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
> +	ld =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
> +	ld2 =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
> =20
> -	duty =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
> -	duty +=3D 1;
> -	duty *=3D dwc->clk_ns;
> -	state->duty_cycle =3D duty;
> +	state->enabled =3D !!(ctrl & DWC_TIM_CTRL_EN);
> =20
> -	period =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
> -	period +=3D 1;
> -	period *=3D dwc->clk_ns;
> -	period +=3D duty;
> -	state->period =3D period;
> +	/* If we're not in PWM, technically the output is a 50-50

Huh, I expected checkpatch to warn about that. AFAIK the /* is supposed
to be on a line for itself?!

> +	 * based on the timer load-count only.
> +	 */
> +	if (ctrl & DWC_TIM_CTRL_PWM) {
> +		duty =3D ld;
> +		duty +=3D 1;
> +		duty *=3D dwc->clk_ns;

I would prefer to write that as:

	duty =3D (ld + 1) * dwc->clk_ns;

given that todays compilers are clever enough to optimize that just fine
and this version is better readable for humans.

> +
> +		period =3D ld2;
> +		period +=3D 1;
> +		period *=3D dwc->clk_ns;
> +		period +=3D duty;
> +	} else {
> +		duty =3D (ld + 1) * dwc->clk_ns;
> +		period =3D duty * 2;
> +	}
> =20
> +	state->period =3D period;
> +	state->duty_cycle =3D duty;
>  	state->polarity =3D PWM_POLARITY_INVERSED;
> =20
>  	pm_runtime_put_sync(chip->dev);
> --=20
> 2.35.1

I'm marking all patches in this series as "changes requested" even
though not all patches were commented. I assume that you continue to
care for all of them for the next revision. Please make sure to pass -v4
to git format-patch (or git send-email) then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u5pk4sbymvf2ijox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLuQPUACgkQwfwUeK3K
7AkR4gf7B9DBt7Mv4iKarUbP2G34tW5Z9GSdvjrFJw4QvIL/0gcLeKCbH+X1Qnki
3hAZJquao//+vfAmfx29dn1GPtKmoqTUbWMqvSGOgmiTBDG3zosHo5k7F247veo3
irIJCmSIvHkCgFN3WOyi47+hOxs5NWvq21N26nJrZ8cr2WyGsJADcyCCuGxT9H+T
tuU1aaMFCoyZ3q+pM36vFjX3lZNaEXzGkWCeKsG91dZHxcLz6ZfgV2XC/ntyVlkK
whKv2eWtdBBTfiFJc7SB6Mu21EnMBg7TojWmhS/UGrhYk298cn6Uy5Z5V06o9XMs
IzYv87bOB0hsnAbqXJM9dktqkwxdyQ==
=knzw
-----END PGP SIGNATURE-----

--u5pk4sbymvf2ijox--
