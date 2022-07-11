Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE655F4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiF2EMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF2EME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:12:04 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE7369D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:12:00 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101bb9275bcso19811214fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HMYYTN88DYUg0TqSkYO4pYhwtQEbXyeJTSUIQXxVaA=;
        b=VP3ERZhO29KqNsMW3q4AYFrgigWCFF1DOFXMQZBD3RWQ12zb3v+c/1AnJkOOOThh3A
         HTDGttvIxP1RtXxn70fYXDK7d+bYCZu5kqwx2DlKrUm1rcz3djwO0xKVMFlYaLsR+pty
         OlhmGy4TuOOdccoL8rwPxoa82iaFbk4Xu3M8rLHPdj4NMAiX8vqIXwAq43qWR7sT4L0B
         RCCCfZPVbS8SlRFHqEXmPjoebBrmFS24PdJ6JDY5zbv0vCfxhyVSlckG3x8CcmJlgTLv
         syjtmpOws5rNPjT6UnY4377SRMJ01ijSijrFyr8TrCC01iDcdEjEZJtLNk0WwAshvuqu
         7D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HMYYTN88DYUg0TqSkYO4pYhwtQEbXyeJTSUIQXxVaA=;
        b=LbPvgkue5Vq3wZCgIcBzOW6QItgqtsHKEL4X2j3N3AYKfqLUXxCs9DCGgz/tALgacv
         S0DcsEEbBuEMvVQxm5AK6U4j/0Ql7Vu8P+KtOapvHUaH4Ur3PZGZLHERLjNa+/9LFSfE
         b9bZLJrr7/bIh7Okpx5wnZHc2ODDkdB9392NYkxeV+VkmIB4m6pBbap2MsRRdmNiyiZN
         AdOvFynqazwCohiWPLTccRSmPFXWWus+GE6Mik65cu38d0Q86ohQjjqkAzCeSQKd2ygV
         aoFgJ82SfLOYnXqSo22Tiv3LJG2bS88xIJxTFUf+6jjS5rRiHE9y2Yrvt3T9Y5GIvZi/
         BVBQ==
X-Gm-Message-State: AJIora+0kCblFnQiYMVND158HDQn/a/YJXtXHvu1VHKV5dXivd2getXb
        Sm2MUWdEA4NSlVtY0wELxzLRMw==
X-Google-Smtp-Source: AGRyM1tTeVK6SHPvFxCo0hWobZ1splZD3aFjacoVCuVB6OBAaandBJtRIvQl4qWPaISZg8iSCdn1Rw==
X-Received: by 2002:a05:6870:1696:b0:101:d9d7:e878 with SMTP id j22-20020a056870169600b00101d9d7e878mr1810869oae.32.1656475919461;
        Tue, 28 Jun 2022 21:11:59 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b00616ec82b29bsm1578692otf.35.2022.06.28.21.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 21:11:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 4/5] arm64: dts: qcom: sc8280xp: Add reference device
Date:   Tue, 28 Jun 2022 21:14:37 -0700
Message-Id: <20220629041438.1352536-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
References: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the SC8280XP reference device, which allows it to
boot to a shell (using EFIFB) with functional storage (UFS), USB,
keyboard, touchpad, touchscreen, backlight and remoteprocs.

The PMICs are, per socinfo, reused from other platforms. But given that
the address of the PMICs doesn't match other cases and that it's
desirable to label things according to the schematics a new dtsi file is
created to represent the reference combination of PMICs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes since v2:
- Fixed sort order of &xo_board_clk
- Dropped unused includes
- Moved regulator suffix to prefix for edp-bl and misc_3p3
- Dropped empty reserved-memory node

 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts    | 427 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 109 +++++
 3 files changed, 537 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..ceeae094a59f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
