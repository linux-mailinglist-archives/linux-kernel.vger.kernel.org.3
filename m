Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5352745D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiENVzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiENVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E22D1CD
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m12so11120258plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeKFz6FvEbcUusdgXpBLLDhoZhZgVhmRs6eLFHdjJY8=;
        b=o2ylwYfA7fGITDyeMgXr6IGTtlHc8oQwug7nspKDPwGbH25+kLzPeEx3d+B+RQBYiU
         ABQHsTn2umyC/kgr6ZXogHO1jqVsQi3nI+5gqgbHTQxjUhpfoDk5hQaCA63W087k5ViR
         w8JxP5LYcVVeKBoAulRUKCoVCIOqNxesUkvbTxy358dyD4xLsTeQc2dAaYwcGe2c8ZVO
         RD4sJc6qlg4EsWnXwoesfHb60mAuIayEBoPgpb2f/BBOF++cmAMG9nntMIYrAB3QZoQW
         5uuj+80HxveyfRIkJT7FHvgkX3N5h7NGso1tlpRonYkK2ECm+4XlBA0k29CmTWp7gIfl
         /WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeKFz6FvEbcUusdgXpBLLDhoZhZgVhmRs6eLFHdjJY8=;
        b=uD+DL1dNjai6jbYX3Ga0Jy8kwIVFgnOH1qaSU5y9m7djU8bNEcEQWsLH8UJaKOIgW5
         G0RlzUObQtQopU21g691CZVj4ZTD1no0iD55csSbhLnU66mS8sUjcXtzQU0s1puQvfbN
         hskjaiYerMKHgrS8BQPt+EfR/vYr9oGjyHZ3C4vkPD51KVGIZRaDcjWEBwhlH3TRPrpA
         jQx0ZV44rldd+oEeAYk930GBDohDcfyZ006Yr0mfAYTEBq4f+be2AkFAXDzhrrXz9DqZ
         MirFT/YXBPlPUrer6eWtt7N5MwQAhngfTet+H1LCribExmPi7Prc/UyNPKJnL29PhPI6
         jDyg==
X-Gm-Message-State: AOAM530iUnivuwZXIjwW/TMvuQG9/k7bwVSR8lWT9B3Fj8Lm+Qlqxe9X
        zDHzCi7NuoDA4kTh2sW07iwj7g==
X-Google-Smtp-Source: ABdhPJyCpJgeUz2YbwGcAWQjqfF/PIggNj85gfy/wL4aiBjgTuGh36+Oe0W4a15vc8BYDL/sBBwbLw==
X-Received: by 2002:a17:90b:38c4:b0:1dc:6b64:3171 with SMTP id nn4-20020a17090b38c400b001dc6b643171mr23366996pjb.168.1652565289065;
        Sat, 14 May 2022 14:54:49 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:48 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: Fix 'reg-names' for sdhci nodes
Date:   Sun, 15 May 2022 03:24:23 +0530
Message-Id: <20220514215424.1007718-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Qualcomm sdhci-msm device-tree binding has been converted
to yaml format, 'make dtbs_check' reports a number of issues with
ordering of 'reg-names' as various possible combinations
are possible for different qcom SoC dts files.

Fix the same by updating the offending 'dts' files.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 86dbf8ea04bc..45044083faf0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -792,7 +792,7 @@ pcie_phy: phy@7786000 {
 		sdcc1: mmc@7804000 {
 			compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
-			reg-names = "hc", "cqhci";
+			reg-names = "hc_mem", "cqe_mem";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 9076892ff4f8..08f2decc7f4f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -697,7 +697,7 @@ sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x7c4000 0 0x1000>,
 				<0 0x07c5000 0 0x1000>;
-			reg-names = "hc", "cqhci";
+			reg-names = "hc_mem", "cqe_mem";
 
 			iommus = <&apps_smmu 0x60 0x0>;
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e63d1a4499f8..eaaccf0184af 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -866,7 +866,7 @@ sdhc_1: mmc@7c4000 {
 
 			reg = <0 0x007c4000 0 0x1000>,
 			      <0 0x007c5000 0 0x1000>;
-			reg-names = "hc", "cqhci";
+			reg-names = "hc_mem", "cqe_mem";
 
 			iommus = <&apps_smmu 0xc0 0x0>;
 			interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 6d872e2f400a..77dc985b3634 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1275,7 +1275,7 @@ qusb2phy: phy@c012000 {
 		sdhc_2: mmc@c084000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c084000 0x1000>;
-			reg-names = "hc";
+			reg-names = "hc_mem";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
@@ -1330,7 +1330,7 @@ sdhc_1: mmc@c0c4000 {
 			reg = <0x0c0c4000 0x1000>,
 			      <0x0c0c5000 0x1000>,
 			      <0x0c0c8000 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+			reg-names = "hc_mem", "cqe_mem", "ice_mem";
 
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 77bff81af433..94e427abbfd2 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -438,7 +438,7 @@ rpm_msg_ram: sram@45f0000 {
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
-			reg-names = "hc", "core";
+			reg-names = "hc_mem", "core_mem";
 
 			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
@@ -459,7 +459,7 @@ sdhc_1: mmc@4744000 {
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04784000 0x1000>;
-			reg-names = "hc";
+			reg-names = "hc_mem";
 
 			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 1b1eb884136b..6d959aa0ea94 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -477,7 +477,7 @@ sdhc_1: mmc@7c4000 {
 			reg = <0 0x007c4000 0 0x1000>,
 				<0 0x007c5000 0 0x1000>,
 				<0 0x007c8000 0 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+			reg-names = "hc_mem", "cqe_mem", "ice_mem";
 
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.3

