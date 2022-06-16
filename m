Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7555754E225
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377161AbiFPNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377130AbiFPNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:38:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC252AE06
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s1so1920622wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/SPXYyJ9pOv+57/VRPyN+3QaTNRZ+8Q87oNWa1ed6U=;
        b=sZnvhiQPTbFhgH01BZXK9frx5kA9oJjPA7EMRswq3DvCa7aU2L5g/j16bM8oXtkyta
         +6FFNp85niS7md8GlEVv6dVl98KHd4ItmqnZyV5UZ21UaR5BSI2QdXVgdK4P7F9/05c0
         tz9W+4UPJzYD9RjCidvYnXljAXw39h2u+Vj86JfR+Vj/Jects2tXu53R5vpYJe1s4lkJ
         9/gCtdFoTGn1fpcZyy2sFS4ezcNNDRTrdnb3u8Scp7rv27YI5dnx1psDIityA7Qkd/VM
         L0ApCvLQWYvfmo5Xnk66wXKtIiFm1NUtKDIPDeBmdNlb33mfMSiHnd38NEKWn5KOTktH
         RwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/SPXYyJ9pOv+57/VRPyN+3QaTNRZ+8Q87oNWa1ed6U=;
        b=JI8VnXn9qi+76qn+WHQvO9Q77H6C3vcT4aJbtSm0xzDGeqwgWF90dOK5GdLnyGKCS6
         MUJwAdJdhZQALMU4Bspd+cJVPDGsbbhTCestBpYCkpK0IyAwDzCMxOXZFvgXVmEHZjUY
         oJsAYN3N4EULjmJ3SAgsGP3palI4O5ZjLmNbdB50p20LY2rr/rz6e3Um+zApChoRFRrx
         fm59NCre0r0e+3ZUDBo6TFIjVa+rvDhkN1kBVHqkSONvTFU2AbOXqvQEaiV6qYbR4LsH
         /8NT/IyK+uXymQ6z5Lr96L1yHA5JHfHafPDvylHQ9Kbaiv0ws7TsZYCqacss2GJ7OaPc
         Qd/A==
X-Gm-Message-State: AJIora+npX2QXqQtZ1d3FOCJ/Py/wyJuvr1QMeQ6nTX9pN0AGCmqxMIT
        WZNNUYoomztZ2ejDluir8RDVFQ==
X-Google-Smtp-Source: AGRyM1uzUj7FAN/10Bu3b+bPtVXXKsugwJewcCZ3H2BR0vg8eYeVP6T8bZOBrzVRTv2yR+QDna/jIA==
X-Received: by 2002:a5d:4d8f:0:b0:210:3e14:ff27 with SMTP id b15-20020a5d4d8f000000b002103e14ff27mr4601797wru.81.1655386701496;
        Thu, 16 Jun 2022 06:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:34f:da80:9c48:d9f8:5c33:3dd5])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d678c000000b0020c5253d90asm1935423wru.86.2022.06.16.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:38:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
Date:   Thu, 16 Jun 2022 15:38:11 +0200
Message-Id: <20220616133811.1674777-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616133811.1674777-1-narmstrong@baylibre.com>
References: <20220616133811.1674777-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY used to communicate with DSI
panels.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 486ca23aba32..e4d1170efd54 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -59,6 +59,18 @@ config PHY_MESON_G12A_USB3_PCIE
 	  in Meson G12A SoCs.
 	  If unsure, say N.
 
+config PHY_MESON_G12A_MIPI_DPHY_ANALOG
+	tristate "Meson G12A MIPI Analog DPHY driver"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  Enable this to support the Meson MIPI Analog DPHY found in Meson G12A
+	  SoCs.
+	  If unsure, say N.
+
 config PHY_MESON_AXG_PCIE
 	tristate "Meson AXG PCIE PHY driver"
 	default ARCH_MESON
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index c0886c850bb0..91e3b9790c03 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
+obj-$(CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG)	+= phy-meson-g12a-mipi-dphy-analog.o
 obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_DPHY)		+= phy-meson-axg-mipi-dphy.o
diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
new file mode 100644
index 000000000000..adfcca38a952
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Meson G12A MIPI DSI Analog PHY
+ *
+ * Copyright (C) 2018 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/phy/phy.h>
+
+#define HHI_MIPI_CNTL0 0x00
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(31, 16)
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
+
+#define HHI_MIPI_CNTL1 0x04
+#define		HHI_MIPI_CNTL1_BANDGAP		BIT(16)
+#define		HHI_MIPI_CNTL2_DIF_REF_CTL2	GENMASK(15, 0)
+
+#define HHI_MIPI_CNTL2 0x08
+#define		HHI_MIPI_CNTL2_DIF_TX_CTL1	GENMASK(31, 16)
+#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
+#define		HHI_MIPI_CNTL2_DIF_TX_CTL0	GENMASK(10, 0)
+
+#define DSI_LANE_0				BIT(4)
+#define DSI_LANE_1				BIT(3)
+#define DSI_LANE_CLK				BIT(2)
+#define DSI_LANE_2				BIT(1)
+#define DSI_LANE_3				BIT(0)
+
+struct phy_g12a_mipi_dphy_analog_priv {
+	struct phy *phy;
+	struct regmap *regmap;
+	struct phy_configure_opts_mipi_dphy config;
+};
+
+static int phy_g12a_mipi_dphy_analog_configure(struct phy *phy,
+					       union phy_configure_opts *opts)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
+	if (ret)
+		return ret;
+
+	memcpy(&priv->config, opts, sizeof(priv->config));
+
+	return 0;
+}
+
+static int phy_g12a_mipi_dphy_analog_power_on(struct phy *phy)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+	unsigned int reg;
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL0,
+		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8) |
+		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0xa487));
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1,
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_REF_CTL2, 0x2e) |
+		     HHI_MIPI_CNTL1_BANDGAP);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x459) |
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL1, 0x2680));
+
+	reg = DSI_LANE_CLK;
+	switch (priv->config.lanes) {
+	case 4:
+		reg |= DSI_LANE_3;
+		fallthrough;
+	case 3:
+		reg |= DSI_LANE_2;
+		fallthrough;
+	case 2:
+		reg |= DSI_LANE_1;
+		fallthrough;
+	case 1:
+		reg |= DSI_LANE_0;
+		break;
+	default:
+		reg = 0;
+	}
+
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
+			   HHI_MIPI_CNTL2_CH_EN,
+			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
+
+	return 0;
+}
+
+static int phy_g12a_mipi_dphy_analog_power_off(struct phy *phy)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL0, 0);
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0);
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0);
+
+	return 0;
+}
+
+static const struct phy_ops phy_g12a_mipi_dphy_analog_ops = {
+	.configure = phy_g12a_mipi_dphy_analog_configure,
+	.power_on = phy_g12a_mipi_dphy_analog_power_on,
+	.power_off = phy_g12a_mipi_dphy_analog_power_off,
+	.owner = THIS_MODULE,
+};
+
+static int phy_g12a_mipi_dphy_analog_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_g12a_mipi_dphy_analog_priv *priv;
+	struct device_node *np = dev->of_node;
+	struct regmap *map;
+	int ret;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get the hhi system controller node */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap\n");
+		return PTR_ERR(map);
+	}
+
+	priv->regmap = map;
+
+	priv->phy = devm_phy_create(dev, np, &phy_g12a_mipi_dphy_analog_ops);
+	if (IS_ERR(priv->phy)) {
+		ret = PTR_ERR(priv->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+		return ret;
+	}
+
+	phy_set_drvdata(priv->phy, priv);
+	dev_set_drvdata(dev, priv);
+
+	phy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy);
+}
+
+static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
+	{
+		.compatible = "amlogic,g12a-mipi-dphy-analog",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, phy_g12a_mipi_dphy_analog_of_match);
+
+static struct platform_driver phy_g12a_mipi_dphy_analog_driver = {
+	.probe = phy_g12a_mipi_dphy_analog_probe,
+	.driver = {
+		.name = "phy-meson-g12a-mipi-dphy-analog",
+		.of_match_table = phy_g12a_mipi_dphy_analog_of_match,
+	},
+};
+module_platform_driver(phy_g12a_mipi_dphy_analog_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Meson G12A MIPI Analog D-PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

