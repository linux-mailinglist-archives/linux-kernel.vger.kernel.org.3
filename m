Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99C24C5A52
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiB0JvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiB0JvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:51:05 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B556404;
        Sun, 27 Feb 2022 01:50:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x18so8475815pfh.5;
        Sun, 27 Feb 2022 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYWFdIRnG9n8ffw9FnEGd9oXJ9XMcKLwu5zmRKNEbQs=;
        b=kGPE64mNT7tlABrDKsuUF5coqceJij04FNmbjowDPXUwfaAtvPfdmAZSMatj94w0h0
         ytr6coLIn0Llw56vldp3Gf2dueL3FuRbESAEpxzPOT14Jg7z78BbwpJXUGW8kue+FVa6
         YvlJM5zrgMsM7bJjNsfeA1P2pG05jIhYOQCBl9E1gg7o30limGDxc9wFsb4k1WXSIcm4
         BPdYlS9tNlukS6Q9zbpNbQhcfALCYzvtJcaayWEsPsU8DYZHYMwDkGiVzJWFay55x8oP
         1a7av4QfEuf6thZr2vVzbfNEizxgsHX4JLb0pO7dp3OkFi/VkQPUPPAiZ9jPK3NCWR1J
         J9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYWFdIRnG9n8ffw9FnEGd9oXJ9XMcKLwu5zmRKNEbQs=;
        b=iHYwwXoGOOjxngrIeMAUvtA7tKKMVFGl62RL/UHCcXZO+Wkh1PpXl2OYEa7eoQQQrX
         7uN1/Q7OHVgiPgSnETLm+ncK8MySn18kD7/Aoeb4aIwXOeD6KCN2LX3JpUVxBL1Kvj5D
         kYbk+ZGC/0Fojfrn99ZX+XxopZ9zqoX1yDj5oDcnBl269amD9jbHNO/L6KRGUFhxQp4g
         i/QaoPK/n7C4y4UKcFxmaT5SVWzCrBq5OToivJcLsjjuSebotpRKCwM0ZG9S95bHHOj5
         SuCJZFLK3Xbopdpt1Z0/C5w/6zMgvH3nEN3ZTEjbAwCiu7yYFYEZvr/dd0PkOAnqlrSF
         yejA==
X-Gm-Message-State: AOAM530Nra3m6HbNm7tDt0LHVCTxyfr6HH//n8kMxsPlZfCDYfNtmFA/
        h1NKlRNlLUoZEf34vxR1TUI=
X-Google-Smtp-Source: ABdhPJy8l8TcmKA08e1gg0uGqUtCFByzFY0AiuDkjZ6BhHzM1JRT/VFKJsSAUTgZ1erbxStMul79pw==
X-Received: by 2002:a63:ef03:0:b0:374:7286:14d0 with SMTP id u3-20020a63ef03000000b00374728614d0mr13289476pgh.552.1645955428405;
        Sun, 27 Feb 2022 01:50:28 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm7473334pga.38.2022.02.27.01.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Feb 2022 01:50:27 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 1/2] usb: host: ehci-sunplus: Add driver for ehci in Sunplus SP7021
Date:   Sun, 27 Feb 2022 17:50:40 +0800
Message-Id: <1645955441-6496-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
References: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for ehci in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
  - Address the comments by Rob Herring.
  - Clean up codes.

 MAINTAINERS                     |   6 +
 drivers/usb/host/Kconfig        |  11 +
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ehci-sunplus.c | 495 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 513 insertions(+)
 create mode 100644 drivers/usb/host/ehci-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1..6c2faf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17947,6 +17947,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS USB EHCI DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/host/ehci-sunplus.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c4736d1..9728d3b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -339,6 +339,17 @@ config USB_OCTEON_EHCI
 	  USB 2.0 device support.  All CN6XXX based chips with USB are
 	  supported.
 
