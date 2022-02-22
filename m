Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC44BF757
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiBVLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiBVLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:40:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0F136EFC;
        Tue, 22 Feb 2022 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645529981; x=1677065981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bAcPZNAE7B1EyRiOO9Yj95G0vdC998qo8hhG4+FWP6g=;
  b=eIAxjXGcUFyJuCUmEFOpDZ0mQLvE9n3TVj1LYz4ibJGvjSlkZL9WIK0r
   KkY/6/4xCD/lbAvMqRDGfe50mCj2/Sv8JAtxWH2KkiJLZIr5HoWvLyP3E
   crK5jDxLF1LGB3Wpcd3OgiGG8+rjsQmD8J+G0heCHk+QfPUL+zmyx8FDO
   ZFzAUaxfalVifKGV6AP4XKghncyfdWQc1K1FOEZ4CFCDKLNy15K7Ho0sN
   tGMAOHnKjSUrJj9pQCfZmoTON+zVEpcu7MVIBl4BlbnNo1dS2TAQibNwT
   yTJj8b14IYDabaxnfZfBeycJPmMQYWA/yDD10KS1yz2Ank8yH4n8/C7Kb
   w==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="149554576"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 04:39:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 04:39:40 -0700
Received: from hari-laptop.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 22 Feb 2022 04:39:35 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH] 2/3] ARM: dts: at91: sama7g5: Add can controllers of sama7g5
Date:   Tue, 22 Feb 2022 17:09:23 +0530
Message-ID: <20220222113924.25799-2-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
References: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for all the six CAN controllers of sama7g5.The internal SRAM of 128KB
is split among the CAN controllers for the message RAM elements leaving a small
portion reserved for power management. The SRAM split up is as below.

Lower 64K:
        PM       13K
        can-0    17K
        can-1    17K
        can-2    17K

Higher 64K:

        can-3    17K
        can-4    17K
        can-5    17K

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 6c7012f74b10..d4d87db8e212 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -211,6 +211,102 @@
 			status = "disabled";
 		};
 
+		can0: can@e0828000 {
+			compatible = "bosch,m_can";
+			reg = <0xe0828000 0x100>, <0x100000 0x7800>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 61>, <&pmc PMC_TYPE_GCK 61>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 61>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x3400 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can1: can@e082c000 {
+			compatible = "bosch,m_can";
+			reg = <0xe082c000 0x100>, <0x100000 0xbc00>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 62>, <&pmc PMC_TYPE_GCK 62>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 62>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can2: can@e0830000 {
+			compatible = "bosch,m_can";
+			reg = <0xe0830000 0x100>, <0x100000 0x10000>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 63>, <&pmc PMC_TYPE_GCK 63>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 63>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0xbc00 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can3: can@e0834000 {
+			compatible = "bosch,m_can";
+			reg = <0xe0834000 0x100>, <0x110000 0x4400>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 64>, <&pmc PMC_TYPE_GCK 64>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 64>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can4: can@e0838000 {
+			compatible = "bosch,m_can";
+			reg = <0xe0838000 0x100>, <0x110000 0x8800>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 65>, <&pmc PMC_TYPE_GCK 65>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 65>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x4400 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can5: can@e083c000 {
+			compatible = "bosch,m_can";
+			reg = <0xe083c000 0x100>, <0x110000 0xcc00>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 66>, <&pmc PMC_TYPE_GCK 66>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 66>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_SYSPLL>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x8800 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
 		adc: adc@e1000000 {
 			compatible = "microchip,sama7g5-adc";
 			reg = <0xe1000000 0x200>;
-- 
2.17.1

