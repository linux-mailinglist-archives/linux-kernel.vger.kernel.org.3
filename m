Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CF4F771B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiDGHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiDGHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B411CF40;
        Thu,  7 Apr 2022 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315729; x=1680851729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYy+OHu/ihHl4AVwsFTzsneY2qllDVbmw6a9RaRneP4=;
  b=WERRA4gaWAY4mGXfr5DTdTM07MVGYj0ovscC03LesMTs+YF6V6Lg7BuW
   5M3PeMX6xs0q9Eg2gXlx0Js6blWdENPdFVk6py/ObuJ0tehLp4WhYxRm3
   mJXqqvCe4tthT1kkZHKi1lOEvenBtk0c9NbQYuXK2269+IWf9eHDF2FPe
   7s5I1ZpZ64ty0raVe0qtnRkeAMrrzbrLAa7VtVVwJxEZThwe2x+qWCikx
   S2NNe6vclRzOblIRItFj3attV4RGE3ZOtHIAS5o+r2bTOqdvtS2H5CMio
   t/RI+QIRSLnMgXmjmmeQ1+DZWRc//aLdwApNdMWLZSWvK5aUfDKo3h942
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="151841482"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:25 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/10] power: reset: at91-reset: add support for SAMA7G5
Date:   Thu, 7 Apr 2022 10:17:06 +0300
Message-ID: <20220407071708.3848812-9-claudiu.beznea@microchip.com>
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

Add support for SAMA7G5 including reset_controller_dev support for 3 lines
(which are USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index a6f65ac430cd..cba12af638a4 100644
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
2.32.0

