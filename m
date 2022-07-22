Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9C57E315
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiGVOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:32:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76033E13;
        Fri, 22 Jul 2022 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658500373; x=1690036373;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cJhcrvwQUUUB2Iut1TzfM6T9V9OhuYYecIuSJe9l/z4=;
  b=EFocGkY94w/tS4v0dbVtEnLDUJ9qS8YOtlKcsBTJHnQWMuKr+qH4JdGV
   1yNfjFMrnh5dMHPZiFUeGIiu3f9hUJquabn8MqWX4+UcQJU+d504qFRyn
   C2zhMJZbjq351Mc7aWCIhuAls55ZH2hcHG4u33L8dGIBxpl0Nmb6Wo0St
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jul 2022 07:32:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 07:32:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 07:32:52 -0700
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 07:32:49 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sa8295p: move common nodes to dtsi
Date:   Fri, 22 Jul 2022 20:02:32 +0530
Message-ID: <20220722143232.7903-1-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many ADP boards with lot of common features. Move common
nodes to sa8xxxp-auto.dtsi files. This will be base for many ADP boards
to be introduced in near future.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
---

Changes since v1:
- Add , after year 2022, in the license header
- Rename the dtsi which is suitable for common to many ADP boards
- Split the patch in introducing common dtsi file, and adding new board
  file

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
 .../arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi | 385 ++++++++++++++++++
 2 files changed, 387 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 9398f0349944..3cc92162ba02 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -2,388 +2,14 @@
 /*
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/spmi/spmi.h>
-
-#include "sa8540p.dtsi"
+#include "sa8xxxp-auto-adp.dtsi"
 
 / {
 	model = "Qualcomm SA8295P ADP";
 	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
-
-	aliases {
-		serial0 = &qup2_uart17;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&apps_rsc {
-	pmm8540-a-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "a";
-
-		vreg_l3a: ldo3 {
-			regulator-name = "vreg_l3a";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l5a: ldo5 {
-			regulator-name = "vreg_l5a";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7a: ldo7 {
-			regulator-name = "vreg_l7a";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l13a: ldo13 {
-			regulator-name = "vreg_l13a";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pmm8540-c-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "c";
-
-		vreg_l1c: ldo1 {
-			regulator-name = "vreg_l1c";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l2c: ldo2 {
-			regulator-name = "vreg_l2c";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l3c: ldo3 {
-			regulator-name = "vreg_l3c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l4c: ldo4 {
-			regulator-name = "vreg_l4c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l6c: ldo6 {
-			regulator-name = "vreg_l6c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7c: ldo7 {
-			regulator-name = "vreg_l7c";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l10c: ldo10 {
-			regulator-name = "vreg_l10c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l17c: ldo17 {
-			regulator-name = "vreg_l17c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pmm8540-g-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "g";
-
-		vreg_l3g: ldo3 {
-			regulator-name = "vreg_l3g";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7g: ldo7 {
-			regulator-name = "vreg_l7g";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l8g: ldo8 {
-			regulator-name = "vreg_l8g";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-};
-
-&qup2 {
-	status = "okay";
-};
-
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-	status = "okay";
-};
-
-&remoteproc_adsp {
-	firmware-name = "qcom/sa8540p/adsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp0 {
-	firmware-name = "qcom/sa8540p/cdsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp1 {
-	firmware-name = "qcom/sa8540p/cdsp1.mbn";
-	status = "okay";
-};
-
-&spmi_bus {
-	pm8450a: pmic@0 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450a_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450c: pmic@4 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x4 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450c_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450e: pmic@8 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x8 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450e_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450g: pmic@c {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0xc SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450g_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-};
-
-&ufs_mem_hc {
-	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l17c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l6c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_mem_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
 };
-
-&ufs_card_hc {
-	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l10c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l3c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_card_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
-};
-
-&usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "peripheral";
-};
-
-&usb_0_hsphy {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7a>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_0_qmpphy {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "host";
-};
-
-&usb_1_hsphy {
-	vdda-pll-supply = <&vreg_l1c>;
-	vdda18-supply = <&vreg_l7c>;
-	vdda33-supply = <&vreg_l2c>;
-
-	status = "okay";
-};
-
-&usb_1_qmpphy {
-	vdda-phy-supply = <&vreg_l4c>;
-	vdda-pll-supply = <&vreg_l1c>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy0 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy1 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy2 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy3 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy0 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy1 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
-/* PINCTRL */
diff --git a/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi b/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
new file mode 100644
index 000000000000..428e10f48481
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+
+#include "sa8540p.dtsi"
+
+/ {
+	aliases {
+		serial0 = &qup2_uart17;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&apps_rsc {
+	pmm8540-a-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_l3a: ldo3 {
+			regulator-name = "vreg_l3a";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l5a: ldo5 {
+			regulator-name = "vreg_l5a";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7a: ldo7 {
+			regulator-name = "vreg_l7a";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l13a: ldo13 {
+			regulator-name = "vreg_l13a";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmm8540-c-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l3c: ldo3 {
+			regulator-name = "vreg_l3c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l4c: ldo4 {
+			regulator-name = "vreg_l4c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6c: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l10c: ldo10 {
+			regulator-name = "vreg_l10c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l17c: ldo17 {
+			regulator-name = "vreg_l17c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmm8540-g-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "g";
+
+		vreg_l3g: ldo3 {
+			regulator-name = "vreg_l3g";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7g: ldo7 {
+			regulator-name = "vreg_l7g";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l8g: ldo8 {
+			regulator-name = "vreg_l8g";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&qup2 {
+	status = "okay";
+};
+
+&qup2_uart17 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8540p/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp0 {
+	firmware-name = "qcom/sa8540p/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp1 {
+	firmware-name = "qcom/sa8540p/cdsp1.mbn";
+	status = "okay";
+};
+
+&spmi_bus {
+	pm8450a: pmic@0 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450a_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450c: pmic@4 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450c_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450e: pmic@8 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x8 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450e_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450g: pmic@c {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0xc SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450g_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&ufs_card_hc {
+	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l3c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_card_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
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
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7a>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
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
+	vdda-pll-supply = <&vreg_l1c>;
+	vdda18-supply = <&vreg_l7c>;
+	vdda33-supply = <&vreg_l2c>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l4c>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy0 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy1 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy2 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy3 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
+
+/* PINCTRL */
-- 
2.17.1

