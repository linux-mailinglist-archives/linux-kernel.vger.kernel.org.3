Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4E471424
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhLKOGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 09:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhLKOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 09:06:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3FC061714;
        Sat, 11 Dec 2021 06:06:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so37517865edb.8;
        Sat, 11 Dec 2021 06:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpkUKCa7ycM0Kp4DVB3WQA2XUF4a6iF4mvi/kRCI3Z0=;
        b=iMt3NB66sFY9Tk+dsxSX/nzhBdfkxI6Kmg007wqF0ksOvM2VdO+HKPaVhzJvhGFlbi
         PEQmy+6VCEZSNN4ctdI3bUKVarFLKXplmhhTId07XPjIqS2A+C0LiYM6SuSCiPGLcv1T
         PXkD0OW7eDxlrSRNnU6H4GsVSF+AtxWx9RSRb47YeBwdAg1LmlDyFA1ze+WlORoJtRNL
         3FuJO7CgCguoCC5vDuB/46OyDVoQbC5jRt2CH7FvwJbUasVs0CE9/mPzh9fC76t0oMAO
         8cNdVFuk86ao39CF4vLSjjbpbyCk1CzzrkvzNffE0CEVd/oyjooxN5m+2ECVIxoK2Deh
         TqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpkUKCa7ycM0Kp4DVB3WQA2XUF4a6iF4mvi/kRCI3Z0=;
        b=g98znlrSKTtELEkwgvnA9ZJGxAjeQiJcb3R1CH1b9XxfXDDz+lAO+SD6aKsJmWedb+
         +/1WAU+FuFU/HOUQIdXy8lNw0RIGK69ntDTx2h2HcXLe6BeNYTDTmT+fX7XjmUaZlzOk
         +VcNKTafnYmJSqjsRucjWfRmD8lreTjBUudx33uc77YfMjzKvD8+Hp29y1nO1n0ca1kz
         Pnp7Njv1l49vJSfFLuHIX2GZiGQ76e0G5zoEVhlnR0qa9kle61xGtDzMjpLU/MbbEJqG
         2AXP4HtosRAtRy83/vhdGzgt5SrY8myc/zVp0kQLWpJ1rzcGKznUak+ErJmrcoWQ+sJb
         tCVw==
X-Gm-Message-State: AOAM531++FoYfJr+T+juLBu8wcVqDfbZe1VrGfz93bFX8vcDBOVHlSub
        HvaV0rBTyyoBp49WNhY7HToEJPZmEO0JyA==
X-Google-Smtp-Source: ABdhPJzvPR2PO+ir1u/Gov4lxVjGwGH4I51P8BVeJNUiQ3KMD6VyJFl6/lsRE7OpqOYi0OtvNi2fVg==
X-Received: by 2002:a50:d88b:: with SMTP id p11mr45969340edj.287.1639231604165;
        Sat, 11 Dec 2021 06:06:44 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k16sm3124614edq.77.2021.12.11.06.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:06:43 -0800 (PST)
Subject: Re: [RFC PATCH v4 3/4] phy: rockchip: add naneng combo phy for RK3568
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20211208185449.16763-1-jbx6244@gmail.com>
 <20211208185449.16763-4-jbx6244@gmail.com>
Message-ID: <79ef86db-fc79-0ef1-c5cc-d4b5770b693b@gmail.com>
Date:   Sat, 11 Dec 2021 15:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208185449.16763-4-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Some comments...Have a look if it is useful.

The key question is: does this RFC serie work?
Is someone able to give a test report?

Could you produce a version 5 serie?
- Include lee.jones@linaro.org for MFD syscon.
  Add "Acked by" to patch:
  dt-bindings: mfd: syscon: add naneng combo phy register compatible

- Change description for rockchip,enable-ssc for PCIE, SATA and USB in
patch:
  dt-bindings: phy: rockchip: Add Naneng combo PHY bindings

  Add change log for rob+dt for a new review that explains why his
  "Reviewed by" tag was not added.

- If you like include some change suggestions from version 4.

On 12/8/21 7:54 PM, Johan Jonker wrote:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.

From Rockchip RK3568 Datasheet V1.0-20201210.pdf page 16-17:

Multi-PHY0 support one of the following interfaces
USB3.0 OTG
SATA0

Multi-PHY1 support one of the following interfaces
USB3.0 Host
SATA1
QSGMII/SGMII

Multi-PHY2 support one of the following interfaces
PCIe2.1
SATA2
QSGMII/SGMII

===

