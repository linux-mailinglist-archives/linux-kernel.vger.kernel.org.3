Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978994B50F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353864AbiBNNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:04:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353128AbiBNNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:04:26 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17F84D609;
        Mon, 14 Feb 2022 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644843859; x=1676379859;
  h=from:to:cc:subject:date:message-id;
  bh=qx6pEXqoFPXIkh9XX2jchiqtkp6Y1daXAlw0FUECkxg=;
  b=nurytHB2UNqNRPCqO/5IcEDK51n3gN6+eQwvdFRyRASYN5wMS5IOIoMM
   vKir/v+Fy/fnMPLo7uRwfcyQUGCJpn/L8yGeDA7Yh/UHlEePzXYvJ/Zek
   ty16EtVkVlLKAbtT6c8hM1uUm5mtxR5PH6K/KjFSyhcjOF6dqDuqfuyY5
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 05:04:19 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Feb 2022 05:04:16 -0800
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2022 18:34:06 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 682783C9F; Mon, 14 Feb 2022 18:34:05 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, msavaliy@qti.qualcomm.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to bias-disable for sc7280-idp
Date:   Mon, 14 Feb 2022 18:33:48 +0530
Message-Id: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..de18319 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -516,10 +516,10 @@
 		pins = "gpio28";
 		function = "gpio";
 		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
+		 * Configure a disable on CTS to lower power usage
+		 * when BT is turned off.
 		 */
-		bias-pull-down;
+		bias-disable;
 	};
 
 	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

