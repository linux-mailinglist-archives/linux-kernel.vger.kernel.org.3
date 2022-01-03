Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCED4836D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiACS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiACS0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:26:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC549C061761;
        Mon,  3 Jan 2022 10:26:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so139077440edb.5;
        Mon, 03 Jan 2022 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OrJM93M/1Pa0pceLB6F0Oy4dk3bRvjx0jHYiPMN36hs=;
        b=CsovT1LEeXrLAVJc0B3ym8aknleGlhFolHY7gDjdJLmvaqgTh6CD1GkZY1M2zY1DTf
         wI7InBDrUyOFK/L4OojGH7C2L7hicq6etrh7XKsRBd/gNzUEnFblD/1YTKwBciDdKmuK
         j6JYwcDqMHPZuU4PKqcoS8Dv6BF0/nLgOaNH6Uv9G6U0LNbhwSxRJwQzxijbNT7vNO8B
         BE9yWBTxNXanuyuQ0TSlNIi0wBoJRT4w0/6fJms0na8+z83RyBZJQlslc1APX4pPE7G1
         +3j5pskk8TrdmUdjMGz6DRJaNXU91cFauyuQWZo1gnfLkVporaWJuqG8nqfjC3FB3Pt7
         hV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrJM93M/1Pa0pceLB6F0Oy4dk3bRvjx0jHYiPMN36hs=;
        b=XvShL+eLWNmgpiHmY41k4y6jBFwheNXY3PO4M7lsOQ+Es0po+xt8Bg1qi00bSUCL/V
         Zgc8hSVuY5oKR9nKB60QVOM7979xXgcGp6NDfTiwieqZoTCEwPQ9srkMydnfk3lTxNva
         cRbAWNpFZgrJG2UX6eXJZGCNiUPrwIRi/gVhRPp/VRUUnCiu6Gmt4i5n5cHDtQbDR6q1
         V8PHE3OGs8DJxOYqX4yNphr+MABjnq+biOKCGeq6xYmQ/LAtBFpiqNoqZs+CFwPABEyO
         67VCX7+lnAaroh6a2aMc5Qq40UxgSopTKG0lLn/+kRWIKqdfwAHvV4L2gc4yY63ZcfUj
         +tDQ==
X-Gm-Message-State: AOAM531xu62dKYpHlkYRcf/o9+QITt6pfRbkXoGJ/d2HHOBvsAPtoqFt
        X4GsLEyPcyDWfFzvc8ElMJM=
X-Google-Smtp-Source: ABdhPJxHvNjUOAqyY/Xe2iFKnbaQUd39SRN+rhnMjxRSRB39XGx3jrQwjyZam7VEaOpcx5v5EBbzNQ==
X-Received: by 2002:aa7:c5ca:: with SMTP id h10mr44544713eds.401.1641234399359;
        Mon, 03 Jan 2022 10:26:39 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w11sm13651912edv.65.2022.01.03.10.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 10:26:38 -0800 (PST)
Subject: Re: [PATCH v7 3/4] phy: rockchip: add naneng combo phy for RK3568
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, Frank Wunderlich <frank-w@public-files.de>
References: <20211230084815.28110-1-yifeng.zhao@rock-chips.com>
 <20211230084815.28110-4-yifeng.zhao@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4838413b-c424-cf55-0699-9cd8ac23d9c2@gmail.com>
Date:   Mon, 3 Jan 2022 19:26:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211230084815.28110-4-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng, Kishon, rob+dt,

Some comments, have a look if it's useful.

====

Could the DT and phy maintainer advise the correct/right driver
structure to Yifeng, so that we can move forward!

====

This driver still follows the wrong approach.
Things used in the manufacturer tree are not necessary future proof in a
mainline kernel.
In order to switch SGMII input between lane1 and lanes2 phy structures
it is needed that there is a parent node.

Could you look at combo phy example:

https://elixir.bootlin.com/linux/latest/source/drivers/phy/marvell/phy-mvebu-a3700-comphy.c

