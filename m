Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D708D54620A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347389AbiFJJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349785AbiFJJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA115896A;
        Fri, 10 Jun 2022 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852970; x=1686388970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+R088pW6Qc5uDDhwtQgDHJhmOR/UgLx7ErvvWBaI+0=;
  b=2bGWelUr8gE5nWAcvBLRKKtUAcKVYJTf6F2H8QLRX0bG/3ZynnSkbGJR
   7m7fi4Wf/wX3d45mj7fO+SX2xIgs+x43XRZRr64VbatIMMxedkEfTboTu
   Yk/k6EyWUbRO2ePgkNQagjzu8HGy5jIQ9K7I7w826zV1+uM488vnQb0OS
   6pNTvIp+dwdfGygDxLYVi/KCHOlIu7sVXQSwgFfT+i2ClCpY6UYmX3TjB
   ELZUS7bz2ETdhLCpLt/GV7+c6d3VE1azWiXuhS/t1Nfy+h4N4DHJNPEoM
   aZCTewrdV806BFM5e3f4wkG/g0hpAB93kKhR3SAOuWWZ+PKIRNLX+dzRo
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="177391143"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:49 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 7/9] power: reset: at91-reset: add reset_controller_dev support
Date:   Fri, 10 Jun 2022 12:24:12 +0300
Message-ID: <20220610092414.1816571-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index bb073aba816f..bc9f1d9e7867 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/reset-controller.h>
 
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
@@ -65,8 +66,11 @@ enum reset_type {
  * struct at91_reset - AT91 reset specific data structure
  * @rstc_base:		base address for system reset
  * @ramc_base:		array with base addresses of RAM controllers
+ * @dev_base:		base address for devices reset
  * @sclk:		slow clock
  * @data:		platform specific reset data
+ * @rcdev:		reset controller device
+ * @lock:		lock for devices reset register access
  * @nb:			reset notifier block
  * @args:		SoC specific system reset arguments
  * @ramc_lpr:		SDRAM Controller Low Power Register
@@ -74,13 +78,18 @@ enum reset_type {
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
+	void __iomem *dev_base;
 	struct clk *sclk;
 	const struct at91_reset_data *data;
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
  * @reset_args:			SoC specific system reset arguments
@@ -222,6 +231,89 @@ static const struct of_device_id at91_reset_of_match[] = {
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
+	struct at91_reset *reset = to_at91_reset(rcdev);
+
+	if (!reset->data->n_device_reset ||
+	    (reset_spec->args[0] < reset->data->device_reset_min_id ||
+	     reset_spec->args[0] > reset->data->device_reset_max_id))
+		return -EINVAL;
+
+	return reset_spec->args[0];
+}
+
+static int at91_rcdev_init(struct at91_reset *reset,
+			   struct platform_device *pdev)
+{
+	if (!reset->data->n_device_reset)
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
+	reset->rcdev.nr_resets = reset->data->n_device_reset;
+	reset->rcdev.of_reset_n_cells = 1;
+	reset->rcdev.of_xlate = at91_reset_of_xlate;
+
+	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+}
+
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -272,6 +364,10 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, reset);
 
+	ret = at91_rcdev_init(reset, pdev);
+	if (ret)
+		goto disable_clk;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc")) {
 		u32 val = readl(reset->rstc_base + AT91_RSTC_MR);
 
@@ -280,14 +376,16 @@ static int __init at91_reset_probe(struct platform_device *pdev)
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
2.34.1