This driver or documentation never mentions the phy combinations that
are possible and with which DT properties. Any suggestions?

===
Missing gmac SGMII support?

ethernet: stmicro: stmmac: Add SGMII/QSGMII support for RK3568
https://github.com/rockchip-linux/kernel/commit/1fc7cbfe9e227c700c692f1de3137914b3ea6ca6

net: stmmac: dwmac-rk: Set XPCS port1 speed for GMAC1 SGMII mode
https://github.com/rockchip-linux/kernel/commit/0b1548f20254539c4fcc24f79a50581dfe164cc3

===
It looks like SGMII connects both to phy1 and phy2 ??
How to do that in DT ?? Any example/suggestions ??

	gmac0: ethernet@fe2a0000 {
???? PHY_TYPE_SGMII
	}

	gmac1: ethernet@fe010000 {
???? PHY_TYPE_SGMII
	}


	sata0: sata@fc000000 {
		phys = <&combphy0 PHY_TYPE_SATA>;
		phy-names = "sata-phy";
	}
	sata1: sata@fc400000 {
		phys = <&combphy1 PHY_TYPE_SATA>;
		phy-names = "sata-phy";
	}
	sata2: sata@fc800000 {
		phys = <&combphy2 PHY_TYPE_SATA>;
		phy-names = "sata-phy";
	}
	usbdrd3_0: usb@fcc00000 {
		phys = <&u2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
		phy-names = "usb2-phy", "usb3-phy";
	}
	usbdrd3_1: usb@fd000000 {
		phys = <&u2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
		phy-names = "usb2-phy", "usb3-phy";
	}
	pcie2x1: pcie@fe260000 {
		phys = <&combphy2 PHY_TYPE_PCIE>;
		phy-names = "pcie-phy";
	}

> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> TEST COMPILED ONLY!
> Driver not verified with hardware!
> ---
> 
> Changed V4:
>   restyle
>   add devm_reset_control_array_get()
>   remove clk structure
>   change refclk DT parse
>   change dev_err message
>   add dot to phrase
>   add ext_refclk variable
>   add enable_ssc variable
>   rename rockchip_combphy_param_write
>   remove param_read
>   replace rockchip-naneng-combphy driver name
> ---
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 608 ++++++++++++++++++
>  3 files changed, 617 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index e812adad7..9022e395c 100644
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
> index f0eec212b..a5041efb5 100644
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
> index 000000000..56aaeed62
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip PIPE USB3.0 PCIE SATA combphy driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define BIT_WRITEABLE_SHIFT		16
> +#define REF_CLOCK_24MHz			24000000
> +#define REF_CLOCK_25MHz			25000000
> +#define REF_CLOCK_100MHz		100000000
> +/* RK3568 T22 COMBO PHY REG */
> +#define RK3568_T22_PHYREG5		0x14
> +#define T22_PHYREG5_PLL_DIV_MASK	GENMASK(7, 6)
> +#define T22_PHYREG5_PLL_DIV_SHIFT	6
> +#define T22_PHYREG5_PLL_DIV_2		1
> +
> +#define RK3568_T22_PHYREG6		0x18
> +#define T22_PHYREG6_TX_RTERM_MASK	GENMASK(7, 4)
> +#define T22_PHYREG6_TX_RTERM_SHIFT	4
> +#define T22_PHYREG6_TX_RTERM_50OHM	0x8
> +#define T22_PHYREG6_RX_RTERM_MASK	GENMASK(3, 0)
> +#define T22_PHYREG6_RX_RTERM_SHIFT	0
> +#define T22_PHYREG6_RX_RTERM_44OHM	0xF
> +
> +#define RK3568_T22_PHYREG7		0x1C
> +#define T22_PHYREG7_SSC_EN		BIT(4)
> +
> +#define RK3568_T22_PHYREG10		0x28
> +#define T22_PHYREG10_SU_TRIM_0_7	0xF0
> +
> +#define RK3568_T22_PHYREG11		0x2C
> +#define T22_PHYREG11_PLL_LPF_ADJ	0x4
> +
> +#define RK3568_T22_PHYREG12		0x30
> +#define T22_PHYREG12_RESISTER_MASK	GENMASK(5, 4)
> +#define T22_PHYREG12_RESISTER_SHIFT	0x4
> +#define T22_PHYREG12_RESISTER_HIGH_Z	0x3
> +#define T22_PHYREG12_CKRCV_AMP0		BIT(7)
> +
> +#define RK3568_T22_PHYREG13		0x34
> +#define T22_PHYREG13_CKRCV_AMP1		BIT(0)
> +
> +#define RK3568_T22_PHYREG14		0x38
> +#define T22_PHYREG14_CTLE_EN		BIT(0)
> +#define T22_PHYREG14_SSC_CNT_MASK	GENMASK(7, 6)
> +#define T22_PHYREG14_SSC_CNT_SHIFT	6
> +#define T22_PHYREG14_SSC_CNT_VALUE	0x1
> +
> +#define RK3568_T22_PHYREG15		0x3C
> +#define T22_PHYREG15_SSC_CNT_VALUE	0x5f
> +
> +#define RK3568_T22_PHYREG17		0x44
> +#define T22_PHYREG17_PLL_LOOP		0x32
> +

