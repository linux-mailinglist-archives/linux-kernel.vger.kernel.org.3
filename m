Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7455A19B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbiHYTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbiHYTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:39:05 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA66BFA9C;
        Thu, 25 Aug 2022 12:39:01 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 1EFFB60436;
        Thu, 25 Aug 2022 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1661456339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOfzSG5Rsc36wOEXL11ogzW0HdZVFzdej9JJriXcjH8=;
        b=r2X7OQei5BVbk+nqPpOUpMJXPB+Bg2qfFzoGPdGYmwz0ZNxfxSReTb07uXWTX4c+iMesLl
        bKnwG9Y6+Blyg8NaHZ1MgwzckzuV4DVtO5o/WBduiEbJ+b07PZ00n62NPl0HU9hD6+3IIy
        iBoKw1N36BMbSL5kp160MTxi+6oN60M=
Received: from frank-G5.. (fttx-pool-80.245.75.185.bambit.de [80.245.75.185])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 1ED2440353;
        Thu, 25 Aug 2022 19:38:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] phy: rockchip: Support PCIe v3
Date:   Thu, 25 Aug 2022 21:38:34 +0200
Message-Id: <20220825193836.54262-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825193836.54262-1-linux@fw-web.de>
References: <20220825193836.54262-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f8180e51-dccf-452b-97b2-d58dc6711785
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
It use a dedicated PCIe-phy. Add support for this.

Initial support by Shawn Lin, modifications by Peter Geis and Frank
Wunderlich.

Add data-lanes property for splitting pcie-lanes across controllers.

The data-lanes is an array where x=0 means lane is disabled and  x > 0
means controller x is assigned to phy lane.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Suggested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v5:
- change pr_* to dev_*, update copyright-years
- add naming of magic constants

v4:
- change u8 lane-map to u32 data-lanes

v3:
- change dt-binding include
- change reset to devm_reset_control_get_optional_exclusive
  exit on error and lower severity of message if unset
- fix from peter: disable reg-write for phy-mode in rockchip_p3phy_probe
- move bifurcation/lane-map support from PCIe to phy driver

v2:
- move dt-bindings header into separate patch
- use BIT-macro
- make constants better readable
- use dev_err instead of pr_*
- change dt-binding include due to renaming (phy-snps-pcie3.h => phy-rockchip-pcie3.h)
- use exclusive variant of devm_reset_control_get{,_exclusive}
- fix semicolon.cocci warnings reported by kernel test robot <lkp@intel.com>

---
driver was taken from linux 5.10 based on in
https://github.com/JeffyCN/mirrors
which now has disappeared

Update phy-rockchip-snps-pcie3.c

Fix messages for data-lanes

Update phy-rockchip-snps-pcie3.c

Fix comment for data-lanes
---
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 319 ++++++++++++++++++
 include/linux/phy/pcie.h                      |  12 +
 4 files changed, 341 insertions(+)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 include/linux/phy/pcie.h

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 9022e395c056..94360fc96a6f 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -83,6 +83,15 @@ config PHY_ROCKCHIP_PCIE
 	help
 	  Enable this to support the Rockchip PCIe PHY.
 
+config PHY_ROCKCHIP_SNPS_PCIE3
+	tristate "Rockchip Snps PCIe3 PHY Driver"
+	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the Rockchip snps PCIe3 PHY.
+
 config PHY_ROCKCHIP_TYPEC
 	tristate "Rockchip TYPEC PHY Driver"
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index a5041efb5b8f..7eab129230d1 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
+obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
 obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
