Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2045756C0F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiGHQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiGHQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:45:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB52DA88;
        Fri,  8 Jul 2022 09:45:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x11so787788qki.1;
        Fri, 08 Jul 2022 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZThGptq7h5vtkvYTEqQOjJHDp96c1xA4HJ53tM0Cq7I=;
        b=XfbYr7nYKQzSjNbhfWTRJv4r2l3M96KbNuUKVdTITaSXakF2uXSfLLyAHUjEKNLcZg
         6HedJYW9nb9YX7Griof39wAY+Opz+imI7/uR2YytrMGrYJYHWrZ9luLTkRceUfs2c0E5
         erarSiAZTvw5g+0CrBaDCDe3yPR8R0CFqg7kv35qN/XoYBzyp2or9chTxzbz8J098/pD
         W1DsFVOO+mowngJfWU8O+z09DCIW6TupjE2HZakzxRhmquD0PXFeLhTo4qGsS7zVAzyA
         4onzI1AgOPAq5GU5dtqeIfOTsIDmd8iP9AChovXrqY3rHqIiH32Sg/fTqgDW+KcgCY2u
         GaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZThGptq7h5vtkvYTEqQOjJHDp96c1xA4HJ53tM0Cq7I=;
        b=rTtzQ8FvbUxDTfgAf7kZ3iz5WFKKZE91/aGNdgv7FV7zOpjaThzZNPODB/P8NC+DGO
         9pElq0taddWHl40+yFLzpakG3YjdnNL6Xt9R2AkhAF3ghJ96Rws+I001UjGknKJv1tqy
         CoAy8ZQ3IAFGZMjsHTpIVgtRSSOJ5AZq/M/wVoWukLIFoEepxk+27qPZ+TC4Y7zcm69h
         H60gBcI5nmXmukMDf2U3GC3nqWdiTbKNFwGnuzV4VQ+1WPnQIxlMUgKVOWTFQbsYOMD4
         1al9y0ewHSnWQaBzqTnjNwU/0zvxpVaON46BM5cYloJSsMsGyapOfJ8N6utha+SCgx+U
         94lg==
X-Gm-Message-State: AJIora8RgCafCIkk3m3upwSzh/FWS3x8tTPV8a63BM5a6yv6++nRGDLG
        sN0MSMGJrES8owU+JRhidkgYdkFdIlOv1z6hkVM=
X-Google-Smtp-Source: AGRyM1vm3Sz06iZw23zFJKL4aCV6vtw06v1+bIfXshboOMlt0Qh4zT50XgACo4dXGHfx7M8PQpyxfX8oFEFDnpvpgCk=
X-Received: by 2002:a05:620a:1a23:b0:6af:6ceb:2ed with SMTP id
 bk35-20020a05620a1a2300b006af6ceb02edmr3109700qkb.42.1657298708601; Fri, 08
 Jul 2022 09:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220705191017.1683716-1-robimarko@gmail.com> <20220705191017.1683716-3-robimarko@gmail.com>
 <bab08104-8474-0247-6d64-d6335535c37c@somainline.org>
In-Reply-To: <bab08104-8474-0247-6d64-d6335535c37c@somainline.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 8 Jul 2022 18:44:57 +0200
Message-ID: <CAOX2RU6gmz6AHS2NzaX-duXPW_1U4QsqMH4LeCU-PFLLpVFc9g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] clk: qcom: Add IPQ8074 APSS clock controller
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
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

On Wed, 6 Jul 2022 at 15:21, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
>
>
> On 5.07.2022 21:10, Robert Marko wrote:
> > IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
> > cores, thus also providing support for CPU frequency scaling.
> >
> > It looks like they are clocked by the XO and a custom APSS type PLL.
> >
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v5:
> > * Drop F define as its already defined in clk-rgc.h
> > * Correct the driver name to not include commas
> > * Correct Christian-s SoB
> > * Add MODULE_ALIAS so it gets loaded if built as a module
> >
> > Changes in v2:
> > * Convert to using parent-data instead of parent-names
> > ---
> >  drivers/clk/qcom/Kconfig        |  11 +++
> >  drivers/clk/qcom/Makefile       |   1 +
> >  drivers/clk/qcom/apss-ipq8074.c | 169 ++++++++++++++++++++++++++++++++
> >  3 files changed, 181 insertions(+)
> >  create mode 100644 drivers/clk/qcom/apss-ipq8074.c
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index fc45d00eec42..a3ba541a9dee 100644
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
> > index 08594230c1c1..226f3b5cefde 100644
> > --- a/drivers/clk/qcom/Makefile
> > +++ b/drivers/clk/qcom/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
> >  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
> >  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
> >  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
> > +obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
> >  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
> >  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
> >  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> > diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
> > new file mode 100644
> > index 000000000000..36fafa71c4ea
> > --- /dev/null
> > +++ b/drivers/clk/qcom/apss-ipq8074.c
> > @@ -0,0 +1,169 @@
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
> Since you're only adding this driver now, no DT uses it an you
> should drop the .name lookup.

