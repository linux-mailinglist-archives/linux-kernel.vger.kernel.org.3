Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7E5654AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiGDMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiGDMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:14:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D06DD4B;
        Mon,  4 Jul 2022 05:14:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r2so9599637qta.0;
        Mon, 04 Jul 2022 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pkWd82LO/ojYDosmwrfm5ZDsGyg9LY0SRgbyRKCeB4=;
        b=C150c99pirZ4/D40yQk0Ir0jTC2u1MZCCaGtystElsE5+GX6CcAWKon6SttbWz5+BG
         1045XiYJ9XPrQT2WuQSf/Iks9uRJP+vVBFvOm8ZnkU8CvE7EMx9xzXYf2kaGHhX+Eq9W
         zE1TAQ17m3u99ABf92XlbfwXrTzOKBU92NOteDWVePyvg2cbjfYzt22ibCJjjXgjPRdM
         cmfQAcpobNU65qaRpfzmeqKfgBUXAsSSriJMzu1JX0+S50xuOE0/LCwd/vnPHCDii21X
         2LOltDBaxAvkC3JXKJeApEAEWHxE5HJoH7be8U8LoPDN+Ndj1PpuUir++KsIBiJS7RkJ
         QirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pkWd82LO/ojYDosmwrfm5ZDsGyg9LY0SRgbyRKCeB4=;
        b=puMjKENNiyL/bJUAsDHFGlZ3x5pjEMBE1h/GLqItN0qCQXzAPr4EXqXepf0TNIzqIp
         Yjusz952YrrHyljKwK7MNijLNcBUAZHgEwkdNMyWHUNcU1EIf8lxQN3fNbOObFUcLXLt
         nVD6NiFbupToLNCqevCoyDuP3L1glBzHL2ynqNfyzqt7DgUhSkkeIQoLpqSVihsYc660
         o03d/Kl695+rEiypHO8sKfJ5xzmevEDhVfpoFajlCpqipiuhkNqtoRuPBFADc1j9kepr
         icIw0vD4CDOMbchXOFb+SAnhBe9edDTKskiO+5btyOhsb2wYn5uTGv6maRtlqOsYy8Oc
         nhHg==
X-Gm-Message-State: AJIora/jcSSuavVMBqnoqsAzLdUIqbfFBJaX0dQLL0oI6ZhqM6khj7sW
        uEx25yXMuVb70EEZkxvbqoq0Pt8xlK6lJ527J1/2MUI4Uws=
X-Google-Smtp-Source: AGRyM1vrlC7N+9evf+2BPIHhO8XMvJyYlI8jnnVWh34njQbIAWEwdAGfzdDAWRvy+qiLefHdCmYuktcVhSlj6jeAtLI=
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id
 c10-20020a0ceb4a000000b00472f9363ea0mr2921448qvq.43.1656936863259; Mon, 04
 Jul 2022 05:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220515204540.477711-1-robimarko@gmail.com> <20220515204540.477711-3-robimarko@gmail.com>
 <Yr4rte8Va+TgG9CM@builder.lan>
