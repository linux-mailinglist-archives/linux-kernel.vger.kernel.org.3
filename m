Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F84F91E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiDHJUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiDHJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:17:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3E24E27C;
        Fri,  8 Apr 2022 02:12:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2389CUM4085581;
        Fri, 8 Apr 2022 04:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649409150;
        bh=elCJdmY3sfAxfF8zHHCCiGjDa7ESfftTerkXFKvEorE=;
        h=From:To:CC:Subject:Date;
        b=rDnPh6roC+hum0NrVpsDb7T1eP8WU6bkFVqD8lPcvaD+6JHhZ16X16ieQ5kBECuXk
         paLhZKfUlxIAplyWSw/A/qdtoYxWwgiAmG04Nw7rrrj7DsoKLSsrUhhG/U83+aUq6D
         C0ieWmtTGFLaanM4PG2eHDi3hqtrUyuEIEIahWIg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2389CUAM025682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Apr 2022 04:12:30 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Apr 2022 04:12:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Apr 2022 04:12:30 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2389CSgD039327;
        Fri, 8 Apr 2022 04:12:28 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH] arm64: dts: k3-j721e-sk: add CAN-FD transceiver nodes
Date:   Fri, 8 Apr 2022 02:12:08 -0700
Message-ID: <20220408091208.26629-1-mranostay@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add transceiver, and pincontrol definitions for the CAN-FD interfaces
on the J721E Starter Kit (e.g. J1, J2, J5, J6 headers). Additionally,
MCAN interfaces that cannot be accessed are disabled.

Largely based on original work from Amarnath MB <amarnath.mb@ti.com>

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 159 +++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index f25d85169e0d..dc809750c3d5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -213,6 +213,41 @@ dp_pwr_3v3: fixedregulator-dp-prw {
 		enable-active-high;
 	};
 
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mcan0_gpio_pins_default>;
+		standby-gpios = <&main_gpio0 65 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mcan5_gpio_pins_default>;
+		standby-gpios = <&main_gpio0 66 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mcan9_gpio_pins_default>;
+		standby-gpios = <&main_gpio0 67 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -272,6 +307,45 @@ J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
 	};
 
+	main_mcan0_pins_default: main-mcan0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x208, PIN_INPUT, 0) /* (W5) MCAN0_RX */
+			J721E_IOPAD(0x20c, PIN_OUTPUT, 0) /* (W6) MCAN0_TX */
+		>;
+	};
+
+	main_mcan0_gpio_pins_default: main-mcan0-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x108, PIN_INPUT, 7) /* (AD27) PRG0_PRU1_GPO2.GPIO0_65 */
+		>;
+	};
+
+	main_mcan5_pins_default: main-mcan5-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x50, PIN_INPUT, 6) /* (AE21) PRG1_PRU0_GPO18.MCAN5_RX */
+			J721E_IOPAD(0x4c, PIN_OUTPUT, 6) /* (AJ21) PRG1_PRU0_GPO17.MCAN5_TX */
+		>;
+	};
+
+	main_mcan5_gpio_pins_default: main-mcan5-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x10c, PIN_INPUT, 7) /* (AC25) PRG0_PRU1_GPO3.GPIO0_66 */
+		>;
+	};
+
+	main_mcan9_pins_default: main-mcan9-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd0, PIN_INPUT, 6) /* (AC27) PRG0_PRU0_GPO8.MCAN9_RX */
+			J721E_IOPAD(0xcc, PIN_OUTPUT, 6) /* (AC28) PRG0_PRU0_GPO7.MCAN9_TX */
+		>;
+	};
+
+	main_mcan9_gpio_pins_default: main-mcan9-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x110, PIN_INPUT, 7) /* (AD29) PRG0_PRU1_GPO4.GPIO0_67 */
+		>;
+	};
+
 	dp0_pins_default: dp0-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
@@ -385,6 +459,19 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
 	};
 
+	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xac, PIN_INPUT, 0) /* (C29) MCU_MCAN0_RX */
+			J721E_WKUP_IOPAD(0xa8, PIN_OUTPUT, 0) /* (D29) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xbc, PIN_INPUT, 7) /* (F27) WKUP_GPIO0_3 */
+		>;
+	};
+
 	/* Reset for M.2 M Key slot on PCIe1  */
 	mkey_reset_pins_default: mkey-reset-pns-pins-default {
 		pinctrl-single,pins = <
@@ -998,3 +1085,75 @@ &c71_0 {
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "disabled";
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
+
+&main_mcan2 {
+	status = "disabled";
+};
+
+&main_mcan3 {
+	status = "disabled";
+};
+
+&main_mcan4 {
+	status = "disabled";
+};
+
+&main_mcan5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan5_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan6 {
+	status = "disabled";
+};
+
+&main_mcan7 {
+	status = "disabled";
+};
+
+&main_mcan8 {
+	status = "disabled";
+};
+
+&main_mcan9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan9_pins_default>;
+	phys = <&transceiver4>;
+};
+
+&main_mcan10 {
+	status = "disabled";
+};
+
+&main_mcan11 {
+	status = "disabled";
+};
+
+&main_mcan12 {
+	status = "disabled";
+};
+
+&main_mcan13 {
+	status = "disabled";
+};
-- 
2.30.2

