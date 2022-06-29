Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5435604CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiF2Pkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiF2Pkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:40:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A461338A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:40:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o6Znp-0007pv-Mv; Wed, 29 Jun 2022 17:40:29 +0200
Message-ID: <bf8289b9223a135c26363c27c2f5e35baa448032.camel@pengutronix.de>
Subject: Re: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Date:   Wed, 29 Jun 2022 17:40:26 +0200
In-Reply-To: <20220601094537.3390127-5-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
         <20220601094537.3390127-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
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

Am Mittwoch, dem 01.06.2022 um 17:45 +0800 schrieb Peng Fan (OSS):
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
> +		}
> +
> +		ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "failed to get noc entries\n");

I don't like that this introduces a new requirement to the kernel
config and DT, which is a backwards compat breaking change. Now one
could argue that the NoC configuration is pretty critical and should
not be skipped, but it has the potential to break currently working
systems.

I think it would be better do a
if (ret != -EPROBE_DEFER)
	dev_warn_once(dev, "Could not get interconnect paths, NoC will stay unconfigured!\n");

here and ignore the error to allow the blk-ctrl to probe even if the
interconnect paths couldn't be found due to lacking kernel config or
DT.

Regards,
Lucas

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


