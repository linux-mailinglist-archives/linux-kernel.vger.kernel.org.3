Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08ED4B4465
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiBNIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbiBNIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:38:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD93669D;
        Mon, 14 Feb 2022 00:38:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BC89B80DAD;
        Mon, 14 Feb 2022 08:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CDBC340E9;
        Mon, 14 Feb 2022 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644827918;
        bh=SK9GP+YjxYRjwidcx5rhZWUqddOGCD3hC2rVka+pUcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=No+BLVMqBQvKfhJtPvQ3azMFH9CkhZLOFusiV3vHbZEQ4kBiqyIVGcjcKA7lyKy/T
         PoRG0LXTD/4Wzc97MJk18g8kCKJmX7poP+yCCTLyFvlWK5jiHH4/JsGBnJdZhq5Vx0
         ee3EyxVC1fJz6VOle1GAnJLbrfZjxDcXgiwKEW4g=
Date:   Mon, 14 Feb 2022 09:38:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v1 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
Message-ID: <YgoVBv/z1uCsR1Y0@kroah.com>
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:32:41PM +0800, Vincent Shih wrote:
> Add driver for ehci in Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  MAINTAINERS                     |   6 +
>  drivers/usb/host/Kconfig        |  11 +
>  drivers/usb/host/Makefile       |   1 +
>  drivers/usb/host/ehci-sunplus.c | 527 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 545 insertions(+)
>  create mode 100644 drivers/usb/host/ehci-sunplus.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80eebc1..6c2faf3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17947,6 +17947,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS USB EHCI DRIVER
> +M:	Vincent Shih <vincent.sunplus@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	drivers/usb/host/ehci-sunplus.c
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index c4736d1..9728d3b 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -339,6 +339,17 @@ config USB_OCTEON_EHCI
>  	  USB 2.0 device support.  All CN6XXX based chips with USB are
>  	  supported.
>  
> +config USB_EHCI_SUNPLUS
> +	tristate "EHCI support for Sunplus USB controller"
> +	depends on SOC_SP7021
> +	select NVMEM_SUNPLUS_OCOTP
> +	help
> +	  Enables support for the on-chip EHCI controller in Sunplus
> +	  SoCs. It supports 32-bit AHB/AXI config bus and 64-bit AXI
> +	  data bus.
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ehci-sunplus.
> +
>  endif # USB_EHCI_HCD
>  
>  config USB_OXU210HP_HCD
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 171de4d..7e9b5f1 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
>  obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
>  obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
>  obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
> +obj-$(CONFIG_USB_EHCI_SUNPLUS)	+= ehci-sunplus.o
>  
>  obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
>  obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
> diff --git a/drivers/usb/host/ehci-sunplus.c b/drivers/usb/host/ehci-sunplus.c
> new file mode 100644
> index 0000000..007923a
> --- /dev/null
> +++ b/drivers/usb/host/ehci-sunplus.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * The EHCI driver for Sunplus SP7021
> + *
> + * Copyright (C) 2019 Sunplus Technology Inc., All rights reserved.

You have not touched this file since 2019?


> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb.h>
> +#include <linux/usb/ehci_pdriver.h>
> +#include <linux/usb/hcd.h>
> +
> +#include "ehci.h"
> +
> +#define RF_MASK_V(mask, val)			(((mask) << 16) | (val))
> +#define RF_MASK_V_CLR(mask)			(((mask) << 16) | 0)
> +
> +#define USB_PORT0_ID				0
> +#define USB_PORT1_ID				1
> +#define USB_PORT_NUM				2
> +
> +#define MASK_BITS				0xffff
> +
> +#define OTP_DISC_LEVEL_DEFAULT			0xd
> +#define OTP_DISC_LEVEL_BITS			0x5
> +
> +// GROUP 140/150 UPHY0/UPHY1
> +#define CONFIG1					0x4
> +#define J_HS_TX_PWRSAV				BIT(5)
> +#define CONFIG3					0xc
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
> +// GROUP 0 MOON 0
> +#define HARDWARE_RESET_CONTROL2			0x5c
> +#define UPHY1_RESET				BIT(14)
> +#define UPHY0_RESET				BIT(13)
> +#define USBC1_RESET				BIT(11)
> +#define USBC0_RESET				BIT(10)
> +
> +// GROUP 4 MOON 4
> +#define USBC_CONTROL				0x44
> +#define MO1_USBC1_USB0_SEL			BIT(13)
> +#define MO1_USBC1_USB0_CTRL			BIT(12)
> +#define MO1_USBC0_USB0_SEL			BIT(5)
> +#define MO1_USBC0_USB0_CTRL			BIT(4)
> +#define UPHY0_CONTROL0				0x48
> +#define UPHY0_CONTROL1				0x4c
> +#define UPHY0_CONTROL2				0x50
> +#define MO1_UPHY0_RX_CLK_SEL			BIT(6)
> +#define UPHY0_CONTROL3				0x54
> +#define MO1_UPHY0_PLL_POWER_OFF_SEL		BIT(7)
> +#define MO1_UPHY0_PLL_POWER_OFF			BIT(3)
> +#define UPHY1_CONTROL0				0x58
> +#define UPHY1_CONTROL1				0x5c
> +#define UPHY1_CONTROL2				0x60
> +#define MO1_UPHY1_RX_CLK_SEL			BIT(6)
> +#define UPHY1_CONTROL3				0x64
> +#define MO1_UPHY1_PLL_POWER_OFF_SEL		BIT(7)
> +#define MO1_UPHY1_PLL_POWER_OFF			BIT(3)
> +
> +#define hcd_to_sp_ehci_priv(h) \
> +		((struct sp_ehci_priv *)hcd_to_ehci(h)->priv)
> +
> +struct sp_ehci_priv {
> +	struct resource *uphy_res_mem[USB_PORT_NUM];
> +	struct resource *moon0_res_mem;
> +	struct resource *moon4_res_mem;
> +	struct clk *uphy_clk[USB_PORT_NUM];
> +	struct clk *ehci_clk[USB_PORT_NUM];
> +	void __iomem *uphy_regs[USB_PORT_NUM];
> +	void __iomem *moon0_regs;
> +	void __iomem *moon4_regs;
> +};
> +
> +static int ehci_sunplus_reset(struct usb_hcd *hcd)
> +{
> +	struct platform_device *pdev = to_platform_device(hcd->self.controller);
> +	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int retval;
> +
> +	hcd->has_tt = pdata->has_tt;
> +	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
> +	ehci->big_endian_desc = pdata->big_endian_desc;
> +	ehci->big_endian_mmio = pdata->big_endian_mmio;
> +
> +	ehci->caps = hcd->regs + pdata->caps_offset;
> +	retval = ehci_setup(hcd);
> +
> +	return retval;
> +}
> +
> +static struct hc_driver __read_mostly ehci_sunplus_driver;
> +
> +static const struct ehci_driver_overrides ehci_sunplus_overrides __initconst = {
> +	.reset =		ehci_sunplus_reset,
> +	.extra_priv_size =	sizeof(struct sp_ehci_priv),
> +};
> +
> +static int uphy0_init(struct platform_device *pdev, struct sp_ehci_priv *sp_priv)
> +{
> +	struct nvmem_cell *cell;
> +	char *disc_name = "disc_vol";
> +	ssize_t otp_l = 0;
> +	char *otp_v;
> +	int port = pdev->id - 1;
> +	u32 val, set, pll_pwr_on, pll_pwr_off;
> +
> +	/* Default value modification */
> +	writel(RF_MASK_V(MASK_BITS, 0x4002), sp_priv->moon4_regs + UPHY0_CONTROL0);
> +	writel(RF_MASK_V(MASK_BITS, 0x8747), sp_priv->moon4_regs + UPHY0_CONTROL1);
> +
> +	/* PLL power off/on twice */
> +	pll_pwr_off = (readl(sp_priv->moon4_regs + UPHY0_CONTROL3) & ~MASK_BITS)
> +			| MO1_UPHY0_PLL_POWER_OFF_SEL | MO1_UPHY0_PLL_POWER_OFF;
> +	pll_pwr_on = (readl(sp_priv->moon4_regs + UPHY0_CONTROL3) & ~MASK_BITS)
> +			| MO1_UPHY0_PLL_POWER_OFF_SEL;
> +
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + UPHY0_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + UPHY0_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + UPHY0_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + UPHY0_CONTROL3);
> +	mdelay(1);
> +	writel(RF_MASK_V(MASK_BITS, 0x0), sp_priv->moon4_regs + UPHY0_CONTROL3);
> +

