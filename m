Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3247678F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhLPBvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:51:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59630 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:51:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBCE4B8226F;
        Thu, 16 Dec 2021 01:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD3C36AE1;
        Thu, 16 Dec 2021 01:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639619496;
        bh=KK2PCJcQ7/7Byemi7xyIPz+xoe33j+VFfkbiyGQPARM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f3defKgWisUy4hgonbQccfiHiru2wDolSQZ2lMO8IcXbwKS0CzlFONzt1DKwkTkOe
         sAzE/ZUhiOKvVGpR/T0TS6TAyrXIfIlAss5DjPcgWRsNxqM2AifybPhY2rFWpuq7r4
         GcMpj50E/eqc47U5+AltRcSpdxtKQXMEsnwoZ9ppabM/LMHoI+efFG2N8huqB5HIug
         9e+GBheH/SmbuMesh8dBVaQekajmGqSC473a1yfeVljWZtQCBbsW9CN5lxxr7FLVZa
         sLT5KfNY2X376yjhQbAg3ZOqKoMYkC3F1NBB8vRanWcFK/cigst/XT+qweb6MZzSPF
         8d9cP3mlkupqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Amit Nischal <anischal@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 15 Dec 2021 17:51:35 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216015136.96AD3C36AE1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-02 19:56:01)
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. Failure to enable these clocks seems
> to have been silently ignored in the past, but starting in SM8350 this
> failure will prevent the GDSC to turn on.
>=20
> At least on SM8350 this operation will enable the RCG per the
> configuration in CFG_REG. This means that the current model where the
> current configuration is written back to CF_REG immediately after
> parking the RCG doesn't work.

Just to clarify, is the RCG off and "parked" at XO with the config
register dirty and set to the desired frequency and then the RCG is
turned on by the GDSC?

>=20
> Instead, keep track of the currently requested rate of the clock and
> upon enabling the clock reapply the configuration per the saved rate.

We already keep track of the requested rate and reapply it on enable,
just we're lazy and stash that information in the hardware and not the
software. I didn't think the gdsc would be turned on and ruin that all,
but it's fair.

>=20
> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as n=
eeded")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/clk-rcg.h  |  2 ++
>  drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 99efcc7f8d88..6939f4e62768 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
>   * @freq_tbl: frequency table
>   * @clkr: regmap clock handle
>   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> + * @current_rate: cached rate for parked RCGs
>   */
>  struct clk_rcg2 {
>         u32                     cmd_rcgr;
> @@ -149,6 +150,7 @@ struct clk_rcg2 {
>         const struct freq_tbl   *freq_tbl;
>         struct clk_regmap       clkr;
>         u8                      cfg_off;
> +       unsigned long           current_rate;
>  };
> =20
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg=
2, clkr)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..b574b38dcbd5 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long=
 parent_rate)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
>         u32 cfg, hid_div, m =3D 0, n =3D 0, mode =3D 0, mask;
> +       unsigned long rate;
> =20
>         regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> =20
> @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned lon=
g parent_rate)
>         hid_div =3D cfg >> CFG_SRC_DIV_SHIFT;
>         hid_div &=3D mask;
> =20
> -       return calc_rate(parent_rate, m, n, mode, hid_div);
> +       rate =3D calc_rate(parent_rate, m, n, mode, hid_div);
> +       if (!rcg->current_rate)
> +               rcg->current_rate =3D rate;

Instead of doing this in recalc_rate, all the time, why not make an init
clk op that does it once during registration? The other problem I see is
that the rate we calculate may be wrong if the parent is registered
after this clk. I think this came up originally when the patch this is
fixing was discussed.

So instead of saving the current_rate can we save the cfg register value
(or however many registers we need) to put back the frequency of the clk
to what we want on enable? The other thing is that we made recalc_rate()
work "seamlessly" here by stashing the frequency into the register but
leaving it uncommitted until enable. We may need to now look at the
software copy of the registers in the shared rcg recalc rate operation
to figure out what the frequency is.

> +
> +       return rate;
>  }
> =20
>  static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq=
_tbl *f,
> @@ -968,12 +973,14 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *=
hw, unsigned long rate,
>         if (!f)
>                 return -EINVAL;
> =20
> +       rcg->current_rate =3D rate;
> +
>         /*
> -        * In case clock is disabled, update the CFG, M, N and D registers
> -        * and don't hit the update bit of CMD register.
> +        * In the case that the shared RCG is parked, current_rate will be
> +        * applied as the clock is unparked again, so just return here.
>          */
>         if (!__clk_is_enabled(hw->clk))
> -               return __clk_rcg2_configure(rcg, f);
> +               return 0;
> =20
>         return clk_rcg2_shared_force_enable_clear(hw, f);
>  }
> @@ -987,8 +994,13 @@ static int clk_rcg2_shared_set_rate_and_parent(struc=
t clk_hw *hw,
>  static int clk_rcg2_shared_enable(struct clk_hw *hw)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       const struct freq_tbl *f =3D NULL;

Do not assign a value to a variable

>         int ret;
> =20
> +       f =3D qcom_find_freq(rcg->freq_tbl, rcg->current_rate);

and then assign it again without testing it before.

> +       if (!f)
> +               return -EINVAL;
> +
>         /*
>          * Set the update bit because required configuration has already
