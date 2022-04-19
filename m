Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579B506472
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiDSGbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348792AbiDSGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:31:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDF23BFC;
        Mon, 18 Apr 2022 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650349719; x=1681885719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cG1Yzcr9fSJjQUXPjwcFfaw2bSuVoeeQVhgzvUMyjTE=;
  b=wB6VR4O8Ff8peR0KF1PpVT2SWBz6EvNPpT92doFvSeKiaF7ZKLIv0d9U
   qQSu1T+awJ4gUv4ghmg4ZGEmDLQqb1k+TUMUd8s7iJHCvJYiHi+xBWtco
   4BfzVeV4clOxLwZ01cFcbQDXfbI56M4QIgbNOUfNyOCx0ej4wCQcxi0Ct
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 23:28:39 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Apr 2022 23:28:37 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 19 Apr 2022 11:58:28 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 854473C01; Tue, 19 Apr 2022 11:58:26 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V4 2/2] arch: arm64: dts: qcom: sc7280-qcard: Configure cts pinctrl to bias-bus-hold
Date:   Tue, 19 Apr 2022 11:58:17 +0530
Message-Id: <1650349697-13540-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLAN rail was leaking power during RBSC/sleep even after turning BT off.
Change sleep pinctrl configuration to handle same.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v4: modify subject of patch to indicate file it is applying to
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

