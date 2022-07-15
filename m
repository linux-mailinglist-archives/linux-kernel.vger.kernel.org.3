Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C20575C01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiGOHFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGOHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818E2E9DC;
        Fri, 15 Jul 2022 00:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B6B622E0;
        Fri, 15 Jul 2022 07:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CBEC385A2;
        Fri, 15 Jul 2022 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657868689;
        bh=eTjHpwlIIlHYW/5esuVN0QvQEDI4dybjay3yQ29nxjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANatAUCTuYLMJP1Xa+Aqi3j6cBD9xEZHMh3senvFNbU0X99UAvl0NdShgHiu3YKiO
         q4I3GfwD4TFXocllWmyoQgRXDhEDtF6zKbI2+K5aGaOWLLClwPVTME8mxzF4KKGD4N
         eAlImXxNzNaR2PfIxYDcO82Pxl7gQ+3xPXC0Hi/70JoYnaIB9uS0pXMT1aTKc/dPq9
         +Sp0XmTK2ZokTFdhX9xiwlPsniAZTye4KDIVppe+cgGDaM58NdthAzU+qX2Je9girj
         IvNEnBh42hgST9MoSTqhhuj0VLD0EdUg+m28+EesHKnosV/+G1M++MtULPfdhsdYEs
         Q7l+qGg8X5gIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oCFNe-0004yx-GI; Fri, 15 Jul 2022 09:04:54 +0200
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc7280: reorder USB interrupts
Date:   Fri, 15 Jul 2022 09:02:47 +0200
Message-Id: <20220715070248.19078-4-johan+linaro@kernel.org>
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

Only one of the USB controllers supports SuperSpeed and have an SS PHY
wakeup interrupt.

Reorder the interrupts so that they match the updated binding which
specifically has the optional interrupt last.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ef431c954ab5..1e739ba1923d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3174,10 +3174,11 @@ usb_2: usb@8cf8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
-				     <&pdc 13 IRQ_TYPE_EDGE_RISING>,
-				     <&pdc 12 IRQ_TYPE_EDGE_RISING>;
+					      <&pdc 12 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 13 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "hs_phy_irq",
-					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq";
 
 			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
 
@@ -3357,13 +3358,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 17 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 14 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
-					      <&pdc 14 IRQ_TYPE_LEVEL_HIGH>;
+					      <&pdc 17 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
-					  "ss_phy_irq",
+					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
-					  "dp_hs_phy_irq";
+					  "ss_phy_irq";
 
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
 
-- 
2.35.1

