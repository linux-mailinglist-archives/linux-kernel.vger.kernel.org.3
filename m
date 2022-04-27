Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8D511F72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiD0QCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiD0QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2141765EF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so4314133ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Utj/fvWe/fYc337ApANWWH/t7GTPD3mcLfNjhG8JpIA=;
        b=iMrhDCNr1iqObOfIcN+M4TR23IKTXjLkdbnnxsSb1M2yXlBaXe8zH+NnYBhqVLaYYq
         dp6f2iu9djHBp93ns15UF/JNhbbEeeM6Z8TzHN8957VqCVl+fNlh4mx2Zc/QrtD1v0so
         FOyMhTb4GXsqM0+OzLRxW/B9hB6WFZtRAlQXfqIgfSDuDn0QvWslPQBkgqm2aX8YT7e8
         dqjhVE0NTZQeJihI92AgqRqUW1bAgv4313IfMVYAkStoxi/W57SeG34IstItE9P2PpLL
         kJiI7BURaqAoHlMNdk3H1zP3AY9nGbebDyAZyQGFqWnm02dzBXftshOQUmw3ndT3zDDn
         wsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Utj/fvWe/fYc337ApANWWH/t7GTPD3mcLfNjhG8JpIA=;
        b=oNBPBmZNAdiV/LvNqVIx98PYQ5/0IiEgA2s5rIqsVZs4BhO7/TdZsECL1goAruqt7E
         MoqpeYVrucskz/IWEJc32TYpjJ0TJ2aC5XwN7KXc33dwMOt0ogUPprEOzmnb7v1zO0Hh
         oL3HEpjG6Ru7kD5n+M6qx5idm0bUDKl0Sjg9lhOpy2LvZEYal1pIIiq0kBEtgBK7u6SQ
         hY1YLyWUv6RNbCVJXp9Eh7pU78HrFgGUbuvvg8dpdOcn7qa8thcNYMZui4km7tGyFii7
         Q1VgAt/do4o2sOKjkdmyqP+7NQvZWXcw2aPPGhLFFovx/H/BNWnq1ut2ZAx4gbChA+r6
         JnBA==
X-Gm-Message-State: AOAM532N2CzKurJaPykbZkckqq4S6pHRdh1NEIK4E1aEnPTOrZIMoGtv
        /iVyKqy7JhU2n/dlxqtm3zDK6g==
X-Google-Smtp-Source: ABdhPJws7/T73B2Oun+thU4mR/+oametVzI1poODtGnO5SHCTff94pk4Kt50mWmvoGOBFEi8a05gfg==
X-Received: by 2002:a17:906:4cd8:b0:6db:372:c4ba with SMTP id q24-20020a1709064cd800b006db0372c4bamr26639522ejt.57.1651075138709;
        Wed, 27 Apr 2022 08:58:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 08/10] ARM: dts: exynos: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:38 +0200
Message-Id: <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl330 DMA controller bindings documented 'dma-channels' and
'dma-requests' properties (without leading hash sign), so fix the DTS to
match the bindings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos3250.dtsi             |  8 ++++----
 arch/arm/boot/dts/exynos4.dtsi                | 12 +++++------
 .../boot/dts/exynos4210-universal_c210.dts    |  4 ++--
 arch/arm/boot/dts/exynos5250.dtsi             | 16 +++++++--------
 arch/arm/boot/dts/exynos5410.dtsi             |  8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi             | 20 +++++++++----------
 6 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 41bb421e67c2..7bdd4f0782c3 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -429,8 +429,8 @@ pdma0: dma-controller@12680000 {
 			clocks = <&cmu CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@12690000 {
@@ -440,8 +440,8 @@ pdma1: dma-controller@12690000 {
 			clocks = <&cmu CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		adc: adc@126c0000 {
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5fd17bc52321..2a244aaf84b4 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -676,8 +676,8 @@ pdma0: dma-controller@12680000 {
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@12690000 {
@@ -687,8 +687,8 @@ pdma1: dma-controller@12690000 {
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		mdma1: dma-controller@12850000 {
@@ -698,8 +698,8 @@ mdma1: dma-controller@12850000 {
 			clocks = <&clock CLK_MDMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 		};
 
 		fimd: fimd@11c00000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 138d606d58a5..c1b11704b8ee 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -666,8 +666,8 @@ mdma0: dma-controller@12840000 {
 		clocks = <&clock CLK_MDMA>;
 		clock-names = "apb_pclk";
 		#dma-cells = <1>;
-		#dma-channels = <8>;
-		#dma-requests = <1>;
+		dma-channels = <8>;
+		dma-requests = <1>;
 		power-domains = <&pd_lcd0>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index df80ddfada2d..c4c0b4c08094 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -700,8 +700,8 @@ pdma0: dma-controller@121a0000 {
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@121b0000 {
@@ -711,8 +711,8 @@ pdma1: dma-controller@121b0000 {
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		mdma0: dma-controller@10800000 {
@@ -722,8 +722,8 @@ mdma0: dma-controller@10800000 {
 			clocks = <&clock CLK_MDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 		};
 
 		mdma1: dma-controller@11c10000 {
@@ -733,8 +733,8 @@ mdma1: dma-controller@11c10000 {
 			clocks = <&clock CLK_MDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 		};
 
 		gsc_0: gsc@13e00000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 4d797a9abba4..6dc08cb0622c 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -196,8 +196,8 @@ pdma0: dma-controller@121a0000 {
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@121b0000 {
@@ -207,8 +207,8 @@ pdma1: dma-controller@121b0000 {
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		audi2s0: i2s@3830000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 21b608705049..08198d82ce8d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -437,8 +437,8 @@ adma: dma-controller@3880000 {
 			clocks = <&clock_audss EXYNOS_ADMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <6>;
-			#dma-requests = <16>;
+			dma-channels = <6>;
+			dma-requests = <16>;
 			power-domains = <&mau_pd>;
 		};
 
@@ -449,8 +449,8 @@ pdma0: dma-controller@121a0000 {
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@121b0000 {
@@ -460,8 +460,8 @@ pdma1: dma-controller@121b0000 {
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		mdma0: dma-controller@10800000 {
@@ -471,8 +471,8 @@ mdma0: dma-controller@10800000 {
 			clocks = <&clock CLK_MDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 		};
 
 		mdma1: dma-controller@11c10000 {
@@ -482,8 +482,8 @@ mdma1: dma-controller@11c10000 {
 			clocks = <&clock CLK_MDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 			/*
 			 * MDMA1 can support both secure and non-secure
 			 * AXI transactions. When this is enabled in
-- 
2.32.0

