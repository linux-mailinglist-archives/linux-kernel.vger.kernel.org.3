Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FC4B288C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351159AbiBKO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:57:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351136AbiBKO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:57:41 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47DD131;
        Fri, 11 Feb 2022 06:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591459; x=1676127459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FrEtbYgABYhqiX/bwvgheZQ5y7mSXuzHug6fGin9Ups=;
  b=ZhUQNyLR1gxd49V2HId9j8wfnTIQ+vf+bk8L6twY9IsX/zKCIR7hczmi
   ZfCFxmFwhxo9Om+Q3KYnbe3H063rZHWw+0QtHw4O5jSM0Z1vddbwSctxv
   CP+jrYnNTcMxM9JHN179cTjJOuAQY3h+Ll01PEOp0opbaFZy83zFPjgl3
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 06:57:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:57:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:57:38 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:57:34 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and external codecs
Date:   Fri, 11 Feb 2022 20:27:16 +0530
Message-ID: <1644591438-6514-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 178 +++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..dd23b63 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -84,6 +84,10 @@ ap_ts_pen_1v8: &i2c13 {
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
index 1089fa0..07f8b1e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -38,6 +38,14 @@
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
@@ -49,6 +57,31 @@
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
 
 &apps_rsc {
@@ -496,6 +529,148 @@
 	drive-strength = <6>;
 };
 
+&soc {
+	rxmacro: rxmacro@3200000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&rx_swr_active>;
+		compatible = "qcom,sc7280-lpass-rx-macro";
+		reg = <0 0x3200000 0 0x1000>;
+
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+			 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+			 <&vamacro>;
+		clock-names = "mclk", "npl", "fsgen";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		#clock-cells = <0>;
+		clock-frequency = <9600000>;
+		clock-output-names = "mclk";
+		#sound-dai-cells = <1>;
+	};
+
+	swr0: soundwire@3210000 {
+		reg = <0 0x3210000 0 0x2000>;
+		compatible = "qcom,soundwire-v1.6.0";
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&rxmacro>;
+		clock-names = "iface";
+		label = "RX";
+
+		qcom,din-ports = <0>;
+		qcom,dout-ports = <5>;
+		qcom,swrm-hctl-reg = <0x032a90a0>;
+
+		qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
+		qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
+		qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
+		qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
+		qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+		qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
+		qcom,ports-hstart =		/bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
+		qcom,ports-hstop =		/bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
+		qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
+
+		#sound-dai-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+	};
+
+	txmacro: txmacro@3220000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&tx_swr_active>;
+		compatible = "qcom,sc7280-lpass-tx-macro";
+		reg = <0 0x3220000 0 0x1000>;
+
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+			 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+			 <&vamacro>;
+		clock-names = "mclk", "npl", "fsgen";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		#clock-cells = <0>;
+		clock-frequency = <9600000>;
+		clock-output-names = "mclk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		#sound-dai-cells = <1>;
+	};
+
+	swr1: soundwire@3230000 {
+		reg = <0 0x3230000 0 0x2000>;
+		compatible = "qcom,soundwire-v1.6.0";
+
+		interrupts-extended =
+				<&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+				<&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "swr_master_irq", "swr_wake_irq";
+		clocks = <&txmacro>;
+		clock-names = "iface";
+		label = "TX";
+
+		qcom,din-ports = <3>;
+		qcom,dout-ports = <0>;
+		qcom,swrm-hctl-reg = <0x032a90a8>;
+
+		qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
+		qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
+		qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
+		qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF>;
+		qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF>;
+		qcom,ports-word-length =	/bits/ 8 <0xFF 0x0 0xFF>;
+		qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0xFF>;
+		qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF>;
+		qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
+		qcom,port-offset = <1>;
+
+		#sound-dai-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+	};
+
+	vamacro: codec@3370000 {
+		compatible = "qcom,sc7280-lpass-va-macro";
+		pinctrl-0 = <&dmic01_active>;
+		pinctrl-names = "default";
+
+		reg = <0 0x3370000 0 0x1000>;
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
+		clock-names = "mclk";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		#clock-cells = <0>;
+		clock-frequency = <9600000>;
+		clock-output-names = "fsgen";
+		#sound-dai-cells = <1>;
+	};
+};
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
 &tlmm {
 	amp_en: amp-en {
 		pins = "gpio63";
@@ -588,3 +763,6 @@
 	};
 };
 
+&vamacro {
+	vdd-micb-supply = <&vreg_bob>;
+};
-- 
2.7.4

