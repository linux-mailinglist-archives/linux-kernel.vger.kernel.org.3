Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDD569C74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiGGIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiGGIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471133A28
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bf9so6552161lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3oBdjTdR29pNyOQBbtY8v56Cbhul4FZ5CnvjyKdni8=;
        b=qgp2q/wJ8bOWiPAFNpG+rGY+/3KjcP5g/NCky+q+D0nY6fQJb9GOa+x282L/GCFzLI
         dBSiTQxXuVejEW7csnfLJxftpfk4meYl+fFjz+/ZM/RXG/SemZzc8mxG3PJcUCIt8BSR
         B8qo9RZTqKrKMDrVtDFeuR9AwABzM1yS+MIYhxi+h4KRNxv6okl9JJar8yge5PohZxQh
         SezvclDiwWnXV9D+3bNMaKQmhsRYSlVgQf1GOroZZ6Yd+sKFk7aStoCJ2dEx7Lc26Mmr
         zOSuMyo8pLhR+sB5nHyrAZz0yRTCCoblOTY/y2QlI8kEHKQgVZ7eb0REsIk6sPQoiTer
         Tg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3oBdjTdR29pNyOQBbtY8v56Cbhul4FZ5CnvjyKdni8=;
        b=bdvEpa0wKdp9PJpD2xE8IxI1r1Q+oXV6nW6ZKBE4+Z1EJqnYcjQbGC5O/arKA9Yco9
         Of+qW3yRr7mMIY9U8FRPaVfoFGm9V20ydyuVBTC6tKcUN0ATn+vVggYHOzCNBUNb9/yC
         LaP2dmpViRrahD2fdAEhd5T5eE7HMEqWcrh564J4kYB2bIJMuwz1cf630UP7GvywzxJ2
         UZdLPKX/9Za6Z8p7inMq8u1W/BtNlJLvin9r/fOTMWdJwIHJjzI332TF26h/s23oym0/
         rrx7LvIOOj+KWM979t/eMERgyiuX5lPxItMh5Sn9lkOLRvDcJ/QV7cmEPSQjq/AwOHm/
         /Lyw==
X-Gm-Message-State: AJIora/lRzkTaQLF2iYjPLaYkQqVwVpWKl6Estv/ufS7exq5+IX2JWzn
        2zCtDIrKyQfip6rdnurjdPoTOQ==
X-Google-Smtp-Source: AGRyM1vIYwUntzyrCs1GJCtryiH8V3WoOiqhiS6dRLD2qg9NO9EcdTAw4yo47oF7W6GFsoWjrdMhwA==
X-Received: by 2002:a05:6512:1316:b0:484:88a0:2574 with SMTP id x22-20020a056512131600b0048488a02574mr7573733lfu.399.1657181082966;
        Thu, 07 Jul 2022 01:04:42 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:42 -0700 (PDT)
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
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] arm64: dts: qcom: align SDHCI reg-names with DT schema
Date:   Thu,  7 Jul 2022 09:51:50 +0200
Message-Id: <20220707075151.67335-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
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
index 85bbd4f7306d..91153a0234f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2078,7 +2078,7 @@ qusb2phy: phy@c012000 {
 		sdhc2: mmc@c0a4900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

