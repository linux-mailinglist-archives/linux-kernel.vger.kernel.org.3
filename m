Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A74F772B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiDGHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiDGHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685F1404D1;
        Thu,  7 Apr 2022 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315719; x=1680851719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0e0YH0Rg0+RZ78xVEZkAn/PzbIGpQvxvmrrugnXNfzs=;
  b=r4yHyyWozTS1tVD4mNe0h8enfm+96qbvJmVR9wq6DWLtzVq0OuvA62RK
   i/9inLtieqelawqOKGnlMojJfPoc/gtzQZycSakRfD2QDmnbnWWKwTNCS
   u4WOMYv5lnxbKykqElTC4Esvi6As0cKI6Sr3U9HbIHKckNCD5sXSUnVgp
   4Mb6wzoZrj0H7v9OV6QJRHn3Fvlj3l85mrqfmzxayCYnjpvzWTvS/CbcQ
   StT5fL5ywTGMABR8v8OvRaRitCGAhYor69LOgGNQg0Yc6loZ0YbeaY2fV
   9OQReLkGhaPx+euGOW6IbOkUTyXkx+YrO1xEVyMqpuY/0Mz5Vc41TwvUG
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="91587742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 06/10] power: reset: at91-reset: add at91_reset_data
Date:   Thu, 7 Apr 2022 10:17:04 +0300
Message-ID: <20220407071708.3848812-7-claudiu.beznea@microchip.com>
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

Add struct at91_reset_data to keep per platform related information.
This is a prerequisite for adding reset_controller_dev support.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 38 ++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index e62798750b6b..1b2aca3f490d 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -79,6 +79,16 @@ struct at91_reset {
 	u32 ramc_lpr;
 };
 
+/**
+ * struct at91_reset_data - AT91 reset data
+ * @reset_args:		SoC specific system reset arguments
+ * @n_device_reset:	number of device resets
+ */
+struct at91_reset_data {
+	u32 reset_args;
+	u32 n_device_reset;
+};
+
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
@@ -173,29 +183,34 @@ static const struct of_device_id at91_ramc_of_match[] = {
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
@@ -204,6 +219,7 @@ MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	const struct at91_reset_data *data;
 	struct at91_reset *reset;
 	struct device_node *np;
 	int ret, idx = 0;
@@ -233,9 +249,13 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	}
 
 	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
+	if (!match || !match->data)
+		return -ENODEV;
+
+	data = match->data;
 	reset->nb.notifier_call = at91_reset;
 	reset->nb.priority = 192;
-	reset->args = (u32)match->data;
+	reset->args = data->reset_args;
 
 	reset->sclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(reset->sclk))
-- 
2.32.0

