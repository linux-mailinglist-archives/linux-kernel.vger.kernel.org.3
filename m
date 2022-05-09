Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE151F549
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiEIH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiEIH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:27:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36701A492E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652081022; x=1683617022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PQ0v14kg+YX1kWC50pYpDVGqLmrEAVaJH6iokEaC8JY=;
  b=GbpR5zmmCirjKYlnT098NQfOFc8TM47tnxxUCEYuWcb1FVKJPAP3jpDS
   QDz5LUHHlEX6yQ/TdPKHgxJqfsdn0fV0dkXZTdgpohUK+wI2qm/f+yd5D
   Xz/HBxyJljlyEF3RcAQFdNUmgnUD1TnIjGpzMmepXyVQisHiMzxcaFF7v
   KEs4eZ6DAkGAdMIN1K8OBHB1kYyDRiIQhVwzXSeSH6Fr1VMz1iGyW3PsI
   +mNkKaVS7UCEZn/txjqNRfCR8alxiU+CPO6TiEnNA7+i7xaT/6rvzus+V
   jqZkGVwzcXhwlge+GjWet/nbtAsk8l+srgwA/yVBqf+exQzxXCvAS8Rea
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="162801641"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 00:23:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 00:23:40 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 00:23:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2] ARM: at91: Kconfig: implement PIT64B selection
Date:   Mon, 9 May 2022 10:26:05 +0300
Message-ID: <20220509072605.4056145-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement PIT64B selection thus it will be available for the necessary
targets (at the moment SAM9X60 and SAMA7G5) w/o the necessity to
specify it via defconfig. With this the current CONFIG_TIMER_OF
dependency of PIT64B driver could be removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- keep only Kconfig changes

 arch/arm/mach-at91/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 279810381256..1531b4625c76 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -165,6 +165,15 @@ config ATMEL_CLOCKSOURCE_TCB
 	  to make a single 32-bit timer.
 	  It can also be used as a clock event device supporting oneshot mode.
 
+config MICROCHIP_CLOCKSOURCE_PIT64B
+	bool "64-bit Periodic Interval Timer (PIT64B) support"
+	default SOC_SAM9X60 || SOC_SAMA7
+	select MICROCHIP_PIT64B
+	help
+	  Select this to get a high resolution clockevent (SAM9X60) or
+	  clocksource and clockevent (SAMA7G5) based on Microchip 64-bit
+	  Periodic Interval Timer.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.34.1

