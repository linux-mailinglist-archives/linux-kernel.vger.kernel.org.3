Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EC4F5F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiDFNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiDFNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:12:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1825F6704;
        Wed,  6 Apr 2022 02:45:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 001FB482;
        Wed,  6 Apr 2022 11:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649238352;
        bh=jlDjIElqodWntU54EXI4PqRLKycv+S7VoD7sYNoZ+MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/4BgXPUOHhX425m+MUkUHTOJZ45pthLQY5exomOvPagRPNTOoixOROTXVejXykNY
         JTHxEcMc1RDoJyDuy+NjENLMxURYmt2REHtcadnDFN/AGveelgYU/hkOi5xyeONJyO
         9WYMmaLMmi583OJrj5XwmZlQzBzkZfhW5dYxz0vw=
Date:   Wed, 6 Apr 2022 12:45:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/5] soc: imx: imx8mp-blk-ctrl: introduce HSIO blk ctrl
 noc settings
Message-ID: <Yk1hTNYYY47Pau8/@pendragon.ideasonboard.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406082330.2681591-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch.

On Wed, Apr 06, 2022 at 04:23:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The out of reset value of HSIO NoC is not a valid value, we need
> set it to a correct value. We only need to set it after power on.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 74 +++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index e832c007b063..929fd9b770ae 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <dt-bindings/power/imx8mp-power.h>
>  
> @@ -26,14 +27,24 @@ struct imx8mp_hsio_blk_ctrl {
>  	struct notifier_block power_nb;
>  	struct device *bus_power_dev;
>  	struct regmap *regmap;
> +	struct regmap *noc_regmap;
>  	struct imx8mp_hsio_blk_ctrl_domain *domains;
>  	struct genpd_onecell_data onecell_data;
>  };
>  
> +struct imx8mp_hsio_blk_ctrl_noc_data {
> +	u32 off;
> +	u32 priority;
> +	u32 mode;
> +	u32 extctrl;
> +};

Maybe the data structure, and possibly the imx8mp_hsio_noc_set()
function, could be shared with imx8m-blk-ctrl.c ? It's much code, so if
it causes too much trouble, feel free to ignore.

The other comments on patch 4/5 apply to this one too.