+config USB_EHCI_SUNPLUS
+	tristate "EHCI support for Sunplus USB controller"
+	depends on SOC_SP7021
+	select NVMEM_SUNPLUS_OCOTP
+	help
+	  Enables support for the on-chip EHCI controller in Sunplus
+	  SoCs. It supports 32-bit AHB/AXI config bus and 64-bit AXI
+	  data bus.
+	  This driver can also be built as a module. If so, the module
+	  will be called ehci-sunplus.
+
 endif # USB_EHCI_HCD
 
 config USB_OXU210HP_HCD
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 171de4d..7e9b5f1 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
+obj-$(CONFIG_USB_EHCI_SUNPLUS)	+= ehci-sunplus.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
diff --git a/drivers/usb/host/ehci-sunplus.c b/drivers/usb/host/ehci-sunplus.c
new file mode 100644
index 0000000..54a5a16
--- /dev/null
+++ b/drivers/usb/host/ehci-sunplus.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The EHCI driver for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Inc., All rights reserved.
+ *
+ * Note 1 : non-posted write command for the registers accesses of
+ * Sunplus SP7021.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/usb.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define RF_MASK_V(mask, val)			(((mask) << 16) | (val))
+#define RF_MASK_V_CLR(mask)			(((mask) << 16) | 0)
+
+#define USB_PORT0_ID				0
+#define USB_PORT1_ID				1
+#define USB_PORT_NUM				2
+
+#define MASK_BITS				0xffff
+
+#define OTP_DISC_LEVEL_DEFAULT			0xd
+#define OTP_DISC_LEVEL_BITS			0x5
+
+// GROUP 140/150 UPHY0/UPHY1
+#define CONFIG1					0x4
+#define J_HS_TX_PWRSAV				BIT(5)
+#define CONFIG3					0xc
+#define J_FORCE_DISC_ON				BIT(5)
+#define J_DEBUG_CTRL_ADDR_MACRO			BIT(0)
+#define CONFIG7					0x1c
+#define J_DISC					0x1f
+#define CONFIG9					0x24
+#define J_ECO_PATH				BIT(6)
+#define CONFIG16				0x40
+#define J_TBCWAIT_MASK				GENMASK(6, 5)
+#define J_TBCWAIT_1P1_MS			FIELD_PREP(J_TBCWAIT_MASK, 0)
+#define J_TVDM_SRC_DIS_MASK			GENMASK(4, 3)
+#define J_TVDM_SRC_DIS_8P2_MS			FIELD_PREP(J_TVDM_SRC_DIS_MASK, 3)
+#define J_TVDM_SRC_EN_MASK			GENMASK(2, 1)
+#define J_TVDM_SRC_EN_1P6_MS			FIELD_PREP(J_TVDM_SRC_EN_MASK, 0)
+#define J_BC_EN					BIT(0)
+#define CONFIG17				0x44
+#define IBG_TRIM0_MASK				GENMASK(7, 5)
+#define IBG_TRIM0_SSLVHT			FIELD_PREP(IBG_TRIM0_MASK, 4)
+#define J_VDATREE_TRIM_MASK			GENMASK(4, 1)
+#define J_VDATREE_TRIM_DEFAULT			FIELD_PREP(J_VDATREE_TRIM_MASK, 9)
+#define CONFIG23				0x5c
+#define PROB_MASK				GENMASK(5, 3)
+#define PROB					FIELD_PREP(PROB_MASK, 7)
+
+// GROUP 4 MOON 4
+#define USBC_CONTROL				0x44
+#define MO1_USBC1_USB0_SEL			BIT(13)
+#define MO1_USBC1_USB0_CTRL			BIT(12)
+#define MO1_USBC0_USB0_SEL			BIT(5)
+#define MO1_USBC0_USB0_CTRL			BIT(4)
+#define UPHY0_CONTROL0				0x48
+#define UPHY0_CONTROL1				0x4c
+#define UPHY0_CONTROL2				0x50
+#define MO1_UPHY0_RX_CLK_SEL			BIT(6)
+#define UPHY0_CONTROL3				0x54
+#define MO1_UPHY0_PLL_POWER_OFF_SEL		BIT(7)
+#define MO1_UPHY0_PLL_POWER_OFF			BIT(3)
+#define UPHY1_CONTROL0				0x58
+#define UPHY1_CONTROL1				0x5c
+#define UPHY1_CONTROL2				0x60
+#define MO1_UPHY1_RX_CLK_SEL			BIT(6)
+#define UPHY1_CONTROL3				0x64
+#define MO1_UPHY1_PLL_POWER_OFF_SEL		BIT(7)
+#define MO1_UPHY1_PLL_POWER_OFF			BIT(3)
+
+#define hcd_to_sp_ehci_priv(h) \
+		((struct sp_ehci_priv *)hcd_to_ehci(h)->priv)
+
+struct sp_ehci_priv {
+	struct resource *uphy_res_mem;
+	struct resource *moon4_res_mem;
+	struct clk *phy_clk;
+	struct clk *ehci_clk;
+	struct reset_control *phy_rstc;
+	struct reset_control *ehci_rstc;
+	void __iomem *uphy_regs;
+	void __iomem *moon4_regs;
+	u32 port_num;
+};
+
+static int ehci_sunplus_reset(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev = to_platform_device(hcd->self.controller);
+	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval;
+
+	hcd->has_tt = pdata->has_tt;
+	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
+	ehci->big_endian_desc = pdata->big_endian_desc;
+	ehci->big_endian_mmio = pdata->big_endian_mmio;
+
+	ehci->caps = hcd->regs + pdata->caps_offset;
+	retval = ehci_setup(hcd);
+
+	return retval;
+}
+
+static struct hc_driver __read_mostly ehci_sunplus_driver;
+
+static const struct ehci_driver_overrides ehci_sunplus_overrides __initconst = {
+	.reset =		ehci_sunplus_reset,
+	.extra_priv_size =	sizeof(struct sp_ehci_priv),
+};
+
+static void pll_power(struct sp_ehci_priv *sp_priv, u32 par1, u32 par2, u32 par3)
+{
+	u32 pll_pwr_on, pll_pwr_off;
+
+	pll_pwr_off = (readl(sp_priv->moon4_regs + par1) & ~MASK_BITS) | par2 | par3;
+	pll_pwr_on = (readl(sp_priv->moon4_regs + par1) & ~MASK_BITS) | par2;
+
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + par1);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + par1);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), sp_priv->moon4_regs + par1);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), sp_priv->moon4_regs + par1);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, 0x0), sp_priv->moon4_regs + par1);
+}
+
+static int internal_modification(struct device *dev, struct sp_ehci_priv *sp_priv)
+{
+	struct nvmem_cell *cell;
+	char *disc_name = "disc_vol";
+	ssize_t otp_l = 0;
+	char *otp_v;
+	u32 set, val;
+
+	cell = nvmem_cell_get(dev, disc_name);
+	if (IS_ERR_OR_NULL(cell)) {
+		if (PTR_ERR(cell) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	otp_v = nvmem_cell_read(cell, &otp_l);
+	nvmem_cell_put(cell);
+
+	if (otp_v) {
+		if (sp_priv->port_num == USB_PORT0_ID)
+			set = *otp_v & J_DISC;
+		else if (sp_priv->port_num == USB_PORT1_ID)
+			set = ((*otp_v >> OTP_DISC_LEVEL_BITS) |
+				(*(otp_v + 1) << (sizeof(char) * 8 - OTP_DISC_LEVEL_BITS)))
+				& J_DISC;
+	}
+
+	if (!otp_v || set == 0)
+		set = OTP_DISC_LEVEL_DEFAULT;
+
+	val = readl(sp_priv->uphy_regs + CONFIG7);
+	val = (val & ~J_DISC) | set;
+	writel(val, sp_priv->uphy_regs + CONFIG7);
+
+	val = readl(sp_priv->uphy_regs + CONFIG9);
+	val &= ~(J_ECO_PATH);
+	writel(val, sp_priv->uphy_regs + CONFIG9);
+
+	val = readl(sp_priv->uphy_regs + CONFIG1);
+	val &= ~(J_HS_TX_PWRSAV);
+	writel(val, sp_priv->uphy_regs + CONFIG1);
+
+	val = readl(sp_priv->uphy_regs + CONFIG23);
+	val = (val & ~PROB) | PROB;
+	writel(val, sp_priv->uphy_regs + CONFIG23);
+
+	return 0;
+}
+
+static int uphy0_init(struct platform_device *pdev, struct sp_ehci_priv *sp_priv)
+{
+	u32 par1, par2, par3;
+	int retval;
+
+	/* Default value modification */
+	writel(RF_MASK_V(MASK_BITS, 0x4002), sp_priv->moon4_regs + UPHY0_CONTROL0);
+	writel(RF_MASK_V(MASK_BITS, 0x8747), sp_priv->moon4_regs + UPHY0_CONTROL1);
+
+	/* PLL power off/on twice */
+	par1 = UPHY0_CONTROL3;
+	par2 = MO1_UPHY0_PLL_POWER_OFF_SEL;
+	par3 = MO1_UPHY0_PLL_POWER_OFF;
+	pll_power(sp_priv, par1, par2, par3);
+
+	/* board uphy 0 internal register modification for tid certification */
+	retval = internal_modification(&pdev->dev, sp_priv);
+
+	/* port 0 uphy clk fix */
+	writel(RF_MASK_V(MO1_UPHY0_RX_CLK_SEL, MO1_UPHY0_RX_CLK_SEL),
+	       sp_priv->moon4_regs + UPHY0_CONTROL2);
+
+	/* switch to host */
+	writel(RF_MASK_V(MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL,
+			 MO1_USBC0_USB0_SEL | MO1_USBC0_USB0_CTRL),
+	       sp_priv->moon4_regs + USBC_CONTROL);
+
+	return retval;
+}
+
+static int uphy1_init(struct platform_device *pdev, struct sp_ehci_priv *sp_priv)
+{
+	u32 par1, par2, par3;
+	int retval;
+
+	/* Default value modification */
+	writel(RF_MASK_V(MASK_BITS, 0x4002), sp_priv->moon4_regs + UPHY1_CONTROL0);
+	writel(RF_MASK_V(MASK_BITS, 0x8747), sp_priv->moon4_regs + UPHY1_CONTROL1);
+
+	/* PLL power off/on twice */
+	par1 = UPHY1_CONTROL3;
+	par2 = MO1_UPHY1_PLL_POWER_OFF_SEL;
+	par3 = MO1_UPHY1_PLL_POWER_OFF;
+	pll_power(sp_priv, par1, par2, par3);
+
+	/* board uphy 1 internal register modification for tid certification */
+	retval = internal_modification(&pdev->dev, sp_priv);
+
+	/* port 1 uphy clk fix */
+	writel(RF_MASK_V(MO1_UPHY1_RX_CLK_SEL, MO1_UPHY1_RX_CLK_SEL),
+	       sp_priv->moon4_regs + UPHY1_CONTROL2);
+
+	/* switch to host */
+	writel(RF_MASK_V(MO1_USBC1_USB0_SEL | MO1_USBC1_USB0_CTRL,
+			 MO1_USBC1_USB0_SEL | MO1_USBC1_USB0_CTRL),
+	       sp_priv->moon4_regs + USBC_CONTROL);
+
+	return retval;
+}
+
+static struct usb_ehci_pdata usb_ehci_pdata = {
+};
+
+static int ehci_sunplus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_ehci_priv *sp_priv;
+	struct resource *res_mem;
+	struct usb_hcd *hcd;
+	int irq, ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	pdev->dev.platform_data = &usb_ehci_pdata;
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ehci_sunplus_driver, dev, dev_name(dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hcd);
+	sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	/* initialize uphy0/uphy1 */
+	sp_priv->uphy_res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uphy");
+	sp_priv->uphy_regs = devm_ioremap_resource(dev, sp_priv->uphy_res_mem);
+
+	if (IS_ERR(sp_priv->uphy_regs))
+		return PTR_ERR(sp_priv->uphy_regs);
+
+	sp_priv->moon4_res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon4");
+	sp_priv->moon4_regs = devm_ioremap(dev, sp_priv->moon4_res_mem->start,
+					   resource_size(sp_priv->moon4_res_mem));
+	if (IS_ERR(sp_priv->moon4_regs))
+		return PTR_ERR(sp_priv->moon4_regs);
+
+	sp_priv->phy_clk = devm_clk_get(dev, "uphy_clk");
+
+	if (IS_ERR(sp_priv->phy_clk)) {
+		ret = PTR_ERR(sp_priv->phy_clk);
+		goto err_put_hcd;
+	}
+
+	sp_priv->phy_rstc = devm_reset_control_get_exclusive(dev, "uphy_rst");
+	if (IS_ERR(sp_priv->phy_rstc)) {
+		ret = PTR_ERR(sp_priv->phy_rstc);
+		goto err_put_hcd;
+	}
+
+	ret = clk_prepare_enable(sp_priv->phy_clk);
+	if (ret)
+		goto err_put_hcd;
+
+	ret = reset_control_deassert(sp_priv->phy_rstc);
+	if (ret)
+		goto err_phy_reset;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "port-num", &sp_priv->port_num);
+	if (ret == 0) {
+		if (sp_priv->port_num == USB_PORT0_ID)
+			ret = uphy0_init(pdev, sp_priv);
+		else if (sp_priv->port_num == USB_PORT1_ID)
+			ret = uphy1_init(pdev, sp_priv);
+	}
+
+	if (ret < 0)
+		goto err_phy_clk;
+
+	/* battery charger */
+	writel(J_TBCWAIT_1P1_MS | J_TVDM_SRC_DIS_8P2_MS | J_TVDM_SRC_EN_1P6_MS | J_BC_EN,
+	       sp_priv->uphy_regs + CONFIG16);
+	writel(IBG_TRIM0_SSLVHT | J_VDATREE_TRIM_DEFAULT, sp_priv->uphy_regs + CONFIG17);
+
+	/* chirp mode */
+	writel(J_FORCE_DISC_ON | J_DEBUG_CTRL_ADDR_MACRO, sp_priv->uphy_regs + CONFIG3);
+
+	/* ehci */
+	res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "usbc");
+	hcd->regs = devm_ioremap_resource(dev, res_mem);
+	if (IS_ERR(hcd->regs)) {
+		ret = PTR_ERR(hcd->regs);
+		goto err_phy_clk;
+	}
+
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto err_phy_clk;
+	}
+	dev_dbg(&pdev->dev, "ehci_id:%d,irq:%d\n", pdev->id, irq);
+
+	sp_priv->ehci_clk = devm_clk_get(dev, "usbc_clk");
+
+	if (IS_ERR(sp_priv->ehci_clk)) {
+		ret = PTR_ERR(sp_priv->ehci_clk);
+		goto err_phy_clk;
+	}
+
+	sp_priv->ehci_rstc = devm_reset_control_get_exclusive(dev, "usbc_rst");
+	if (IS_ERR(sp_priv->ehci_rstc)) {
+		ret = PTR_ERR(sp_priv->ehci_rstc);
+		goto err_put_hcd;
+	}
+
+	ret = clk_prepare_enable(sp_priv->ehci_clk);
+	if (ret)
+		goto err_phy_reset;
+
+	ret = reset_control_deassert(sp_priv->ehci_rstc);
+	if (ret)
+		goto err_ehci_reset;
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto err_ehci_clk;
+
+	dev_dbg(dev, "hcd_irq:%d,%d\n", hcd->irq, irq);
+
+	return ret;
+
+err_ehci_reset:
+	reset_control_assert(sp_priv->ehci_rstc);
+err_ehci_clk:
+	clk_disable_unprepare(sp_priv->ehci_clk);
+err_phy_reset:
+	reset_control_assert(sp_priv->phy_rstc);
+err_phy_clk:
+	clk_disable_unprepare(sp_priv->phy_clk);
+err_put_hcd:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int ehci_sunplus_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+	u32 val;
+
+	usb_remove_hcd(hcd);
+
+	/* disable battery charger CDP */
+	val = readl(sp_priv->uphy_regs + CONFIG16);
+	val &= ~J_BC_EN;
+	writel(val, sp_priv->uphy_regs + CONFIG16);
+
+	usb_put_hcd(hcd);
+
+	reset_control_assert(sp_priv->ehci_rstc);
+	clk_disable_unprepare(sp_priv->ehci_clk);
+	reset_control_assert(sp_priv->phy_rstc);
+	clk_disable_unprepare(sp_priv->phy_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ehci_sunplus_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+	int rc;
+
+	rc = ehci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
+
+	reset_control_assert(sp_priv->ehci_rstc);
+	clk_disable_unprepare(sp_priv->ehci_clk);
+	reset_control_assert(sp_priv->phy_rstc);
+	clk_disable_unprepare(sp_priv->phy_clk);
+
+	return 0;
+}
+
+static int ehci_sunplus_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	clk_prepare_enable(sp_priv->phy_clk);
+	reset_control_deassert(sp_priv->phy_rstc);
+	clk_prepare_enable(sp_priv->ehci_clk);
+	reset_control_deassert(sp_priv->ehci_rstc);
+
+	ehci_resume(hcd, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ehci_sunplus_pm_ops = {
+	.suspend = ehci_sunplus_drv_suspend,
+	.resume = ehci_sunplus_drv_resume,
+};
+#endif
+
+static const struct of_device_id ehci_sunplus_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-usb-ehci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ehci_sunplus_dt_ids);
+
+static struct platform_driver ehci_hcd_sunplus_driver = {
+	.probe			= ehci_sunplus_probe,
+	.remove			= ehci_sunplus_remove,
+	.shutdown		= usb_hcd_platform_shutdown,
+	.driver = {
+		.name		= "ehci-sunplus",
+		.of_match_table = ehci_sunplus_dt_ids,
+#ifdef CONFIG_PM
+		.pm = &ehci_sunplus_pm_ops,
+#endif
+	}
+};
+
+static int __init ehci_sunplus_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	ehci_init_driver(&ehci_sunplus_driver, &ehci_sunplus_overrides);
+	return platform_driver_register(&ehci_hcd_sunplus_driver);
+}
+module_init(ehci_sunplus_init);
+
+static void __exit ehci_sunplus_cleanup(void)
+{
+	platform_driver_unregister(&ehci_hcd_sunplus_driver);
+}
+module_exit(ehci_sunplus_cleanup);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus USB EHCI driver");
+MODULE_LICENSE("GPL");
+
-- 
2.7.4

