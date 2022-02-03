Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8454A8331
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbiBCLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:33:28 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:14157 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiBCLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643888007; x=1675424007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=i0KImOfkywEWl5/iQghfqS7iVOCZyhHMr5gunELuYrs=;
  b=ON8vb3HpI4TUaubg4MO7OA0yTDRiLgnOwFUUGe8Ta43CxOh5JZaaFqPv
   TEDIo0mgxtVLVhdKawovWkTZVYob+Zz3a/zKUCCtOED7+x7rbdW8Dbnk5
   JKt9PckHTNc7n4MMzowlI3WK1EJVrXfUP2svHAmI3KpmlZ1nr9xtA18Ts
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 03:33:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:33:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:25 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:21 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v3 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and external codecs
Date:   Thu, 3 Feb 2022 17:02:59 +0530
Message-ID: <1643887981-31011-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
References: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
codecs like WCD938x, max98360a using soundwire masters and i2s bus.
Add these nodes for sc7280 based platforms audio use case.
Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  55 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 122 +++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index cd2755c..e6fbfc2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&wcd938x {
+	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ddeb508..2806888 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -32,6 +32,14 @@
 		};
 	};
 
+	max98360a: audio-codec-0 {
+		compatible = "maxim,max98360a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&amp_en>;
+		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
 	nvme_3v3_regulator: nvme-3v3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VLDO_3V3";
@@ -43,6 +51,31 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&nvme_pwren>;
 	};
+
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+		#sound-dai-cells = <1>;
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-io-supply = <&vreg_l18b_1p8>;
+		vdd-buck-supply = <&vreg_l17b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
+							  500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+	};
 };
 
 /*
@@ -636,3 +669,25 @@
 		bias-pull-up;
 	};
 };
+
+&swr0 {
+	wcd_rx: wcd938x-hph-playback {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		#sound-dai-cells = <1>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr1 {
+	wcd_tx: wcd938x-hph-capture {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		#sound-dai-cells = <1>;
+		qcom,tx-port-mapping = <1 2 3 4>;
+	};
+};
+
+&vamacro {
+	vdd-micb-supply = <&vreg_bob>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 6233f2c..946eb01 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1744,6 +1744,128 @@
 			#clock-cells = <1>;
 		};
 
+		rxmacro: rxmacro@3200000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&rx_swr_active>;
+			compatible = "qcom,sc7280-lpass-rx-macro";
+			reg = <0 0x3200000 0 0x1000>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "fsgen";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names ="macro", "dcodec";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		swr0: soundwire@3210000 {
+			reg = <0 0x3210000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.6.0";
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rxmacro>;
+			clock-names = "iface";
+			label = "RX";
+
+			qcom,din-ports = <0>;
+			qcom,dout-ports = <5>;
+			qcom,swrm-hctl-reg = <0x032a90a0>;
+
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		txmacro: txmacro@3220000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&tx_swr_active>;
+			compatible = "qcom,sc7280-lpass-tx-macro";
+			reg = <0 0x3220000 0 0x1000>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "fsgen";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names ="macro", "dcodec";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#sound-dai-cells = <1>;
+		};
+
+		swr1: soundwire@3230000 {
+			reg = <0 0x3230000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.6.0";
+
+			interrupts-extended =
+					<&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+					<&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "swr_master_irq", "swr_wake_irq";
+			clocks = <&txmacro>;
+			clock-names = "iface";
+			label = "TX";
+
+			qcom,din-ports = <3>;
+			qcom,dout-ports = <0>;
+			qcom,swrm-hctl-reg = <0x032a90a8>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0xFF 0x0 0xFF>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
+			qcom,port-offset = <1>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		vamacro: codec@3370000 {
+			compatible = "qcom,sc7280-lpass-va-macro";
+			pinctrl-0 = <&dmic01_active>;
+			pinctrl-names = "default";
+
+			reg = <0 0x3370000 0 0x1000>;
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
+			clock-names = "mclk";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names ="macro", "dcodec";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
 		lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
 			reg = <0 0x33c0000 0x0 0x20000>,
-- 
2.7.4

