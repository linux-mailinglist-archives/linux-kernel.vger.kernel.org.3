Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBC54F82B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382209AbiFQNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382359AbiFQNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:08:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF4175A7;
        Fri, 17 Jun 2022 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655471282; x=1687007282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qMlJTGouMGzkJNwKsS+Zb4L98aeIn5YgnhqvcoiSDMY=;
  b=erFxOGKJDeurZBfIQtg7pJOFokotpVAJ91Ri6oVudncI60nI2+suukGg
   RU4pj8m3UTifvTVL/tp3G4CftovM0Wy1QxkovJSoTR/REBeHiHm10nVIl
   /8QGcF8i6UZuSkC4Ar0UAhQxyG345GdLR28f+saHbfYHI7m+o1M6X9zs1
   tC1Cl9dGtjz+DxKlvoAGyDu+Wj5kI2SGwdPezdK9bkcIA4EhiEelxloGR
   /TJJt9Nn6FAU0WgjOND7+hLtMA9yD4+y1QOboGDLyb7pZH4BP+Y2VMlWs
   CUrAEkgGgVE5ADJAdGdnsGe9po6Az4YlmHsHI2zqbvBwvEFt7CT2JddMu
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="163864329"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 06:08:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 06:08:02 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Jun 2022 06:07:58 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] mfd: atmel-flexcom: Add support for lan966x flexcom chip-select configuration
Date:   Fri, 17 Jun 2022 18:37:29 +0530
Message-ID: <20220617130729.12072-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects
which are optional I/O lines. For each chip select of each
flexcom there is a configuration register FLEXCOM_SHARED[0-4]:SS_MASK[0-1].
The width of configuration register is 21 because there are
21 shared pins on each of which the chip select can be mapped.
Each bit of the register represents a different FLEXCOM_SHARED pin.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v3 -> v4:
 - Add condition for a flexcom whether to configure chip-select lines
   or not, based on "microchip,flx-shrd-pins" property existence because
   chip-select lines are optional.

v2 -> v3:
 - used goto label for clk_disable in error cases.

v1 -> v2:
 - use GENMASK for mask, macros for maximum allowed values.
 - use u32 values for flexcom chipselects instead of strings.
 - disable clock in case of errors.

 drivers/mfd/atmel-flexcom.c | 94 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 33caa4fba6af..430b6783b5a7 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -28,15 +28,68 @@
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
 
+/* LAN966x flexcom shared register offsets */
+#define FLEX_SHRD_SS_MASK_0	0x0
+#define FLEX_SHRD_SS_MASK_1	0x4
+#define FLEX_SHRD_PIN_MAX	20
+#define FLEX_CS_MAX		1
+#define FLEX_SHRD_MASK		GENMASK(20, 0)
+
+struct atmel_flex_caps {
+	bool has_flx_cs;
+};
+
 struct atmel_flexcom {
 	void __iomem *base;
+	void __iomem *flexcom_shared_base;
 	u32 opmode;
 	struct clk *clk;
 };
 
+static int atmel_flexcom_lan966x_cs_config(struct platform_device *pdev)
+{
+	struct atmel_flexcom *ddata = dev_get_drvdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 flx_shrd_pins[2], flx_cs[2], val;
+	int err, i, count;
+
+	count = of_property_count_u32_elems(np, "microchip,flx-shrd-pins");
+	if (count <= 0 || count > 2) {
+		dev_err(&pdev->dev, "Invalid %s property (%d)\n", "flx-shrd-pins",
+				count);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32_array(np, "microchip,flx-shrd-pins", flx_shrd_pins, count);
+	if (err)
+		return err;
+
+	err = of_property_read_u32_array(np, "microchip,flx-cs", flx_cs, count);
+	if (err)
+		return err;
+
+	for (i = 0; i < count; i++) {
+		if (flx_shrd_pins[i] > FLEX_SHRD_PIN_MAX)
+			return -EINVAL;
+
+		if (flx_cs[i] > FLEX_CS_MAX)
+			return -EINVAL;
+
+		val = ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;
+
+		if (flx_cs[i] == 0)
+			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_0);
+		else
+			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_1);
+	}
+
+	return 0;
+}
+
 static int atmel_flexcom_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct atmel_flex_caps *caps;
 	struct resource *res;
 	struct atmel_flexcom *ddata;
 	int err;
@@ -76,13 +129,52 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 */
 	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
 
+	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
+		err = -EINVAL;
+		goto clk_disable;
+	}
+
+	if (caps->has_flx_cs && of_property_read_bool(np, "microchip,flx-shrd-pins")) {
+		ddata->flexcom_shared_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+		if (IS_ERR(ddata->flexcom_shared_base)) {
+			err = dev_err_probe(&pdev->dev,
+					PTR_ERR(ddata->flexcom_shared_base),
+					"failed to get flexcom shared base address\n");
+			goto clk_disable;
+		}
+
+		err = atmel_flexcom_lan966x_cs_config(pdev);
+		if (err)
+			goto clk_disable;
+	}
+
+clk_disable:
 	clk_disable_unprepare(ddata->clk);
+	if (err)
+		return err;
 
 	return devm_of_platform_populate(&pdev->dev);
 }
 
+static const struct atmel_flex_caps atmel_flexcom_caps = {};
+
+static const struct atmel_flex_caps lan966x_flexcom_caps = {
+	.has_flx_cs = true,
+};
+
 static const struct of_device_id atmel_flexcom_of_match[] = {
-	{ .compatible = "atmel,sama5d2-flexcom" },
+	{
+		.compatible = "atmel,sama5d2-flexcom",
+		.data = &atmel_flexcom_caps,
+	},
+
+	{
+		.compatible = "microchip,lan966x-flexcom",
+		.data = &lan966x_flexcom_caps,
+	},
+
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
-- 
2.17.1

