Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161C4E74D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359317AbiCYOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359311AbiCYOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:07:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51ABD8F5D;
        Fri, 25 Mar 2022 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648217174; x=1679753174;
  h=from:to:cc:subject:date:message-id;
  bh=P5x3GDc7b1j4avQHoAkawHiZA9YIIrO8jwjSyUccRNM=;
  b=rR/0vBT35NGkPaFCByy0CdgiQqRIY5NXqr61ANM/wK0o+BbY+EoN0Tkd
   AmCvFmmaGLirazcCyXw89lnZZQIKZSzoeShbybkg7uPRiiQEt1ms8Slsz
   BhTxHH4kL6bvJJyS92hI/2tFhnaGC3m6I0hZ7vhFJDa5IFm35RgSrjcdZ
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Mar 2022 07:06:13 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Mar 2022 07:06:12 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Mar 2022 19:36:00 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 9A3BE44C3; Fri, 25 Mar 2022 19:35:58 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH V2] arm64: dts: qcom: sc7280-idp: Configure cts sleep pinctrl to bias-bus-hold
Date:   Fri, 25 Mar 2022 19:35:45 +0530
Message-Id: <1648217145-725-1-git-send-email-quic_vnivarth@quicinc.com>
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
v2: used bias-bus-hold as per review comments
v1: intial patch used bias-disable
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..80ab2d8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -516,10 +516,10 @@
 		pins = "gpio28";
 		function = "gpio";
 		/*
-		 * Configure a pull-down on CTS to match the pull of
-		 * the Bluetooth module.
+		 * Configure a bus-hold on CTS to lower power usage
+		 * when BT is turned off.
 		 */
-		bias-pull-down;
+		bias-bus-hold;
 	};
 
 	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

