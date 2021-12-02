Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51425465DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349726AbhLBFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:21:32 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:41967 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345211AbhLBFVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638422289; x=1669958289;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/XMyoFnUnbcqzYajmGFLcw3K582rP0wEAsXpwqdxpSQ=;
  b=UvQvdzh0PpQTVL78ehh8FqBHlgR2ZkD0EtdBLVqlAG68hT+zITzjK3u8
   5SQ2JtDQW0XWG62DNcJ+63BOlvdFtvzhnP38Pawx87GA2bjnxUoKrrVkj
   Dp09OlCsswY8EwtigxD+LJKnpTWFUrGDIz5iuYiNfdAYTEniMR9qhVcKV
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 21:18:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 21:18:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 21:18:08 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 21:18:04 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v2] arm64: qcom: sc7280: Move USB2 controller nodes from common dtsi to SKU1
Date:   Thu, 2 Dec 2021 10:47:28 +0530
Message-ID: <1638422248-24221-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move USB2 controller and phy nodes from common dtsi file as it is
required only for SKU1 board and change the mode to host mode as
it will be used in host mode for SKU1.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
v2:
Squashed the two patches in v1 and changed the commit message.

 arch/arm64/boot/dts/qcom/sc7280-idp.dts  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 9b991ba..ffd483d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -80,3 +80,19 @@
 		qcom,pre-scaling = <1 1>;
 	};
 };
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l10c_0p8>;
+	vdda33-supply = <&vreg_l2b_3p0>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..c54ad62 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -398,22 +398,6 @@
 	vdda-pll-supply = <&vreg_l1b_0p8>;
 };
 
-&usb_2 {
-	status = "okay";
-};
-
-&usb_2_dwc3 {
-	dr_mode = "peripheral";
-};
-
-&usb_2_hsphy {
-	status = "okay";
-
-	vdda-pll-supply = <&vreg_l10c_0p8>;
-	vdda33-supply = <&vreg_l2b_3p0>;
-	vdda18-supply = <&vreg_l1c_1p8>;
-};
-
 &uart7 {
 	status = "okay";
 
-- 
2.7.4

