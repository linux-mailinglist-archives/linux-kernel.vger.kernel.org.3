Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA94590D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiHLIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiHLIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:07:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F4A830E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:07:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so329130wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc;
        bh=YCvd02ds7Zu1HLQwM3hM1quMJPxE71z07mU0ABwaefY=;
        b=Mfo2L0plaWHhWXszajI/dzweVwXTTKLDOEohDPHPNdj8tk7ZCfl56RWD4Wduupts50
         QpF7kqpTnOLOBrb0cSXfkLJw6JYfgjkCteIMFe307xxRCn9+XSXNFtLQJ8XwEoNeFHFe
         iwijAPYH99Hc+bz9CahG17vFFyV79O437+1SMPdtZraEAnJDij6W5Zv6QQvgXMxBRyWw
         DVrhfNCIaS815HOfOE8p/9WRdwKsu4jN1+O0FNU9ksl7iRxUXPhgiSIxK273TFwDphPL
         xuDeU+D7WLR0NweFZkSMqvcho8+VAdPBG4tiZIZ/NHR6/BumK9E32BGd4Litg52SM5YB
         aT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc;
        bh=YCvd02ds7Zu1HLQwM3hM1quMJPxE71z07mU0ABwaefY=;
        b=78bY7nbvpVG+lX0FYJscZR2z5kbIne8Odw89D0FJKr052GIU/L7TnGioihrv2vKorD
         ABONrihS3KR4u00wKauvh9yVUKR8LtZ58dpLE4NGqOmEgG04lq8TxQ4enRRCmW0kvi/k
         37UpiK04gt+DPpEfjAqjWDX0fGXv7R14Bdy00ImkCHq+ZjmxDaemwCLa+/NoQqEEKJwc
         7iSl5BWgkw5Vk5CYK0wPFlS0RAbuTsr42Vfe9+T+2uRf21uwwPQTdu03/cuQ5E2lz13+
         Yq2v32D6oCjUxGUT6N/7I69n4Gro8mOfhgo4e4+FLg48tT2+01kdlozmzwjDOfm8WL0f
         mJIQ==
X-Gm-Message-State: ACgBeo1P5x/seACzlgfAAXP3XM5otmTlRveaHX4XAteepm/6rvrMp1cC
        G3BzEXeELb90blqdsngO7Y1Ryg==
X-Google-Smtp-Source: AA6agR7Dtx4f83bmFCDtoSoaIY75yDgAzX4If3nOoAfRJaJBN/8fuBDB49xHV6dMk8OxbVjK5dE4Ng==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr1426653wri.344.1660291655561;
        Fri, 12 Aug 2022 01:07:35 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056000081300b0021eaf4138aesm1539865wrb.108.2022.08.12.01.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:07:34 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-7-yu.tu@amlogic.com>
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
Subject: Re: [PATCH V3 6/6] clk: meson: s4: add s4 SoC peripheral clock
 controller driver
Date:   Wed, 10 Aug 2022 15:57:02 +0200
In-reply-to: <20220805085716.5635-7-yu.tu@amlogic.com>
Message-ID: <1jedxlzxyz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 05 Aug 2022 at 16:57, Yu Tu <yu.tu@amlogic.com> wrote:

> Add the peripheral clock controller found in the s4 SoC family, it
> depends on the A1 PLL driver.
                  ^ How so ?

I don't see any reference to the A1 nor a dependency.
The controller consumes (not depends) clocks from another controller

>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |   13 +
>  drivers/clk/meson/Makefile |    1 +
>  drivers/clk/meson/s4.c     | 3878 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/s4.h     |  232 +++
>  4 files changed, 4124 insertions(+)
>  create mode 100644 drivers/clk/meson/s4.c
>  create mode 100644 drivers/clk/meson/s4.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index f4244edc7b28..ec6beb9284d3 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -127,4 +127,17 @@ config COMMON_CLK_S4_PLL
>  	  Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
>  	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>  	  Say Y if you want peripherals and CPU frequency scaling to work.
> +
> +config COMMON_CLK_S4
> +	tristate "S4 SoC Peripherals clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_VID_PLL_DIV
> +	select COMMON_CLK_S4_PLL

Do you really this ? your driver does not even include the related header.

> +	help
> +	  Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
> +	  devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
> +	  Say Y if you want peripherals and CPU frequency scaling to work.
>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 376f49cc13f1..c9c05b834c7d 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>  obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
> +obj-$(CONFIG_COMMON_CLK_S4) += s4.o
> diff --git a/drivers/clk/meson/s4.c b/drivers/clk/meson/s4.c
> new file mode 100644
> index 000000000000..7ee3b1a0fc4c
> --- /dev/null
> +++ b/drivers/clk/meson/s4.c

s4-peripherals.c ?
Same for the header file

> @@ -0,0 +1,3878 @@
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
> +#include "clk-regmap.h"
> +#include "vid-pll-div.h"
> +#include "clk-dualdiv.h"
> +#include "s4.h"
> +
> +/*
> + * rtc 32k clock in gate
> + */

This comment is no helping.
It is verbose and adds no new information

Also, 1 line comments do not require the multiline format.

> +static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_by_oscin_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct meson_clk_dualdiv_param s4_32k_div_table[] = {
> +	{
> +		.dual	= 1,
> +		.n1	= 733,
> +		.m1	= 8,
> +		.n2	= 732,
> +		.m2	= 11,
> +	},
> +	{}
> +};
> +
> +static struct clk_regmap s4_rtc_32k_by_oscin_div = {
> +	.data = &(struct meson_clk_dualdiv_data){
> +		.n1 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = s4_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_32k_by_oscin_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_rtc_32k_by_oscin_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_rtc_32k_by_oscin_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_32k_by_oscin_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_rtc_32k_by_oscin_div.hw,
> +			&s4_rtc_32k_by_oscin_clkin.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_rtc_32k_by_oscin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_by_oscin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_rtc_32k_by_oscin_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
> + * If it is used, it should be documented in using fW_name and documented in the
                             fix the camel case please ^ 
> + * Bindings. Not currently in use on this board, so skip it.
> + */
> +static u32 rtc_clk_sel[] = { 0, 1 };
> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
> +	{ .hw = &s4_rtc_32k_by_oscin.hw },
> +	{ .hw = &s4_rtc_32k_by_oscin_div.hw },
> +	{ .fw_name = "ext-32k-0",  }

This fw_name needs to be documented in the bindings, as optional.

> +};
> +
> +static struct clk_regmap s4_rtc_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_RTC_CTRL,
> +		.mask = 0x3,
> +		.shift = 0,
> +		.table = rtc_clk_sel,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_clk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = rtc_clk_sel_parent_data,
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * sys clk
> + * The clock corresponding to these 5 is AXi_CLK, which is dedicated to AXI. So skip it.

Camel case again - fix them all please

> + */
> +static u32 mux_table_sys_ab_clk_sel[] = { 0, 1, 2, 3, 4, 6, 7 };

What are we skipping at index 5 ?

> +static const struct clk_parent_data sys_ab_clk_parent_data[] = {
> +	{ .fw_name = "xtal" },
> +	{ .fw_name = "fclk_div2" },
> +	{ .fw_name = "fclk_div3" },
> +	{ .fw_name = "fclk_div4" },
> +	{ .fw_name = "fclk_div5" },
> +	{ .fw_name = "fclk_div7" },
> +	{ .hw = &s4_rtc_clk.hw }
> +};
> +
> +static struct clk_regmap s4_sysclk_b_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 26,
> +		.table = mux_table_sys_ab_clk_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sysclk_b_sel",
> +		.ops = &clk_regmap_mux_ro_ops,

Why is this using the RO ops ?

> +		.parent_data = sys_ab_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_sysclk_b_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.shift = 16,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sysclk_b_div",
> +		.ops = &clk_regmap_divider_ro_ops,

Same here and for the rest of the sys part

> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sysclk_b_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sysclk_b = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.bit_idx = 29,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sysclk_b",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sysclk_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sysclk_a_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 10,
> +		.table = mux_table_sys_ab_clk_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sysclk_a_sel",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = sys_ab_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_sysclk_a_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sysclk_a_div",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sysclk_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sysclk_a = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.bit_idx = 13,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sysclk_a",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sysclk_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sys_clk = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_clk",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sysclk_a.hw,
> +			&s4_sysclk_b.hw
> +		},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_clkin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CECA_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ceca_32k_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data){
> +		.n1 = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = CLKCTRL_CECA_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = CLKCTRL_CECA_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = CLKCTRL_CECA_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = s4_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_sel_pre = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECA_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_sel_pre",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_div.hw,
> +			&s4_ceca_32k_clkin.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECA_CTRL1,
> +		.mask = 0x1,
> +		.shift = 31,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_sel_pre.hw,
> +			&s4_rtc_clk.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_ceca_32k_clkout = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CECA_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ceca_32k_clkout",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ceca_32k_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cecb_32k_clkin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CECB_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cecb_32k_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_cecb_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data){
> +		.n1 = {
> +			.reg_off = CLKCTRL_CECB_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = CLKCTRL_CECB_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = CLKCTRL_CECB_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = CLKCTRL_CECB_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = CLKCTRL_CECB_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = s4_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cecb_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cecb_32k_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_cecb_32k_sel_pre = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECB_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cecb_32k_sel_pre",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cecb_32k_div.hw,
> +			&s4_cecb_32k_clkin.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cecb_32k_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CECB_CTRL1,
> +		.mask = 0x1,
> +		.shift = 31,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cecb_32k_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cecb_32k_sel_pre.hw,
> +			&s4_rtc_clk.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cecb_32k_clkout = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CECB_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cecb_32k_clkout",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cecb_32k_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_sc_parent_data[] = {
> +	{ .fw_name = "fclk_div4" },
> +	{ .fw_name = "fclk_div3" },
> +	{ .fw_name = "fclk_div5" },
> +	{ .fw_name = "xtal", }
> +};
> +
> +static struct clk_regmap s4_sc_clk_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SC_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sc_clk_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_sc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_sc_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sc_clk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sc_clk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sc_clk_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sc_clk_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SC_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sc_clk_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sc_clk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_12_24M_clk_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "12_24m_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_12M_clk_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "12M",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_12_24M_clk_gate.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_12_24M_clk = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.mask = 0x1,
> +		.shift = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "12_24m",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_12_24M_clk_gate.hw,
> +			&s4_12M_clk_div.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* Video Clocks */
> +static struct clk_regmap s4_vid_pll_div = {
> +	.data = &(struct meson_vid_pll_div_data){
> +		.val = {
> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
> +			.shift   = 0,
> +			.width   = 15,
> +		},
> +		.sel = {
> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
> +			.shift   = 16,
> +			.width   = 2,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vid_pll_div",
> +		.ops = &meson_vid_pll_div_ro_ops,

Why RO ? applies to the rest of the video part.

> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "hdmi_pll", }
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vid_pll_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
> +		.mask = 0x1,
> +		.shift = 18,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vid_pll_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bit 18 selects from 2 possible parents:
> +		 * vid_pll_div or hdmi_pll
> +		 */
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .hw = &s4_vid_pll_div.hw },
> +			{ .fw_name = "hdmi_pll", }
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,

Why ? are you planning to DT assigned clocks to statically set this ?

> +	},
> +};
> +
> +static struct clk_regmap s4_vid_pll = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
> +		.bit_idx = 19,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vid_pll",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vid_pll_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_vclk_parent_data[] = {
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "mpll1", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +};
> +
> +static struct clk_regmap s4_vclk_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vclk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,

