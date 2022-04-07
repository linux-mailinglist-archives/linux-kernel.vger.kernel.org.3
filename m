Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070234F770A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiDGHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiDGHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439E14F127;
        Thu,  7 Apr 2022 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315723; x=1680851723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oQ6NbgVbEuV5G6IspjdoFPFdN0GCADuL/PrOyaUBYtw=;
  b=zrN7pWpQwQ+eHGDIXUD90OS9LvUoieAvGOo5Y+yzaOrDAqAfNxNk2l+r
   7L9o2eF8ZZeIJRXBTmKas3KNZIQ4T6EFkjXbSgVVaXWGmCfukD7g923EQ
   q+EQ7kLXRVy40g6/uAdT18SklzoRqXiW8Rp+bxdMbZygZ8sMr/a+TWTwV
   snHS8Vs9PdrbarovdD80kJTnS8yex51vRUYabV++GhsD25yMHAbUgmgbK
   W1kOLBsRI70o9fyrjzqrou6W0Lqftss84R4xvkvnwy76iYyBs4Lbk0rf2
   Ihqu0BDWXrxvW4NMHK4F386URvC6EUoaze5kwy9NVaOFNil19Ff8E6d/m
   g==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159679179"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:22 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 07/10] power: reset: at91-reset: add reset_controller_dev support
Date:   Thu, 7 Apr 2022 10:17:05 +0300
Message-ID: <20220407071708.3848812-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/power/reset/at91-reset.c | 107 +++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 1b2aca3f490d..a6f65ac430cd 100644
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
@@ -216,6 +227,88 @@ static const struct of_device_id at91_reset_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 
+static int at91_reset_update(struct reset_controller_dev *rcdev,
+			     unsigned long id, bool assert)
+{
+	struct at91_reset *reset = to_at91_reset(rcdev);
+	u32 val;
+
+	spin_lock(&reset->lock);
+	val = readl_relaxed(reset->dev_base);
+	if (assert)
+		val |= BIT(id);
+	else
+		val &= ~BIT(id);
+	writel_relaxed(val, reset->dev_base);
+	spin_unlock(&reset->lock);
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
+	spin_lock(&reset->lock);
+	val = readl_relaxed(reset->dev_base);
+	spin_unlock(&reset->lock);
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
@@ -269,6 +362,10 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, reset);
 
+	ret = at91_rcdev_init(reset, data, pdev);
+	if (ret)
+		goto disable_clk;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc")) {
 		u32 val = readl(reset->rstc_base + AT91_RSTC_MR);
 
@@ -277,14 +374,16 @@ static int __init at91_reset_probe(struct platform_device *pdev)
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
2.32.0

