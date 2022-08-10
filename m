Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183158EDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiHJN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:56:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2F52E71
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:56:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1027616wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc;
        bh=IUcZ6Ht5Kh2EwZj5pzsFd/dgwR1bKOIPjfgPLQga2D4=;
        b=35YreMFnOA2ABxQOyoSu3GCjf1kZmmj7ffnR19PhtMQ67i/tUOZVL/a6/UyEPNGA8E
         rTAl1sU2Cl/Yyn0XaahijeJMkKGgXkWVOvsiCrW92X1YkALdbitv5uJoxz+B4h2/+btP
         8MWpWY0YKFDLXI7J5YGSIF+QEhcO59CiWG4evQb6qq1gnLJ5CDAIZfkD6LREwWgD2Uns
         bHgYiwctaVtCtGk1nBtsb7Q28Y9g0kEFU4kWTsKZmnuTaFai5TiIGa63l57hMLUlbqfS
         J2Vij0c33wn9tQhKZk6OTWlKxu9KISp5Gkr5UjqhUOlyJykkYXXnpFie4uzZcgj0SSjR
         So5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc;
        bh=IUcZ6Ht5Kh2EwZj5pzsFd/dgwR1bKOIPjfgPLQga2D4=;
        b=jH+GRHnR8DhpmCTjeDdhlf3XJCrLndmkShiU2Ue3s8sSoY5Z7eJYIn3vHm9EmGeiDJ
         b7Sp3XxIQvQg6wvBX8DlfDBq6m8lZYN4RnQD+p8gk5K+yM0wxD+RypF0TXGriNUMOmgd
         yUqCYpsxSQjGLYANss2+cov9cngAcCcvt7Ie/LTSdCi2mxWdLy6ZJ1gWAI2iY3YOwMsT
         iueUWDoan0gtrv3V2WtiqClEJSOY2GqKawoJQkXtGVsPRK2wmNfQDfJk07HQXU/bNsAc
         2Kz6x8l+j26V/FpR2XUn/l8W7M9ZkVUQvshWF8Vs2j7XMU+1i5+LhfzDl6UPVGk8JiAZ
         yMrw==
X-Gm-Message-State: ACgBeo2+E2w4ucQQb5AtBwF18fHApm8MSjhFEoXGc7Il5JwcF0OahPpA
        l9Jr1FfFI5d9LNXJJ40EBe3fBg==
X-Google-Smtp-Source: AA6agR5r67qw4vWgOaPqlJs2DPTzK3Ba50R7inmh85tY6iyy35tQlYEMi4t1og5/e1duIwsWYjkGPA==
X-Received: by 2002:a05:600c:6022:b0:3a5:219b:9276 with SMTP id az34-20020a05600c602200b003a5219b9276mr2560064wmb.18.1660139775089;
        Wed, 10 Aug 2022 06:56:15 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b0021e2fccea97sm16013187wrf.64.2022.08.10.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:56:14 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-4-yu.tu@amlogic.com>
User-agent: mu4e 1.8.7; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 3/6] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Wed, 10 Aug 2022 15:47:38 +0200
In-reply-to: <20220805085716.5635-4-yu.tu@amlogic.com>
Message-ID: <1jiln0yzgj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 05 Aug 2022 at 16:57, Yu Tu <yu.tu@amlogic.com> wrote:

> Add the S4 PLL clock controller found in the s4 SoC family.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  12 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/s4-pll.c | 891 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/s4-pll.h |  88 ++++
>  4 files changed, 992 insertions(+)
>  create mode 100644 drivers/clk/meson/s4-pll.c
>  create mode 100644 drivers/clk/meson/s4-pll.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index fc002c155bc3..f4244edc7b28 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -115,4 +115,16 @@ config COMMON_CLK_G12A
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>  	  devices, aka g12a. Say Y if you want peripherals to work.
> +
> +config COMMON_CLK_S4_PLL
> +	tristate "S4 SoC PLL clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_MPLL
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_REGMAP
> +	help
> +	  Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
> +	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
> +	  Say Y if you want peripherals and CPU frequency scaling to work.

Looks like this doc is copy/paste of the peripheral controller.
This probably needs to be updated

