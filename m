Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687035AC3F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiIDKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiIDKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B23AE5D;
        Sun,  4 Sep 2022 03:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FD4FB80B40;
        Sun,  4 Sep 2022 10:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F3C433D6;
        Sun,  4 Sep 2022 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662288250;
        bh=LD/3APsOy46a2Tg4kaZSdO8MT1DmAh8q/ONtkg/MBU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FChlw3d4AnBY8GgzK5XqnuzFjKBbfmBIoAMFz8wq2Qe2k9KnOQB9U94SvEYlvSig6
         3/CPU7f7c1Y9+XMkOPGCKKUnSu6wo1MT0gUwuoDLG6QFb425eh0PvreQ+e3W9HqNUl
         jnJi0lfZZgRukX+6i7cI5uU4w3WM07hNo8y8SF8hmygE2XqSGi4/d0iP3xxB0gDUsi
         a+o6gMWtKXTHTYM07NICS/ESPby6hTEQ5nnV/G7Z6BwSWOw7J5KZEE3SjM1fdDTaYS
         mUAC9f3hUKIpgFrqZDJ4BzCfo+xPu/fdbaQQf+/AZoPD8Ziyc+SU1PeP3vYBqdz2Kl
         Jl97nF3EH+Y3g==
Date:   Sun, 4 Sep 2022 18:44:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V8 4/6] soc: imx: add i.MX93 media blk ctrl driver
Message-ID: <20220904104403.GJ1728671@dragon>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
 <20220823055215.1139197-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823055215.1139197-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:52:13PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 mediamix blk ctrl support.
> 
> i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
> It support default QoS value and cfg QoS value. Set an initial
> value from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS
> value in future, they could use interconnect to request bandwidth.
> 
> Reported-by: kernel test robot <lkp@intel.com>

This doesn't make too much sense for a new driver.  It's mostly
meaningful for fixes.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Makefile         |   2 +-
>  drivers/soc/imx/imx93-blk-ctrl.c | 452 +++++++++++++++++++++++++++++++
>  2 files changed, 453 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index a0baa2a01adb..754866e0a10d 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>  obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>  obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
>  obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
> -obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
> +obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o imx93-blk-ctrl.o

Maybe have it on a separate line?

+obj-$(CONFIG_SOC_IMX9) += imx93-blk-ctrl.o

> diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
> new file mode 100644
> index 000000000000..12f4e635b46d
> --- /dev/null
> +++ b/drivers/soc/imx/imx93-blk-ctrl.c
> @@ -0,0 +1,452 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/sizes.h>
> +
> +#include <dt-bindings/power/fsl,imx93-power.h>
> +
> +#define BLK_SFT_RSTN	0x0
> +#define BLK_CLK_EN	0x4
> +#define BLK_MAX_CLKS	4
> +
> +#define DOMAIN_MAX_CLKS 4
> +
> +#define LCDIF_QOS_REG		0xC
> +#define LCDIF_DEFAULT_QOS_OFF	12
> +#define LCDIF_CFG_QOS_OFF	8
> +
> +#define PXP_QOS_REG		0x10
> +#define PXP_R_DEFAULT_QOS_OFF	28
> +#define PXP_R_CFG_QOS_OFF	24
> +#define PXP_W_DEFAULT_QOS_OFF	20
> +#define PXP_W_CFG_QOS_OFF	16
> +
> +#define ISI_CACHE_REG		0x14
> +
> +#define ISI_QOS_REG		0x1C
> +#define ISI_V_DEFAULT_QOS_OFF	28
> +#define ISI_V_CFG_QOS_OFF	24
> +#define ISI_U_DEFAULT_QOS_OFF	20
> +#define ISI_U_CFG_QOS_OFF	16
> +#define ISI_Y_R_DEFAULT_QOS_OFF	12
> +#define ISI_Y_R_CFG_QOS_OFF	8
> +#define ISI_Y_W_DEFAULT_QOS_OFF	4
> +#define ISI_Y_W_CFG_QOS_OFF	0
> +
> +#define PRIO_MASK		0xF
> +
> +#define PRIO(X)			(X)
> +
> +struct imx93_blk_ctrl_domain;
> +
> +struct imx93_blk_ctrl {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	int num_clks;
> +	struct clk_bulk_data clks[BLK_MAX_CLKS];
> +	struct imx93_blk_ctrl_domain *domains;
> +	struct genpd_onecell_data onecell_data;
> +};
> +
> +#define DOMAIN_MAX_QOS 4
> +
> +struct imx93_blk_ctrl_qos {
> +	u32 reg;
> +	u32 cfg_off;
> +	u32 default_prio;
> +	u32 cfg_prio;
> +};
> +
> +struct imx93_blk_ctrl_domain_data {
> +	const char *name;
> +	const char * const *clk_names;
> +	int num_clks;
> +	u32 rst_mask;
> +	u32 clk_mask;
> +	u32 num_qos;
> +	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
> +	const struct regmap_access_table *reg_access_table;

It seems to me that reg_access_table is something specific to
imx93_blk_ctrl rather than imx93_blk_ctrl_domain.

> +};
> +
> +struct imx93_blk_ctrl_domain {
> +	struct generic_pm_domain genpd;
> +	const struct imx93_blk_ctrl_domain_data *data;
> +	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
> +	struct imx93_blk_ctrl *bc;
> +};
> +
> +struct imx93_blk_ctrl_data {
> +	const struct imx93_blk_ctrl_domain_data *domains;
> +	const struct imx93_blk_ctrl_domain_data *bus;

It looks confusing to claim 'bus' as an imx93_blk_ctrl_domain_data.  I
would suggest you have 'related' fields directly defined in
imx93_blk_ctrl_data.

> +	int num_domains;
> +};
> +
> +static inline struct imx93_blk_ctrl_domain *
> +to_imx93_blk_ctrl_domain(struct generic_pm_domain *genpd)
> +{
> +	return container_of(genpd, struct imx93_blk_ctrl_domain, genpd);
> +}
> +
> +static int imx93_blk_ctrl_set_qos(struct imx93_blk_ctrl_domain *domain)
> +{
> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
> +	struct imx93_blk_ctrl *bc = domain->bc;
> +	const struct imx93_blk_ctrl_qos *qos;
> +	u32 val, mask;
> +	int i;
> +
> +	for (i = 0; i < data->num_qos; i++) {
> +		qos = &data->qos[i];
> +
> +		mask = PRIO_MASK << qos->cfg_off;
> +		mask |= PRIO_MASK << (qos->cfg_off + 4);
> +		val = qos->cfg_prio << qos->cfg_off;
> +		val |= qos->default_prio << (qos->cfg_off + 4);
> +
> +		regmap_write_bits(bc->regmap, qos->reg, mask, val);
> +
> +		dev_dbg(bc->dev, "data->qos[i].reg 0x%x 0x%x\n", qos->reg, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx93_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> +{
> +	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
> +	struct imx93_blk_ctrl *bc = domain->bc;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(bc->num_clks, bc->clks);
> +	if (ret) {
> +		dev_err(bc->dev, "failed to enable bus clocks\n");
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
> +		dev_err(bc->dev, "failed to enable clocks\n");
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_get_sync(bc->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(bc->dev);
> +		dev_err(bc->dev, "failed to power up domain\n");
> +		goto disable_clk;
> +	}
> +
> +	/* ungate clk */
> +	regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
> +	/* release reset */
> +	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +
> +	dev_dbg(bc->dev, "pd_on: name: %s\n", genpd->name);
> +
> +	return imx93_blk_ctrl_set_qos(domain);
> +
> +disable_clk:
> +	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> +
> +	return ret;
> +}
> +
> +static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> +{
> +	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
> +	struct imx93_blk_ctrl *bc = domain->bc;
> +
> +	dev_info(bc->dev, "pd_off: name: %s\n", genpd->name);
> +
> +	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
> +	pm_runtime_put(bc->dev);
> +
> +	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> +
> +	clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
> +
> +	return 0;
> +}
> +
> +static struct generic_pm_domain *
> +imx93_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
> +{
> +	struct genpd_onecell_data *onecell_data = data;
> +	unsigned int index = args->args[0];
> +
> +	if (args->args_count != 1 ||
> +	    index >= onecell_data->num_domains)
> +		return ERR_PTR(-EINVAL);
> +
> +	return onecell_data->domains[index];
> +}

Why don't we just use the genpd_xlate_onecell() defined by genpd core?

> +
> +static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct imx93_blk_ctrl_data *bc_data = of_device_get_match_data(dev);
> +	const struct imx93_blk_ctrl_domain_data *bus = bc_data->bus;
> +	struct imx93_blk_ctrl *bc;
> +	void __iomem *base;
> +	int i, ret;
> +
> +	struct regmap_config regmap_config = {
> +		.reg_bits	= 32,
> +		.val_bits	= 32,
> +		.reg_stride	= 4,
> +		.rd_table	= bus->reg_access_table,
> +		.wr_table	= bus->reg_access_table,
> +		.max_register   = SZ_4K,
> +	};
> +
> +	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
> +	if (!bc)
> +		return -ENOMEM;
> +
> +	bc->dev = dev;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(bc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(bc->regmap),
> +				     "failed to init regmap\n");
> +
> +	bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,

Why do we need one more domain than what bc_data defines?

> +				   sizeof(struct imx93_blk_ctrl_domain),
> +				   GFP_KERNEL);
> +	if (!bc->domains)
> +		return -ENOMEM;
> +
> +	bc->onecell_data.num_domains = bc_data->num_domains;
> +	bc->onecell_data.xlate = imx93_blk_ctrl_xlate;
> +	bc->onecell_data.domains =
> +		devm_kcalloc(dev, bc_data->num_domains,
> +			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
> +	if (!bc->onecell_data.domains)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < bus->num_clks; i++)
> +		bc->clks[i].id = bus->clk_names[i];
> +	bc->num_clks = bus->num_clks;
> +
> +	ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to get bus clock\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < bc_data->num_domains; i++) {
> +		const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];
> +		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> +		int j;
> +
> +		domain->data = data;
> +
> +		for (j = 0; j < data->num_clks; j++)
> +			domain->clks[j].id = data->clk_names[j];
> +
> +		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to get clock\n");
> +			goto cleanup_pds;
> +		}
> +
> +		domain->genpd.name = data->name;
> +		domain->genpd.power_on = imx93_blk_ctrl_power_on;
> +		domain->genpd.power_off = imx93_blk_ctrl_power_off;
> +		domain->bc = bc;
> +
> +		ret = pm_genpd_init(&domain->genpd, NULL, true);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to init power domain\n");
> +			goto cleanup_pds;
> +		}
> +
> +		bc->onecell_data.domains[i] = &domain->genpd;
> +	}
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add power domain provider\n");
> +		goto cleanup_pds;
> +	}
> +
> +	dev_set_drvdata(dev, bc);
> +
> +	return 0;
> +
> +cleanup_pds:
> +	for (i--; i >= 0; i--)
> +		pm_genpd_remove(&bc->domains[i].genpd);
> +
> +	return ret;
> +}
> +
> +static int imx93_blk_ctrl_remove(struct platform_device *pdev)
> +{
> +	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
> +	int i;
> +
> +	of_genpd_del_provider(pdev->dev.of_node);
> +
> +	for (i = 0; bc->onecell_data.num_domains; i++) {
> +		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> +
> +		pm_genpd_remove(&domain->genpd);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
> +	[IMX93_MEDIABLK_PD_MIPI_DSI] = {
> +		.name = "mediablk-mipi-dsi",
> +		.clk_names = (const char *[]){ "dsi" },
> +		.num_clks = 1,
> +		.rst_mask = BIT(11) | BIT(12),
> +		.clk_mask = BIT(11) | BIT(12),
> +	},
> +	[IMX93_MEDIABLK_PD_MIPI_CSI] = {
> +		.name = "mediablk-mipi-csi",
> +		.clk_names = (const char *[]){ "cam", "csi" },
> +		.num_clks = 2,
> +		.rst_mask = BIT(9) | BIT(10),
> +		.clk_mask = BIT(9) | BIT(10),
> +	},
> +	[IMX93_MEDIABLK_PD_PXP] = {
> +		.name = "mediablk-pxp",
> +		.clk_names = (const char *[]){ "pxp" },
> +		.num_clks = 1,
> +		.rst_mask = BIT(7) | BIT(8),
> +		.clk_mask = BIT(7) | BIT(8),
> +		.num_qos = 2,
> +		.qos = {
> +			{
> +				.reg = PXP_QOS_REG,
> +				.cfg_off = PXP_R_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(6),
> +			}, {
> +				.reg = PXP_QOS_REG,
> +				.cfg_off = PXP_W_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(6),
> +			}
> +		}
> +	},
> +	[IMX93_MEDIABLK_PD_LCDIF] = {
> +		.name = "mediablk-lcdif",
> +		.clk_names = (const char *[]){ "disp", "lcdif" },
> +		.num_clks = 2,
> +		.rst_mask = BIT(4) | BIT(5) | BIT(6),
> +		.clk_mask = BIT(4) | BIT(5) | BIT(6),
> +		.num_qos = 1,
> +		.qos = {
> +			{
> +			.reg = LCDIF_QOS_REG,
> +			.cfg_off = LCDIF_CFG_QOS_OFF,
> +			.default_prio = PRIO(3),
> +			.cfg_prio = PRIO(7),
> +			}
> +		}
> +	},
> +	[IMX93_MEDIABLK_PD_ISI] = {
> +		.name = "mediablk-isi",
> +		.clk_names = (const char *[]){ "isi" },
> +		.num_clks = 1,
> +		.rst_mask = BIT(2) | BIT(3),
> +		.clk_mask = BIT(2) | BIT(3),
> +		.num_qos = 4,
> +		.qos = {
> +			{
> +				.reg = ISI_QOS_REG,
> +				.cfg_off = ISI_Y_W_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(7),
> +			}, {
> +				.reg = ISI_QOS_REG,
> +				.cfg_off = ISI_Y_R_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(7),
> +			}, {
> +				.reg = ISI_QOS_REG,
> +				.cfg_off = ISI_U_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(7),
> +			}, {
> +				.reg = ISI_QOS_REG,
> +				.cfg_off = ISI_V_CFG_QOS_OFF,
> +				.default_prio = PRIO(3),
> +				.cfg_prio = PRIO(7),
> +			}
> +		}
> +	},
> +};
> +
> +static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {
> +		regmap_reg_range(BLK_SFT_RSTN, BLK_CLK_EN),
> +		regmap_reg_range(LCDIF_QOS_REG, ISI_CACHE_REG),
> +		regmap_reg_range(ISI_QOS_REG, ISI_QOS_REG),

One level indent is enough.

> +};
> +
> +static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
> +	.yes_ranges	= imx93_media_blk_ctl_yes_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),

