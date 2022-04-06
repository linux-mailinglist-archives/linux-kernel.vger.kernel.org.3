Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34704F5BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbiDFKzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiDFKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:54:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8675149A6;
        Wed,  6 Apr 2022 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649229413; x=1680765413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9TeuMS7+p5ddyvbPjNkA+5PT44Jh0Ru6bQlomVn3lo4=;
  b=HNiycbBQKPYzYVP0pDqCSs7Lqp+pAf0xphrIGahiThF+kQXe/P3nEJh0
   bmnAqiFJp4gMuK9WlTTo1utqPObxhSG5U0JMFjSqhX6OEl5Gy1gW2yoV5
   J2LFlRQr1y21oWeLICl91tzphwjpPCece39ycC1Iz4rmHgSsGYqG7r6y6
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 00:16:37 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Apr 2022 00:16:35 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Apr 2022 12:46:33 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id A941F3B51; Wed,  6 Apr 2022 12:46:32 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V3 2/3] arch: arm64: dts: qcom: Configure cts sleep pinctrl to bias-bus-hold
Date:   Wed,  6 Apr 2022 12:46:01 +0530
Message-Id: <1649229362-31183-3-git-send-email-quic_vnivarth@quicinc.com>
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
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 1779d96..eb43ce5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -859,10 +859,10 @@ ap_ec_spi: &spi8 {
 
 &qup_uart7_cts {
 	/*
-	 * Configure a pull-down on CTS to match the pull of
-	 * the Bluetooth module.
+	 * Configure a bias-bus-hold on CTS to lower power usage
+	 * when BT is turned off.
 	 */
-	bias-pull-down;
+	bias-bus-hold;
 };
 
 &qup_uart7_rts {
@@ -1267,10 +1267,10 @@ ap_ec_spi: &spi8 {
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
 
 	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

