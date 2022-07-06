Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D15694AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiGFVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiGFVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:47:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9A29806
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:47:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a15so15471651pfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3+rDoUCYe8RPmhoz8u2hYqTYAf8ITefM+d2gAxFnNQ=;
        b=FNSlrUv53kCFN0bEt0sjfXf4U7vixRGQfYV6M8pKQRGmbfLtd0r2mPn9Qxu56b0coM
         GiakKYX+CsPjP5vBCsHL6xNarxueFBlu7KrsOXeuBwCnHwqLLgtGbGV4e8wV+fyFKkr6
         egvF8X0n20EGcXBooEeLkTyKCaCsqOmHiwNXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3+rDoUCYe8RPmhoz8u2hYqTYAf8ITefM+d2gAxFnNQ=;
        b=WtN9MiVD2UAqKWGczbNBNEsr5Rxycp2GDeGijsEeVktirfg0mUh0pcGebkJrvw4vc8
         x6gQT/Nhx+ZpZlNfvgxTaXFJZ0ZKfQ+iCyXvHa7Oq4fCo70ghZTdtntwMbPqM8TZTlSW
         R/V+fL5UrTTJUHQ4AkHsGxRpfioHKo46x/AOjbk598xP758UWDkFRu9PHxDHjkqDeDtB
         MMhCXn++gz+7dNZ3j4DQv0FSxQYzxrbeS4pfoW0t8gZ+gkEdNTnCAm4g5p4eDSW1FeGp
         gkXt6dL4L3dci88cKnQLar7qofDIxaGk2oRXeUmvNLVWBMilYPlk6//nr+6k2wZUqwEH
         lHKA==
X-Gm-Message-State: AJIora/eCCoWSDxyUAuvGLwW6du+L/aV5c2AfjEynVaJUvv9g3Pr/bGp
        1IuX8SADqgGTOVtQAK+AhNGUkQ==
X-Google-Smtp-Source: AGRyM1v4DdP0bgdN+M2+/vmQSOBYu9OTCiY3gGS7tau41Tm51BpIRne1Egmhuz4VIo95Zya5vZw9+g==
X-Received: by 2002:a05:6a00:174b:b0:525:4eea:8ff2 with SMTP id j11-20020a056a00174b00b005254eea8ff2mr48611592pfc.23.1657144060398;
        Wed, 06 Jul 2022 14:47:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:db48:9018:c59f:cffd])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b0015e8d4eb2e3sm3348955plg.301.2022.07.06.14.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:47:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "arm64: dts: qcom: Fix 'reg-names' for sdhci nodes"
Date:   Wed,  6 Jul 2022 14:47:33 -0700
Message-Id: <20220706144706.1.I48f35820bf3670d54940110462555c2d0a6d5eb2@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit afcbe252e9c19161e4d4c95f33faaf592f1de086.

The commit in question caused my sc7280-herobrine-herobrine-r1 board
not to boot anymore. This shouldn't be too surprising since the driver
is relying on the name "cqhci".

The issue seems to be that someone decided to change the names of
things when the binding moved from .txt to .yaml. We should go back to
the names that the bindings have historically specified.

For some history, see commit d3392339cae9 ("mmc: cqhci: Update cqhci
memory ioresource name") and commit d79100c91ae5 ("dt-bindings: mmc:
sdhci-msm: Add CQE reg map").

Fixes: afcbe252e9c1 ("arm64: dts: qcom: Fix 'reg-names' for sdhci nodes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is just a straight revert. That presumably means we'll get some
"make dtbs_check" warnings that were fixed by the commit being
reverted. I'll leave it to the authors of the original commit to
adjust the bindings to fix those.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 1721c72d591a..19fd8a2b551e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -809,7 +809,7 @@ pcie_phy: phy@7786000 {
 		sdcc1: mmc@7804000 {
 			compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
-			reg-names = "hc_mem", "cqe_mem";
+			reg-names = "hc", "cqhci";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 47ce5787ed5b..881e30953c0f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -697,7 +697,7 @@ sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x7c4000 0 0x1000>,
 				<0 0x07c5000 0 0x1000>;
-			reg-names = "hc_mem", "cqe_mem";
+			reg-names = "hc", "cqhci";
 
 			iommus = <&apps_smmu 0x60 0x0>;
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 40e700cebe56..c398485fec2d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -866,7 +866,7 @@ sdhc_1: mmc@7c4000 {
 
 			reg = <0 0x007c4000 0 0x1000>,
 			      <0 0x007c5000 0 0x1000>;
-			reg-names = "hc_mem", "cqe_mem";
+			reg-names = "hc", "cqhci";
 
 			iommus = <&apps_smmu 0xc0 0x0>;
 			interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 0f4c22be0224..1bc9091cad2a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1280,7 +1280,7 @@ qusb2phy1: phy@c014000 {
 		sdhc_2: mmc@c084000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c084000 0x1000>;
-			reg-names = "hc_mem";
+			reg-names = "hc";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
@@ -1335,7 +1335,7 @@ sdhc_1: mmc@c0c4000 {
 			reg = <0x0c0c4000 0x1000>,
 			      <0x0c0c5000 0x1000>,
 			      <0x0c0c8000 0x8000>;
-			reg-names = "hc_mem", "cqe_mem", "ice_mem";
+			reg-names = "hc", "cqhci", "ice";
 
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 94e427abbfd2..77bff81af433 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -438,7 +438,7 @@ rpm_msg_ram: sram@45f0000 {
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
@@ -459,7 +459,7 @@ sdhc_1: mmc@4744000 {
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04784000 0x1000>;
-			reg-names = "hc_mem";
+			reg-names = "hc";
 
 			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c702235f0291..bb9349bc2d35 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -477,7 +477,7 @@ sdhc_1: mmc@7c4000 {
 			reg = <0 0x007c4000 0 0x1000>,
 				<0 0x007c5000 0 0x1000>,
 				<0 0x007c8000 0 0x8000>;
-			reg-names = "hc_mem", "cqe_mem", "ice_mem";
+			reg-names = "hc", "cqhci", "ice";
 
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.0.rc0.161.g10f37bed90-goog

