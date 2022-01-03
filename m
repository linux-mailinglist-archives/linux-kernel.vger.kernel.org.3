Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC448304C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiACLNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:13:33 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43329 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiACLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641208410; x=1672744410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0sZLt1exlbnoOFLAaXjPGs1S0V3G9wpyyPepRTQ9El8=;
  b=WtITM3pB8WJ9QjTcrD5yrGuJrgTMjAMXEG5o/eHS8Nm3YLyPp8vTR0nW
   eyg3H/YA8hA1iVf3gTCC3DwcQM8BxMnxpiww6vnM9kT0EksZgxWQPcymN
   SXWKziWZrWxBwznEiIkgXxaNLhY47STSE3Cr3Vo7nI3+W7zYZwJQxGd3h
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 03 Jan 2022 03:13:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 03:13:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 3 Jan 2022 03:13:28 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 3 Jan 2022 03:13:24 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc7280: add sound card support
Date:   Mon, 3 Jan 2022 16:43:00 +0530
Message-ID: <1641208380-15510-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sound card support for MTP using WCD938x headset playback,
capture, I2S Speaker Playback and DMICs via VA macro.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |  8 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     |  3 ++
 3 files changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index 035cca9..f55232e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -76,6 +76,14 @@ ap_ts_pen_1v8: &i2c13 {
 	qcom,us-euro-gpios = <&tlmm 81 0>;
 };
 
+&sound {
+	audio-routing =
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"VA DMIC3", "MIC BIAS3";
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 3449d56..63b1184 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -637,6 +637,99 @@
 	};
 };
 
+&sound {
+	compatible = "google,sc7280-herobrine";
+	model = "sc7280-wcd938x-max98360a-1mic";
+	status = "okay";
+	audio-routing =
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC1", "MIC BIAS1",
+		"AMIC2", "MIC BIAS2",
+		"VA DMIC0", "MIC BIAS3",
+		"VA DMIC1", "MIC BIAS3",
+		"VA DMIC2", "MIC BIAS1",
+		"VA DMIC3", "MIC BIAS1",
+		"TX SWR_ADC0", "ADC1_OUTPUT",
+		"TX SWR_ADC1", "ADC2_OUTPUT",
+		"TX SWR_ADC2", "ADC3_OUTPUT",
+		"TX SWR_DMIC0", "DMIC1_OUTPUT",
+		"TX SWR_DMIC1", "DMIC2_OUTPUT",
+		"TX SWR_DMIC2", "DMIC3_OUTPUT",
+		"TX SWR_DMIC3", "DMIC4_OUTPUT",
+		"TX SWR_DMIC4", "DMIC5_OUTPUT",
+		"TX SWR_DMIC5", "DMIC6_OUTPUT",
+		"TX SWR_DMIC6", "DMIC7_OUTPUT",
+		"TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+		qcom,msm-mbhc-hphl-swh = <1>;
+		qcom,msm-mbhc-gnd-swh = <1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	#sound-dai-cells = <0>;
+
+	dai-link@6 {
+		link-name = "WCD Playback";
+		reg = <LPASS_CDC_DMA_RX0>;
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr0 0>, <&rxmacro 0>;
+		};
+	};
+
+	dai-link@19 {
+		link-name = "WCD Capture";
+		reg = <LPASS_CDC_DMA_TX3>;
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 1>, <&swr1 0>, <&txmacro 0>;
+		};
+	};
+
+	dai-link@1 {
+		link-name = "Secondary MI2S Playback";
+		reg = <MI2S_SECONDARY>;
+		cpu {
+			sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+		};
+
+		codec {
+			sound-dai = <&max98360a>;
+		};
+	};
+
+	dai-link@5 {
+		link-name = "DP Playback";
+		reg = <LPASS_DP_RX>;
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_DP_RX>;
+		};
+
+		codec {
+				sound-dai = <&msm_dp>;
+		};
+	};
+
+	dai-link@25 {
+		link-name = "DMIC Capture";
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+		cpu {
+			sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+		};
+
+		codec {
+			sound-dai = <&vamacro 0>;
+		};
+	};
+};
+
 &swr0 {
 	wcd_rx: wcd938x-rx{
 		compatible = "sdw20217010d00";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 68c7755..57bc5ef 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2786,6 +2786,9 @@
 
 		};
 
+		sound: sound {
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sc7280-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.7.4

