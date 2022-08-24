Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194FB59F3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiHXGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiHXGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:51:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2487F0B6;
        Tue, 23 Aug 2022 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661323909; x=1692859909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i089sQETkF6czyTsAQidiBQG3A22dMjUG/Oyhy6+DLA=;
  b=HM8KXEPzzSTBCKv+8DQE++sirJIFQUrGMw6yFK+G0jVmOukl4gC4uvPS
   hClCelRlrXgq/u7w8Kut8LDxQ7DhwwOshksDWRAY6IVd8mqp+qIV06m2v
   UKSbVVpl/vwcDieNkCUIOKpEqEslXR/y17XCuY2/QYZfv5jpi8O7LvAl6
   um+paUywiq8OP/lHkXnpkgsnWNGs+6LB+ulj3+svldyot/Wu6anm4MV/R
   WL9w0T9bwIGXVVKm7/O0s57kF8zDMHWIgAHUYGGKO41fMFfS+l9A/qve8
   tlHyLjoQUy/zZ9Aq7wJIYMUjYzMUdAOQtVCp5hbjZ8vm5MFkThNic9k2Q
   A==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="170673958"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 23:51:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 23:51:35 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 23 Aug 2022 23:51:32 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v3] ARM: dts: lan966x: add support for pcb8290
Date:   Wed, 24 Aug 2022 08:55:27 +0200
Message-ID: <20220824065527.157334-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for pcb8290. It has 2 lan8814 phys(each phy is a
quad-port) on the external MDIO bus and no SFP ports.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v2->v3:
- update coma-mode-gpios, set them to OPEN_DRAIN

v1->v2:
- add comments for pps_out_pins and ptp_ext_pins pins
- fix commit message.
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/lan966x-pcb8290.dts | 171 ++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 arch/arm/boot/dts/lan966x-pcb8290.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..595e870750cd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -788,6 +788,7 @@ dtb-$(CONFIG_SOC_IMXRT) += \
 dtb-$(CONFIG_SOC_LAN966) += \
 	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
 	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
+	lan966x-pcb8290.dtb \
 	lan966x-pcb8291.dtb \
 	lan966x-pcb8309.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/lan966x-pcb8290.dts
new file mode 100644
index 000000000000..3d93049fdf57
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-pcb8290.dts
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x_pcb8290.dts - Device Tree file for PCB8290
+ */
+/dts-v1/;
+#include "lan966x.dtsi"
+#include "dt-bindings/phy/phy-lan966x-serdes.h"
+
+/ {
+	model = "Microchip EVB LAN9668";
+	compatible = "microchip,lan9668-pcb8290", "microchip,lan9668", "microchip,lan966";
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
+		priority = <200>;
+	};
+};
+
+&gpio {
+	miim_a_pins: mdio-pins {
+		/* MDC, MDIO */
+		pins =  "GPIO_28", "GPIO_29";
+		function = "miim_a";
+	};
+
+	pps_out_pins: pps-out-pins {
+		/* 1pps output */
+		pins = "GPIO_38";
+		function = "ptpsync_3";
+	};
+
+	ptp_ext_pins: ptp-ext-pins {
+		/* 1pps input */
+		pins = "GPIO_35";
+		function = "ptpsync_0";
+	};
+
+	udc_pins: ucd-pins {
+		/* VBUS_DET B */
+		pins = "GPIO_8";
+		function = "usb_slave_b";
+	};
+};
+
+&mdio0 {
+	pinctrl-0 = <&miim_a_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ext_phy0: ethernet-phy@7 {
+		reg = <7>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy1: ethernet-phy@8 {
+		reg = <8>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy2: ethernet-phy@9 {
+		reg = <9>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy3: ethernet-phy@10 {
+		reg = <10>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy4: ethernet-phy@15 {
+		reg = <15>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy5: ethernet-phy@16 {
+		reg = <16>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy6: ethernet-phy@17 {
+		reg = <17>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+
+	ext_phy7: ethernet-phy@18 {
+		reg = <18>;
+		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
+	};
+};
+
+&port0 {
+	reg = <2>;
+	phy-handle = <&ext_phy2>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 0 SERDES6G(1)>;
+	status = "okay";
+};
+
+&port1 {
+	reg = <3>;
+	phy-handle = <&ext_phy3>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 1 SERDES6G(1)>;
+	status = "okay";
+};
+
+&port2 {
+	reg = <0>;
+	phy-handle = <&ext_phy0>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 2 SERDES6G(1)>;
+	status = "okay";
+};
+
+&port3 {
+	reg = <1>;
+	phy-handle = <&ext_phy1>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 3 SERDES6G(1)>;
+	status = "okay";
+};
+
+&port4 {
+	reg = <6>;
+	phy-handle = <&ext_phy6>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 4 SERDES6G(2)>;
+	status = "okay";
+};
+
+&port5 {
+	reg = <7>;
+	phy-handle = <&ext_phy7>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 5 SERDES6G(2)>;
+	status = "okay";
+};
+
+&port6 {
+	reg = <4>;
+	phy-handle = <&ext_phy4>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 6 SERDES6G(2)>;
+	status = "okay";
+};
+
+&port7 {
+	reg = <5>;
+	phy-handle = <&ext_phy5>;
+	phy-mode = "qsgmii";
+	phys = <&serdes 7 SERDES6G(2)>;
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
+&switch {
+	pinctrl-0 = <&pps_out_pins>, <&ptp_ext_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&udc {
+	pinctrl-0 = <&udc_pins>;
+	pinctrl-names = "default";
+	atmel,vbus-gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.33.0

