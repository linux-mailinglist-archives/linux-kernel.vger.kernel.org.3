Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42605669F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGELl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiGELlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0D165B2;
        Tue,  5 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35D76165F;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC86C341C7;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021257;
        bh=1/rcgwcQKLweYTXDt2AYvYQjEnmbbEGMmYoUqECaYZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmwhYIeWJ+G9u9VUlirbUiuhCIFn9aTIRe9Zz0AyLtbQUGq9VlEpiChoCqLfO7W2/
         OaFX/9ATJ+wDXTkPOsq6fDAN0siyfZ6nDMt4Jq/PfCkzsd7ZOa2Om6EoySWcFdhkxF
         Dyw+UCj2DXVr+rDAM68CGDjovMH5c0uX/Ngr4y+z3CC0Ku1ALW+WsvE72YRjQOFPqX
         Ed+mllkGDTTKY7j9QfmqAgsFq2j0Nog51BDCZzhfoatcWzS75yk8ON1bZv++irsGa8
         O/RNQYuTwhzI48jthSs6JhxvSQvuk5Hm40claZtfl/7YFxmIjgAbybSPUW3CIk7Qwl
         6K5jA2zpuQCzQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvK-0005y4-A4; Tue, 05 Jul 2022 13:40:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 14/14] arm64: dts: qcom: msm8996: clean up PCIe PHY node
Date:   Tue,  5 Jul 2022 13:40:32 +0200
Message-Id: <20220705114032.22787-15-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the PCIe PHY node by renaming the wrapper node and grouping the
child node properties.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 16869bb7d625..98a4cad89e9f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -585,7 +585,7 @@ soc: soc {
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		pcie_phy: phy@34000 {
+		pcie_phy: phy-wrapper@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x00034000 0x488>;
 			#address-cells = <1>;
@@ -601,48 +601,55 @@ pcie_phy: phy@34000 {
 				<&gcc GCC_PCIE_PHY_COM_BCR>,
 				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
 			reset-names = "phy", "common", "cfg";
+
 			status = "disabled";
 
 			pciephy_0: phy@1000 {
 				reg = <0x1000 0x130>,
 				      <0x1200 0x200>,
 				      <0x1400 0x1dc>;
-				#phy-cells = <0>;
 
-				#clock-cells = <0>;
-				clock-output-names = "pcie_0_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
 				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
 				reset-names = "lane0";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+
+				#phy-cells = <0>;
 			};
 
 			pciephy_1: phy@2000 {
 				reg = <0x2000 0x130>,
 				      <0x2200 0x200>,
 				      <0x2400 0x1dc>;
-				#phy-cells = <0>;
 
-				#clock-cells = <0>;
-				clock-output-names = "pcie_1_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe1";
 				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
 				reset-names = "lane1";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk_src";
+
+				#phy-cells = <0>;
 			};
 
 			pciephy_2: phy@3000 {
 				reg = <0x3000 0x130>,
 				      <0x3200 0x200>,
 				      <0x3400 0x1dc>;
-				#phy-cells = <0>;
 
-				#clock-cells = <0>;
-				clock-output-names = "pcie_2_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
 				clock-names = "pipe2";
 				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
 				reset-names = "lane2";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_2_pipe_clk_src";
+
+				#phy-cells = <0>;
 			};
 		};
 
-- 
2.35.1