Same 

> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vclk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_input = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_DIV,
> +		.bit_idx = 16,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_input",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_input = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_DIV,
> +		.bit_idx = 16,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_input",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VID_CLK_DIV,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk_input.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VIID_CLK_DIV,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk2_input.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 19,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 19,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div2_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div2_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div4_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div4_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div6_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div6_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk_div12_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div12_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div2_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div2_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div4_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div4_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div6_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div6_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vclk2_div12_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VIID_CLK_CTRL,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div12_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div2",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk_div2_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk_div4 = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div4",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk_div4_en.hw
> +		},
> +		.num_parents = 1,

Why is the rate propagation cut here ?

> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk_div6 = {
> +	.mult = 1,
> +	.div = 6,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div6",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk_div6_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk_div12 = {
> +	.mult = 1,
> +	.div = 12,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div12",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk_div12_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk2_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div2",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk2_div2_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk2_div4 = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div4",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk2_div4_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk2_div6 = {
> +	.mult = 1,
> +	.div = 6,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div6",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk2_div6_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_vclk2_div12 = {
> +	.mult = 1,
> +	.div = 12,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div12",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vclk2_div12_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/*
> + * bits 31:28 selects from 12 possible parents:
> + * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
> + * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12r.

This comment is not useful. We can read the same below 

> + * The 5,6,7 corresponds to no real clock, so threre are not used.
               ^ indexes                           ^ typo

> + */
> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> +static const struct clk_hw *s4_cts_parent_hws[] = {
> +	&s4_vclk_div1.hw,
> +	&s4_vclk_div2.hw,
> +	&s4_vclk_div4.hw,
> +	&s4_vclk_div6.hw,
> +	&s4_vclk_div12.hw,
> +	&s4_vclk2_div1.hw,
> +	&s4_vclk2_div2.hw,
> +	&s4_vclk2_div4.hw,
> +	&s4_vclk2_div6.hw,
> +	&s4_vclk2_div12.hw
> +};
> +
> +static struct clk_regmap s4_cts_enci_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 28,
> +		.table = mux_table_cts_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_enci_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_cts_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,

If you use this flag, I expect at least a quick explanation
Why is it static ? How it is supposed to be set ?

Applies to the other usage of it 

> +	},
> +};
> +
> +static struct clk_regmap s4_cts_encp_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 20,
> +		.table = mux_table_cts_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_encp_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_cts_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cts_vdac_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VIID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 28,
> +		.table = mux_table_cts_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_vdac_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_cts_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +/*
> + * TOFIX: add support for cts_tcon

Fix it then :P ... or remove it

> + * bits 31:28 selects from 12 possible parents:
> + * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
> + * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12,

Same

> + * cts_tcon
> + */
> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> +static const struct clk_hw *s4_cts_hdmi_tx_parent_hws[] = {
> +	&s4_vclk_div1.hw,
> +	&s4_vclk_div2.hw,
> +	&s4_vclk_div4.hw,
> +	&s4_vclk_div6.hw,
> +	&s4_vclk_div12.hw,
> +	&s4_vclk2_div1.hw,
> +	&s4_vclk2_div2.hw,
> +	&s4_vclk2_div4.hw,
> +	&s4_vclk2_div6.hw,
> +	&s4_vclk2_div12.hw
> +};
> +
> +static struct clk_regmap s4_hdmi_tx_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
> +		.mask = 0xf,
> +		.shift = 16,
> +		.table = mux_table_hdmi_tx_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_tx_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_cts_hdmi_tx_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_cts_hdmi_tx_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cts_enci = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL2,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_enci",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cts_enci_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cts_encp = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL2,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_encp",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cts_encp_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cts_vdac = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL2,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_vdac",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cts_vdac_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_tx = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL2,
> +		.bit_idx = 5,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdmi_tx",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdmi_tx_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* HDMI Clocks */
> +static const struct clk_parent_data s4_hdmi_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", }
> +};
> +
> +static struct clk_regmap s4_hdmi_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_hdmi_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_hdmi_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_sel.hw },
> +		.num_parents = 1,

Why is rate propagation stopped here ?

> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdmi",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_ts_clk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_TS_CLK_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ts_clk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal",
> +		},
> +		.num_parents = 1,

propagation stopped ?

> +	},
> +};
> +
> +static struct clk_regmap s4_ts_clk_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_TS_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ts_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_ts_clk_div.hw
> +		},
> +		.num_parents = 1,
> +	},

propagation stopped ?

> +};
> +
> +/*
> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> + * muxed by a glitch-free switch. The CCF can manage this glitch-free
> + * mux because it does top-to-bottom updates the each clock tree and
> + * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
> + */
> +static const struct clk_parent_data s4_mali_0_1_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "fclk_div2p5", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", }
> +};
> +
> +static struct clk_regmap s4_mali_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_mali_0_1_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
> +		/*
> +		 * Don't request the parent to change the rate because
> +		 * all GPU frequencies can be derived from the fclk_*
> +		 * clocks and one special GP0_PLL setting. This is
> +		 * important because we need the MPLL clocks for audio.
> +		 */
> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap s4_mali_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mali_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_mali_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mali_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_mali_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_mali_0_1_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
> +		/*
> +		 * Don't request the parent to change the rate because
> +		 * all GPU frequencies can be derived from the fclk_*
> +		 * clocks and one special GP0_PLL setting. This is
> +		 * important because we need the MPLL clocks for audio.
> +		 */

I got it mali_0_sel - don't need to Copy/Paste the explanation when it
is clear elements are duplicate and obey the same rule.

Can be applied elsewhere.

> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap s4_mali_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mali_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_mali_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mali_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_hw *s4_mali_parent_hws[] = {
> +	&s4_mali_0.hw,
> +	&s4_mali_1.hw
> +};
> +
> +static struct clk_regmap s4_mali_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_MALI_CLK_CTRL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_mali_parent_hws,
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* VDEC clocks */
> +static const struct clk_parent_data s4_dec_parent_data[] = {
> +	{ .fw_name = "fclk_div2p5", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "xtal", }
> +};
> +
> +static struct clk_regmap s4_vdec_p0_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_p0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_dec_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdec_p0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_p0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdec_p0_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdec_p0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_p0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdec_p0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,

Interresting, why to need to gate on set_rate() here ?

> +	},
> +};
> +
> +static struct clk_regmap s4_vdec_p1_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_p1_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_dec_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdec_p1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_p1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdec_p1_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdec_p1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdec_p1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdec_p1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_hw *s4_vdec_mux_parent_hws[] = {
> +	&s4_vdec_p0.hw,
> +	&s4_vdec_p1.hw
> +};
> +
> +static struct clk_regmap s4_vdec_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_vdec_mux_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p0_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hevcf_p0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_dec_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hevcf_p0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hevcf_p0_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hevcf_p0_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hevcf_p0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p1_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hevcf_p1_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_dec_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hevcf_p1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hevcf_p1_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hevcf_p1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hevcf_p1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hevcf_p1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_hw *s4_hevcf_mux_parent_hws[] = {
> +	&s4_hevcf_p0.hw,
> +	&s4_hevcf_p1.hw
> +};
> +
> +static struct clk_regmap s4_hevcf_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hevcf",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_hevcf_mux_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* VPU Clock */
> +static const struct clk_parent_data s4_vpu_parent_data[] = {
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll1", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "gp0_pll", },
> +};
> +
> +static struct clk_regmap s4_vpu_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vpu_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vpu_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vpu_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vpu_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLK_CTRL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bit 31 selects from 2 possible parents:
> +		 * vpu_0 or vpu_1
> +		 */

yes, It is obvious from the code ..

> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_0.hw,
> +			&s4_vpu_1.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,

... but this deserve a explanantion :)

