Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13444593C58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiHOTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344348AbiHOTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E030F58;
        Mon, 15 Aug 2022 11:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E606761200;
        Mon, 15 Aug 2022 18:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4210EC43470;
        Mon, 15 Aug 2022 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660589155;
        bh=UIRaZA/DpTd04gsmK1eWGhx14sd8ik48o9o03i9sgek=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V8+PW0FogmjITLRkekPhsAo5MnW06luA/9yClkrXgsO35ZuMSzs4MwsWq8l3sxxR+
         OF9vWhT71PG1XhQDejrVY4IXIyNlTTPGtH54sk+wjIPX+4sMWaULxqs6Y+i2LpBSpi
         1IKUxoKSlXyD9QoRy+IMnjmATwUVMey/GJ5j9Xeh0S+QDIjX68PWb19Y3mC8dhLEN8
         DVMVbZ+ELv7Zo3XzxxO4nimBoFgO+Cy2jNEe392nhtNm4afdt+/KCnjOIoiMDPIQLT
         t0Tq+DfJNG13Cy8FxtCl3t1pXY/Itjx8KBIRK4A3nbT4JkJMDdFz9IMRuZ+sNVWu55
         fuLNNXPKqlVNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220811042855.3867774-3-bjorn.andersson@linaro.org>
References: <20220811042855.3867774-1-bjorn.andersson@linaro.org> <20220811042855.3867774-3-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: Add SC8280XP GPU clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 15 Aug 2022 11:45:53 -0700
User-Agent: alot/0.10
Message-Id: <20220815184555.4210EC43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-08-10 21:28:55)
> diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-s=
c8280xp.c
> new file mode 100644
> index 000000000000..555fd4ff58ab
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sc8280xp.c
> @@ -0,0 +1,460 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>

include kernel.h for ARRAY_SIZE please.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "reset.h"
> +#include "gdsc.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +       DT_BI_TCXO,
> +       DT_GCC_GPU_GPLL0_CLK_SRC,
> +       DT_GCC_GPU_GPLL0_DIV_CLK_SRC,
> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_GCC_GPU_GPLL0_CLK_SRC,
> +       P_GCC_GPU_GPLL0_DIV_CLK_SRC,
> +       P_GPU_CC_PLL0_OUT_MAIN,
> +       P_GPU_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct clk_parent_data parent_data_tcxo =3D { .index =3D DT=
_BI_TCXO };
> +
> +static const struct pll_vco lucid_5lpe_vco[] =3D {
> +       { 249600000, 1800000000, 0 },
> +};
> +
> +static struct alpha_pll_config gpu_cc_pll0_config =3D {
> +       .l =3D 0x1c,
> +       .alpha =3D 0xa555,
> +       .config_ctl_val =3D 0x20485699,
> +       .config_ctl_hi_val =3D 0x00002261,
> +       .config_ctl_hi1_val =3D 0x2a9a699c,
> +       .test_ctl_val =3D 0x00000000,
> +       .test_ctl_hi_val =3D 0x00000000,
> +       .test_ctl_hi1_val =3D 0x01800000,
> +       .user_ctl_val =3D 0x00000000,
> +       .user_ctl_hi_val =3D 0x00000805,
> +       .user_ctl_hi1_val =3D 0x00000000,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0 =3D {
> +       .offset =3D 0x0,
> +       .vco_table =3D lucid_5lpe_vco,
> +       .num_vco =3D ARRAY_SIZE(lucid_5lpe_vco),
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){

const?

> +                       .name =3D "gpu_cc_pll0",
> +                       .parent_data =3D &parent_data_tcxo,
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_lucid_5lpe_ops,
> +               },
> +       },
> +};
