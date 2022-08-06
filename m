Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBC58B4F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbiHFKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbiHFKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:07:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8D12753
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 03:07:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGi4-00015e-Ka; Sat, 06 Aug 2022 12:07:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGi0-0024bw-Lz; Sat, 06 Aug 2022 12:07:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKGi1-009u86-Qw; Sat, 06 Aug 2022 12:07:05 +0200
Date:   Sat, 6 Aug 2022 12:07:03 +0200
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
Subject: Re: [PATCH 6/8] pwm: dwc: add timer clock
Message-ID: <20220806100703.uxnf2i4pne2kwk63@pengutronix.de>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-7-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaxdd5apuo5zvxnf"
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-7-ben.dooks@sifive.com>
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


--xaxdd5apuo5zvxnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Fri, Aug 05, 2022 at 05:50:31PM +0100, Ben Dooks wrote:
> Add a configurable clock base rate for the pwm as when being built
> for non-PCI the block may be sourced from an internal clock.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v2:
>   - removed the ifdef and merged the other clock patch in here
> ---
>  drivers/pwm/pwm-dwc.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index d5f2df6fee62..5c319d0e3d52 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> @@ -35,7 +36,6 @@
>  #define DWC_TIMERS_COMP_VERSION	0xac
> =20
>  #define DWC_TIMERS_TOTAL	8
> -#define DWC_CLK_PERIOD_NS	10
> =20
>  /* Timer Control Register */
>  #define DWC_TIM_CTRL_EN		BIT(0)
> @@ -54,6 +54,8 @@ struct dwc_pwm_ctx {
>  struct dwc_pwm {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int clk_ns;
>  	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>  };
>  #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> @@ -96,13 +98,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *=
dwc,
>  	 * periods and check are the result within HW limits between 1 and
>  	 * 2^32 periods.
>  	 */
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	low =3D tmp - 1;
> =20
>  	tmp =3D DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
> -				    DWC_CLK_PERIOD_NS);
> +				    dwc->clk_ns);

You're loosing precision here as clk_ns is already the result of a
division. We're having

	dwc->clk_ns =3D 1000000000 / clk_get_rate(dwc->clk);

=66rom dwc_pwm_plat_probe() (in the platform case).

Consider clk_rate =3D 285714285 and state->period - state->duty_cycle =3D
300000. Then you get tmp =3D 100000 while the exact result would be:

	300000 * 285714285 / 1000000000 =3D 85714.2855

Note that even doing

	dwc->clk_ns =3D DIV_ROUND_CLOSEST(1000000000, clk_get_rate(dwc->clk))

only somewhat weakens the problem, with the above numbers you then get
75000.

Also note that rounding closest is also wrong in the calculation of tmp
because the driver is supposed to implement the biggest period not
bigger than the requested period and for that period implement the
biggest duty cycle not bigger than the requested duty cycle.

Can the hardware emit 0% relative duty cycle (e.g. by disabling)?

>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	high =3D tmp - 1;
> @@ -177,12 +179,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
> =20
>  	duty =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>  	duty +=3D 1;
> -	duty *=3D DWC_CLK_PERIOD_NS;
> +	duty *=3D dwc->clk_ns;
>  	state->duty_cycle =3D duty;
> =20
>  	period =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>  	period +=3D 1;
> -	period *=3D DWC_CLK_PERIOD_NS;
> +	period *=3D dwc->clk_ns;
>  	period +=3D duty;
>  	state->period =3D period;
> =20
> @@ -205,6 +207,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *d=
ev)
>  	if (!dwc)
>  		return NULL;
> =20
> +	dwc->clk_ns =3D 10;
>  	dwc->chip.dev =3D dev;
>  	dwc->chip.ops =3D &dwc_pwm_ops;
>  	dwc->chip.npwm =3D DWC_TIMERS_TOTAL;
> @@ -336,6 +339,14 @@ static int dwc_pwm_plat_probe(struct platform_device=
 *pdev)
>  		return dev_err_probe(dev, PTR_ERR(dwc->base),
>  				     "failed to map IO\n");
> =20
> +	dwc->clk =3D devm_clk_get(dev, "timer");
> +	if (IS_ERR(dwc->clk))
> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
> +				     "failed to get timer clock\n");
> +
> +	clk_prepare_enable(dwc->clk);

If you used devm_clk_get_enabled() you wouldn't need to care separately
for enabling. (If you stick to separate calls, please add error checking
for clk_prepare_enable().)

> +	dwc->clk_ns =3D 1000000000 / clk_get_rate(dwc->clk);

s/1000000000/NSEC_PER_SEC/

> +
>  	ret =3D pwmchip_add(&dwc->chip);
>  	if (ret)
>  		return ret;
> @@ -347,6 +358,7 @@ static int dwc_pwm_plat_remove(struct platform_device=
 *pdev)
>  {
>  	struct dwc_pwm *dwc =3D platform_get_drvdata(pdev);
> =20
> +	clk_disable_unprepare(dwc->clk);
>  	pwmchip_remove(&dwc->chip);

This is wrong, you must not disable the clock before calling
pwmchip_remove() as the PWM is supposed to stay functional until
pwmchip_remove() returns.

>  	return 0;
>  }

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xaxdd5apuo5zvxnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLuPUQACgkQwfwUeK3K
7AmVxAf/XONIBuRAh5k6Mr4Jlwq3Vs6ng6W9ieMRBELcUf1JdrWq2DUUFaSmhhtr
RCqn5FyGulGQgTtg0Ybseo7FHO0lBNGeotZe1liWmtj3+KfDxW4ZrfXN9yVEj9Y/
nEih+q9mW/oZZQbqTlv3kYu81GClpOP013KT1h67vk+HMfcUGijSTqf2a/4tfg5B
ctgJv8YGHLIwWFzski9bFRoHqOl/9vk2aqptOJPlZTBlJKpSoQDo6lddeWujGMc5
tIRf7KHOM3V51V6Hg2Ol35Q+GOqFNUj333iT3BmjUhGVClC0T4fswsQN9Qq/t65c
7Y4vuI/Wm2bAq6Yj4Bhz4K6yDegVwA==
=My4q
-----END PGP SIGNATURE-----

--xaxdd5apuo5zvxnf--
