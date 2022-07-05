Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C25665A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiGEIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiGEIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:55:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CF13E0B;
        Tue,  5 Jul 2022 01:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDAAFB81671;
        Tue,  5 Jul 2022 08:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8C6C385A2;
        Tue,  5 Jul 2022 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657011283;
        bh=BHuZkW0eJ+WX6mMKEaJB7fYlXXHAt/pr6+iBHt921tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfrlx/4Nq9+LTTHzBFOowlQG96GoPQaYW15MSV8nWWHWiu9ph7x2B4A9yit1gLLCY
         pYd05Fd4c0Rcf3SGgVU1u7ajoHRy7Fq4NRdJJVKHmDMhostuRDDD7ECR04Q4XlbXjs
         CL+I2efcR841Pnt6GV3/gZNh9mP5bpXbCnVNJo03TAdBhMzvE6IymP/LcnUAZ3f8x5
         5fNpRMq1CQly6foSefLI+GlGuLRpV7wvmD8PXs+hJ9nmbmY3zfNxk0daIkBMJ8L9LO
         XxgHBE5tlIx8lsMqu0z32ifDAc09G9FIQLkUWPWupI8yLEVXFveVtvE0cNAZ55l7iX
         SJT/kQ6gdaU6w==
Date:   Tue, 5 Jul 2022 14:24:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v3 3/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Message-ID: <YsP8TYgA7SU72/xE@matsya>
References: <20220620123854.1138028-1-victor.liu@nxp.com>
 <20220620123854.1138028-4-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620123854.1138028-4-victor.liu@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-22, 20:38, Liu Ying wrote:
> Add Freescale i.MX8qm LVDS PHY support.
> The PHY IP is from Mixel, Inc.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * No change.
> 
> v1->v2:
> * Drop 'This patch' from commit message. (Krzysztof)
> * Make dev_err_probe() function calls as one-liners. (Krzysztof)
> * Drop unnecessary debug messages. (Krzysztof)
> * Get phy_ref_clk without name specified due to 'clock-names' dropped from
>   dt-binding.
> 
>  drivers/phy/freescale/Kconfig                 |   9 +
>  drivers/phy/freescale/Makefile                |   1 +
>  .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 440 ++++++++++++++++++
>  3 files changed, 450 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index f9c54cd02036..853958fb2c06 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -8,6 +8,15 @@ config PHY_FSL_IMX8MQ_USB
>  	select GENERIC_PHY
>  	default ARCH_MXC && ARM64
>  
> +config PHY_MIXEL_LVDS_PHY
> +	tristate "Mixel LVDS PHY support"
> +	depends on OF
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to add support for the Mixel LVDS PHY as found
> +	  on NXP's i.MX8qm SoC.
> +
>  config PHY_MIXEL_MIPI_DPHY
>  	tristate "Mixel MIPI DSI PHY support"
>  	depends on OF && HAS_IOMEM
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index 3518d5dbe8a7..cedb328bc4d2 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
> +obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> new file mode 100644
> index 000000000000..37f77115ddab
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
> @@ -0,0 +1,440 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2017-2020,2022 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#define REG_SET		0x4
> +#define REG_CLR		0x8
> +
> +#define PHY_CTRL	0x0
> +#define  M_MASK		GENMASK(18, 17)
> +#define  M(n)		FIELD_PREP(M_MASK, (n))
> +#define  CCM_MASK	GENMASK(16, 14)
> +#define  CCM(n)		FIELD_PREP(CCM_MASK, (n))
> +#define  CA_MASK	GENMASK(13, 11)
> +#define  CA(n)		FIELD_PREP(CA_MASK, (n))
> +#define  TST_MASK	GENMASK(10, 5)
> +#define  TST(n)		FIELD_PREP(TST_MASK, (n))
> +#define  CH_EN(id)	BIT(3 + (id))
> +#define  NB		BIT(2)
> +#define  RFB		BIT(1)
> +#define  PD		BIT(0)
> +
> +/* Power On Reset(POR) value */
> +#define  CTRL_RESET_VAL	(M(0x0) | CCM(0x4) | CA(0x4) | TST(0x25))
> +
> +/* PHY initialization value and mask */
> +#define  CTRL_INIT_MASK	(M_MASK | CCM_MASK | CA_MASK | TST_MASK | NB | RFB)
> +#define  CTRL_INIT_VAL	(M(0x0) | CCM(0x5) | CA(0x4) | TST(0x25) | RFB)
> +
> +#define PHY_STATUS	0x10
> +#define  LOCK		BIT(0)
> +
> +#define PHY_NUM		2
> +
> +#define MIN_CLKIN_FREQ	25000000

