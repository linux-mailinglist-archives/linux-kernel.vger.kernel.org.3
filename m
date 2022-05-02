Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67DC516D12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384164AbiEBJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbiEBJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:10:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005939FDC;
        Mon,  2 May 2022 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651482425; x=1683018425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Z6gNoqhmJqY/KPhur4zfZOo/YinQ5sHtg1CcDq7XhqU=;
  b=FAJFEKQSjo1oJnRkDX7/pJiq3iZNIy6M0j1E5NLd46Q0nhGMtU1uMXq8
   iuFESH6pbnwMX/OGpT8zX851LYxklvYXiJB1y3IcV71MaXLhxuURAk0HK
   +ZR6013vaJZTl9Zko08YxcudxOisrK+UKC7v2SAUB7HQq9lv93baIbCGZ
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 02:07:05 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 02:07:03 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:36:45 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 640073BE1; Mon,  2 May 2022 14:36:44 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 4/4] ARM: dts: qcom: sdx65-mtp: Enable USB3 and PHY support
Date:   Mon,  2 May 2022 14:36:35 +0530
Message-Id: <1651482395-29443-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for USB3 controller, QMP PHY and HS PHY on SDX65 MTP.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 79dc31a..6920524 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -123,7 +123,7 @@
 			regulator-max-microvolt = <1300000>;
 		};
 
-		ldo1 {
+		vreg_l1b_1p2: ldo1 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
@@ -141,13 +141,13 @@
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		ldo4 {
+		vreg_l4b_0p88: ldo4 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		ldo5 {
+		vreg_l5b_1p8: ldo5 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
@@ -177,7 +177,7 @@
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		ldo10 {
+		vreg_l10b_3p08: ldo10 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
@@ -244,3 +244,24 @@
 		};
 	};
 };
+
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l4b_0p88>;
+	vdda33-supply = <&vreg_l10b_3p08>;
+	vdda18-supply = <&vreg_l5b_1p8>;
+};
+
+&usb_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l4b_0p88>;
+	vdda-pll-supply = <&vreg_l1b_1p2>;
+};
-- 
2.7.4

