Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD474E63E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbiCXNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiCXNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:12:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A6A774D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648127449; x=1679663449;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AJ4z9771lC03AT4ol+j4MJ3/Iwb6+ApMU5BnuJsmO3g=;
  b=bqJkbvm42AA8OYH+mI5nPN/LcKaWE3d2DLt3/ANR+OJaLr31zcllHMnM
   57EC+Y3nRPEL7asSR9zgilsbKoOQuzd9eJGEN+qgYOqplXTvpuRESiuBQ
   WteszoOpaWCLYmh0cKv/rsKd6BhOmPzam5ciDSLrprNKV0uIom+C+beGp
   XW+UHcrmZeHZaTZ6QkaqACSrgvKAEciDXtgAPCkaPvbX9ZcUIJE4TdbfP
   K4VM9M8BD89eC7XAnxPftKqhOcPlySktDPFf2W04h0FGOeh0N4MWS6swf
   EkzpdO0m8ZgfFxbVWxsCFAzD5UuLuflGJS+VMN9Fk7bbMBEr9Iu3DuH1m
   A==;
X-IronPort-AV: E=Sophos;i="5.90,207,1643698800"; 
   d="scan'208";a="166977136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2022 06:10:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Mar 2022 06:10:47 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 24 Mar 2022 06:10:45 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <michael@walle.cc>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v2] ARM: at91: debug: add lan966 support
Date:   Thu, 24 Mar 2022 18:40:31 +0530
Message-ID: <20220324131031.32430-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for low-level debugging on FLEXCOM3 USART of
LAN966 SoC.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
- Corrected flexcom3 base address - 0xe0064200.

 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c9497d549e3..04501ddc7ab4 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -210,6 +210,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on the FLEXCOM3 port of SAMA7G5.
 
+        config DEBUG_AT91_LAN966_FLEXCOM3
+                bool "Kernel low-level debugging on LAN966 FLEXCOM3 USART"
+                select DEBUG_AT91_UART
+                depends on SOC_LAN966
+                help
+                  Say Y here if you want kernel low-level debugging support
+                  on the FLEXCOM3 port of LAN966.
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V6
@@ -1685,6 +1693,7 @@ config DEBUG_UART_PHYS
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if DEBUG_SPEAR13XX
+	default 0xe0064200 if DEBUG_AT91_LAN966_FLEXCOM3
 	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
@@ -1805,6 +1814,7 @@ config DEBUG_UART_VIRT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
+	default 0xfd064200 if DEBUG_AT91_LAN966_FLEXCOM3
 	default 0xfd531000 if DEBUG_STIH41X_SBC_ASC1
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfdd32000 if DEBUG_STIH41X_ASC2
-- 
2.17.1

