Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75A4B4261
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiBNHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:01:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbiBNHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:01:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF259A66;
        Sun, 13 Feb 2022 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644822080; x=1676358080;
  h=from:to:cc:subject:date:message-id;
  bh=J2KQOLTp6dTypHQ3yNmxkBsSyB1kwzt6QL9gj41Nx0A=;
  b=hp8RVjc3qX9IR6Y4TZPWEELd/W/zxLLzON1NDNT8+mK458I8uUHZNpD2
   mBxXkuy3kjsJM6hCkExBlffmI0QClo8g/VG4acbuv2IdufInOxWwTb6Qa
   stCgTntjujdNxYzO4DvlJ+aYnnilgOBpPTfZ//w2EvqViyXmT3Q5cURZ3
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Feb 2022 23:01:20 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Feb 2022 23:01:18 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2022 12:31:16 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id DEB494473; Mon, 14 Feb 2022 12:31:15 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 5/8] ARM: dts: qcom: sdx65: Add support for A7 PLL clock
Date:   Mon, 14 Feb 2022 12:31:09 +0530
Message-Id: <1644822069-27513-1-git-send-email-quic_rohiagar@quicinc.com>
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

On SDX65 there is a separate A7 PLL which is used to provide high
frequency clock to the Cortex A7 CPU via a MUX.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 556a2e3..2900ffe 100644
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