this is 25MHz, so lets write as 25 * MEGA (see units.h)

> +#define MAX_CLKIN_FREQ	165000000

here too

> +
> +#define PLL_LOCK_SLEEP		10
> +#define PLL_LOCK_TIMEOUT	1000
> +
> +struct mixel_lvds_phy {
> +	struct phy *phy;
> +	struct phy_configure_opts_lvds cfg;
> +	unsigned int id;
> +};
> +
> +struct mixel_lvds_phy_priv {
> +	struct regmap *regmap;
> +	struct mutex lock;	/* protect remap access and cfg of our own */
> +	struct clk *phy_ref_clk;
> +	struct mixel_lvds_phy *phys[PHY_NUM];
> +};
> +
> +static int mixel_lvds_phy_init(struct phy *phy)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +
> +	mutex_lock(&priv->lock);
> +	regmap_update_bits(priv->regmap,
> +			   PHY_CTRL, CTRL_INIT_MASK, CTRL_INIT_VAL);
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int mixel_lvds_phy_power_on(struct phy *phy)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
> +	struct mixel_lvds_phy *companion = priv->phys[lvds_phy->id ^ 1];
> +	struct phy_configure_opts_lvds *cfg = &lvds_phy->cfg;
> +	u32 val = 0;
> +	u32 locked;
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->phy_ref_clk);
> +	if (ret < 0) {
> +		dev_err(&phy->dev,
> +			"failed to enable PHY reference clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* The master PHY would power on the slave PHY. */
> +	if (cfg->is_slave)
> +		return 0;
> +
> +	mutex_lock(&priv->lock);
> +	if (cfg->bits_per_lane_and_dclk_cycle == 7) {
> +		if (cfg->differential_clk_rate < 44000000)
> +			val |= M(0x2);
> +		else if (cfg->differential_clk_rate < 90000000)
> +			val |= M(0x1);
> +		else
> +			val |= M(0x0);
> +	} else {
> +		val = NB;
> +
> +		if (cfg->differential_clk_rate < 32000000)
> +			val |= M(0x2);
> +		else if (cfg->differential_clk_rate < 63000000)
> +			val |= M(0x1);
> +		else
> +			val |= M(0x0);
> +	}
> +	regmap_update_bits(priv->regmap, PHY_CTRL, M_MASK | NB, val);
> +
> +	/*
> +	 * Enable two channels synchronously,
> +	 * if the companion PHY is a slave PHY.
> +	 */
> +	if (companion->cfg.is_slave)
> +		val = CH_EN(0) | CH_EN(1);
> +	else
> +		val = CH_EN(lvds_phy->id);
> +	regmap_write(priv->regmap, PHY_CTRL + REG_SET, val);
> +
> +	ret = regmap_read_poll_timeout(priv->regmap, PHY_STATUS, locked,
> +				       locked, PLL_LOCK_SLEEP,
> +				       PLL_LOCK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&phy->dev, "failed to get PHY lock: %d\n", ret);
> +		clk_disable_unprepare(priv->phy_ref_clk);
> +	}
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static int mixel_lvds_phy_power_off(struct phy *phy)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
> +
> +	mutex_lock(&priv->lock);
> +	regmap_write(priv->regmap, PHY_CTRL + REG_CLR, CH_EN(lvds_phy->id));
> +	mutex_unlock(&priv->lock);

No check for slave here?

> +
> +	clk_disable_unprepare(priv->phy_ref_clk);
> +
> +	return 0;
> +}
> +
> +static int mixel_lvds_phy_configure(struct phy *phy,
> +				    union phy_configure_opts *opts)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct phy_configure_opts_lvds *cfg = &opts->lvds;
> +	int ret;
> +
> +	ret = clk_set_rate(priv->phy_ref_clk, cfg->differential_clk_rate);
> +	if (ret)
> +		dev_err(&phy->dev,
> +			"failed to set PHY reference clock rate(%lu): %d\n",

this can fit in a single line (100 chars is okay)

> +			cfg->differential_clk_rate, ret);
> +
> +	return ret;
> +}
> +
> +/* Assume the master PHY's configuration set is cached first. */
> +static int mixel_lvds_phy_check_slave(struct phy *slave_phy)
> +{
> +	struct device *dev = &slave_phy->dev;
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev->parent);
> +	struct mixel_lvds_phy *slv = phy_get_drvdata(slave_phy);
> +	struct mixel_lvds_phy *mst = priv->phys[slv->id ^ 1];
> +	struct phy_configure_opts_lvds *mst_cfg = &mst->cfg;
> +	struct phy_configure_opts_lvds *slv_cfg = &slv->cfg;
> +
> +	if (mst_cfg->bits_per_lane_and_dclk_cycle !=
> +	    slv_cfg->bits_per_lane_and_dclk_cycle) {
> +		dev_err(dev, "number bits mismatch(mst: %u vs slv: %u)\n",
> +			mst_cfg->bits_per_lane_and_dclk_cycle,
> +			slv_cfg->bits_per_lane_and_dclk_cycle);
> +		return -EINVAL;
> +	}
> +
> +	if (mst_cfg->differential_clk_rate !=
> +	    slv_cfg->differential_clk_rate) {
> +		dev_err(dev, "dclk rate mismatch(mst: %lu vs slv: %lu)\n",
> +			mst_cfg->differential_clk_rate,
> +			slv_cfg->differential_clk_rate);
> +		return -EINVAL;
> +	}
> +
> +	if (mst_cfg->lanes != slv_cfg->lanes) {
> +		dev_err(dev, "lanes mismatch(mst: %u vs slv: %u)\n",
> +			mst_cfg->lanes, slv_cfg->lanes);
> +		return -EINVAL;
> +	}
> +
> +	if (mst_cfg->is_slave == slv_cfg->is_slave) {
> +		dev_err(dev, "master PHY is not found\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mixel_lvds_phy_validate(struct phy *phy, enum phy_mode mode,
> +				   int submode, union phy_configure_opts *opts)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
> +	struct phy_configure_opts_lvds *cfg = &opts->lvds;
> +	int ret = 0;
> +
> +	if (mode != PHY_MODE_LVDS) {
> +		dev_err(&phy->dev, "invalid PHY mode(%d)\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->bits_per_lane_and_dclk_cycle != 7 &&
> +	    cfg->bits_per_lane_and_dclk_cycle != 10) {
> +		dev_err(&phy->dev, "invalid bits per data lane(%u)\n",
> +			cfg->bits_per_lane_and_dclk_cycle);
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->lanes != 4 && cfg->lanes != 3) {
> +		dev_err(&phy->dev, "invalid data lanes(%u)\n", cfg->lanes);
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->differential_clk_rate < MIN_CLKIN_FREQ ||
> +	    cfg->differential_clk_rate > MAX_CLKIN_FREQ) {
> +		dev_err(&phy->dev, "invalid differential clock rate(%lu)\n",
> +			cfg->differential_clk_rate);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&priv->lock);
> +	/* cache configuration set of our own for check */
> +	memcpy(&lvds_phy->cfg, cfg, sizeof(*cfg));
> +
> +	if (cfg->is_slave) {
> +		ret = mixel_lvds_phy_check_slave(phy);
> +		if (ret)
> +			dev_err(&phy->dev,
> +				"failed to check slave PHY: %d\n", ret);

very ugly, single line pls

> +	}
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static const struct phy_ops mixel_lvds_phy_ops = {
> +	.init = mixel_lvds_phy_init,
> +	.power_on = mixel_lvds_phy_power_on,
> +	.power_off = mixel_lvds_phy_power_off,
> +	.configure = mixel_lvds_phy_configure,
> +	.validate = mixel_lvds_phy_validate,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int mixel_lvds_phy_reset(struct device *dev)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);

pm_runtime_resume_and_get() pls

> +	if (ret < 0) {
> +		dev_err(dev, "failed to get PM runtime: %d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_write(priv->regmap, PHY_CTRL, CTRL_RESET_VAL);
> +
> +	ret = pm_runtime_put(dev);

this seems to be done only around reset, why not in on/off method?

> +	if (ret < 0)
> +		dev_err(dev, "failed to put PM runtime: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct phy *mixel_lvds_phy_xlate(struct device *dev,
> +					struct of_phandle_args *args)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +	unsigned int phy_id;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev,
> +			"invalid argument number(%d) for 'phys' property\n",
> +			args->args_count);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	phy_id = args->args[0];
> +
> +	if (phy_id >= PHY_NUM) {
> +		dev_err(dev, "invalid PHY index(%d)\n", phy_id);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return priv->phys[phy_id]->phy;
> +}
> +
> +static int mixel_lvds_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	struct mixel_lvds_phy_priv *priv;
> +	struct mixel_lvds_phy *lvds_phy;
> +	struct phy *phy;
> +	int i;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to get regmap\n");
> +
> +	priv->phy_ref_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->phy_ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy_ref_clk),
> +				     "failed to get PHY reference clock\n");
> +
> +	mutex_init(&priv->lock);
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = mixel_lvds_phy_reset(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to do POR reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < PHY_NUM; i++) {
> +		lvds_phy = devm_kzalloc(dev, sizeof(*lvds_phy), GFP_KERNEL);
> +		if (!lvds_phy) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		phy = devm_phy_create(dev, NULL, &mixel_lvds_phy_ops);
> +		if (IS_ERR(phy)) {
> +			ret = PTR_ERR(phy);
> +			dev_err(dev, "failed to create PHY for channel%d: %d\n",
> +				i, ret);
> +			goto err;
> +		}
> +
> +		lvds_phy->phy = phy;
> +		lvds_phy->id = i;
> +		priv->phys[i] = lvds_phy;
> +
> +		phy_set_drvdata(phy, lvds_phy);
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(dev, mixel_lvds_phy_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret = PTR_ERR(phy_provider);
> +		dev_err(dev, "failed to register PHY provider: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static int mixel_lvds_phy_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mixel_lvds_phy_runtime_suspend(struct device *dev)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +
> +	/* power down */
> +	mutex_lock(&priv->lock);
> +	regmap_write(priv->regmap, PHY_CTRL + REG_SET, PD);
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mixel_lvds_phy_runtime_resume(struct device *dev)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +
> +	/* power up + control initialization */
> +	mutex_lock(&priv->lock);
> +	regmap_update_bits(priv->regmap, PHY_CTRL,
> +			   CTRL_INIT_MASK | PD, CTRL_INIT_VAL);
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mixel_lvds_phy_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mixel_lvds_phy_runtime_suspend,
> +			   mixel_lvds_phy_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id mixel_lvds_phy_of_match[] = {
> +	{ .compatible = "fsl,imx8qm-lvds-phy" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mixel_lvds_phy_of_match);
> +
> +static struct platform_driver mixel_lvds_phy_driver = {
> +	.probe	= mixel_lvds_phy_probe,
> +	.remove	= mixel_lvds_phy_remove,
> +	.driver = {
> +		.pm = &mixel_lvds_phy_pm_ops,
> +		.name = "mixel-lvds-phy",
> +		.of_match_table	= mixel_lvds_phy_of_match,
> +	}
> +};
> +module_platform_driver(mixel_lvds_phy_driver);
> +
> +MODULE_DESCRIPTION("Mixel LVDS PHY driver");
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1

-- 
~Vinod
