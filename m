Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC074F611F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiDFOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiDFOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:06:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F234F685B;
        Wed,  6 Apr 2022 02:42:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED8E0482;
        Wed,  6 Apr 2022 11:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649238151;
        bh=aUCy+ImicXTtNnSI4HEWGIKuc+zB6N4k+KCfdfk9jqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZfHMu5yOfRNKsAdLM9boEqvGF3YOfHSpOEEdR7Hub2u/vMgee51yGT4lQ5CuuXr4
         DLwgpclcMlFoBsYuWqChCuG9rpXJVFjNJPjy1fSmoOlgrr2YqYGuTLY9jT5r3ZFUHn
         EsgcnpCAOc4HQXkU9FuCmuEvpKITDz0xmCUAA25s=
Date:   Wed, 6 Apr 2022 12:42:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/5] soc: imx: imx8m-blk-ctrl: support i.MX8MP media blk
 ctrl noc settings
Message-ID: <Yk1gg2k38ESUp9xC@pendragon.ideasonboard.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406082330.2681591-5-peng.fan@oss.nxp.com>
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

On Wed, Apr 06, 2022 at 04:23:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The out of reset value of NoC is not a valid value, we need
> set it to a correct value. We only need to set it after power on.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 109 +++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 3a6abd70520c..5b382b4e6a64 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <dt-bindings/power/imx8mm-power.h>
>  #include <dt-bindings/power/imx8mn-power.h>
> @@ -29,10 +30,19 @@ struct imx8m_blk_ctrl {
>  	struct notifier_block power_nb;
>  	struct device *bus_power_dev;
>  	struct regmap *regmap;
> +	struct regmap *noc_regmap;
>  	struct imx8m_blk_ctrl_domain *domains;
>  	struct genpd_onecell_data onecell_data;
>  };
>  
> +struct imx8m_blk_ctrl_noc_data {
> +	u32 off;

Maybe "offset" ?

> +	u32 priority;
> +	u32 mode;
> +	u32 extctrl;
> +};
> +
> +#define DOMAIN_MAX_NOC	4

And a blank line here.

We have 3 NoC entries at most below, so this could be lowered, but I
wonder if it wouldn't be nicer to actually drop the macro (see below).

