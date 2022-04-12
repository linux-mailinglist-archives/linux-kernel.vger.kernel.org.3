Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8827B4FE847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiDLS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiDLS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043E19C2D;
        Tue, 12 Apr 2022 11:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C6E61B60;
        Tue, 12 Apr 2022 18:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC9C385A5;
        Tue, 12 Apr 2022 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649789804;
        bh=QZO61uAR+J5ahnsJ1BjgdII5wLkBSWqULlpcKIuOXLg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X1p2L8rfzOCvbll7wtimC+k8bW8msoW2cI9Fuw7SuQJgZJtvoalp0J8gnGduNFFpm
         EglXrJ9DJOs82ihPwKL55H6ezDOuXjtP+mSCirwYEgC/GIbho1urCKQVVwHIk0ND4a
         ii6e4w0Yd5Pj2X+O2UjS4m7F9HTTNLQQlRQmxs+evpo1dZY3A2TOOUpmZ5inHQszMX
         ZUnDP0EUYkjVrOTKrOXnwfvdlHn2h2aGBnug8KATQPHohzMUdYub3TvewBQ9A473J3
         +alrRFgtAGzxEglu7od6CJYDju8mYfDAqyuwA2jffGVYlaBYxU89iHgP8e+cuQbdAA
         X8erxqWBR14ag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220308040348.1340405-1-bjorn.andersson@linaro.org>
References: <20220308040348.1340405-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Amit Nischal <quic_anischal@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Tue, 12 Apr 2022 11:56:42 -0700
User-Agent: alot/0.10
Message-Id: <20220412185644.2EEC9C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I "quicified" the codeaurora emails, let's hope it worked.

Quoting Bjorn Andersson (2022-03-07 20:03:48)
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. For this, and similar, purposes the
> "shared RCGs" will park the RCG on a source clock which is known to be
> available.
> When the RCG is parked, a safe clock source will be selected and
> committed, then the original source would be written back and upon enable
> the change back to the unparked source would be committed.
>=20
> But starting with SM8350 this fails, as the value in CFG is committed by
> the GDSC handshake and without a valid parent the GDSC enablement will
> fail.

Does this lead to boot problems? Or some driver failing to work? More
details on severity here please.

>=20
> To avoid this problem, the software needs to cache the CFG register
> content while the shared RCG is parked.
>=20
> Writes to M, N and D registers are committed as they are requested. New
> helpers for get_parent() and recalc_rate() are extracted from their
> previous implementations and __clk_rcg2_configure() is modified to allow
> it to operate on the cached value.
>=20
> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as n=
eeded")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Minor nits mostly. Thanks for taking the cfg caching approach. I think
we want to take this for clk-fixes if it is serious enough so I can
merge the next version directly.

>=20
> Changes since v1:
> - Rather than caching the last requested freqnecy, cache and update the C=
FG
>   register value while the shared RCG is disabled.
> - Use/modify the cached RCG value in get_parent(), set_parent() and
>   recalc_rate() for parked shared RCGs as well.
> - Rewrote the commit message.
>=20
>  drivers/clk/qcom/clk-rcg.h  |   2 +
>  drivers/clk/qcom/clk-rcg2.c | 134 +++++++++++++++++++++++++++---------
>  2 files changed, 104 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 99efcc7f8d88..7bcbda8e4f17 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
>   * @freq_tbl: frequency table
>   * @clkr: regmap clock handle
>   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> + * @parked_cfg: cached value of the CFG register for parked RCGs
>   */
>  struct clk_rcg2 {
>         u32                     cmd_rcgr;
> @@ -149,6 +150,7 @@ struct clk_rcg2 {
>         const struct freq_tbl   *freq_tbl;
>         struct clk_regmap       clkr;
>         u8                      cfg_off;
> +       u32                     parked_cfg;
>  };
> =20
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg=
2, clkr)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..8e3aebb72191 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -73,16 +73,11 @@ static int clk_rcg2_is_enabled(struct clk_hw *hw)
>         return (cmd & CMD_ROOT_OFF) =3D=3D 0;
>  }
> =20
> -static u8 clk_rcg2_get_parent(struct clk_hw *hw)
> +static u8 __clk_rcg2_get_parent(struct clk_hw *hw, u32 cfg)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
>         int num_parents =3D clk_hw_get_num_parents(hw);
> -       u32 cfg;
> -       int i, ret;
> -
> -       ret =3D regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> -       if (ret)
> -               goto err;
> +       int i;
> =20
>         cfg &=3D CFG_SRC_SEL_MASK;
>         cfg >>=3D CFG_SRC_SEL_SHIFT;
> @@ -91,12 +86,27 @@ static u8 clk_rcg2_get_parent(struct clk_hw *hw)
>                 if (cfg =3D=3D rcg->parent_map[i].cfg)
>                         return i;
> =20
> -err:
>         pr_debug("%s: Clock %s has invalid parent, using default.\n",
>                  __func__, clk_hw_get_name(hw));
>         return 0;
>  }
> =20
> +static u8 clk_rcg2_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       u32 cfg;
> +       int ret;
> +
> +       ret =3D regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> +       if (ret) {
> +               pr_err("%s: Unable to read CFG register for %s\n",

This used to be the pr_debug() above. Can it still be a pr_debug()?

> +                      __func__, clk_hw_get_name(hw));
> +               return 0;
> +       }
> +
> +       return __clk_rcg2_get_parent(hw, cfg);
> +}
> +
>  static int update_config(struct clk_rcg2 *rcg)
>  {
>         int count, ret;
> @@ -163,12 +173,10 @@ calc_rate(unsigned long rate, u32 m, u32 n, u32 mod=
e, u32 hid_div)
>  }
> =20
>  static unsigned long
> -clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +__clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate, u32=
 cfg)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> -       u32 cfg, hid_div, m =3D 0, n =3D 0, mode =3D 0, mask;
