Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18AF4AEE76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBIJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBIJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:51:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC0E0CEDEA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644400280; x=1675936280;
  h=from:to:subject:date:message-id:mime-version;
  bh=EKL23ZICjemdPDx3xCc3sIo7S0uH2JuId0XLQZ6xIUo=;
  b=Ly6GFsGmhL4/+MBG+SXgAz/vOf74ASmgzrAzV4YC8Jar9JQVNXDgH397
   1ckKsMevEz35JgebPls8leS/US4Q+BTKAPupvXNi+lCXISt7SKJgBBLDr
   aMHNkLJhRM8BOr6QejMSh0SjiRQ6B/WdeubnbYEYmJwiAV882PGErU2Gf
   qzsk1m8yf2rr9SZly4htMyWnOTLeypxU//hvkC9E6Gdo8BYd7siHqaat+
   2+ZATBdI6ki4zNUcIlD2sbe7oPaI0LRC5RdaxM5xXzqE/p390lzE48azB
   8++moL57jMKT0OCRhwwiXVAkWVKzUgQoPnxO6t978Q8cbww/NxCfGOD3Q
   A==;
IronPort-SDR: azLCwhdvQiyqxIZ0TViWvN/GvCS0HpmG3i6RWiniDEaua1CCKuxvh2Q5FXNAZksWLAwgT98Fow
 TjFdvygpSxkA9EO3ZlznUuRAZYz0iL4EeCg+Dd8Q4mnYI3B0dAcL2us2zlq1IDHpj4oFgbv/cQ
 obUPMCZ2ALQ628i7H7K8F/ECR8Bnx8/7U7llN+u+CQ1EINJJYzXHXe4xopxQK/OZc/4ERihm8T
 xU9ORNdNH2n1+UmTPogNeRfaFzAR+KsKeRjE2NhDrdaMthdmaT7lvXeirqoP/f8Wjqi6Hbl8c3
 kficdpvVGJFQxz25IeyYDTMP
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152430783"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 01:41:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 01:41:43 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 01:41:41 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linus.walleij@linaro.org>, <linux@armlinux.org.uk>
Subject: [PATCH] ARM: at91: debug: add lan966 support
Date:   Wed, 9 Feb 2022 14:11:39 +0530
Message-ID: <20220209084139.29901-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for low-level debugging on FLEXCOM3 USART of
LAN966 SoC.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 976315dea958..7989d0633188 100644
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
+	default 0xe0040200 if DEBUG_AT91_LAN966_FLEXCOM3
 	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
@@ -1805,6 +1814,7 @@ config DEBUG_UART_VIRT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
+	default 0xfd040200 if DEBUG_AT91_LAN966_FLEXCOM3
 	default 0xfd531000 if DEBUG_STIH41X_SBC_ASC1
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfdd32000 if DEBUG_STIH41X_ASC2
-- 
2.17.1

