Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B250ADED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443483AbiDVCq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbiDVCqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56A4C787;
        Thu, 21 Apr 2022 19:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60CD861924;
        Fri, 22 Apr 2022 02:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4681C385A5;
        Fri, 22 Apr 2022 02:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650595411;
        bh=M7eCpy1YM/FZZkPtnY1nuvZ9kmH7octKYQQT4/LloXQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YEj9tQRoB951sXaa6rYu1shr5AHRFpRcdYMwsRj110RQ9b8QuWPC2i4/ADpxxZKZb
         tMR3XQlBFgSUHsbsUQQrrjL8VduQ+eW6XA8q1CE1yaZ0Pbr9GPm3JaD0wyeBifwSA8
         wd6kbJZ8P9aj5V/fyZ9WukapYsdRiUPD1D38oEByxSVr6j54vWqDFm/xzCaH+y2XXb
         UB1GocLy3rdMvexOZrO8kJJHR5BqabBBDMLv6S9zwziccb6ptC1oQ7stkU14OjTQLP
         JGKOpUDJyU3jo2526XVWirQpvAYx7KS3EaditjiK1HQBr3CuzxSfjxVAgci5myhutK
         Yp0QYhjWNxk/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220421031849.454626-1-bjorn.andersson@linaro.org>
References: <20220421031849.454626-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Amit Nischal <anischal@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Thu, 21 Apr 2022 19:43:29 -0700
User-Agent: alot/0.10
Message-Id: <20220422024331.B4681C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-20 20:18:49)
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. For this, and similar, purposes the
> "shared RCGs" will park the RCG on a source clock which is known to be
> available.
> When the RCG is parked, a safe clock source will be selected and
> committed, then the original source would be written back and upon enable
> the change back to the unparked source would be committed.
>=20
> But starting with SM8350 this fails, as the value in CFG is committed by
> the GDSC handshake and without a ticking parent the GDSC enablement will
> time out.
>=20
> This becomes a concrete problem if the runtime supended state of a
> device includes disabling such rcg's parent clock. As the device
> attempts to power up the domain again the rcg will fail to enable and
> hence the GDSC enablement will fail, preventing the device from
> returning from the suspended state.
>=20
> This can be seen in e.g. the display stack during probe on SM8350.
>=20
> To avoid this problem, the software needs to ensure that the RCG is
> configured to a active parent clock while it is disabled. This is done
> by caching the CFG register content while the shared RCG is parked on
> this safe source.
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

Taniya, can you please review?

>=20
> Changes since v2:
> - Explained the symptoms in commit message
> - Reduced error in clk_rcg2_get_parent() to pr_debug()
> - Reduced the size of the change in __clk_rcg2_configure()
> - Polished comment in clk_rcg2_shared_set_rate()
> - Use clk_hw_is_enabled() in clk_rcg2_shared_set_parent()
>=20
>  drivers/clk/qcom/clk-rcg.h  |   2 +
>  drivers/clk/qcom/clk-rcg2.c | 124 ++++++++++++++++++++++++++++--------
>  2 files changed, 100 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 00cea508d49e..012e745794fd 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -140,6 +140,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
>   * @freq_tbl: frequency table
>   * @clkr: regmap clock handle
>   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> + * @parked_cfg: cached value of the CFG register for parked RCGs
>   */
>  struct clk_rcg2 {
>         u32                     cmd_rcgr;
> @@ -150,6 +151,7 @@ struct clk_rcg2 {
>         const struct freq_tbl   *freq_tbl;
>         struct clk_regmap       clkr;
>         u8                      cfg_off;
> +       u32                     parked_cfg;
>  };
> =20
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg=
2, clkr)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index f675fd969c4d..9d218b04aa49 100644
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
> +               pr_debug("%s: Unable to read CFG register for %s\n",
> +                        __func__, clk_hw_get_name(hw));
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
> @@ -262,7 +281,8 @@ static int clk_rcg2_determine_floor_rate(struct clk_h=
w *hw,
>         return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
>  }
> =20
> -static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f)
> +static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f,
> +                               u32 *_cfg)
>  {
>         u32 cfg, mask, d_val, not2d_val, n_minus_m;
>         struct clk_hw *hw =3D &rcg->clkr.hw;
> @@ -304,15 +324,27 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rc=
g, const struct freq_tbl *f)
>         cfg |=3D rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
>         if (rcg->mnd_width && f->n && (f->m !=3D f->n))
>                 cfg |=3D CFG_MODE_DUAL_EDGE;
> -       return regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
> -                                       mask, cfg);
> +
> +       *_cfg &=3D ~mask;
> +       *_cfg |=3D cfg;
> +
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
> @@ -979,11 +1011,12 @@ static int clk_rcg2_shared_set_rate(struct clk_hw =
*hw, unsigned long rate,
>                 return -EINVAL;
> =20
>         /*
> -        * In case clock is disabled, update the CFG, M, N and D registers
> -        * and don't hit the update bit of CMD register.
> +        * In case clock is disabled, update the M, N and D registers, ca=
che
> +        * the CFG value in parked_cfg and don't hit the update bit of CMD
> +        * register.
>          */
>         if (!__clk_is_enabled(hw->clk))
> -               return __clk_rcg2_configure(rcg, f);
> +               return __clk_rcg2_configure(rcg, f, &rcg->parked_cfg);
> =20
>         return clk_rcg2_shared_force_enable_clear(hw, f);
>  }
> @@ -1007,6 +1040,11 @@ static int clk_rcg2_shared_enable(struct clk_hw *h=
w)
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
> @@ -1017,13 +1055,12 @@ static int clk_rcg2_shared_enable(struct clk_hw *=
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
> @@ -1041,17 +1078,52 @@ static void clk_rcg2_shared_disable(struct clk_hw=
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
> +       if (!clk_hw_is_enabled(hw)) {
> +               rcg->parked_cfg &=3D ~CFG_SRC_SEL_MASK;
> +               rcg->parked_cfg |=3D rcg->parent_map[index].cfg << CFG_SR=
C_SEL_SHIFT;
> +
> +               return 0;
> +       }
> +
> +       return clk_rcg2_set_parent(hw, index);
> +}
> +
> +static unsigned long
> +clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       /* If the shared rcg is parked used the cached cfg instead */
> +       if (!__clk_is_enabled(hw->clk))
> +               return __clk_rcg2_recalc_rate(hw, parent_rate, rcg->parke=
d_cfg);
> +
> +       return clk_rcg2_recalc_rate(hw, parent_rate);
>  }
> =20
>  const struct clk_ops clk_rcg2_shared_ops =3D {
>         .enable =3D clk_rcg2_shared_enable,
>         .disable =3D clk_rcg2_shared_disable,
> -       .get_parent =3D clk_rcg2_get_parent,
> -       .set_parent =3D clk_rcg2_set_parent,
> -       .recalc_rate =3D clk_rcg2_recalc_rate,
> +       .get_parent =3D clk_rcg2_shared_get_parent,
> +       .set_parent =3D clk_rcg2_shared_set_parent,
> +       .recalc_rate =3D clk_rcg2_shared_recalc_rate,
>         .determine_rate =3D clk_rcg2_determine_rate,
>         .set_rate =3D clk_rcg2_shared_set_rate,
>         .set_rate_and_parent =3D clk_rcg2_shared_set_rate_and_parent,
> --=20
> 2.35.1
>
