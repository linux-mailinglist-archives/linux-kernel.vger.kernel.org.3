Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27198570422
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiGKNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:23:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714BB3DF0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:23:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oAtNW-0006xY-HM; Mon, 11 Jul 2022 15:23:10 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1oAtNT-0001Ww-Vt; Mon, 11 Jul 2022 15:23:07 +0200
Date:   Mon, 11 Jul 2022 15:23:07 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] clk: baikal-t1: Move reset-controls code into a
 dedicated module
Message-ID: <20220711132307.GA3771@pengutronix.de>
References: <20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru>
 <20220708192725.9501-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708192725.9501-6-Sergey.Semin@baikalelectronics.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:27:23PM +0300, Serge Semin wrote:
> Before adding the directly controlled resets support it's reasonable to
> move the existing resets control functionality into a dedicated object for
> the sake of the CCU dividers clock driver simplification. After the new
> functionality was added clk-ccu-div.c would have got to a mixture of the
> weakly dependent clocks and resets methods. Splitting the methods up into
> the two objects will make the code easier to read and maintain. It shall
> also improve the code scalability (though hopefully we won't need this
> part that much in the future).
> 
> The reset control functionality is now implemented in the framework of a
> single unit since splitting it up doesn't make much sense due to
> relatively simple reset operations. The ccu-rst.c has been designed to be
> looking like ccu-div.c or ccu-pll.c with two globally available methods
> for the sake of the code unification and better code readability.
> 
> This commit doesn't provide any change in the CCU reset implementation
> semantics. As before the driver will support the trigger-like CCU resets
> only, which are responsible for the AXI-bus, APB-bus and SATA-ref blocks
> reset. The assert/de-assert-capable reset controls support will be added
> in the next commit.
> 
> Note the CCU Clock dividers and resets functionality split up was possible
> due to not having any side-effects (at least we didn't found ones) of the
> regmap-based concurrent access of the common CCU dividers/reset CSRs.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Nothing left I'd insist to be changed, so:

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Just a few nitpicks below:

> 
> ---
> 
> Changelog v4:
> - Completely split CCU Dividers and Resets functionality. (@Stephen)
> 
> Changelog v6:
> - Combine the reset-related code into a single file. (@Philipp)
> - Refactor the code to support the linear reset IDs only. (@Philipp)
> - Drop CCU_DIV_RST_MAP() macro. It's no longer used.
> ---
>  drivers/clk/baikal-t1/Kconfig       |  12 ++-
>  drivers/clk/baikal-t1/Makefile      |   1 +
>  drivers/clk/baikal-t1/ccu-div.c     |  19 ----
>  drivers/clk/baikal-t1/ccu-div.h     |   4 +-
>  drivers/clk/baikal-t1/ccu-rst.c     | 151 ++++++++++++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  57 +++++++++++
>  drivers/clk/baikal-t1/clk-ccu-div.c |  92 ++---------------
>  7 files changed, 231 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> 
[...]
> diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
> new file mode 100644
> index 000000000000..8fd40810d24e
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-rst.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *
> + * Baikal-T1 CCU Resets interface driver
> + */
> +
> +#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/printk.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/reset/bt1-ccu.h>
> +
> +#include "ccu-rst.h"
> +
> +#define CCU_AXI_MAIN_BASE		0x030
> +#define CCU_AXI_DDR_BASE		0x034
> +#define CCU_AXI_SATA_BASE		0x038
> +#define CCU_AXI_GMAC0_BASE		0x03C
> +#define CCU_AXI_GMAC1_BASE		0x040
> +#define CCU_AXI_XGMAC_BASE		0x044
> +#define CCU_AXI_PCIE_M_BASE		0x048
> +#define CCU_AXI_PCIE_S_BASE		0x04C
> +#define CCU_AXI_USB_BASE		0x050
> +#define CCU_AXI_HWA_BASE		0x054
> +#define CCU_AXI_SRAM_BASE		0x058
> +
> +#define CCU_SYS_SATA_REF_BASE		0x060
> +#define CCU_SYS_APB_BASE		0x064
> +
> +#define CCU_RST_DELAY_US		1
> +
> +#define CCU_RST_TRIG(_base, _ofs)		\
> +	{					\
> +		.base = _base,			\
> +		.mask = BIT(_ofs),		\
> +	}
> +
> +struct ccu_rst_info {
> +	unsigned int base;
> +	unsigned int mask;
> +};
[...]

This could be compacted by making the base offset u16 and - if there are
no resets that require toggling two bits at once - by storing an u8 bit
offset instead of the mask.

> diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
> new file mode 100644
> index 000000000000..68214d777465
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-rst.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> + *
> + * Baikal-T1 CCU Resets interface driver
> + */
> +#ifndef __CLK_BT1_CCU_RST_H__
> +#define __CLK_BT1_CCU_RST_H__
> +
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +struct ccu_rst_info;
> +
> +/*
> + * struct ccu_rst_init_data - CCU Resets initialization data
> + * @sys_regs: Baikal-T1 System Controller registers map.
> + * @np: Pointer to the node with the System CCU block.
> + */
> +struct ccu_rst_init_data {
> +	struct regmap *sys_regs;
> +	struct device_node *np;
> +};
> +
> +/*
> + * struct ccu_rst - CCU Reset descriptor
> + * @rcdev: Reset controller descriptor.
> + * @sys_regs: Baikal-T1 System Controller registers map.
> + * @rsts_info: Reset flag info (base address and mask).
> + */
> +struct ccu_rst {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *sys_regs;
> +	const struct ccu_rst_info *rsts_info;
> +};
> +#define to_ccu_rst(_rcdev) container_of(_rcdev, struct ccu_rst, rcdev)

I'd make this a static inline function.

> diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
> index 90f4fda406ee..278aa38d767e 100644
> --- a/drivers/clk/baikal-t1/clk-ccu-div.c
> +++ b/drivers/clk/baikal-t1/clk-ccu-div.c
[...]
> @@ -274,42 +241,6 @@ static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> -static int ccu_div_reset(struct reset_controller_dev *rcdev,
> -			 unsigned long rst_id)
> -{
> -	struct ccu_div_data *data = to_ccu_div_data(rcdev);
> -	const struct ccu_div_rst_map *map;
> -	struct ccu_div *div;
> -	int idx, ret;
> -
> -	for (idx = 0, map = data->rst_map; idx < data->rst_num; ++idx, ++map) {
> -		if (map->rst_id == rst_id)
> -			break;
> -	}
> -	if (idx == data->rst_num) {
> -		pr_err("Invalid reset ID %lu specified\n", rst_id);
> -		return -EINVAL;
> -	}
> -
> -	div = ccu_div_find_desc(data, map->clk_id);
> -	if (IS_ERR(div)) {
> -		pr_err("Invalid clock ID %d in mapping\n", map->clk_id);
> -		return PTR_ERR(div);
> -	}
> -
> -	ret = ccu_div_reset_domain(div);
> -	if (ret) {
> -		pr_err("Reset isn't supported by divider %s\n",
> -			clk_hw_get_name(ccu_div_get_clk_hw(div)));
                       ^
This should be aligned to the parenthesis, see checkpatch.pl --strict.

> -	}
> -
> -	return ret;
> -}
> -
> -static const struct reset_control_ops ccu_div_rst_ops = {
> -	.reset = ccu_div_reset,
> -};
> -
>  static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
>  {
>  	struct ccu_div_data *data;
> @@ -323,13 +254,9 @@ static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
>  	if (of_device_is_compatible(np, "baikal,bt1-ccu-axi")) {
>  		data->divs_num = ARRAY_SIZE(axi_info);
>  		data->divs_info = axi_info;
> -		data->rst_num = ARRAY_SIZE(axi_rst_map);
> -		data->rst_map = axi_rst_map;
>  	} else if (of_device_is_compatible(np, "baikal,bt1-ccu-sys")) {
>  		data->divs_num = ARRAY_SIZE(sys_info);
>  		data->divs_info = sys_info;
> -		data->rst_num = ARRAY_SIZE(sys_rst_map);
> -		data->rst_map = sys_rst_map;
>  	} else {
>  		pr_err("Incompatible DT node '%s' specified\n",
>  			of_node_full_name(np));
                       ^
Same as above.

regards
Philipp
