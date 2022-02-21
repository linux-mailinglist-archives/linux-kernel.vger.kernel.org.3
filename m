Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357BB4BE831
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358659AbiBUNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:12:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350923AbiBUNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:12:52 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35E1EED5;
        Mon, 21 Feb 2022 05:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645449149; x=1676985149;
  h=from:to:cc:subject:date:message-id;
  bh=G7oTbgnW/y7+oRzp7iXZzH5BC58ZLVjZyl7jNT6m2Z8=;
  b=LdPwZU66Nr+bx0t1XDmcph2ydGHan+ebdb65MdBo8c+aUUrNuKIR5iSP
   nBsxNsJCHZFkkNlLQFXBG6oL1N992cBb2hCUg6PZe/MI9McdW98XjBE8i
   Dn+8iUS6bT23MJhNIOSborsemk1yzc7NFQF+CORUe/qVbMIwqU9FyaAhJ
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 05:12:28 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 05:12:26 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 18:42:12 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 41F47231E; Mon, 21 Feb 2022 18:42:12 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [v1] arm64/dts/qcom/sc7280: update mdp clk to max supported value to support higher refresh rates
Date:   Mon, 21 Feb 2022 18:42:06 +0530
Message-Id: <1645449126-17718-1-git-send-email-quic_vpolimer@quicinc.com>
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

Panels with higher refresh rate will need mdp clk above 300Mhz.
Select max frequency for mdp clock during bootup, dpu driver will
scale down the clock as per usecase when first update from the framework is received.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index baf1653..7af96fc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2895,7 +2895,7 @@
 				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
 						<&dispcc DISP_CC_MDSS_VSYNC_CLK>,
 						<&dispcc DISP_CC_MDSS_AHB_CLK>;
-				assigned-clock-rates = <300000000>,
+				assigned-clock-rates = <506666667>,
 							<19200000>,
 							<19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
-- 
2.7.4

