Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B2572DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiGMGKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGMGKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:10:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45DC6352
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:10:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVZt-0006mS-FF; Wed, 13 Jul 2022 08:10:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVZs-000eq7-Eq; Wed, 13 Jul 2022 08:10:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBVZr-004sba-E4; Wed, 13 Jul 2022 08:10:27 +0200
Date:   Wed, 13 Jul 2022 08:10:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
Subject: Re: [PATCH 5/7] pwm: dwc: add timer clock
Message-ID: <20220713061024.aapsqqtofb5y54zd@pengutronix.de>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-6-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="emcef65jx2exq74x"
Content-Disposition: inline
In-Reply-To: <20220712100113.569042-6-ben.dooks@sifive.com>
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


--emcef65jx2exq74x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 11:01:11AM +0100, Ben Dooks wrote:
> Add a configurable clock base rate for the pwm as when
> being built for non-PCI the block may be sourced from
> an internal clock.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  drivers/pwm/pwm-dwc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 235cb730c888..aa0486b89bdd 100644
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
> @@ -35,7 +36,12 @@
>  #define DWC_TIMERS_COMP_VERSION	0xac
> =20
>  #define DWC_TIMERS_TOTAL	8
> +
> +#ifndef CONFIG_OF
>  #define DWC_CLK_PERIOD_NS	10
> +#else
> +#define DWC_CLK_PERIOD_NS	dwc->clk_ns
> +#endif

Hmm, that looks wrong. If you have CONFIG_OF but use the pci device ...

IMHO it would help readability if you used ifdef. When there is an #else
branch anyhow, there is no reason to use the negative variant.

>  /* Timer Control Register */
>  #define DWC_TIM_CTRL_EN		BIT(0)
> @@ -54,6 +60,8 @@ struct dwc_pwm_ctx {
>  struct dwc_pwm {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int clk_ns;
>  	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>  };
>  #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> @@ -336,6 +344,14 @@ static int dwc_pwm_plat_probe(struct platform_device=
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
> +	dwc->clk_ns =3D 1000000000 /clk_get_rate(dwc->clk);
> +
>  	ret =3D pwmchip_add(&dwc->chip);
>  	if (ret)
>  		return ret;

Here you're missing clk_disable_unprepare(). (Alternatively use
devm_clk_get_enabled().)

> @@ -347,6 +363,7 @@ static int dwc_pwm_plat_remove(struct platform_device=
 *pdev)
>  {
>  	struct dwc_pwm *dwc =3D platform_get_drvdata(pdev);
> =20
> +	clk_disable_unprepare(dwc->clk);
>  	pwmchip_remove(&dwc->chip);

The order is wrong here. You must only stop the clk when the pwmchip is
removed. Until that the PWM is supposed to stay functional.

>  	return 0;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--emcef65jx2exq74x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLOYc0ACgkQwfwUeK3K
7AmAUAf/XdDJHJMPrKmm8NeYvTXFPxbVIExnG2y6hwtGCMAts2C5wo7JY0wwUys4
H5KgFGh8N0qNWw3a2QL9uGnCWznXwRXB+ir/rwYrBlRzcopQI03wzpfB88U1o2XG
aEAQSBD+TjO1p5JtD/DswY052Olc5P/taAEgHnHb/k09rwCBOtK9XQAxrpv+pZ5R
qD6+54LP1FMLVKaahcLZLT2gfTNU/qKlxF26r4FJZemOsels9zosJ+IuLDJ39GZF
Bp/jEMdaqYpxqSPsanSScf3qlQkTY3hlYGCHMiFI3wccamyjoUvniWr4WJphZ3/O
N443D1mPYj9YpFRcf8lDJUJ90Qiwbw==
=rsdR
-----END PGP SIGNATURE-----

--emcef65jx2exq74x--
