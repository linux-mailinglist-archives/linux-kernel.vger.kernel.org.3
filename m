Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1C472C09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhLMMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:11:52 -0500
Received: from smtpcmd0986.aruba.it ([62.149.156.86]:37965 "EHLO
        smtpcmd0986.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbhLMMLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:11:51 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id wkBHm7dpyq3qKwkBHmBbYl; Mon, 13 Dec 2021 13:11:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639397509; bh=drYARyVjOeljg12C/GUwtxc8Npgm5VoDO/Rlqxosyiw=;
        h=Subject:From:To:Date:MIME-Version:Content-Type;
        b=RhDecNf0gWBnzFQ3p9vgeViTm+00Yy/QJM0Nq9F0ZexAVtm+RQ0D4KJyJlfbEGODO
         VJjcBSg9vvMCqhW12qab4PO/8p2tUsIlf2CxN+hj2Fw5knHhoqDdvmMX7pBk8upuoN
         hzc98FCYruZmzrO93k0ZQ9jgzpBTyChL5spunxq/iBPMp6DyE5HwWDLIwFixEGDWX4
         cfpYtRV6UqZZZY2t16lC1uvlQPl3jQlbA2hR9ObuFy+a7jBlPWfSJASya0ZbhVM7Ya
         AXBWeTkusAl83b8KYdZvMxJ+mi5oqSE6kXkhsfZBzxxYHCW93/KKBzLESkbFmwaeH8
         CkBjZYpNW524Q==
Subject: Re: [PATCH v4 07/13] clk: imx: Add initial support for i.MXRT clock
 driver
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, adrian.hunter@intel.com,
        jirislaby@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-8-Mr.Bossman075@gmail.com> <YbcuweQlw3inhye1@ryzen>
 <bc7a718c-2cb7-1c23-a8fe-524b327fbcd5@benettiengineering.com>
Message-ID: <50c4e81f-2905-6c30-3a3e-20237b71c262@benettiengineering.com>
Date:   Mon, 13 Dec 2021 13:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bc7a718c-2cb7-1c23-a8fe-524b327fbcd5@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDzSWdO7DVRoR8yiOR72gXaJzQjCCBEILLSxjdn2NhUNRSsXIudnWnBG8omqTTrzMPv/SAi5DNH7xleF/74F/6/i/GSdRGuxFA2st8VQTUUKuxJXqnMn
 ABRUyUSSq1uvkbp3Sby+jwcMRhuwa10AVHnjsPFomtGe/NpBqOGYdEZwHL4rwS+SEwUjcrP1MgpHno8pk0Z5vLNsxZ8LvSazn2Z5SuQfEN0B0hegXMAJCsEH
 AljT6zVSLXM8Gm9Btss0KpiVPIUcG9DAnByezMpYMM4UY3COe7oB86/2E99b05qv+EXxi+e/3ZldttaG/vTZUp6J8KPyunbCZQxf/hqX/Pgp4AhoiaKhl9Lg
 DyEHiZsWVVhtlXKJn4Sz44vFysaJXTKyVYJkbYe7+n9S+x9D+lWeNLsmyurawEzm4IoIazlAC46AyivfBdzbT6t3JCnHt6pFcMrMMxa1ea7IUslQZzQl044h
 bMh/71L9siTx5XiCPk8Ewe8VeVTfm9Z6tj8Up+QMQUzaewo1+pT4axYQ3Sn2coKncmapl8KRe5ISn45FzVrPpEqyzsdc53j9d/S9KCsmyliurVyYMzpLlekm
 bu0f9ToVN4R7nO+KhfOWsJmaqzcfa0RuzxcTD+CIQSI17TY+H9YPkPh4q/uCIF7JJ8B4orrixkCkHkqGwACwheKVl/bcqjXcLZjjpP/YJ3xJVmqvGOpkjNgO
 DyV2r8WgcfpkoTKmBdYpLJgQnPUxjYGUmmuGsAev9aQZNDwRfnQEKPbUjNAkVDMt1l0gmEvSMpdoangsjHrDpes1qjdyj3L+UUKA285FzjLqtZ1lES5w0+hj
 L8AHcus5HSrkGft3pRfOUkdpEdpVOnfmOXbTN1eybGYjkM6m+fYeIQme7N7x22wN7qWuvXsXDCQBwIp0r6LRqwK9ng4z/UWJ449tthcGCRAp7KDdYfYXBkVf
 bZzj3ZTkMhTG+tluBlVedF9sLj2KYi7bVRQsEfPT/iScpHgONLlA7a28txrnu8mwUTUKwIf0Nme7PpLTAw5/rvltLMtk9TnnfGErfhD5Vyr2sYOwouRHB+/f
 lxWEq4XE9gWRq9p/epogNHnzWf4tEazSJDZO0V2/ucqilUstTx2NQPGktF37F6IfMu+E/zk+qEbuIiNFDyxziypQ46ooPcUdQn0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel, Jesse,

On 13/12/21 13:05, Giulio Benetti wrote:
> Hi Abel,
> 
> On 13/12/21 12:30, Abel Vesa wrote:
>> On 21-12-04 01:10:36, Jesse Taube wrote:
>>> Add clock driver support for i.MXRT1***s starting with the i.MXRT1050.
>>>
>>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>>> Suggested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> ---
>>> V1->V2:
>>> * Kconfig: Add new line
>>> * clk-imxrt.c: Remove unused const
>>> * clk-imxrt.c: Remove set parents
>>> * clk-imxrt.c: Use fsl,imxrt-anatop for anatop base address
>>> V2->V3:
>>> * Remove unused ANATOP_BASE_ADDR
>>> * Move to hw API
>>> * Add GPT's own clock
>>> * Add SEMC clocks to set muxing to CRITICAL
>>> V3->V4:
>>> * Rename clk-imxrt.c to clk-imxrt1050.c
>>> * Rename CONFIG_CLK_IMXRT to CONFIG_CLK_IMXRT1050
>>> * Make CONFIG_CLK_IMXRT1050 selectable
>>> ---
>>>    drivers/clk/imx/Kconfig         |   5 +
>>>    drivers/clk/imx/Makefile        |   1 +
>>>    drivers/clk/imx/clk-imxrt1050.c | 156 ++++++++++++++++++++++++++++++++
>>>    3 files changed, 162 insertions(+)
>>>    create mode 100644 drivers/clk/imx/clk-imxrt1050.c
>>>
>>> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
>>> index c08edbd04d22..f697652ab19c 100644
>>> --- a/drivers/clk/imx/Kconfig
>>> +++ b/drivers/clk/imx/Kconfig
>>> @@ -105,3 +105,8 @@ config CLK_IMX8ULP
>>>    	select MXC_CLK
>>>    	help
>>>    	    Build the driver for i.MX8ULP CCM Clock Driver
>>> +
>>> +config CLK_IMXRT1050
>>> +	bool "IMXRT1050 CCM Clock Driver"
>>> +	depends on SOC_IMXRT
>>> +	select MXC_CLK
>>> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
>>> index b5e040026dfb..3d9a1e3b5fc6 100644
>>> --- a/drivers/clk/imx/Makefile
>>> +++ b/drivers/clk/imx/Makefile
>>> @@ -47,3 +47,4 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
>>>    obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
>>>    obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
>>>    obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
>>> +obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
>>> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
>>> new file mode 100644
>>> index 000000000000..85ba1a240335
>>> --- /dev/null
>>> +++ b/drivers/clk/imx/clk-imxrt1050.c
>>> @@ -0,0 +1,156 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>> +/*
>>> + * Copyright (C) 2021
>>> + * Author(s):
>>> + * Jesse Taube <Mr.Bossman075@gmail.com>
>>> + * Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> + */
>>> +#include <linux/mm.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/clkdev.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/err.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/sizes.h>
>>> +#include <soc/imx/revision.h>
>>> +#include <dt-bindings/clock/imxrt1050-clock.h>
>>> +
>>> +#include "clk.h"
>>> +
>>> +static const char * const pll_ref_sels[] = {"osc", "dummy", };
>>> +static const char * const per_sels[] = {"ipg_pdof", "osc", };
>>> +static const char * const pll1_bypass_sels[] = {"pll1_arm", "pll1_arm_ref_sel", };
>>> +static const char * const pll2_bypass_sels[] = {"pll2_sys", "pll2_sys_ref_sel", };
>>> +static const char * const pll3_bypass_sels[] = {"pll3_usb_otg", "pll3_usb_otg_ref_sel", };
>>> +static const char * const pll5_bypass_sels[] = {"pll5_video", "pll5_video_ref_sel", };
>>> +static const char *const pre_periph_sels[] = {
>>> +	"pll2_sys", "pll2_pfd2_396m", "pll2_pfd0_352m", "arm_podf", };
>>> +static const char *const periph_sels[] = { "pre_periph_sel", "todo", };
>>> +static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
>>> +static const char *const lpuart_sels[] = { "pll3_80m", "osc", };
>>> +static const char *const lcdif_sels[] = {
>>> +	"pll2_sys", "pll3_pfd3_454_74m", "pll5_video", "pll2_pfd0_352m",
>>> +	"pll2_pfd1_594m", "pll3_pfd1_664_62m", };
>>> +static const char *const semc_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_664_62m", };
>>> +static const char *const semc_sels[] = { "periph_sel", "semc_alt_sel", };
>>> +
>>> +static struct clk_hw **hws;
>>> +static struct clk_hw_onecell_data *clk_hw_data;
>>> +
>>> +static void __init imxrt_clocks_common_init(void __iomem *base)
>>> +{
>>> +	/* Anatop clocks */
>>> +	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
>>> +
>>> +	hws[IMXRT1050_CLK_PLL1_REF_SEL] = imx_clk_hw_mux("pll1_arm_ref_sel",
>>> +		base + 0x0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>>> +	hws[IMXRT1050_CLK_PLL2_REF_SEL] = imx_clk_hw_mux("pll2_sys_ref_sel",
>>> +		base + 0x30, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>>> +	hws[IMXRT1050_CLK_PLL3_REF_SEL] = imx_clk_hw_mux("pll3_usb_otg_ref_sel",
>>> +		base + 0x10, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>>> +	hws[IMXRT1050_CLK_PLL5_REF_SEL] = imx_clk_hw_mux("pll5_video_ref_sel",
>>> +		base + 0xa0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>>> +
>>> +	hws[IMXRT1050_CLK_PLL1_ARM] = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll1_arm",
>>> +		"pll1_arm_ref_sel", base + 0x0, 0x7f);
>>> +	hws[IMXRT1050_CLK_PLL2_SYS] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2_sys",
>>> +		"pll2_sys_ref_sel", base + 0x30, 0x1);
>>> +	hws[IMXRT1050_CLK_PLL3_USB_OTG] = imx_clk_hw_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
>>> +		"pll3_usb_otg_ref_sel", base + 0x10, 0x1);
>>> +	hws[IMXRT1050_CLK_PLL5_VIDEO] = imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll5_video",
>>> +		"pll5_video_ref_sel", base + 0xa0, 0x7f);
>>> +
>>> +	/* PLL bypass out */
>>> +	hws[IMXRT1050_CLK_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", base + 0x0, 16, 1,
>>> +		pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
>>> +	hws[IMXRT1050_CLK_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", base + 0x30, 16, 1,
>>> +		pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
>>> +	hws[IMXRT1050_CLK_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", base + 0x10, 16, 1,
>>> +		pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
>>> +	hws[IMXRT1050_CLK_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1,
>>> +		pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
>>> +
>>> +	hws[IMXRT1050_CLK_VIDEO_POST_DIV_SEL] = imx_clk_hw_divider("video_post_div_sel",
>>> +		"pll5_video", base + 0xa0, 19, 2);
>>> +	hws[IMXRT1050_CLK_VIDEO_DIV] = imx_clk_hw_divider("video_div",
>>> +		"video_post_div_sel", base + 0x170, 30, 2);
>>> +
>>> +	hws[IMXRT1050_CLK_PLL3_80M] = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg", 1, 6);
>>> +
>>> +	hws[IMXRT1050_CLK_PLL2_PFD0_352M] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_sys", base + 0x100, 0);
>>> +	hws[IMXRT1050_CLK_PLL2_PFD1_594M] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_sys", base + 0x100, 1);
>>> +	hws[IMXRT1050_CLK_PLL2_PFD2_396M] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_sys", base + 0x100, 2);
>>> +	hws[IMXRT1050_CLK_PLL3_PFD1_664_62M] = imx_clk_hw_pfd("pll3_pfd1_664_62m", "pll3_usb_otg", base + 0xf0, 1);
>>> +	hws[IMXRT1050_CLK_PLL3_PFD3_454_74M] = imx_clk_hw_pfd("pll3_pfd3_454_74m", "pll3_usb_otg", base + 0xf0, 3);
>>> +}
>>> +
>>> +static void __init imxrt1050_clocks_init(struct device_node *np)
>>> +{
>>> +	void __iomem *ccm_base;
>>> +	void __iomem *pll_base;
>>> +	struct device_node *anp;
>>> +
>>> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
>>> +					  IMXRT1050_CLK_END), GFP_KERNEL);
>>> +	if (WARN_ON(!clk_hw_data))
>>> +		return;
>>> +
>>> +	clk_hw_data->num = IMXRT1050_CLK_END;
>>> +	hws = clk_hw_data->hws;
>>> +
>>> +	hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
>>> +
>>> +	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
>>> +	pll_base = of_iomap(anp, 0);
>>> +	WARN_ON(!pll_base);
>>> +	imxrt_clocks_common_init(pll_base);
>>> +	/* CCM clocks */
>>> +	ccm_base = of_iomap(np, 0);
>>> +	WARN_ON(!ccm_base);
>>> +
>>> +	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
>>> +	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
>>> +		pre_periph_sels, ARRAY_SIZE(pre_periph_sels));
>>> +	hws[IMXRT1050_CLK_PERIPH_SEL] = imx_clk_hw_mux("periph_sel", ccm_base + 0x14, 25, 1,
>>> +		periph_sels, ARRAY_SIZE(periph_sels));
>>> +	hws[IMXRT1050_CLK_USDHC1_SEL] = imx_clk_hw_mux("usdhc1_sel", ccm_base + 0x1c, 16, 1,
>>> +		usdhc_sels, ARRAY_SIZE(usdhc_sels));
>>> +	hws[IMXRT1050_CLK_USDHC2_SEL] = imx_clk_hw_mux("usdhc2_sel", ccm_base + 0x1c, 17, 1,
>>> +		usdhc_sels, ARRAY_SIZE(usdhc_sels));
>>> +	hws[IMXRT1050_CLK_LPUART_SEL] = imx_clk_hw_mux("lpuart_sel", ccm_base + 0x24, 6, 1,
>>> +		lpuart_sels, ARRAY_SIZE(lpuart_sels));
>>> +	hws[IMXRT1050_CLK_LCDIF_SEL] = imx_clk_hw_mux("lcdif_sel", ccm_base + 0x38, 15, 3,
>>> +		lcdif_sels, ARRAY_SIZE(lcdif_sels));
>>> +	hws[IMXRT1050_CLK_PER_CLK_SEL] = imx_clk_hw_mux("per_sel", ccm_base + 0x1C, 6, 1,
>>> +		per_sels, ARRAY_SIZE(per_sels));
>>> +	hws[IMXRT1050_CLK_SEMC_ALT_SEL] = imx_clk_hw_mux("semc_alt_sel", ccm_base + 0x14, 7, 1,
>>> +		semc_alt_sels, ARRAY_SIZE(semc_alt_sels));
>>> +	hws[IMXRT1050_CLK_SEMC_SEL] = imx_clk_hw_mux_flags("semc_sel", ccm_base + 0x14, 6, 1,
>>> +		semc_sels, ARRAY_SIZE(semc_sels), CLK_IS_CRITICAL);
>>> +
>>> +	hws[IMXRT1050_CLK_AHB_PODF] = imx_clk_hw_divider("ahb", "periph_sel", ccm_base + 0x14, 10, 3);
>>> +	hws[IMXRT1050_CLK_IPG_PDOF] = imx_clk_hw_divider("ipg", "ahb", ccm_base + 0x14, 8, 2);
>>> +	hws[IMXRT1050_CLK_PER_PDOF] = imx_clk_hw_divider("per", "per_sel", ccm_base + 0x1C, 0, 5);
>>> +
>>> +	hws[IMXRT1050_CLK_USDHC1_PODF] = imx_clk_hw_divider("usdhc1_podf", "usdhc1_sel", ccm_base + 0x24, 11, 3);
>>> +	hws[IMXRT1050_CLK_USDHC2_PODF] = imx_clk_hw_divider("usdhc2_podf", "usdhc2_sel", ccm_base + 0x24, 16, 3);
>>> +	hws[IMXRT1050_CLK_LPUART_PODF] = imx_clk_hw_divider("lpuart_podf", "lpuart_sel", ccm_base + 0x24, 0, 6);
>>> +	hws[IMXRT1050_CLK_LCDIF_PRED] = imx_clk_hw_divider("lcdif_pred", "lcdif_sel", ccm_base + 0x38, 12, 3);
>>> +	hws[IMXRT1050_CLK_LCDIF_PODF] = imx_clk_hw_divider("lcdif_podf", "lcdif_pred", ccm_base + 0x18, 23, 3);
>>> +
>>> +	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
>>> +	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
>>> +	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
>>> +	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
>>> +	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
>>> +	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
>>> +	hws[IMXRT1050_CLK_GPT] = imx_clk_hw_fixed_factor("gpt", "osc", 1, 8);
>>> +	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
>>> +
>>> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
>>> +}
>>> +CLK_OF_DECLARE(imxrt_ccm, "fsl,imxrt1050-ccm", imxrt1050_clocks_init);
>>
>> I would suggest module platform driver instead.
> 
> Can you please point us an example?

Sorry, I've found already the clk-imx8mq.c as an example.

@Jesse, if you want here is a change to do on this driver or let me know 
if I have to make it.

Thank you all
Best regards
-- 
Giulio Benetti
Benetti Engineering sas
