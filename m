Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E414BD53B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiBUFXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:23:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbiBUFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:31 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057BEA5;
        Sun, 20 Feb 2022 21:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420989; x=1676956989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qTdBqK/wk3XPj6YIH+4a3yNFkD3UU5gHt0you21im4M=;
  b=n3EmGSx3MQmcU0+5Ti3Ymkkr+WU2Wy02eEWeiof0ezCFWs6OQ9k6eSzW
   DTv5B3ToBeAFhFW/A3DQ/y2a4THxpYH94qSXhvtE7s/5PaudKlQS6SpY0
   XxzYCXC2O9ZAhGAPldGiSHOOYVK7KanvV73/jFEnYCni/90WHRbow7UlJ
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:09 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:07 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:55 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id B1FF746C2; Mon, 21 Feb 2022 10:52:54 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 5/7] ARM: dts: qcom: sdx65: Add support for A7 PLL clock
Date:   Mon, 21 Feb 2022 10:52:31 +0530
Message-Id: <1645420953-21176-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SDX65 there is a separate A7 PLL which is used to provide high
frequency clock to the Cortex A7 CPU via a MUX.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 653df15..0219445 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -125,6 +125,14 @@
 			      <0x17802000 0x1000>;
 		};
 
+		a7pll: clock@17808000 {
+			compatible = "qcom,sdx65-a7pll";
+			reg = <0x17808000 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			#clock-cells = <0>;
+		};
+
 		timer@17820000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

