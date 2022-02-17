Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC34BAD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiBQXGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:06:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBQXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:06:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094D10A7C1;
        Thu, 17 Feb 2022 15:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8159B8236F;
        Thu, 17 Feb 2022 23:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B95FC340E8;
        Thu, 17 Feb 2022 23:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645139154;
        bh=RA6FMwHfb2jUYRMIbeE8rCAw28fKE4qG6r2ViJuNcNY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NnCFHA9csJlg4okOXjALKDliRQMBMt/JGA1iojgz1gn0Wvso0K/Ghl4n87vtS6rIr
         oUS250FynHBkmRlaPdh3nKiReqd574T1pnhn0JxuZmy7Y8iGLkae1RQ5B8K58JhPMz
         Pm/ljPZp3qhN57dYCUDLLBv0UPWJUhQcWhRbHLrad2gaFhzWfcQasNTlbYHBiCQHUH
         T/9/TDzNEDEahnnPz4zVmEz4BW0HqsCWj0G2Jj8YMYlbyNOWjNVZZzKoWlW3LoF9u0
         OMDa3v61lJFP/O05vNY47C6FUi01PTCxUR2fMDERs+XIkrGI48gZxzEJr0x0imLg3D
         ht5RRXcFWttTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220202172540.2458-1-tdas@codeaurora.org>
References: <20220202172540.2458-1-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 15:05:52 -0800
User-Agent: alot/0.10
Message-Id: <20220217230554.6B95FC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-02 09:25:39)
> The current implementation does not check for D value is within
> the accepted range for a given M & N value. Update the logic to
> calculate the final D value based on the range.

Is this fixing any SoC that's supported now? Or is it future work? This
is important to know if this needs to be merged this week or next merge
window.

>=20
> Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
> * Split the patch and update the Fixes tag.
>=20
>  drivers/clk/qcom/clk-rcg2.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..34251ec98def 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -264,7 +264,7 @@ static int clk_rcg2_determine_floor_rate(struct clk_h=
w *hw,
>=20
>  static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f)
>  {
> -       u32 cfg, mask;
> +       u32 cfg, mask, d_val, not2d_val;
>         struct clk_hw *hw =3D &rcg->clkr.hw;
>         int ret, index =3D qcom_find_src_index(hw, rcg->parent_map, f->sr=
c);
>=20
> @@ -283,8 +283,18 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg=
, const struct freq_tbl *f)
>                 if (ret)
>                         return ret;
>=20
> +               /* Calculate 2d value */
> +               d_val =3D f->n;
> +
> +               if (d_val > ((f->n - f->m) * 2))

Please make another local variable for (f->n - f->m) * 2

	u32 n_minus_m;

	...

	n_minus_m =3D f->n - f->m;
	n_minus_m *=3D 2;

	d_val =3D clamp(d_val, f->m, n_minus_m);
	not2d_val =3D ~d_val & mask;

would be better than if else logic because the types are all verified to
be compatible.

> +                       d_val =3D (f->n - f->m) * 2;
> +               else if (d_val < f->m)
> +                       d_val =3D f->m;
> +
> +               not2d_val =3D ~d_val & mask;
> +
>                 ret =3D regmap_update_bits(rcg->clkr.regmap,
> -                               RCG_D_OFFSET(rcg), mask, ~f->n);
> +                               RCG_D_OFFSET(rcg), mask, not2d_val);
>                 if (ret)
>                         return ret;