To prevent accidents with a DT from the manefucturer tree and mainline
use a differnet compatible string for each SoC.

See version 6:
Use for_each_available_child_of_node to find all available subnodes.

Make for each SoC a structure with supported features.

Make better use of the phy frame work ops  (setmode, poweron).

====
Use enum phy_mode instead of PHY_TYPE.

PHY_TYPE are used in DT.
phy_mode are used in struct phy *phy
====

Example to generate the capabilities structure:
static const struct rk3568_multiphy_conf rk3568_multiphy_modes[] = {
	/* lane 0 */
	RK3568_MULTI_CONF_GEN(0, PHY_MODE_SATA, 0,
				    MULTI_FW_MODE_SATA),
	RK3568_MULTI_CONF_GEN(0, PHY_MODE_USB_HOST_SS, 0,
				    MULTI_FW_MODE_USB3H),
	/* lane 1 */
	RK3568_MULTI_CONF_GEN(1, PHY_MODE_SATA, 0,
				    MULTI_FW_MODE_SATA),
	RK3568_MULTI_CONF_GEN(1, PHY_MODE_USB_HOST_SS, 0,
				    MULTI_FW_MODE_USB3H),
	RK3568_MULTI_CONF_ETH(1, PHY_INTERFACE_MODE_SGMII, 0,
				    MULTI_FW_MODE_SGMII),
	/* lane 2 */
	RK3568_MULTI_CONF_GEN(2, PHY_MODE_SATA, 0,
				    MULTI_FW_MODE_SATA),
	RK3568_MULTI_CONF_ETH(2, PHY_INTERFACE_MODE_SGMII, 1,
				    MULTI_FW_MODE_SGMII),
	RK3568_MULTI_CONF_GEN(2, PHY_MODE_PCIE, 0,
				    MULTI_FW_MODE_PCIE),
};