Why not just do a read after a write so that you know that is the
correct delay?  Doing a sleep like this seems slow and possibly wrong.

> +	/* reset UPHY0 */
> +	writel(RF_MASK_V(UPHY0_RESET, UPHY0_RESET), sp_priv->moon0_regs + HARDWARE_RESET_CONTROL2);
> +	writel(RF_MASK_V_CLR(UPHY0_RESET), sp_priv->moon0_regs + HARDWARE_RESET_CONTROL2);
> +	mdelay(1);

Again, read()?

> +
> +	/* board uphy 0 internal register modification for tid certification */
> +	cell = nvmem_cell_get(&pdev->dev, disc_name);
> +	if (IS_ERR_OR_NULL(cell)) {
> +		if (PTR_ERR(cell) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	otp_v = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);
> +
> +	if (otp_v)
> +		set = ((*otp_v >> OTP_DISC_LEVEL_BITS) |
> +			(*(otp_v + 1) << (sizeof(char) * 8 - OTP_DISC_LEVEL_BITS))) & J_DISC;
> +
> +	if (!otp_v || set == 0)
> +		set = OTP_DISC_LEVEL_DEFAULT;
> +
> +	val = readl(sp_priv->uphy_regs[port] + CONFIG7);
> +	val = (val & ~J_DISC) | set;
> +	writel(val, sp_priv->uphy_regs[port] + CONFIG7);
> +
> +	val = readl(sp_priv->uphy_regs[port] + CONFIG9);
> +	val &= ~(J_ECO_PATH);
> +	writel(val, sp_priv->uphy_regs[port] + CONFIG9);
> +
> +	val = readl(sp_priv->uphy_regs[port] + CONFIG1);
> +	val &= ~(J_HS_TX_PWRSAV);
> +	writel(val, sp_priv->uphy_regs[port] + CONFIG1);
> +
> +	val = readl(sp_priv->uphy_regs[port] + CONFIG23);
> +	val = (val & ~PROB) | PROB;
> +	writel(val, sp_priv->uphy_regs[port] + CONFIG23);
> +
> +	/* USBC 0 reset */
> +	writel(RF_MASK_V(USBC0_RESET, USBC0_RESET), sp_priv->moon0_regs + HARDWARE_RESET_CONTROL2);
> +	writel(RF_MASK_V_CLR(USBC0_RESET), sp_priv->moon0_regs + HARDWARE_RESET_CONTROL2);
> +
> +	/* port 0 uphy clk fix */
> +	writel(RF_MASK_V(MO1_UPHY0_RX_CLK_SEL, MO1_UPHY0_RX_CLK_SEL),
> +	       sp_priv->moon4_regs + UPHY0_CONTROL2);
> +
> +	/* switch to host */
> +	writel(RF_MASK_V(MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL,
> +			 MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL),
> +	       sp_priv->moon4_regs + USBC_CONTROL);
> +
> +	/* battery charger */
> +	writel(J_TBCWAIT_1P1_MS | J_TVDM_SRC_DIS_8P2_MS | J_TVDM_SRC_EN_1P6_MS | J_BC_EN,
> +	       sp_priv->uphy_regs[port] + CONFIG16);
> +	writel(IBG_TRIM0_SSLVHT | J_VDATREE_TRIM_DEFAULT, sp_priv->uphy_regs[port] + CONFIG17);
> +	writel(J_FORCE_DISC_ON | J_DEBUG_CTRL_ADDR_MACRO, sp_priv->uphy_regs[port] + CONFIG3);

What about all of these writes, are you sure they made it to the
hardware ok?  No need to read?

Same for elsewhere in the file.

thanks,

greg k-h
