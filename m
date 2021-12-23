Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF147E5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhLWPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:44:27 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47857 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349379AbhLWPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640274213; x=1671810213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gLKto1hI5OmGjoWkpCUF8t/R7PykhlF+MUksnia//Rs=;
  b=IXUFLFaVqslIdCShrju08w/Amp2YDgNh/vafK2w6K9qTuF5zRfU0UYgX
   qFftBE/xCSMr/6upVq+68j4sTMrVkw2xr9Uilww17dV/kfijfoCqnsXNk
   j5sOVZCYVzINuMFlqPEPj2+AY7UpOoXs+0oJ34Z525DfpkZ4WJO4jwoLT
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Dec 2021 07:43:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:43:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:31 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:27 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 1/3] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Thu, 23 Dec 2021 21:13:07 +0530
Message-ID: <1640274189-14120-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com>
References: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMP enable node and pinmux for primary and secondary I2S
for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 11 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 55 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..86f182c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -491,6 +491,17 @@
 };
 
 &tlmm {
+	amp_en: amp-en {
+		pinmux {
+			pins = "gpio63";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio63";
+			bias-pull-down;
+		};
+	};
+
 	nvme_pwren: nvme-pwren {
 		function = "gpio";
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0..b5ebc9ec 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3461,6 +3461,61 @@
 				};
 			};
 
+			pri_mi2s_active: primary_mi2s_active {
+				sclk {
+					pins = "gpio97";
+					function = "mi2s0_sck";
+					drive-strength = <16>;
+				};
+				ws {
+					pins = "gpio100";
+					function = "mi2s0_ws";
+					drive-strength = <16>;
+				};
+				data0 {
+					pins = "gpio98";
+					function = "mi2s0_data0";
+					drive-strength = <16>;
+				};
+				data1 {
+					pins = "gpio99";
+					function = "mi2s0_data1";
+					drive-strength = <16>;
+				};
+			};
+
+			pri_mi2s_mclk_active: pri-mi2s-mclk-active {
+				pinmux {
+					pins = "gpio96";
+					function = "pri_mi2s";
+				};
+			};
+
+			sec_mi2s_active: sec-mi2s-active {
+				sclk {
+					pins = "gpio106";
+					function = "mi2s1_sck";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+
+				ws {
+					pins = "gpio108";
+					function = "mi2s1_ws";
+					drive-strength = <16>;
+					output-high;
+				};
+
+				data0 {
+					pins = "gpio107";
+					function = "mi2s1_data0";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
 			qup_uart8_cts: qup-uart8-cts {
 				pins = "gpio32";
 				function = "qup10";
-- 
2.7.4

