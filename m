Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA884CD37B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiCDLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbiCDLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:30:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97251662F3;
        Fri,  4 Mar 2022 03:30:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cx5so7129081pjb.1;
        Fri, 04 Mar 2022 03:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBQDCuX8MYJfVY0SBX9728DIPQM2b9XymHXTOQ3iyNc=;
        b=Nv8weaNYcQrZm7gcjwXpmnSavf0yZ+Rxv0HJpF0NzloQ2MbNpF/84jB5cJ1nmjgOXb
         xQIYO6WYuyqZF8kbZ8dthFXWa4KXXAIchOJiE/UZnSInBYFS3v3e00mg1rcFU+2PrOhy
         3xzr4nI/XkZAwUm5ELhqk/WAmMrrwVwVaRWt5DELC9KsB2ZMr75vv+kYqahDU/0NWqvl
         KF26YoYiAa9w6TUAhY68fr9KbtU1gNcfDamEObI25wp91FeX866bTUjFo0e64UUhtSxt
         dOZ7C7e7Co0r8fE/p7i2RckdzI8+5ecdYF6FjV4hsxpBVJlPyYwg8Y98bYGpgYYtCjFS
         QgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gBQDCuX8MYJfVY0SBX9728DIPQM2b9XymHXTOQ3iyNc=;
        b=osLyNYxgxs6z7LvYpDlmXudZJytuj0EdV3J2KSihsrM0Vua2R5eAMGdnhtYt45g7BD
         3vG0ObTsRIJ82vwQYiFyK7q6+Ku2h1CRqxbUim+xjB6gXegZEmH/oIK+xqLz4NWTuuJa
         T45f127DzjonqmaW+ToU3saYLF9nVThvk6I2wetVx6z8IiVVPf/tSTDOuMhz4WnHPjeU
         er+ulEW1m+h8wbV/R14EMaY8Srve/u5JFsxWMQ7fmy15bXKnTP1tuawUFMfDNzg38NnG
         ZovU4jm7g2cSRNjaV2l/DZRd6jlk5dwsnlEDnvq4kYu5Y8XXeENFom45Gr1QX3jFq99R
         HfWw==
X-Gm-Message-State: AOAM531Sy3VIA3uDZ5eznrSWpyYbon2f8EHzd05Tr6T2OSwBs93S2P03
        YCVKbXntDosrBsRQwIXjYRrMx1lgrYcL/w==
X-Google-Smtp-Source: ABdhPJyD2cikGBrlLBLFhk/PbB/cDPSx2sJl4pLD2LzQw+VnGZfqpMEfF1BOOjpV570ZJX3CCElpdw==
X-Received: by 2002:a17:902:e883:b0:14f:fa85:2af2 with SMTP id w3-20020a170902e88300b0014ffa852af2mr40529829plg.40.1646393405161;
        Fri, 04 Mar 2022 03:30:05 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm5718237pfc.99.2022.03.04.03.30.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 03:30:04 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 1/2] phy: usb: Add USB2.0 phy driver for Sunplus SP7021
Date:   Fri,  4 Mar 2022 19:30:17 +0800
Message-Id: <1646393418-26421-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
References: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB2.0 phy driver for Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 MAINTAINERS                            |   8 ++
 drivers/phy/Kconfig                    |   1 +
 drivers/phy/Makefile                   |   1 +
 drivers/phy/sunplus/Kconfig            |  12 ++
 drivers/phy/sunplus/Makefile           |   2 +
 drivers/phy/sunplus/phy-sunplus-usb2.c | 248 +++++++++++++++++++++++++++++++++
 6 files changed, 272 insertions(+)
 create mode 100644 drivers/phy/sunplus/Kconfig
 create mode 100644 drivers/phy/sunplus/Makefile
 create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1..a3bb35e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17947,6 +17947,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS USB2 PHY DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/phy/sunplus/Kconfig
+F:	drivers/phy/sunplus/Makefile
+F:	drivers/phy/sunplus/phy-sunplus-usb2.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 82b63e6..d97e22e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -90,6 +90,7 @@ source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/st/Kconfig"
+source "drivers/phy/sunplus/Kconfig"
 source "drivers/phy/tegra/Kconfig"
 source "drivers/phy/ti/Kconfig"
 source "drivers/phy/intel/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 01e9eff..ed88b6f 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   samsung/	\
 					   socionext/	\
 					   st/		\
+					   sunplus/		\
 					   tegra/	\
 					   ti/		\
 					   xilinx/
