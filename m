Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8014D1DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbiCHQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348509AbiCHQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:56:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1B4ECF9;
        Tue,  8 Mar 2022 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646758523; x=1678294523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=a4IaeSXwSBvcS1QBXci/iCU3y5fDAD+ThP2vZLPD1Hg=;
  b=D7vValmJkOOb+0f51zb51jZaCxtg/H0//rHquw3HZtryLWlicc1SQuHw
   5PmwYTDRb5HlTupD/1i9+R9W8Tqi2B3+ImTXwLVTpjGYWG/u5GvyoTYJE
   2cBNh0r8Ep19shZrhDRbfHh0aQS5J4/8OhwTtIDWLnYK0gZF40/NzyJLD
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 08:55:23 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Mar 2022 08:55:21 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 22:25:03 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 7621E53EF; Tue,  8 Mar 2022 22:25:02 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v5 4/5] arm64/dts/qcom/sm8250: remove assigned-clock-rate property for mdp clk
Date:   Tue,  8 Mar 2022 22:24:59 +0530
Message-Id: <1646758500-3776-5-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel clock driver assumes that initial rate is the
max rate for that clock and was not allowing it to scale
beyond the assigned clock value.

Drop the assigned clock rate property and vote on the mdp clock as per
calculated value during the usecase.

Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303..2105eb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3164,9 +3164,6 @@
 				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
 			clock-names = "iface", "bus", "nrt_bus", "core";
 
-			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
-			assigned-clock-rates = <460000000>;
-
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -3191,10 +3188,8 @@
 					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				clock-names = "iface", "bus", "core", "vsync";
 
-				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
-						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
-				assigned-clock-rates = <460000000>,
-						       <19200000>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
 				power-domains = <&rpmhpd SM8250_MMCX>;
-- 
2.7.4

