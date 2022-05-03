Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6823D5181B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiECJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiECJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:56:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240334B99;
        Tue,  3 May 2022 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651571553; x=1683107553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNHm10rt5V80Sp41Q9FtUMsR+uyoYpn2wc8CZHNDVOI=;
  b=tcCgkdIkGT7ldjHgr6T2OOvbGWOFPKzLchsmCsLi6+YtzXDr3/EvuaB/
   Muu1efKupfomcS6nqhedu/+1m6LOvcCPngeE9ENUQBxgU/lNeaBK5XNz4
   URSS+JY4bdYDm3Aenw9blO3ayLJ3OGW9gXCseQ01CJQUdccQ5bpQ8E3wU
   XefWqCIOiKN1BI8n7abWRBhQGrLt9kd72WBUXK1U6tef6qkiaUy1vvV6D
   D1wYBanqxe6nyMzeclVdMKtbGhEDxBYeGLsCf1+6FsRdK6+iWfqW03Lxr
   ms9vIDDxukp163EW32wm7miC/Q0CAEY8GzAQ5B/PTpyAL8dCtWMmOzLTa
   A==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="94364004"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 02:52:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 02:52:31 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 02:52:18 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <jacopo@jmondi.org>, Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video capture
Date:   Tue, 3 May 2022 12:51:25 +0300
Message-ID: <20220503095127.48710-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503095127.48710-1-eugen.hristev@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
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

Add node for the XISC (eXtended Image Sensor Controller) and CSI2DC
(csi2 demux controller).
These nodes represent the top level of the video capture hardware pipeline
and are directly connected in hardware.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v10:
- nodes disabled by default

 arch/arm/boot/dts/sama7g5.dtsi | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 4decd3a91a76..fe9c6df9819b 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -454,6 +454,57 @@ sdmmc2: mmc@e120c000 {
 			status = "disabled";
 		};
 
+		csi2dc: csi2dc@e1404000 {
+			compatible = "microchip,sama7g5-csi2dc";
+			reg = <0xe1404000 0x500>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&xisc>;
+			clock-names = "pclk", "scck";
+			assigned-clocks = <&xisc>;
+			assigned-clock-rates = <266000000>;
+			status = "disabled";
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
+			status = "disabled";
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

