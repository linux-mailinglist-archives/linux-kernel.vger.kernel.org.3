Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEE53C9E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiFCMTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbiFCMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:19:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FB27161;
        Fri,  3 Jun 2022 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654258762; x=1685794762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vPjtyYVg+EEiabNmG8qMLL1Ibfw++Ug4T0dSA+weyig=;
  b=o/Zk34jyEz5qD4lBhMMOtEohzzCGzUGZwiNFw7D2UkXM6qk08tvKZXWK
   LXmecfep361we/6jpBXAy0RlU1krKatcwXNMn7XdKH2DOf0BL2gcmOa5s
   lc6L26okWGs+75alc2EcE5d3b37U/92cxLIUC7cW6iHWOGVC4qTl93TUh
   G/hDNUriiwvDtEIzNmqUVd7oWozP38OFV4RJ1JzAfTl8FCy1NEJ3YCGJ6
   zEFoKKv4I78F6pcL7IJxRTVnh/JDOTyvz+j8z2scSbf793vCWt+nySxA+
   skBwZXZQ28Id9FKwOZCACHSibAe3TKyOJGc2YCiFP5JNBl0O3MwmhZPkU
   g==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="98453581"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2022 05:19:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 3 Jun 2022 05:19:21 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 3 Jun 2022 05:19:17 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH 3/3] mfd: atmel-flexcom: Add support for lan966x flexcom chip-select configuration
Date:   Fri, 3 Jun 2022 17:48:02 +0530
Message-ID: <20220603121802.30320-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
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

LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
For each chip select of each flexcom there is a configuration
register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
configuration register is 21 because there are 21 shared pins
on each of which the chip select can be mapped. Each bit of the
register represents a different FLEXCOM_SHARED pin.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 drivers/mfd/atmel-flexcom.c | 86 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 33caa4fba6af..f87ee3606eb0 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -28,15 +28,64 @@
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
 
+/* LAN966x flexcom shared register offsets */
+#define FLEX_SHRD_SS_MASK_0	0x0
+#define FLEX_SHRD_SS_MASK_1	0x4
+#define FLEX_SHRD_MASK		0x1FFFFF
+
+struct atmel_flex_caps {
+	bool has_flx_cs;
+};
+
 struct atmel_flexcom {
-	void __iomem *base;
+	void __iomem *base, *flexcom_shared_base;
 	u32 opmode;
 	struct clk *clk;
 };
 
+static int atmel_flexcom_lan966x_cs_config(struct platform_device *pdev)
+{
+	struct atmel_flexcom *ddata = dev_get_drvdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 flx_shrd_pins[2], val;
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
+	for (i = 0; i < count; i++) {
+		const char *flx_cs;
+
+		if (flx_shrd_pins[i] > 20)
+			return -EINVAL;
+
+		val = ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;
+
+		err = of_property_read_string_index(np, "microchip,flx-cs", i, &flx_cs);
+		if (err)
+			return err;
+
+		if (!strcmp(flx_cs, "cs0") || !strcmp(flx_cs, "cts"))
+			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_0);
+		else if (!strcmp(flx_cs, "cs1") || !strcmp(flx_cs, "rts"))
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
@@ -76,13 +125,46 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 */
 	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
 
+	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
+		return -EINVAL;
+	}
+
+	if (caps->has_flx_cs) {
+		ddata->flexcom_shared_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+		if (IS_ERR(ddata->flexcom_shared_base))
+			return dev_err_probe(&pdev->dev,
+					PTR_ERR(ddata->flexcom_shared_base),
+					"failed to get flexcom shared base address\n");
+
+		err = atmel_flexcom_lan966x_cs_config(pdev);
+		if (err)
+			return err;
+	}
+
 	clk_disable_unprepare(ddata->clk);
 
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