>  struct imx8m_blk_ctrl_domain_data {
>  	const char *name;
>  	const char * const *clk_names;
> @@ -49,6 +59,7 @@ struct imx8m_blk_ctrl_domain_data {
>  	 * register.
>  	 */
>  	u32 mipi_phy_rst_mask;
> +	const struct imx8m_blk_ctrl_noc_data *noc_data[DOMAIN_MAX_NOC];

This would become just

	const struct imx8m_blk_ctrl_noc_data **noc_data;

>  };
>  
>  #define DOMAIN_MAX_CLKS 3
> @@ -66,6 +77,7 @@ struct imx8m_blk_ctrl_data {
>  	notifier_fn_t power_notifier_fn;
>  	const struct imx8m_blk_ctrl_domain_data *domains;
>  	int num_domains;
> +	bool has_noc;
>  };
>  
>  static inline struct imx8m_blk_ctrl_domain *
> @@ -74,6 +86,27 @@ to_imx8m_blk_ctrl_domain(struct generic_pm_domain *genpd)
>  	return container_of(genpd, struct imx8m_blk_ctrl_domain, genpd);
>  }
>  
> +static int imx8m_blk_ctrl_noc_set(struct imx8m_blk_ctrl_domain *domain)
> +{
> +	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> +	struct imx8m_blk_ctrl *bc = domain->bc;
> +	struct regmap *regmap = bc->noc_regmap;
> +	int i;

As it can never be negative, you can make i an unsigned int.

> +
> +	if (!data || !regmap)
> +		return 0;
> +
> +	for (i = 0; i < DOMAIN_MAX_NOC; i++) {
> +		if (!data->noc_data[i])
> +			continue;

With

		const struct imx8m_blk_ctrl_noc_data *noc_data = &data->noc_data[i];

		if (!noc_data)
			continue;

you could then write

		regmap_write(regmap, noc_data->off + 0x8, noc_data->priority);
		regmap_write(regmap, noc_data->off + 0xc, noc_data->mode);
		regmap_write(regmap, noc_data->off + 0x18, noc_data->extctrl);

which is a bit nicer.

If we drop the harcoded number of NoC entries, the loop could become

	const struct imx8m_blk_ctrl_noc_data *noc_data;

	for (i = 0; data->noc_data[i]; i++) {
		const struct imx8m_blk_ctrl_noc_data *noc_data = data->noc_data[i];

		regmap_write(regmap, noc_data->off + 0x8, noc_data->priority);
		regmap_write(regmap, noc_data->off + 0xc, noc_data->mode);
		regmap_write(regmap, noc_data->off + 0x18, noc_data->extctrl);
	}

You would then need a sentinel entry at the end of the noc_data array,
initialized to NULL.

> +		regmap_write(regmap, data->noc_data[i]->off + 0x8, data->noc_data[i]->priority);
> +		regmap_write(regmap, data->noc_data[i]->off + 0xc, data->noc_data[i]->mode);
> +		regmap_write(regmap, data->noc_data[i]->off + 0x18, data->noc_data[i]->extctrl);
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct imx8m_blk_ctrl_domain *domain = to_imx8m_blk_ctrl_domain(genpd);
> @@ -117,6 +150,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	if (data->mipi_phy_rst_mask)
>  		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>  
> +	imx8m_blk_ctrl_noc_set(domain);
> +
>  	/* disable upstream clocks */
>  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>  
> @@ -172,6 +207,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  	const struct imx8m_blk_ctrl_data *bc_data;
>  	struct device *dev = &pdev->dev;
>  	struct imx8m_blk_ctrl *bc;
> +	struct regmap *regmap;
>  	void __iomem *base;
>  	int i, ret;
>  
> @@ -218,6 +254,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
>  				     "failed to attach power domain\n");
>  
> +	regmap = syscon_regmap_lookup_by_compatible("fsl,imx8m-noc");
> +	if (!IS_ERR(regmap))
> +		bc->noc_regmap = regmap;
> +
>  	for (i = 0; i < bc_data->num_domains; i++) {
>  		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
>  		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
> @@ -677,6 +717,55 @@ static int imx8mp_media_power_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +#define IMX8MP_MEDIABLK_LCDIF_RD	0
> +#define IMX8MP_MEDIABLK_LCDIF_WR	1
> +#define IMX8MP_MEDIABLK_ISI0		2
> +#define IMX8MP_MEDIABLK_ISI1		3
> +#define IMX8MP_MEDIABLK_ISI2		4

Would these be the two AXI write and the AXI read ports of the ISI ?
Could they then be named accordingly (e.g. ISI_WR0, ISI_WR1, ISI_RD) ? I
don't know which is which though.

> +#define IMX8MP_MEDIABLK_ISP0		5
> +#define IMX8MP_MEDIABLK_ISP1		6
> +#define IMX8MP_MEDIABLK_DWE		7
> +
> +static const struct imx8m_blk_ctrl_noc_data imx8mp_media_noc_data[] = {
> +	[IMX8MP_MEDIABLK_LCDIF_RD] = {
> +		.off = 0x980,
> +		.priority = 0x80000202,
> +		.extctrl = 1,
> +	},
> +	[IMX8MP_MEDIABLK_LCDIF_WR] = {
> +		.off = 0xa00,
> +		.priority = 0x80000202,
> +		.extctrl = 1,
> +	},
> +	[IMX8MP_MEDIABLK_ISI0] = {
> +		.off = 0xa80,
> +		.priority = 0x80000202,
> +		.extctrl = 1,
> +	},
> +	[IMX8MP_MEDIABLK_ISI1] = {
> +		.off = 0xb00,
> +		.priority = 0x80000202,
> +		.extctrl = 1,
> +	},
> +	[IMX8MP_MEDIABLK_ISI2] = {
> +		.off = 0xb80,
> +		.priority = 0x80000202,
> +		.extctrl = 1,
> +	},
> +	[IMX8MP_MEDIABLK_ISP0] = {
> +		.off = 0xc00,
> +		.priority = 0x80000707,
> +	},
> +	[IMX8MP_MEDIABLK_ISP1] = {
> +		.off = 0xc80,
> +		.priority = 0x80000707,
> +	},
> +	[IMX8MP_MEDIABLK_DWE] = {
> +		.off = 0xd00,
> +		.priority = 0x80000707,
> +	},

This matches the TF-A implementation.

With the above comments taken into account,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +};
> +
>  /*
>   * From i.MX 8M Plus Applications Processor Reference Manual, Rev. 1,
>   * section 13.2.2, 13.2.3
> @@ -708,6 +797,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "lcdif1",
>  		.rst_mask = BIT(4) | BIT(5) | BIT(23),
>  		.clk_mask = BIT(4) | BIT(5) | BIT(23),
> +		.noc_data = {
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_RD],
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_WR],
> +		},
>  	},
>  	[IMX8MP_MEDIABLK_PD_ISI] = {
>  		.name = "mediablk-isi",
> @@ -716,6 +809,11 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "isi",
>  		.rst_mask = BIT(6) | BIT(7),
>  		.clk_mask = BIT(6) | BIT(7),
> +		.noc_data = {
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI0],
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI1],
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI2],
> +		},
>  	},
>  	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
>  		.name = "mediablk-mipi-csi2-2",
> @@ -733,6 +831,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "lcdif2",
>  		.rst_mask = BIT(11) | BIT(12) | BIT(24),
>  		.clk_mask = BIT(11) | BIT(12) | BIT(24),
> +		.noc_data = {
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_RD],
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_WR],
> +		},
>  	},
>  	[IMX8MP_MEDIABLK_PD_ISP2] = {
>  		.name = "mediablk-isp2",
> @@ -749,6 +851,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "isp1",
>  		.rst_mask = BIT(16) | BIT(17) | BIT(18),
>  		.clk_mask = BIT(16) | BIT(17) | BIT(18),
> +		.noc_data = {
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISP0],
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISP1],
> +		},
>  	},
>  	[IMX8MP_MEDIABLK_PD_DWE] = {
>  		.name = "mediablk-dwe",
> @@ -757,6 +863,9 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "dwe",
>  		.rst_mask = BIT(19) | BIT(20) | BIT(21),
>  		.clk_mask = BIT(19) | BIT(20) | BIT(21),
> +		.noc_data = {
> +			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_DWE],
> +		},
>  	},
>  	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
>  		.name = "mediablk-mipi-dsi-2",

-- 
Regards,

Laurent Pinchart
