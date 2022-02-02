Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF14A7458
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiBBPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:13:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40998
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345387AbiBBPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:13:33 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 641863F4B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643814812;
        bh=iLc3G6YH7/qnd/6MBLVC0gYFOAHbytgg/CHu+i+G3Xk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=l0RjJPeRobWl8E4JtBIW+/tfP0baT0FPo1eU33y/YIi8zjHNK3UNZRGJmcuERh2T6
         hKfwMJPvAvCqQXbFoyVyHvVbso5LWzprGAfrQPWiB6F8SmM//LaIeKNni8KYGXkGVn
         5V1zpBslkDDHPQvj1Jyr9rj48afnscPVymIFc14Bd528TI+kE6rGs+bFDeIoE/LHAy
         AAdUp4raMvTunV0JmvoDU9pBh7MzdQs+rZBRNQHcciC+S81R1kZss6pqOxXe0njYmB
         5QUnE9au+q9y/eDZmRNkDajLcBu5NzlvZ78OPIsc2VU8m5AiBNe5038sH3Duykk7H+
         2LJ0ay8Yaw7Tg==
Received: by mail-wm1-f70.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso4063963wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLc3G6YH7/qnd/6MBLVC0gYFOAHbytgg/CHu+i+G3Xk=;
        b=2tnjMTWAsrUOguRuTeFFHXZJQbSAKuDsE8R3t8Wx3ighZId7f/7ALGHhpKB2+wFafV
         SZ1qZzYAIGU/nXbBnSQpGNKhklU/4qn7gAcoK4GKVuQ+GCuhIqbWDvg8Z//DkRyuXZnl
         q3azKVtFuMs4LtgqIdJzues505bcbYXOwvTn/b9BOaVlKxideZ2Uil1qgt7eV9/9q8Z7
         mGCWyZrCpUqiL3Z84aD7PMi3FxBOwRwfjyPt2/AyaYSgAn+M7aM1ylD5hlM9jI0EdqJo
         YX+ZVjqoDpxcTFw2/gMYYFrHPjlF962WPMhS0aFoO97fntoD+OvgVVV54sH2ARn9+j0h
         8s7A==
X-Gm-Message-State: AOAM532Tmmk1x8eslHHk4fnUKPuE/azpHLUC4rm6aYnJ0fCNCSGlN3am
        wSY4vsXOx6weGOFpbfLb5OHuA1tiS1DgbzPJmmnNND8iePVvV75siDzhbU+f8GFjzIdcMt2OdEc
        sOHbKk8se3ibfNiDJDV83ewI2m8TPTvqw7YJwEgk0xg==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr20021682wrz.700.1643814812014;
        Wed, 02 Feb 2022 07:13:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw74yve7th3H3L856WxT+OL6uQFH9rhguofhpxZXCx5JlJrmjaGkzwUXjdw3yHNp9V3hNbiSA==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr20021662wrz.700.1643814811802;
        Wed, 02 Feb 2022 07:13:31 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p7sm5098872wmq.20.2022.02.02.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:13:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/3] dt-bindings: mfd: samsung,exynos5433-lpass: Convert to dtschema
Date:   Wed,  2 Feb 2022 16:13:10 +0100
Message-Id: <20220202151310.285561-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
References: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Exynos5433 LPASS bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
 .../mfd/samsung,exynos5433-lpass.yaml         | 117 ++++++++++++++++++
 2 files changed, 117 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
