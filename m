Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7B542B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiFHJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiFHJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A295F99FD;
        Wed,  8 Jun 2022 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677483; x=1686213483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nw1us/eLwEAcD1lnH/jrTicFged/HonT+iT6ZavvPDc=;
  b=Hn9v+cEBqWQiadLgG0nEkor9mf6pUtXXPdK99EsDm6cxagEQ4eoifxGf
   alxzBsibTFTLJQRykHr7FbC4ic54ziAb05d9JPo/RMXibLyWNvod9PCEo
   +DwnsGJNTM3AUTE7vDbBqn5Kkdp9JEulckthRP9bhLOAMOW4pBIhJ5mEn
   00HJweRvsuVbbsqO6TAjvNDYkoLfXr2SlvpRQe6JmZ2RAKoG7/qTBweXq
   wsqgqz/BcMmRzdOrEytHkqGE4tLITJ/0xEU8wkgh4/m2y69T3KUOrQCaJ
   UBqkrmkYjY5eX+jLxZJv4zTOSiJOWn8s+tzlp+Y/uRvIpeZaTWuvxvo8T
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="167235568"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:38:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:37:53 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 6/9] power: reset: at91-reset: add at91_reset_data
Date:   Wed, 8 Jun 2022 11:39:39 +0300
Message-ID: <20220608083942.1584087-7-claudiu.beznea@microchip.com>
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
2.33.0

