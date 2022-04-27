Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97251511B55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiD0Njv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiD0Njl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:39:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DB4BB9C;
        Wed, 27 Apr 2022 06:36:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 65A931F44777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651066588;
        bh=IWzXLtS9cVu8yK22quZ5GFOORsY31Ichreqxak0QuoQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dxGzCIweZOMEYZdU41U+tpWLq5IBp9YNnc/+QnH+uXo1gLNrL/70T6ly1drL1tKh6
         CbHOf8Jp/WctAMEb7N1+5nMq6OZA3+mA3iDSI/7ZwsbjyYEY/3Ijy+GZd+vmD9ioEP
         YyHTwjCJpjgL22Ek3SSHZuaRfgC1YyGR29eSnV1C/S0Ta1h2MwaGxgntN5VrvsLmni
         ukoB/NVaty0pwdW+r8szrtJaQMFUMBvPlzWp389k5GM3W+VvZiUbDIln8/tg9id1Zq
         sqtqp4fchKPKUNoI73hEo+gRsAIP1pt/1Jt0FqOMmWgtY9PRLNvc+KROFfcFfki8zz
         qHpHXs0f1t8yw==
Message-ID: <05f60b83065a7e39c04f71c6b769a205e1953f41.camel@collabora.com>
Subject: Re: [PATCHv1 03/19] clk: rockchip: add pll type for RK3588
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com
Date:   Wed, 27 Apr 2022 09:36:17 -0400
In-Reply-To: <20220422170920.401914-4-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
         <20220422170920.401914-4-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 22 avril 2022 =C3=A0 19:09 +0200, Sebastian Reichel a =C3=A9cri=