In-Reply-To: <Yr4rte8Va+TgG9CM@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 4 Jul 2022 14:14:12 +0200
Message-ID: <CAOX2RU5bpvaHQxTftPRGR-GXrgzOBXnjHZ=Lxzbz4-h0whSn2A@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] clk: qcom: Add IPQ8074 APSS clock controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 01:03, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Sun 15 May 15:45 CDT 2022, Robert Marko wrote:
>
> > IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
> > cores, thus also providing support for CPU frequency scaling.
> >
> > It looks like they are clocked by the XO and a custom APSS type PLL.
> >
> > Co-developed-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Convert to using parent-data instead of parent-names
> > ---
> >  drivers/clk/qcom/Kconfig        |  11 +++
> >  drivers/clk/qcom/Makefile       |   1 +
> >  drivers/clk/qcom/apss-ipq8074.c | 170 ++++++++++++++++++++++++++++++++
> >  3 files changed, 182 insertions(+)
> >  create mode 100644 drivers/clk/qcom/apss-ipq8074.c
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 00fe5f066de5..9494eb74374a 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -134,6 +134,17 @@ config IPQ_APSS_6018
> >         Say Y if you want to support CPU frequency scaling on
> >         ipq based devices.
> >
> > +config IPQ_APSS_8074
> > +     tristate "IPQ8074 APSS Clock Controller"
> > +     select IPQ_GCC_8074
> > +     depends on QCOM_APCS_IPC || COMPILE_TEST
> > +     help
> > +       Support for APSS clock controller on IPQ8074 platforms. The
> > +       APSS clock controller manages the Mux and enable block that feeds the
> > +       CPUs.
> > +       Say Y if you want to support CPU frequency scaling on
> > +       IPQ8074 based devices.
> > +
> >  config IPQ_GCC_4019
> >       tristate "IPQ4019 Global Clock Controller"
> >       help
> > diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> > index 671cf5821af1..7b2da6dd570c 100644
> > --- a/drivers/clk/qcom/Makefile
> > +++ b/drivers/clk/qcom/Makefile
> > @@ -22,6 +22,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
> >  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
> >  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
> >  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
> > +obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
> >  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
> >  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
> >  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> > diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
> > new file mode 100644
> > index 000000000000..38d03cd0ff76
> > --- /dev/null
> > +++ b/drivers/clk/qcom/apss-ipq8074.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <dt-bindings/clock/qcom,apss-ipq8074.h>
> > +
> > +#include "common.h"
> > +#include "clk-regmap.h"
> > +#include "clk-pll.h"
> > +#include "clk-rcg.h"
> > +#include "clk-branch.h"
> > +#include "clk-alpha-pll.h"
> > +#include "clk-regmap-divider.h"
> > +#include "clk-regmap-mux.h"
> > +
> > +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> > +
> > +enum {
> > +     P_XO,
> > +     P_GPLL0,
> > +     P_GPLL2,
> > +     P_GPLL4,
> > +     P_APSS_PLL_EARLY,
> > +     P_APSS_PLL
> > +};
> > +
> > +static struct clk_alpha_pll apss_pll_early = {
> > +     .offset = 0x5000,
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> > +     .clkr = {
> > +             .enable_reg = 0x5000,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "apss_pll_early",
> > +                     .parent_data = &(const struct clk_parent_data) {
> > +                             .fw_name = "xo", .name = "xo"
> > +                     },
> > +                     .num_parents = 1,
> > +                     .ops = &clk_alpha_pll_huayra_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_alpha_pll_postdiv apss_pll = {
> > +     .offset = 0x5000,
> > +     .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> > +     .width = 2,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "apss_pll",
> > +             .parent_hws = (const struct clk_hw *[]){
> > +                     &apss_pll_early.clkr.hw },
> > +             .num_parents = 1,
> > +             .ops = &clk_alpha_pll_postdiv_ro_ops,
> > +     },
> > +};
> > +
> > +static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
> > +     { .fw_name = "xo", .name = "xo" },
> > +     { .fw_name = "gpll0", .name = "gpll0" },
> > +     { .fw_name = "gpll2", .name = "gpll2" },
> > +     { .fw_name = "gpll4", .name = "gpll4" },
> > +     { .hw = &apss_pll.clkr.hw },
> > +     { .hw = &apss_pll_early.clkr.hw },
> > +};
> > +
> > +static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
> > +     { P_XO, 0 },
> > +     { P_GPLL0, 4 },
> > +     { P_GPLL2, 2 },
> > +     { P_GPLL4, 1 },
> > +     { P_APSS_PLL, 3 },
> > +     { P_APSS_PLL_EARLY, 5 },
> > +};
> > +
> > +struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
> > +     F(19200000, P_XO, 1, 0, 0),
> > +     F(403200000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(806400000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(1017600000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(1382400000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(1651200000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(1843200000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(1920000000, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     F(2208000000UL, P_APSS_PLL_EARLY, 1, 0, 0),
> > +     { }
> > +};
> > +
> > +struct clk_rcg2 apcs_alias0_clk_src = {
> > +     .cmd_rcgr = 0x0050,
> > +     .freq_tbl = ftbl_apcs_alias0_clk_src,
> > +     .hid_width = 5,
> > +     .parent_map = parents_apcs_alias0_clk_src_map,
> > +     .clkr.hw.init = &(struct clk_init_data){
> > +             .name = "apcs_alias0_clk_src",
> > +             .parent_data = parents_apcs_alias0_clk_src,
> > +             .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> > +             .ops = &clk_rcg2_ops,
> > +             .flags = CLK_SET_RATE_PARENT,
> > +     },
> > +};
> > +
> > +static struct clk_branch apcs_alias0_core_clk = {
> > +     .halt_reg = 0x0058,
> > +     .halt_bit = 31,
> > +     .clkr = {
> > +             .enable_reg = 0x0058,
> > +             .enable_mask = BIT(0),
> > +             .hw.init = &(struct clk_init_data){
> > +                     .name = "apcs_alias0_core_clk",
> > +                     .parent_hws = (const struct clk_hw *[]){
> > +                             &apcs_alias0_clk_src.clkr.hw },
> > +                     .num_parents = 1,
> > +                     .flags = CLK_SET_RATE_PARENT |
> > +                             CLK_IS_CRITICAL,
> > +                     .ops = &clk_branch2_ops,
> > +             },
> > +     },
> > +};
> > +
> > +static struct clk_regmap *apss_ipq8074_clks[] = {
> > +     [APSS_PLL_EARLY] = &apss_pll_early.clkr,
> > +     [APSS_PLL] = &apss_pll.clkr,
> > +     [APCS_ALIAS0_CLK_SRC] = &apcs_alias0_clk_src.clkr,
> > +     [APCS_ALIAS0_CORE_CLK] = &apcs_alias0_core_clk.clkr,
> > +};
> > +
> > +static const struct regmap_config apss_ipq8074_regmap_config = {
> > +     .reg_bits       = 32,
> > +     .reg_stride     = 4,
> > +     .val_bits       = 32,
> > +     .max_register   = 0x5ffc,
> > +     .fast_io        = true,
> > +};
> > +
> > +static const struct qcom_cc_desc apss_ipq8074_desc = {
> > +     .config = &apss_ipq8074_regmap_config,
> > +     .clks = apss_ipq8074_clks,
> > +     .num_clks = ARRAY_SIZE(apss_ipq8074_clks),
> > +};
> > +
> > +static int apss_ipq8074_probe(struct platform_device *pdev)
> > +{
> > +     struct regmap *regmap;
> > +
> > +     regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!regmap)
> > +             return -ENODEV;
> > +
> > +     return qcom_cc_really_probe(pdev, &apss_ipq8074_desc, regmap);
> > +}
> > +
> > +static struct platform_driver apss_ipq8074_driver = {
> > +     .probe = apss_ipq8074_probe,
> > +     .driver = {
> > +             .name   = "qcom,apss-ipq8074-clk",
>
> As pointed out by Krzysztof, this shouldn't have a ',' in there and if
> you look at msm8916 it uses "qcom-apcs-msm8916-clk", so please follow
> that.

Hi,
Sorry for the late reply.

Will fix it up in v5.

>
> I don't know if you intend to actually build this as a module, but if
> so, wouldn't you also need
> MODULE_ALIAS("platform:qcom-apss-ipq8074-clk"); to make module loading
> pick this thing up?

I never tried it as a module, however, there is nothing special here that would
require it to be boolean.

It works fine as a module, but like you stated MODULE_ALIAS is required so it
gets autoloaded, I will add it in v5.

Regards,
Robert
>
> Regards,
> Bjorn
>
> > +     },
> > +};
> > +
> > +module_platform_driver(apss_ipq8074_driver);
> > +
> > +MODULE_DESCRIPTION("Qualcomm IPQ8074 APSS clock driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.36.1
> >
