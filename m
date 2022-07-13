Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D057373B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiGMNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiGMNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4203BC53;
        Wed, 13 Jul 2022 06:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF731B81F48;
        Wed, 13 Jul 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B2C385A2;
        Wed, 13 Jul 2022 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718277;
        bh=SauCF41rVsY6LM+X0ZnhGdaP/KcXwomdi6I+zIPVqeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXYEohfLt8HFL6YxyD9LMom1TQtjKql9RnIi7fiiOML+ztYXreMwTHlhGpYOarKTh
         gnh0ZppzASGxyQEVOe94i32H+6/bPRRr5oUvqbW2bKNfPc/qiEJQuUV4DDgmSWIyJq
         Ug62CsJ3e3ZyQjchjL4vLqsfQ1GL171i+wGJgGmSfaaxpQ0VBJv5DWrSb5gWsDGeKu
         XxHsaIna31hAlh6SqCEOvNKxL6QJiyU2EdQGrGyE61kluB0L4D547KHLXKuTWlK9DU
         rL93zH0Q9dFFfT6i74BvwlUWDAKKMiST1AvGSd3xYGxQaJRMGpM05WyvFf4Gov+wFb
         lzDAshr4HM4tw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBcFd-0007gS-Ht; Wed, 13 Jul 2022 15:18:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/7] arm64: dts: qcom: sc7280: reorder USB interrupts
Date:   Wed, 13 Jul 2022 15:13:39 +0200
Message-Id: <20220713131340.29401-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713131340.29401-1-johan+linaro@kernel.org>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
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