t=C2=A0:
> From: Elaine Zhang <zhangqing@rock-chips.com>
>=20
> Add RK3588 PLL support including calculation of PLL parameters
> for arbitrary frequencies.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> [rebase and partially rewrite code]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/rockchip/clk-pll.c | 287 ++++++++++++++++++++++++++++++++-
>  drivers/clk/rockchip/clk.h     |  18 +++
>  2 files changed, 304 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pl=
l.c
> index f7827b3b7fc1..010e47eb51b8 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -15,6 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/units.h>
>  #include "clk.h"
> =20
>  #define PLL_MODE_MASK		0x3
> @@ -47,6 +48,67 @@ struct rockchip_clk_pll {
>  #define to_rockchip_clk_pll_nb(nb) \
>  			container_of(nb, struct rockchip_clk_pll, clk_nb)
> =20
> +static int
> +rockchip_rk3588_get_pll_settings(struct rockchip_clk_pll *pll,
> +				 unsigned long fin_hz,
> +				 unsigned long fout_hz,
> +				 struct rockchip_pll_rate_table *rate_table)
> +{
> +	u64 fvco_min =3D 2250 * HZ_PER_MHZ, fvco_max =3D 4500 * HZ_PER_MHZ;
> +	u64 fout_min =3D 37 * HZ_PER_MHZ, fout_max =3D 4500 * HZ_PER_MHZ;
> +	u32 p, m, s;
> +	u64 fvco, fref, fout, ffrac;
> +
> +	if (fin_hz =3D=3D 0 || fout_hz =3D=3D 0 || fout_hz =3D=3D fin_hz)
> +		return -EINVAL;
> +
> +	if (fout_hz > fout_max || fout_hz < fout_min)
> +		return -EINVAL;
> +
> +	if (fin_hz / HZ_PER_MHZ * HZ_PER_MHZ =3D=3D fin_hz &&
> +	    fout_hz / HZ_PER_MHZ * HZ_PER_MHZ =3D=3D fout_hz) {
> +		for (s =3D 0; s <=3D 6; s++) {
> +			fvco =3D fout_hz << s;
> +			if (fvco < fvco_min || fvco > fvco_max)
> +				continue;
> +			for (p =3D 2; p <=3D 4; p++) {
> +				for (m =3D 64; m <=3D 1023; m++) {
> +					if (fvco =3D=3D m * fin_hz / p) {
> +						rate_table->p =3D p;
> +						rate_table->m =3D m;
> +						rate_table->s =3D s;
> +						rate_table->k =3D 0;
> +						return 0;
> +					}
> +				}
> +			}
> +		}
> +	} else {
> +		fout =3D (fout_hz / HZ_PER_MHZ) * HZ_PER_MHZ;
> +		ffrac =3D (fout_hz % HZ_PER_MHZ);
> +		for (s =3D 0; s <=3D 6; s++) {
> +			fvco =3D fout << s;
> +			if (fvco < fvco_min || fvco > fvco_max)
> +				continue;
> +			for (p =3D 1; p <=3D 4; p++) {
> +				for (m =3D 64; m <=3D 1023; m++) {
> +					if (fvco =3D=3D m * fin_hz / p) {
> +						rate_table->p =3D p;
> +						rate_table->m =3D m;
> +						rate_table->s =3D s;
> +						fref =3D fin_hz / p;
> +						fout =3D (ffrac << s) * 65535;
> +						rate_table->k =3D fout / fref;
> +						return 0;
> +					}
> +				}
> +			}
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
>  			    struct rockchip_clk_pll *pll, unsigned long rate)
>  {
> @@ -68,6 +130,14 @@ static long rockchip_pll_round_rate(struct clk_hw *hw=
,
>  	const struct rockchip_pll_rate_table *rate_table =3D pll->rate_table;
>  	int i;
> =20
> +	if (pll->type =3D=3D pll_rk3588 || pll->type =3D=3D pll_rk3588_core) {
> +		long parent_rate =3D prate ? *prate : 24 * HZ_PER_MHZ;
> +		struct rockchip_pll_rate_table pll_settings;
> +
> +		if (rockchip_rk3588_get_pll_settings(pll, parent_rate, drate, &pll_set=
tings) >=3D 0)
> +			return pll_settings.rate;
> +	}
> +

I was reading some of previous backlog on why these formula have never been
mainlines [0]. It looks like so far the statu quo was adopted. But if that =
was
to change, I think this implementation is not aligned with the intent. If m=
y
understanding is right, the rate_table[] (if it exists) should be looked up
first and the formula use as a fallback.

[0] https://patchwork.kernel.org/project/linux-rockchip/patch/1470144852-20=
708-1-git-send-email-zhengxing@rock-chips.com/#19548765

>  	/* Assumming rate_table is in descending order */
>  	for (i =3D 0; i < pll->rate_count; i++) {
>  		if (drate >=3D rate_table[i].rate)
> @@ -842,6 +912,212 @@ static const struct clk_ops rockchip_rk3399_pll_clk=
_ops =3D {
>  	.init =3D rockchip_rk3399_pll_init,
>  };
> =20
> +/**
> + * PLL used in RK3588
> + */
> +
> +#define RK3588_PLLCON(i)               (i * 0x4)
> +#define RK3588_PLLCON0_M_MASK          0x3ff
> +#define RK3588_PLLCON0_M_SHIFT         0
> +#define RK3588_PLLCON1_P_MASK          0x3f
> +#define RK3588_PLLCON1_P_SHIFT         0
> +#define RK3588_PLLCON1_S_MASK          0x7
> +#define RK3588_PLLCON1_S_SHIFT         6
> +#define RK3588_PLLCON2_K_MASK          0xffff
> +#define RK3588_PLLCON2_K_SHIFT         0
> +#define RK3588_PLLCON1_PWRDOWN         BIT(13)
> +#define RK3588_PLLCON6_LOCK_STATUS     BIT(15)
> +
> +static int rockchip_rk3588_pll_wait_lock(struct rockchip_clk_pll *pll)
> +{
> +	u32 pllcon;
> +	int ret;
> +
> +	/*
> +	 * Lock time typical 250, max 500 input clock cycles @24MHz
> +	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
> +	 */
> +	ret =3D readl_relaxed_poll_timeout(pll->reg_base + RK3588_PLLCON(6),
> +					 pllcon,
> +					 pllcon & RK3588_PLLCON6_LOCK_STATUS,
> +					 0, 1000);
> +	if (ret)
> +		pr_err("%s: timeout waiting for pll to lock\n", __func__);
> +
> +	return ret;
> +}
> +
> +static void rockchip_rk3588_pll_get_params(struct rockchip_clk_pll *pll,
> +					   struct rockchip_pll_rate_table *rate)
> +{
> +	u32 pllcon;
> +
> +	pllcon =3D readl_relaxed(pll->reg_base + RK3588_PLLCON(0));
> +	rate->m =3D ((pllcon >> RK3588_PLLCON0_M_SHIFT) & RK3588_PLLCON0_M_MASK=
);
> +
> +	pllcon =3D readl_relaxed(pll->reg_base + RK3588_PLLCON(1));
> +	rate->p =3D ((pllcon >> RK3588_PLLCON1_P_SHIFT) & RK3588_PLLCON1_P_MASK=
);
> +	rate->s =3D ((pllcon >> RK3588_PLLCON1_S_SHIFT) & RK3588_PLLCON1_S_MASK=
);
> +
> +	pllcon =3D readl_relaxed(pll->reg_base + RK3588_PLLCON(2));
> +	rate->k =3D ((pllcon >> RK3588_PLLCON2_K_SHIFT) & RK3588_PLLCON2_K_MASK=
);
> +}
> +
> +static unsigned long rockchip_rk3588_pll_recalc_rate(struct clk_hw *hw, =
unsigned long prate)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +	struct rockchip_pll_rate_table cur;
> +	u64 rate64 =3D prate, postdiv;
> +
> +	rockchip_rk3588_pll_get_params(pll, &cur);
> +
> +	rate64 *=3D cur.m;
> +	do_div(rate64, cur.p);
> +
> +	if (cur.k) {
> +		/* fractional mode */
> +		u64 frac_rate64 =3D prate * cur.k;
> +
> +		postdiv =3D cur.p * 65535;
> +		do_div(frac_rate64, postdiv);
> +		rate64 +=3D frac_rate64;
> +	}
> +	rate64 =3D rate64 >> cur.s;
> +
> +	return (unsigned long)rate64;
> +}
> +
> +static int rockchip_rk3588_pll_set_params(struct rockchip_clk_pll *pll,
> +					  const struct rockchip_pll_rate_table *rate)
> +{
> +	const struct clk_ops *pll_mux_ops =3D pll->pll_mux_ops;
> +	struct clk_mux *pll_mux =3D &pll->pll_mux;
> +	struct rockchip_pll_rate_table cur;
> +	int rate_change_remuxed =3D 0;
> +	int cur_parent;
> +	int ret;
> +
> +	pr_debug("%s: rate settings for %lu p: %d, m: %d, s: %d, k: %d\n",
> +		 __func__, rate->rate, rate->p, rate->m, rate->s, rate->k);
> +
> +	rockchip_rk3588_pll_get_params(pll, &cur);
> +	cur.rate =3D 0;
> +
> +	if (pll->type =3D=3D pll_rk3588) {
> +		cur_parent =3D pll_mux_ops->get_parent(&pll_mux->hw);
> +		if (cur_parent =3D=3D PLL_MODE_NORM) {
> +			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
> +			rate_change_remuxed =3D 1;
> +		}
> +	}
> +
> +	/* set pll power down */
> +	writel(HIWORD_UPDATE(RK3588_PLLCON1_PWRDOWN,
> +			     RK3588_PLLCON1_PWRDOWN, 0),
> +	       pll->reg_base + RK3399_PLLCON(1));
> +
> +	/* update pll values */
> +	writel_relaxed(HIWORD_UPDATE(rate->m, RK3588_PLLCON0_M_MASK, RK3588_PLL=
CON0_M_SHIFT),
> +		       pll->reg_base + RK3399_PLLCON(0));
> +
> +	writel_relaxed(HIWORD_UPDATE(rate->p, RK3588_PLLCON1_P_MASK, RK3588_PLL=
CON1_P_SHIFT) |
> +		       HIWORD_UPDATE(rate->s, RK3588_PLLCON1_S_MASK, RK3588_PLLCON1_S_=
SHIFT),
> +		       pll->reg_base + RK3399_PLLCON(1));
> +
> +	writel_relaxed(HIWORD_UPDATE(rate->k, RK3588_PLLCON2_K_MASK, RK3588_PLL=
CON2_K_SHIFT),
> +		       pll->reg_base + RK3399_PLLCON(2));
> +
> +	/* set pll power up */
> +	writel(HIWORD_UPDATE(0, RK3588_PLLCON1_PWRDOWN, 0),
> +	       pll->reg_base + RK3588_PLLCON(1));
> +
> +	/* wait for the pll to lock */
> +	ret =3D rockchip_rk3588_pll_wait_lock(pll);
> +	if (ret) {
> +		pr_warn("%s: pll update unsuccessful, trying to restore old params\n",
> +			__func__);
> +		rockchip_rk3588_pll_set_params(pll, &cur);
> +	}
> +
> +	if ((pll->type =3D=3D pll_rk3588) && rate_change_remuxed)
> +		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
> +
> +	return ret;
> +}
> +
> +static int rockchip_rk3588_pll_set_rate(struct clk_hw *hw, unsigned long=
 drate,
> +					unsigned long prate)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +	struct rockchip_pll_rate_table rate;
> +	unsigned long old_rate =3D rockchip_rk3588_pll_recalc_rate(hw, prate);
> +
> +	pr_debug("%s: changing %s from %lu to %lu with a parent rate of %lu\n",
> +		 __func__, __clk_get_name(hw->clk), old_rate, drate, prate);
> +
> +	if (rockchip_rk3588_get_pll_settings(pll, prate, drate, &rate) < 0) {
> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
> +		       drate, __clk_get_name(hw->clk));
> +		return -EINVAL;
> +	}
> +
> +	return rockchip_rk3588_pll_set_params(pll, &rate);
> +}
> +
> +static int rockchip_rk3588_pll_enable(struct clk_hw *hw)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +
> +	writel(HIWORD_UPDATE(0, RK3588_PLLCON1_PWRDOWN, 0),
> +	       pll->reg_base + RK3588_PLLCON(1));
> +	rockchip_rk3588_pll_wait_lock(pll);
> +
> +	return 0;
> +}
> +
> +static void rockchip_rk3588_pll_disable(struct clk_hw *hw)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +
> +	writel(HIWORD_UPDATE(RK3588_PLLCON1_PWRDOWN, RK3588_PLLCON1_PWRDOWN, 0)=
,
> +	       pll->reg_base + RK3588_PLLCON(1));
> +}
> +
> +static int rockchip_rk3588_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +	u32 pllcon =3D readl(pll->reg_base + RK3588_PLLCON(1));
> +
> +	return !(pllcon & RK3588_PLLCON1_PWRDOWN);
> +}
> +
> +static int rockchip_rk3588_pll_init(struct clk_hw *hw)
> +{
> +	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
> +
> +	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops rockchip_rk3588_pll_clk_norate_ops =3D {
> +	.recalc_rate =3D rockchip_rk3588_pll_recalc_rate,
> +	.enable =3D rockchip_rk3588_pll_enable,
> +	.disable =3D rockchip_rk3588_pll_disable,
> +	.is_enabled =3D rockchip_rk3588_pll_is_enabled,
> +};
> +
> +static const struct clk_ops rockchip_rk3588_pll_clk_ops =3D {
> +	.recalc_rate =3D rockchip_rk3588_pll_recalc_rate,
> +	.round_rate =3D rockchip_pll_round_rate,
> +	.set_rate =3D rockchip_rk3588_pll_set_rate,
> +	.enable =3D rockchip_rk3588_pll_enable,
> +	.disable =3D rockchip_rk3588_pll_disable,
> +	.is_enabled =3D rockchip_rk3588_pll_is_enabled,
> +	.init =3D rockchip_rk3588_pll_init,
> +};
> +
>  /*
>   * Common registering of pll clocks
>   */
> @@ -890,7 +1166,8 @@ struct clk *rockchip_clk_register_pll(struct rockchi=
p_clk_provider *ctx,
>  	if (pll_type =3D=3D pll_rk3036 ||
>  	    pll_type =3D=3D pll_rk3066 ||
>  	    pll_type =3D=3D pll_rk3328 ||
> -	    pll_type =3D=3D pll_rk3399)
> +	    pll_type =3D=3D pll_rk3399 ||
> +	    pll_type =3D=3D pll_rk3588)
>  		pll_mux->flags |=3D CLK_MUX_HIWORD_MASK;
> =20
>  	/* the actual muxing is xin24m, pll-output, xin32k */
> @@ -957,6 +1234,14 @@ struct clk *rockchip_clk_register_pll(struct rockch=
ip_clk_provider *ctx,
>  		else
>  			init.ops =3D &rockchip_rk3399_pll_clk_ops;
>  		break;
> +	case pll_rk3588:
> +	case pll_rk3588_core:
> +		if (!pll->rate_table)
> +			init.ops =3D &rockchip_rk3588_pll_clk_norate_ops;
> +		else
> +			init.ops =3D &rockchip_rk3588_pll_clk_ops;
> +		init.flags =3D flags;
> +		break;
>  	default:
>  		pr_warn("%s: Unknown pll type for pll clk %s\n",
>  			__func__, name);
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 6aece7f07a7d..bf7c8d082fde 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -221,6 +221,8 @@ enum rockchip_pll_type {
>  	pll_rk3066,
>  	pll_rk3328,
>  	pll_rk3399,
> +	pll_rk3588,
> +	pll_rk3588_core,
>  };
> =20
>  #define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
> @@ -253,6 +255,15 @@ enum rockchip_pll_type {
>  	.nb =3D _nb,						\
>  }
> =20
> +#define RK3588_PLL_RATE(_rate, _p, _m, _s, _k)			\
> +{								\
> +	.rate   =3D _rate##U,					\
> +	.p =3D _p,						\
> +	.m =3D _m,						\
> +	.s =3D _s,						\
> +	.k =3D _k,						\
> +}
> +
>  /**
>   * struct rockchip_clk_provider - information about clock provider
>   * @reg_base: virtual address for the register base.
> @@ -288,6 +299,13 @@ struct rockchip_pll_rate_table {
>  			unsigned int dsmpd;
>  			unsigned int frac;
>  		};
> +		struct {
> +			/* for RK3588 */
> +			unsigned int m;
> +			unsigned int p;
> +			unsigned int s;
> +			unsigned int k;
> +		};
>  	};
>  };
> =20
> --=20
> 2.35.1
>=20
>=20