> +#define RK3568_T22_PHYREG31		0x7C
> +#define T22_PHYREG31_SSC_MASK		GENMASK(7, 4)
> +#define T22_PHYREG31_SSC_DIR_SHIFT	4
> +#define T22_PHYREG31_SSC_UPWARD		0
> +#define T22_PHYREG31_SSC_DOWNWARD	1
> +#define T22_PHYREG31_SSC_OFFSET_SHIFT	6
> +#define T22_PHYREG31_SSC_OFFSET_500PPM	1

Where in the TRM can I find this reg description?
Can't find matching bits???

Rockchip RK3568 TRM Part2 V1.0-20210111.pdf
page 1965 ???

Multi-PHY_Register032
Address: Operational Base + offset (0x007C)

RES[7:0]
[0]: bypass the mode of pd_ck100m controlling CKDRV
1'b0: CKDRV is on only in PCIE mode
1'b1: CKDRV is controlled by ckref_src[1:0];
[1]: select signal of pll_lock to TX/RX
1'b0: pll_lock is controlled by rate[1:0]
1'b1: pll_lock is not controlled by rate[1:0]
[2]: bypass the mode of rate[1:0] controlling pll_lock_pcs
1'b0: pll_lock_pcs is controlled by rate[1:0]
1'b1: pll_lock_pcs is not controlled by rate[1:0]
[7:3]: Reserved


> +
> +#define RK3568_T22_PHYREG32		0x80
> +#define T22_PHYREG32_PLL_KVCO_MASK	GENMASK(4, 2)
> +#define T22_PHYREG32_PLL_KVCO_SHIFT	2
> +#define T22_PHYREG32_PLL_KVCO_VALUE	2
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
> +	struct combphy_reg pipe_sgmii_mac_sel;
> +	struct combphy_reg pipe_xpcs_phy_ready;
> +	struct combphy_reg u3otg0_port_en;
> +	struct combphy_reg u3otg1_port_en;
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
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *rockchip_combphy_xlate(struct device *dev, struct of_phandle_args *args)
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
> +	const struct rockchip_combphy_cfg *phy_cfg = priv->cfg;
> +	int mac_id;
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

> +	if (device_property_present(dev, "rockchip,dis-u3otg0-port"))
> +		rockchip_combphy_param_write(priv->pipe_grf, &phy_cfg->grfcfg->u3otg0_port_en,
> +					     false);
> +
> +	if (device_property_present(dev, "rockchip,dis-u3otg1-port"))
> +		rockchip_combphy_param_write(priv->pipe_grf, &phy_cfg->grfcfg->u3otg1_port_en,
> +					     false);
> +
> +	priv->enable_ssc = device_property_present(dev, "rockchip,enable-ssc");
> +
> +	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
> +
> +	if (!device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &mac_id) &&
> +	    (mac_id > 0))
> +		rockchip_combphy_param_write(priv->pipe_grf, &phy_cfg->grfcfg->pipe_sgmii_mac_sel,
> +					     true);
> +	else
> +		rockchip_combphy_param_write(priv->pipe_grf, &phy_cfg->grfcfg->pipe_sgmii_mac_sel,
> +					     false);

When a module is reloaded or when bits are previously set by u-boot it
doesn't garantee that they are in default state, does it?
Maybe always set them regardless if the property is present to default
or a value.

val = condition ? true : false;

rockchip_combphy_param_write(priv->pipe_grf,
&phy_cfg->grfcfg->pipe_sgmii_mac_sel,
val);


> +
> +	priv->phy_rst = devm_reset_control_array_get(dev, false, false);

