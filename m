Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A55461FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiFJJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349751AbiFJJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8B3CA7C;
        Fri, 10 Jun 2022 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852966; x=1686388966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxqDz6xYHFQmyYp+lbFAthJ/+U2ME7Qqx22cRFFmTvg=;
  b=nCHXIF//KINEQ6TcAb3+9gC2+vJVjf9shYewPu9mPUgRTmpBj+Mftdil
   /DWlio1fCLR1266SfOQn4e5b3aE1FLHkEhIkx9WCXu2V3yKbQVpD0XRQk
   Le4U3rkV0jjw+0K8oc201KbMbXsx/H5kLEk1tDEneFiBWeRiUr4IkO7IR
   Nd26qurhcoUV+bkD0lLMRJjOdONGwmWdSMEd2X/7/SPyoskuygBoUiw/1
   L5ayS2G3xwrOU89nUHsMs5/NE04kJ93FmQND0ojBjdQm95xtZuyZwG7Kr
   s3sQTSqCjGEbuj0XhPrFQO0cl8HfoeXCB7ax6ZZDVsNbPCpOBC5EuZZIn
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="159728360"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:44 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 6/9] power: reset: at91-reset: add at91_reset_data
Date:   Fri, 10 Jun 2022 12:24:11 +0300
Message-ID: <20220610092414.1816571-7-claudiu.beznea@microchip.com>
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

Add struct at91_reset_data to keep per platform related information.
This is a prerequisite for adding reset_controller_dev support.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 45 ++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index e62798750b6b..bb073aba816f 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -66,6 +66,7 @@ enum reset_type {
  * @rstc_base:		base address for system reset
  * @ramc_base:		array with base addresses of RAM controllers
  * @sclk:		slow clock
+ * @data:		platform specific reset data
  * @nb:			reset notifier block
  * @args:		SoC specific system reset arguments
  * @ramc_lpr:		SDRAM Controller Low Power Register
@@ -74,11 +75,26 @@ struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
 	struct clk *sclk;
+	const struct at91_reset_data *data;
 	struct notifier_block nb;
 	u32 args;
 	u32 ramc_lpr;
 };
 
+/**
+ * struct at91_reset_data - AT91 reset data
+ * @reset_args:			SoC specific system reset arguments
+ * @n_device_reset:		number of device resets
+ * @device_reset_min_id:	min id for device reset
+ * @device_reset_max_id:	max id for device reset
+ */
+struct at91_reset_data {
+	u32 reset_args;
+	u32 n_device_reset;
+	u8 device_reset_min_id;
+	u8 device_reset_max_id;
+};
+
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
@@ -115,7 +131,7 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		  "r" (reset->rstc_base),
 		  "r" (1),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
-		  "r" (reset->args),
+		  "r" (reset->data->reset_args),
 		  "r" (reset->ramc_lpr)
 		: "r4");
 
@@ -173,29 +189,34 @@ static const struct of_device_id at91_ramc_of_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct at91_reset_data sam9260 = {
+	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
+};
+
+static const struct at91_reset_data samx7 = {
+	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PROCRST,
+};
+
 static const struct of_device_id at91_reset_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9260-rstc",
-		.data = (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
-				 AT91_RSTC_PROCRST),
+		.data = &sam9260,
 	},
 	{
 		.compatible = "atmel,at91sam9g45-rstc",
-		.data = (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
-				 AT91_RSTC_PROCRST)
+		.data = &sam9260,
 	},
 	{
 		.compatible = "atmel,sama5d3-rstc",
-		.data = (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
-				 AT91_RSTC_PROCRST)
+		.data = &sam9260,
 	},
 	{
 		.compatible = "atmel,samx7-rstc",
-		.data = (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
+		.data = &samx7,
 	},
 	{
 		.compatible = "microchip,sam9x60-rstc",
-		.data = (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
+		.data = &samx7,
 	},
 	{ /* sentinel */ }
 };
@@ -232,10 +253,12 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 		}
 	}
 
-	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
+	reset->data = device_get_match_data(&pdev->dev);
+	if (!reset->data)
+		return -ENODEV;
+
 	reset->nb.notifier_call = at91_reset;
 	reset->nb.priority = 192;
-	reset->args = (u32)match->data;
 
 	reset->sclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(reset->sclk))
-- 
2.34.1

