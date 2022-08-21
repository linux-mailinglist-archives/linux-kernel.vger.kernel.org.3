Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99959B156
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 04:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiHUCte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 22:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiHUCtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 22:49:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22F24095;
        Sat, 20 Aug 2022 19:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49C30CE0064;
        Sun, 21 Aug 2022 02:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE789C433C1;
        Sun, 21 Aug 2022 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661050166;
        bh=NQPXhFg5BdDMCFze1MKNJpNFjVXRqm3HsERWvMoSabM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKuC0yjUscAd/eUyEE1EjadDmF3GHpY/cvLE/6fWiT7zxCnfwPvuW7Xsr7VEuPNe8
         MQlr6Q5BHAFakIxpZp/JQJURCXgFoTc+xCpcxTOjL4Q0NynwvyNqKneyoPTxZFzEOk
         KhujIUin8/g9aQVBhILKs1bAsC7wjDDv/cfda6E6HRjnjue/jNOdGmictDM98fbrD0
         RUO1UJYDioF5NsXGB7eyQAiqg/V8dqFSVDlngU//RWUTC5vfNVC/9wekCZFg6lya3i
         F31/VjZwsRwy6+IXo7ifE4OvTw85JNfsivSa93ykKVd9+RP+iZ4pbWcv9x0YBXi4vu
         sggPxJQOfoTQQ==
Date:   Sun, 21 Aug 2022 10:49:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 3/6] soc: imx: add i.MX93 SRC power domain driver
Message-ID: <20220821024919.GJ149610@dragon>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
 <20220719073541.197788-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719073541.197788-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:35:38PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Support controlling power domain managed by System Reset
> Controller(SRC). Current supported power domain is mediamix power
> domain.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Kconfig     |   8 ++
>  drivers/soc/imx/Makefile    |   1 +
>  drivers/soc/imx/imx93-pd.c  | 163 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/imx93-src.c |  32 +++++++

Shouldn't a reset driver go to drivers/reset/?

>  4 files changed, 204 insertions(+)
>  create mode 100644 drivers/soc/imx/imx93-pd.c
>  create mode 100644 drivers/soc/imx/imx93-src.c
> 
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index a840494e849a..4b906791d6c7 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -20,4 +20,12 @@ config SOC_IMX8M
>  	  support, it will provide the SoC info like SoC family,
>  	  ID and revision etc.
>  
> +config SOC_IMX9
> +	tristate "i.MX9 SoC family support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	default ARCH_MXC && ARM64
> +	select SOC_BUS
> +	help
> +	  If you say yes here, you get support for the NXP i.MX9 family
> +
>  endmenu
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 63cd29f6d4d2..a0baa2a01adb 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>  obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>  obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
>  obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
> +obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
> diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
> new file mode 100644
> index 000000000000..48437c303b78
> --- /dev/null
> +++ b/drivers/soc/imx/imx93-pd.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of_device.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +
> +#define MIX_SLICE_SW_CTRL_OFF		0x20
> +#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
> +#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
> +
> +#define MIX_FUNC_STAT_OFF		0xB4
> +
> +#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
> +#define FUNC_STAT_RST_STAT_MASK		BIT(2)
> +#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
> +
> +struct imx93_power_domain {
> +	struct generic_pm_domain genpd;
> +	struct device *dev;
> +	void __iomem *addr;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	bool init_off;
> +};
> +
> +#define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
> +
> +static int imx93_pd_on(struct generic_pm_domain *genpd)
> +{
> +	struct imx93_power_domain *domain = to_imx93_pd(genpd);
> +	void __iomem *addr = domain->addr;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
> +		return ret;
> +	}
> +
> +	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
> +	val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
> +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
> +
> +	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> +				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
> +	if (ret) {
> +		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx93_pd_off(struct generic_pm_domain *genpd)
> +{
> +	struct imx93_power_domain *domain = to_imx93_pd(genpd);
> +	void __iomem *addr = domain->addr;
> +	int ret;
> +	u32 val;
> +
> +	/* Power off MIX */
> +	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
> +	val |= SLICE_SW_CTRL_PDN_SOFT_MASK;
> +	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
> +
> +	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> +				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
> +	if (ret) {
> +		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
> +		return ret;
> +	}
> +
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +
> +	return 0;
> +};
> +
> +static int imx93_pd_remove(struct platform_device *pdev)
> +{
> +	struct imx93_power_domain *domain = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	if (!domain->init_off)
> +		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +
> +	of_genpd_del_provider(np);
> +	pm_genpd_remove(&domain->genpd);
> +
> +	return 0;
> +}
> +
> +static int imx93_pd_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx93_power_domain *domain;
> +	int ret;
> +
> +	domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return -ENOMEM;

Have a newline.

> +	domain->addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(domain->addr))
> +		return PTR_ERR(domain->addr);
> +
> +

One newline is enough.

> +	domain->num_clks = devm_clk_bulk_get_all(dev, &domain->clks);
> +	if (domain->num_clks < 0)
> +		return dev_err_probe(dev, domain->num_clks, "Failed to get domain's clocks\n");
> +
> +	domain->genpd.name = dev_name(dev);
> +	domain->genpd.power_off = imx93_pd_off;
> +	domain->genpd.power_on = imx93_pd_on;
> +	domain->dev = dev;
> +
> +	domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
> +	/* Just to sync the status of hardware */
> +	if (!domain->init_off) {
> +		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
> +				domain->genpd.name);
> +			return 0;

This is a case of success?

> +		}
> +	}
> +
> +	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, domain);
> +
> +	return of_genpd_add_provider_simple(np, &domain->genpd);
> +}
> +
> +static const struct of_device_id imx93_dt_ids[] = {
> +	{ .compatible = "fsl,imx93-src-slice" },
> +	{ }
> +};

MODULE_DEVICE_TABLE()?

Shawn

> +
> +static struct platform_driver imx93_power_domain_driver = {
> +	.driver = {
> +		.name	= "imx93_power_domain",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = imx93_dt_ids,
> +	},
> +	.probe = imx93_pd_probe,
> +	.remove = imx93_pd_remove,
> +};
> +module_platform_driver(imx93_power_domain_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX93 power domain driver");
> +MODULE_LICENSE("GPL");

"GPL v2" since you have "SPDX-License-Identifier: GPL-2.0" claimed in
the beginning?

Shawn

> diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
> new file mode 100644
> index 000000000000..6f14c241538e
> --- /dev/null
> +++ b/drivers/soc/imx/imx93-src.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +static int imx93_src_probe(struct platform_device *pdev)
> +{
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct of_device_id imx93_dt_ids[] = {
> +	{ .compatible = "fsl,imx93-src" },
> +	{ }
> +};
> +
> +static struct platform_driver imx93_src_driver = {
> +	.driver = {
> +		.name	= "imx93_src",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = imx93_dt_ids,
> +	},
> +	.probe = imx93_src_probe,
> +};
> +module_platform_driver(imx93_src_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX93 src driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