> +
> +#define DOMAIN_MAX_NOC	2
>  struct imx8mp_hsio_blk_ctrl_domain_data {
>  	const char *name;
>  	const char *clk_name;
>  	const char *gpc_name;
> +	const struct imx8mp_hsio_blk_ctrl_noc_data *noc_data[DOMAIN_MAX_NOC];
>  };
>  
>  struct imx8mp_hsio_blk_ctrl_domain {
> @@ -41,6 +52,7 @@ struct imx8mp_hsio_blk_ctrl_domain {
>  	struct clk *clk;
>  	struct device *power_dev;
>  	struct imx8mp_hsio_blk_ctrl *bc;
> +	const struct imx8mp_hsio_blk_ctrl_domain_data *data;
>  	int id;
>  };
>  
> @@ -50,6 +62,27 @@ to_imx8mp_hsio_blk_ctrl_domain(struct generic_pm_domain *genpd)
>  	return container_of(genpd, struct imx8mp_hsio_blk_ctrl_domain, genpd);
>  }
>  
> +static int imx8mp_hsio_noc_set(struct imx8mp_hsio_blk_ctrl_domain *domain)
> +{
> +	const struct imx8mp_hsio_blk_ctrl_domain_data *data = domain->data;
> +	struct imx8mp_hsio_blk_ctrl *bc = domain->bc;
> +	struct regmap *regmap = bc->noc_regmap;
> +	int i;
> +
> +	if (!data || !regmap)
> +		return 0;
> +
> +	for (i = 0; i < DOMAIN_MAX_NOC; i++) {
> +		if (!data->noc_data[i])
> +			continue;
> +		regmap_write(regmap, data->noc_data[i]->off + 0x8, data->noc_data[i]->priority);
> +		regmap_write(regmap, data->noc_data[i]->off + 0xc, data->noc_data[i]->mode);
> +		regmap_write(regmap, data->noc_data[i]->off + 0x18, data->noc_data[i]->extctrl);
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx8mp_hsio_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct imx8mp_hsio_blk_ctrl_domain *domain =
> @@ -89,6 +122,8 @@ static int imx8mp_hsio_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		goto clk_disable;
>  	}
>  
> +	imx8mp_hsio_noc_set(domain);
> +
>  	return 0;
>  
>  clk_disable:
> @@ -143,11 +178,39 @@ imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
>  
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>  
> +#define IMX8MP_HSIOBLK_NOC_PCIE	0
> +#define IMX8MP_HSIOBLK_USB1	1
> +#define IMX8MP_HSIOBLK_USB2	2
> +#define IMX8MP_HSIOBLK_PCIE	3
> +
> +static const struct imx8mp_hsio_blk_ctrl_noc_data imx8mp_hsio_noc_data[] = {
> +	[IMX8MP_HSIOBLK_NOC_PCIE] = {
> +		.off = 0x780,
> +		.priority = 0x80000303,
> +	},
> +	[IMX8MP_HSIOBLK_USB1] = {
> +		.off = 0x800,
> +		.priority = 0x80000303,
> +	},
> +	[IMX8MP_HSIOBLK_USB2] = {
> +		.off = 0x880,
> +		.priority = 0x80000303,
> +	},
> +	[IMX8MP_HSIOBLK_PCIE] = {
> +		.off = 0x900,
> +		.priority = 0x80000303,
> +	},
> +};
> +
>  static const struct imx8mp_hsio_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
>  	[IMX8MP_HSIOBLK_PD_USB] = {
>  		.name = "hsioblk-usb",
>  		.clk_name = "usb",
>  		.gpc_name = "usb",
> +		.noc_data = {
> +			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_USB1],
> +			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_USB2]
> +		},
>  	},
>  	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
>  		.name = "hsioblk-usb-phy1",
> @@ -161,6 +224,10 @@ static const struct imx8mp_hsio_blk_ctrl_domain_data imx8mp_hsio_domain_data[] =
>  		.name = "hsioblk-pcie",
>  		.clk_name = "pcie",
>  		.gpc_name = "pcie",
> +		.noc_data = {
> +			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_NOC_PCIE],
> +			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_PCIE]
> +		},
>  	},
>  	[IMX8MP_HSIOBLK_PD_PCIE_PHY] = {
>  		.name = "hsioblk-pcie-phy",
> @@ -215,6 +282,7 @@ static int imx8mp_hsio_blk_ctrl_probe(struct platform_device *pdev)
>  	int num_domains = ARRAY_SIZE(imx8mp_hsio_domain_data);
>  	struct device *dev = &pdev->dev;
>  	struct imx8mp_hsio_blk_ctrl *bc;
> +	struct regmap *regmap;
>  	void __iomem *base;
>  	int i, ret;
>  
> @@ -259,11 +327,17 @@ static int imx8mp_hsio_blk_ctrl_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
>  				     "failed to attach bus power domain\n");
>  
> +	regmap = syscon_regmap_lookup_by_compatible("fsl,imx8m-noc");
> +	if (!IS_ERR(regmap))
> +		bc->noc_regmap = regmap;
> +
>  	for (i = 0; i < num_domains; i++) {
>  		const struct imx8mp_hsio_blk_ctrl_domain_data *data =
>  				&imx8mp_hsio_domain_data[i];
>  		struct imx8mp_hsio_blk_ctrl_domain *domain = &bc->domains[i];
>  
> +		domain->data = data;
> +
>  		if (data->clk_name) {
>  			domain->clk = devm_clk_get(dev, data->clk_name);
>  			if (IS_ERR(domain->clk)) {
> -- 
> 2.25.1
> 

-- 
Regards,

Laurent Pinchart
