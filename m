Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2879F56A227
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiGGMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiGGMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:36:48 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67B2559E;
        Thu,  7 Jul 2022 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657197407; x=1688733407;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UHRFUN82n1Ah6AJN0WBsMi2z7cqhaqHdGtwdvg6bkTE=;
  b=VzhtC9UOOS8fida3cADJkcfb99+Tnn1RrtHle4X3RUF3rmxnlDxKjdTA
   AIinBNP7lV38ve/riJ3AFCiR3bS8vSc+YJP2e+2ijYcYvM2hFYnDUnH9v
   Ox1cmNCh+fY/03eeu8KQUOkik+lU/lBZKrDQdsgp9I4xYTUb4EaXjcJq2
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jul 2022 05:36:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 05:36:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 05:36:46 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 05:36:42 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Move wcd specific pin conf to common file
Date:   Thu, 7 Jul 2022 18:06:21 +0530
Message-ID: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Move wcd specific pin conf to common file to support various
herbronie variant boards and to avoid duplicate nodes in dts files.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes Since V1:
    -- Remove redundant documentation.
    -- Update the pincontrol header comment.

 .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 64 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  | 61 ---------------------
 2 files changed, 64 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
index 32a1e78..859faaa 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
@@ -5,6 +5,70 @@
  * Copyright (c) 2022, The Linux Foundation. All rights reserved.
  */
 
+/* PINCTRL */
+
+&lpass_dmic01_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic01_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic01_data {
+	bias-pull-down;
+};
+
+&lpass_dmic23_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic23_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic23_data {
+	bias-pull-down;
+};
+
+&lpass_rx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_rx_swr_clk_sleep {
+	bias-pull-down;
+};
+
+&lpass_rx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
+&lpass_rx_swr_data_sleep {
+	bias-pull-down;
+};
+
+&lpass_tx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_tx_swr_clk_sleep {
+	bias-pull-down;
+};
+
+&lpass_tx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
 &mi2s1_data0 {
 	drive-strength = <6>;
 	bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index e9ca6c5..7881bbc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -155,67 +155,6 @@ ap_ts_pen_1v8: &i2c13 {
  * - If a pin is totally internal to Qcard then it gets Qcard name.
  * - If a pin is not hooked up on Qcard, it gets no name.
  */
-&lpass_dmic01_clk {
-	drive-strength = <8>;
-	bias-disable;
-};
-
-&lpass_dmic01_clk_sleep {
-	drive-strength = <2>;
-};
-
-&lpass_dmic01_data {
-	bias-pull-down;
-};
-
-&lpass_dmic23_clk {
-	drive-strength = <8>;
-	bias-disable;
-};
-
-&lpass_dmic23_clk_sleep {
-	drive-strength = <2>;
-};
-
-&lpass_dmic23_data {
-	bias-pull-down;
-};
-
-&lpass_rx_swr_clk {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-disable;
-};
-
-&lpass_rx_swr_clk_sleep {
-	bias-pull-down;
-};
-
-&lpass_rx_swr_data {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-bus-hold;
-};
-
-&lpass_rx_swr_data_sleep {
-	bias-pull-down;
-};
-
-&lpass_tx_swr_clk {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-disable;
-};
-
-&lpass_tx_swr_clk_sleep {
-	bias-pull-down;
-};
-
-&lpass_tx_swr_data {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-bus-hold;
-};
 
 &pm8350c_gpios {
 	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
-- 
2.7.4

