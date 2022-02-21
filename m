Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAEE4BDC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiBUJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:44:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351553AbiBUJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:37:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09F3A1B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:16:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM4nN-00037y-8Y; Mon, 21 Feb 2022 10:15:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM4nM-000OTG-MK; Mon, 21 Feb 2022 10:15:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nM4nL-004ZU9-65; Mon, 21 Feb 2022 10:15:47 +0100
Date:   Mon, 21 Feb 2022 10:15:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: pwm-mtk-disp: Switch to regmap for mmio access
Message-ID: <20220221091547.wxmz7fqicyhjc5rc@pengutronix.de>
References: <20220103153506.50896-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="the5o73wncrjkh3c"
Content-Disposition: inline
In-Reply-To: <20220103153506.50896-1-angelogioacchino.delregno@collabora.com>
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


--the5o73wncrjkh3c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 03, 2022 at 04:35:06PM +0100, AngeloGioacchino Del Regno wrote:
> Switch to using the generic regmap API instead of calls to readl/writel
> for MMIO register access, allowing us to reduce code size.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 77 ++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index c605013e4114..4a6fab144cee 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
>  #define DISP_PWM_EN		0x00
> @@ -47,7 +48,7 @@ struct mtk_disp_pwm {
>  	const struct mtk_pwm_data *data;
>  	struct clk *clk_main;
>  	struct clk *clk_mm;
> -	void __iomem *base;
> +	struct regmap *regmap;
>  	bool enabled;
>  };
> =20
> @@ -56,22 +57,11 @@ static inline struct mtk_disp_pwm *to_mtk_disp_pwm(st=
ruct pwm_chip *chip)
>  	return container_of(chip, struct mtk_disp_pwm, chip);
>  }
> =20
> -static void mtk_disp_pwm_update_bits(struct mtk_disp_pwm *mdp, u32 offse=
t,
> -				     u32 mask, u32 data)
> -{
> -	void __iomem *address =3D mdp->base + offset;
> -	u32 value;
> -
> -	value =3D readl(address);
> -	value &=3D ~mask;
> -	value |=3D data;
> -	writel(value, address);
> -}
> -
>  static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
>  			      const struct pwm_state *state)
>  {
>  	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
> +	const struct mtk_pwm_data *pdata =3D mdp->data;
>  	u32 clk_div, period, high_width, value;
>  	u64 div, rate;
>  	int err;
> @@ -80,8 +70,7 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		return -EINVAL;
> =20
>  	if (!state->enabled) {
> -		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> -					 0x0);
> +		regmap_clear_bits(mdp->regmap, DISP_PWM_EN, pdata->enable_mask);
> =20
>  		if (mdp->enabled) {
>  			clk_disable_unprepare(mdp->clk_mm);
> @@ -138,37 +127,25 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	high_width =3D mul_u64_u64_div_u64(state->duty_cycle, rate, div);
>  	value =3D period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> =20
> -	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -				 PWM_CLKDIV_MASK,
> -				 clk_div << PWM_CLKDIV_SHIFT);
> -	mtk_disp_pwm_update_bits(mdp, mdp->data->con1,
> -				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
> -				 value);
> +	regmap_update_bits(mdp->regmap, pdata->con0, PWM_CLKDIV_MASK,
> +			   clk_div << PWM_CLKDIV_SHIFT);
> +	regmap_update_bits(mdp->regmap, pdata->con1,
> +			   PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK, value);
> =20
>  	if (mdp->data->has_commit) {
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
> -					 mdp->data->commit_mask,
> -					 mdp->data->commit_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
> -					 mdp->data->commit_mask,
> -					 0x0);
> +		regmap_set_bits(mdp->regmap, pdata->commit, pdata->commit_mask);
> +		regmap_clear_bits(mdp->regmap, pdata->commit, pdata->commit_mask);
>  	} else {
>  		/*
>  		 * For MT2701, disable double buffer before writing register
>  		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
>  		 */
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> -					 mdp->data->bls_debug_mask,
> -					 mdp->data->bls_debug_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -					 mdp->data->con0_sel,
> -					 mdp->data->con0_sel);
> +		regmap_set_bits(mdp->regmap, pdata->bls_debug, pdata->bls_debug_mask);
> +		regmap_set_bits(mdp->regmap, pdata->con0, pdata->con0_sel);
>  	}
> =20
> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> -				 mdp->data->enable_mask);
> +	regmap_set_bits(mdp->regmap, DISP_PWM_EN, pdata->enable_mask);
>  	mdp->enabled =3D true;
> -