On 12/30/21 9:48 AM, Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changes in v7:
> - rename regs
> - remove pipe_sgmii_mac_sel, u3otg0_port_en and u3otg1_port_en
> 
> Changes in v5:
> - add rockchip_combphy_updatel()
> - restyle
> 
> Changes in v4:
> - restyle
> - add devm_reset_control_array_get()
> - remove clk structure
> - change refclk DT parse
> - change dev_err message
> - add dot to phrase
> - add ext_refclk variable
> - add enable_ssc variable
> - rename rockchip_combphy_param_write
> - remove param_read
> - replace rockchip-naneng-combphy driver name
> 
> Changes in v3:
> - Using api devm_reset_control_get_optional_exclusive and dev_err_probe.
> - Remove apb_rst.
> - Redefine registers address.
> 
> Changes in v2:
> - Using api devm_platform_get_and_ioremap_resource.
> - Modify rockchip_combphy_set_Mode.
> - Add some PHY registers definition.
> 
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 589 ++++++++++++++++++
>  3 files changed, 598 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index e812adad7242..9022e395c056 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -66,6 +66,14 @@ config PHY_ROCKCHIP_INNO_DSIDPHY
>  	  Enable this to support the Rockchip MIPI/LVDS/TTL PHY with
>  	  Innosilicon IP block.
>  
> +config PHY_ROCKCHIP_NANENG_COMBO_PHY
> +	tristate "Rockchip NANENG COMBO PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
> +	  combo PHY with NaNeng IP block.
> +
>  config PHY_ROCKCHIP_PCIE
>  	tristate "Rockchip PCIe PHY Driver"
>  	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index f0eec212b2aa..a5041efb5b8f 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY)	+= phy-rockchip-inno-csidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
> +obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> new file mode 100644
> index 000000000000..47137a5c448a
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -0,0 +1,589 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip PIPE USB3.0 PCIE SATA Combo Phy driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/units.h>
> +
> +#define BIT_WRITEABLE_SHIFT		16
> +#define REF_CLOCK_24MHz			(24 * HZ_PER_MHZ)
> +#define REF_CLOCK_25MHz			(25 * HZ_PER_MHZ)
> +#define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
> +
> +/* COMBO PHY REG */
> +#define PHYREG6				0x14
> +#define PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
> +#define PHYREG6_PLL_DIV_SHIFT		6
> +#define PHYREG6_PLL_DIV_2		1
> +
> +#define PHYREG7				0x18
> +#define PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
> +#define PHYREG7_TX_RTERM_SHIFT		4
> +#define PHYREG7_TX_RTERM_50OHM		8
> +#define PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
> +#define PHYREG7_RX_RTERM_SHIFT		0
> +#define PHYREG7_RX_RTERM_44OHM		15
> +
> +#define PHYREG8				0x1C
> +#define PHYREG8_SSC_EN			BIT(4)
> +
> +#define PHYREG11			0x28
> +#define PHYREG11_SU_TRIM_0_7		0xF0
> +
> +#define PHYREG12			0x2C
> +#define PHYREG12_PLL_LPF_ADJ_VALUE	4
> +
> +#define PHYREG13			0x30
> +#define PHYREG13_RESISTER_MASK		GENMASK(5, 4)
> +#define PHYREG13_RESISTER_SHIFT		0x4
> +#define PHYREG13_RESISTER_HIGH_Z	3
> +#define PHYREG13_CKRCV_AMP0		BIT(7)
> +
> +#define PHYREG14			0x34
> +#define PHYREG14_CKRCV_AMP1		BIT(0)
> +
> +#define PHYREG15			0x38
> +#define PHYREG15_CTLE_EN		BIT(0)
> +#define PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
> +#define PHYREG15_SSC_CNT_SHIFT		6
> +#define PHYREG15_SSC_CNT_VALUE		1
> +
> +#define PHYREG16			0x3C
> +#define PHYREG16_SSC_CNT_VALUE		0x5f
> +
> +#define PHYREG18			0x44
> +#define PHYREG18_PLL_LOOP		0x32
> +
> +#define PHYREG32			0x7C
> +#define PHYREG32_SSC_MASK		GENMASK(7, 4)
> +#define PHYREG32_SSC_DIR_SHIFT		4
> +#define PHYREG32_SSC_UPWARD		0
> +#define PHYREG32_SSC_DOWNWARD		1
> +#define PHYREG32_SSC_OFFSET_SHIFT	6
> +#define PHYREG32_SSC_OFFSET_500PPM	1
> +
> +#define PHYREG33			0x80
> +#define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
> +#define PHYREG33_PLL_KVCO_SHIFT		2
> +#define PHYREG33_PLL_KVCO_VALUE		2
> +
> +struct rockchip_combphy_priv;
> +
> +struct combphy_reg {
> +	u16 offset;
> +	u16 bitend;
> +	u16 bitstart;
> +	u16 disable;
> +	u16 enable;
> +};
> +
> +struct rockchip_combphy_grfcfg {
> +	struct combphy_reg pcie_mode_set;
> +	struct combphy_reg usb_mode_set;
> +	struct combphy_reg sgmii_mode_set;
> +	struct combphy_reg qsgmii_mode_set;
> +	struct combphy_reg pipe_rxterm_set;
> +	struct combphy_reg pipe_txelec_set;
> +	struct combphy_reg pipe_txcomp_set;
> +	struct combphy_reg pipe_clk_25m;
> +	struct combphy_reg pipe_clk_100m;
> +	struct combphy_reg pipe_phymode_sel;
> +	struct combphy_reg pipe_rate_sel;
> +	struct combphy_reg pipe_rxterm_sel;
> +	struct combphy_reg pipe_txelec_sel;
> +	struct combphy_reg pipe_txcomp_sel;
> +	struct combphy_reg pipe_clk_ext;
> +	struct combphy_reg pipe_sel_usb;
> +	struct combphy_reg pipe_sel_qsgmii;
> +	struct combphy_reg pipe_phy_status;
> +	struct combphy_reg con0_for_pcie;
> +	struct combphy_reg con1_for_pcie;
> +	struct combphy_reg con2_for_pcie;
> +	struct combphy_reg con3_for_pcie;
> +	struct combphy_reg con0_for_sata;
> +	struct combphy_reg con1_for_sata;
> +	struct combphy_reg con2_for_sata;
> +	struct combphy_reg con3_for_sata;
> +	struct combphy_reg pipe_con0_for_sata;
> +	struct combphy_reg pipe_xpcs_phy_ready;
> +};
> +
> +struct rockchip_combphy_cfg {
> +	const struct rockchip_combphy_grfcfg *grfcfg;
> +	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
> +};
> +
> +struct rockchip_combphy_priv {
> +	u8 mode;
> +	void __iomem *mmio;
> +	int num_clks;
> +	struct clk_bulk_data *clks;
> +	struct device *dev;
> +	struct regmap *pipe_grf;
> +	struct regmap *phy_grf;
> +	struct phy *phy;
> +	struct reset_control *phy_rst;
> +	const struct rockchip_combphy_cfg *cfg;
> +	bool enable_ssc;
> +	bool ext_refclk;
> +	struct clk *refclk;
> +};
> +
> +static void rockchip_combphy_updatel(struct rockchip_combphy_priv *priv,
> +				     int mask, int val, int reg)
> +{
> +	unsigned int temp;
> +
> +	temp = readl(priv->mmio + reg);
> +	temp = (temp & ~(mask)) | val;
> +	writel(temp, priv->mmio + reg);
> +}
> +
> +static int rockchip_combphy_param_write(struct regmap *base,
> +					const struct combphy_reg *reg, bool en)
> +{
> +	u32 val, mask, tmp;
> +
> +	tmp = en ? reg->enable : reg->disable;
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
> +
> +	return regmap_write(base, reg->offset, val);
> +}
> +
> +static u32 rockchip_combphy_is_ready(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 mask, val;
> +
> +	mask = GENMASK(cfg->pipe_phy_status.bitend,
> +		       cfg->pipe_phy_status.bitstart);
> +
> +	regmap_read(priv->phy_grf, cfg->pipe_phy_status.offset, &val);
> +	val = (val & mask) >> cfg->pipe_phy_status.bitstart;
> +
> +	return val;
> +}
> +