diff --git a/drivers/phy/sunplus/Kconfig b/drivers/phy/sunplus/Kconfig
new file mode 100644
index 0000000..beb85f4
--- /dev/null
+++ b/drivers/phy/sunplus/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PHY_SUNPLUS_USB
+	tristate "Sunplus USB2 PHY driver"
+	depends on OF && (SOC_SP7021 || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB 2.0 PHY on Sunplus SP7021
+	  SoC. The USB 2.0 PHY controller supports battery charger
+	  and synchronous signals, various power down modes including
+	  operating, partial and suspend modes, and high-speed,
+	  full-speed and low-speed data transfer.
diff --git a/drivers/phy/sunplus/Makefile b/drivers/phy/sunplus/Makefile
new file mode 100644
index 0000000..71754d5
--- /dev/null
+++ b/drivers/phy/sunplus/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_PHY_SUNPLUS_USB)	+= phy-sunplus-usb2.o
diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
new file mode 100644
index 0000000..a2c17ca
--- /dev/null
+++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Sunplus SP7021 USB 2.0 phy driver
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
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define RF_MASK_V(_mask, _val)			(((_mask) << 16) | (_val))
+#define RF_MASK_V_CLR(_mask)			(((_mask) << 16) | 0)
+
+#define MASK_BITS				0xffff
+#define OTP_DISC_LEVEL_DEFAULT			0xd
+
+// GROUP UPHY
+#define CONFIG1					0x4
+#define J_HS_TX_PWRSAV				BIT(5)
+#define CONFIG3					0xc
+#define J_FORCE_DISC_ON				BIT(5)
+#define J_DEBUG_CTRL_ADDR_MACRO			BIT(0)
+#define CONFIG7					0x1c
+#define J_DISC					0X1f
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
+// GROUP MOON4
+#define UPHY_CONTROL0				0x0
+#define UPHY_CONTROL1				0x4
+#define UPHY_CONTROL2				0x8
+#define MO1_UPHY_RX_CLK_SEL			BIT(6)
+#define UPHY_CONTROL3				0xc
+#define MO1_UPHY_PLL_POWER_OFF_SEL		BIT(7)
+#define MO1_UPHY_PLL_POWER_OFF			BIT(3)
+
+struct sp_usbphy {
+	struct device *dev;
+	struct resource *phy_res_mem;
+	struct resource *moon4_res_mem;
+	struct reset_control *rstc;
+	struct clk *phy_clk;
+	void __iomem *phy_regs;
+	void __iomem *moon4_regs;
+	u32 disc_vol_addr_off;
+};
+
+static int sp_uphy_init(struct phy *phy)
+{
+	struct sp_usbphy *usbphy = phy_get_drvdata(phy);
+	struct nvmem_cell *cell;
+	char *disc_name = "disc_vol";
+	ssize_t otp_l = 0;
+	char *otp_v;
+	u32 val, set, pll_pwr_on, pll_pwr_off;
+
+	/* Default value modification */
+	writel(RF_MASK_V(MASK_BITS, 0x4002), usbphy->moon4_regs + UPHY_CONTROL0);
+	writel(RF_MASK_V(MASK_BITS, 0x8747), usbphy->moon4_regs + UPHY_CONTROL1);
+
+	/* PLL power off/on twice */
+	pll_pwr_off = (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MASK_BITS)
+			| MO1_UPHY_PLL_POWER_OFF_SEL | MO1_UPHY_PLL_POWER_OFF;
+	pll_pwr_on = (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MASK_BITS)
+			| MO1_UPHY_PLL_POWER_OFF_SEL;
+
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UPHY_CONTROL3);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPHY_CONTROL3);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UPHY_CONTROL3);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPHY_CONTROL3);
+	mdelay(1);
+	writel(RF_MASK_V(MASK_BITS, 0x0), usbphy->moon4_regs + UPHY_CONTROL3);
+
+	/* board uphy 0 internal register modification for tid certification */
+	cell = nvmem_cell_get(usbphy->dev, disc_name);
+	if (IS_ERR_OR_NULL(cell)) {
+		if (PTR_ERR(cell) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	otp_v = nvmem_cell_read(cell, &otp_l);
+	nvmem_cell_put(cell);
+
+	if (otp_v) {
+		set = *(otp_v + 1);
+		set = (set << (sizeof(char) * 8)) | *otp_v;
+		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
+	}
+
+	if (!otp_v || set == 0)
+		set = OTP_DISC_LEVEL_DEFAULT;
+
+	val = readl(usbphy->phy_regs + CONFIG7);
+	val = (val & ~J_DISC) | set;
+	writel(val, usbphy->phy_regs + CONFIG7);
+
+	val = readl(usbphy->phy_regs + CONFIG9);
+	val &= ~(J_ECO_PATH);
+	writel(val, usbphy->phy_regs + CONFIG9);
+
+	val = readl(usbphy->phy_regs + CONFIG1);
+	val &= ~(J_HS_TX_PWRSAV);
+	writel(val, usbphy->phy_regs + CONFIG1);
+
+	val = readl(usbphy->phy_regs + CONFIG23);
+	val = (val & ~PROB) | PROB;
+	writel(val, usbphy->phy_regs + CONFIG23);
+
+	/* port 0 uphy clk fix */
+	writel(RF_MASK_V(MO1_UPHY_RX_CLK_SEL, MO1_UPHY_RX_CLK_SEL),
+	       usbphy->moon4_regs + UPHY_CONTROL2);
+
+	/* battery charger */
+	writel(J_TBCWAIT_1P1_MS | J_TVDM_SRC_DIS_8P2_MS | J_TVDM_SRC_EN_1P6_MS | J_BC_EN,
+	       usbphy->phy_regs + CONFIG16);
+	writel(IBG_TRIM0_SSLVHT | J_VDATREE_TRIM_DEFAULT, usbphy->phy_regs + CONFIG17);
+
+	/* chirp mode */
+	writel(J_FORCE_DISC_ON | J_DEBUG_CTRL_ADDR_MACRO, usbphy->phy_regs + CONFIG3);
+
+	return 0;
+}
+
+static const struct phy_ops sp_uphy_ops = {
+	.init		= sp_uphy_init,
+};
+
+static const struct of_device_id sp_uphy_dt_ids[] = {
+	{.compatible = "sunplus,sp7021-usb2-phy",
+	 .data = &sp_uphy_ops,},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sp_uphy_dt_ids);
+
+static int sp_usb_phy_probe(struct platform_device *pdev)
+{
+	struct sp_usbphy *usbphy;
+	const struct phy_ops *phy_ops;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+	int ret;
+
+	usbphy = devm_kzalloc(&pdev->dev, sizeof(*usbphy), GFP_KERNEL);
+	if (!usbphy)
+		return -ENOMEM;
+
+	usbphy->dev = &pdev->dev;
+
+	usbphy->phy_res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
+	usbphy->phy_regs = devm_ioremap_resource(&pdev->dev, usbphy->phy_res_mem);
+	if (IS_ERR(usbphy->phy_regs))
+		return PTR_ERR(usbphy->phy_regs);
+
+	usbphy->moon4_res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon4");
+	usbphy->moon4_regs = devm_ioremap(&pdev->dev, usbphy->moon4_res_mem->start,
+					  resource_size(usbphy->moon4_res_mem));
+	if (IS_ERR(usbphy->moon4_regs))
+		return PTR_ERR(usbphy->moon4_regs);
+
+	usbphy->phy_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(usbphy->phy_clk))
+		return PTR_ERR(usbphy->phy_clk);
+
+	usbphy->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(usbphy->rstc))
+		return PTR_ERR(usbphy->rstc);
+
+	ret = clk_prepare_enable(usbphy->phy_clk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_control_deassert(usbphy->rstc);
+	if (ret)
+		goto err_reset;
+
+	of_property_read_u32(pdev->dev.of_node, "sunplus,disc-vol-addr-off",
+			     &usbphy->disc_vol_addr_off);
+
+	phy_ops = of_device_get_match_data(&pdev->dev);
+	if (!phy_ops) {
+		ret = -EINVAL;
+		goto err_reset;
+	}
+
+	phy = devm_phy_create(&pdev->dev, NULL, phy_ops);
+	if (IS_ERR(phy)) {
+		ret = -PTR_ERR(phy);
+		goto err_reset;
+	}
+
+	phy_set_drvdata(phy, usbphy);
+	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+err_reset:
+	reset_control_assert(usbphy->rstc);
+err_clk:
+	clk_disable_unprepare(usbphy->phy_clk);
+
+	return ret;
+}
+
+static struct platform_driver sunplus_usb_phy_driver = {
+	.probe		= sp_usb_phy_probe,
+	.driver		= {
+		.name	= "sunplus-usb2-phy",
+		.of_match_table = sp_uphy_dt_ids,
+	},
+};
+module_platform_driver(sunplus_usb_phy_driver);
+
+MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus USB 2.0 phy driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.7.4

