Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEE4C6A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiB1LTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiB1LTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:19:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CF33E8C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047099; x=1677583099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yt27LNUTflYgzhTyHkUhcmzYyrzGjKVHAKDiaE7aibE=;
  b=ymaj6zKQmdm2RLC8PuN6xKp9pzHKxFmTW0PWb+5wN/fcPoblGgUYc8T2
   yteWplLcTeEAiE5tZsPFSisxEsYlc/O1u9K4xhViYgVYCD7acNmzaq9VV
   XjkPIczy1cCzP7Fz25WPsz+vWf1UiYHO4kxgmitz4dHSsI9Yj1q3Jnvm9
   3T2N/SWZqt+W+Nu7bdoAbm7MoMgNASb+4fem/7E++MQCH6PR+NhoIpPXg
   nDNQBgyS/ElCuBRzme43mm6eiMcuzoEfkw4GfarFXNtWnn+NaKQaLvS3X
   ZZVnd1CMFgZl7v2oh3WcLOoPCIDQm4vC4cJ9+ZT/7cnGFBP4nAqE1q36C
   A==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155099435"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:18:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:18:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:18:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/7] clocksource/drivers/timer-microchip-pit64b: remove mmio selection
Date:   Mon, 28 Feb 2022 13:19:17 +0200
Message-ID: <20220228111923.1400049-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
References: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIT64B timer driver doesn't depend on CLKSRC_MMIO since
commit e85c1d21b16b ("clocksource/drivers/timer-microchip-pit64b:
Add clocksource suspend/resume"). Remove the selection.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..1ea556e75494 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -713,7 +713,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select CLKSRC_MMIO
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.32.0

