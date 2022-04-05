Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5204F4A87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573149AbiDEWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382414AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE35B82FE;
        Tue,  5 Apr 2022 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157938; x=1680693938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDg8/E+Vo2i6Ejt2q59XPnG+fEJHVdM3pIjPwRq/hYY=;
  b=kCANGilkCaJ8Mv1lASe/GGC7FqIO8E8U59nxaCDHU9LAuGMvIn0EhREX
   mmXYnhflgweWvTuR30TV5uWMrHaGtzrAcTckADW4wMswnMyAfd0aRql7J
   lyopBbeVU2JPRtmm5PCj3aDveDHGqmNHLqtI5+NxKPrfE+nRSjJRSNHKd
   qh7J7MZjvK4frDnGQVV/7/VMmWJ/LS3v+1nf6YIzpcPiYQonRQWN7h/xw
   NnDyuadpzbr2aGoeWUUXeYBzh7rjkKg5rkbvYiksV2vAVOnRvshIyRenC
   RiO/8Bro/cIBBN/h3rSEB8vk+jXVmSoIKkaAnG7qK7FcgocGK3HiCq4zP
   A==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="159346911"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:37 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev support
Date:   Tue, 5 Apr 2022 14:27:22 +0300
Message-ID: <20220405112724.2760905-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 reset controller has 5 extra lines that goes to different devices
(3 lines to USB PHYs, 1 line to DDR controller, one line DDR PHY
controller). These reset lines could be requested by different controller
drivers (e.g. USB PHY driver) and these controllers' drivers could
assert/deassert these lines when necessary. Thus add support for
reset_controller_dev which brings this functionality.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 92 ++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 0d721e27f545..b04df54c15d2 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/reset-controller.h>
 
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
@@ -53,12 +54,16 @@ enum reset_type {
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
+	void __iomem *dev_base;
+	struct reset_controller_dev rcdev;
 	struct clk *sclk;
 	struct notifier_block nb;
 	u32 args;
 	u32 ramc_lpr;
 };
 
+#define to_at91_reset(r)	container_of(r, struct at91_reset, rcdev)
+
 struct at91_reset_data {
 	u32 reset_args;
 	u32 n_device_reset;
@@ -191,6 +196,79 @@ static const struct of_device_id at91_reset_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 
+static int at91_reset_update(struct reset_controller_dev *rcdev,
+			     unsigned long id, bool assert)
+{
+	struct at91_reset *reset = to_at91_reset(rcdev);
+	u32 val;
+
+	val = readl_relaxed(reset->dev_base);
+	if (assert)
+		val |= BIT(id);
+	else
+		val &= ~BIT(id);
+	writel_relaxed(val, reset->dev_base);
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
+	if (IS_ERR(reset->rstc_base))
+		return -ENODEV;
+
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
@@ -244,6 +322,10 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, reset);
 
+	ret = at91_rcdev_init(reset, data, pdev);
+	if (ret)
+		goto disable_clk;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc")) {
 		u32 val = readl(reset->rstc_base + AT91_RSTC_MR);
 
@@ -252,14 +334,16 @@ static int __init at91_reset_probe(struct platform_device *pdev)
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

