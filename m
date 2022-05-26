Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD985354FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbiEZUrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349168AbiEZUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D04BC2B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so3144780edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBaqWUZdGRxVXZa/3xFn5e0ng0GgoHiZioilUw5+2nw=;
        b=Cv0JakkXE60pGLI7Iyhf67f1yhGMoKIqoT+mBKLUK6Ga875dfGpC9/btNCcIg99qBA
         UzrB7bs7Wh7HvZk6CwGBEv7Tv0e/WgtEX2C22p4pdGQsYLT6ufYXQT/MOJv8FHqGwXxj
         /TB9LO7I459hEYE+b9x7XYbDD54uLPepZvzKWl0E1RBCL0q1LvNOmuxD1rFvC9GzMW8/
         D75bhWgOULe3Ra0NRkagjYu+U3+XdeAo+US/j8hTQMgv7U2ZGA3U6oeL6uRw1a7OFglI
         +U1gFGAS0nnMCxHD4VpKI8MRIGRrHrAelcjB8cNDQMGmrL/9ilYx0+NhqtHL084FhPJ/
         eueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBaqWUZdGRxVXZa/3xFn5e0ng0GgoHiZioilUw5+2nw=;
        b=U4o9CiQU0ZdHKwksfwVaqimsTNqvQIBnEaVb45q7L29eqG1WzKyvRN8utgubsk784P
         PE2x4r+Rz1j6vUeL/rCjp57qhWvh6mIV6eUwsqCugOu2NeLWLLGBIuTyDf1L9ACb0VkL
         mDc6EwbXdyBlvLoV5LN0WheyArw5b45MVMSOdtFZjwDtUNfeamR4rPc0PktXHH2au4YR
         Rhh5ml73J6U+AIbn8cgI1ldmaK1wj4J888StEoGgMtOVskmgVK5XpvJ2TyoHhAzB1xSA
         BlgBVH8b0qoJb33NjQ2vCk9Jbf6Ci9BvdNLglIJai9BQKNAHgOKqFRl8uLgOOSC18ZEU
         fftA==
X-Gm-Message-State: AOAM532/BDCEL9ge/LdHXs06Sc/qnJ/NSrW8ABpxGAi8VEiD3Q0hUFfF
        BE5UWaqWZyfbmFoFRyDvg8xxRBmrhsIoWUvW
X-Google-Smtp-Source: ABdhPJyHWBYYGWWKKVa+ctitylRhZbBsaUfysB9c86pss61rRr5dSIfVUtjmrT45kwD7kqrjoXIc6w==
X-Received: by 2002:a05:6402:221a:b0:42b:c764:9c9f with SMTP id cq26-20020a056402221a00b0042bc7649c9fmr10690849edb.75.1653597975466;
        Thu, 26 May 2022 13:46:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b006ff16f48e2asm813254ejc.76.2022.05.26.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:46:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Chanho Min <chanho.min@lge.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] arm64: dts: lg: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:46:06 +0200
