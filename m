Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84011542B39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiFHJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiFHJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731121DB1C6;
        Wed,  8 Jun 2022 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677478; x=1686213478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaQ9f9g39ZnVQCAOTVUvHNMiLRXd/oxG4jPCA+dLL8o=;
  b=v8gFDyKy6gRT4aDCJ6MqJ41za3Xyyc7mFz9Uhi/kWpgXAA2FV7fRnnk0
   6E3VoFs7p1uXpnvvJ6DVqO0yKyII0HyxbT/499iQZVcxTZ+zifKbw64jY
   o3S7jcP0NkWSXKr9HNegO8PyJi+if+QOm235lcTOloZc3bMWIR5hY90vW
   MiEvpy7Ov18SDEr7fWtt0IM43ZUXYkSYwRzqvytiwj88hbKln5mOggdQz
   VbT6R/4EzONF7mtmzRsiCTEN++qU6c3CMeRGz05Wb+RpOjr6vDWh25Du8
   h4SBOp3hjC6pdzxehBCf0uINjMS7KOErUzI9iHRKNKD3DoefcXk4Licy+
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="159357023"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:37:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:37:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 7/9] power: reset: at91-reset: add reset_controller_dev support
Date:   Wed, 8 Jun 2022 11:39:40 +0300
Message-ID: <20220608083942.1584087-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 reset controller has 5 extra lines that goes to different devices
(3 lines to USB PHYs, 1 line to DDR controller, 1 line to DDR PHY
controller). These reset lines could be requested by different controller
drivers (e.g. USB PHY driver) and these controllers' drivers could
assert/deassert these lines when necessary. Thus add support for
reset_controller_dev which brings this functionality.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/power/reset/at91-reset.c | 106 +++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 1b2aca3f490d..e25d8d38a2f8 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -17,10 +17,13 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/reset-controller.h>
 
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
 
+#include <dt-bindings/reset/sama7g5-reset.h>
+
 #define AT91_RSTC_CR	0x00		/* Reset Controller Control Register */
 #define AT91_RSTC_PROCRST	BIT(0)		/* Processor Reset */
 #define AT91_RSTC_PERRST	BIT(2)		/* Peripheral Reset */
@@ -65,7 +68,10 @@ enum reset_type {
  * struct at91_reset - AT91 reset specific data structure
  * @rstc_base:		base address for system reset
  * @ramc_base:		array with base addresses of RAM controllers
+ * @dev_base:		base address for devices reset
  * @sclk:		slow clock
+ * @rcdev:		reset controller device
+ * @lock:		lock for devices reset register access
  * @nb:			reset notifier block
  * @args:		SoC specific system reset arguments
  * @ramc_lpr:		SDRAM Controller Low Power Register
@@ -73,12 +79,17 @@ enum reset_type {
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
+	void __iomem *dev_base;
 	struct clk *sclk;
+	struct reset_controller_dev rcdev;
+	spinlock_t lock;
 	struct notifier_block nb;
 	u32 args;
 	u32 ramc_lpr;
 };
 
+#define to_at91_reset(r)	container_of(r, struct at91_reset, rcdev)
+
 /**
  * struct at91_reset_data - AT91 reset data
  * @reset_args:		SoC specific system reset arguments
@@ -216,6 +227,87 @@ static const struct of_device_id at91_reset_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 
+static int at91_reset_update(struct reset_controller_dev *rcdev,
+			     unsigned long id, bool assert)
+{
+	struct at91_reset *reset = to_at91_reset(rcdev);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&reset->lock, flags);
+	val = readl_relaxed(reset->dev_base);
+	if (assert)
+		val |= BIT(id);
+	else
+		val &= ~BIT(id);
+	writel_relaxed(val, reset->dev_base);
+	spin_unlock_irqrestore(&reset->lock, flags);
+
+	return 0;
+}
+
+static int at91_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return at91_reset_update(rcdev, id, true);
+}
+
+static int at91_reset_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return at91_reset_update(rcdev, id, false);
+}
+
+static int at91_reset_dev_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct at91_reset *reset = to_at91_reset(rcdev);
+	u32 val;
+
+	val = readl_relaxed(reset->dev_base);
+
+	return !!(val & BIT(id));
+}
+
+static const struct reset_control_ops at91_reset_ops = {
+	.assert = at91_reset_assert,
+	.deassert = at91_reset_deassert,
+	.status = at91_reset_dev_status,
+};
+
+static int at91_reset_of_xlate(struct reset_controller_dev *rcdev,
+			       const struct of_phandle_args *reset_spec)
+{
+	if (reset_spec->args[0] < SAMA7G5_RESET_USB_PHY1 ||
+	    reset_spec->args[0] > SAMA7G5_RESET_USB_PHY3)
+		return -EINVAL;
+
+	return reset_spec->args[0];
+}
+
+static int at91_rcdev_init(struct at91_reset *reset,
+			   const struct at91_reset_data *data,
+			   struct platform_device *pdev)
+{
+	if (!data->n_device_reset)
+		return 0;
+
+	reset->dev_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 1,
+					NULL);
+	if (IS_ERR(reset->dev_base))
+		return -ENODEV;
+
+	spin_lock_init(&reset->lock);
+	reset->rcdev.ops = &at91_reset_ops;
+	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.nr_resets = data->n_device_reset;
+	reset->rcdev.of_reset_n_cells = 1;
+	reset->rcdev.of_xlate = at91_reset_of_xlate;
+
+	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+}
+
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -269,6 +361,10 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, reset);
 
+	ret = at91_rcdev_init(reset, data, pdev);
+	if (ret)
+		goto disable_clk;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc")) {
 		u32 val = readl(reset->rstc_base + AT91_RSTC_MR);
 
@@ -277,14 +373,16 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	}
 
 	ret = register_restart_handler(&reset->nb);
-	if (ret) {
-		clk_disable_unprepare(reset->sclk);
-		return ret;
-	}
+	if (ret)
+		goto disable_clk;
 
 	at91_reset_status(pdev, reset->rstc_base);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(reset->sclk);
+	return ret;
 }
 
 static int __exit at91_reset_remove(struct platform_device *pdev)
-- 
2.33.0

