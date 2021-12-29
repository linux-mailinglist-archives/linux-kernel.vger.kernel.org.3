Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605154817BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhL2XaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhL2XaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:30:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F7C061574;
        Wed, 29 Dec 2021 15:30:20 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 278682A5;
        Thu, 30 Dec 2021 00:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640820618;
        bh=7slk1BTJSQ2MNvLZf4HMKHSD+agLM/Pr6AQQ0aueOvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtaIB/7dNo9A+AMXc/YOGtE8UoCeVrBc0Jl/LIgtRLJ/LTwksGeJXbiqXq0HsP+xR
         kggcnIx6a7EgI7uC/bPA/nWWBMzNI+PnEygjPGo6YIv5CKCBMnwf3b5NRaFkVH/W1u
         rf1rt+Qgjd8C+472L5tYs0RPIlKS/sGXB6AGPjbE=
Date:   Thu, 30 Dec 2021 01:30:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 1/4] phy: cadence: Add Cadence D-PHY Rx driver
Message-ID: <YczviHU5IK6cdNhK@pendragon.ideasonboard.com>
References: <20211227105545.4852-1-p.yadav@ti.com>
 <20211227105545.4852-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227105545.4852-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Mon, Dec 27, 2021 at 04:25:42PM +0530, Pratyush Yadav wrote:
