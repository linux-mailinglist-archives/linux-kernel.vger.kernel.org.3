Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D34C38B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiBXW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiBXW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:27:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4EB12CD;
        Thu, 24 Feb 2022 14:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E93161B2A;
        Thu, 24 Feb 2022 22:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1867C340E9;
        Thu, 24 Feb 2022 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645741625;
        bh=mh9q6q9DUWGy048lBsddQQM4s5VhNGTnLedJDttJKgc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JIX9RfgdhS6V8kEznUTs4SbwqzHe/501uzLpMIIytlzW8dPBC4wOZlh3AL+aGSGAB
         MkC2MKWDps7g8HA5dwMfQrI22Kk1Ox7QQ3Qjw4HsripcXqTpsfIKh88QLqmrTDwboH
         bBoXYEa/MoEBZ46A9uXUHm2O2FsOAgpmXxCnrc+bBhcGeP0NpLV8vp5mWyb9IK5lG2
         10ySpBhJaxiKBtW3Xe6yiJLRlfHAO5XiWTNsAR3WVfHn2U7ENtUuurML2ilzjaKRsJ
         OPo9/GdnRdqSi78222yL+9gWxbQtNgyMZIh8lzyNrzhHDWKjf7HS2De6o/lMNdsWI8
         qTHans8S2k33A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220221181322.5486-1-tdas@codeaurora.org>
References: <20220221181322.5486-1-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 24 Feb 2022 14:27:03 -0800
User-Agent: alot/0.10
Message-Id: <20220224222705.C1867C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-21 10:13:21)
> The display pixel clock has a requirement on certain newer platforms to
> support M/N as (2/3) and the final D value calculated results in
> underflow errors.
> As the current implementation does not check for D value is within
> the accepted range for a given M & N value. Update the logic to
> calculate the final D value based on the range.
>=20
> Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  [v2]
>    * Update the if else check with clamp.
>    * Typecast the f->m to u32.
>=20
>  drivers/clk/qcom/clk-rcg2.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..3a78a2a16cf8 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -264,7 +264,7 @@ static int clk_rcg2_determine_floor_rate(struct clk_h=
w *hw,
>=20
>  static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f)
>  {
> -       u32 cfg, mask;
> +       u32 cfg, mask, d_val, not2d_val, n_minus_m;
>         struct clk_hw *hw =3D &rcg->clkr.hw;
>         int ret, index =3D qcom_find_src_index(hw, rcg->parent_map, f->sr=
c);
>=20
> @@ -283,8 +283,17 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg=
, const struct freq_tbl *f)
>                 if (ret)
>                         return ret;
>=20
> +               /* Calculate 2d value */
> +               d_val =3D f->n;
> +
> +               n_minus_m =3D f->n - f->m;
> +               n_minus_m *=3D 2;
> +
> +               d_val =3D clamp(d_val, (u32)f->m, n_minus_m);

Use clamp_t(u32, d_val, f->m, n_minus_m)

> +               not2d_val =3D ~d_val & mask;
> +
>                 ret =3D regmap_update_bits(rcg->clkr.regmap,
> -                               RCG_D_OFFSET(rcg), mask, ~f->n);
> +                               RCG_D_OFFSET(rcg), mask, not2d_val);
>                 if (ret)