> +	},
> +};
> +
> +static const struct clk_parent_data vpu_clkb_tmp_parent_data[] = {
> +	{ .hw = &s4_vpu.hw },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", }
> +};
> +
> +static struct clk_regmap s4_vpu_clkb_tmp_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
> +		.mask = 0x3,
> +		.shift = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkb_tmp_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vpu_clkb_tmp_parent_data,
> +		.num_parents = ARRAY_SIZE(vpu_clkb_tmp_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkb_tmp_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
> +		.shift = 16,
> +		.width = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkb_tmp_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkb_tmp_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkb_tmp = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_clkb_tmp",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkb_tmp_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkb_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkb_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkb_tmp.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkb = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_clkb",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkb_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll1", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "gp0_pll", },
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_p0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vpu_clkc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_p0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkc_p0_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_clkc_p0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkc_p0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p1_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_p1_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vpu_clkc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_p1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkc_p1_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_clkc_p1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vpu_clkc_p1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_hw *s4_vpu_mux_parent_hws[] = {
> +	&s4_vpu_clkc_p0.hw,
> +	&s4_vpu_clkc_p1.hw
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.mask = 0x1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_vpu_mux_parent_hws,
> +		.num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +/* VAPB Clock */
> +static const struct clk_parent_data s4_vapb_parent_data[] = {
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll1", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "fclk_div2p5", },
> +};
> +
> +static struct clk_regmap s4_vapb_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vapb_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vapb_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vapb_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vapb_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vapb_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vapb_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vapb_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vapb_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vapb = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bit 31 selects from 2 possible parents:
> +		 * vapb_0 or vapb_1
> +		 */
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vapb_0.hw,
> +			&s4_vapb_1.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_ge2d_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VAPBCLK_CTRL,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ge2d_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_vapb.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_esmclk_parent_data[] = {
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +};
> +
> +static struct clk_regmap s4_hdcp22_esmclk_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdcp22_esmclk_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_esmclk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_esmclk_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_hdcp22_esmclk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdcp22_esmclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdcp22_esmclk_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdcp22_esmclk_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdcp22_esmclk_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdcp22_esmclk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_skpclk_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +};
> +
> +static struct clk_regmap s4_hdcp22_skpclk_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdcp22_skpclk_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_skpclk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_skpclk_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdcp22_skpclk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hdcp22_skpclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdcp22_skpclk_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdcp22_skpclk_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_HDCP22_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdcp22_skpclk_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdcp22_skpclk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data s4_vdin_parent_data[]  = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .hw = &s4_vid_pll.hw }
> +};
> +
> +static struct clk_regmap s4_vdin_meas_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdin_meas_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vdin_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vdin_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdin_meas_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdin_meas_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdin_meas_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_vdin_meas_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdin_meas_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_vdin_meas_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* EMMC/NAND clock */
> +
> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "fclk_div2p5", },
> +	/*
> +	 * Following these parent clocks, we should also have had mpll2, mpll3
> +	 * and gp0_pll but these clocks are too precious to be used here. All
> +	 * the necessary rates for MMC and NAND operation can be acheived using
> +	 * hifi_pll or fclk_div clocks
> +	 */

You don't want to list mplls but hifi_pll is fine ? seems dangerous.


> +};
> +
> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_clk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_sd_emmc_clk0_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_c_clk0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_clk0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_c_clk0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_c_clk0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_c_clk0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_c_clk0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_a_clk0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_clk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_sd_emmc_clk0_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_a_clk0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_clk0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_a_clk0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_a_clk0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_a_clk0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_a_clk0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_b_clk0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_clk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_sd_emmc_clk0_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_b_clk0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_clk0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_b_clk0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_sd_emmc_b_clk0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_b_clk0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_sd_emmc_b_clk0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* SPICC SCLK source clock */
> +

Those comment could help organize a bit but you need to be consistent,
including wether or not you add a new line after it.

> +static const struct clk_parent_data s4_spicc_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &s4_sys_clk.hw },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +};
> +
> +static struct clk_regmap s4_spicc0_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_spicc0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_spicc0_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_spicc0_gate = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.bit_idx = 6,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "spicc0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_spicc0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* PWM CLOCK */
> +
> +static const struct clk_parent_data s4_pwm_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +};
> +
> +static struct clk_regmap s4_pwm_a_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_a_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_a_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_a_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_a_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_a_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_b_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_b_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_b_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.shift = 16,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_b_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_b_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_b_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_b_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_c_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_c_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_c_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_c_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_c_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_c_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_c_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_c_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_d_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_d_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_d_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.shift = 16,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_d_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_d_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_d_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_d_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_d_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_e_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_e_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_e_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_e_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_e_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_e_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_e_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_e_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_f_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_f_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_f_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.shift = 16,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_f_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_f_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_f_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_f_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_f_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_g_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_g_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_g_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_g_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_g_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_g_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_g_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_g_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_h_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_h_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_h_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.shift = 16,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_h_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_h_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_h_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_h_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_h_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_i_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_i_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_i_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_i_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_i_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_i_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_i_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_i_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_j_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_j_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_j_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.shift = 16,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_j_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_h_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_pwm_j_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_j_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_pwm_j_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_saradc_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "saradc_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .hw = &s4_sys_clk.hw },
> +		},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap s4_saradc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "saradc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_saradc_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_saradc_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "saradc_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_saradc_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
> + * corresponding clock sources are not described in the clock tree, so they are skipped.
> + */

Still feels a bit light, don't you think ? Among all the clocks, can't
you add a bit more parents here ? It would certainly help debug down the road

> +static u32 s4_gen_clk_mux_table[] = { 0, 5, 7, 19, 21, 22,
> +				      23, 24, 25, 26, 27, 28 };
> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll0", },
> +	{ .fw_name = "mpll1", },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "mpll3", },
> +};
> +
> +static struct clk_regmap s4_gen_clk_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.mask = 0x1f,
> +		.shift = 12,
> +		.table = s4_gen_clk_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gen_clk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_gen_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_gen_clk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.shift = 0,
> +		.width = 11,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gen_clk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gen_clk_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_gen_clk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gen_clk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};

GEN clock being about debug mostly, I would recommend GET_RATE_NOCACHE
in the flags

> +
> +static const struct clk_parent_data s4_adc_extclk_in_parent_data[]  = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "hifi_pll", },
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_adc_extclk_in_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_adc_extclk_in_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_adc_extclk_in_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_adc_extclk_in_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core_clk_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core_clk_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .fw_name = "fclk_div7", },
> +			{ .fw_name = "fclk_div4", },
> +			{ .hw = &s4_adc_extclk_in_gate.hw }
> +		},
> +		.num_parents = 4,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core_clk_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core_clk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_demod_core_clk_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core_clk_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_demod_core_clk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +#define MESON_GATE(_name, _reg, _bit) \
> +	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
> +
> +static MESON_GATE(s4_ddr,		CLKCTRL_SYS_CLK_EN0_REG0, 0);
> +static MESON_GATE(s4_dos,		CLKCTRL_SYS_CLK_EN0_REG0, 1);
> +static MESON_GATE(s4_ethphy,		CLKCTRL_SYS_CLK_EN0_REG0, 4);
> +static MESON_GATE(s4_mali,		CLKCTRL_SYS_CLK_EN0_REG0, 6);
> +static MESON_GATE(s4_aocpu,		CLKCTRL_SYS_CLK_EN0_REG0, 13);
> +static MESON_GATE(s4_aucpu,		CLKCTRL_SYS_CLK_EN0_REG0, 14);
> +static MESON_GATE(s4_cec,		CLKCTRL_SYS_CLK_EN0_REG0, 16);
> +static MESON_GATE(s4_sdemmca,		CLKCTRL_SYS_CLK_EN0_REG0, 24);
> +static MESON_GATE(s4_sdemmcb,		CLKCTRL_SYS_CLK_EN0_REG0, 25);
> +static MESON_GATE(s4_nand,		CLKCTRL_SYS_CLK_EN0_REG0, 26);
> +static MESON_GATE(s4_smartcard,		CLKCTRL_SYS_CLK_EN0_REG0, 27);
> +static MESON_GATE(s4_acodec,		CLKCTRL_SYS_CLK_EN0_REG0, 28);
> +static MESON_GATE(s4_spifc,		CLKCTRL_SYS_CLK_EN0_REG0, 29);
> +static MESON_GATE(s4_msr_clk,		CLKCTRL_SYS_CLK_EN0_REG0, 30);
> +static MESON_GATE(s4_ir_ctrl,		CLKCTRL_SYS_CLK_EN0_REG0, 31);
> +
> +static MESON_GATE(s4_audio,		CLKCTRL_SYS_CLK_EN0_REG1, 0);
> +static MESON_GATE(s4_eth,		CLKCTRL_SYS_CLK_EN0_REG1, 3);
> +static MESON_GATE(s4_uart_a,		CLKCTRL_SYS_CLK_EN0_REG1, 5);
> +static MESON_GATE(s4_uart_b,		CLKCTRL_SYS_CLK_EN0_REG1, 6);
> +static MESON_GATE(s4_uart_c,		CLKCTRL_SYS_CLK_EN0_REG1, 7);
> +static MESON_GATE(s4_uart_d,		CLKCTRL_SYS_CLK_EN0_REG1, 8);
> +static MESON_GATE(s4_uart_e,		CLKCTRL_SYS_CLK_EN0_REG1, 9);
> +static MESON_GATE(s4_aififo,		CLKCTRL_SYS_CLK_EN0_REG1, 11);
> +static MESON_GATE(s4_ts_ddr,		CLKCTRL_SYS_CLK_EN0_REG1, 15);
> +static MESON_GATE(s4_ts_pll,		CLKCTRL_SYS_CLK_EN0_REG1, 16);
> +static MESON_GATE(s4_g2d,		CLKCTRL_SYS_CLK_EN0_REG1, 20);
> +static MESON_GATE(s4_spicc0,		CLKCTRL_SYS_CLK_EN0_REG1, 21);
> +static MESON_GATE(s4_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 26);
> +static MESON_GATE(s4_i2c_m_a,		CLKCTRL_SYS_CLK_EN0_REG1, 30);
> +static MESON_GATE(s4_i2c_m_b,		CLKCTRL_SYS_CLK_EN0_REG1, 31);
> +
> +static MESON_GATE(s4_i2c_m_c,		CLKCTRL_SYS_CLK_EN0_REG2, 0);
> +static MESON_GATE(s4_i2c_m_d,		CLKCTRL_SYS_CLK_EN0_REG2, 1);
> +static MESON_GATE(s4_i2c_m_e,		CLKCTRL_SYS_CLK_EN0_REG2, 2);
> +static MESON_GATE(s4_hdmitx_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 4);
> +static MESON_GATE(s4_i2c_s_a,		CLKCTRL_SYS_CLK_EN0_REG2, 5);
> +static MESON_GATE(s4_usb1_to_ddr,	CLKCTRL_SYS_CLK_EN0_REG2, 8);
> +static MESON_GATE(s4_hdcp22,		CLKCTRL_SYS_CLK_EN0_REG2, 10);
> +static MESON_GATE(s4_mmc_apb,		CLKCTRL_SYS_CLK_EN0_REG2, 11);
> +static MESON_GATE(s4_rsa,		CLKCTRL_SYS_CLK_EN0_REG2, 18);
> +static MESON_GATE(s4_cpu_debug,		CLKCTRL_SYS_CLK_EN0_REG2, 19);
> +static MESON_GATE(s4_vpu_intr,		CLKCTRL_SYS_CLK_EN0_REG2, 25);
> +static MESON_GATE(s4_demod,		CLKCTRL_SYS_CLK_EN0_REG2, 27);
> +static MESON_GATE(s4_sar_adc,		CLKCTRL_SYS_CLK_EN0_REG2, 28);
> +static MESON_GATE(s4_gic,		CLKCTRL_SYS_CLK_EN0_REG2, 30);
> +
> +static MESON_GATE(s4_pwm_ab,		CLKCTRL_SYS_CLK_EN0_REG3, 7);
> +static MESON_GATE(s4_pwm_cd,		CLKCTRL_SYS_CLK_EN0_REG3, 8);
> +static MESON_GATE(s4_pwm_ef,		CLKCTRL_SYS_CLK_EN0_REG3, 9);
> +static MESON_GATE(s4_pwm_gh,		CLKCTRL_SYS_CLK_EN0_REG3, 10);
> +static MESON_GATE(s4_pwm_ij,		CLKCTRL_SYS_CLK_EN0_REG3, 11);
> +
> +/* Array of all clocks provided by this provider */
> +static struct clk_hw_onecell_data s4_periphs_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_RTC_32K_CLKIN]		= &s4_rtc_32k_by_oscin_clkin.hw,
> +		[CLKID_RTC_32K_DIV]		= &s4_rtc_32k_by_oscin_div.hw,
> +		[CLKID_RTC_32K_SEL]		= &s4_rtc_32k_by_oscin_sel.hw,
> +		[CLKID_RTC_32K_XATL]		= &s4_rtc_32k_by_oscin.hw,
> +		[CLKID_RTC_CLK]			= &s4_rtc_clk.hw,
> +

