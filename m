Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC904FF41D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiDMJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiDMJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673123ED0F;
        Wed, 13 Apr 2022 02:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E813E61C65;
        Wed, 13 Apr 2022 09:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BDBC385A3;
        Wed, 13 Apr 2022 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843385;
        bh=1BfLGkK1rv4hX6wZhBXevkYnV1nm2u0TCXElbfP/1G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNqtmEn6lMxywD3HCQXh+WhpsohbOEk2sZUBk/xX/j5IKE5NIKUxVA/E7c2sTOfVE
         6TCKyUw1txxZf6wEQ7faLzuR4/esamJhRuouW2a8XPgKm0lJQjsxBd4u0vi0YDw8t1
         9DuMfGJSc6th6xuE0z+982yHDlHje091hyHbdW9bTeUCVkBIYh/UImlsJthe+cMbwU
         LCpDtpnsFFwJlPK5jGQrALxpcxiJ8zhrUfrZv1z+Poo1Q5YuF4Zy00WnAQ/UlMmQgg
         MAHUHYorDewHhLQHa52l6QlQbi9MuDYNWyOaiNGH0AXaczS0Bc8e84DokzJnnlsnxV
         lgC9i8Gkqmlag==
Date:   Wed, 13 Apr 2022 15:19:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     kishon@ti.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v1 1/2] phy: usb: Add USB2.0 phy driver for Sunplus SP7021
Message-ID: <YlactHJyZ6QnNV5j@matsya>
References: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
 <1646393418-26421-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646393418-26421-2-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-22, 19:30, Vincent Shih wrote:
> Add USB2.0 phy driver for Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  MAINTAINERS                            |   8 ++
>  drivers/phy/Kconfig                    |   1 +
>  drivers/phy/Makefile                   |   1 +
>  drivers/phy/sunplus/Kconfig            |  12 ++
>  drivers/phy/sunplus/Makefile           |   2 +
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 248 +++++++++++++++++++++++++++++++++
>  6 files changed, 272 insertions(+)
>  create mode 100644 drivers/phy/sunplus/Kconfig
>  create mode 100644 drivers/phy/sunplus/Makefile
>  create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80eebc1..a3bb35e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17947,6 +17947,14 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS USB2 PHY DRIVER
> +M:	Vincent Shih <vincent.sunplus@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	drivers/phy/sunplus/Kconfig
> +F:	drivers/phy/sunplus/Makefile
> +F:	drivers/phy/sunplus/phy-sunplus-usb2.c
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 82b63e6..d97e22e 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -90,6 +90,7 @@ source "drivers/phy/rockchip/Kconfig"
>  source "drivers/phy/samsung/Kconfig"
>  source "drivers/phy/socionext/Kconfig"
>  source "drivers/phy/st/Kconfig"
> +source "drivers/phy/sunplus/Kconfig"
>  source "drivers/phy/tegra/Kconfig"
>  source "drivers/phy/ti/Kconfig"
>  source "drivers/phy/intel/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 01e9eff..ed88b6f 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
>  					   samsung/	\
>  					   socionext/	\
>  					   st/		\
> +					   sunplus/		\
>  					   tegra/	\
>  					   ti/		\
>  					   xilinx/
> diff --git a/drivers/phy/sunplus/Kconfig b/drivers/phy/sunplus/Kconfig
> new file mode 100644
> index 0000000..beb85f4
> --- /dev/null
> +++ b/drivers/phy/sunplus/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config PHY_SUNPLUS_USB
> +	tristate "Sunplus USB2 PHY driver"
> +	depends on OF && (SOC_SP7021 || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB 2.0 PHY on Sunplus SP7021
> +	  SoC. The USB 2.0 PHY controller supports battery charger
> +	  and synchronous signals, various power down modes including
> +	  operating, partial and suspend modes, and high-speed,
> +	  full-speed and low-speed data transfer.
> diff --git a/drivers/phy/sunplus/Makefile b/drivers/phy/sunplus/Makefile
> new file mode 100644
> index 0000000..71754d5
> --- /dev/null
> +++ b/drivers/phy/sunplus/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_PHY_SUNPLUS_USB)	+= phy-sunplus-usb2.o
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> new file mode 100644
> index 0000000..a2c17ca
> --- /dev/null
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Sunplus SP7021 USB 2.0 phy driver
> + *
> + * Copyright (C) 2021 Sunplus Technology Inc., All rights reserved.

2022

> + *
> + * Note 1 : non-posted write command for the registers accesses of
> + * Sunplus SP7021.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#define RF_MASK_V(_mask, _val)			(((_mask) << 16) | (_val))
> +#define RF_MASK_V_CLR(_mask)			(((_mask) << 16) | 0)

