Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2274E6BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353505AbiCYBMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbiCYBMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D5FB0A44;
        Thu, 24 Mar 2022 18:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AAC61884;
        Fri, 25 Mar 2022 01:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03173C340EC;
        Fri, 25 Mar 2022 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648170637;
        bh=E6OmgAah0QJu1/4fu15UUprCEkyb3mfwZl0885ms9kw=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=UG76NRnF/m59E98ovMv8r0IOA7zSdyw8YjEcxMOJora8IgnmmlOSqxNp3GXMV5vLg
         Lze+t0R47kbdxggrj347fYqknJvk/Yufj7AnLDJnrN/3oRtubbdvGWe+N0SmTtjXu2
         UJkmn8xB/RX5VJHsNjtVrcgBngC6l/pYgQOuFBg5hJW0ZDyRYv0mlohteYItjNCxc6
         Lc8PRvo6qaKmKnhiZ1iWgosKKDYovJrknO85Uaq3pw7byc6KSDFcaxDiegRFCDerkn
         wLb1FgWQI6JsP33ckUa1ryQvNe6IpAE20rcPrQnAo6r6ihbx7ATlSAO3a2FUzR5ll3
         Af8h2UU7ByMuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-4-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:10:35 -0700
User-Agent: alot/0.10
Message-Id: <20220325011037.03173C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:33)
> PXO_SRC is currently defined in the gcc include and referenced in the
> ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
> panic if a driver starts to actually use it.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

What is this patch about? clk providers shouldn't be calling clk_get().

>  drivers/clk/qcom/gcc-ipq806x.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806=
x.c
> index 27f6d7626abb..7271d3afdc89 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -26,6 +26,8 @@
>  #include "clk-hfpll.h"
>  #include "reset.h"
> =20
> +static struct clk_regmap pxo =3D { };
> +
>  static struct clk_pll pll0 =3D {
>         .l_reg =3D 0x30c4,
>         .m_reg =3D 0x30c8,
> @@ -2754,6 +2756,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk =3D {
>  };
> =20
>  static struct clk_regmap *gcc_ipq806x_clks[] =3D {
> +       [PXO_SRC] =3D NULL,
>         [PLL0] =3D &pll0.clkr,
>         [PLL0_VOTE] =3D &pll0_vote,
>         [PLL3] =3D &pll3.clkr,
> @@ -3083,6 +3086,10 @@ static int gcc_ipq806x_probe(struct platform_devic=
e *pdev)
>         if (ret)
>                 return ret;
> =20
> +       clk =3D clk_get(dev, "pxo");
> +       pxo.hw =3D *__clk_get_hw(clk);
> +       gcc_ipq806x_clks[PXO_SRC] =3D &pxo;
> +
>         regmap =3D dev_get_regmap(dev, NULL);
>         if (!regmap)
>                 return -ENODEV;
> --=20
> 2.34.1
>