> The Cadence D-PHY can be configured in Tx (DSI) mode or Rx (CSI) mode.
> Both modes have a different programming sequence and share little among
> them. In addition, a PHY configured in Tx mode cannot be used in Rx mode
> and vice versa. For this reason, create a separate driver for the Rx
> mode to make it easier to read and maintain.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v7:
> - Add spaces after { and before } in the bands table.
> - Drop the wrapping around the for loop on cdns_dphy_rx_get_band_ctrl().
> - Make cdns_dphy_rx_wait_for_bit() inline.
> - Print an error message if registering PHY provider fails.
> 
> Changes in v6:
> - Move to a separate driver.
> 
> Changes in v5:
> - Use the new cdns_dphy_info to specify PHY ops.
> - Re-order include in alphabetical order.
> - Make bands const.
> - Drop num_bands.
> - Make i, lanes unsigned.
> - Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
>   complete and return -EOPNOTSUPP when we reach the end.
> - Drop the "rate < bands[i].min_rate" check since the bands are in
>   ascending order.
> - Move data_lane_ctrl to start of function and make it static const.
> 
> Changes in v4:
> - Drop the submode parts. Use a different compatible for the Rx ops.
> - Make bands and num_bands static.
> 
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
> 
>  drivers/phy/cadence/Kconfig        |   8 +
>  drivers/phy/cadence/Makefile       |   1 +
>  drivers/phy/cadence/cdns-dphy-rx.c | 255 +++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
> 
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index a62910ff5591..1adde2d99ae7 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -22,6 +22,14 @@ config PHY_CADENCE_DPHY
>  	  system. If M is selected, the module will be called
>  	  cdns-dphy.
>  
> +config PHY_CADENCE_DPHY_RX
> +	tristate "Cadence D-PHY Rx Support"
> +	depends on HAS_IOMEM && OF
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Support for Cadence D-PHY in Rx configuration.
> +
>  config PHY_CADENCE_SIERRA
>  	tristate "Cadence Sierra PHY Driver"
>  	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> index 26e16bd34efe..e17f035ddece 100644
> --- a/drivers/phy/cadence/Makefile
> +++ b/drivers/phy/cadence/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
>  obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
> +obj-$(CONFIG_PHY_CADENCE_DPHY_RX)	+= cdns-dphy-rx.o
>  obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
>  obj-$(CONFIG_PHY_CADENCE_SALVO)	+= phy-cadence-salvo.o
> diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
> new file mode 100644
> index 000000000000..47a5b67ded58
> --- /dev/null
> +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-mipi-dphy.h>
> +#include <linux/platform_device.h>
> +
> +#define DPHY_PMA_CMN(reg)		(reg)
> +#define DPHY_PCS(reg)			(0xb00 + (reg))
> +#define DPHY_ISO(reg)			(0xc00 + (reg))
> +
> +#define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
> +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
> +#define DPHY_CMN_SSM_EN			BIT(0)
> +
> +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
> +
> +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> +
> +#define DPHY_POWER_ISLAND_EN_DATA	DPHY_PCS(0x8)
> +#define DPHY_POWER_ISLAND_EN_DATA_VAL	0xaaaaaaaa
> +
> +#define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
> +#define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> +
> +#define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
> +#define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
> +#define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> +#define DPHY_ISO_DL_CTRL_L2		DPHY_ISO(0x30)
> +#define DPHY_ISO_DL_CTRL_L3		DPHY_ISO(0x3c)
> +
> +#define DPHY_ISO_LANE_READY_BIT		0
> +#define DPHY_ISO_LANE_READY_TIMEOUT_MS	100UL
> +
> +#define DPHY_LANES_MIN			1
> +#define DPHY_LANES_MAX			4
> +
> +struct cdns_dphy_rx {
> +	void __iomem *regs;
> +	struct device *dev;
> +	struct phy *phy;
> +};
> +
> +struct cdns_dphy_rx_band {
> +	/* Rates are in Mbps. */
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +static const struct cdns_dphy_rx_band bands[] = {
> +	{ 80, 100 }, { 100, 120 }, { 120, 160 }, { 160, 200 }, { 200, 240 },
> +	{ 240, 280 }, { 280, 320 }, { 320, 360 }, { 360, 400 }, { 400, 480 },
> +	{ 480, 560 }, { 560, 640 }, { 640, 720 }, { 720, 800 }, { 800, 880 },
> +	{ 880, 1040 }, { 1040, 1200 }, { 1200, 1350 }, { 1350, 1500 },
> +	{ 1500, 1750 }, { 1750, 2000 }, { 2000, 2250 }, { 2250, 2500 }

It could be possible to store only the min or max rate, as
bands[i].max_rate == bands[i+1].min_rate. Up to you.

> +};
> +
> +static int cdns_dphy_rx_power_on(struct phy *phy)
> +{
> +	struct cdns_dphy_rx *dphy = phy_get_drvdata(phy);
> +
> +	/* Start RX state machine. */
> +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN |
> +	       FIELD_PREP(DPHY_CMN_RX_BANDGAP_TIMER_MASK,
> +			  DPHY_CMN_RX_BANDGAP_TIMER),
> +	       dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_power_off(struct phy *phy)
> +{
> +	struct cdns_dphy_rx *dphy = phy_get_drvdata(phy);
> +
> +	writel(0, dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_get_band_ctrl(unsigned long hs_clk_rate)
> +{
> +	unsigned int rate, i;
> +
> +	rate = hs_clk_rate / 1000000UL;
> +	/* Since CSI-2 clock is DDR, the bit rate is twice the clock rate. */
> +	rate *= 2;
> +
> +	if (rate < bands[0].min_rate)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < ARRAY_SIZE(bands); i++)
> +		if (rate < bands[i].max_rate)
> +			return i;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int cdns_dphy_rx_wait_for_bit(void __iomem *addr,
> +					    unsigned int bit)
> +{
> +	u32 val;
> +
> +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);
> +}
> +
> +static int cdns_dphy_rx_wait_lane_ready(struct cdns_dphy_rx *dphy,
> +					unsigned int lanes)
> +{
> +	static const u32 data_lane_ctrl[] = {DPHY_ISO_DL_CTRL_L0,
> +					     DPHY_ISO_DL_CTRL_L1,
> +					     DPHY_ISO_DL_CTRL_L2,
> +					     DPHY_ISO_DL_CTRL_L3};
> +	void __iomem *reg = dphy->regs;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Data lanes. Minimum one lane is mandatory. */
> +	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
> +		return -EINVAL;

How about moving this at the beginning of cdns_dphy_rx_configure(), to
avoid starting the configuration sequence if the parameter is wrong ?

> +
> +	/* Clock lane */
> +	ret = cdns_dphy_rx_wait_for_bit(reg + DPHY_ISO_CL_CTRL_L,
> +					DPHY_ISO_LANE_READY_BIT);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < lanes; i++) {
> +		ret = cdns_dphy_rx_wait_for_bit(reg + data_lane_ctrl[i],
> +						DPHY_ISO_LANE_READY_BIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_configure(struct phy *phy,
> +				  union phy_configure_opts *opts)
> +{
> +	struct cdns_dphy_rx *dphy = phy_get_drvdata(phy);
> +	unsigned int reg;
> +	int band_ctrl, ret;
> +
> +	band_ctrl = cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (band_ctrl < 0)
> +		return band_ctrl;
> +
> +	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
> +	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
> +	writel(reg, dphy->regs + DPHY_BAND_CFG);
> +
> +	/*
> +	 * Set the required power island phase 2 time. This is mandated by DPHY
> +	 * specs.
> +	 */
> +	reg = DPHY_POWER_ISLAND_EN_DATA_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_DATA);
> +	reg = DPHY_POWER_ISLAND_EN_CLK_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_CLK);
> +
> +	ret = cdns_dphy_rx_wait_lane_ready(dphy, opts->mipi_dphy.lanes);
> +	if (ret) {
> +		dev_err(dphy->dev, "DPHY wait for lane ready timeout\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_validate(struct phy *phy, enum phy_mode mode,
> +				 int submode, union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	if (mode != PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	ret = cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +}
> +
> +static const struct phy_ops cdns_dphy_rx_ops = {
> +	.power_on = cdns_dphy_rx_power_on,
> +	.power_off = cdns_dphy_rx_power_off,
> +	.configure = cdns_dphy_rx_configure,
> +	.validate = cdns_dphy_rx_validate,
> +};
> +
> +static int cdns_dphy_rx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *provider;
> +	struct cdns_dphy_rx *dphy;
> +
> +	dphy = devm_kzalloc(dev, sizeof(*dphy), GFP_KERNEL);
> +	if (!dphy)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, dphy);
> +	dphy->dev = dev;
> +
> +	dphy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dphy->regs))
> +		return PTR_ERR(dphy->regs);
> +
> +	dphy->phy = devm_phy_create(dev, NULL, &cdns_dphy_rx_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		dev_err(dev, "Failed to create PHY: %d\n", PTR_ERR(dphy->phy));
> +		return PTR_ERR(dphy->phy);
> +	}
> +
> +	phy_set_drvdata(dphy->phy, dphy);
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "Failed to register PHY provider: %d\n",
> +			PTR_ERR(provider));
> +		return PTR_ERR(provider);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cdns_dphy_rx_of_match[] = {
> +	{ .compatible = "cdns,dphy-rx" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, cdns_dphy_rx_of_match);
> +
> +static struct platform_driver cdns_dphy_rx_platform_driver = {
> +	.probe		= cdns_dphy_rx_probe,
> +	.driver		= {
> +		.name		= "cdns-mipi-dphy-rx",
> +		.of_match_table	= cdns_dphy_rx_of_match,
> +	},
> +};
> +module_platform_driver(cdns_dphy_rx_platform_driver);
> +
> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
> +MODULE_DESCRIPTION("Cadence D-PHY Rx Driver");
> +MODULE_LICENSE("GPL v2");

This should be "GPL". "GPL v2" exists for historical reasons (see
Documentation/process/license-rules.rst).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
