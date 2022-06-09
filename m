Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC17544CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbiFIM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343647AbiFIM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:58:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0FF2DCF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:58:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so2941403plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/EKJBE7qLr4649V+UyMOClIIGIMepC1q22NqdO65sM=;
        b=gpNBnKag/x0OKxtZVG4rW5kONo5y1ZyUhp1qePOt5Zhp7vcwZi9HdnYIsB/YqdFPjw
         Hl0tqR7cbnzcqQpaaFwqnjUy+qzuwvSP6bsCP5ZWaIGZDFknwvQSfrgMfsxze6CUYqEX
         nd/VYBJg9EBN1W2rvLi7Ecd6nBQbOwWwHG8uXJGw7UcaRWXi1BggC0dSkUQxmzk1GENt
         /SfrPkZvJ5I1+mUFAkQ7AkwlsW0tYt6Wck2Ih5/KOtKhGq8cLk+vXlGB9rRRuMqSMuMl
         hJd551/gn0C3b3ndSLkK6GbgGOTbDD6/29XTAvs6szN+3F66eLIr2dGf4ShZMGeW3JJ+
         aEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/EKJBE7qLr4649V+UyMOClIIGIMepC1q22NqdO65sM=;
        b=hwns0GhR97/oWNh5eJX/7FLVa2Dj2qeFaArZ56vtukPPKB2stBEkD4lTuk39EhNx1m
         OroQtm/1ehpZqLO0rUAUr2e1fPTB9rX5KLGvPt+Cs5kuawrInxXa6K0ptW0MaX/B9I0r
         7ZzsmTqWE8RF8PVTwkta2rPs/IsvFSZ7YbrzmLV0IDjiq6Ugxu6HzuttCw4TzQHfxbDq
         cVLixU/Ul610kQzw+K/z1E9v9DO8QKnFdIso2DFQ09I8o8iF6vglk8FamJg3UKVXlQwF
         XqGZireIGI1KWTCMSXwSQ47/l4m8/byJCk54j+v/esm3YLVEcjqZTqZVXa3ntC3g+g68
         wugw==
X-Gm-Message-State: AOAM533ecG9FL+uqETjM9l3mXwVaIV9JaZsn7ZhayiQlisr9pcPmZ5cB
        ZMIZnLWcTDnWgGvontswmhrg7+RwnTpyeqCyklfVpg==
X-Google-Smtp-Source: ABdhPJz17NcS4E2JH/wQWlMl3evXLeTrkgwtUa5F7iFXFkGv4OklSWzb496OB+mP3eeCbdf+6aqDc+2ojD0Q4Yepg7k=
X-Received: by 2002:a17:902:f282:b0:164:a74:6236 with SMTP id
 k2-20020a170902f28200b001640a746236mr39836625plc.21.1654779519855; Thu, 09
 Jun 2022 05:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220609092940.304740-1-robert.foss@linaro.org>
 <20220609092940.304740-5-robert.foss@linaro.org> <575874bc-9228-aeb8-5b15-6450577466f5@somainline.org>
