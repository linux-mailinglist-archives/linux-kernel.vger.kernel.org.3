Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213ED482BC9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 16:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiABP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 10:58:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42270
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233335AbiABP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 10:58:14 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6146B3F1A5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641139092;
        bh=LtivP7WsTpD9kz9x4I95xynZ1y8EWIVWr2itObbwl8s=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jYZX1FGjp77k7Yy3jbg03w4JeeQLIIqTLc9H8kyzlhjydMGQqA33CaQrqL1OQDhTc
         /XkKBVsY1FX1tEnAFN6u06f7qlpS9H6/+I1kxtZxdrnVOxtGq21Jsvm7RoxqPArlyl
         EotQ1Vac+ApTqTBBhlYTX6ill1+GGC15h0o1F3aWNvgsvJ23QPrQbnt3JJtXHHwwhh
         fVKnRLKSiYee457SJx+bmCNatPo6YwKDTYWREXMI9MwqrtqMZakkZMC/TqFtsxlP9x
         gOxH27AmoF61j2903WcMNqEGkCQdOn/6mBoYd9TXmA5RlfmfsxChO4+5qRQOjPubbs
         RsNnNaUg8Tbxw==
Received: by mail-lf1-f72.google.com with SMTP id k30-20020a0565123d9e00b0042633ae1b8eso5895303lfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 07:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtivP7WsTpD9kz9x4I95xynZ1y8EWIVWr2itObbwl8s=;
        b=wGeWpS50aWHfbFgT9aDZ9FBS2lU0JfY7hkQR+dAkTe6FrJM8Ah6FmZMCPmHCM13C/e
         sGdLelSN1eUjsV8I27rjpQjCmil+U0ulCA49DKa+AbeBx23POnBXjt5K8xRfKGY88cKu
         T/NPgXqUJBMqsCFpNZvMXoq9kv5sfkgeVQRHbzqnUW2W82yBMzoCUoeRKe4+j3DU71i/
         lpY2boIGF/+10tkpK/rOkLffTwk+uIqLKai42opRyAlEiirYB6PkCLx/SLwuAMCRABPA
         7yb9eIKHdK9Mpms3FRs60fbqoVe5OuJzB0EXv9NOJwvQV25qEdXWWVMjHF9gkCB0hPeP
         CsxQ==
X-Gm-Message-State: AOAM533rpPkWdQwhfx88cf1V4NlPz6fUnTxSBL0i4+Bvvu/GgIad3Csz
        XWKgBDp5eJpZuB9IkpTnqoVZgIHrBRni+iJOXBZHOHZuF471mhBKs+4VeXLseKAQgJ/Mv3FKlPq
        Q/Op7WKCT72LoByRHb3cumDmjtseYiFG6BtPhm0WCPg==
X-Received: by 2002:a05:6512:3d17:: with SMTP id d23mr38407854lfv.685.1641139091728;
        Sun, 02 Jan 2022 07:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3N1SgFL84UNCzwOmPpkl4JrwIXRYifA6S9/er7qR0PqoW740HU2aoyIEGBIJJj2ESXFk3mA==
X-Received: by 2002:a05:6512:3d17:: with SMTP id d23mr38407839lfv.685.1641139091489;
        Sun, 02 Jan 2022 07:58:11 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k19sm3377612lfv.87.2022.01.02.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 07:58:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] spi: dt-bindings: samsung: convert to dtschema
Date:   Sun,  2 Jan 2022 16:58:07 +0100
Message-Id: <20220102155807.42758-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
References: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
controller bindings to DT schema format

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/spi/samsung,spi.yaml  | 220 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ----------
 MAINTAINERS                                   |   2 +-
 3 files changed, 221 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
