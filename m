Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29748AE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiAKNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:06:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49468 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiAKNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641906361; x=1673442361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J+t8T0SDKaKxChCOBni42uvmLsI2U82MOlA7kFSEowQ=;
  b=ZyvJhLdH3sqsi7M7nXTS8r23iErX50mACS8BYDtviwLFX4XiUR8+a3xm
   lmPVuB+0lxFHWdMSHXwQE/c4SOyTBKXAejHnBvmt4jdSGxgsx2ORfxeET
   E5F10PZ2GNqCaXkC+05LMbluOVtDRoo1svyzKlTSbA+RSrY1ezVXC0sPM
   U3yOzByCthsOaXx8uX/Lbl8nKPlsW0T7Ri0iidgMvdoj6//XatK/4kr6U
   KifJ5MZfvqHxGrjmgrY1JNJwjexSAdnoLeKAfq2T1tFTjnTYlDJ8Z+eck
   tZOQ/ci/XuEIcRQ5zmo3thf03y7t+ZgX3rAvgps5jpWV/mpNtDT19jLnj
   g==;
IronPort-SDR: 4JZn0sd76OX9lGedEygPTjJOmxQ6e3W7XHQxX3klVTnV9nABHPhChS/UhlsbfnPOZHTu/BE97G
 XYIaQ79Pzk6VgZM8aC/c9KVB4x1SWMHqwbDeftckIIofHfknyNoGCrkKK/Vo6CvQdkaxx8/0e+
 vrvaBy++A/Knh8XBvKkXWhbFJ+i/TiFDQ3VlyvE86eV6eZypS3k+J1Z44qb5gddIVsur2rxjYp
 eTSvf8rWBdOvNhuYHJYw+NAVMTPNwxbcu5rCY2o06IgLS+mK4Kd2jshV+h0MXEScLisV1R6xkE
 bipdjVkHUwoHHgwYGb2nao0z
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="145039025"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 06:06:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 06:06:00 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 11 Jan 2022 06:05:58 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Date:   Tue, 11 Jan 2022 15:05:56 +0200
Message-ID: <20220111130556.905978-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NAND support. The sama7g5's SMC IP is the same as sama5d2's with
a slightly change: it provides a synchronous clock output (SMC clock)
that is dedicated to FPGA usage. Since this doesn't interfere with the SMC
NAND configuration, thus code will not be added in the current nand driver
to address the FPGA usage, use the sama5d2's compatible and choose not to
introduce dedicated compatibles for sama7g5.
Tested with Micron MT29F4G08ABAEAWP NAND flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
The patch depends on the following patch:
https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u

 arch/arm/boot/dts/sama7g5.dtsi | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..7972cb8c2562 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -75,6 +75,45 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		nfc_sram: sram@600000 {
+			compatible = "mmio-sram";
+			no-memory-wc;
+			reg = <0x00600000 0x2400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x00600000 0x2400>;
+		};
+
+		nfc_io: nfc-io@10000000 {
+			compatible = "atmel,sama5d3-nfc-io", "syscon";
+			reg = <0x10000000 0x8000000>;
+		};
+
+		ebi: ebi@40000000 {
+			compatible = "atmel,sama5d3-ebi";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			atmel,smc = <&hsmc>;
+			reg = <0x40000000 0x20000000>;
+			ranges = <0x0 0x0 0x40000000 0x8000000
+				  0x1 0x0 0x48000000 0x8000000
+				  0x2 0x0 0x50000000 0x8000000
+				  0x3 0x0 0x58000000 0x8000000>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK1>;
+			status = "disabled";
+
+			nand_controller: nand-controller {
+				compatible = "atmel,sama5d3-nand-controller";
+				atmel,nfc-sram = <&nfc_sram>;
+				atmel,nfc-io = <&nfc_io>;
+				ecc-engine = <&pmecc>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+			};
+		};
+
 		securam: securam@e0000000 {
 			compatible = "microchip,sama7g5-securam", "atmel,sama5d2-securam", "mmio-sram";
 			reg = <0xe0000000 0x4000>;
@@ -181,6 +220,22 @@ tcb1: timer@e0800000 {
 			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 		};
 
+		hsmc: hsmc@e0808000 {
+			compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
+			reg = <0xe0808000 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pmecc: ecc-engine@e0808070 {
+				compatible = "atmel,sama5d2-pmecc";
+				reg = <0xe0808070 0x490>,
+				      <0xe0808500 0x200>;
+			};
+		};
+
 		qspi0: spi@e080c000 {
 			compatible = "microchip,sama7g5-ospi";
 			reg = <0xe080c000 0x400>, <0x20000000 0x10000000>;
-- 
2.25.1