In-Reply-To: <575874bc-9228-aeb8-5b15-6450577466f5@somainline.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 9 Jun 2022 14:58:28 +0200
Message-ID: <CAG3jFyuOntup9u0G_VAgDJCzW8G0QCEowE9K9LFw6Ej73GT0bA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] clk: qcom: add support for SM8350 DISPCC
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 12:52, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
> Hi!
>
> On 09/06/2022 11:29, Robert Foss wrote:
> > Add support to the SM8350 display clock controller.
> >
> > While this controller is similar to the sm8250 controller, the differences
> > are incompatible due to the .fw_name / .index change.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> >
> > Changes since v1
> >   - Remove comment - Dmitry
> >
> > Changes since v2
> >   - Add my SoB - Bjorn
> >   - Remove CLK_ASSUME_ENABLED_WHEN_UNUSED flag
> >
> > Changes since v3
> >   - Add kconfig dependency on SM_GCC_8350 - Konrad
> >   - Change hex to lowercase - Konrad
> >   - Split from dispcc-sm8250.c implementation
> >   - Switch from .fw_name to .index
> >
> >
> >   drivers/clk/qcom/Kconfig         |    9 +
> >   drivers/clk/qcom/Makefile        |    1 +
> >   drivers/clk/qcom/dispcc-sm8350.c | 1330 ++++++++++++++++++++++++++++++
> >   3 files changed, 1340 insertions(+)
> >   create mode 100644 drivers/clk/qcom/dispcc-sm8350.c
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index b11235c21952..319812a1d614 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -626,6 +626,15 @@ config SM_DISPCC_8250
> >         Say Y if you want to support display devices and functionality such as
> >         splash screen.
> >
> > +config SM_DISPCC_8350
> > +     tristate "SM8350 Display Clock Controller"
> > +     depends on SM_GCC_8350
> > +     help
> > +       Support for the display clock controller on Qualcomm Technologies, Inc
> > +       SM8350 devices.
> > +       Say Y if you want to support display devices and functionality such as
> > +       splash screen.
> > +
> >   config SM_DISPCC_6350
> >       tristate "SM6350 Display Clock Controller"
> >       depends on SM_GCC_6350
> > diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> > index ef9c64824424..70f98320eb1d 100644
> > --- a/drivers/clk/qcom/Makefile
> > +++ b/drivers/clk/qcom/Makefile
> > @@ -91,6 +91,7 @@ obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
> >   obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
> >   obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
> >   obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
> > +obj-$(CONFIG_SM_DISPCC_8350) += dispcc-sm8350.o
> >   obj-$(CONFIG_SM_GCC_6115) += gcc-sm6115.o
> >   obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
> >   obj-$(CONFIG_SM_GCC_6350) += gcc-sm6350.o
> > diff --git a/drivers/clk/qcom/dispcc-sm8350.c b/drivers/clk/qcom/dispcc-sm8350.c
> > new file mode 100644
> > index 000000000000..269a0512f207
> > --- /dev/null
> > +++ b/drivers/clk/qcom/dispcc-sm8350.c
> > @@ -0,0 +1,1330 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +
> > +#include <dt-bindings/clock/qcom,dispcc-sm8350.h>
> > +
> > +#include "clk-alpha-pll.h"
> > +#include "clk-branch.h"
> > +#include "clk-rcg.h"
> > +#include "clk-regmap-divider.h"
> > +#include "common.h"
> > +#include "gdsc.h"
> > +#include "reset.h"
> > +
> > +/* Need to match the order of clocks in DT binding */
> > +enum {
> > +     DT_BI_TCXO,
> > +     DT_DP_PHY_PLL_LINK_CLK,
> > +     DT_DP_PHY_PLL_VCO_DIV_CLK,
> > +     DT_DPTX1_PHY_PLL_LINK_CLK,
> > +     DT_DPTX1_PHY_PLL_VCO_DIV_CLK,
> > +     DT_DPTX2_PHY_PLL_LINK_CLK,
> > +     DT_DPTX2_PHY_PLL_VCO_DIV_CLK,
> > +     DT_DSI0_PHY_PLL_OUT_BYTECLK,
> > +     DT_DSI0_PHY_PLL_OUT_DSICLK,
> > +     DT_DSI1_PHY_PLL_OUT_BYTECLK,
> > +     DT_DSI1_PHY_PLL_OUT_DSICLK,
> > +     DT_EDP_PHY_PLL_LINK_CLK,
> > +     DT_EDP_PHY_PLL_VCO_DIV_CLK,
> > +};
> > +
> > +enum {
> > +     P_BI_TCXO,
> > +     P_DISP_CC_PLL0_OUT_MAIN,
> > +     P_DISP_CC_PLL1_OUT_EVEN,
> > +     P_DISP_CC_PLL1_OUT_MAIN,
> > +     P_DP_PHY_PLL_LINK_CLK,
> > +     P_DP_PHY_PLL_VCO_DIV_CLK,
> > +     P_DPTX1_PHY_PLL_LINK_CLK,
> > +     P_DPTX1_PHY_PLL_VCO_DIV_CLK,
> > +     P_DPTX2_PHY_PLL_LINK_CLK,
> > +     P_DPTX2_PHY_PLL_VCO_DIV_CLK,
> > +     P_EDP_PHY_PLL_LINK_CLK,
> > +     P_EDP_PHY_PLL_VCO_DIV_CLK,
> > +     P_DSI0_PHY_PLL_OUT_BYTECLK,
> > +     P_DSI0_PHY_PLL_OUT_DSICLK,
> > +     P_DSI1_PHY_PLL_OUT_BYTECLK,
> > +     P_DSI1_PHY_PLL_OUT_DSICLK,
> > +};
> > +
> > +static struct pll_vco vco_table[] = {
> > +     { 249600000, 2000000000, 0 },
> > +};
> > +
> > +static struct pll_vco lucid_5lpe_vco[] = {
> > +     { 249600000, 1750000000, 0 },
> > +};
> > +
> > +static struct alpha_pll_config disp_cc_pll0_config = {
> > +     .l = 0x47,
> > +     .alpha = 0xE000,
> > +     .config_ctl_val = 0x20485699,
> > +     .config_ctl_hi_val = 0x00002261,
> > +     .config_ctl_hi1_val = 0x329A699C,
>
> Lowercase hex please, all around the file

Ack.

>
>
> > +     .user_ctl_val = 0x00000000,
> > +     .user_ctl_hi_val = 0x00000805,
> > +     .user_ctl_hi1_val = 0x00000000,
> > +};
> > +
> > +static struct clk_init_data disp_cc_pll0_init = {
> > +     .name = "disp_cc_pll0",
> > +     .parent_data = &(const struct clk_parent_data){
> > +             .index = DT_BI_TCXO,
> > +     },
> > +     .num_parents = 1,
> > +     .ops = &clk_alpha_pll_lucid_ops,
> > +};
> > +
> > +static struct clk_alpha_pll disp_cc_pll0 = {
> > +     .offset = 0x0,
> > +     .vco_table = vco_table,
> > +     .num_vco = ARRAY_SIZE(vco_table),
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > +     .clkr.hw.init = &disp_cc_pll0_init
> > +};
> > +
> > +static struct alpha_pll_config disp_cc_pll1_config = {
> > +     .l = 0x1F,
> > +     .alpha = 0x4000,
> > +     .config_ctl_val = 0x20485699,
> > +     .config_ctl_hi_val = 0x00002261,
> > +     .config_ctl_hi1_val = 0x329A699C,
> > +     .user_ctl_val = 0x00000000,
> > +     .user_ctl_hi_val = 0x00000805,
> > +     .user_ctl_hi1_val = 0x00000000,
> > +};
> > +
> > +static struct clk_init_data disp_cc_pll1_init = {
> > +     .name = "disp_cc_pll1",
> > +     .parent_data = &(const struct clk_parent_data){
> > +             .index = DT_BI_TCXO,
> > +     },
> > +     .num_parents = 1,
> > +     .ops = &clk_alpha_pll_lucid_ops,
> > +};
> > +
> > +static struct clk_alpha_pll disp_cc_pll1 = {
> > +     .offset = 0x1000,
> > +     .vco_table = vco_table,
> > +     .num_vco = ARRAY_SIZE(vco_table),
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> > +     .clkr.hw.init = &disp_cc_pll1_init
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_0[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DP_PHY_PLL_LINK_CLK, 1 },
> > +     { P_DP_PHY_PLL_VCO_DIV_CLK, 2 },
> > +     { P_DPTX1_PHY_PLL_LINK_CLK, 3 },
> > +     { P_DPTX1_PHY_PLL_VCO_DIV_CLK, 4 },
> > +     { P_DPTX2_PHY_PLL_LINK_CLK, 5 },
> > +     { P_DPTX2_PHY_PLL_VCO_DIV_CLK, 6 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_0[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .index = DT_DP_PHY_PLL_LINK_CLK },
> > +     { .index = DT_DP_PHY_PLL_VCO_DIV_CLK },
> > +     { .index = DT_DPTX1_PHY_PLL_LINK_CLK },
> > +     { .index = DT_DPTX1_PHY_PLL_VCO_DIV_CLK },
> > +     { .index = DT_DPTX2_PHY_PLL_LINK_CLK },
> > +     { .index = DT_DPTX2_PHY_PLL_VCO_DIV_CLK },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_1[] = {
> > +     { P_BI_TCXO, 0 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_1[] = {
> > +     { .index = DT_BI_TCXO },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_2[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
> > +     { P_DSI1_PHY_PLL_OUT_BYTECLK, 2 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_2[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
> > +     { .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_3[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DISP_CC_PLL1_OUT_MAIN, 4 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_3[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .hw = &disp_cc_pll1.clkr.hw },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_4[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_EDP_PHY_PLL_LINK_CLK, 1 },
> > +     { P_EDP_PHY_PLL_VCO_DIV_CLK, 2},
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_4[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .index = DT_EDP_PHY_PLL_LINK_CLK},
> > +     { .index = DT_EDP_PHY_PLL_VCO_DIV_CLK},
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_5[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DISP_CC_PLL0_OUT_MAIN, 1 },
> > +     { P_DISP_CC_PLL1_OUT_MAIN, 4 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_5[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .hw = &disp_cc_pll0.clkr.hw },
> > +     { .hw = &disp_cc_pll1.clkr.hw },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_6[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
> > +     { P_DSI1_PHY_PLL_OUT_DSICLK, 2 },
> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_6[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .index = DT_DSI0_PHY_PLL_OUT_DSICLK },
> > +     { .index = DT_DSI1_PHY_PLL_OUT_DSICLK },
> > +};
> > +
> > +static const struct parent_map disp_cc_parent_map_7[] = {
> > +     { P_BI_TCXO, 0 },
> > +     { P_DISP_CC_PLL1_OUT_MAIN, 4 },
> > +     /* { P_DISP_CC_PLL1_OUT_EVEN, 5 }, */
> Is this and its .hw below commented out on purpose? If so, why?

It's a leftover from dispcc-sm8250, looking closer at this it was
introduced by Bjorn in the below commit.

2ebdd326d1995 - clk: qcom: dispcc-sm8250: Add EDP clocks

Downstream does have this snippet enabled.

https://git.linaro.org/people/robert.foss/linux.git/tree/drivers/clk/qcom/dispcc-lahaina.c?id=5a585e470356af7ab39cbf05274dd9bce9f2f85e#n253

Bjorn: Do you know anything about the snippet being commented out?

> > +};
> > +
> > +static const struct clk_parent_data disp_cc_parent_data_7[] = {
> > +     { .index = DT_BI_TCXO },
> > +     { .hw = &disp_cc_pll1.clkr.hw },
> > +     /* { .hw = &disp_cc_pll1_out_even.clkr.hw }, */
> > +};
> > +
> > +static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
> > +     F(19200000, P_BI_TCXO, 1, 0, 0),
> > +     F(37500000, P_DISP_CC_PLL1_OUT_MAIN, 16, 0, 0),
> > +     F(75000000, P_DISP_CC_PLL1_OUT_MAIN, 8, 0, 0),
> > +     { }
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
> > +     .cmd_rcgr = 0x22bc,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_3,
> > +     .freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_ahb_clk_src",
> > +             .parent_data = disp_cc_parent_data_3,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_shared_ops,
> > +     },
> > +};
> > +
> > +static const struct freq_tbl ftbl_disp_cc_mdss_byte0_clk_src[] = {
> > +     F(19200000, P_BI_TCXO, 1, 0, 0),
> > +     { }
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
> > +     .cmd_rcgr = 0x210c,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_2,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_byte0_clk_src",
> > +             .parent_data = disp_cc_parent_data_2,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_byte2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
> > +     .cmd_rcgr = 0x2128,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_2,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_byte1_clk_src",
> > +             .parent_data = disp_cc_parent_data_2,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_byte2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_aux1_clk_src = {
> > +     .cmd_rcgr = 0x223c,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_1,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_aux1_clk_src",
> > +             .parent_data = disp_cc_parent_data_1,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
> > +     .cmd_rcgr = 0x21d8,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_1,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_aux_clk_src",
> > +             .parent_data = disp_cc_parent_data_1,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_link1_clk_src = {
> > +     .cmd_rcgr = 0x2208,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_0,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_link1_clk_src",
> > +             .parent_data = disp_cc_parent_data_0,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> > +             .ops = &clk_byte2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
> > +     .cmd_rcgr = 0x2174,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_0,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_link_clk_src",
> > +             .parent_data = disp_cc_parent_data_0,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> > +             .ops = &clk_byte2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src = {
> > +     .cmd_rcgr = 0x21c0,
> > +     .mnd_width = 16,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_0,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_pixel1_clk_src",
> > +             .parent_data = disp_cc_parent_data_0,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> > +             .ops = &clk_dp_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_pixel2_clk_src = {
> > +     .cmd_rcgr = 0x21f0,
> > +     .mnd_width = 16,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_0,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_pixel2_clk_src",
> > +             .parent_data = disp_cc_parent_data_0,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> > +             .ops = &clk_dp_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
> > +     .cmd_rcgr = 0x21a8,
> > +     .mnd_width = 16,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_0,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_dp_pixel_clk_src",
> > +             .parent_data = disp_cc_parent_data_0,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> > +             .ops = &clk_dp_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_edp_aux_clk_src = {
> > +     .cmd_rcgr = 0x228c,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_1,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_edp_aux_clk_src",
> > +             .parent_data = disp_cc_parent_data_1,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_edp_gtc_clk_src = {
> > +     .cmd_rcgr = 0x22a4,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_7,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_edp_gtc_clk_src",
> > +             .parent_data = disp_cc_parent_data_7,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_edp_link_clk_src = {
> > +     .cmd_rcgr = 0x2270,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_4,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_edp_link_clk_src",
> > +             .parent_data = disp_cc_parent_data_4,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_byte2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_edp_pixel_clk_src = {
> > +     .cmd_rcgr = 0x2258,
> > +     .mnd_width = 16,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_4,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_edp_pixel_clk_src",
> > +             .parent_data = disp_cc_parent_data_4,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> > +             .ops = &clk_dp_ops,
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_edp_aux_clk = {
> > +     .halt_reg = 0x2078,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2078,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_edp_aux_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_edp_aux_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_edp_gtc_clk = {
> > +     .halt_reg = 0x207c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x207c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_edp_gtc_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_edp_gtc_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_edp_link_clk = {
> > +     .halt_reg = 0x2070,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2070,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_edp_link_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_edp_link_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
> > +     .halt_reg = 0x2074,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2074,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_edp_link_intf_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_edp_link_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_GET_RATE_NOCACHE,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_edp_pixel_clk = {
> > +     .halt_reg = 0x206c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x206c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_edp_pixel_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_edp_pixel_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
> > +     .cmd_rcgr = 0x2144,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_2,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_esc0_clk_src",
> > +             .parent_data = disp_cc_parent_data_2,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
> > +     .cmd_rcgr = 0x2160,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_2,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_esc1_clk_src",
> > +             .parent_data = disp_cc_parent_data_2,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
> > +     F(19200000, P_BI_TCXO, 1, 0, 0),
> > +     F(85714286, P_DISP_CC_PLL1_OUT_MAIN, 7, 0, 0),
> > +     F(100000000, P_DISP_CC_PLL1_OUT_MAIN, 6, 0, 0),
> > +     F(150000000, P_DISP_CC_PLL1_OUT_MAIN, 4, 0, 0),
> > +     F(200000000, P_DISP_CC_PLL1_OUT_MAIN, 3, 0, 0),
> > +     F(300000000, P_DISP_CC_PLL1_OUT_MAIN, 2, 0, 0),
> > +     F(345000000, P_DISP_CC_PLL0_OUT_MAIN, 4, 0, 0),
> > +     F(460000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> > +     { }
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
> > +     .cmd_rcgr = 0x20c4,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_5,
> > +     .freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_mdp_clk_src",
> > +             .parent_data = disp_cc_parent_data_5,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_shared_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
> > +     .cmd_rcgr = 0x2094,
> > +     .mnd_width = 8,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_6,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_pclk0_clk_src",
> > +             .parent_data = disp_cc_parent_data_6,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_pixel_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
> > +     .cmd_rcgr = 0x20ac,
> > +     .mnd_width = 8,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_6,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_pclk1_clk_src",
> > +             .parent_data = disp_cc_parent_data_6,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_pixel_ops,
> > +     },
> > +};
> > +
> > +static const struct freq_tbl ftbl_disp_cc_mdss_rot_clk_src[] = {
> > +     F(19200000, P_BI_TCXO, 1, 0, 0),
> > +     F(200000000, P_DISP_CC_PLL1_OUT_MAIN, 3, 0, 0),
> > +     F(300000000, P_DISP_CC_PLL1_OUT_MAIN, 2, 0, 0),
> > +     F(345000000, P_DISP_CC_PLL0_OUT_MAIN, 4, 0, 0),
> > +     F(460000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
> > +     { }
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
> > +     .cmd_rcgr = 0x20dc,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_5,
> > +     .freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_rot_clk_src",
> > +             .parent_data = disp_cc_parent_data_5,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_shared_ops,
> > +     },
> > +};
> > +
> > +static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
> > +     .cmd_rcgr = 0x20f4,
> > +     .mnd_width = 0,
> > +     .hid_width = 5,
> > +     .parent_map = disp_cc_parent_map_1,
> > +     .freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "disp_cc_mdss_vsync_clk_src",
> > +             .parent_data = disp_cc_parent_data_1,
> > +             .num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> > +             .flags = CLK_SET_RATE_PARENT,
> > +             .ops = &clk_rcg2_ops,
> > +     },
> > +};
> > +
> > +static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
> > +     .reg = 0x2124,
> > +     .shift = 0,
> > +     .width = 4,
> > +     .clkr.hw.init = &(struct clk_init_data) {
> > +             .name = "disp_cc_mdss_byte0_div_clk_src",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &disp_cc_mdss_byte0_clk_src.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_regmap_div_ops,
> > +     },
> > +};
> > +
> > +static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
> > +     .reg = 0x2140,
> > +     .shift = 0,
> > +     .width = 4,
> > +     .clkr.hw.init = &(struct clk_init_data) {
> > +             .name = "disp_cc_mdss_byte1_div_clk_src",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &disp_cc_mdss_byte1_clk_src.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_regmap_div_ops,
> > +     },
> > +};
> > +
> > +static struct clk_regmap_div disp_cc_mdss_dp_link1_div_clk_src = {
> > +     .reg = 0x2220,
> > +     .shift = 0,
> > +     .width = 4,
> > +     .clkr.hw.init = &(struct clk_init_data) {
> > +             .name = "disp_cc_mdss_dp_link1_div_clk_src",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &disp_cc_mdss_dp_link1_clk_src.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_regmap_div_ro_ops,
> > +     },
> > +};
> > +
> > +static struct clk_regmap_div disp_cc_mdss_dp_link_div_clk_src = {
> > +     .reg = 0x218c,
> > +     .shift = 0,
> > +     .width = 4,
> > +     .clkr.hw.init = &(struct clk_init_data) {
> > +             .name = "disp_cc_mdss_dp_link_div_clk_src",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &disp_cc_mdss_dp_link_clk_src.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_regmap_div_ro_ops,
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_ahb_clk = {
> > +     .halt_reg = 0x207c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x207c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_ahb_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_ahb_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_byte0_clk = {
> > +     .halt_reg = 0x2028,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2028,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_byte0_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_byte0_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
> > +     .halt_reg = 0x202c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x202c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_byte0_intf_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_byte0_div_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_byte1_clk = {
> > +     .halt_reg = 0x2030,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2030,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_byte1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_byte1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
> > +     .halt_reg = 0x2034,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2034,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_byte1_intf_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_byte1_div_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_aux1_clk = {
> > +     .halt_reg = 0x2068,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2068,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_aux1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_aux1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_aux_clk = {
> > +     .halt_reg = 0x2054,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2054,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_aux_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_aux_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_link1_clk = {
> > +     .halt_reg = 0x205c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x205c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_link1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_link1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_link1_intf_clk = {
> > +     .halt_reg = 0x2060,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2060,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_link1_intf_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_link1_div_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_link_clk = {
> > +     .halt_reg = 0x2040,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2040,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_link_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_link_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
> > +     .halt_reg = 0x2044,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2044,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_link_intf_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_link_div_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_pixel1_clk = {
> > +     .halt_reg = 0x2050,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2050,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_pixel1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_pixel1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_pixel2_clk = {
> > +     .halt_reg = 0x2058,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2058,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_pixel2_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_pixel2_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_dp_pixel_clk = {
> > +     .halt_reg = 0x204c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x204c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_dp_pixel_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_dp_pixel_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_esc0_clk = {
> > +     .halt_reg = 0x2038,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2038,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_esc0_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_esc0_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_esc1_clk = {
> > +     .halt_reg = 0x203c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x203c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_esc1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_esc1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_mdp_clk = {
> > +     .halt_reg = 0x200c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x200c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_mdp_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_mdp_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
> > +     .halt_reg = 0x201c,
> > +     .halt_check = BRANCH_VOTED,
> > +     .clkr = {
> > +             .enable_reg = 0x201c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_mdp_lut_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_mdp_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
> > +     .halt_reg = 0x4004,
> > +     .halt_check = BRANCH_VOTED,
> > +     .clkr = {
> > +             .enable_reg = 0x4004,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_non_gdsc_ahb_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_ahb_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_pclk0_clk = {
> > +     .halt_reg = 0x2004,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2004,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_pclk0_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_pclk0_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_pclk1_clk = {
> > +     .halt_reg = 0x2008,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2008,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_pclk1_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_pclk1_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_rot_clk = {
> > +     .halt_reg = 0x2014,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2014,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_rot_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_rot_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
> > +     .halt_reg = 0x400c,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x400c,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_rscc_ahb_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_ahb_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
> > +     .halt_reg = 0x4008,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x4008,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_rscc_vsync_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_vsync_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_branch disp_cc_mdss_vsync_clk = {
> > +     .halt_reg = 0x2024,
> > +     .halt_check = BRANCH_HALT,
> > +     .clkr = {
> > +             .enable_reg = 0x2024,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "disp_cc_mdss_vsync_clk",
> > +                     .parent_hws = (const struct clk_hw*[]){
> > +                             &disp_cc_mdss_vsync_clk_src.clkr.hw,
> > +                     },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct gdsc mdss_gdsc = {
> > +     .gdscr = 0x3000,
> > +     .en_rest_wait_val = 0x2,
> > +     .en_few_wait_val = 0x2,
> > +     .clk_dis_wait_val = 0xf,
> > +     .pd = {
> > +             .name = "mdss_gdsc",
> > +     },
> > +     .pwrsts = PWRSTS_OFF_ON,
> > +     .flags = HW_CTRL,
> > +     .supply = "mmcx",
> > +};
> > +
> > +static struct clk_regmap *disp_cc_sm8350_clocks[] = {
> > +     [DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
> > +     [DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
> > +     [DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
> > +     [DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
> > +     [DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
> > +     [DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
> > +     [DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
> > +     [DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
> > +     [DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
> > +     [DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
> > +     [DISP_CC_MDSS_DP_AUX1_CLK] = &disp_cc_mdss_dp_aux1_clk.clkr,
> > +     [DISP_CC_MDSS_DP_AUX1_CLK_SRC] = &disp_cc_mdss_dp_aux1_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_AUX_CLK] = &disp_cc_mdss_dp_aux_clk.clkr,
> > +     [DISP_CC_MDSS_DP_AUX_CLK_SRC] = &disp_cc_mdss_dp_aux_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_LINK1_CLK] = &disp_cc_mdss_dp_link1_clk.clkr,
> > +     [DISP_CC_MDSS_DP_LINK1_CLK_SRC] = &disp_cc_mdss_dp_link1_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_LINK1_DIV_CLK_SRC] = &disp_cc_mdss_dp_link1_div_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_LINK1_INTF_CLK] = &disp_cc_mdss_dp_link1_intf_clk.clkr,
> > +     [DISP_CC_MDSS_DP_LINK_CLK] = &disp_cc_mdss_dp_link_clk.clkr,
> > +     [DISP_CC_MDSS_DP_LINK_CLK_SRC] = &disp_cc_mdss_dp_link_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dp_link_div_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_LINK_INTF_CLK] = &disp_cc_mdss_dp_link_intf_clk.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL1_CLK] = &disp_cc_mdss_dp_pixel1_clk.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL1_CLK_SRC] = &disp_cc_mdss_dp_pixel1_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL2_CLK] = &disp_cc_mdss_dp_pixel2_clk.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL2_CLK_SRC] = &disp_cc_mdss_dp_pixel2_clk_src.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL_CLK] = &disp_cc_mdss_dp_pixel_clk.clkr,
> > +     [DISP_CC_MDSS_DP_PIXEL_CLK_SRC] = &disp_cc_mdss_dp_pixel_clk_src.clkr,
> > +     [DISP_CC_MDSS_EDP_AUX_CLK] = &disp_cc_mdss_edp_aux_clk.clkr,
> > +     [DISP_CC_MDSS_EDP_AUX_CLK_SRC] = &disp_cc_mdss_edp_aux_clk_src.clkr,
> > +     [DISP_CC_MDSS_EDP_GTC_CLK] = &disp_cc_mdss_edp_gtc_clk.clkr,
> > +     [DISP_CC_MDSS_EDP_GTC_CLK_SRC] = &disp_cc_mdss_edp_gtc_clk_src.clkr,
> > +     [DISP_CC_MDSS_EDP_LINK_CLK] = &disp_cc_mdss_edp_link_clk.clkr,
> > +     [DISP_CC_MDSS_EDP_LINK_CLK_SRC] = &disp_cc_mdss_edp_link_clk_src.clkr,
> > +     [DISP_CC_MDSS_EDP_LINK_INTF_CLK] = &disp_cc_mdss_edp_link_intf_clk.clkr,
> > +     [DISP_CC_MDSS_EDP_PIXEL_CLK] = &disp_cc_mdss_edp_pixel_clk.clkr,
> > +     [DISP_CC_MDSS_EDP_PIXEL_CLK_SRC] = &disp_cc_mdss_edp_pixel_clk_src.clkr,
> > +     [DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
> > +     [DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
> > +     [DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
> > +     [DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
> > +     [DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
> > +     [DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
> > +     [DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
> > +     [DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
> > +     [DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
> > +     [DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
> > +     [DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
> > +     [DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
> > +     [DISP_CC_MDSS_ROT_CLK] = &disp_cc_mdss_rot_clk.clkr,
> > +     [DISP_CC_MDSS_ROT_CLK_SRC] = &disp_cc_mdss_rot_clk_src.clkr,
> > +     [DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
> > +     [DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
> > +     [DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
> > +     [DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
> > +     [DISP_CC_PLL0] = &disp_cc_pll0.clkr,
> > +     [DISP_CC_PLL1] = &disp_cc_pll1.clkr,
> > +};
> > +
> > +static const struct qcom_reset_map disp_cc_sm8350_resets[] = {
> > +     [DISP_CC_MDSS_CORE_BCR] = { 0x2000 },
> > +     [DISP_CC_MDSS_RSCC_BCR] = { 0x4000 },
> > +};
> > +
> > +static struct gdsc *disp_cc_sm8350_gdscs[] = {
> > +     [MDSS_GDSC] = &mdss_gdsc,
> > +};
> > +
> > +static const struct regmap_config disp_cc_sm8350_regmap_config = {
> > +     .reg_bits       = 32,
> > +     .reg_stride     = 4,
> > +     .val_bits       = 32,
> > +     .max_register   = 0x10000,
> > +     .fast_io        = true,
> > +};
> > +
> > +static const struct qcom_cc_desc disp_cc_sm8350_desc = {
> > +     .config = &disp_cc_sm8350_regmap_config,
> > +     .clks = disp_cc_sm8350_clocks,
> > +     .num_clks = ARRAY_SIZE(disp_cc_sm8350_clocks),
> > +     .resets = disp_cc_sm8350_resets,
> > +     .num_resets = ARRAY_SIZE(disp_cc_sm8350_resets),
> > +     .gdscs = disp_cc_sm8350_gdscs,
> > +     .num_gdscs = ARRAY_SIZE(disp_cc_sm8350_gdscs),
> > +};
> > +
> > +static const struct of_device_id disp_cc_sm8350_match_table[] = {
> > +     { .compatible = "qcom,sc8180x-dispcc" },
> > +     { .compatible = "qcom,sm8150-dispcc" },
> > +     { .compatible = "qcom,sm8350-dispcc" },
> > +     { .compatible = "qcom,sm8350-dispcc" },
>
> Double 8350 and mis-copied 8180x/8150

D'oh! Thanks for catching this.


>
>
> Konrad
>
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, disp_cc_sm8350_match_table);
> > +
> > +static void disp_cc_sm8350_pm_runtime_disable(void *data)
> > +{
> > +     pm_runtime_disable(data);
> > +}
> > +
> > +static int disp_cc_sm8350_probe(struct platform_device *pdev)
> > +{
> > +     struct regmap *regmap;
> > +     int ret;
> > +
> > +     pm_runtime_enable(&pdev->dev);
> > +
> > +     ret = devm_add_action_or_reset(&pdev->dev, disp_cc_sm8350_pm_runtime_disable, &pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = pm_runtime_resume_and_get(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     regmap = qcom_cc_map(pdev, &disp_cc_sm8350_desc);
> > +     if (IS_ERR(regmap)) {
> > +             pm_runtime_put(&pdev->dev);
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
> > +
> > +     disp_cc_mdss_ahb_clk_src.cmd_rcgr = 0x22a0;
> > +
> > +     disp_cc_pll0_config.config_ctl_hi1_val = 0x2a9a699c;
> > +     disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
> > +     disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> > +     disp_cc_pll0.vco_table = lucid_5lpe_vco;
> > +     disp_cc_pll1_config.config_ctl_hi1_val = 0x2a9a699c;
> > +     disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
> > +     disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> > +     disp_cc_pll1.vco_table = lucid_5lpe_vco;
> > +
> > +     clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> > +     clk_lucid_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
> > +
> > +     /* Enable clock gating for MDP clocks */
> > +     regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
> > +
> > +     /* DISP_CC_XO_CLK always-on */
> > +     regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
> > +
> > +     ret = qcom_cc_really_probe(pdev, &disp_cc_sm8350_desc, regmap);
> > +
> > +     pm_runtime_put(&pdev->dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static struct platform_driver disp_cc_sm8350_driver = {
> > +     .probe = disp_cc_sm8350_probe,
> > +     .driver = {
> > +             .name = "disp_cc-sm8350",
> > +             .of_match_table = disp_cc_sm8350_match_table,
> > +     },
> > +};
> > +
> > +static int __init disp_cc_sm8350_init(void)
> > +{
> > +     return platform_driver_register(&disp_cc_sm8350_driver);
> > +}
> > +subsys_initcall(disp_cc_sm8350_init);
> > +
> > +static void __exit disp_cc_sm8350_exit(void)
> > +{
> > +     platform_driver_unregister(&disp_cc_sm8350_driver);
> > +}
> > +module_exit(disp_cc_sm8350_exit);
> > +
> > +MODULE_DESCRIPTION("QTI DISPCC SM8250 Driver");
> > +MODULE_LICENSE("GPL v2");
