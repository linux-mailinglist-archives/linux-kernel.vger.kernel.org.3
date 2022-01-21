Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE5495FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350681AbiAUNRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:17:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17486 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380648AbiAUNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642771038; x=1674307038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xxbMoJxEUM+uShIZyq7n+TJzFaS64VgMHwwQZqkOs6k=;
  b=0LmiBciTlew/XcOizTYrHjiAi3FpHYtOtfd4Hv+lqsyShHtSYKZy84fZ
   MtcbAL1bo0KN3d1XSziSAW8RbI6GVgCkrS6Va3Ox2ip26AimACVnw5CHE
   e6Mq5xy8OOhERxoDd3y+kOrCfSsH7xCBnmle2v9RzXduJlUqFOZN/2AZg
   PcT4+RCbNjUFnx97L5kdvOgcgqf9vT6xgMz+HDxzB9cl+1Q1Td6issRia
   EvrhDYhvvGhFrJa8QDQCa1kWnRtT77XT7ucGvhAfGH5lgST34XswrsArC
   Jrev0kJVNtMrIE3j7MnL0ZDr6ZYwcZvly9DNQ+wVL5X5VZXig8eA6kEwi
   A==;
IronPort-SDR: I1DGNUQlB37qdbzJOhof03GFpJY5c2bnFbYRAbEThE59g3m/y8SXg4Mg5cJMRn3L+SpLL/zgxI
 zfJ9QRMk+Jly8ImzJfnYqGwWaQJI5qjXCBoIfvv2IufnhPpp1CAXuuurO9YAg7+siY00ch/DVV
 fHRzymCC5lyGcK6D7JLOs6CNnaEi/axi2rSq4ckoUY6NdL3CY6vgmEqJ9aXlQSzX6wVeuSv+C7
 Ar7OHcvD4/yZpEVcDRRrPAAZCM9sodoJk3GnP+SxizXrWc1xo+qbPIRE3T8m/YEH3DdvOSAmjY
 1UH25GAM/V28uSrHUCnRlHIR
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="146183497"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:17:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:17:17 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:16:58 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 09/11] ARM: dts: at91: sama7g5: add nodes for video capture
Date:   Fri, 21 Jan 2022 15:14:14 +0200
Message-ID: <20220121131416.603972-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the XISC (eXtended Image Sensor Controller) and CSI2DC
(csi2 demux controller).
These nodes represent the top level of the video capture hardware pipeline
and are directly connected in hardware.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v4:
- add mandatory property bus type

Changes in v3:
- change bus width for endpoints to the default 14

 arch/arm/boot/dts/sama7g5.dtsi | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 7039311bf678..d47d62f01895 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -236,6 +236,55 @@ sdmmc2: mmc@e120c000 {
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