Hi Konrad,
I will fix it up, also need to update the dtschema and DT node patch for APCS
node as "xo" is not a valid clock currently for it.
>
>
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
> Looks like it only supports frequencies with APSS_PLL_EARLY and XO
> as parents? Are all of these other PLLs necessary here?

Unfortunately, I dont have any docs on this, this is based on the downstream 5.4
driver.

I got rid of GPLL-s as parents and it seems to still be able to set
the correct frequency
, however, initially the frequency that is read during boot then
matches the XO frequency
of 19.2 MHz which is obviously incorrect:
[    1.632308] cpufreq: cpufreq_online: CPU0: Running at unlisted
initial frequency: 19200 KHz, changing to: 1017600 KHz

I can then use the userspace governor and go through all OPP points
without an issue and
using the mhz [1] tool I can confirm that frequency matches the requested one.

[1] https://github.com/wtarreau/mhz
>
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
> Every frequency is a div1 and comes from a single clock..
> is this correct? This sounds like a simple mux that only
> switches between XO and APSS_PLL_EARLY..

I tested this using the IPQ6018 clk_regmap_mux apcs_alias0_clk_src
and it appears to work, I am able to switch through all of the OPP-s:
# cat scaling_available_frequencies
1017600 1382400 1651200 1843200 1920000 2208000
# echo 1017600 > scaling_setspeed
# mhz
count=413212 us50=20314 us250=101571 diff=81257 cpu_MHz=1017.050
# echo 1382400 > scaling_setspeed
# mhz
count=645643 us50=23381 us250=116811 diff=93430 cpu_MHz=1382.089
# echo 1651200 > scaling_setspeed
# mhz
count=807053 us50=24452 us250=122238 diff=97786 cpu_MHz=1650.651
# echo 1843200 > scaling_setspeed
# mhz
count=807053 us50=21901 us250=109503 diff=87602 cpu_MHz=1842.545
# echo 1920000 > scaling_setspeed
# mhz
count=807053 us50=21023 us250=105125 diff=84102 cpu_MHz=1919.224
# echo 2208000 > scaling_setspeed
# mhz
count=1008816 us50=22857 us250=114255 diff=91398 cpu_MHz=2207.523

Seems like IPQ6018 and IPQ8074 use the same mux, though PLL is different.

>
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
> This can fit in a single line.

I will fix it in v6.
>
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
> qcom_cc_probe?

qcom_cc_probe would not work as it calls qcom_cc_map which works only on the
device MMIO resource, and we have to get the regmap from the parent which is
APCS as they share the same register space.

>
> > +}
> > +
> > +static struct platform_driver apss_ipq8074_driver = {
> > +     .probe = apss_ipq8074_probe,
> > +     .driver = {
> > +             .name   = "qcom-apss-ipq8074-clk",
> > +     },
> > +};
> > +
> > +module_platform_driver(apss_ipq8074_driver);
> > +
> > +MODULE_ALIAS("platform:qcom-apss-ipq8074-clk");
> > +MODULE_DESCRIPTION("Qualcomm IPQ8074 APSS clock driver");
> > +MODULE_LICENSE("GPL");
> "GPL v2"?

Checkpatch now warns on GPL v2 and other variants that GPL is
preferred since 5.18:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/scripts/checkpatch.pl?h=v5.18.10&id=6e8f42dc9c8548c6b37566f3b8bda1873700c4a6

Originally had "GPL v2" and then checkpatch pointed this out.

Regards,
Robert
>
> Konrad
