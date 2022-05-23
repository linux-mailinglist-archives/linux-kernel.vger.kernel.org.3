Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A020F530DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiEWJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiEWJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:24:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4D4839F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653297872; x=1684833872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRi/7a46MfYDFlhSMgqEU+HSCfWcSnsmUq9coE4Pa70=;
  b=JG4/UJhMwmoeuu3KHWVIvFi23mKHXW+YLTzF1BPus8o53zE0wEer6edt
   cG2eAPBF7Fu9Zw2Uc0KuRuTMFwUNIqbmH5kXfd1Za+ridpzMb2WJcGDUS
   qm5gTCrVGbVflLsMIbQnAb7tlVnH+PoQmvYUIu9FgQHUg6f0BHGppflV8
   Qkj3u4KrqB0Ldhby1zCUor+fozmKzuEgD0IAbkKnSylpKjAM0PxGvJpYZ
   g6SW3ztpl0+0FDNI8hw2rhO8i8M+o4IStWHjq2Wer53ESPNs+n5cngyae
   TyoHonZ1poEm4H+WAkPb5SWjSj4K6+Ilf6qNasIr594NKcmZwHnvoNwIU
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="160174319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 02:24:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 02:24:31 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 02:24:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <sboyd@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: at91: pm: use proper compatibles for sama7g5's rtc and rtt
Date:   Mon, 23 May 2022 12:24:21 +0300
Message-ID: <20220523092421.317345-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523092421.317345-1-claudiu.beznea@microchip.com>
References: <20220523092421.317345-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper compatible strings for SAMA7G5's RTC and RTT IPs. These are
necessary for configuring wakeup sources for ULP1 PM mode.

Fixes: 6501330f9f5e ("ARM: at91: pm: add pm support for SAMA7G5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f017b2d1b11e..826fd56d2a17 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -224,13 +224,13 @@ static const struct of_device_id sam9x60_ws_ids[] = {
 };
 
 static const struct of_device_id sama7g5_ws_ids[] = {
-	{ .compatible = "atmel,at91sam9x5-rtc",		.data = &ws_info[1] },
+	{ .compatible = "microchip,sama7g5-rtc",	.data = &ws_info[1] },
 	{ .compatible = "microchip,sama7g5-ohci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
 	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
 	{ .compatible = "microchip,sama7g5-sdhci",	.data = &ws_info[3] },
-	{ .compatible = "atmel,at91sam9260-rtt",	.data = &ws_info[4] },
+	{ .compatible = "microchip,sama7g5-rtt",	.data = &ws_info[4] },
 	{ /* sentinel */ }
 };
 
-- 
2.34.1