Inconsistent indent around '=' with imx93_media_blk_ctl_bus_data and
imx93_media_blk_ctl_dev_data below.

> +};
> +
> +static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_bus_data = {
> +	.clk_names = (const char *[]){ "axi", "apb", "nic", },
> +	.num_clks = 3,
> +	.reg_access_table = &imx93_media_blk_ctl_access_table,
> +};
> +
> +static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
> +	.domains = imx93_media_blk_ctl_domain_data,
> +	.bus = &imx93_media_blk_ctl_bus_data,
> +	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
> +};
> +
> +static const struct of_device_id imx93_blk_ctrl_of_match[] = {
> +	{
> +		.compatible = "fsl,imx93-media-blk-ctrl",
> +		.data = &imx93_media_blk_ctl_dev_data
> +	}, {
> +		/* Sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
> +
> +static struct platform_driver imx93_blk_ctrl_driver = {
> +	.probe = imx93_blk_ctrl_probe,
> +	.remove = imx93_blk_ctrl_remove,
> +	.driver = {
> +		.name = "imx93-blk-ctrl",
> +		.of_match_table = imx93_blk_ctrl_of_match,
> +	},
> +};
> +module_platform_driver(imx93_blk_ctrl_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("i.MX93 BLK CTRL driver");
> +MODULE_LICENSE("GPL");

"GPL v2"

Shawn