new file mode 100644
index 000000000000..45058ad0a1c8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sc8280xp.dtsi"
+#include "sc8280xp-pmics.dtsi"
+
+/ {
+	model = "Qualcomm SC8280XP CRD";
+	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";
+
+	aliases {
+		serial0 = &qup2_uart17;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pmc8280c_lpg 3 1000000>;
+		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vreg_edp_bl>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	vreg_edp_bl: regulator-edp-bl {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_BL";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+
+		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_reg_en>;
+
+		regulator-boot-on;
+	};
+
+	vreg_misc_3p3: regulator-misc-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_MISC_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&misc_3p3_reg_en>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&apps_rsc {
+	pmc8280-1-rpmh-regulators {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-l3-l5-supply = <&vreg_s11b>;
+
+		vreg_s11b: smps11 {
+			regulator-name = "vreg_s11b";
+			regulator-min-microvolt = <1272000>;
+			regulator-max-microvolt = <1272000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3b: ldo3 {
+			regulator-name = "vreg_l3b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vreg_l4b: ldo4 {
+			regulator-name = "vreg_l4b";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6b: ldo6 {
+			regulator-name = "vreg_l6b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+	};
+
+	pmc8280c-rpmh-regulators {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l13c: ldo13 {
+			regulator-name = "vreg_l13c";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmc8280-2-rpmh-regulators {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		vdd-l1-l4-supply = <&vreg_s11b>;
+
+		vreg_l3d: ldo3 {
+			regulator-name = "vreg_l3d";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l4d: ldo4 {
+			regulator-name = "vreg_l4d";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6d: ldo6 {
+			regulator-name = "vreg_l6d";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7d: ldo7 {
+			regulator-name = "vreg_l7d";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l9d: ldo9 {
+			regulator-name = "vreg_l9d";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&pmc8280c_lpg {
+	status = "okay";
+};
+
+&pmk8280_pon_pwrkey {
+	status = "okay";
+};
+
+&qup0 {
+	status = "okay";
+};
+
+&qup0_i2c4 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
+
+	status = "okay";
+
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+	};
+};
+
+&qup1 {
+	status = "okay";
+};
+
+&qup2 {
+	status = "okay";
+};
+
+&qup2_i2c5 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+	};
+
+	keyboard@68 {
+		compatible = "hid-over-i2c";
+		reg = <0x68>;
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+	};
+};
+
+&qup2_uart17 {
+	compatible = "qcom,geni-debug-uart";
+
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_nsp0 {
+	firmware-name = "qcom/sc8280xp/qccdsp8280.mbn";
+
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l3d>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l6b>;
+	vdda-pll-supply = <&vreg_l3b>;
+
+	status = "okay";
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "host";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l9d>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l7d>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l9d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l4b>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l13c>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l4b>;
+	vdda-pll-supply = <&vreg_l3b>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
+
+/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
+
+&pmc8280_1_gpios {
+	edp_bl_en: edp-bl-en-state {
+		pins = "gpio8";
+		function = "normal";
+	};
+
+	edp_bl_reg_en: edp-bl-reg-en-state {
+		pins = "gpio9";
+		function = "normal";
+	};
+
+	misc_3p3_reg_en: misc-3p3-reg-en-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
+&pmc8280c_gpios {
+	edp_bl_pwm: edp-bl-pwm-state {
+		pins = "gpio8";
+		function = "func1";
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
+
+	kybd_default: kybd-default-state {
+		disable {
+			pins = "gpio102";
+			function = "gpio";
+			output-low;
+		};
+
+		int-n {
+			pins = "gpio104";
+			function = "gpio";
+			bias-disable;
+		};
+
+		reset {
+			pins = "gpio105";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	qup0_i2c4_default: qup0-i2c4-default-state {
+		pins = "gpio171", "gpio172";
+		function = "qup4";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
+	qup2_i2c5_default: qup2-i2c5-default-state {
+		pins = "gpio81", "gpio82";
+		function = "qup21";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
+	tpad_default: tpad-default-state {
+		int-n {
+			pins = "gpio182";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	ts0_default: ts0-default-state {
+		int-n {
+			pins = "gpio175";
+			function = "gpio";
+			bias-pull-up;
+		};
+
+		reset-n {
+			pins = "gpio99";
+			function = "gpio";
+			output-high;
+			drive-strength = <16>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
new file mode 100644
index 000000000000..ae90b97aecb8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmk8280: pmic@0 {
+		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmk8280_pon: pon@1300 {
+			compatible = "qcom,pm8998-pon";
+			reg = <0x1300>;
+
+			pmk8280_pon_pwrkey: pwrkey {
+				compatible = "qcom,pmk8350-pwrkey";
+				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				status = "disabled";
+			};
+		};
+	};
+
+	pmc8280_1: pmic@1 {
+		compatible = "qcom,pm8350", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmc8280_1_gpios: gpio@8800 {
+			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmc8280_1_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmc8280c: pmic@2 {
+		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmc8280c_gpios: gpio@8800 {
+			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmc8280c_gpios 0 0 9>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmc8280c_lpg: lpg@e800 {
+			compatible = "qcom,pm8350c-pwm";
+			reg = <0xe800>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+	};
+
+	pmc8280_2: pmic@3 {
+		compatible = "qcom,pm8350", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmc8280_2_gpios: gpio@8800 {
+			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmc8280_2_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmr735a: pmic@4 {
+		compatible = "qcom,pmr735a", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmr735a_gpios: gpio@8800 {
+			compatible = "qcom,pmr735a-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmr735a_gpios 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.35.1