new file mode 100644
index 000000000000..195bfafe05fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -0,0 +1,220 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/samsung,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C/S5P/Exynos SoC SPI controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description:
+  All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' where n is a unique number for the alias.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,s3c2443-spi
+          - samsung,s3c6410-spi
+          - samsung,s5pv210-spi
+          - samsung,exynos5433-spi
+      - const: samsung,exynos7-spi
+        deprecated: true
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+  cs-gpios: true
+
+  dmas:
+    minItems: 2
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  no-cs-readback:
+    description:
+      The CS line is disconnected, therefore the device should not operate
+      based on CS signalling.
+    type: boolean
+
+  num-cs:
+    minimum: 1
+    maximum: 4
+    default: 1
+
+  samsung,spi-src-clk:
+    description:
+      If the spi controller includes a internal clock mux to select the clock
+      source for the spi bus clock, this property can be used to indicate the
+      clock to be used for driving the spi bus clock. If not specified, the
+      clock number 0 is used as default.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    allOf:
+      - $ref: spi-peripheral-props.yaml
+
+    properties:
+      controller-data:
+        type: object
+        additionalProperties: false
+
+        properties:
+          samsung,spi-feedback-delay:
+            description: |
+              The sampling phase shift to be applied on the miso line (to account
+              for any lag in the miso line). Valid values:
+               - 0: No phase shift.
+               - 1: 90 degree phase shift sampling.
+               - 2: 180 degree phase shift sampling.
+               - 3: 270 degree phase shift sampling.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+
+        required:
+          - samsung,spi-feedback-delay
+
+    required:
+      - controller-data
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - interrupts
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-spi
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: spi
+            - enum:
+                - spi_busclk0
+                - spi_busclk1
+                - spi_busclk2
+                - spi_busclk3
+            - const: spi_ioclk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: spi
+            - enum:
+                - spi_busclk0
+                - spi_busclk1
+                - spi_busclk2
+                - spi_busclk3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/clock/samsung,s2mps11.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi@14d30000 {
+        compatible = "samsung,exynos5433-spi";
+        reg = <0x14d30000 0x100>;
+        interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&pdma0 11>, <&pdma0 10>;
+        dma-names = "tx", "rx";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&cmu_peric CLK_PCLK_SPI1>,
+                 <&cmu_peric CLK_SCLK_SPI1>,
+                 <&cmu_peric CLK_SCLK_IOCLK_SPI1>;
+        clock-names = "spi",
+                      "spi_busclk0",
+                      "spi_ioclk";
+        samsung,spi-src-clk = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi1_bus>;
+        num-cs = <1>;
+
+        cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
+        status = "okay";
+
+        audio-codec@0 {
+            compatible = "wlf,wm5110";
+            reg = <0x0>;
+            spi-max-frequency = <20000000>;
+            interrupt-parent = <&gpa0>;
+            interrupts = <4 IRQ_TYPE_NONE>;
+            clocks = <&pmu_system_controller 0>,
+                     <&s2mps13_osc S2MPS11_CLK_BT>;
+            clock-names = "mclk1", "mclk2";
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            wlf,micd-detect-debounce = <300>;
+            wlf,micd-bias-start-time = <0x1>;
+            wlf,micd-rate = <0x7>;
+            wlf,micd-dbtime = <0x2>;
+            wlf,micd-force-micbias;
+            wlf,micd-configs = <0x0 1 0>;
+            wlf,hpdet-channel = <1>;
+            wlf,gpsw = <0x1>;
+            wlf,inmode = <2 0 2 0>;
+
+            wlf,reset = <&gpc0 7 GPIO_ACTIVE_HIGH>;
+            wlf,ldoena = <&gpf0 0 GPIO_ACTIVE_HIGH>;
+
+            /* core supplies */
+            AVDD-supply = <&ldo18_reg>;
+            DBVDD1-supply = <&ldo18_reg>;
+            CPVDD-supply = <&ldo18_reg>;
+            DBVDD2-supply = <&ldo18_reg>;
+            DBVDD3-supply = <&ldo18_reg>;
+            SPKVDDL-supply = <&ldo18_reg>;
+            SPKVDDR-supply = <&ldo18_reg>;
+
+            controller-data {
+                samsung,spi-feedback-delay = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
deleted file mode 100644
index 49028a4f5df1..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ /dev/null
@@ -1,122 +0,0 @@
-* Samsung SPI Controller
-
-The Samsung SPI controller is used to interface with various devices such as flash
-and display controllers using the SPI communication interface.
-
-Required SoC Specific Properties:
-
-- compatible: should be one of the following.
-    - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
-    - samsung,s3c6410-spi: for s3c6410 platforms
-    - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
-    - samsung,exynos5433-spi: for exynos5433 compatible controllers
-    - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-  depends on the interrupt controller.
-
-- dmas : Two or more DMA channel specifiers following the convention outlined
-  in bindings/dma/dma.txt
-
-- dma-names: Names for the dma channels. There must be at least one channel
-  named "tx" for transmit and named "rx" for receive.
-
-- clocks: specifies the clock IDs provided to the SPI controller; they are
-  required for interacting with the controller itself, for synchronizing the bus
-  and as I/O clock (the latter is required by exynos5433 and exynos7).
-
-- clock-names: string names of the clocks in the 'clocks' property; for all the
-  the devices the names must be "spi", "spi_busclkN" (where N is determined by
-  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
-  "spi_ioclk" for the I/O clock.
-
-Required Board Specific Properties:
-
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-
-Optional Board Specific Properties:
-
-- samsung,spi-src-clk: If the spi controller includes a internal clock mux to
-  select the clock source for the spi bus clock, this property can be used to
-  indicate the clock to be used for driving the spi bus clock. If not specified,
-  the clock number 0 is used as default.
-
-- num-cs: Specifies the number of chip select lines supported. If
-  not specified, the default number of chip select lines is set to 1.
-
-- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
-
-- no-cs-readback: the CS line is disconnected, therefore the device should not
-  operate based on CS signalling.
-
-SPI Controller specific data in SPI slave nodes:
-
-- The spi slave nodes should provide the following information which is required
-  by the spi controller.
-
-  - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
-    miso line (to account for any lag in the miso line). The following are the
-    valid values.
-
-      - 0: No phase shift.
-      - 1: 90 degree phase shift sampling.
-      - 2: 180 degree phase shift sampling.
-      - 3: 270 degree phase shift sampling.
-
-Aliases:
-
-- All the SPI controller nodes should be represented in the aliases node using
-  the following format 'spi{n}' where n is a unique number for the alias.
-
-
-Example:
-
-- SoC Specific Portion:
-
-	spi_0: spi@12d20000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x12d20000 0x100>;
-		interrupts = <0 66 0>;
-		dmas = <&pdma0 5
-			&pdma0 4>;
-		dma-names = "tx", "rx";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-- Board Specific Portion:
-
-	spi_0: spi@12d20000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&spi0_bus>;
-		cs-gpios = <&gpa2 5 0>;
-
-		w25q80bw@0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "w25x80";
-			reg = <0>;
-			spi-max-frequency = <10000>;
-
-			controller-data {
-				samsung,spi-feedback-delay = <0>;
-			};
-
-			partition@0 {
-				label = "U-Boot";
-				reg = <0x0 0x40000>;
-				read-only;
-			};
-
-			partition@40000 {
-				label = "Kernel";
-				reg = <0x40000 0xc0000>;
-			};
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index af392bd04874..572eb97f1855 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17058,7 +17058,7 @@ M:	Andi Shyti <andi@etezian.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
+F:	Documentation/devicetree/bindings/spi/samsung,spi.yaml
 F:	drivers/spi/spi-s3c*
 F:	include/linux/platform_data/spi-s3c64xx.h
 F:	include/linux/spi/s3c24xx-fiq.h
-- 
2.32.0

