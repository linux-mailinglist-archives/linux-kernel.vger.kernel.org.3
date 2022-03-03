Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8884CB867
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiCCIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiCCIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:09:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A85FD2;
        Thu,  3 Mar 2022 00:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646294924; x=1677830924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oEHygAuYx7ScDgeJr076Rg/5e143mby8KSvoAzMOeBE=;
  b=TzKbSJqOv7t1YFtg+e8u24576F6wqwGtktG5y/ixhenhkjKi4YwD3uq6
   fooZQjhUKgUmqh9yR/pwQnP+JzIEbYZUB/jqCQ3p5Ar+/979qZ8wLXYwS
   lPa/+aCN9pnozOuBMooeGwozp2tt7WRpAn3mL9mhTmhLeHJqkqO9U3RYm
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Mar 2022 00:08:44 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Mar 2022 00:08:42 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 03 Mar 2022 13:38:30 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 10E274E1B; Thu,  3 Mar 2022 13:38:30 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v3 1/3] arm64/dts/qcom/sc7280: remove assigned-clock-rate property for mdp clk
Date:   Thu,  3 Mar 2022 13:38:22 +0530
Message-Id: <1646294904-4753-2-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646294904-4753-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1646294904-4753-1-git-send-email-quic_vpolimer@quicinc.com>
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

Changes in v2:
- Remove assigned-clock-rate property and set mdp clk during resume sequence.
- Add fixes tag.

Changes in v3:
- Remove extra line after fixes tag.(Stephen Boyd)
- Add similar changes for sc7180, sdm845 which uses opp table for voting mdp clk.(Stephen Boyd)
- Drop patch: "drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table"

Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index baf1653..408cf6c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2856,9 +2856,6 @@
 				      "ahb",
 				      "core";
 
-			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
-			assigned-clock-rates = <300000000>;
-
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -2892,11 +2889,9 @@
 					      "lut",
 					      "core",
 					      "vsync";
-				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
-						<&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
 						<&dispcc DISP_CC_MDSS_AHB_CLK>;
-				assigned-clock-rates = <300000000>,
-							<19200000>,
+				assigned-clock-rates = <19200000>,
 							<19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
 				power-domains = <&rpmhpd SC7280_CX>;
-- 
2.7.4