>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 6eca2a406ee3..376f49cc13f1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> +obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> new file mode 100644
> index 000000000000..478c78b5ed46
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -0,0 +1,891 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-S4 Clock Controller Driver
> + *
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mpll.h"
> +#include "clk-pll.h"
> +#include "clk-regmap.h"
> +#include "s4-pll.h"
> +
> +static DEFINE_SPINLOCK(meson_clk_lock);
> +
> +static struct clk_regmap s4_fixed_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll_dco",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock won't ever change at runtime so
> +		 * CLK_SET_RATE_PARENT is not required
> +		 */
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct pll_mult_range s4_gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +/*
> + * Internal gp0 pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL1,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4,	.def = 0x88770290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 }
> +};
> +
> +static struct clk_regmap s4_gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_gp0_init_regs,
> +		.init_count = ARRAY_SIZE(s4_gp0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_gp0_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Internal hifi pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x00010e56 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4,	.def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 }
> +};
> +
> +static struct clk_regmap s4_hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_hifi_init_regs,
> +		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
> +		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_hifi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_dco",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * Display directly handle hdmi pll registers ATM, we need
> +		 * NOCACHE to keep our view of the clock as accurate as
> +		 * possible
> +		 */

Is it really ?

Given that HDMI support for the s4 is there yet, the
addresses have changes and the region is no longer a syscon, it is time
for the HDMI driver to get fixed.

> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll_od = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HDMIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 4,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdmi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * Display directly handle hdmi pll registers ATM, we need
> +		 * NOCACHE to keep our view of the clock as accurate as
> +		 * possible
> +		 */
> +		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HDMIPLL_CTRL0,
> +		.shift = 20,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdmi_pll_od.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * Display directly handle hdmi pll registers ATM, we need
> +		 * NOCACHE to keep our view of the clock as accurate as
> +		 * possible
> +		 */
> +		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_mpll_50m_div = {
> +	.mult = 1,
> +	.div = 80,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_50m_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll_50m = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = ANACTRL_FIXPLL_CTRL3,
> +		.mask = 0x1,
> +		.shift = 5,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_50m",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .hw = &s4_mpll_50m_div.hw },
> +		},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_mpll_prediv = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_prediv",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll0_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL2, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll0_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll0_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL1,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll0_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll1_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL4,	.def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll1_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll1_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll1_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL3,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll1_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll2_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL6, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll2_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll2_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll2_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL5,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll2_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll3_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL8, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll3_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll3_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll3_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL7,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll3_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* Array of all clocks provided by this provider */
> +static struct clk_hw_onecell_data s4_pll_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_FIXED_PLL_DCO]		= &s4_fixed_pll_dco.hw,
> +		[CLKID_FIXED_PLL]		= &s4_fixed_pll.hw,
> +		[CLKID_FCLK_DIV2_DIV]		= &s4_fclk_div2_div.hw,
> +		[CLKID_FCLK_DIV2]		= &s4_fclk_div2.hw,
> +		[CLKID_FCLK_DIV3_DIV]		= &s4_fclk_div3_div.hw,
> +		[CLKID_FCLK_DIV3]		= &s4_fclk_div3.hw,
> +		[CLKID_FCLK_DIV4_DIV]		= &s4_fclk_div4_div.hw,
> +		[CLKID_FCLK_DIV4]		= &s4_fclk_div4.hw,
> +		[CLKID_FCLK_DIV5_DIV]		= &s4_fclk_div5_div.hw,
> +		[CLKID_FCLK_DIV5]		= &s4_fclk_div5.hw,
> +		[CLKID_FCLK_DIV7_DIV]		= &s4_fclk_div7_div.hw,
> +		[CLKID_FCLK_DIV7]		= &s4_fclk_div7.hw,
> +		[CLKID_FCLK_DIV2P5_DIV]		= &s4_fclk_div2p5_div.hw,
> +		[CLKID_FCLK_DIV2P5]		= &s4_fclk_div2p5.hw,
> +		[CLKID_GP0_PLL_DCO]		= &s4_gp0_pll_dco.hw,
> +		[CLKID_GP0_PLL]			= &s4_gp0_pll.hw,
> +		[CLKID_HIFI_PLL_DCO]		= &s4_hifi_pll_dco.hw,
> +		[CLKID_HIFI_PLL]		= &s4_hifi_pll.hw,
> +		[CLKID_HDMI_PLL_DCO]		= &s4_hdmi_pll_dco.hw,
> +		[CLKID_HDMI_PLL_OD]		= &s4_hdmi_pll_od.hw,
> +		[CLKID_HDMI_PLL]		= &s4_hdmi_pll.hw,
> +		[CLKID_MPLL_50M_DIV]		= &s4_mpll_50m_div.hw,
> +		[CLKID_MPLL_50M]		= &s4_mpll_50m.hw,
> +		[CLKID_MPLL_PREDIV]		= &s4_mpll_prediv.hw,
> +		[CLKID_MPLL0_DIV]		= &s4_mpll0_div.hw,
> +		[CLKID_MPLL0]			= &s4_mpll0.hw,
> +		[CLKID_MPLL1_DIV]		= &s4_mpll1_div.hw,
> +		[CLKID_MPLL1]			= &s4_mpll1.hw,
> +		[CLKID_MPLL2_DIV]		= &s4_mpll2_div.hw,
> +		[CLKID_MPLL2]			= &s4_mpll2.hw,
> +		[CLKID_MPLL3_DIV]		= &s4_mpll3_div.hw,
> +		[CLKID_MPLL3]			= &s4_mpll3.hw,
> +
> +		[NR_PLL_CLKS]			= NULL
> +	},
> +	.num = NR_PLL_CLKS,
> +};
> +
> +static struct clk_regmap *const s4_pll_clk_regmaps[] = {
> +	&s4_fixed_pll_dco,
> +	&s4_fixed_pll,
> +	&s4_fclk_div2,
> +	&s4_fclk_div3,
> +	&s4_fclk_div4,
> +	&s4_fclk_div5,
> +	&s4_fclk_div7,
> +	&s4_fclk_div2p5,
> +	&s4_gp0_pll_dco,
> +	&s4_gp0_pll,
> +	&s4_hifi_pll_dco,
> +	&s4_hifi_pll,
> +	&s4_hdmi_pll_dco,
> +	&s4_hdmi_pll_od,
> +	&s4_hdmi_pll,
> +	&s4_mpll_50m,
> +	&s4_mpll0_div,
> +	&s4_mpll0,
> +	&s4_mpll1_div,
> +	&s4_mpll1,
> +	&s4_mpll2_div,
> +	&s4_mpll2,
> +	&s4_mpll3_div,
> +	&s4_mpll3,
> +};
> +
> +static const struct reg_sequence s4_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x00000543 },
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static int meson_s4_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_multi_reg_write(regmap, s4_init_regs, ARRAY_SIZE(s4_init_regs));
> +	if (ret) {
> +		dev_err(dev, "Failed to init registers\n");
> +		return ret;
> +	}
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(s4_pll_clk_regmaps); i++)
> +		s4_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (i = 0; i < s4_pll_hw_onecell_data.num; i++) {
> +		/* array might be sparse */
> +		if (!s4_pll_hw_onecell_data.hws[i])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, s4_pll_hw_onecell_data.hws[i]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &s4_pll_hw_onecell_data);
> +}
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,s4-pll-clkc",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver s4_driver = {
> +	.probe		= meson_s4_pll_probe,
> +	.driver		= {
> +		.name	= "s4-pll-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(s4_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/s4-pll.h b/drivers/clk/meson/s4-pll.h
> new file mode 100644
> index 000000000000..41dc6de978c1
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __MESON_S4_PLL_H__
> +#define __MESON_S4_PLL_H__
> +
> +/* ANA_CTRL - Registers
> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe008000
> + */
> +#define ANACTRL_FIXPLL_CTRL0                       (0x0010 << 2)

I already commented on the "<< 2" . Remove them please.

> +#define ANACTRL_FIXPLL_CTRL1                       (0x0011 << 2)
> +#define ANACTRL_FIXPLL_CTRL2                       (0x0012 << 2)
> +#define ANACTRL_FIXPLL_CTRL3                       (0x0013 << 2)
> +#define ANACTRL_FIXPLL_CTRL4                       (0x0014 << 2)
> +#define ANACTRL_FIXPLL_CTRL5                       (0x0015 << 2)
> +#define ANACTRL_FIXPLL_CTRL6                       (0x0016 << 2)
> +#define ANACTRL_FIXPLL_STS                         (0x0017 << 2)
> +#define ANACTRL_GP0PLL_CTRL0                       (0x0020 << 2)
> +#define ANACTRL_GP0PLL_CTRL1                       (0x0021 << 2)
> +#define ANACTRL_GP0PLL_CTRL2                       (0x0022 << 2)
> +#define ANACTRL_GP0PLL_CTRL3                       (0x0023 << 2)
> +#define ANACTRL_GP0PLL_CTRL4                       (0x0024 << 2)
> +#define ANACTRL_GP0PLL_CTRL5                       (0x0025 << 2)
> +#define ANACTRL_GP0PLL_CTRL6                       (0x0026 << 2)
> +#define ANACTRL_GP0PLL_STS                         (0x0027 << 2)
> +#define ANACTRL_HIFIPLL_CTRL0                      (0x0040 << 2)
> +#define ANACTRL_HIFIPLL_CTRL1                      (0x0041 << 2)
> +#define ANACTRL_HIFIPLL_CTRL2                      (0x0042 << 2)
> +#define ANACTRL_HIFIPLL_CTRL3                      (0x0043 << 2)
> +#define ANACTRL_HIFIPLL_CTRL4                      (0x0044 << 2)
> +#define ANACTRL_HIFIPLL_CTRL5                      (0x0045 << 2)
> +#define ANACTRL_HIFIPLL_CTRL6                      (0x0046 << 2)
> +#define ANACTRL_HIFIPLL_STS                        (0x0047 << 2)
> +#define ANACTRL_MPLL_CTRL0                         (0x0060 << 2)
> +#define ANACTRL_MPLL_CTRL1                         (0x0061 << 2)
> +#define ANACTRL_MPLL_CTRL2                         (0x0062 << 2)
> +#define ANACTRL_MPLL_CTRL3                         (0x0063 << 2)
> +#define ANACTRL_MPLL_CTRL4                         (0x0064 << 2)
> +#define ANACTRL_MPLL_CTRL5                         (0x0065 << 2)
> +#define ANACTRL_MPLL_CTRL6                         (0x0066 << 2)
> +#define ANACTRL_MPLL_CTRL7                         (0x0067 << 2)
> +#define ANACTRL_MPLL_CTRL8                         (0x0068 << 2)
> +#define ANACTRL_MPLL_STS                           (0x0069 << 2)
> +#define ANACTRL_HDMIPLL_CTRL0                      (0x0070 << 2)
> +#define ANACTRL_HDMIPLL_CTRL1                      (0x0071 << 2)
> +#define ANACTRL_HDMIPLL_CTRL2                      (0x0072 << 2)
> +#define ANACTRL_HDMIPLL_CTRL3                      (0x0073 << 2)
> +#define ANACTRL_HDMIPLL_CTRL4                      (0x0074 << 2)
> +#define ANACTRL_HDMIPLL_CTRL5                      (0x0075 << 2)
> +#define ANACTRL_HDMIPLL_CTRL6                      (0x0076 << 2)
> +#define ANACTRL_HDMIPLL_STS                        (0x0077 << 2)
> +#define ANACTRL_HDMIPLL_VLOCK                      (0x0079 << 2)
> +
> +/*
> + * CLKID index values
> + *
> + * These indices are entirely contrived and do not map onto the hardware.
> + * It has now been decided to expose everything by default in the DT header:
> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
> + * to expose, such as the internal muxes and dividers of composite clocks,
> + * will remain defined here.
> + */
> +#define CLKID_FIXED_PLL_DCO		0
> +#define CLKID_FCLK_DIV2_DIV		2
> +#define CLKID_FCLK_DIV3_DIV		4
> +#define CLKID_FCLK_DIV4_DIV		6
> +#define CLKID_FCLK_DIV5_DIV		8
> +#define CLKID_FCLK_DIV7_DIV		10
> +#define CLKID_FCLK_DIV2P5_DIV		12
> +#define CLKID_GP0_PLL_DCO		14
> +#define CLKID_HIFI_PLL_DCO		16
> +#define CLKID_HDMI_PLL_DCO		18
> +#define CLKID_HDMI_PLL_OD		19
> +#define CLKID_MPLL_50M_DIV		21
> +#define CLKID_MPLL_PREDIV		23
> +#define CLKID_MPLL0_DIV			24
> +#define CLKID_MPLL1_DIV			26
> +#define CLKID_MPLL2_DIV			28
> +#define CLKID_MPLL3_DIV			30
> +
> +#define NR_PLL_CLKS			32
> +/* include the CLKIDs that have been made part of the DT binding */
> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
> +
> +#endif /* __MESON_S4_PLL_H__ */

