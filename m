Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF409554150
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356820AbiFVELG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356759AbiFVEKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:10:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138933E38
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:25 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1048b8a38bbso4307372fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2lBRiQ83+499zZ6HYPxPX39zS2ryDaEeojdegHG3XI=;
        b=x4x/y5Ydt+XZcf8uo6HXVfmi/EbiZmwg5XCgRkHUGmJDBsRd89YEFxHHkHs7tVINiQ
         jyXVZdlEaX7HMFmy8cj75WOkdRZ7vi+gG+tti5AOTDcUOJUzGFPpiBI4cCt1IdSwDmaB
         kL/mv3Hr0siRyCXUCHwrw6g5O8FrffjC2dZwxhTqHN/YkeuBzlwLTFeIgDgTO7wfE/bm
         bxSsmkMXbcnlIRt2U6j7aboWSWwL/xOxl3rBF6KshC0O3xGyGU7bZNnkMMGHXN4HVjQ+
         7tP660LzyR7a3nuECPPJ22mixt1KY1qLiEIsiY/eOQ+7ImxnmdkM3myOz/DzNBONg87y
         9g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2lBRiQ83+499zZ6HYPxPX39zS2ryDaEeojdegHG3XI=;
        b=f77r7zOQpuJJQQvF0PltvzTcP/vylE+qPXlsyCNRnQMfijSoXAuslrn/Pqi8nnoeg6
         CiLzpO52WHropPAKBQhjmPt0rUaZzVNRljkE08ZhP0iWs5itXWb8utIMmoK9ZCvEKnae
         Si+AsfdESQsNCD8mQxSEHi3Uac9ldwoeVLJp7teAkaw+GisaUqk/Vllt0DkN9D047je7
         tNBipG3AIVyuFvhjtbH1d3CgFSv2cyGWdDgG5oYwH9pmm0gBrVH7nihXZwFORkwRbooi
         krK7rPpyhOtSyO3kQIv4iS5PFi9zMMi2zYooeen/Cn8tx8Fg40BHJww+tjSwxDOCLG/4
         fOUg==
X-Gm-Message-State: AJIora9SkoWUg3BMUrwBwLerA9kDTW5G0cPYgjWT5LhfBYPjwMqEYRxn
        Sz+UkVbb4bSUcjELuq8By9OsLg==
X-Google-Smtp-Source: AGRyM1tjo9cVRRdEkiRm6jUkDlzCXkCbUcBCWcBUUjNnvOwV5PIzm+zggmDy23Kte8D/RN/peHvLDg==
X-Received: by 2002:a05:6870:5247:b0:101:ec40:6a3a with SMTP id o7-20020a056870524700b00101ec406a3amr985948oai.276.1655871025265;
        Tue, 21 Jun 2022 21:10:25 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000f2455e26acsm2314718oaf.48.2022.06.21.21.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:10:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree
Date:   Tue, 21 Jun 2022 21:12:24 -0700
Message-Id: <20220622041224.627803-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622041224.627803-1-bjorn.andersson@linaro.org>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

Add an initial Lenovo Thinkpad X13s devicetree.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changs since v1:
- New patch

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 393 ++++++++++++++++++
 2 files changed, 394 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f416b84b71c..43053f1f6be9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -91,6 +91,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
new file mode 100644
index 000000000000..58d3d8035751
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sc8280xp.dtsi"
+#include "sc8280xp-pmics.dtsi"
+
+/ {
+	model = "Lenovo ThinkPad X13s";
+	compatible = "lenovo,thinkpad-x13s", "qcom,sc8280xp";
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
+	vreg_edp_bl: edp-bl-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VBL9";
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
+	vreg_misc_3p3: misc-3p3-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3B";
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
+
+	reserved-memory {
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
+			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
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
+		vreg_l12c: ldo12 {
+			regulator-name = "vreg_l12c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
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
+	/* FIXME: verify, missing on some x13s */
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
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
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
+	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
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
-- 
2.35.1