Does this work?

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
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +	u32 val;
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +		val &= ~T22_PHYREG31_SSC_MASK;
> +		val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +		val &= ~T22_PHYREG31_SSC_MASK;
> +		val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +		val |= T22_PHYREG14_CTLE_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +
> +		/* Set PLL KVCO fine tuning signals. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG32);
> +		val &= ~T22_PHYREG32_PLL_KVCO_MASK;
> +		val |= T22_PHYREG32_PLL_KVCO_VALUE << T22_PHYREG32_PLL_KVCO_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG32);
> +
> +		/* Enable controlling random jitter. */
> +		writel(T22_PHYREG11_PLL_LPF_ADJ, priv->mmio + RK3568_T22_PHYREG11);
> +
> +		/* Set PLL input clock divider 1/2. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG5);
> +		val &= ~T22_PHYREG5_PLL_DIV_MASK;
> +		val |= T22_PHYREG5_PLL_DIV_2 << T22_PHYREG5_PLL_DIV_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG5);
> +
> +		writel(T22_PHYREG17_PLL_LOOP, priv->mmio + RK3568_T22_PHYREG17);
> +		writel(T22_PHYREG10_SU_TRIM_0_7, priv->mmio + RK3568_T22_PHYREG10);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx. */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +		val |= T22_PHYREG14_CTLE_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +		/*
> +		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
> +		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
> +		 */
> +		val = T22_PHYREG6_TX_RTERM_50OHM << T22_PHYREG6_TX_RTERM_SHIFT;
> +		val |= T22_PHYREG6_RX_RTERM_44OHM << T22_PHYREG6_RX_RTERM_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG6);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		break;
> +	case PHY_TYPE_SGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->sgmii_mode_set, true);
> +		break;
> +	case PHY_TYPE_QSGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_rate_sel, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->qsgmii_mode_set, true);
> +		break;
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
> +			val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +			val &= ~T22_PHYREG14_SSC_CNT_MASK;
> +			val |= T22_PHYREG14_SSC_CNT_VALUE << T22_PHYREG14_SSC_CNT_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +			writel(T22_PHYREG15_SSC_CNT_VALUE, priv->mmio + RK3568_T22_PHYREG15);
> +		}
> +		break;
> +	case REF_CLOCK_25MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->mode == PHY_TYPE_PCIE) {
> +			/* PLL KVCO  fine tuning. */
> +			val = readl(priv->mmio + RK3568_T22_PHYREG32);
> +			val &= ~T22_PHYREG32_PLL_KVCO_MASK;
> +			val |= T22_PHYREG32_PLL_KVCO_VALUE << T22_PHYREG32_PLL_KVCO_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG32);
> +
> +			/* Enable controlling random jitter. */
> +			writel(T22_PHYREG11_PLL_LPF_ADJ, priv->mmio + RK3568_T22_PHYREG11);
> +
> +			val = readl(priv->mmio + RK3568_T22_PHYREG5);
> +			val &= ~T22_PHYREG5_PLL_DIV_MASK;
> +			val |= T22_PHYREG5_PLL_DIV_2 << T22_PHYREG5_PLL_DIV_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG5);
> +
> +			writel(T22_PHYREG17_PLL_LOOP, priv->mmio + RK3568_T22_PHYREG17);
> +			writel(T22_PHYREG10_SU_TRIM_0_7, priv->mmio + RK3568_T22_PHYREG10);
> +		} else if (priv->mode == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +			val &= ~T22_PHYREG31_SSC_MASK;
> +			val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +			val |= T22_PHYREG31_SSC_OFFSET_500PPM << T22_PHYREG31_SSC_OFFSET_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +		}
> +		break;
> +	default:
> +		dev_err(priv->dev, "unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->mode == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = readl(priv->mmio + RK3568_T22_PHYREG12);
> +			val &= ~T22_PHYREG12_RESISTER_MASK;
> +			val |= T22_PHYREG12_RESISTER_HIGH_Z << T22_PHYREG12_RESISTER_SHIFT;
> +			val |= T22_PHYREG12_CKRCV_AMP0;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG12);
> +
> +			val = readl(priv->mmio + RK3568_T22_PHYREG13);
> +			val |= T22_PHYREG13_CKRCV_AMP1;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG13);
> +		}
> +	}
> +
> +	if (priv->enable_ssc) {
> +		val = readl(priv->mmio + RK3568_T22_PHYREG7);
> +		val |= T22_PHYREG7_SSC_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG7);
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
> +	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
> +	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
> +	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
> +	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
> +};
> +
> +static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> +	.grfcfg		= &rk3568_combphy_grfcfgs,
> +	.combphy_cfg	= rk3568_combphy_cfg,
> +};
> +
> +static const struct of_device_id rockchip_combphy_of_match[] = {
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
