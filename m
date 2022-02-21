Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7B4BD82C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiBUISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:18:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiBUISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:18:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E6E1DA52
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:17:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM3sw-00047o-3Z; Mon, 21 Feb 2022 09:17:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM3su-000Nwy-FU; Mon, 21 Feb 2022 09:17:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM3st-004YuB-4s; Mon, 21 Feb 2022 09:17:27 +0100
Date:   Mon, 21 Feb 2022 09:17:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v16 21/40] pwm: tegra: Add runtime PM and OPP support
Message-ID: <20220221081727.jeq2jff5ewjzubxv@pengutronix.de>
References: <20211130232347.950-1-digetx@gmail.com>
 <20211130232347.950-22-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwoouscqlz5ttj4a"
Content-Disposition: inline
In-Reply-To: <20211130232347.950-22-digetx@gmail.com>
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


--cwoouscqlz5ttj4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 01, 2021 at 02:23:28AM +0300, Dmitry Osipenko wrote:
> The PWM on Tegra belongs to the core power domain and we're going to
> enable GENPD support for the core domain. Now PWM must be resumed using
> runtime PM API in order to initialize the PWM power state. The PWM clock
> rate must be changed using OPP API that will reconfigure the power domain
> performance state in accordance to the rate. Add runtime PM and OPP
> support to the PWM driver.
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/pwm/pwm-tegra.c | 82 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 11a10b575ace..18cf974ac776 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -42,12 +42,16 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pwm.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/reset.h>
> =20
> +#include <soc/tegra/common.h>
> +
>  #define PWM_ENABLE	(1 << 31)
>  #define PWM_DUTY_WIDTH	8
>  #define PWM_DUTY_SHIFT	16
> @@ -145,7 +149,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		required_clk_rate =3D
>  			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> =20
> -		err =3D clk_set_rate(pc->clk, required_clk_rate);
> +		err =3D dev_pm_opp_set_rate(pc->dev, required_clk_rate);
>  		if (err < 0)
>  			return -EINVAL;
> =20
> @@ -181,8 +185,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	 * before writing the register. Otherwise, keep it enabled.
>  	 */
>  	if (!pwm_is_enabled(pwm)) {
> -		err =3D clk_prepare_enable(pc->clk);
> -		if (err < 0)
> +		err =3D pm_runtime_resume_and_get(pc->dev);
> +		if (err)
>  			return err;
>  	} else
>  		val |=3D PWM_ENABLE;
> @@ -193,7 +197,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	 * If the PWM is not enabled, turn the clock off again to save power.
>  	 */
>  	if (!pwm_is_enabled(pwm))
> -		clk_disable_unprepare(pc->clk);
> +		pm_runtime_put(pc->dev);
> =20
>  	return 0;
>  }
> @@ -204,8 +208,8 @@ static int tegra_pwm_enable(struct pwm_chip *chip, st=
ruct pwm_device *pwm)
>  	int rc =3D 0;
>  	u32 val;
> =20
> -	rc =3D clk_prepare_enable(pc->clk);
> -	if (rc < 0)
> +	rc =3D pm_runtime_resume_and_get(pc->dev);
> +	if (rc)
>  		return rc;
> =20
>  	val =3D pwm_readl(pc, pwm->hwpwm);
> @@ -224,7 +228,7 @@ static void tegra_pwm_disable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	val &=3D ~PWM_ENABLE;
>  	pwm_writel(pc, pwm->hwpwm, val);
> =20
> -	clk_disable_unprepare(pc->clk);
> +	pm_runtime_put_sync(pc->dev);
>  }
> =20
>  static const struct pwm_ops tegra_pwm_ops =3D {
> @@ -256,11 +260,20 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
> =20
> +	ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
>  	/* Set maximum frequency of the IP */
> -	ret =3D clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> +	ret =3D dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
> -		return ret;
> +		goto put_pm;
>  	}
> =20
>  	/*
> @@ -278,7 +291,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(pwm->rst)) {
>  		ret =3D PTR_ERR(pwm->rst);
>  		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
> -		return ret;
> +		goto put_pm;
>  	}
> =20
>  	reset_control_deassert(pwm->rst);
> @@ -291,10 +304,16 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  		reset_control_assert(pwm->rst);
> -		return ret;
> +		goto put_pm;
>  	}
> =20
> +	pm_runtime_put(&pdev->dev);
> +
>  	return 0;
> +put_pm:
> +	pm_runtime_put_sync_suspend(&pdev->dev);
> +	pm_runtime_force_suspend(&pdev->dev);
> +	return ret;
>  }
> =20
>  static int tegra_pwm_remove(struct platform_device *pdev)
> @@ -305,20 +324,44 @@ static int tegra_pwm_remove(struct platform_device =
*pdev)
> =20
>  	reset_control_assert(pc->rst);
> =20
> +	pm_runtime_force_suspend(&pdev->dev);
> +
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM_SLEEP
> -static int tegra_pwm_suspend(struct device *dev)
> +static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
>  {
> -	return pinctrl_pm_select_sleep_state(dev);
> +	struct tegra_pwm_chip *pc =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	clk_disable_unprepare(pc->clk);
> +
> +	err =3D pinctrl_pm_select_sleep_state(dev);
> +	if (err) {
> +		clk_prepare_enable(pc->clk);
> +		return err;
> +	}
> +
> +	return 0;
>  }
> =20
> -static int tegra_pwm_resume(struct device *dev)
> +static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
>  {
> -	return pinctrl_pm_select_default_state(dev);
> +	struct tegra_pwm_chip *pc =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D pinctrl_pm_select_default_state(dev);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(pc->clk);
> +	if (err) {
> +		pinctrl_pm_select_sleep_state(dev);
> +		return err;
> +	}
> +
> +	return 0;
>  }
> -#endif
> =20
>  static const struct tegra_pwm_soc tegra20_pwm_soc =3D {
>  	.num_channels =3D 4,
> @@ -344,7 +387,10 @@ static const struct of_device_id tegra_pwm_of_match[=
] =3D {
>  MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
> =20
>  static const struct dev_pm_ops tegra_pwm_pm_ops =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(tegra_pwm_suspend, tegra_pwm_resume)
> +	SET_RUNTIME_PM_OPS(tegra_pwm_runtime_suspend, tegra_pwm_runtime_resume,
> +			   NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
> =20
>  static struct platform_driver tegra_pwm_driver =3D {

I admit to not completely understand the effects of this patch, but I
don't see a problem either. So for me this patch is OK:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I spot a problem, it's not introduced by this patch however: If the
consumer of the PWM didn't stop the hardware, the suspend should IMHO be
prevented.

I wonder if the patches in this series go in in one go via an ARM or
Tegra tree, or each patch via its respective maintainer tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cwoouscqlz5ttj4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmITSpMACgkQwfwUeK3K
7AmZaggAnjKWv6/JVY3Cp1bcb73ZjrS1hecjg6rS92mYnqvqYCbPCvW9u6Ku+IWI
u/wIClnWJzYXF6ukB9OGBlJox1w6dS/j+LHiqAQw5h4DdWQv0cy27jDTF9lV4r1E
DQWuKRNPSs/X7nMMIGkJ2UqgyeKw0sfX1cHpiJ8WatkPUwayInGaBfblE0seHIhw
QUG2NbJtiROV3MgPRpoQWb0+7t9SSw9wxobBva3oaAIMNQLDmi/hcMzJXfXo3uH5
Nu4PJjXQxnIxTap/ys4sqabTbmIopeHY2WDuuwIxgRqF9O4IRl+ygV05c79HE6mt
tX1TItqO17EB1/sux6//dOpREBQgQA==
=cZKl
-----END PGP SIGNATURE-----

--cwoouscqlz5ttj4a--
