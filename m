Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CCF50A4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390381AbiDUP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390347AbiDUP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:59:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803040E4D;
        Thu, 21 Apr 2022 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650556587; x=1682092587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OD7nlJx/6iGBllBRTPaDLn52/B3dZkY8qzJCccA0fws=;
  b=M+epw1OFXV21BEjI7LNo+zUvcWlEWjMbBr+ORTp6R+7psljNo2C/IOZt
   e3a4u4fU5kwY+lwNHXBmz+b45Xgch50haBsM/d+Qm3MOhRIe1ZaqrOv1k
   BHUXx6C6i7qMG8eCye/7ByprhcuFmyZN0MlWbbeWxsJPQsNG10jDcn2KQ
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Apr 2022 08:56:27 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Apr 2022 08:56:25 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Apr 2022 21:26:14 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 299EF3C77; Thu, 21 Apr 2022 21:26:13 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V6 2/2] arm64: dts: qcom: sc7280-qcard: Configure CTS pin to bias-bus-hold for bluetooth
Date:   Thu, 21 Apr 2022 21:26:07 +0530
Message-Id: <1650556567-4995-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650556567-4995-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1650556567-4995-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN rail was leaking power during RBSC/sleep even after turning BT off.
Change active and sleep pinctrl configurations to handle same.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v6: add code comments about how bias-bus-hold could save power
v5: modify subject to include bluetooth
v4: modify subject of patch to indicate file it is applying to
v3: apply same change to active state and other sc7280*.dts* as well
v2: used bias-bus-hold as per review comments
v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
---
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index b833ba1..98b5cd70 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -398,8 +398,14 @@ mos_bt_uart: &uart7 {
 
 /* For mos_bt_uart */
 &qup_uart7_cts {
-	/* Configure a pull-down on CTS to match the pull of the Bluetooth module. */
-	bias-pull-down;
+	/*
+	 * Configure a bias-bus-hold on CTS to lower power
+	 * usage when Bluetooth is turned off. Bus hold will
+	 * maintain a low power state regardless of whether
+	 * the Bluetooth module drives the pin in either
+	 * direction or leaves the pin fully unpowered.
+	 */
+	bias-bus-hold;
 };
 
 /* For mos_bt_uart */
@@ -490,10 +496,13 @@ mos_bt_uart: &uart7 {
 		pins = "gpio28";
 		function = "gpio";
 		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
 		 */
-		bias-pull-down;
+		bias-bus-hold;
 	};
 
 	/* For mos_bt_uart */
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

