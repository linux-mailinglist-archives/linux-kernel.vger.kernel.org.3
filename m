Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F459B167
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiHUDQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiHUDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DC1402A;
        Sat, 20 Aug 2022 20:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41D3600BE;
        Sun, 21 Aug 2022 03:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0BFC433C1;
        Sun, 21 Aug 2022 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661051759;
        bh=cx0qnMHU/FjAzP2G+c5qxImp+aF3pT7+w8iNDJydJPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5vEJdUOpmC7jPr6mvu8Ngd+w2afvAE4ba3ZQwIk3C0eQ3mqSbBJ6OQAFnvk9grOh
         O4sqW8XPRukvP0Lh7MUPqspi8EHG2/Au1kodsQVNxwIxwYYztQRBRXzdFaaxP98tLd
         raDr/wHsbjrrSiG1DLvVndeZkAk0hYpedLH2aqs6JvHx7lo1DDZWwaGiGQLSioUO36
         OUda3Dq6RHpMrRH4aJve+7Of2hyL9SEzsCo0Iti/xzVOp7axBGmsVWHKualsg79c37
         tI5amfsQrjBXx8ESiZaR+7L21+fxnknBowTGM/69LuvHhnnQoUTbns7v3FYEAaV2Jz
         5N/gHtNf4q9MA==
Date:   Sun, 21 Aug 2022 11:15:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 4/6] soc: imx: add i.MX93 media blk ctrl driver
Message-ID: <20220821031551.GK149610@dragon>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
 <20220719073541.197788-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719073541.197788-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:35:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 mediamix blk ctrl support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Makefile         |   2 +-
>  drivers/soc/imx/imx93-blk-ctrl.c | 333 +++++++++++++++++++++++++++++++
>  2 files changed, 334 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
> new file mode 100644
> index 000000000000..42be09688cf1
> --- /dev/null
> +++ b/drivers/soc/imx/imx93-blk-ctrl.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0 for SRC driver and GPL-2.0+ for this?

> +

No need of newline.

> +/*
> + * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>

Sort them alphabetically?

> +
> +#include <dt-bindings/power/fsl,imx93-power.h>
> +
> +#define BLK_SFT_RSTN	0x0
> +#define BLK_CLK_EN	0x4
> +
> +#define BLK_MAX_CLKS 4
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
> +struct imx93_blk_ctrl_domain_data {
> +	const char *name;
> +	const char * const *clk_names;
> +	int num_clks;
> +	u32 rst_mask;
> +	u32 clk_mask;
> +
> +};
> +
> +#define DOMAIN_MAX_CLKS 4

Move this up to #define section?

> +
> +struct imx93_blk_ctrl_domain {
> +	struct generic_pm_domain genpd;
> +	const struct imx93_blk_ctrl_domain_data *data;
> +	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
> +	struct imx93_blk_ctrl *bc;
> +};
> +
> +struct imx93_blk_ctrl_data {
> +	int max_reg;
> +	const struct imx93_blk_ctrl_domain_data *domains;
> +	const struct imx93_blk_ctrl_domain_data *bus;
> +	int num_domains;
> +};
> +
> +static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_bus_data = {
> +	.clk_names = (const char *[]){ "axi", "apb", "nic", },
> +	.num_clks = 3,
> +};

Can this be moved to where imx93_media_blk_ctl_domain_data is defined?

> +
> +static inline struct imx93_blk_ctrl_domain *
> +to_imx93_blk_ctrl_domain(struct generic_pm_domain *genpd)
> +{
> +	return container_of(genpd, struct imx93_blk_ctrl_domain, genpd);
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
> +		dev_err(bc->dev, "failed to enable clocks\n");
> +		return ret;

So bc->clks left enabled?

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
> +	dev_info(bc->dev, "pd_on: name: %s\n", genpd->name);

dev_dbg() maybe?

> +
> +	return 0;
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
> +
> +static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +	const struct imx93_blk_ctrl_data *bc_data;
> +	struct device *dev = &pdev->dev;
> +	struct imx93_blk_ctrl *bc;
> +	void __iomem *base;
> +	int i, ret;
> +	const struct imx93_blk_ctrl_domain_data *bus;
> +
> +	struct regmap_config regmap_config = {
> +		.reg_bits	= 32,
> +		.val_bits	= 32,
> +		.reg_stride	= 4,
> +	};
> +
> +	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
> +	if (!bc)
> +		return -ENOMEM;
> +
> +	bc->dev = dev;
> +

Unnecessary newline.

> +	bc_data = of_device_get_match_data(dev);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap_config.max_register = bc_data->max_reg;
> +	bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(bc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(bc->regmap),
> +				     "failed to init regmap\n");
> +
> +	bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,
> +				   sizeof(struct imx93_blk_ctrl_domain),
> +				   GFP_KERNEL);
> +	if (!bc->domains)
> +		return -ENOMEM;
> +
> +	bus = bc_data->bus;
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
> +

One newline.

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
> +	},
> +	[IMX93_MEDIABLK_PD_LCDIF] = {
> +		.name = "mediablk-lcdif",
> +		.clk_names = (const char *[]){ "disp", "lcdif" },
> +		.num_clks = 2,
> +		.rst_mask = BIT(4) | BIT(5) | BIT(6),
> +		.clk_mask = BIT(4) | BIT(5) | BIT(6),
> +	},
> +	[IMX93_MEDIABLK_PD_ISI] = {
> +		.name = "mediablk-isi",
> +		.clk_names = (const char *[]){ "isi" },
> +		.num_clks = 1,
> +		.rst_mask = BIT(2) | BIT(3),
> +		.clk_mask = BIT(2) | BIT(3),
> +	},
> +};
> +
> +static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
> +	.max_reg = 0x90,
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

MODULE_AUTHOR, MODULE_DESCRIPTION, MODULE_LICENSE?

Shawn
