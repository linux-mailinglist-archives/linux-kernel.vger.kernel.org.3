Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67053D8A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbiFDVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFDVpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:45:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5C222AC;
        Sat,  4 Jun 2022 14:45:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 859AC6D4;
        Sat,  4 Jun 2022 23:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654379103;
        bh=TrFjpWkzVkNWUt57w55uIPPPvqKwBd4wXSVA6ZZCZCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzLMCNe2RMozks1RnefrxWhkIyqATY7kiKwq6DQGiKtiqdpzkHj3+Tg7joo81UHcr
         /hqBmwnPuByxG+SI0g3ihYny/vBtDwHR7/TZb1NR73dfaozpDHSu69IGQjVMvr/cix
         E1LN8IqCNBW+/yVqVOrpoRqQ0Q0idLC/L7iXfJks=
Date:   Sun, 5 Jun 2022 00:44:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Message-ID: <YpvSWTZk5kb8d0Bn@pendragon.ideasonboard.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
 <20220601094537.3390127-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601094537.3390127-5-peng.fan@oss.nxp.com>
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

On Wed, Jun 01, 2022 at 05:45:33PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect paths for i.MX8MP media blk ctrl
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi |  1 +
>  drivers/soc/imx/imx8m-blk-ctrl.c          | 31 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index d9542dfff83f..2a1c6ff37e03 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/interconnect/fsl,imx8mp.h>
>  #include <dt-bindings/power/imx8mp-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 7f49385ed2f8..423cac0c9cb6 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/interconnect.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -37,6 +38,8 @@ struct imx8m_blk_ctrl_domain_data {
>  	const char *name;
>  	const char * const *clk_names;
>  	int num_clks;
> +	const char * const *path_names;
> +	int num_paths;
>  	const char *gpc_name;
>  	u32 rst_mask;
>  	u32 clk_mask;
> @@ -52,11 +55,13 @@ struct imx8m_blk_ctrl_domain_data {
>  };
>  
>  #define DOMAIN_MAX_CLKS 4
> +#define DOMAIN_MAX_PATHS 4
>  
>  struct imx8m_blk_ctrl_domain {
>  	struct generic_pm_domain genpd;
>  	const struct imx8m_blk_ctrl_domain_data *data;
>  	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
> +	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
>  	struct device *power_dev;
>  	struct imx8m_blk_ctrl *bc;
>  };
> @@ -117,6 +122,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	if (data->mipi_phy_rst_mask)
>  		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>  
> +	ret = icc_bulk_set_bw(data->num_paths, domain->paths);
> +	if (ret)
> +		dev_err(bc->dev, "failed to set icc bw\n");

Don't we need to "release" the bandwidth on power off ?

> +
>  	/* disable upstream clocks */
>  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>  
> @@ -228,6 +237,18 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		for (j = 0; j < data->num_clks; j++)
>  			domain->clks[j].id = data->clk_names[j];
>  
> +		for (j = 0; j < data->num_paths; j++) {
> +			domain->paths[j].name = data->path_names[j];
> +			domain->paths[j].avg_bw = INT_MAX;
> +			domain->paths[j].peak_bw = INT_MAX;

That's harsh :-) I suppose it's good enough to start with, but I wonder
if we'll need more control later.

> +		}
> +
> +		ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to get noc entries\n");
> +			goto cleanup_pds;
> +		}
> +
>  		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
>  		if (ret) {
>  			dev_err_probe(dev, ret, "failed to get clock\n");
> @@ -647,6 +668,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "lcdif1",
>  		.rst_mask = BIT(4) | BIT(5) | BIT(23),
>  		.clk_mask = BIT(4) | BIT(5) | BIT(23),
> +		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
> +		.num_paths = 2,
>  	},
>  	[IMX8MP_MEDIABLK_PD_ISI] = {
>  		.name = "mediablk-isi",
> @@ -655,6 +678,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "isi",
>  		.rst_mask = BIT(6) | BIT(7),
>  		.clk_mask = BIT(6) | BIT(7),
> +		.path_names = (const char *[]){"isi0", "isi1", "isi2"},
> +		.num_paths = 3,
>  	},
>  	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
>  		.name = "mediablk-mipi-csi2-2",
> @@ -672,6 +697,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "lcdif2",
>  		.rst_mask = BIT(11) | BIT(12) | BIT(24),
>  		.clk_mask = BIT(11) | BIT(12) | BIT(24),
> +		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
> +		.num_paths = 2,
>  	},
>  	[IMX8MP_MEDIABLK_PD_ISP] = {
>  		.name = "mediablk-isp",
> @@ -680,6 +707,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "isp",
>  		.rst_mask = BIT(16) | BIT(17) | BIT(18),
>  		.clk_mask = BIT(16) | BIT(17) | BIT(18),
> +		.path_names = (const char *[]){"isp0", "isp1"},
> +		.num_paths = 2,

As far as I understand, there's a single power domain for both ISP
instances (I'm not entirely sure this is on purpose or a design mistake,
but that's another story), but one interconnect path for each ISP
instance. Would there be any use case for controlling them separately ?
I can't really think of any myself.

>  	},
>  	[IMX8MP_MEDIABLK_PD_DWE] = {
>  		.name = "mediablk-dwe",
> @@ -688,6 +717,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
>  		.gpc_name = "dwe",
>  		.rst_mask = BIT(19) | BIT(20) | BIT(21),
>  		.clk_mask = BIT(19) | BIT(20) | BIT(21),
> +		.path_names = (const char *[]){"dwe"},
> +		.num_paths = 1,
>  	},
>  	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
>  		.name = "mediablk-mipi-dsi-2",

-- 
Regards,

Laurent Pinchart
