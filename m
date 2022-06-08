Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73C542B36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiFHJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiFHJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123D29832;
        Wed,  8 Jun 2022 01:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654677481; x=1686213481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmpkQCfq78I9O4H6zMMUL04zFy7nE3AaQI8yswkw5HA=;
  b=1k3GQU02K5FiS/uM8BHpv5p7G5tpXWbtSt51Mh3FU2/RcgUAe1OhD58t
   gErUJy+T4rhjuMQfBeHLWbLFNgx8wk6gDoePOuaPk+Yna19N7300oeATI
   AG001gCKqZ28ISUJNZsUqX/7JyKoN9tWtKjt7IJ858llzcizQNIlDDWjk
   CI87HzSVBAZ9dDWSWR2c3dot1GbXmpPKEL9gO/jhmNuqzzDRo0fXxLO1+
   skKdbdns4c51e974F9ZuanUWOP2abiOa9CeBT0PGz7VIwD+2eowcQ0mbi
   hKd4vz2T6DnYurb2PKynFJJyQNNYgpODuhfBW0MtVCa278KhOaxPLdoxG
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="167565074"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:38:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:38:00 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:37:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 8/9] power: reset: at91-reset: add support for SAMA7G5
Date:   Wed, 8 Jun 2022 11:39:41 +0300
Message-ID: <20220608083942.1584087-9-claudiu.beznea@microchip.com>
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

Add support for SAMA7G5 including reset_controller_dev support for 3 lines
(which are USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index e25d8d38a2f8..80bf0c023c17 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -202,6 +202,11 @@ static const struct at91_reset_data samx7 = {
 	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PROCRST,
 };
 
+static const struct at91_reset_data sama7g5 = {
+	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PROCRST,
+	.n_device_reset = 3,
+};
+
 static const struct of_device_id at91_reset_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9260-rstc",
@@ -223,6 +228,10 @@ static const struct of_device_id at91_reset_of_match[] = {
 		.compatible = "microchip,sam9x60-rstc",
 		.data = &samx7,
 	},
+	{
+		.compatible = "microchip,sama7g5-rstc",
+		.data = &sama7g5,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
-- 
2.33.0