> +static int rockchip_combphy_set_mode(struct rockchip_combphy_priv *priv)

static int rockchip_combphy_set_mode(struct phy *phy, enum phy_mode
mode, int submode)

	/* Use this function to remember the mode, ->power_on() will do the
real setup */

> +{
> +	int ret = 0;
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +	case PHY_TYPE_USB3:
> +	case PHY_TYPE_SATA:
> +	case PHY_TYPE_SGMII:
> +	case PHY_TYPE_QSGMII:
> +		if (priv->cfg->combphy_cfg)
> +			ret = priv->cfg->combphy_cfg(priv);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		dev_err(priv->dev, "failed to init phy for phy mode %x\n", priv->mode);
> +



> +	return ret;
> +}
> +

> +static int rockchip_combphy_init(struct phy *phy)

poweron

> +{
> +	struct rockchip_combphy_priv *priv = phy_get_drvdata(phy);
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to enable clks\n");
> +		return ret;
> +	}
> +

> +	ret = rockchip_combphy_set_mode(priv);
> +	if (ret)
> +		goto err_clk;
> +

Make use of phy frame work for setmode.

> +	ret = reset_control_deassert(priv->phy_rst);
> +	if (ret)
> +		goto err_clk;
> +
> +	if (priv->mode == PHY_TYPE_USB3) {
> +		ret = readx_poll_timeout_atomic(rockchip_combphy_is_ready,
> +						priv, val,
> +						val == cfg->pipe_phy_status.enable,
> +						10, 1000);
> +		if (ret)
> +			dev_warn(priv->dev, "wait phy status ready timeout\n");
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +
> +	return ret;
> +}
> +

> +static int rockchip_combphy_exit(struct phy *phy)

