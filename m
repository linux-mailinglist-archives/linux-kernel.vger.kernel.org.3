Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC44F5CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiDFLzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiDFLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:54:57 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096D2DBFF1;
        Wed,  6 Apr 2022 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649229404; x=1680765404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G8TAxFuMIH2k2HAYU7fzVN3wL8YmlGxi1x8C6tasnho=;
  b=xypWVrB73Siu4NHZtcB2SgV+cBlneJ71qSOTF+80qifkROoacMV14oSb
   ulI5uMOys0d/uryyEavFTea+RAnH8TRz7Ggp70KY5yrY/PZvEDtiMj/uV
   aS09iCyLM5xrI5mqKhgNZBSlMEWZ2dLMQlHgoDRAaxbdvgy4rvcVWYrdB
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 00:16:37 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Apr 2022 00:16:35 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Apr 2022 12:46:34 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 0F7223B51; Wed,  6 Apr 2022 12:46:34 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V3 3/3] arch: arm64: dts: qcom: Configure cts sleep pinctrl to bias-bus-hold
Date:   Wed,  6 Apr 2022 12:46:02 +0530
Message-Id: <1649229362-31183-4-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649229362-31183-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1649229362-31183-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN rail was leaking power during RBSC/sleep even after turning BT off.
Change sleep pinctrl configuration to handle same.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v3: apply same change to active state and other sc7280*.dts* as well
v2: used bias-bus-hold as per review comments
v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
---
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index b833ba1..602ebd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -398,8 +398,11 @@ mos_bt_uart: &uart7 {
 
 /* For mos_bt_uart */
 &qup_uart7_cts {
-	/* Configure a pull-down on CTS to match the pull of the Bluetooth module. */
-	bias-pull-down;
+	/*
+	 * Configure a bias-bus-hold on CTS to lower power usage
+	 * when BT is turned off.
+	 */
+	bias-bus-hold;
 };
 
 /* For mos_bt_uart */
@@ -490,10 +493,10 @@ mos_bt_uart: &uart7 {
 		pins = "gpio28";
 		function = "gpio";
 		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
+		 * Configure a bias-bus-hold on CTS to lower power usage
+		 * when BT is turned off.
 		 */
-		bias-pull-down;
+		bias-bus-hold;
 	};
 
 	/* For mos_bt_uart */
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