Remove these extra new lines please

> +		[CLKID_SYS_CLK_B_SEL]		= &s4_sysclk_b_sel.hw,
> +		[CLKID_SYS_CLK_B_DIV]		= &s4_sysclk_b_div.hw,
> +		[CLKID_SYS_CLK_B_GATE]		= &s4_sysclk_b.hw,
> +		[CLKID_SYS_CLK_A_SEL]		= &s4_sysclk_a_sel.hw,
> +		[CLKID_SYS_CLK_A_DIV]		= &s4_sysclk_a_div.hw,
> +		[CLKID_SYS_CLK_A_GATE]		= &s4_sysclk_a.hw,
> +		[CLKID_SYS_CLK]			= &s4_sys_clk.hw,
> +
> +		[CLKID_CECA_32K_CLKIN]		= &s4_ceca_32k_clkin.hw,
> +		[CLKID_CECA_32K_DIV]		= &s4_ceca_32k_div.hw,
> +		[CLKID_CECA_32K_SEL_PRE]	= &s4_ceca_32k_sel_pre.hw,
> +		[CLKID_CECA_32K_SEL]		= &s4_ceca_32k_sel.hw,
> +		[CLKID_CECA_32K_CLKOUT]		= &s4_ceca_32k_clkout.hw,
> +
> +		[CLKID_CECB_32K_CLKIN]		= &s4_cecb_32k_clkin.hw,
> +		[CLKID_CECB_32K_DIV]		= &s4_cecb_32k_div.hw,
> +		[CLKID_CECB_32K_SEL_PRE]	= &s4_cecb_32k_sel_pre.hw,
> +		[CLKID_CECB_32K_SEL]		= &s4_cecb_32k_sel.hw,
> +		[CLKID_CECB_32K_CLKOUT]		= &s4_cecb_32k_clkout.hw,
> +
> +		[CLKID_SC_CLK_SEL]		= &s4_sc_clk_mux.hw,
> +		[CLKID_SC_CLK_DIV]		= &s4_sc_clk_div.hw,
> +		[CLKID_SC_CLK_GATE]		= &s4_sc_clk_gate.hw,
> +
> +		[CLKID_12_24M_CLK_GATE]		= &s4_12_24M_clk_gate.hw,
> +		[CLKID_12M_CLK_DIV]		= &s4_12M_clk_div.hw,
> +		[CLKID_12_24M_CLK_SEL]		= &s4_12_24M_clk.hw,
> +
> +		[CLKID_VID_PLL_DIV]		= &s4_vid_pll_div.hw,
> +		[CLKID_VID_PLL_SEL]		= &s4_vid_pll_sel.hw,
> +		[CLKID_VID_PLL]			= &s4_vid_pll.hw,
> +		[CLKID_VCLK_SEL]		= &s4_vclk_sel.hw,
> +		[CLKID_VCLK2_SEL]		= &s4_vclk2_sel.hw,
> +		[CLKID_VCLK_INPUT]		= &s4_vclk_input.hw,
> +		[CLKID_VCLK2_INPUT]		= &s4_vclk2_input.hw,
> +		[CLKID_VCLK_DIV]		= &s4_vclk_div.hw,
> +		[CLKID_VCLK2_DIV]		= &s4_vclk2_div.hw,
> +		[CLKID_VCLK]			= &s4_vclk.hw,
> +		[CLKID_VCLK2]			= &s4_vclk2.hw,
> +		[CLKID_VCLK_DIV1]		= &s4_vclk_div1.hw,
> +		[CLKID_VCLK_DIV2_EN]		= &s4_vclk_div2_en.hw,
> +		[CLKID_VCLK_DIV4_EN]		= &s4_vclk_div4_en.hw,
> +		[CLKID_VCLK_DIV6_EN]		= &s4_vclk_div6_en.hw,
> +		[CLKID_VCLK_DIV12_EN]		= &s4_vclk_div12_en.hw,
> +		[CLKID_VCLK2_DIV1]		= &s4_vclk2_div1.hw,
> +		[CLKID_VCLK2_DIV2_EN]		= &s4_vclk2_div2_en.hw,
> +		[CLKID_VCLK2_DIV4_EN]		= &s4_vclk2_div4_en.hw,
> +		[CLKID_VCLK2_DIV6_EN]		= &s4_vclk2_div6_en.hw,
> +		[CLKID_VCLK2_DIV12_EN]		= &s4_vclk2_div12_en.hw,
> +		[CLKID_VCLK_DIV2]		= &s4_vclk_div2.hw,
> +		[CLKID_VCLK_DIV4]		= &s4_vclk_div4.hw,
> +		[CLKID_VCLK_DIV6]		= &s4_vclk_div6.hw,
> +		[CLKID_VCLK_DIV12]		= &s4_vclk_div12.hw,
> +		[CLKID_VCLK2_DIV2]		= &s4_vclk2_div2.hw,
> +		[CLKID_VCLK2_DIV4]		= &s4_vclk2_div4.hw,
> +		[CLKID_VCLK2_DIV6]		= &s4_vclk2_div6.hw,
> +		[CLKID_VCLK2_DIV12]		= &s4_vclk2_div12.hw,
> +		[CLKID_CTS_ENCI_SEL]		= &s4_cts_enci_sel.hw,
> +		[CLKID_CTS_ENCP_SEL]		= &s4_cts_encp_sel.hw,
> +		[CLKID_CTS_VDAC_SEL]		= &s4_cts_vdac_sel.hw,
> +		[CLKID_HDMI_TX_SEL]		= &s4_hdmi_tx_sel.hw,
> +		[CLKID_CTS_ENCI]		= &s4_cts_enci.hw,
> +		[CLKID_CTS_ENCP]		= &s4_cts_encp.hw,
> +		[CLKID_CTS_VDAC]		= &s4_cts_vdac.hw,
> +		[CLKID_HDMI_TX]			= &s4_hdmi_tx.hw,
> +		[CLKID_HDMI_SEL]		= &s4_hdmi_sel.hw,
> +		[CLKID_HDMI_DIV]		= &s4_hdmi_div.hw,
> +		[CLKID_HDMI]			= &s4_hdmi.hw,
> +
> +		[CLKID_TS_CLK_DIV]		= &s4_ts_clk_div.hw,
> +		[CLKID_TS_CLK_GATE]		= &s4_ts_clk_gate.hw,
> +
> +		[CLKID_MALI_0_SEL]		= &s4_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]		= &s4_mali_0_div.hw,
> +		[CLKID_MALI_0]			= &s4_mali_0.hw,
> +		[CLKID_MALI_1_SEL]		= &s4_mali_1_sel.hw,
> +		[CLKID_MALI_1_DIV]		= &s4_mali_1_div.hw,
> +		[CLKID_MALI_1]			= &s4_mali_1.hw,
> +		[CLKID_MALI]			= &s4_mali_mux.hw,
> +
> +		[CLKID_VDEC_P0_SEL]		= &s4_vdec_p0_mux.hw,
> +		[CLKID_VDEC_P0_DIV]		= &s4_vdec_p0_div.hw,
> +		[CLKID_VDEC_P0]			= &s4_vdec_p0.hw,
> +		[CLKID_VDEC_P1_SEL]		= &s4_vdec_p1_mux.hw,
> +		[CLKID_VDEC_P1_DIV]		= &s4_vdec_p1_div.hw,
> +		[CLKID_VDEC_P1]			= &s4_vdec_p1.hw,
> +		[CLKID_VDEC_SEL]		= &s4_vdec_mux.hw,
> +
> +		[CLKID_HEVCF_P0_SEL]		= &s4_hevcf_p0_mux.hw,
> +		[CLKID_HEVCF_P0_DIV]		= &s4_hevcf_p0_div.hw,
> +		[CLKID_HEVCF_P0]		= &s4_hevcf_p0.hw,
> +		[CLKID_HEVCF_P1_SEL]		= &s4_hevcf_p1_mux.hw,
> +		[CLKID_HEVCF_P1_DIV]		= &s4_hevcf_p1_div.hw,
> +		[CLKID_HEVCF_P1]		= &s4_hevcf_p1.hw,
> +		[CLKID_HEVCF_SEL]		= &s4_hevcf_mux.hw,
> +
> +		[CLKID_VPU_0_SEL]		= &s4_vpu_0_sel.hw,
> +		[CLKID_VPU_0_DIV]		= &s4_vpu_0_div.hw,
> +		[CLKID_VPU_0]			= &s4_vpu_0.hw,
> +		[CLKID_VPU_1_SEL]		= &s4_vpu_1_sel.hw,
> +		[CLKID_VPU_1_DIV]		= &s4_vpu_1_div.hw,
> +		[CLKID_VPU_1]			= &s4_vpu_1.hw,
> +		[CLKID_VPU]			= &s4_vpu.hw,
> +
> +		[CLKID_VPU_CLKB_TMP_SEL]	= &s4_vpu_clkb_tmp_mux.hw,
> +		[CLKID_VPU_CLKB_TMP_DIV]	= &s4_vpu_clkb_tmp_div.hw,
> +		[CLKID_VPU_CLKB_TMP]		= &s4_vpu_clkb_tmp.hw,
> +		[CLKID_VPU_CLKB_DIV]		= &s4_vpu_clkb_div.hw,
> +		[CLKID_VPU_CLKB]		= &s4_vpu_clkb.hw,
> +		[CLKID_VPU_CLKC_P0_SEL]		= &s4_vpu_clkc_p0_mux.hw,
> +		[CLKID_VPU_CLKC_P0_DIV]		= &s4_vpu_clkc_p0_div.hw,
> +		[CLKID_VPU_CLKC_P0]		= &s4_vpu_clkc_p0.hw,
> +		[CLKID_VPU_CLKC_P1_SEL]		= &s4_vpu_clkc_p1_mux.hw,
> +		[CLKID_VPU_CLKC_P1_DIV]		= &s4_vpu_clkc_p1_div.hw,
> +		[CLKID_VPU_CLKC_P1]		= &s4_vpu_clkc_p1.hw,
> +		[CLKID_VPU_CLKC_SEL]		= &s4_vpu_clkc_mux.hw,
> +
> +		[CLKID_VAPB_0_SEL]		= &s4_vapb_0_sel.hw,
> +		[CLKID_VAPB_0_DIV]		= &s4_vapb_0_div.hw,
> +		[CLKID_VAPB_0]			= &s4_vapb_0.hw,
> +		[CLKID_VAPB_1_SEL]		= &s4_vapb_1_sel.hw,
> +		[CLKID_VAPB_1_DIV]		= &s4_vapb_1_div.hw,
> +		[CLKID_VAPB_1]			= &s4_vapb_1.hw,
> +		[CLKID_VAPB]			= &s4_vapb.hw,
> +
> +		[CLKID_GE2D]			= &s4_ge2d_gate.hw,
> +
> +		[CLKID_VDIN_MEAS_SEL]		= &s4_vdin_meas_mux.hw,
> +		[CLKID_VDIN_MEAS_DIV]		= &s4_vdin_meas_div.hw,
> +		[CLKID_VDIN_MEAS_GATE]		= &s4_vdin_meas_gate.hw,
> +
> +		[CLKID_SD_EMMC_C_CLK_SEL]	= &s4_sd_emmc_c_clk0_sel.hw,
> +		[CLKID_SD_EMMC_C_CLK_DIV]	= &s4_sd_emmc_c_clk0_div.hw,
> +		[CLKID_SD_EMMC_C_CLK]		= &s4_sd_emmc_c_clk0.hw,
> +
> +		[CLKID_SD_EMMC_A_CLK_SEL]	= &s4_sd_emmc_a_clk0_sel.hw,
> +		[CLKID_SD_EMMC_A_CLK_DIV]	= &s4_sd_emmc_a_clk0_div.hw,
> +		[CLKID_SD_EMMC_A_CLK]		= &s4_sd_emmc_a_clk0.hw,
> +		[CLKID_SD_EMMC_B_CLK_SEL]	= &s4_sd_emmc_b_clk0_sel.hw,
> +		[CLKID_SD_EMMC_B_CLK_DIV]	= &s4_sd_emmc_b_clk0_div.hw,
> +		[CLKID_SD_EMMC_B_CLK]		= &s4_sd_emmc_b_clk0.hw,
> +
> +		[CLKID_SPICC0_SEL]		= &s4_spicc0_mux.hw,
> +		[CLKID_SPICC0_DIV]		= &s4_spicc0_div.hw,
> +		[CLKID_SPICC0_GATE]		= &s4_spicc0_gate.hw,
> +
> +		[CLKID_PWM_A_SEL]		= &s4_pwm_a_mux.hw,
> +		[CLKID_PWM_A_DIV]		= &s4_pwm_a_div.hw,
> +		[CLKID_PWM_A_GATE]		= &s4_pwm_a_gate.hw,
> +		[CLKID_PWM_B_SEL]		= &s4_pwm_b_mux.hw,
> +		[CLKID_PWM_B_DIV]		= &s4_pwm_b_div.hw,
> +		[CLKID_PWM_B_GATE]		= &s4_pwm_b_gate.hw,
> +		[CLKID_PWM_C_SEL]		= &s4_pwm_c_mux.hw,
> +		[CLKID_PWM_C_DIV]		= &s4_pwm_c_div.hw,
> +		[CLKID_PWM_C_GATE]		= &s4_pwm_c_gate.hw,
> +		[CLKID_PWM_D_SEL]		= &s4_pwm_d_mux.hw,
> +		[CLKID_PWM_D_DIV]		= &s4_pwm_d_div.hw,
> +		[CLKID_PWM_D_GATE]		= &s4_pwm_d_gate.hw,
> +		[CLKID_PWM_E_SEL]		= &s4_pwm_e_mux.hw,
> +		[CLKID_PWM_E_DIV]		= &s4_pwm_e_div.hw,
> +		[CLKID_PWM_E_GATE]		= &s4_pwm_e_gate.hw,
> +		[CLKID_PWM_F_SEL]		= &s4_pwm_f_mux.hw,
> +		[CLKID_PWM_F_DIV]		= &s4_pwm_f_div.hw,
> +		[CLKID_PWM_F_GATE]		= &s4_pwm_f_gate.hw,
> +		[CLKID_PWM_G_SEL]		= &s4_pwm_g_mux.hw,
> +		[CLKID_PWM_G_DIV]		= &s4_pwm_g_div.hw,
> +		[CLKID_PWM_G_GATE]		= &s4_pwm_g_gate.hw,
> +		[CLKID_PWM_H_SEL]		= &s4_pwm_h_mux.hw,
> +		[CLKID_PWM_H_DIV]		= &s4_pwm_h_div.hw,
> +		[CLKID_PWM_H_GATE]		= &s4_pwm_h_gate.hw,
> +		[CLKID_PWM_I_SEL]		= &s4_pwm_i_mux.hw,
> +		[CLKID_PWM_I_DIV]		= &s4_pwm_i_div.hw,
> +		[CLKID_PWM_I_GATE]		= &s4_pwm_i_gate.hw,
> +		[CLKID_PWM_J_SEL]		= &s4_pwm_j_mux.hw,
> +		[CLKID_PWM_J_DIV]		= &s4_pwm_j_div.hw,
> +		[CLKID_PWM_J_GATE]		= &s4_pwm_j_gate.hw,
> +
> +		[CLKID_SARADC_SEL]		= &s4_saradc_mux.hw,
> +		[CLKID_SARADC_DIV]		= &s4_saradc_div.hw,
> +		[CLKID_SARADC_GATE]		= &s4_saradc_gate.hw,
> +
> +		[CLKID_GEN_SEL]			= &s4_gen_clk_sel.hw,
> +		[CLKID_GEN_DIV]			= &s4_gen_clk_div.hw,
> +		[CLKID_GEN_GATE]		= &s4_gen_clk.hw,
> +
> +		[CLKID_DDR]			= &s4_ddr.hw,
> +		[CLKID_DOS]			= &s4_dos.hw,
> +		[CLKID_ETHPHY]			= &s4_ethphy.hw,
> +		[CLKID_MALI_GATE]		= &s4_mali.hw,
> +		[CLKID_AOCPU]			= &s4_aocpu.hw,
> +		[CLKID_AUCPU]			= &s4_aucpu.hw,
> +		[CLKID_CEC]			= &s4_cec.hw,
> +		[CLKID_SD_EMMC_A]		= &s4_sdemmca.hw,
> +		[CLKID_SD_EMMC_B]		= &s4_sdemmcb.hw,
> +		[CLKID_NAND]			= &s4_nand.hw,
> +		[CLKID_SMARTCARD]		= &s4_smartcard.hw,
> +		[CLKID_ACODEC]			= &s4_acodec.hw,
> +		[CLKID_SPIFC]			= &s4_spifc.hw,
> +		[CLKID_MSR_CLK]			= &s4_msr_clk.hw,
> +		[CLKID_IR_CTRL]			= &s4_ir_ctrl.hw,
> +
> +		[CLKID_AUDIO]			= &s4_audio.hw,
> +		[CLKID_ETH]			= &s4_eth.hw,
> +		[CLKID_UART_A]			= &s4_uart_a.hw,
> +		[CLKID_UART_B]			= &s4_uart_b.hw,
> +		[CLKID_UART_C]			= &s4_uart_c.hw,
> +		[CLKID_UART_D]			= &s4_uart_d.hw,
> +		[CLKID_UART_E]			= &s4_uart_e.hw,
> +		[CLKID_AIFIFO]			= &s4_aififo.hw,
> +		[CLKID_TS_DDR]			= &s4_ts_ddr.hw,
> +		[CLKID_TS_PLL]			= &s4_ts_pll.hw,
> +		[CLKID_G2D]			= &s4_g2d.hw,
> +		[CLKID_SPICC0]			= &s4_spicc0.hw,
> +		[CLKID_USB]			= &s4_usb.hw,
> +		[CLKID_I2C_M_A]			= &s4_i2c_m_a.hw,
> +		[CLKID_I2C_M_B]			= &s4_i2c_m_b.hw,
> +		[CLKID_I2C_M_C]			= &s4_i2c_m_c.hw,
> +		[CLKID_I2C_M_D]			= &s4_i2c_m_d.hw,
> +		[CLKID_I2C_M_E]			= &s4_i2c_m_e.hw,
> +		[CLKID_HDMITX_APB]		= &s4_hdmitx_apb.hw,
> +		[CLKID_I2C_S_A]			= &s4_i2c_s_a.hw,
> +		[CLKID_USB1_TO_DDR]		= &s4_usb1_to_ddr.hw,
> +		[CLKID_HDCP22]			= &s4_hdcp22.hw,
> +		[CLKID_MMC_APB]			= &s4_mmc_apb.hw,
> +		[CLKID_RSA]			= &s4_rsa.hw,
> +		[CLKID_CPU_DEBUG]		= &s4_cpu_debug.hw,
> +		[CLKID_VPU_INTR]		= &s4_vpu_intr.hw,
> +		[CLKID_DEMOD]			= &s4_demod.hw,
> +		[CLKID_SAR_ADC]			= &s4_sar_adc.hw,
> +		[CLKID_GIC]			= &s4_gic.hw,
> +		[CLKID_PWM_AB]			= &s4_pwm_ab.hw,
> +		[CLKID_PWM_CD]			= &s4_pwm_cd.hw,
> +		[CLKID_PWM_EF]			= &s4_pwm_ef.hw,
> +		[CLKID_PWM_GH]			= &s4_pwm_gh.hw,
> +		[CLKID_PWM_IJ]			= &s4_pwm_ij.hw,
> +
> +		[CLKID_HDCP22_ESMCLK_SEL]	= &s4_hdcp22_esmclk_mux.hw,
> +		[CLKID_HDCP22_ESMCLK_DIV]	= &s4_hdcp22_esmclk_div.hw,
> +		[CLKID_HDCP22_ESMCLK_GATE]	= &s4_hdcp22_esmclk_gate.hw,
> +		[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_mux.hw,
> +		[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
> +		[CLKID_HDCP22_SKPCLK_GATE]	= &s4_hdcp22_skpclk_gate.hw,
> +
> +		[NR_CLKS]			= NULL
> +	},
> +	.num = NR_CLKS,
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const s4_periphs_clk_regmaps[] = {
> +	&s4_rtc_32k_by_oscin_clkin,
> +	&s4_rtc_32k_by_oscin_div,
> +	&s4_rtc_32k_by_oscin_sel,
> +	&s4_rtc_32k_by_oscin,
> +	&s4_rtc_clk,
> +

Same

> +	&s4_sysclk_b_sel,
> +	&s4_sysclk_b_div,
> +	&s4_sysclk_b,
> +	&s4_sysclk_a_sel,
> +	&s4_sysclk_a_div,
> +	&s4_sysclk_a,
> +	&s4_sys_clk,
> +
> +	&s4_ceca_32k_clkin,
> +	&s4_ceca_32k_div,
> +	&s4_ceca_32k_sel_pre,
> +	&s4_ceca_32k_sel,
> +	&s4_ceca_32k_clkout,
> +	&s4_cecb_32k_clkin,
> +	&s4_cecb_32k_div,
> +	&s4_cecb_32k_sel_pre,
> +	&s4_cecb_32k_sel,
> +	&s4_cecb_32k_clkout,
> +
> +	&s4_sc_clk_mux,
> +	&s4_sc_clk_div,
> +	&s4_sc_clk_gate,
> +
> +	&s4_12_24M_clk_gate,
> +	&s4_12_24M_clk,
> +	&s4_vid_pll_div,
> +	&s4_vid_pll_sel,
> +	&s4_vid_pll,
> +	&s4_vclk_sel,
> +	&s4_vclk2_sel,
> +	&s4_vclk_input,
> +	&s4_vclk2_input,
> +	&s4_vclk_div,
> +	&s4_vclk2_div,
> +	&s4_vclk,
> +	&s4_vclk2,
> +	&s4_vclk_div1,
> +	&s4_vclk_div2_en,
> +	&s4_vclk_div4_en,
> +	&s4_vclk_div6_en,
> +	&s4_vclk_div12_en,
> +	&s4_vclk2_div1,
> +	&s4_vclk2_div2_en,
> +	&s4_vclk2_div4_en,
> +	&s4_vclk2_div6_en,
> +	&s4_vclk2_div12_en,
> +	&s4_cts_enci_sel,
> +	&s4_cts_encp_sel,
> +	&s4_cts_vdac_sel,
> +	&s4_hdmi_tx_sel,
> +	&s4_cts_enci,
> +	&s4_cts_encp,
> +	&s4_cts_vdac,
> +	&s4_hdmi_tx,
> +
> +	&s4_hdmi_sel,
> +	&s4_hdmi_div,
> +	&s4_hdmi,
> +	&s4_ts_clk_div,
> +	&s4_ts_clk_gate,
> +
> +	&s4_mali_0_sel,
> +	&s4_mali_0_div,
> +	&s4_mali_0,
> +	&s4_mali_1_sel,
> +	&s4_mali_1_div,
> +	&s4_mali_1,
> +	&s4_mali_mux,
> +
> +	&s4_vdec_p0_mux,
> +	&s4_vdec_p0_div,
> +	&s4_vdec_p0,
> +	&s4_vdec_p1_mux,
> +	&s4_vdec_p1_div,
> +	&s4_vdec_p1,
> +	&s4_vdec_mux,
> +
> +	&s4_hevcf_p0_mux,
> +	&s4_hevcf_p0_div,
> +	&s4_hevcf_p0,
> +	&s4_hevcf_p1_mux,
> +	&s4_hevcf_p1_div,
> +	&s4_hevcf_p1,
> +	&s4_hevcf_mux,
> +
> +	&s4_vpu_0_sel,
> +	&s4_vpu_0_div,
> +	&s4_vpu_0,
> +	&s4_vpu_1_sel,
> +	&s4_vpu_1_div,
> +	&s4_vpu_1,
> +	&s4_vpu,
> +	&s4_vpu_clkb_tmp_mux,
> +	&s4_vpu_clkb_tmp_div,
> +	&s4_vpu_clkb_tmp,
> +	&s4_vpu_clkb_div,
> +	&s4_vpu_clkb,
> +	&s4_vpu_clkc_p0_mux,
> +	&s4_vpu_clkc_p0_div,
> +	&s4_vpu_clkc_p0,
> +	&s4_vpu_clkc_p1_mux,
> +	&s4_vpu_clkc_p1_div,
> +	&s4_vpu_clkc_p1,
> +	&s4_vpu_clkc_mux,
> +
> +	&s4_vapb_0_sel,
> +	&s4_vapb_0_div,
> +	&s4_vapb_0,
> +	&s4_vapb_1_sel,
> +	&s4_vapb_1_div,
> +	&s4_vapb_1,
> +	&s4_vapb,
> +	&s4_ge2d_gate,
> +
> +	&s4_hdcp22_esmclk_mux,
> +	&s4_hdcp22_esmclk_div,
> +	&s4_hdcp22_esmclk_gate,
> +	&s4_hdcp22_skpclk_mux,
> +	&s4_hdcp22_skpclk_div,
> +	&s4_hdcp22_skpclk_gate,
> +
> +	&s4_vdin_meas_mux,
> +	&s4_vdin_meas_div,
> +	&s4_vdin_meas_gate,
> +
> +	&s4_sd_emmc_c_clk0_sel,
> +	&s4_sd_emmc_c_clk0_div,
> +	&s4_sd_emmc_c_clk0,
> +	&s4_sd_emmc_a_clk0_sel,
> +	&s4_sd_emmc_a_clk0_div,
> +	&s4_sd_emmc_a_clk0,
> +	&s4_sd_emmc_b_clk0_sel,
> +	&s4_sd_emmc_b_clk0_div,
> +	&s4_sd_emmc_b_clk0,
> +
> +	&s4_spicc0_mux,
> +	&s4_spicc0_div,
> +	&s4_spicc0_gate,
> +
> +	&s4_pwm_a_mux,
> +	&s4_pwm_a_div,
> +	&s4_pwm_a_gate,
> +	&s4_pwm_b_mux,
> +	&s4_pwm_b_div,
> +	&s4_pwm_b_gate,
> +	&s4_pwm_c_mux,
> +	&s4_pwm_c_div,
> +	&s4_pwm_c_gate,
> +	&s4_pwm_d_mux,
> +	&s4_pwm_d_div,
> +	&s4_pwm_d_gate,
> +	&s4_pwm_e_mux,
> +	&s4_pwm_e_div,
> +	&s4_pwm_e_gate,
> +	&s4_pwm_f_mux,
> +	&s4_pwm_f_div,
> +	&s4_pwm_f_gate,
> +	&s4_pwm_g_mux,
> +	&s4_pwm_g_div,
> +	&s4_pwm_g_gate,
> +	&s4_pwm_h_mux,
> +	&s4_pwm_h_div,
> +	&s4_pwm_h_gate,
> +	&s4_pwm_i_mux,
> +	&s4_pwm_i_div,
> +	&s4_pwm_i_gate,
> +	&s4_pwm_j_mux,
> +	&s4_pwm_j_div,
> +	&s4_pwm_j_gate,
> +
> +	&s4_saradc_mux,
> +	&s4_saradc_div,
> +	&s4_saradc_gate,
> +
> +	&s4_gen_clk_sel,
> +	&s4_gen_clk_div,
> +	&s4_gen_clk,
> +
> +	&s4_ddr,
> +	&s4_dos,
> +	&s4_ethphy,
> +	&s4_mali,
> +	&s4_aocpu,
> +	&s4_aucpu,
> +	&s4_cec,
> +	&s4_sdemmca,
> +	&s4_sdemmcb,
> +	&s4_nand,
> +	&s4_smartcard,
> +	&s4_acodec,
> +	&s4_spifc,
> +	&s4_msr_clk,
> +	&s4_ir_ctrl,
> +	&s4_audio,
> +	&s4_eth,
> +	&s4_uart_a,
> +	&s4_uart_b,
> +	&s4_uart_c,
> +	&s4_uart_d,
> +	&s4_uart_e,
> +	&s4_aififo,
> +	&s4_ts_ddr,
> +	&s4_ts_pll,
> +	&s4_g2d,
> +	&s4_spicc0,
> +	&s4_usb,
> +	&s4_i2c_m_a,
> +	&s4_i2c_m_b,
> +	&s4_i2c_m_c,
> +	&s4_i2c_m_d,
> +	&s4_i2c_m_e,
> +	&s4_hdmitx_apb,
> +	&s4_i2c_s_a,
> +	&s4_usb1_to_ddr,
> +	&s4_hdcp22,
> +	&s4_mmc_apb,
> +	&s4_rsa,
> +	&s4_cpu_debug,
> +	&s4_vpu_intr,
> +	&s4_demod,
> +	&s4_sar_adc,
> +	&s4_gic,
> +	&s4_pwm_ab,
> +	&s4_pwm_cd,
> +	&s4_pwm_ef,
> +	&s4_pwm_gh,
> +	&s4_pwm_ij,
> +	&s4_demod_core_clk_mux,
> +	&s4_demod_core_clk_div,
> +	&s4_demod_core_clk_gate,
> +	&s4_adc_extclk_in_mux,
> +	&s4_adc_extclk_in_div,
> +	&s4_adc_extclk_in_gate,
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static int meson_s4_periphs_probe(struct platform_device *pdev)
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
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(s4_periphs_clk_regmaps); i++)
> +		s4_periphs_clk_regmaps[i]->map = regmap;
> +
> +	for (i = 0; i < s4_periphs_hw_onecell_data.num; i++) {
> +		/* array might be sparse */
> +		if (!s4_periphs_hw_onecell_data.hws[i])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, s4_periphs_hw_onecell_data.hws[i]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &s4_periphs_hw_onecell_data);
> +}
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,s4-periphs-clkc",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver s4_driver = {
> +	.probe		= meson_s4_periphs_probe,
> +	.driver		= {
> +		.name	= "s4-periphs-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(s4_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/s4.h b/drivers/clk/meson/s4.h
> new file mode 100644
> index 000000000000..15fb9bec592b
> --- /dev/null
> +++ b/drivers/clk/meson/s4.h
> @@ -0,0 +1,232 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __MESON_S4_H__
> +#define __MESON_S4_H__
> +
> +/*
> + * Clock controller register offsets
> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe000000
> + */
> +#define CLKCTRL_OSCIN_CTRL                         (0x0001 << 2)

Same comment as the PLL controller

> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 (0x0002 << 2)
> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 (0x0003 << 2)
> +#define CLKCTRL_RTC_CTRL                           (0x0004 << 2)
> +#define CLKCTRL_CHECK_CLK_RESULT                   (0x0005 << 2)
> +#define CLKCTRL_MBIST_ATSPEED_CTRL                 (0x0006 << 2)
> +#define CLKCTRL_LOCK_BIT_REG0                      (0x0008 << 2)
> +#define CLKCTRL_LOCK_BIT_REG1                      (0x0009 << 2)
> +#define CLKCTRL_LOCK_BIT_REG2                      (0x000a << 2)
> +#define CLKCTRL_LOCK_BIT_REG3                      (0x000b << 2)
> +#define CLKCTRL_PROT_BIT_REG0                      (0x000c << 2)
> +#define CLKCTRL_PROT_BIT_REG1                      (0x000d << 2)
> +#define CLKCTRL_PROT_BIT_REG2                      (0x000e << 2)
> +#define CLKCTRL_PROT_BIT_REG3                      (0x000f << 2)
> +#define CLKCTRL_SYS_CLK_CTRL0                      (0x0010 << 2)
> +#define CLKCTRL_SYS_CLK_EN0_REG0                   (0x0011 << 2)
> +#define CLKCTRL_SYS_CLK_EN0_REG1                   (0x0012 << 2)
> +#define CLKCTRL_SYS_CLK_EN0_REG2                   (0x0013 << 2)
> +#define CLKCTRL_SYS_CLK_EN0_REG3                   (0x0014 << 2)
> +#define CLKCTRL_SYS_CLK_EN1_REG0                   (0x0015 << 2)
> +#define CLKCTRL_SYS_CLK_EN1_REG1                   (0x0016 << 2)
> +#define CLKCTRL_SYS_CLK_EN1_REG2                   (0x0017 << 2)
> +#define CLKCTRL_SYS_CLK_EN1_REG3                   (0x0018 << 2)
> +#define CLKCTRL_SYS_CLK_VPU_EN0                    (0x0019 << 2)
> +#define CLKCTRL_SYS_CLK_VPU_EN1                    (0x001a << 2)
> +#define CLKCTRL_AXI_CLK_CTRL0                      (0x001b << 2)
> +#define CLKCTRL_TST_CTRL0                          (0x0020 << 2)
> +#define CLKCTRL_TST_CTRL1                          (0x0021 << 2)
> +#define CLKCTRL_CECA_CTRL0                         (0x0022 << 2)
> +#define CLKCTRL_CECA_CTRL1                         (0x0023 << 2)
> +#define CLKCTRL_CECB_CTRL0                         (0x0024 << 2)
> +#define CLKCTRL_CECB_CTRL1                         (0x0025 << 2)
> +#define CLKCTRL_SC_CLK_CTRL                        (0x0026 << 2)
> +#define CLKCTRL_DSPA_CLK_CTRL0                     (0x0027 << 2)
> +#define CLKCTRL_DSPB_CLK_CTRL0                     (0x0028 << 2)
> +#define CLKCTRL_RAMA_CLK_CTRL0                     (0x0029 << 2)
> +#define CLKCTRL_CLK12_24_CTRL                      (0x002a << 2)
> +#define CLKCTRL_VID_CLK_CTRL                       (0x0030 << 2)
> +#define CLKCTRL_VID_CLK_CTRL2                      (0x0031 << 2)
> +#define CLKCTRL_VID_CLK_DIV                        (0x0032 << 2)
> +#define CLKCTRL_VIID_CLK_DIV                       (0x0033 << 2)
> +#define CLKCTRL_VIID_CLK_CTRL                      (0x0034 << 2)
> +#define CLKCTRL_HDMI_CLK_CTRL                      (0x0038 << 2)
> +#define CLKCTRL_VID_PLL_CLK_DIV                    (0x0039 << 2)
> +#define CLKCTRL_VPU_CLK_CTRL                       (0x003a << 2)
> +#define CLKCTRL_VPU_CLKB_CTRL                      (0x003b << 2)
> +#define CLKCTRL_VPU_CLKC_CTRL                      (0x003c << 2)
> +#define CLKCTRL_VID_LOCK_CLK_CTRL                  (0x003d << 2)
> +#define CLKCTRL_VDIN_MEAS_CLK_CTRL                 (0x003e << 2)
> +#define CLKCTRL_VAPBCLK_CTRL                       (0x003f << 2)
> +#define CLKCTRL_HDCP22_CTRL                        (0x0040 << 2)
> +#define CLKCTRL_MIPIDSI_PHY_CLK_CTRL               (0x0041 << 2)
> +#define CLKCTRL_CDAC_CLK_CTRL                      (0x0042 << 2)
> +#define CLKCTRL_MIPI_CSI_PHY_CLK_CTRL              (0x0043 << 2)
> +#define CLKCTRL_CSI2_ADAPT_CLK_CTRL                (0x0044 << 2)
> +#define CLKCTRL_VDEC_CLK_CTRL                      (0x0050 << 2)
> +#define CLKCTRL_VDEC2_CLK_CTRL                     (0x0051 << 2)
> +#define CLKCTRL_VDEC3_CLK_CTRL                     (0x0052 << 2)
> +#define CLKCTRL_VDEC4_CLK_CTRL                     (0x0053 << 2)
> +#define CLKCTRL_WAVE420L_CLK_CTRL                  (0x0054 << 2)
> +#define CLKCTRL_WAVE420L_CLK_CTRL2                 (0x0055 << 2)
> +#define CLKCTRL_TS_CLK_CTRL                        (0x0056 << 2)
> +#define CLKCTRL_MALI_CLK_CTRL                      (0x0057 << 2)
> +#define CLKCTRL_VIPNANOQ_CLK_CTRL                  (0x0058 << 2)
> +#define CLKCTRL_ETH_CLK_CTRL                       (0x0059 << 2)
> +#define CLKCTRL_NAND_CLK_CTRL                      (0x005a << 2)
> +#define CLKCTRL_SD_EMMC_CLK_CTRL                   (0x005b << 2)
> +#define CLKCTRL_BT656_CLK_CTRL                     (0x005c << 2)
> +#define CLKCTRL_SPICC_CLK_CTRL                     (0x005d << 2)
> +#define CLKCTRL_GEN_CLK_CTRL                       (0x005e << 2)
> +#define CLKCTRL_SAR_CLK_CTRL                       (0x005f << 2)
> +#define CLKCTRL_PWM_CLK_AB_CTRL                    (0x0060 << 2)
> +#define CLKCTRL_PWM_CLK_CD_CTRL                    (0x0061 << 2)
> +#define CLKCTRL_PWM_CLK_EF_CTRL                    (0x0062 << 2)
> +#define CLKCTRL_PWM_CLK_GH_CTRL                    (0x0063 << 2)
> +#define CLKCTRL_PWM_CLK_IJ_CTRL                    (0x0064 << 2)
> +#define CLKCTRL_DEMOD_CLK_CTRL                     (0x0080 << 2)
> +#define CLKCTRL_DEMOD_CLK_CTRL1                    (0x0081 << 2)
> +#define CLKCTRL_DEMOD_32K_CTRL0                    (0x0082 << 2)
> +#define CLKCTRL_DEMOD_32K_CTRL1                    (0x0083 << 2)
> +#define CLKCTRL_TIMESTAMP_CTRL                     (0x0100 << 2)
> +#define CLKCTRL_TIMESTAMP_CTRL1                    (0x0101 << 2)
> +#define CLKCTRL_TIMESTAMP_CTRL2                    (0x0103 << 2)
> +#define CLKCTRL_TIMESTAMP_RD0                      (0x0104 << 2)
> +#define CLKCTRL_TIMESTAMP_RD1                      (0x0105 << 2)
> +#define CLKCTRL_TIMEBASE_CTRL0                     (0x0106 << 2)
> +#define CLKCTRL_TIMEBASE_CTRL1                     (0x0107 << 2)
> +#define CLKCTRL_EFUSE_CPU_CFG01                    (0x0120 << 2)
> +#define CLKCTRL_EFUSE_CPU_CFG2                     (0x0121 << 2)
> +#define CLKCTRL_EFUSE_ENCP_CFG0                    (0x0122 << 2)
> +#define CLKCTRL_EFUSE_MALI_CFG01                   (0x0123 << 2)
> +#define CLKCTRL_EFUSE_HEVCB_CFG01                  (0x0124 << 2)
> +#define CLKCTRL_EFUSE_HEVCB_CFG2                   (0x0125 << 2)
> +#define CLKCTRL_EFUSE_LOCK                         (0x0126 << 2)
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
> +#define CLKID_RTC_32K_CLKIN		117
> +#define CLKID_RTC_32K_DIV		118
> +#define CLKID_RTC_32K_SEL		119
> +#define CLKID_RTC_32K_XATL		120
> +#define CLKID_SYS_CLK_B_SEL		121
> +#define CLKID_SYS_CLK_B_DIV		122
> +#define CLKID_SYS_CLK_A_SEL		123
> +#define CLKID_SYS_CLK_A_DIV		124
> +#define CLKID_CECA_32K_CLKIN		125
> +#define CLKID_CECA_32K_DIV		126
> +#define CLKID_CECA_32K_SEL_PRE		127
> +#define CLKID_CECA_32K_SEL		128
> +#define CLKID_CECB_32K_CLKIN		129
> +#define CLKID_CECB_32K_DIV		130
> +#define CLKID_CECB_32K_SEL_PRE		131
> +#define CLKID_CECB_32K_SEL		132
> +#define CLKID_SC_CLK_SEL		133
> +#define CLKID_SC_CLK_DIV		134
> +#define CLKID_12_24M_CLK_GATE		135
> +#define CLKID_12M_CLK_DIV		136
> +#define CLKID_VID_PLL_DIV		137
> +#define CLKID_VID_PLL_SEL		138
> +#define CLKID_VCLK_SEL			139
> +#define CLKID_VCLK2_SEL			140
> +#define CLKID_VCLK_INPUT		141
> +#define CLKID_VCLK2_INPUT		142
> +#define CLKID_VCLK_DIV			143
> +#define CLKID_VCLK2_DIV			144
> +#define CLKID_VCLK_DIV2_EN		145
> +#define CLKID_VCLK_DIV4_EN		146
> +#define CLKID_VCLK_DIV6_EN		147
> +#define CLKID_VCLK_DIV12_EN		148
> +#define CLKID_VCLK2_DIV2_EN		149
> +#define CLKID_VCLK2_DIV4_EN		150
> +#define CLKID_VCLK2_DIV6_EN		151
> +#define CLKID_VCLK2_DIV12_EN		152
> +#define CLKID_CTS_ENCI_SEL		153
> +#define CLKID_CTS_ENCP_SEL		154
> +#define CLKID_CTS_VDAC_SEL		155
> +#define CLKID_HDMI_TX_SEL		156
> +#define CLKID_HDMI_TX			157
> +#define CLKID_HDMI_SEL			158
> +#define CLKID_HDMI_DIV			159
> +#define CLKID_TS_CLK_DIV		160
> +#define CLKID_MALI_0_SEL		161
> +#define CLKID_MALI_0_DIV		162
> +#define CLKID_MALI_1_SEL		163
> +#define CLKID_MALI_1_DIV		164
> +#define CLKID_VDEC_P0_SEL		165
> +#define CLKID_VDEC_P0_DIV		166
> +#define CLKID_VDEC_P1_SEL		167
> +#define CLKID_VDEC_P1_DIV		168
> +#define CLKID_HEVCF_P0_SEL		169
> +#define CLKID_HEVCF_P0_DIV		170
> +#define CLKID_HEVCF_P1_SEL		171
> +#define CLKID_HEVCF_P1_DIV		172
> +#define CLKID_VPU_0_SEL			173
> +#define CLKID_VPU_0_DIV			174
> +#define CLKID_VPU_1_SEL			175
> +#define CLKID_VPU_1_DIV			176
> +#define CLKID_VPU_CLKB_TMP_SEL		177
> +#define CLKID_VPU_CLKB_TMP_DIV		178
> +#define CLKID_VPU_CLKB_DIV		179
> +#define CLKID_VPU_CLKC_P0_SEL		180
> +#define CLKID_VPU_CLKC_P0_DIV		181
> +#define CLKID_VPU_CLKC_P1_SEL		182
> +#define CLKID_VPU_CLKC_P1_DIV		183
> +#define CLKID_VAPB_0_SEL		184
> +#define CLKID_VAPB_0_DIV		185
> +#define CLKID_VAPB_1_SEL		186
> +#define CLKID_VAPB_1_DIV		187
> +#define CLKID_VDIN_MEAS_SEL		188
> +#define CLKID_VDIN_MEAS_DIV		189
> +#define CLKID_SD_EMMC_C_CLK_SEL		190
> +#define CLKID_SD_EMMC_C_CLK_DIV		191
> +#define CLKID_SD_EMMC_A_CLK_SEL		192
> +#define CLKID_SD_EMMC_A_CLK_DIV		193
> +#define CLKID_SD_EMMC_B_CLK_SEL		194
> +#define CLKID_SD_EMMC_B_CLK_DIV		195
> +#define CLKID_SPICC0_SEL		196
> +#define CLKID_SPICC0_DIV		197
> +#define CLKID_PWM_A_SEL			198
> +#define CLKID_PWM_A_DIV			199
> +#define CLKID_PWM_B_SEL			200
> +#define CLKID_PWM_B_DIV			201
> +#define CLKID_PWM_C_SEL			202
> +#define CLKID_PWM_C_DIV			203
> +#define CLKID_PWM_D_SEL			204
> +#define CLKID_PWM_D_DIV			205
> +#define CLKID_PWM_E_SEL			206
> +#define CLKID_PWM_E_DIV			207
> +#define CLKID_PWM_F_SEL			208
> +#define CLKID_PWM_F_DIV			209
> +#define CLKID_PWM_G_SEL			210
> +#define CLKID_PWM_G_DIV			211
> +#define CLKID_PWM_H_SEL			212
> +#define CLKID_PWM_H_DIV			213
> +#define CLKID_PWM_I_SEL			214
> +#define CLKID_PWM_I_DIV			215
> +#define CLKID_PWM_J_SEL			216
> +#define CLKID_PWM_J_DIV			217
> +#define CLKID_SARADC_SEL		218
> +#define CLKID_SARADC_DIV		219
> +#define CLKID_GEN_SEL			220
> +#define CLKID_GEN_DIV			221
> +#define CLKID_HDCP22_ESMCLK_SEL		222
> +#define CLKID_HDCP22_ESMCLK_DIV		223
> +#define CLKID_HDCP22_SKPCLK_SEL		224
> +#define CLKID_HDCP22_SKPCLK_DIV		225
> +
> +#define NR_CLKS				226
> +/* include the CLKIDs that have been made part of the DT binding */
> +#include <dt-bindings/clock/amlogic,s4-clkc.h>
> +
> +#endif /* __MESON_S4_H__ */

