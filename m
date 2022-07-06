Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF8568510
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGFKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiGFKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:17:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC32528F;
        Wed,  6 Jul 2022 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657102630; x=1688638630;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VwlfvnG2tSLYTcnCDSEuoyt5q/+OAYIkK+DH0Z8k1qo=;
  b=HNAjkkO8/6SDDAVdUlzGY9/YtM3SAmzLWu83JnJ1HKHLJDXn43JzGbFB
   LwCTiOC00O4UC+2e7nmY8stpO/Db0HHHQRtWIYAm9OQQrX3eDLkvknF91
   o7OTUpFAlWFgGfgVwoR19WUkIgIDeTSoQN42oJe3etdwt8jb8ngulQfld
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jul 2022 03:17:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:17:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 03:17:08 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 03:17:04 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7280: Move wcd specific pin conf to common file
Date:   Wed, 6 Jul 2022 15:46:51 +0530
Message-ID: <1657102611-20067-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 71 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  | 61 -------------------
 2 files changed, 71 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
index 32a1e78..b04d796 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
@@ -5,6 +5,77 @@
  * Copyright (c) 2022, The Linux Foundation. All rights reserved.
  */
 
+/* PINCTRL - BOARD-SPECIFIC */
+
+/*
+ * Methodology for gpio-line-names:
+ * - If a pin goes to CRD board and is named it gets that name.
+ * - If a pin goes to CRD board and is not named, it gets no name.
+ * - If a pin is totally internal to Qcard then it gets Qcard name.
+ * - If a pin is not hooked up on Qcard, it gets no name.
+ */
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