deleted file mode 100644
index 30ea27c3936d..000000000000
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
-
-Required properties:
-
- - compatible		: "samsung,exynos5433-lpass"
- - reg			: should contain the LPASS top SFR region location
-			  and size
- - clock-names		: should contain following required clocks: "sfr0_ctrl"
- - clocks		: should contain clock specifiers of all clocks, which
-			  input names have been specified in clock-names
-			  property, in same order.
- - #address-cells	: should be 1
- - #size-cells		: should be 1
- - ranges		: must be present
-
-Each IP block of the Low Power Audio Subsystem should be specified as
-an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
-UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
-
-Bindings of the sub-nodes are described in:
-  ../serial/samsung_uart.yaml
-  ../sound/samsung-i2s.txt
-  ../dma/arm-pl330.txt
-
-
-Example:
-
-audio-subsystem {
-	compatible = "samsung,exynos5433-lpass";
-	reg = <0x11400000 0x100>, <0x11500000 0x08>;
-	clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
-	clock-names = "sfr0_ctrl";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	adma: adma@11420000 {
-		compatible = "arm,pl330", "arm,primecell";
-		reg = <0x11420000 0x1000>;
-		interrupts = <0 73 0>;
-		clocks = <&cmu_aud CLK_ACLK_DMAC>;
-		clock-names = "apb_pclk";
-		#dma-cells = <1>;
-		#dma-channels = <8>;
-		#dma-requests = <32>;
-	};
-
-	i2s0: i2s0@11440000 {
-		compatible = "samsung,exynos7-i2s";
-		reg = <0x11440000 0x100>;
-		dmas = <&adma 0 &adma 2>;
-		dma-names = "tx", "rx";
-		interrupts = <0 70 0>;
-		clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
-			 <&cmu_aud CLK_SCLK_AUD_I2S>,
-			 <&cmu_aud CLK_SCLK_I2S_BCLK>;
-		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2s0_bus>;
-	};
-
-	serial_3: serial@11460000 {
-		compatible = "samsung,exynos5433-uart";
-		reg = <0x11460000 0x100>;
-		interrupts = <0 67 0>;
-		clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
-			 <&cmu_aud CLK_SCLK_AUD_UART>;
-		clock-names = "uart", "clk_uart_baud0";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart_aud_bus>;
-	};
- };
diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
new file mode 100644
index 000000000000..bae55c98961c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,exynos5433-lpass.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Low Power Audio Subsystem (LPASS)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,exynos5433-lpass
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sfr0_ctrl
+
+  power-domains:
+    maxItems: 1
+
+  ranges: true
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^dma-controller@[0-9a-f]+$":
+    $ref: /schemas/dma/arm,pl330.yaml
+
+  "^i2s@[0-9a-f]+$":
+    $ref: /schemas/sound/samsung-i2s.yaml
+
+  "^serial@[0-9a-f]+$":
+    $ref: /schemas/serial/samsung_uart.yaml
+
+required:
+  - compatible
+  - '#address-cells'
+  - clocks
+  - clock-names
+  - ranges
+  - reg
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    audio-subsystem@11400000 {
+        compatible = "samsung,exynos5433-lpass";
+        reg = <0x11400000 0x100>, <0x11500000 0x08>;
+        clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
+        clock-names = "sfr0_ctrl";
+        power-domains = <&pd_aud>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        dma-controller@11420000 {
+            compatible = "arm,pl330", "arm,primecell";
+            reg = <0x11420000 0x1000>;
+            interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_aud CLK_ACLK_DMAC>;
+            clock-names = "apb_pclk";
+            #dma-cells = <1>;
+            #dma-channels = <8>;
+            #dma-requests = <32>;
+            power-domains = <&pd_aud>;
+        };
+
+        i2s@11440000 {
+            compatible = "samsung,exynos7-i2s";
+            reg = <0x11440000 0x100>;
+            dmas = <&adma 0>, <&adma 2>;
+            dma-names = "tx", "rx";
+            interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
+                     <&cmu_aud CLK_SCLK_AUD_I2S>,
+                     <&cmu_aud CLK_SCLK_I2S_BCLK>;
+            clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+            #clock-cells = <1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&i2s0_bus>;
+            power-domains = <&pd_aud>;
+            #sound-dai-cells = <1>;
+        };
+
+        serial@11460000 {
+            compatible = "samsung,exynos5433-uart";
+            reg = <0x11460000 0x100>;
+            interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
+                     <&cmu_aud CLK_SCLK_AUD_UART>;
+            clock-names = "uart", "clk_uart_baud0";
+            pinctrl-names = "default";
+            pinctrl-0 = <&uart_aud_bus>;
+            power-domains = <&pd_aud>;
+        };
+    };
-- 
2.32.0

