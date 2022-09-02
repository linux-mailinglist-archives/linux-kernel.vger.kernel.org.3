Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555E5AA7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiIBGUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiIBGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:20:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1C50073;
        Thu,  1 Sep 2022 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662099637; x=1693635637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ym7YRYwYyvDY9fhkvBA5UnV1wOMfAoiNYtaQ4wfiJyg=;
  b=swzBitQtxnSSgcqZIdp1a4k4xWvWmJcIa3skXDOKzFVwJXCODwrYqULP
   bCBPwNObw2rmiD+zE8tZedCVsUCio39EJrSJ+fem2SNJ8edmKaREHQxZZ
   /XURA9qKj1zhP0utPla1ayVBzOSuhEjQyMleCRzRJJr9G9vF/+9uJ1EZh
   EbZn2LwsOb/GOXGjAT02g8iuJmk/r1B8hkK+FRl5Rla2l9EPZP5AuqHyk
   +22WGbYNtKz+1qiAbThgmz+zyIuTEl/ScSTU//6OHupL1DQNjTodoBxbL
   +GAiTVoZQhXiq0l8enVuivFDCOkBjVXGVUrXJhN9qiY33XNFw7oP+dqxm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="111872642"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 23:20:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 23:20:36 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 23:20:34 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2] ARM: dts: lan966x: add led configuration
Date:   Fri, 2 Sep 2022 08:24:47 +0200
Message-ID: <20220902062447.443846-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add led configuration for pcb8291 and pcb8309. Both pcbs have 4 leds which
are connected to the sgpio controller.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- remove status from the leds node as default is okay
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 28 +++++++++++++++++++++++++++
 arch/arm/boot/dts/lan966x-pcb8309.dts | 28 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 24d9055c4a08..289a31649422 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -23,6 +23,34 @@ gpio-restart {
 		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 		priority = <200>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-s0-blue {
+			label = "s0:blue";
+			gpios = <&sgpio_out 2 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s0-green {
+			label = "s0:green";
+			gpios = <&sgpio_out 2 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-blue {
+			label = "s1:blue";
+			gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-green {
+			label = "s1:green";
+			gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
 };
 
 &gpio {
diff --git a/arch/arm/boot/dts/lan966x-pcb8309.dts b/arch/arm/boot/dts/lan966x-pcb8309.dts
index 05ce27ed5648..cfd7c8933703 100644
--- a/arch/arm/boot/dts/lan966x-pcb8309.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8309.dts
@@ -42,6 +42,34 @@ i2c103: i2c-sfp@2 {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-s0-green {
+			label = "s0:green";
+			gpios = <&sgpio_out 2 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s0-red {
+			label = "s0:red";
+			gpios = <&sgpio_out 2 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-green {
+			label = "s1:green";
+			gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-s1-red {
+			label = "s1:red";
+			gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
 	mux: mux-controller {
 		compatible = "gpio-mux";
 		#mux-control-cells = <0>;
-- 
2.33.0

