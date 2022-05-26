Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33870535486
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiEZUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbiEZUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:36:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770022288
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:36:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c93so1817234edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xCGQvvUGQaE5nD3AhNgDDTCkjpXLMHYug+OugGhLH0=;
        b=Twyo2Su5UAgxeN7qKIrQ1vclQVUGHHVefW54I++4vRwJK4H6KWuuy9suuHEq58XgQO
         8U5a1P6Fgg4qunOy5D7v5am1del8uVkfl1j7RBIZ32TWYuskIV+Z02licFV0tcTUq7G1
         C2k5R/JPSypSJr9S23eeTizw9keKK6DhIECQJIBBEceEa1S9dZ/qswMr5K9HdielElkq
         6YtNDqlnzvzlY/lkQtRhtabUd4cySk8AqV8iEc0cs4V5pH8VSXvke6gcFbNrL7mdLjS/
         tdn/tj+3Hic7PWveY3O0y3AqvP9PYKCdnrmvCE3PwjlCoR5j92RD1OA2zXYcJ1TfpBTT
         LamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xCGQvvUGQaE5nD3AhNgDDTCkjpXLMHYug+OugGhLH0=;
        b=et0Xv+KjqFplzGycZhKPu6hBhtTo0elmFJuG+GCjDdTUg90wW+TwQ5vPe7QTIm9sbP
         aCAV+RoocQBe8PamqUQBEafYMCEQn9aZGuxC9gNjAuccu+eNke5Fzv9JFlX84j8QObhg
         CI6/XKR/Ychj2cN2nheJX94NByKdxChdtApU4bwUlgleDmsT2sjxJKqq1njIWNXYrzx+
         FsbojVlByiS+oE1SR1bW1CHmND1uxqbADRCBwFoO9PYczTT0ZswWQ6Lpe6HrOgLpmziI
         kx2KzhJdcpe1TJ7xH5L7XCNEZqwo6L/uNe7ziXv6jHU8KcDVe1CVr2vWaqPfg2AJHMxN
         +/iQ==
X-Gm-Message-State: AOAM531VgjRAi8Y/0ORqZEEep54UY3YaYr1cwDauAIpq5OsFjMnQsMGW
        Utw78Wymm60UeAsYdQs0BJF2NA==
X-Google-Smtp-Source: ABdhPJyGbdQkLhMKqhKy+9Q0m93KwcBPYZYVxQ9WwPptqaaBghy4mJi2ZYCq6XT+edUFXgi0KT6qrQ==
X-Received: by 2002:aa7:cd4b:0:b0:42b:cd71:5e85 with SMTP id v11-20020aa7cd4b000000b0042bcd715e85mr9387536edw.207.1653597410345;
        Thu, 26 May 2022 13:36:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u28-20020a50c05c000000b0042ac43be19dsm1211304edd.3.2022.05.26.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:36:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: stm: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:36:32 +0200
Message-Id: <20220526203632.831039-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
References: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/stm32429i-eval.dts    | 8 ++++----
 arch/arm/boot/dts/stm32h743.dtsi        | 4 ++--
 arch/arm/boot/dts/stm32h743i-disco.dts  | 8 ++++----
 arch/arm/boot/dts/stm32h743i-eval.dts   | 8 ++++----
 arch/arm/boot/dts/stm32h750i-art-pi.dts | 8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 0d98aca01736..3de0e9dbe030 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -251,10 +251,10 @@ ltdc_out_rgb: endpoint {
 
 &mac {
 	status = "okay";
-	pinctrl-0	= <&ethernet_mii>;
-	pinctrl-names	= "default";
-	phy-mode	= "mii";
-	phy-handle	= <&phy1>;
+	pinctrl-0 = <&ethernet_mii>;
+	pinctrl-names = "default";
+	phy-mode = "mii";
+	phy-handle = <&phy1>;
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 91dde07a38ba..2059593da21d 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -375,7 +375,7 @@ sdmmc1: mmc@52007000 {
 			arm,primecell-periphid = <0x10153180>;
 			reg = <0x52007000 0x1000>;
 			interrupts = <49>;
-			interrupt-names	= "cmd_irq";
+			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC1_CK>;
 			clock-names = "apb_pclk";
 			resets = <&rcc STM32H7_AHB3_RESET(SDMMC1)>;
@@ -389,7 +389,7 @@ sdmmc2: mmc@48022400 {
 			arm,primecell-periphid = <0x10153180>;
 			reg = <0x48022400 0x400>;
 			interrupts = <124>;
-			interrupt-names	= "cmd_irq";
+			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC2_CK>;
 			clock-names = "apb_pclk";
 			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
index 59e01ce10318..2b452883a708 100644
--- a/arch/arm/boot/dts/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -77,10 +77,10 @@ &clk_hse {
 
 &mac {
 	status = "disabled";
-	pinctrl-0	= <&ethernet_rmii>;
-	pinctrl-names	= "default";
-	phy-mode	= "rmii";
-	phy-handle	= <&phy0>;
+	pinctrl-0 = <&ethernet_rmii>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
 
 	mdio0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 38cc7faf6884..5c5d8059bdc7 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -115,10 +115,10 @@ &rtc {
 
 &mac {
 	status = "disabled";
-	pinctrl-0	= <&ethernet_rmii>;
-	pinctrl-names	= "default";
-	phy-mode	= "rmii";
-	phy-handle	= <&phy0>;
+	pinctrl-0 = <&ethernet_rmii>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
 
 	mdio0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
index 9bb73bb61901..f3e70d3b65ac 100644
--- a/arch/arm/boot/dts/stm32h750i-art-pi.dts
+++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
@@ -126,10 +126,10 @@ &dma2 {
 
 &mac {
 	status = "disabled";
-	pinctrl-0	= <&ethernet_rmii>;
-	pinctrl-names	= "default";
-	phy-mode	= "rmii";
-	phy-handle	= <&phy0>;
+	pinctrl-0 = <&ethernet_rmii>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
 
 	mdio0 {
 		#address-cells = <1>;
-- 
2.34.1