Was the empty line here removed on purpose? I would have kept it.

>  	return 0;
>  }
> =20
> @@ -195,8 +172,8 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *c=
hip,
>  	}
> =20
>  	rate =3D clk_get_rate(mdp->clk_main);
> -	con0 =3D readl(mdp->base + mdp->data->con0);
> -	con1 =3D readl(mdp->base + mdp->data->con1);
> +	regmap_read(mdp->regmap, mdp->data->con0, &con0);
> +	regmap_read(mdp->regmap, mdp->data->con1, &con1);
>  	state->enabled =3D !!(con0 & BIT(0));
>  	clk_div =3D FIELD_GET(PWM_CLKDIV_MASK, con0);
>  	period =3D FIELD_GET(PWM_PERIOD_MASK, con1);
> @@ -219,9 +196,17 @@ static const struct pwm_ops mtk_disp_pwm_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static const struct regmap_config mtk_disp_pwm_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.disable_locking =3D true,
> +};
> +
>  static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  {
>  	struct mtk_disp_pwm *mdp;
> +	void __iomem *base;
>  	int ret;
> =20
>  	mdp =3D devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
> @@ -230,9 +215,13 @@ static int mtk_disp_pwm_probe(struct platform_device=
 *pdev)
> =20
>  	mdp->data =3D of_device_get_match_data(&pdev->dev);
> =20
> -	mdp->base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(mdp->base))
> -		return PTR_ERR(mdp->base);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	mdp->regmap =3D devm_regmap_init_mmio(&pdev->dev, base, &mtk_disp_pwm_r=
egmap_config);
> +	if (IS_ERR(mdp->regmap))
> +		return PTR_ERR(mdp->regmap);
> =20
>  	mdp->clk_main =3D devm_clk_get(&pdev->dev, "main");
>  	if (IS_ERR(mdp->clk_main))
> @@ -247,10 +236,8 @@ static int mtk_disp_pwm_probe(struct platform_device=
 *pdev)
>  	mdp->chip.npwm =3D 1;
> =20
>  	ret =3D pwmchip_add(&mdp->chip);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %pe\n", ERR_PTR(ret));
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");

I wonder that you convert this to dev_err_probe, but don't use it in the
hunk above. If I'm not mistaken devm_regmap_init_mmio doesn't emit an
error message, so an error message would be appropriate there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--the5o73wncrjkh3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmITWD8ACgkQwfwUeK3K
7AnVTwf/d/6wF7mTZFktUIW8C0OeHQOFn6f8+btJwknUOXbY5NZGoj7keHwdxpqr
BjmdmMkwoprwKqC3d3hnukM12YHbDxHnW+6FUHqMPua4W/xTAlnUuHJAnrEwSraf
Tzux+dHfvW9LGrLbCc6quGZIILEarDFgCVVDcPlTTmmu8QYHeXHNGCWxT/BP0MjQ
bI6pRO36mkuXWJq3cumhfFs2/lr4GXoOPARwXbanOAbvAo/Ekp9YNMi6LKDeZd7+
DHb4fDXcOUD9a57TrYToPbxIR2im1bTA81XTEyu3B51mZMDELZe173jRKgUC7uBu
fG0ep5/fNclvtAcbPIZBfWfmFkIItw==
=LNMU
-----END PGP SIGNATURE-----

--the5o73wncrjkh3c--
