Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6E494188
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357310AbiASUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:10:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58580
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357259AbiASUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:10:16 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57A1140037
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623014;
        bh=QjRllAYQYdOXGm303csM0n/kH3zayd8k8FhnaI7vQn0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kHo8lpKjm7LCaQcCWqqmFL6qgi98t7m7pyG4gJWlKKYhTFxOWSsZDkwozoKE3+5Ak
         Yjup2eAki2wlY9HSd6D/0Wf4gwaJBqWYNojG3WO7CBjbG9mYgqBMLFqgZQSoenoqsE
         RSwprYK2MLlTzNbS0oEjvh0CiySvyK4gimf5SXvqY/lVwOaP9Pd5HQlF1SNQlxsl83
         MLQ6G+m11xnM+vNAo75NrjCws0kO0Qe/oi7aQN7uVOm3e7dXYGdoeBxMC1HYH4yiWx
         UlHcSw97eZLDpdi8VM4iZzZo9KpXRw/adusO1+u39fvnfmv0EOMsL2kF5EJaOWyvyf
         C1n+dZb3tMU2w==
Received: by mail-ed1-f72.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso3792007edw.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjRllAYQYdOXGm303csM0n/kH3zayd8k8FhnaI7vQn0=;
        b=mi0odNvSxmgA4j19earyrGej7+LNlHrUVFrQayeW8Ib6cKCOrJr1HnGdWBc+YMHFzV
         ZPEVpD+CXAYXmnThxJFGB+c5BaVMlvdAmQcoT7t2NUyPCuL7d0xpyp2/JwqGvnT+Dh9W
         8ubWXFJyaRMA/wvmebkIJDtgysFmQtl9S+NIbN1yDWOashW9EbgB7T4cRaozChTCZjct
         d+4OTfMyeRLlJkdFm78XSiMQM9j4Wx3Wsf1rDyvR87bDgyEerDcau3exeR5sqZFp/zUj
         65BpCWjC/coKZ4nU7dOUVfNdUII4IGTleH9OIWn1QMdw3Qy6fO+luAhwr+4M66l9jsnR
         z95w==
X-Gm-Message-State: AOAM531Z5BrANAS8c1vlXe3/WtIoleFzvY0yXu2IE066fk/EUsXO5jbq
        gapNHuUvW/n3rWCXfN4h+rS8PzZsNZIyrz6XBF4fVkp7t0aGEkig0xPuARW5ih6HYUoMfqgedMd
        TvzuJOSj8wf6OAvsfmUEP0lF/qPs3WoOQaMF7xJtlvQ==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr26154614ejc.557.1642623013555;
        Wed, 19 Jan 2022 12:10:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzJ5AD6sNzhhSvIxESEdGRpQTQiur9R3wawShtp7N+vDKaou3lbxl8avcAto0wenroeJINSA==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr26154590ejc.557.1642623013206;
        Wed, 19 Jan 2022 12:10:13 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 2/5] spi: dt-bindings: samsung: convert to dtschema
Date:   Wed, 19 Jan 2022 21:10:02 +0100
Message-Id: <20220119201005.13145-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
controller bindings to DT schema format

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
 .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 6 files changed, 225 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index 273f2d95a043..e72b6a3fae99 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -22,7 +22,7 @@ description: |
 
   [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
   [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
-  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
+  [3] Documentation/devicetree/bindings/spi/samsung,spi.yaml
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
new file mode 100644
index 000000000000..aa5a1f48494b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+properties:
+  controller-data:
+    type: object
+    additionalProperties: false
+
+    properties:
+      samsung,spi-feedback-delay:
+        description: |
+          The sampling phase shift to be applied on the miso line (to account
+          for any lag in the miso line). Valid values:
+           - 0: No phase shift.
+           - 1: 90 degree phase shift sampling.
+           - 2: 180 degree phase shift sampling.
+           - 3: 270 degree phase shift sampling.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+
+    required:
+      - samsung,spi-feedback-delay
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
new file mode 100644
index 000000000000..61c77088e8ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -0,0 +1,187 @@
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
+          - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
+          - samsung,s3c6410-spi
+          - samsung,s5pv210-spi # for S5PV210 and S5PC110
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
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..df885eeb144f 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -85,5 +85,6 @@ properties:
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
+  - $ref: samsung,spi-peripheral-props.yaml#
 
 additionalProperties: true
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
index 5ea5655a29c3..1f951bc877f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17054,7 +17054,7 @@ M:	Andi Shyti <andi@etezian.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
+F:	Documentation/devicetree/bindings/spi/samsung,spi*.yaml
 F:	drivers/spi/spi-s3c*
 F:	include/linux/platform_data/spi-s3c64xx.h
 F:	include/linux/spi/s3c24xx-fiq.h
-- 
2.32.0

