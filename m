Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793E4A9A16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358888AbiBDNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:37:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34457 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643981878; x=1675517878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ins3wjr1yw8GLN2RCWCRKZ7wEA5SACV7Eby0ebdTizI=;
  b=sWn5O4a4SYHLdOHjcBsJ50RkdQbtMDls8nK6/71RgJBLUnKrgHYE4n9O
   MDA6tjxJcIbXge9bEqvX50aQRE6quuUMJJpAL9zuwHnRxLibZSIdNeCtP
   sfhpqtfQtAMmn/+NjNZA2IXO1lmdGchef4FuosqseHhxHPrOU2nyzuvkh
   92x7b1MdymFb40g/x3FMx39iNyD+jf3KYWNexo6VBzHiuq/c7AX0rW1hY
   Tgh9ugMLCfgN3FswojdSIWi+hodkaEhlq2Wd+V0i+RMi43fHbwqTbLg6d
   TygcGbFEasLHsiLVX+caZV6kx7XTljgDerd/5PPnBbhXRXRvaKlDrN4Yw
   w==;
IronPort-SDR: GObYwLT3RkKPIG3eW2ryvclkpvDVyYLSnseXNQyBoxcdlZqG7iYDfbA78TqWZlI/fA/V29BBUc
 AO1vAstjEm15yCGEJnzERVSdRfx4UXRfDH9061Yynk3kUry9MZiba8ux1s6wJ83mTNe62aLDVX
 HJRusjsYSsGemgtokY6b+f7YINMnPLo1QS86FSHXDV3fS81yQ0pZOaiAd12U1s2xU9S5DKuTbl
 K44t8qseYgNnwYpnceHMqxGLp6vhAaYLkUdM8ozCgu/HoWi13WB2y7mTQDQlJQk7fnCQZ1jcb/
 +BCHye7jOGWujiJQ9SRRvJh8
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="151967375"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 06:37:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 06:37:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 06:37:54 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: Add crypto nodes
Date:   Fri, 4 Feb 2022 15:37:51 +0200
Message-ID: <20220204133751.498600-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe and enable the AES, SHA and TDES crypto IPs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7972cb8c2562..1f2731a64139 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -393,6 +393,29 @@ pit64b1: timer@e1804000 {
 			clock-names = "pclk", "gclk";
 		};
 
+		aes: aes@e1810000 {
+			compatible = "atmel,at91sam9g46-aes";
+			reg = <0xe1810000 0x100>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(2)>;
+			dma-names = "tx", "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
+			clock-names = "aes_clk";
+			status = "okay";
+		};
+
+		sha: sha@e1814000 {
+			compatible = "atmel,at91sam9g46-sha";
+			reg = <0xe1814000 0x100>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
+			dma-names = "tx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
+			clock-names = "sha_clk";
+			status = "okay";
+		};
+
 		flx0: flexcom@e1818000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe1818000 0x200>;
@@ -475,6 +498,18 @@ trng: rng@e2010000 {
 			status = "disabled";
 		};
 
+		tdes@e2014000 {
+			compatible = "atmel,at91sam9g46-tdes";
+			reg = <0xe2014000 0x100>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(53)>;
+			dma-names = "tx", "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
+			clock-names = "tdes_clk";
+			status = "okay";
+		};
+
 		flx4: flexcom@e2018000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2018000 0x200>;
-- 
2.25.1