Please use FIELD_PREP and FIELD_GET macros for these

> +
> +#define MASK_BITS				0xffff
> +#define OTP_DISC_LEVEL_DEFAULT			0xd
> +
> +// GROUP UPHY
> +#define CONFIG1					0x4
> +#define J_HS_TX_PWRSAV				BIT(5)
> +#define CONFIG3					0xc

GENAMSK() ?


> +#define J_FORCE_DISC_ON				BIT(5)
> +#define J_DEBUG_CTRL_ADDR_MACRO			BIT(0)
> +#define CONFIG7					0x1c
> +#define J_DISC					0X1f
> +#define CONFIG9					0x24
> +#define J_ECO_PATH				BIT(6)
> +#define CONFIG16				0x40
> +#define J_TBCWAIT_MASK				GENMASK(6, 5)
> +#define J_TBCWAIT_1P1_MS			FIELD_PREP(J_TBCWAIT_MASK, 0)
> +#define J_TVDM_SRC_DIS_MASK			GENMASK(4, 3)
> +#define J_TVDM_SRC_DIS_8P2_MS			FIELD_PREP(J_TVDM_SRC_DIS_MASK, 3)
> +#define J_TVDM_SRC_EN_MASK			GENMASK(2, 1)
> +#define J_TVDM_SRC_EN_1P6_MS			FIELD_PREP(J_TVDM_SRC_EN_MASK, 0)
> +#define J_BC_EN					BIT(0)
> +#define CONFIG17				0x44
> +#define IBG_TRIM0_MASK				GENMASK(7, 5)
> +#define IBG_TRIM0_SSLVHT			FIELD_PREP(IBG_TRIM0_MASK, 4)
> +#define J_VDATREE_TRIM_MASK			GENMASK(4, 1)
> +#define J_VDATREE_TRIM_DEFAULT			FIELD_PREP(J_VDATREE_TRIM_MASK, 9)
> +#define CONFIG23				0x5c
> +#define PROB_MASK				GENMASK(5, 3)
> +#define PROB					FIELD_PREP(PROB_MASK, 7)
> +
> +// GROUP MOON4

wrong comments style

> +static int sp_uphy_init(struct phy *phy)
> +{
> +	struct sp_usbphy *usbphy = phy_get_drvdata(phy);
> +	struct nvmem_cell *cell;
> +	char *disc_name = "disc_vol";
> +	ssize_t otp_l = 0;
> +	char *otp_v;
> +	u32 val, set, pll_pwr_on, pll_pwr_off;
> +
> +	/* Default value modification */
> +	writel(RF_MASK_V(MASK_BITS, 0x4002), usbphy->moon4_regs + UPHY_CONTROL0);
> +	writel(RF_MASK_V(MASK_BITS, 0x8747), usbphy->moon4_regs + UPHY_CONTROL1);
> +
> +	/* PLL power off/on twice */
> +	pll_pwr_off = (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MASK_BITS)
> +			| MO1_UPHY_PLL_POWER_OFF_SEL | MO1_UPHY_PLL_POWER_OFF;
> +	pll_pwr_on = (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MASK_BITS)
> +			| MO1_UPHY_PLL_POWER_OFF_SEL;
> +
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UPHY_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPHY_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UPHY_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPHY_CONTROL3);
> +	mdelay(1);

why delay on each register write?

> +	writel(RF_MASK_V(MASK_BITS, 0x0), usbphy->moon4_regs + UPHY_CONTROL3);
> +
> +	/* board uphy 0 internal register modification for tid certification */
> +	cell = nvmem_cell_get(usbphy->dev, disc_name);
> +	if (IS_ERR_OR_NULL(cell)) {
> +		if (PTR_ERR(cell) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	otp_v = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);
> +
> +	if (otp_v) {
> +		set = *(otp_v + 1);
> +		set = (set << (sizeof(char) * 8)) | *otp_v;
> +		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
> +	}
> +
> +	if (!otp_v || set == 0)
> +		set = OTP_DISC_LEVEL_DEFAULT;
> +
> +	val = readl(usbphy->phy_regs + CONFIG7);
> +	val = (val & ~J_DISC) | set;
> +	writel(val, usbphy->phy_regs + CONFIG7);

maybe add a updatel() macro

> +static const struct phy_ops sp_uphy_ops = {
> +	.init		= sp_uphy_init,

no power_on/off/exit routines??

> +static const struct of_device_id sp_uphy_dt_ids[] = {
> +	{.compatible = "sunplus,sp7021-usb2-phy",
> +	 .data = &sp_uphy_ops,},

why should the ops be in driver data?

-- 
~Vinod
