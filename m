Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEC51834E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiECLgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:36:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209C261C;
        Tue,  3 May 2022 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651577597; x=1683113597;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=o23VYzBAw21sFAspLxcuTiAZCy5akFiprfgj/fLVtaE=;
  b=cg64EZ6rPVx0PAjVS/V3Q7vXwmpZchuxJgRrW/aEtQCTxtTUAdpAKW+A
   AQvjrZCoNVF3pQh1ANORaJvVTV+1YCkPVYb0Fn9fADy+EzmXnj3jbF9pF
   4ZhZQz2KkUBA9xDN4W1gDCPk78nJfiaCXLAWwb1vo+TEkHDp35kOj3Gyc
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 May 2022 04:33:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 04:33:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 04:33:16 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 04:33:13 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v4] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers
Date:   Tue, 3 May 2022 17:02:46 +0530
Message-ID: <20220503113246.13857-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the low pass audio clock controller device nodes. Keep the lpasscc
clock node disabled and enabled for lpass pil based devices.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
[v4]
 * Mark lpasscc[lpasscc@3000000] device node as "disabled".

[v3]
 * Fix unwanted extra spaces in reg property.
 * Fix lpass_aon node clock phandle <&lpasscc> to <&lpasscore>

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be63c21..477a754741a1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
+#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -1978,6 +1980,48 @@
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		lpass_audiocc: clock-controller@3300000 {
+			compatible = "qcom,sc7280-lpassaudiocc";
+			reg = <0 0x03300000 0 0x30000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
+			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
+			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpass_aon: clock-controller@3380000 {
+			compatible = "qcom,sc7280-lpassaoncc";
+			reg = <0 0x03380000 0 0x30000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			       <&rpmhcc RPMH_CXO_CLK_A>,
+			       <&lpasscore LPASS_CORE_CC_CORE_CLK>;
+			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpasscore: clock-controller@3900000 {
+			compatible = "qcom,sc7280-lpasscorecc";
+			reg = <0 0x03900000 0 0x50000>;
+			clocks =  <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpass_hm: clock-controller@3c00000 {
+			compatible = "qcom,sc7280-lpasshm";
+			reg = <0 0x3c00000 0 0x28>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 		};

 		lpass_ag_noc: interconnect@3c40000 {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

