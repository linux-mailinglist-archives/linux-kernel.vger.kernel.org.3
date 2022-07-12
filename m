Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB8571D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiGLOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiGLOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:43:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62CBB7CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:43:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so14307462lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRKH8Efyp+7WaOc4hkxLZdMcS/Z3VlGzrmvpw8bwAY8=;
        b=BRbdomsDxFHOtoR1pKSBtc+JkWGr0hTXZSBEwJphmxjaf3E12XpfYyF++PTjcd5G4e
         CiF8vU7fW8Zsfyx3fFmUP1k9lar/YwX9slYkh7Fyg71bY+mjGPkJeiTMOCRR9Yqpcslg
         Jq4MXfBJ9ikZUKD4+dfyY4K3YhcXYljSoLaC8ZNUcqhjPaGQyeZxoth+eO5lngYf4Qyn
         G6PBH368YJpixAMXBov9uzcjnDXoegf6XHIIrllIfDkoWrWDeeTE6y/ryfLIMQJ2yB3c
         p2d7PochcgBCieeHmHU3H0DAZqoap2ATGQM/7Fvlv5rm9K8iWfXLoF55acdVsI3UJO0d
         IYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRKH8Efyp+7WaOc4hkxLZdMcS/Z3VlGzrmvpw8bwAY8=;
        b=oTn1lq/pV5URqwWYuXWDj2sgt0bJ1ElZWASbth0hMuVskl8VsNtYNFGzpA6uL0pETy
         CBVHOzkg5PmvVHu7/poDwS0z9BWNbohMKuRW4lrSnVMPXiC+ZrMo8uEIkmNw1Eh5UNlY
         eQR5S4/0xLEQPBbE/OLtg0ouch+5rsH/lcB55+jXKUnym7yzn1uk2JqM/y/z4vaKaVvR
         NwWoMYZTvoacI2BQJWuq/ntZwtv4WQ3yYGa2CzObdpqmPrOdXnzARqVkaH83mkJYnnK8
         RYa0Xi4nIPJt3bLrpc7S04cucGFddslc2e+YyFOISozUVQSvgkRTvDHTJ58Gntsc/hDG
         NbvQ==
X-Gm-Message-State: AJIora9u12rzwkTRttV1j71bhdylePVZCnzpgDBHAAS/AfYvWU77ukqq
        H0Aq6qjQ7F8nOXBtmSqnn05h/A==
X-Google-Smtp-Source: AGRyM1vWK54rOOsp6Y8z7B/A8kPn7tb3dKWCgu3FZRLRPUY2zH6lMOnK9l//YCWg4/hghYpRFrfXYw==
X-Received: by 2002:a05:6512:12c8:b0:489:efbf:18d1 with SMTP id p8-20020a05651212c800b00489efbf18d1mr2700825lfg.192.1657636982571;
        Tue, 12 Jul 2022 07:43:02 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:43:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/5] arm64: dts: qcom: align SDHCI reg-names with DT schema
Date:   Tue, 12 Jul 2022 16:42:43 +0200
Message-Id: <20220712144245.17417-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
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

DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
just like TXT bindings were expecting before the conversion.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a6cb0dafcc17..2b9374f61d5b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -379,7 +379,7 @@ spmi_bus: spmi@200f000 {
 		sdhc_1: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 48bc2e09128d..0bdf4d39f778 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1469,7 +1469,7 @@ lpass_codec: audio-codec@771c000 {
 		sdhc_1: mmc@7824000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -1487,7 +1487,7 @@ sdhc_1: mmc@7824000 {
 		sdhc_2: mmc@7864000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 1bc0ef476cdb..97dde1a429d9 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -799,7 +799,7 @@ sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -859,7 +859,7 @@ sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7864900 0x500>, <0x7864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 8bc6c070e306..35c1ca080684 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -464,7 +464,7 @@ usb@f9200000 {
 		sdhc1: mmc@f9824900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -487,7 +487,7 @@ sdhc1: mmc@f9824900 {
 		sdhc2: mmc@f98a4900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 25d6b26fab60..9745df5dc007 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2896,7 +2896,7 @@ hsusb_phy2: phy@7412000 {
 		sdhc1: mmc@7464900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
@@ -2920,7 +2920,7 @@ sdhc1: mmc@7464900 {
 		sdhc2: mmc@74a4900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index e263a59d84b0..c98f36f95f3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2078,7 +2078,7 @@ qusb2phy: phy@c012000 {
 		sdhc2: mmc@c0a4900 {
 			compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