> -
> -       regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> +       u32 hid_div, m =3D 0, n =3D 0, mode =3D 0, mask;
> =20
>         if (rcg->mnd_width) {
>                 mask =3D BIT(rcg->mnd_width) - 1;
> @@ -189,6 +197,17 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned lon=
g parent_rate)
>         return calc_rate(parent_rate, m, n, mode, hid_div);
>  }
> =20
> +static unsigned long
> +clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       u32 cfg;
> +
> +       regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> +
> +       return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
> +}
> +
>  static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq=
_tbl *f,
>                                     struct clk_rate_request *req,
>                                     enum freq_policy policy)
> @@ -262,9 +281,10 @@ static int clk_rcg2_determine_floor_rate(struct clk_=
hw *hw,
>         return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
>  }
> =20
> -static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f)
> +static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f,
> +                               u32 *cfg)
>  {
> -       u32 cfg, mask;
> +       u32 mask;
>         struct clk_hw *hw =3D &rcg->clkr.hw;
>         int ret, index =3D qcom_find_src_index(hw, rcg->parent_map, f->sr=
c);
> =20
> @@ -289,21 +309,31 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rc=
g, const struct freq_tbl *f)
>                         return ret;
>         }
> =20
> -       mask =3D BIT(rcg->hid_width) - 1;
> -       mask |=3D CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK;
> -       cfg =3D f->pre_div << CFG_SRC_DIV_SHIFT;
> -       cfg |=3D rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
> +       *cfg &=3D ~GENMASK(rcg->hid_width - 1, 0);

I'd prefer to not change this in this patch. Name the parameter _cfg and
then assign it at the end? I had to look closely here and things aren't
the same.

> +       *cfg &=3D ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MA=
SK);
> +
> +       *cfg =3D f->pre_div << CFG_SRC_DIV_SHIFT;
> +       *cfg |=3D rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
>         if (rcg->mnd_width && f->n && (f->m !=3D f->n))
> -               cfg |=3D CFG_MODE_DUAL_EDGE;
> -       return regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
> -                                       mask, cfg);
> +               *cfg |=3D CFG_MODE_DUAL_EDGE;
> +

	*_cfg =3D cfg;

> +       return 0;
>  }
> =20
>  static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tb=
l *f)
>  {
> +       u32 cfg;
>         int ret;
> =20
> -       ret =3D __clk_rcg2_configure(rcg, f);
> +       ret =3D regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D __clk_rcg2_configure(rcg, f, &cfg);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), cfg);
>         if (ret)
>                 return ret;
> =20
> @@ -969,11 +999,12 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *=
hw, unsigned long rate,
>                 return -EINVAL;
> =20
>         /*
> -        * In case clock is disabled, update the CFG, M, N and D registers
> -        * and don't hit the update bit of CMD register.
> +        * In case clock is disabled, update the M, N and D registers and=
 cache
> +        * the CFG value in parked_cfg.

We still don't hit the update bit, right?

>          */
> +
>         if (!__clk_is_enabled(hw->clk))
> -               return __clk_rcg2_configure(rcg, f);
> +               return __clk_rcg2_configure(rcg, f, &rcg->parked_cfg);
> =20
>         return clk_rcg2_shared_force_enable_clear(hw, f);
>  }
> @@ -997,6 +1028,11 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>         if (ret)
>                 return ret;
> =20
> +       /* Write back the stored configuration corresponding to current r=
ate */
> +       ret =3D regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, r=
cg->parked_cfg);
> +       if (ret)
> +               return ret;
> +
>         ret =3D update_config(rcg);
>         if (ret)
>                 return ret;
> @@ -1007,13 +1043,12 @@ static int clk_rcg2_shared_enable(struct clk_hw *=
hw)
>  static void clk_rcg2_shared_disable(struct clk_hw *hw)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> -       u32 cfg;
> =20
>         /*
>          * Store current configuration as switching to safe source would =
clear
>          * the SRC and DIV of CFG register
>          */
> -       regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +       regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->park=
ed_cfg);
> =20
>         /*
>          * Park the RCG at a safe configuration - sourced off of safe sou=
rce.
> @@ -1031,17 +1066,52 @@ static void clk_rcg2_shared_disable(struct clk_hw=
 *hw)
>         update_config(rcg);
> =20
>         clk_rcg2_clear_force_enable(hw);
> +}
> =20
> -       /* Write back the stored configuration corresponding to current r=
ate */
> -       regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
> +static u8 clk_rcg2_shared_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       /* If the shared rcg is parked used the cached cfg instead */
> +       if (!__clk_is_enabled(hw->clk))
> +               return __clk_rcg2_get_parent(hw, rcg->parked_cfg);
> +
> +       return clk_rcg2_get_parent(hw);
> +}
> +
> +static int clk_rcg2_shared_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       /* If the shared rcg is parked only update the cached cfg */
> +       if (!__clk_is_enabled(hw->clk)) {

Use clk_hw_is_enabled() please

> +               rcg->parked_cfg &=3D ~CFG_SRC_SEL_MASK;
> +               rcg->parked_cfg |=3D rcg->parent_map[index].cfg << CFG_SR=
C_SEL_SHIFT;
> +
> +               return 0;
> +       }
> +
> +       return clk_rcg2_set_parent(hw, index);
> +}
