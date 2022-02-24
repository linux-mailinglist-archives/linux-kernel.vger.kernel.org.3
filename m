Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306674C3873
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiBXWJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiBXWJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:09:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511028570B;
        Thu, 24 Feb 2022 14:09:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A44961AC6;
        Thu, 24 Feb 2022 22:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C84C340E9;
        Thu, 24 Feb 2022 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740542;
        bh=3YO5uGv0CTYxkDPjKqHsKSg1yIWpGaKpBKUEmyW44ZA=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=RMzOVsyryHJ0yMs+qop/CJm5qDT2uPmEuOVRdgXT7e7hskOgQ3U6pDCzXbWlPW9Ms
         HNMXvsPjV8NVbefatY4h0FoxiCvXh2SzKoBfSrYG8sWsI0ydX+UL1IGihiFTGhhYIz
         j9zm+WykR3Gdr/QPb3Vp5O/yitmTwka6zyVHpk60BzNXyNQAIX77mz2M2T/Zry6joC
         5Aorh6kmTeQBXwJV3C0u4fEdcD2TQeZhs9yMbzmEh/ffcprVFNPQ9jen6kvtXX/m0+
         L/btZ/a81EcfZ9Yd+AZ6SKNNu6uX0C5KxViM9dw8yVwUOpyHZFGub2/2042wDUmgUH
         J5KsvsfMn1sDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-6-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-6-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 05/15] clk: qcom: gcc-ipq806x: convert parent_names to parent_data
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 14:09:00 -0800
User-Agent: alot/0.10
Message-Id: <20220224220901.E1C84C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:21)
> Convert parent_names to parent_data to modernize the driver.
> Where possible use parent_hws directly.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 293 ++++++++++++++++++++-------------
>  1 file changed, 180 insertions(+), 113 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806=
x.c
> index 34cddf461dba..f18888454b4f 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -25,6 +25,11 @@
>  #include "clk-hfpll.h"
>  #include "reset.h"
> =20
> +static const struct clk_parent_data gcc_pxo[] =3D {
> +       { .fw_name =3D "pxo" },
> +       { .name =3D "pxo" },

This is supposed to be one element, not two?

	{ .fw_name =3D "pxo", .name =3D "pxo" }

> +};
> +
>  static struct clk_pll pll0 =3D {
>         .l_reg =3D 0x30c4,
>         .m_reg =3D 0x30c8,
> @@ -259,9 +270,10 @@ static const struct parent_map gcc_pxo_pll8_map[] =
=3D {
>         { P_PLL8, 3 }
>  };
> =20
> -static const char * const gcc_pxo_pll8[] =3D {
> -       "pxo",
> -       "pll8_vote",
> +static const struct clk_parent_data gcc_pxo_pll8[] =3D {
> +       { .fw_name =3D "pxo" },
> +       { .name =3D "pxo" },
> +       { .hw =3D &pll8_vote.hw },
>  };
> =20
>  static const struct parent_map gcc_pxo_pll8_cxo_map[] =3D {
> @@ -270,10 +282,12 @@ static const struct parent_map gcc_pxo_pll8_cxo_map=
[] =3D {
>         { P_CXO, 5 }
>  };
> =20
> -static const char * const gcc_pxo_pll8_cxo[] =3D {
> -       "pxo",
> -       "pll8_vote",
> -       "cxo",
> +static const struct clk_parent_data gcc_pxo_pll8_cxo[] =3D {
> +       { .fw_name =3D "pxo" },
> +       { .name =3D "pxo" },
> +       { .hw =3D &pll8_vote.hw },
> +       { .fw_name =3D "cxo" },
> +       { .name =3D "cxo" },
>  };
> =20
>  static const struct parent_map gcc_pxo_pll3_map[] =3D {
> @@ -286,9 +300,10 @@ static const struct parent_map gcc_pxo_pll3_sata_map=
[] =3D {
>         { P_PLL3, 6 }
>  };
> =20
> -static const char * const gcc_pxo_pll3[] =3D {
> -       "pxo",
> -       "pll3",
> +static const struct clk_parent_data gcc_pxo_pll3[] =3D {
> +       { .fw_name =3D "pxo" },
> +       { .name =3D "pxo" },
> +       { .hw =3D &pll3.clkr.hw },
>  };
> =20
>  static const struct parent_map gcc_pxo_pll8_pll0_map[] =3D {
> @@ -297,10 +312,11 @@ static const struct parent_map gcc_pxo_pll8_pll0_ma=
p[] =3D {
>         { P_PLL0, 2 }
>  };
> =20
> -static const char * const gcc_pxo_pll8_pll0[] =3D {
> -       "pxo",
> -       "pll8_vote",
> -       "pll0_vote",
> +static const struct clk_parent_data gcc_pxo_pll8_pll0[] =3D {
> +       { .fw_name =3D "pxo" },
> +       { .name =3D "pxo" },

Same comment for these ones

> +       { .hw =3D &pll8_vote.hw },
> +       { .hw =3D &pll0_vote.hw },
>  };