poweroff

> +{
> +	struct rockchip_combphy_priv *priv = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +	reset_control_assert(priv->phy_rst);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops rochchip_combphy_ops = {
> +	.init = rockchip_combphy_init,
> +	.exit = rockchip_combphy_exit,

Maybe use poweron poweroff

.set_mode = rockchip_combphy_set_mode,

> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *rockchip_combphy_xlate(struct device *dev, struct of_phandle_args *args)

use xlate to translate phy structure to lanes.

> +{
> +	struct rockchip_combphy_priv *priv = dev_get_drvdata(dev);
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of arguments\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (priv->mode != PHY_NONE && priv->mode != args->args[0])
> +		dev_warn(dev, "phy type select %d overwriting type %d\n",
> +			 args->args[0], priv->mode);
> +
> +	priv->mode = args->args[0];




> +
> +	return priv->phy;
> +}
> +
> +static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy_priv *priv)
> +{
> +	int i;
> +
> +	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
> +	if (priv->num_clks < 1)
> +		return -EINVAL;
> +
> +	priv->refclk = NULL;
> +	for (i = 0; i < priv->num_clks; i++) {
> +		if (!strncmp(priv->clks[i].id, "ref", 3)) {
> +			priv->refclk = priv->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	if (!priv->refclk) {
> +		dev_err(dev, "no refclk found\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,pipe-grf");
> +	if (IS_ERR(priv->pipe_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap\n");
> +		return PTR_ERR(priv->pipe_grf);
> +	}
> +
> +	priv->phy_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,pipe-phy-grf");
> +	if (IS_ERR(priv->phy_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-phy-grf regmap\n");
> +		return PTR_ERR(priv->phy_grf);
> +	}
> +
> +	priv->enable_ssc = device_property_present(dev, "rockchip,enable-ssc");
> +
> +	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
> +
> +	priv->phy_rst = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(priv->phy_rst))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
> +
> +	return 0;
> +}
> +
> +static int rockchip_combphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_combphy_priv *priv;
> +	const struct rockchip_combphy_cfg *phy_cfg;
> +	struct resource *res;
> +	int ret;
> +
> +	phy_cfg = of_device_get_match_data(dev);
> +	if (!phy_cfg) {
> +		dev_err(dev, "no OF match data provided\n");
> +		return -EINVAL;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->mmio)) {
> +		ret = PTR_ERR(priv->mmio);
> +		return ret;
> +	}
> +
> +	priv->dev = dev;
> +	priv->mode = PHY_NONE;
> +	priv->cfg = phy_cfg;
> +
> +	ret = rockchip_combphy_parse_dt(dev, priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_assert(priv->phy_rst);
> +	if (ret) {
> +		dev_err(dev, "failed to reset phy\n");
> +		return ret;
> +	}
> +
> +	priv->phy = devm_phy_create(dev, NULL, &rochchip_combphy_ops);
> +	if (IS_ERR(priv->phy)) {
> +		dev_err(dev, "failed to create combphy\n");
> +		return PTR_ERR(priv->phy);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	phy_set_drvdata(priv->phy, priv);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, rockchip_combphy_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
struct phy *phy

Use phy structure to pass data.
See version 6.

> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +	u32 val;
> +


> +	switch (priv->mode) {

switch phy/lane modes

> +	case PHY_TYPE_PCIE:
PHY_MODE_PCIE

> +		/* Set SSC downward spread spectrum. */
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					 PHYREG32);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +

> +	case PHY_TYPE_USB3:

PHY_MODE_USB_DEVICE_SS

> +		/* Set SSC downward spread spectrum. */
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					 PHYREG32);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx. */
> +		val = readl(priv->mmio + PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, priv->mmio + PHYREG15);
> +
> +		/* Set PLL KVCO fine tuning signals. */
> +		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
> +					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
> +					 PHYREG33);
> +
> +		/* Enable controlling random jitter. */
> +		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
> +
> +		/* Set PLL input clock divider 1/2. */
> +		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
> +					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
> +					 PHYREG6);
> +
> +		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
> +		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +

> +	case PHY_TYPE_SATA:

PHY_MODE_SATA

> +		/* Enable adaptive CTLE for SATA Rx. */
> +		val = readl(priv->mmio + PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, priv->mmio + PHYREG15);
> +		/*
> +		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
> +		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
> +		 */
> +		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
> +		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
> +		writel(val, priv->mmio + PHYREG7);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);

> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);

3xSATA -> 3xprobe -> 3x: call rk3568_combphy_cfg -> 3xaccess pipe_grf

Pipe_grf is not reset, so previous (modules,probe,u-boot) state is
unknown. This driver is just assuming all bit are right.
Fix writing to common grf. Make it idiot proof!


> +		break;
> +


Use sub nodes.
Use phy structure to pass INTERFACE_MODE with arg[]

	case PHY_MODE_ETHERNET:
		switch (lane->submode) {
		case PHY_INTERFACE_MODE_SGMII

> +	case PHY_TYPE_SGMII:

> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->sgmii_mode_set, true);
> +		break;
> +

		case PHY_INTERFACE_MODE_QSGMII:
> +	case PHY_TYPE_QSGMII:


> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_rate_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->qsgmii_mode_set, true);
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(priv->refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		if (priv->mode == PHY_TYPE_USB3 || priv->mode == PHY_TYPE_SATA) {
> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
> +			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
> +						 val, PHYREG15);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
> +		}
> +		break;
> +
> +	case REF_CLOCK_25MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->mode == PHY_TYPE_PCIE) {
> +			/* PLL KVCO  fine tuning. */
> +			val = PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
> +						 val, PHYREG33);
> +
> +			/* Enable controlling random jitter. */
> +			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
> +
> +			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
> +						 val, PHYREG6);
> +
> +			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
> +			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
> +		} else if (priv->mode == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
> +			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
> +		}
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->mode == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
> +			val |= PHYREG13_CKRCV_AMP0;
> +			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
> +
> +			val = readl(priv->mmio + PHYREG14);
> +			val |= PHYREG14_CKRCV_AMP1;
> +			writel(val, priv->mmio + PHYREG14);
> +		}
> +	}
> +
> +	if (priv->enable_ssc) {
> +		val = readl(priv->mmio + PHYREG8);
> +		val |= PHYREG8_SSC_EN;
> +		writel(val, priv->mmio + PHYREG8);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.sgmii_mode_set		= { 0x0000, 5, 0, 0x00, 0x01 },
> +	.qsgmii_mode_set	= { 0x0000, 5, 0, 0x00, 0x21 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_sel_usb		= { 0x000c, 14, 13, 0x00, 0x01 },
> +	.pipe_sel_qsgmii	= { 0x000c, 15, 13, 0x00, 0x07 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0119 },
> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0040 },
> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c3 },
> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
> +	/* pipe-grf */
> +	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
> +	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
> +};
> +

rk3568_multiphy_modes structure

> +static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> +	.grfcfg		= &rk3568_combphy_grfcfgs,
> +	.combphy_cfg	= rk3568_combphy_cfg,
> +};
> +
> +static const struct of_device_id rockchip_combphy_of_match[] = {

rk3566
rk3568
rk3588

> +	{
> +		.compatible = "rockchip,rk3568-naneng-combphy",
> +		.data = &rk3568_combphy_cfgs,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_combphy_of_match);
> +
> +static struct platform_driver rockchip_combphy_driver = {
> +	.probe	= rockchip_combphy_probe,
> +	.driver = {
> +		.name = "rockchip-naneng-combphy",
> +		.of_match_table = rockchip_combphy_of_match,
> +	},
> +};
> +module_platform_driver(rockchip_combphy_driver);
> +
> +MODULE_DESCRIPTION("Rockchip NANENG COMBPHY driver");
> +MODULE_LICENSE("GPL v2");
> 
