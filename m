Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25D4D36B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiCIQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A9EDF28;
        Wed,  9 Mar 2022 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646844021; x=1678380021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPz0O/j6T/R5IOZ/0HdGMFHbVlsAXUy78/qaH+crieA=;
  b=dx5F9qc1ro7xXhENcK3+nLT0hRREb2N67Yj30Q5ooaBf0XLzZMLJGnIL
   qSQYb2Er3brkGhS2QUBOezC6x7uOE0H2/ihI6tSXJP0axa6f8BH4cJVvk
   YfFGfhdCFgI69F1/MgXJqFDt9yJNpz4tc3cNzsctf1C8M2YuKuxXIQlMN
   wrTFAoSYqg24+b5HkjDqeLsHg5kn+R2hALojZBUR8bFX/2IG9lk0IJqd2
   GpDn3rmnVt7lgk84HA4OH350dqKObOYXyd8tXKQKQCcukstkzu4O+zkcr
   8kWXguu37vK8pWvc35OYlafIeXlLR/hOZS+g4MBj66dbgEmHJur+O7xlB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148643235"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 09:40:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 09:40:19 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 09:40:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v8 11/13] ARM: dts: at91: sama7g5: add nodes for video capture
Date:   Wed, 9 Mar 2022 18:37:56 +0200
Message-ID: <20220309163758.2672727-12-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309163758.2672727-1-eugen.hristev@microchip.com>
References: <20220309163758.2672727-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the XISC (eXtended Image Sensor Controller) and CSI2DC
(csi2 demux controller).
These nodes represent the top level of the video capture hardware pipeline
and are directly connected in hardware.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..de43f854ce47 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -266,6 +266,55 @@ sdmmc2: mmc@e120c000 {
 			status = "disabled";
 		};
 
+		csi2dc: csi2dc@e1404000 {
+			compatible = "microchip,sama7g5-csi2dc";
+			reg = <0xe1404000 0x500>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&xisc>;
+			clock-names = "pclk", "scck";
+			assigned-clocks = <&xisc>;
+			assigned-clock-rates = <266000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					csi2dc_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					csi2dc_out: endpoint {
+						bus-width = <14>;
+						hsync-active = <1>;
+						vsync-active = <1>;
+						remote-endpoint = <&xisc_in>;
+					};
+				};
+			};
+		};
+
+		xisc: xisc@e1408000 {
+			compatible = "microchip,sama7g5-isc";
+			reg = <0xe1408000 0x2000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 56>;
+			clock-names = "hclock";
+			#clock-cells = <0>;
+			clock-output-names = "isc-mck";
+
+			port {
+				xisc_in: endpoint {
+					bus-type = <5>; /* Parallel */
+					bus-width = <14>;
+					hsync-active = <1>;
+					vsync-active = <1>;
+					remote-endpoint = <&csi2dc_out>;
+				};
+			};
+		};
+
 		pwm: pwm@e1604000 {
 			compatible = "microchip,sama7g5-pwm", "atmel,sama5d2-pwm";
 			reg = <0xe1604000 0x4000>;
-- 
2.25.1

