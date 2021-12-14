Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75F5473F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhLNJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhLNJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:15:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D05C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:15:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3u8-0006W4-SK; Tue, 14 Dec 2021 10:15:24 +0100
Message-ID: <26d00447bc3a94b8034b8fde095004717659f235.camel@pengutronix.de>
Subject: Re: [PATCH V4 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP
 blk-ctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Dec 2021 10:15:23 +0100
In-Reply-To: <20211128131853.15125-6-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-6-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 28.11.2021 um 07:18 -0600 schrieb Adam Ford:
> This adds the description for the i.MX8MN disp blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 77 +++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index c2f076b56e24..511e74f0db8a 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
> 
>  #include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/power/imx8mn-power.h>
> 
>  #define BLK_SFT_RSTN	0x0
>  #define BLK_CLK_EN	0x4
> @@ -517,6 +518,77 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
>  	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
>  };
> 
> +
> +static int imx8mn_disp_power_notifier(struct notifier_block *nb,
> +				      unsigned long action, void *data)
> +{
> +	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +						 power_nb);
> +
> +	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
> +		return NOTIFY_OK;
> +
> +	/* Enable bus clock and deassert bus reset */
> +	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
> +	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
> +
> +	/*
> +	 * On power up we have no software backchannel to the GPC to
> +	 * wait for the ADB handshake to happen, so we just delay for a
> +	 * bit. On power down the GPC driver waits for the handshake.
> +	 */
> +	if (action == GENPD_NOTIFY_ON)
> +		udelay(5);
> +
> +
> +	return NOTIFY_OK;
> +}
> +
> +static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
> +	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
> +		.name = "dispblk-mipi-dsi",
> +		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
> +		.num_clks = 2,
> +		.gpc_name = "mipi-dsi",
> +		.rst_mask = BIT(0) | BIT(1),
> +		.clk_mask = BIT(0) | BIT(1),
> +		.mipi_phy_rst_mask = BIT(17),
> +	},
> +	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
> +		.name = "dispblk-mipi-csi",
> +		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
> +		.num_clks = 2,
> +		.gpc_name = "mipi-csi",
> +		.rst_mask = BIT(2) | BIT(3),
> +		.clk_mask = BIT(2) | BIT(3),
> +		.mipi_phy_rst_mask = BIT(16),
> +	},
> +	[IMX8MN_DISPBLK_PD_LCDIF] = {
> +		.name = "dispblk-lcdif",
> +		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
> +		.num_clks = 3,
> +		.gpc_name = "lcdif",
> +		.rst_mask = BIT(4) | BIT(5),
> +		.clk_mask = BIT(4) | BIT(5),
> +	},
> +	[IMX8MN_DISPBLK_PD_ISI] = {
> +		.name = "dispblk-isi",
> +		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> +						"disp_apb_root"},
> +		.num_clks = 4,
> +		.gpc_name = "isi",
> +		.rst_mask = BIT(6) | BIT(7),
> +		.clk_mask = BIT(6) | BIT(7),
> +	},
> +};
> +
> +static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
> +	.max_reg = 0x84,
> +	.power_notifier_fn = imx8mn_disp_power_notifier,
> +	.domains = imx8mn_disp_blk_ctl_domain_data,
> +	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> +};
> +
>  static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>  	{
>  		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
> @@ -524,7 +596,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>  	}, {
>  		.compatible = "fsl,imx8mm-disp-blk-ctrl",
>  		.data = &imx8mm_disp_blk_ctl_dev_data
> -	} ,{
> +	}, {
> +		.compatible = "fsl,imx8mn-disp-blk-ctrl",
> +		.data = &imx8mn_disp_blk_ctl_dev_data
> +	}, {
>  		/* Sentinel */
>  	}
>  };
> --
> 2.32.0
> 