new file mode 100644
index 000000000000..1917edda6b47
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip PCIE3.0 phy driver
+ *
+ * Copyright (C) 2022 Rockchip Electronics Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/pcie.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+/* Register for RK3568 */
+#define GRF_PCIE30PHY_CON1			0x4
+#define GRF_PCIE30PHY_CON6			0x18
+#define GRF_PCIE30PHY_CON9			0x24
+#define GRF_PCIE30PHY_DA_OCM			(BIT(15) | BIT(31))
+#define GRF_PCIE30PHY_STATUS0			0x80
+#define GRF_PCIE30PHY_WR_EN			(0xf << 16)
+#define SRAM_INIT_DONE(reg)			(reg & BIT(14))
+
+#define RK3568_BIFURCATION_LANE_0_1		BIT(0)
+
+/* Register for RK3588 */
+#define PHP_GRF_PCIESEL_CON			0x100
+#define RK3588_PCIE3PHY_GRF_CMN_CON0		0x0
+#define RK3588_PCIE3PHY_GRF_PHY0_STATUS1	0x904
+#define RK3588_PCIE3PHY_GRF_PHY1_STATUS1	0xa04
+#define RK3588_SRAM_INIT_DONE(reg)		(reg & BIT(0))
+
+#define RK3588_BIFURCATION_LANE_0_1		BIT(0)
+#define RK3588_BIFURCATION_LANE_2_3		BIT(1)
+#define RK3588_LANE_AGGREGATION		BIT(2)
+
+struct rockchip_p3phy_ops;
+
+struct rockchip_p3phy_priv {
+	const struct rockchip_p3phy_ops *ops;
+	void __iomem *mmio;
+	/* mode: RC, EP */
+	int mode;
+	/* pcie30_phymode: Aggregation, Bifurcation */
+	int pcie30_phymode;
+	struct regmap *phy_grf;
+	struct regmap *pipe_grf;
+	struct reset_control *p30phy;
+	struct phy *phy;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	int num_lanes;
+	u32 lanes[4];
+};
+
+struct rockchip_p3phy_ops {
+	int (*phy_init)(struct rockchip_p3phy_priv *priv);
+};
+
+static int rockchip_p3phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+
+	/* Actually We don't care EP/RC mode, but just record it */
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		priv->mode = PHY_MODE_PCIE_RC;
+		break;
+	case PHY_MODE_PCIE_EP:
+		priv->mode = PHY_MODE_PCIE_EP;
+		break;
+	default:
+		dev_err(&phy->dev, "%s, invalid mode\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rockchip_p3phy_rk3568_init(struct rockchip_p3phy_priv *priv)
+{
+	struct phy *phy = priv->phy;
+	bool bifurcation = false;
+	int ret;
+	u32 reg;
+
+	/* Deassert PCIe PMA output clamp mode */
+	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9, GRF_PCIE30PHY_DA_OCM);
+
+	for (int i = 0; i < priv->num_lanes; i++) {
+		dev_info(&phy->dev, "lane number %d, val %d\n", i, priv->lanes[i]);
+		if (priv->lanes[i] > 1)
+			bifurcation = true;
+	}
+
+	/* Set bifurcation if needed, and it doesn't care RC/EP */
+	if (bifurcation) {
+		dev_info(&phy->dev, "bifurcation enabled\n");
+		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
+			     GRF_PCIE30PHY_WR_EN | RK3568_BIFURCATION_LANE_0_1);
+		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON1,
+			     GRF_PCIE30PHY_DA_OCM);
+	} else {
+		dev_dbg(&phy->dev, "bifurcation disabled\n");
+		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
+			     GRF_PCIE30PHY_WR_EN & ~RK3568_BIFURCATION_LANE_0_1);
+	}
+
+	reset_control_deassert(priv->p30phy);
+
+	ret = regmap_read_poll_timeout(priv->phy_grf,
+				       GRF_PCIE30PHY_STATUS0,
+				       reg, SRAM_INIT_DONE(reg),
+				       0, 500);
+	if (ret)
+		dev_err(&priv->phy->dev, "%s: lock failed 0x%x, check input refclk and power supply\n",
+		       __func__, reg);
+	return ret;
+}
+
+static const struct rockchip_p3phy_ops rk3568_ops = {
+	.phy_init = rockchip_p3phy_rk3568_init,
+};
+
+static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
+{
+	u32 reg = 0;
+	u8 mode = 0;
+	int ret;
+
+	/* Deassert PCIe PMA output clamp mode */
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, BIT(8) | BIT(24));
+
+	/* Set bifurcation if needed */
+	for (int i = 0; i < priv->num_lanes; i++) {
+		if (!priv->lanes[i])
+			mode |= (BIT(i) << 3);
+
+		if (priv->lanes[i] > 1)
+			mode |= (BIT(i) >> 1);
+	}
+
+	if (!mode)
+		reg = RK3588_LANE_AGGREGATION;
+	else {
+		if (mode & (BIT(0) | BIT(1)))
+			reg |= RK3588_BIFURCATION_LANE_0_1;
+
+		if (mode & (BIT(2) | BIT(3)))
+			reg |= RK3588_BIFURCATION_LANE_2_3;
+	}
+
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, (0x7<<16) | reg);
+
+	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
+	if (!IS_ERR(priv->pipe_grf)) {
+		reg = (mode & (BIT(6) | BIT(7))) >> 6;
+		if (reg)
+			regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
+				     (reg << 16) | reg);
+	}
+
+	reset_control_deassert(priv->p30phy);
+
+	ret = regmap_read_poll_timeout(priv->phy_grf,
+				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
+				       reg, RK3588_SRAM_INIT_DONE(reg),
+				       0, 500);
+	ret |= regmap_read_poll_timeout(priv->phy_grf,
+					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
+					reg, RK3588_SRAM_INIT_DONE(reg),
+					0, 500);
+	if (ret)
+		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
+			reg);
+	return ret;
+}
+
+static const struct rockchip_p3phy_ops rk3588_ops = {
+	.phy_init = rockchip_p3phy_rk3588_init,
+};
+
+static int rochchip_p3phy_init(struct phy *phy)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret) {
+		dev_err(&priv->phy->dev, "failed to enable PCIe bulk clks %d\n", ret);
+		return ret;
+	}
+
+	reset_control_assert(priv->p30phy);
+	udelay(1);
+
+	if (priv->ops->phy_init) {
+		ret = priv->ops->phy_init(priv);
+		if (ret)
+			clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	}
+
+	return ret;
+}
+
+static int rochchip_p3phy_exit(struct phy *phy)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	reset_control_assert(priv->p30phy);
+	return 0;
+}
+
+static const struct phy_ops rochchip_p3phy_ops = {
+	.init = rochchip_p3phy_init,
+	.exit = rochchip_p3phy_exit,
+	.set_mode = rockchip_p3phy_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static int rockchip_p3phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct rockchip_p3phy_priv *priv;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->mmio)) {
+		ret = PTR_ERR(priv->mmio);
+		return ret;
+	}
+
+	priv->ops = of_device_get_match_data(&pdev->dev);
+	if (!priv->ops) {
+		dev_err(dev, "no of match data provided\n");
+		return -EINVAL;
+	}
+
+	priv->phy_grf = syscon_regmap_lookup_by_phandle(np, "rockchip,phy-grf");
+	if (IS_ERR(priv->phy_grf)) {
+		dev_err(dev, "failed to find rockchip,phy_grf regmap\n");
+		return PTR_ERR(priv->phy_grf);
+	}
+
+	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
+							 "rockchip,pipe-grf");
+	if (IS_ERR(priv->pipe_grf))
+		dev_info(dev, "failed to find rockchip,pipe_grf regmap\n");
+
+	priv->num_lanes = of_property_read_variable_u32_array(dev->of_node, "data-lanes",
+							     priv->lanes, 2,
+							     ARRAY_SIZE(priv->lanes));
+
+	/* if no data-lanes assume aggregation */
+	if (priv->num_lanes == -EINVAL) {
+		dev_dbg(dev, "no data-lanes property found\n");
+		priv->num_lanes = 1;
+		priv->lanes[0] = 1;
+	} else if (priv->num_lanes < 0) {
+		dev_err(dev, "failed to read data-lanes property %d\n", priv->num_lanes);
+		return priv->num_lanes;
+	}
+
+	priv->phy = devm_phy_create(dev, NULL, &rochchip_p3phy_ops);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create combphy\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	priv->p30phy = devm_reset_control_get_optional_exclusive(dev, "phy");
+	if (IS_ERR(priv->p30phy)) {
+		return dev_err_probe(dev, PTR_ERR(priv->p30phy),
+				     "failed to get phy reset control\n");
+	}
+	if (!priv->p30phy)
+		dev_info(dev, "no phy reset control specified\n");
+
+	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
+	if (priv->num_clks < 1)
+		return -ENODEV;
+
+	dev_set_drvdata(dev, priv);
+	phy_set_drvdata(priv->phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id rockchip_p3phy_of_match[] = {
+	{ .compatible = "rockchip,rk3568-pcie3-phy", .data = &rk3568_ops },
+	{ .compatible = "rockchip,rk3588-pcie3-phy", .data = &rk3588_ops },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rockchip_p3phy_of_match);
+
+static struct platform_driver rockchip_p3phy_driver = {
+	.probe	= rockchip_p3phy_probe,
+	.driver = {
+		.name = "rockchip-snps-pcie3-phy",
+		.of_match_table = rockchip_p3phy_of_match,
+	},
+};
+module_platform_driver(rockchip_p3phy_driver);
+MODULE_DESCRIPTION("Rockchip Synopsys PCIe 3.0 PHY driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/phy/pcie.h b/include/linux/phy/pcie.h
new file mode 100644
index 000000000000..e7ac81764576
--- /dev/null
+++ b/include/linux/phy/pcie.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ */
+#ifndef __PHY_PCIE_H
+#define __PHY_PCIE_H
+
+#define PHY_MODE_PCIE_RC 20
+#define PHY_MODE_PCIE_EP 21
+#define PHY_MODE_PCIE_BIFURCATION 22
+
+#endif
-- 
2.34.1

