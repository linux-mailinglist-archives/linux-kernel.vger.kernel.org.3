Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989294FDFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353284AbiDLMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352961AbiDLMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908E41A1;
        Tue, 12 Apr 2022 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649761441; x=1681297441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9cQsfFJNCquvzvMaEJQhRvwJJvHExoXEPcrfecuGvb0=;
  b=wr6xqpctnNstmtcrQU6uogfsY/F+BN3+AZdXICJp3b4Wy6HxskCXAPhB
   7HJDjItIzavdmcnaRJcnG58PlNynyBKQDOmkat5mtd4mBDpk1ja89iWFf
   vfsX5heioe5/SVYiV12IYmjdGw1idZKCTg9drqzDWNepe5gJwEUE36hs+
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 04:04:00 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 04:03:58 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:33:42 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 6D9193AA3; Tue, 12 Apr 2022 16:33:41 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/4] ARM: dts: qcom: sdx65: Add USB3 and PHY support
Date:   Tue, 12 Apr 2022 16:33:33 +0530
Message-Id: <1649761414-19217-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
SNPS HS PHY on SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 3e4dc63..e419e47 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -130,6 +130,7 @@
 			reg = <0x00100000 0x001f7400>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+			#power-domain-cells = <1>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -143,6 +144,45 @@
 			status = "disabled";
 		};
 
+		usb_hsphy: hsphy@ff4000 {
+			compatible = "qcom,usb-snps-hs-7nm-phy";
+			reg = <0xff4000 0x120>;
+			#phy-cells = <0>;
+			status = "disabled";
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+			resets = <&gcc GCC_QUSB2PHY_BCR>;
+		};
+
+		usb_qmpphy: phy@ff6000 {
+			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
+			reg = <0x00ff6000 0x1c8>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_EN>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_USB3PHY_PHY_BCR>,
+				 <&gcc GCC_USB3_PHY_BCR>;
+			reset-names = "phy", "common";
+
+			usb_ssphy: phy@ff6200 {
+				reg = <0x00ff6e00 0x160>,
+				      <0x00ff7000 0x1ec>,
+				      <0x00ff6200 0x1e00>;
+				#phy-cells = <0>;
+				#clock-cells = <0>;
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_uni_phy_pipe_clk_src";
+			};
+		};
+
 		system_noc: interconnect@1620000 {
 			compatible = "qcom,sdx65-system-noc";
 			reg = <0x1620000 0x31200>;
@@ -182,6 +222,49 @@
 			status = "disabled";
 		};
 
+		usb: usb@a6f8800 {
+			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
+			reg = <0x0a6f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+					"sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
+					  "ss_phy_irq", "dm_hs_phy_irq";
+
+			power-domains = <&gcc USB30_GDSC>;
+
+			resets = <&gcc GCC_USB30_BCR>;
+
+			usb_dwc3: dwc3@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0x0a600000 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x1a0 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_hsphy>, <&usb_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		spmi_bus: qcom,spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0xd00>,
-- 
2.7.4

