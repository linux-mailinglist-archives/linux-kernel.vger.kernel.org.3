Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655E058B4C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiHFJaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiHFJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:30:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E013F68
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:30:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKG8B-0005Ql-VJ; Sat, 06 Aug 2022 11:30:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKG87-00249Y-Gm; Sat, 06 Aug 2022 11:30:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKG89-009u37-1y; Sat, 06 Aug 2022 11:30:01 +0200
Date:   Sat, 6 Aug 2022 11:29:58 +0200
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
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
Message-ID: <20220806092958.7snnef4fwi5gcqw7@pengutronix.de>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2jw6adv4qfzwuy7"
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-5-ben.dooks@sifive.com>
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


--g2jw6adv4qfzwuy7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2022 at 05:50:29PM +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v3:
>  - changed compatible name
> ---
>  drivers/pwm/Kconfig   |  5 ++--
>  drivers/pwm/pwm-dwc.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..b8717877a524 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -176,9 +176,10 @@ config PWM_CROS_EC
> =20
>  config PWM_DWC
>  	tristate "DesignWare PWM Controller"
> -	depends on PCI
> +	depends on PCI || OF
>  	help
> -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> +	  PWM driver for Synopsys DWC PWM Controller attached to either a
> +	  PCI or platform bus.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-dwc.
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 61f11e0a9319..d5f2df6fee62 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> =20
> @@ -319,6 +320,58 @@ static struct pci_driver dwc_pwm_driver =3D {
> =20
>  module_pci_driver(dwc_pwm_driver);
> =20
> +#ifdef CONFIG_OF
> +static int dwc_pwm_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct dwc_pwm *dwc;
> +	int ret;
> +
> +	dwc =3D dwc_pwm_alloc(dev);
> +	if (!dwc)
> +		return -ENOMEM;
> +
> +	dwc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dwc->base))
> +		return dev_err_probe(dev, PTR_ERR(dwc->base),
> +				     "failed to map IO\n");

devm_platform_ioremap_resource already provides an error message, so
drop the message here.

> +	ret =3D pwmchip_add(&dwc->chip);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

the last three code lines are equivalent to just

	return ret;

An error message would be nice after pwmchip_add failed.

> +}
> +
> +static int dwc_pwm_plat_remove(struct platform_device *pdev)
> +{
> +	struct dwc_pwm *dwc =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&dwc->chip);
> +	return 0;
> +}

Please consider using devm_pwmchip_add() which makes it unnecessary to
provide a remove callback.

> +static const struct of_device_id dwc_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "snps,dw-apb-timers-pwm2" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
> +
> +static struct platform_driver dwc_pwm_plat_driver =3D {
> +	.driver =3D {
> +		.name		=3D "dwc-pwm",
> +		.of_match_table  =3D dwc_pwm_dt_ids,

I'm not a fan of aligning the =3D signs, for sure, don't use tabs for one
and spaces for the other. If you ask me, use a single space.

> +	},
> +	.probe	=3D dwc_pwm_plat_probe,
> +	.remove	=3D dwc_pwm_plat_remove,
> +};
> +
> +module_platform_driver(dwc_pwm_plat_driver);
> +
> +MODULE_ALIAS("platform:dwc-pwm");
> +#endif /* CONFIG_OF */
> +
> +
>  MODULE_AUTHOR("Felipe Balbi (Intel)");
>  MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
>  MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
>=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g2jw6adv4qfzwuy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLuNJMACgkQwfwUeK3K
7AlZxgf/U/h7YG6LjQJD5Jlg3Zu7mxRGZ+K4ygiEHbNLFQ3rYXGtsAfjkE/qbG3g
yQn3T6StlmSM3RKZxHRpH6gvr3ITSlpefzEjpOxpHCZhTYbbKlfOrGf7PN9zMqYx
2AnJ2qErdSML6OkA1Opw3/GSWrXxf+fzKwsHILMOz4oq8jX0K6J/EYsgBnIUejjy
VxLAhFoKd21QXa946f7RqSrPlGl45iZin2AG4DTTalDHHk9V9X/50w2JC+4gjhzK
rPtQWOdohqYMhwtNR3knVe1CgquDdItX1lwWzfSt73TG+Y3Ey0s+FRN2W0mdYM4q
fH2GcCeXfSmBzqZiPKXjaih4uOsUiQ==
=GNP3
-----END PGP SIGNATURE-----

--g2jw6adv4qfzwuy7--
