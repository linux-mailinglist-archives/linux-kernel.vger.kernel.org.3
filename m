Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E472B560443
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiF2POC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 11:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiF2PNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:13:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCBD3FBC2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:12:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6ZMh-0004IV-CK; Wed, 29 Jun 2022 17:12:27 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6ZMc-003QJ4-K7; Wed, 29 Jun 2022 17:12:26 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6ZMf-000BVg-Gm; Wed, 29 Jun 2022 17:12:25 +0200
Message-ID: <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code
 into a dedicated module
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Jun 2022 17:12:25 +0200
In-Reply-To: <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
         <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
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

Hi Serge,

On Fr, 2022-06-24 at 17:18 +0300, Serge Semin wrote:
> Before adding the directly controlled resets support it's reasonable to
> move the existing resets control functionality into a dedicated object for
> the sake of the CCU dividers clock driver simplification. After the new
> functionality was added clk-ccu-div.c would have got to a mixture of the
> weakly dependent clocks and resets methods. Splitting the methods up into
> the two objects will make the code easier to read and maintain. It shall
> also improve the code scalability (though hopefully we won't need this
> part that much in the future).
> 
> As it was done for the CCU PLLs and Dividers the reset control
> functionality in its turn has been split up into two sub-modules:
> hw-interface and generic reset device description. This commit doesn't
> provide any change in the CCU reset module semantics. As before it
> supports the trigger-like CCU resets only, which are responsible for the
> AXI-bus, APB-bus and SATA-ref blocks reset. The assert/de-assert-capable
> reset controls support will be added in the next commit.
> 
> Note the CCU Clock dividers and resets functionality split up was possible
> due to not having any side-effects (at least we didn't found ones) of the
> regmap-based concurrent access of the common CCU dividers/reset CSRs.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - Completely split CCU Dividers and Resets functionality. (@Stephen)
> ---
>  drivers/clk/baikal-t1/Kconfig       |  12 +-
>  drivers/clk/baikal-t1/Makefile      |   1 +
>  drivers/clk/baikal-t1/ccu-div.c     |  19 ---
>  drivers/clk/baikal-t1/ccu-div.h     |   4 +-
>  drivers/clk/baikal-t1/ccu-rst.c     |  43 +++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  67 ++++++++
>  drivers/clk/baikal-t1/clk-ccu-div.c | 101 +++---------
>  drivers/clk/baikal-t1/clk-ccu-rst.c | 236 ++++++++++++++++++++++++++++

What is the reason for separating ccu-rst.c and clk-ccu-rst.c?

I expect implementing the reset ops and registering the reset
controller in the same compilation unit would be easier.

> diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
> new file mode 100644
> index 000000000000..b355bf0b399a
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-rst.c
> @@ -0,0 +1,43 @@
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
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include "ccu-rst.h"
> +
> +#define CCU_RST_DELAY_US		1
> +
> +static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
> +{
> +	struct ccu_rst *rst;
> +
> +	rst = ccu_rst_get_desc(rcdev, idx);
> +	if (IS_ERR(rst)) {
> +		pr_err("Invalid reset index %lu specified\n", idx);
> +		return PTR_ERR(rst);
> +	}

I don't think this is necessary, see my comments below. Since the reset
ids are contiguous, just setting nr_resets and using the default
.of_xlate should be enough to make sure this is never called with an
invalid id.

> +
> +	regmap_update_bits(rst->sys_regs, rst->reg_ctl, rst->mask, rst->mask);

I would expect this to get sys_regs from data, which can be obtained
from rcdev via container_of. The reg_ctl and mask could then be
obtained from the ccu_rst_info array, data->rsts_info[idx].

> +
> +	/* The next delay must be enough to cover all the resets. */
> +	udelay(CCU_RST_DELAY_US);
> +
> +	return 0;
> +}
[...]
> +
> +const struct reset_control_ops ccu_rst_ops = {

With ops and controller registration in the same .c file this could be
static.

> +	.reset = ccu_rst_reset,
> +};
> diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
> new file mode 100644
> index 000000000000..d03bae4b7a05
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-rst.h
> @@ -0,0 +1,67 @@
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
> +
> +struct ccu_rst_data;
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
> + * @id: Reset identifier.
> + * @reg_ctl: Reset control register base address.
> + * @sys_regs: Baikal-T1 System Controller registers map.
> + * @mask: Reset bitmask (normally it's just a single bit flag).
> + */
> +struct ccu_rst {
> +	unsigned int id;

I'm not convinced this structure is necessary.
It is just a copy of struct ccu_rst_info, but with an added regmap
pointer per entry, which seems excessive since the regmap is the same
for all resets.

[...]
> diff --git a/drivers/clk/baikal-t1/clk-ccu-rst.c b/drivers/clk/baikal-t1/clk-ccu-rst.c
> new file mode 100644
> index 000000000000..b10857f48b8b
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/clk-ccu-rst.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *
> + * Baikal-T1 CCU Resets domain driver
> + */
> +#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
> +
> +#include <linux/bits.h>
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
> +#define CCU_RST_TRIG(_id, _base, _ofs)		\
> +	{					\
> +		.id = _id,			\

I think the _id parameter and id field could be dropped.

> +		.base = _base,			\
> +		.mask = BIT(_ofs),		\
> +	}
> +
> +struct ccu_rst_info {
> +	unsigned int id;

This could be dropped.

> +	unsigned int base;
> +	unsigned int mask;

Are there actually resets that require setting/clearing multiple bits,
or is this theoretical?

> +};
> +
> +struct ccu_rst_data {
> +	struct device_node *np;

This is already in rcdev.of_node, no need to carry a copy.

> +	struct regmap *sys_regs;
> +
> +	unsigned int rsts_num;

Same as above, this is already in rcdev.nr_resets.

> +	const struct ccu_rst_info *rsts_info;
> +	struct ccu_rst *rsts;

This is not neccessary if you use sys_regs and rsts_info in the reset
ops.

> +
> +	struct reset_controller_dev rcdev;
> +};
> +#define to_ccu_rst_data(_rcdev) container_of(_rcdev, struct ccu_rst_data, rcdev)
> +
> +/*
> + * Each AXI-bus clock divider is equipped with the corresponding clock-consumer
> + * domain reset (it's self-deasserted reset control).
> + */
> +static const struct ccu_rst_info axi_rst_info[] = {
> +	CCU_RST_TRIG(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_BASE, 1),

This could be:

	[CCU_AXI_MAIN_RST] = CCU_RST_TRIG(CCU_AXI_MAIN_BASE, 1),

> +	CCU_RST_TRIG(CCU_AXI_DDR_RST, CCU_AXI_DDR_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_SATA_RST, CCU_AXI_SATA_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_USB_RST, CCU_AXI_USB_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_HWA_RST, CCU_AXI_HWA_BASE, 1),
> +	CCU_RST_TRIG(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_BASE, 1),
> +};
> +
> +/*
> + * SATA reference clock domain and APB-bus domain are connected with the
> + * sefl-deasserted reset control, which can be activated via the corresponding
> + * clock divider register. DDR and PCIe sub-domains can be reset with directly
> + * controlled reset signals. Resetting the DDR controller though won't end up
> + * well while the Linux kernel is working.
> + */
> +static const struct ccu_rst_info sys_rst_info[] = {
> +	CCU_RST_TRIG(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_BASE, 1),

Same as above.

> +	CCU_RST_TRIG(CCU_SYS_APB_RST, CCU_SYS_APB_BASE, 1),
> +};
> +
> +struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx)
> +{
> +	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
> +
> +	if (idx >= data->rsts_num)
> +		return ERR_PTR(-EINVAL);
> +
> +	return &data->rsts[idx];
> +}

This is not necessary if you just use the reset id as an index into the
ccu_rst_info array.

> +
> +static int ccu_rst_of_idx_get(struct reset_controller_dev *rcdev,
> +			      const struct of_phandle_args *rstspec)
> +{
> +	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
> +	unsigned int id, idx;
> +
> +	id = rstspec->args[0];
> +	for (idx = 0; idx < data->rsts_num; ++idx) {
> +		if (data->rsts[idx].id == id)
> +			break;
> +	}
> +	if (idx == data->rsts_num) {
> +		pr_err("Invalid reset ID %u specified\n", id);
> +		return -EINVAL;
> +	}
> +
> +	return idx;
> +}

Unless I'm mistaken, id == idx for all resets, and this is not
necessary at all. You should be able to use the default .of_xlate.

> +
> +static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *rst_init)
> +{
> +	struct ccu_rst_data *data;
> +	int ret;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->np = rst_init->np;

No reason to store data->np only to copy it to data->rcdev.of_node
later.

> +	data->sys_regs = rst_init->sys_regs;
> +	if (of_device_is_compatible(data->np, "baikal,bt1-ccu-axi")) {
> +		data->rsts_num = ARRAY_SIZE(axi_rst_info);

You could store the number of resets directly into
data->rcdev.nr_resets.

> +		data->rsts_info = axi_rst_info;
> +	} else if (of_device_is_compatible(data->np, "baikal,bt1-ccu-sys")) {
> +		data->rsts_num = ARRAY_SIZE(sys_rst_info);
> +		data->rsts_info = sys_rst_info;
> +	} else {
> +		pr_err("Incompatible DT node '%s' specified\n",
> +			of_node_full_name(data->np));
> +		ret = -EINVAL;
> +		goto err_kfree_data;
> +	}
> +
> +	data->rsts = kcalloc(data->rsts_num, sizeof(*data->rsts), GFP_KERNEL);
> +	if (!data->rsts) {
> +		ret = -ENOMEM;
> +		goto err_kfree_data;
> +	}

I think data->rsts is not required.

> +
> +	return data;
> +
> +err_kfree_data:
> +	kfree(data);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static void ccu_rst_free_data(struct ccu_rst_data *data)
> +{
> +	kfree(data->rsts);
>
Not necessary.

> +	kfree(data);
> +}

I would fold this into ccu_rst_hw_unregister().

> +
> +static void ccu_rst_init_desc(struct ccu_rst_data *data)
> +{
> +	struct ccu_rst *rst = data->rsts;
> +	unsigned int idx;
> +
> +	for (idx = 0; idx < data->rsts_num; ++idx, ++rst) {
> +		const struct ccu_rst_info *info = &data->rsts_info[idx];
> +
> +		rst->id = info->id;
> +		rst->type = info->type;
> +		rst->reg_ctl = info->base;
> +		rst->sys_regs = data->sys_regs;
> +		rst->mask = info->mask;
> +	}
> +}

Not necessary.

> +static int ccu_rst_dev_register(struct ccu_rst_data *data)
> +{
> +	int ret;
> +
> +	data->rcdev.ops = &ccu_rst_ops;
> +	data->rcdev.of_node = data->np;
> +	data->rcdev.nr_resets = data->rsts_num;
> +	data->rcdev.of_reset_n_cells = 1;
> +	data->rcdev.of_xlate = ccu_rst_of_idx_get;
> +
> +	ret = reset_controller_register(&data->rcdev);
> +	if (ret) {
> +		pr_err("Couldn't register '%s' reset controller\n",
> +			of_node_full_name(data->np));
> +	}
> +
> +	return ret;
> +}
> +
> +static void ccu_rst_dev_unregister(struct ccu_rst_data *data)
> +{
> +	reset_controller_unregister(&data->rcdev);
> +}

I would fold this into ccu_rst_hw_unregister().

> +struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *rst_init)
> +{
> +	struct ccu_rst_data *data;
> +	int ret;
> +
> +	data = ccu_rst_create_data(rst_init);
> +	if (IS_ERR(data))
> +		return data;
> +
> +	ccu_rst_init_desc(data);

Not necessary.

> +
> +	ret = ccu_rst_dev_register(data);
> +	if (ret)
> +		goto err_free_data;
> +
> +	return data;
> +
> +err_free_data:
> +	ccu_rst_free_data(data);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +void ccu_rst_hw_unregister(struct ccu_rst_data *data)
> +{
> +	ccu_rst_dev_unregister(data);
> +
> +	ccu_rst_free_data(data);
> +}

To me it looks like you could avoid a few unnecessary complications and
copied data if you merged ccu-rst.c and clk-ccu-rst.c and made use of
the contiguous reset ids instead of the custom of_xlate and the copied
ccu_rst descriptors.

regards
Philipp
