Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4154F4CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580123AbiDEXeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382393AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73843B8211;
        Tue,  5 Apr 2022 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157936; x=1680693936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ioal/KUBbdxMkJnA+gxPguV8rV4ionWp+UmNMFGaWwU=;
  b=cAVnzm4qQ/Y2JFyg7QnHk05U+tgxk/OEez9lTO3J04YJ2CtlmiGwxiDw
   72CzzH9uwLlE6dPP1zggUhIcjSBA8082VQ5slM34eMlV8Dk1td6GGeOjB
   fIz/xeqpr1mWp/Ct9ETtGIdZVmSglpnyW2ZhxpgjUoeNwLXaGQwQrC7Zm
   pnT+d5hKBcQKfAa6DhxWJgYVPkUZO2BzmYLXmpcZE6AvPunyLWBaEgKyE
   GbwMMTnuj88Muu012GvIHrrCP6tYalEy3L0XSIJOeg1EQ8ZGbx3BpEyGi
   Ukmn7rj9bFkpzMNNgxwy9Rx2a7t3AsBIpPuQ55iEJTCtci+IIhu7PFFtT
   A==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="159346905"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:35 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/8] power: reset: at91-reset: add at91_reset_data
Date:   Tue, 5 Apr 2022 14:27:21 +0300
Message-ID: <20220405112724.2760905-6-claudiu.beznea@microchip.com>
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

Add struct at91_reset_data to keep per platform related information.
This is a prerequisite for adding reset_controller_dev support.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 33 +++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 64def79d557a..0d721e27f545 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -59,6 +59,11 @@ struct at91_reset {
 	u32 ramc_lpr;
 };
 
+struct at91_reset_data {
+	u32 reset_args;
+	u32 n_device_reset;
+};
+
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
@@ -153,29 +158,34 @@ static const struct of_device_id at91_ramc_of_match[] = {
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
@@ -184,6 +194,7 @@ MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	const struct at91_reset_data *data;
 	struct at91_reset *reset;
 	struct device_node *np;
 	int ret, idx = 0;
@@ -213,9 +224,13 @@ static int __init at91_reset_probe(struct platform_device *pdev)
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

