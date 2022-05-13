Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE06525EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379005AbiEMJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378985AbiEMJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:25:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3E2A28CB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652433938; x=1683969938;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7lONoJE0pI/mqPtOMCm6iSirbPlA0ZWBn6ql3BY1kUg=;
  b=mSIvswrEzuEf8aPRDQBW+jPSsayJrINpb3C+ODcKfTOIbMG2IbLg0PT8
   DXiABBRM2l+V0+YTreGoZG9uMZGlVszEHO216uQeKgEWPAWNnajarDPqp
   F0NEx7RkV3eFvd5iBCvuc7+IsivYJqWyD7B6N/xFUe5/oRfjaE8eKKtQw
   jghduSH3QCvhnS7wUQBnS9idxVRqR0p8mjET2vARy/rrjvx0St0FmX9MP
   g1TLZu0WabA37Gs5YC5ZKFVPHCKW0uWusGFUIFQsF4dFxpUQNA8j4i9KV
   u0XRaTWQtz/ssV1MiGSgxfmSZsktvq/J8LENpfXlfrn/uY4tOUwStDDca
   g==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="163546220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 02:25:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 02:25:36 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 13 May 2022 02:25:32 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <alexandre.belloni@bootlin.com>, <michael@walle.cc>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v4] ARM: at91: debug: add lan966 support
Date:   Fri, 13 May 2022 14:55:30 +0530
Message-ID: <20220513092530.19213-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Add support for low-level debugging on FLEXCOM USART of
LAN966 SoC.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v3 -> v4:
- changed SOC_LAN966x to SOC_LAN966.

 arch/arm/Kconfig.debug | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c9497d549e3..77b2db882e75 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -210,6 +210,26 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on the FLEXCOM3 port of SAMA7G5.
 
+	config DEBUG_AT91_LAN966_FLEXCOM
+		bool "Kernel low-level debugging on LAN966 FLEXCOM USART"
+		select DEBUG_AT91_UART
+		depends on SOC_LAN966
+		help
+		Say Y here if you want kernel low-level debugging support
+		on the FLEXCOM port of LAN966.
+
+		DEBUG_UART_PHYS | DEBUG_UART_VIRT
+
+		0xe0040200      | 0xfd040200     | FLEXCOM0
+		0xe0044200      | 0xfd044200     | FLEXCOM1
+		0xe0060200      | 0xfd060200     | FLEXCOM2
+		0xe0064200      | 0xfd064200     | FLEXCOM3
+		0xe0070200      | 0xfd070200     | FLEXCOM4
+
+		By default, enabling FLEXCOM3 port. Based on requirement, use
+		DEBUG_UART_PHYS and DEBUG_UART_VIRT configurations from above
+		table.
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V6
@@ -1685,6 +1705,7 @@ config DEBUG_UART_PHYS
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if DEBUG_SPEAR13XX
+	default 0xe0064200 if DEBUG_AT91_LAN966_FLEXCOM
 	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
@@ -1805,6 +1826,7 @@ config DEBUG_UART_VIRT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
+	default 0xfd064200 if DEBUG_AT91_LAN966_FLEXCOM
 	default 0xfd531000 if DEBUG_STIH41X_SBC_ASC1
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfdd32000 if DEBUG_STIH41X_ASC2
-- 
2.17.1

