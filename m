Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4A4B4263
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiBNHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:02:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiBNHC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:02:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F6580D8;
        Sun, 13 Feb 2022 23:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644822143; x=1676358143;
  h=from:to:cc:subject:date:message-id;
  bh=dO5l/En4m8ZREkWl9lrDIcLcLCuIjcDgtaL8yi+zZeg=;
  b=eVQVAjupypQxjgHy394w0qoHkHMXTrH7WmgLhqwpusLyn2qtGCc403io
   48cytK9Iy8fTKYRBFYJlSAN14QAE7v549avk7EcyYFXTP5qR28j8FTHof
   mE8JS/O+sB93efDyXdH278m0GUi8gU3BY724Pb8MmzLIkkRqJvcBI1N3H
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 13 Feb 2022 23:02:23 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Feb 2022 23:02:21 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2022 12:32:19 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 31F544473; Mon, 14 Feb 2022 12:32:18 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 6/8] ARM: dts: qcom: sdx65: Add support for APCS block
Date:   Mon, 14 Feb 2022 12:32:17 +0530
Message-Id: <1644822137-27760-1-git-send-email-quic_rohiagar@quicinc.com>
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

The APCS block on SDX65 acts as a mailbox controller and also provides
clock output for the Cortex A7 CPU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 2900ffe..1646c7c 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -133,6 +133,15 @@
 			#clock-cells = <0>;
 		};
 
+		apcs: mailbox@17810000 {
+			compatible = "qcom,sdx65-apcs-gcc", "syscon";
+			reg = <0x17810000 0x2000>;
+			#mbox-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&a7pll>, <&gcc GPLL0>;
+			clock-names = "ref", "pll", "aux";
+			#clock-cells = <0>;
+		};
+
 		timer@17820000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

