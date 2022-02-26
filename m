Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897024C5524
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiBZKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:21:02 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE431EDA03;
        Sat, 26 Feb 2022 02:20:28 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 02483C8606;
        Sat, 26 Feb 2022 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645870827; bh=BBTPR8ndkMJKzpJc4293l6J8Otn5feMmw3gXpcNORDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hK04Tbp110tYvso8tQ7qoodu6F9dvH7vbcPoOuTYIKvaGoWSB51/Fx/aPWNzrE4TO
         Rve3F4TLP0Jq2D+q6OEeFU3Zyco66Fpejyt7qumPwEivxTJ+BgaqkMzxlsQrl1Q8EG
         H9jms7yd4fuf3M7KqVCwDGniPg7nqfmdCj5paRH0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: qcom: Add support for ASUS ZenWatch 2
Date:   Sat, 26 Feb 2022 11:19:39 +0100
Message-Id: <20220226101939.1011551-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226101939.1011551-1-luca@z3ntu.xyz>
References: <20220226101939.1011551-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this smartwatch, based on Snapdragon 400 SoC.

Currently supported functionality:
* Internal storage
* USB
* Charger
* Power button
* Vibration motor
* Bluetooth
* Wifi

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Please note that this patch soft-depends on "Bluetooth: hci_bcm: add
BCM43430A0 & BCM43430A1" which I sent out yesterday.

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/qcom-apq8026-asus-sparrow.dts    | 294 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8226.dtsi           |   9 +
 3 files changed, 304 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 235ad559acb2..4b2489580f7c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -967,6 +967,7 @@ dtb-$(CONFIG_ARCH_OXNAS) += \
 	ox820-cloudengines-pogoplug-series-3.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8016-sbc.dtb \
+	qcom-apq8026-asus-sparrow.dtb \
 	qcom-apq8026-lg-lenok.dtb \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
new file mode 100644
index 000000000000..ace8cea27949
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Luca Weiss <luca@z3ntu.xyz>
+ */
+
+/dts-v1/;
+
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/ {
+	model = "ASUS ZenWatch 2";
+	compatible = "asus,sparrow", "qcom,apq8026";
+	chassis-type = "watch";
+	qcom,msm-id = <199 0x20000>;
+	qcom,board-id = <8 3005>;
+
+	reserved-memory {
+		sbl_region: sbl@2f00000 {
+			reg = <0x02f00000 0x100000>;
+			no-map;
+		};
+		external_image_region: external-image@3100000 {
+			reg = <0x3100000 0x200000>;
+			no-map;
+		};
+		peripheral_region: peripheral@3300000 {
+			reg = <0x3300000 0x600000>;
+			no-map;
+		};
+		adsp_region: adsp@3900000 {
+			reg = <0x3900000 0x1400000>;
+			no-map;
+		};
+		modem_region: modem@4d00000 {
+			reg = <0x4d00000 0x1b00000>;
+			no-map;
+		};
+		modem_efs_region: modem-efs@7f00000 {
+			reg = <0x7f00000 0x100000>;
+			no-map;
+		};
+	};
+
+	vreg_wlan: wlan-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_regulator_default_state>;
+	};
+};
+
+&blsp1_uart1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart1_default_state>;
+
+	bluetooth {
+		compatible = "brcm,bcm43430a1-bt";
+		max-speed = <3000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bluetooth_default_state>;
+
+		host-wakeup-gpios = <&tlmm 48 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&pm8226_vib {
+	status = "okay";
+};
+
+&rpm_requests {
+	pm8226-regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
+		};
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+		};
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <1900000>;
+		};
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+};
+
+&sdhc_3 {
+	status = "okay";
+
+	max-frequency = <100000000>;
+	non-removable;
+
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi@1 {
+		compatible = "brcm,bcm43430a1-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupts-extended = <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_hostwake_default_state>;
+	};
+};
+
+&smbb {
+	qcom,fast-charge-safe-current = <1500000>;
+	qcom,fast-charge-current-limit = <350000>;
+	qcom,fast-charge-safe-voltage = <4430000>;
+	qcom,fast-charge-high-threshold-voltage = <4400000>;
+	qcom,auto-recharge-threshold-voltage = <4300000>;
+	qcom,minimum-input-voltage = <4400000>;
+};
+
+&tlmm {
+	blsp1_uart1_default_state: blsp1-uart1-default-state {
+		pins = "gpio0", "gpio1", "gpio2", "gpio3";
+		function = "blsp_uart1";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	bluetooth_default_state: bluetooth-default-state {
+		pins = "gpio48", "gpio61";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+		input-enable;
+	};
+
+	wlan_hostwake_default_state: wlan-hostwake-default-state {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	wlan_regulator_default_state: wlan-regulator-default-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	status = "okay";
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index dfeb47eb41a2..e24e53438b4d 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -153,6 +153,15 @@ sdhc_3: sdhci@f9864900 {
 			status = "disabled";
 		};
 
+		blsp1_uart1: serial@f991d000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xf991d000 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart3: serial@f991f000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991f000 0x1000>;
-- 
2.35.1

