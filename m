Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B83E575C05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiGOHFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGOHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8511413DC1;
        Fri, 15 Jul 2022 00:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B1BF622CC;
        Fri, 15 Jul 2022 07:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E54BC3411E;
        Fri, 15 Jul 2022 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657868689;
        bh=pKBHh3E3edFDbZJXA86vUXSWmuu+8Z7ILOltVYBgFWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKX2zaTpb5eQE5Eji9mgA8uFqBJfaV+HOIw8ANit+tdSyt2hABlF3RL2C3onpYM0B
         6e81CCigdcCA+AMxVqyoGyYDUxjLTMYmM84uu1dvOPYsrvhWJRRUsYKsyZjipxI2B2
         SFV9Yl8Fu7/z+dmaw7mcKZuK97xTPbQ+7feViwMFLi7PzMimz0HJYHBMV7EssgoNP1
         X4HH4sHaNUZXgZeuReHk3iAAYwjinO7hk0pD8RZv+gcLpdLIq67IFHjgAKdtQ39DK/
         /gYqN63lItzF99eQWj1R10+U9NEdRdG+cLLgB8U3S8aGXQJ2/iyIFeBj8qImeDbsL+
         64b182Kt+GW8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oCFNe-0004yz-JE; Fri, 15 Jul 2022 09:04:54 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: reorder USB interrupts
Date:   Fri, 15 Jul 2022 09:02:48 +0200
Message-Id: <20220715070248.19078-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220715070248.19078-1-johan+linaro@kernel.org>
References: <20220715070248.19078-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three SoCs did not follow the interrupt order specified by the USB
controller binding.

While keeping the non-SuperSpeed interrupts together seems natural,
reorder the interrupts to match the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 10 ++++++----
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++--------
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 20 ++++++++++++--------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 7a193678b4f5..8daefd50217a 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -372,11 +372,13 @@ usb: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "ss_phy_irq", "dm_hs_phy_irq";
+					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_GDSC>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7ac8aa110f81..65be7f3ec74c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3026,11 +3026,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 
@@ -3081,11 +3083,13 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_SEC_GDSC>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 65c7fe54613d..e72a04411888 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2461,11 +2461,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 
@@ -2509,11 +2511,13 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
-					  "dm_hs_phy_irq", "ss_phy_irq";
+					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_SEC_GDSC>;
 
-- 
2.35.1

