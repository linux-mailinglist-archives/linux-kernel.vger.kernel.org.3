Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6917847BBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhLUIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:18:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40128 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhLUISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:18:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8IK72091887;
        Tue, 21 Dec 2021 02:18:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640074700;
        bh=rrRoEp5WUDOXl107FcGyDyHhbhxUuB0uibMECR059y4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fpXLl/8kK/R3uilVbVYTYmGjgx7GK4gE7v9OGWDLU3YTJRvcI1q3HNVOI6iQko0dc
         r1KVHRmIahATJqBMMIXOGO9SkLq+EhoqfKvGFOowQTKcXG96T+x9Uzyx2tNETT95EY
         rmATzDF0ZyLuVHHShV9of3+XnLgHghcMD9GP6uZk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BL8IKoZ067622
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 02:18:20 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 02:18:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 02:18:20 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BL8I7oC010607;
        Tue, 21 Dec 2021 02:18:18 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 4/5] arm64: dts: ti: Add initial support for J721S2 System on Module
Date:   Tue, 21 Dec 2021 13:48:05 +0530
Message-ID: <20211221081806.7836-5-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221081806.7836-1-a-govindraju@ti.com>
References: <20211221081806.7836-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A System on Module (SoM) contains the SoC, PMIC, DDR and basic high speed
components necessary for functionality. Therefore, add support for the
components present on the SoM.

SoM: https://www.ti.com/lit/zip/sprr439

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 174 +++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
new file mode 100644
index 000000000000..d0657b87d467
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SoM: https://www.ti.com/lit/zip/sprr439
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-j721s2.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		/* 16 GB RAM */
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+		      <0x08 0x80000000 0x03 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	transceiver0: can-phy0 {
+		/* standby pin has been grounded by default */
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+};
+
+&main_pmx0 {
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AH25) I2C0_SCL */
+			J721S2_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AE24) I2C0_SDA */
+		>;
+	};
+
+	main_mcan16_pins_default: main-mcan16-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x028, PIN_INPUT, 0) /* (AB24) MCAN16_RX */
+			J721S2_IOPAD(0x024, PIN_OUTPUT, 0) /* (Y28) MCAN16_TX */
+		>;
+	};
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	exp_som: gpio@21 {
+		compatible = "ti,tca6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB2.0_MUX_SEL", "CANUART_MUX1_SEL0",
+				  "CANUART_MUX2_SEL0", "CANUART_MUX_SEL1",
+				  "GPIO_RGMII1_RST", "GPIO_eDP_ENABLE",
+				   "GPIO_LIN_EN", "CAN_STB";
+	};
+};
+
+&main_mcan16 {
+	pinctrl-0 = <&main_mcan16_pins_default>;
+	pinctrl-names = "default";
+	phys = <&transceiver0>;
+};
+
+&mailbox0_cluster0 {
+	status = "disabled";
+};
+
+&mailbox0_cluster1 {
+	status = "disabled";
+};
+
+&mailbox0_cluster2 {
+	status = "disabled";
+};
+
+&mailbox0_cluster3 {
+	status = "disabled";
+};
+
+&mailbox0_cluster4 {
+	status = "disabled";
+};
+
+&mailbox0_cluster5 {
+	status = "disabled";
+};
+
+&mailbox0_cluster6 {
+	status = "disabled";
+};
+
+&mailbox0_cluster7 {
+	status = "disabled";
+};
+
+&mailbox0_cluster8 {
+	status = "disabled";
+};
+
+&mailbox0_cluster9 {
+	status = "disabled";
+};
+
+&mailbox0_cluster10 {
+	status = "disabled";
+};
+
+&mailbox0_cluster11 {
+	status = "disabled";
+};
+
+&mailbox1_cluster0 {
+	status = "disabled";
+};
+
+&mailbox1_cluster1 {
+	status = "disabled";
+};
+
+&mailbox1_cluster2 {
+	status = "disabled";
+};
+
+&mailbox1_cluster3 {
+	status = "disabled";
+};
+
+&mailbox1_cluster4 {
+	status = "disabled";
+};
+
+&mailbox1_cluster5 {
+	status = "disabled";
+};
+
+&mailbox1_cluster6 {
+	status = "disabled";
+};
+
+&mailbox1_cluster7 {
+	status = "disabled";
+};
+
+&mailbox1_cluster8 {
+	status = "disabled";
+};
+
+&mailbox1_cluster9 {
+	status = "disabled";
+};
+
+&mailbox1_cluster10 {
+	status = "disabled";
+};
+
+&mailbox1_cluster11 {
+	status = "disabled";
+};
-- 
2.17.1