Message-Id: <20220526204606.833054-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 38 +++++++++++++++---------------
 arch/arm64/boot/dts/lg/lg1313.dtsi | 38 +++++++++++++++---------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index bec97480a960..78ae73d0cf36 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -52,7 +52,7 @@ L2_0: l2-cache0 {
 	};
 
 	psci {
-		compatible  = "arm,psci-0.2", "arm,psci";
+		compatible = "arm,psci-0.2", "arm,psci";
 		method = "smc";
 		cpu_suspend = <0x84000001>;
 		cpu_off = <0x84000002>;
@@ -150,7 +150,7 @@ uart0: serial@fe000000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		uart1: serial@fe100000 {
 			compatible = "arm,pl011", "arm,primecell";
@@ -158,7 +158,7 @@ uart1: serial@fe100000 {
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		uart2: serial@fe200000 {
 			compatible = "arm,pl011", "arm,primecell";
@@ -166,7 +166,7 @@ uart2: serial@fe200000 {
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
@@ -197,7 +197,7 @@ gpio0: gpio@fd400000 {
 			reg = <0x0 0xfd400000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio1: gpio@fd410000 {
 			#gpio-cells = <2>;
@@ -206,7 +206,7 @@ gpio1: gpio@fd410000 {
 			reg = <0x0 0xfd410000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio2: gpio@fd420000 {
 			#gpio-cells = <2>;
@@ -215,7 +215,7 @@ gpio2: gpio@fd420000 {
 			reg = <0x0 0xfd420000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio3: gpio@fd430000 {
 			#gpio-cells = <2>;
@@ -232,7 +232,7 @@ gpio4: gpio@fd440000 {
 			reg = <0x0 0xfd440000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio5: gpio@fd450000 {
 			#gpio-cells = <2>;
@@ -241,7 +241,7 @@ gpio5: gpio@fd450000 {
 			reg = <0x0 0xfd450000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio6: gpio@fd460000 {
 			#gpio-cells = <2>;
@@ -250,7 +250,7 @@ gpio6: gpio@fd460000 {
 			reg = <0x0 0xfd460000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio7: gpio@fd470000 {
 			#gpio-cells = <2>;
@@ -259,7 +259,7 @@ gpio7: gpio@fd470000 {
 			reg = <0x0 0xfd470000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio8: gpio@fd480000 {
 			#gpio-cells = <2>;
@@ -268,7 +268,7 @@ gpio8: gpio@fd480000 {
 			reg = <0x0 0xfd480000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio9: gpio@fd490000 {
 			#gpio-cells = <2>;
@@ -277,7 +277,7 @@ gpio9: gpio@fd490000 {
 			reg = <0x0 0xfd490000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio10: gpio@fd4a0000 {
 			#gpio-cells = <2>;
@@ -286,7 +286,7 @@ gpio10: gpio@fd4a0000 {
 			reg = <0x0 0xfd4a0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio11: gpio@fd4b0000 {
 			#gpio-cells = <2>;
@@ -303,7 +303,7 @@ gpio12: gpio@fd4c0000 {
 			reg = <0x0 0xfd4c0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio13: gpio@fd4d0000 {
 			#gpio-cells = <2>;
@@ -312,7 +312,7 @@ gpio13: gpio@fd4d0000 {
 			reg = <0x0 0xfd4d0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio14: gpio@fd4e0000 {
 			#gpio-cells = <2>;
@@ -321,7 +321,7 @@ gpio14: gpio@fd4e0000 {
 			reg = <0x0 0xfd4e0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio15: gpio@fd4f0000 {
 			#gpio-cells = <2>;
@@ -330,7 +330,7 @@ gpio15: gpio@fd4f0000 {
 			reg = <0x0 0xfd4f0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio16: gpio@fd500000 {
 			#gpio-cells = <2>;
@@ -339,7 +339,7 @@ gpio16: gpio@fd500000 {
 			reg = <0x0 0xfd500000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio17: gpio@fd510000 {
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index ada3d4dc6305..2173316573be 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -52,7 +52,7 @@ L2_0: l2-cache0 {
 	};
 
 	psci {
-		compatible  = "arm,psci-0.2", "arm,psci";
+		compatible = "arm,psci-0.2", "arm,psci";
 		method = "smc";
 		cpu_suspend = <0x84000001>;
 		cpu_off = <0x84000002>;
@@ -150,7 +150,7 @@ uart0: serial@fe000000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		uart1: serial@fe100000 {
 			compatible = "arm,pl011", "arm,primecell";
@@ -158,7 +158,7 @@ uart1: serial@fe100000 {
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		uart2: serial@fe200000 {
 			compatible = "arm,pl011", "arm,primecell";
@@ -166,7 +166,7 @@ uart2: serial@fe200000 {
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
@@ -197,7 +197,7 @@ gpio0: gpio@fd400000 {
 			reg = <0x0 0xfd400000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio1: gpio@fd410000 {
 			#gpio-cells = <2>;
@@ -206,7 +206,7 @@ gpio1: gpio@fd410000 {
 			reg = <0x0 0xfd410000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio2: gpio@fd420000 {
 			#gpio-cells = <2>;
@@ -215,7 +215,7 @@ gpio2: gpio@fd420000 {
 			reg = <0x0 0xfd420000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio3: gpio@fd430000 {
 			#gpio-cells = <2>;
@@ -232,7 +232,7 @@ gpio4: gpio@fd440000 {
 			reg = <0x0 0xfd440000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio5: gpio@fd450000 {
 			#gpio-cells = <2>;
@@ -241,7 +241,7 @@ gpio5: gpio@fd450000 {
 			reg = <0x0 0xfd450000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio6: gpio@fd460000 {
 			#gpio-cells = <2>;
@@ -250,7 +250,7 @@ gpio6: gpio@fd460000 {
 			reg = <0x0 0xfd460000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio7: gpio@fd470000 {
 			#gpio-cells = <2>;
@@ -259,7 +259,7 @@ gpio7: gpio@fd470000 {
 			reg = <0x0 0xfd470000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio8: gpio@fd480000 {
 			#gpio-cells = <2>;
@@ -268,7 +268,7 @@ gpio8: gpio@fd480000 {
 			reg = <0x0 0xfd480000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio9: gpio@fd490000 {
 			#gpio-cells = <2>;
@@ -277,7 +277,7 @@ gpio9: gpio@fd490000 {
 			reg = <0x0 0xfd490000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio10: gpio@fd4a0000 {
 			#gpio-cells = <2>;
@@ -286,7 +286,7 @@ gpio10: gpio@fd4a0000 {
 			reg = <0x0 0xfd4a0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio11: gpio@fd4b0000 {
 			#gpio-cells = <2>;
@@ -303,7 +303,7 @@ gpio12: gpio@fd4c0000 {
 			reg = <0x0 0xfd4c0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio13: gpio@fd4d0000 {
 			#gpio-cells = <2>;
@@ -312,7 +312,7 @@ gpio13: gpio@fd4d0000 {
 			reg = <0x0 0xfd4d0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio14: gpio@fd4e0000 {
 			#gpio-cells = <2>;
@@ -321,7 +321,7 @@ gpio14: gpio@fd4e0000 {
 			reg = <0x0 0xfd4e0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio15: gpio@fd4f0000 {
 			#gpio-cells = <2>;
@@ -330,7 +330,7 @@ gpio15: gpio@fd4f0000 {
 			reg = <0x0 0xfd4f0000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio16: gpio@fd500000 {
 			#gpio-cells = <2>;
@@ -339,7 +339,7 @@ gpio16: gpio@fd500000 {
 			reg = <0x0 0xfd500000 0x1000>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
-			status="disabled";
+			status = "disabled";
 		};
 		gpio17: gpio@fd510000 {
 			#gpio-cells = <2>;
-- 
2.34.1

