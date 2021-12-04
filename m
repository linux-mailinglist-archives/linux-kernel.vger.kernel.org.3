Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB164687DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbhLDWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbhLDWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:01:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32494C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 13:58:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso7539844wmr.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 13:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcRHvW6bfEvOLIyYySuv2qE2GSS7ehbl/asNSPEPqM4=;
        b=OxluEssHaHt7b4Y1wzk2CJ2CYgLfrnV/SOjRgF5vkWac43NVlHwNDlSfNdtHhMB80T
         rTGlepvaNLu6+BX1EYd9QoLIe/hAbqiTM3cju7y8nLium7OleT9jelzZb7FLjqdV0KME
         0zMerUUm8AyE9us2zkPWmM3XrFw1JqWGmdUoVIUfZKknPt+fofl8L9NtC4DBtaV+Y/pi
         XebiI4XzyLrvaCoV+lD32fkcGnVwIZP5InWoW2jqZfdNmjMvh7qmlJzCYLmaGCTReQy7
         uutw5BhARgHt0LhDvDHT4GtUbNex7OwswcotkfYynkr2s//y7/8sfzLGydof4ZXjsUC+
         aEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcRHvW6bfEvOLIyYySuv2qE2GSS7ehbl/asNSPEPqM4=;
        b=77+bLUKvcJdDA1y0mNR79zzEeNd57DeyxRe004m7g2cLJ9NwRT5YdgdmG1Yx9vAX2S
         k8ee9s8Dp5sD8sVPK6XAksCcejTMPEd99Lw6auGG9/lQa7VxXWiaZ1PLOdwUy4oVfr+/
         FPsi38CdtMj1iIgQWylMs5IKJo7OnhKXbai6qLWL1oVEJNzsMdlrhI8Uzy6sfaoo1/HJ
         Ylzg7HVAqJdxLqUnk2W/y3Cy5yLYwkJTtPkzWFpylE4KQiwxWaKgAdCvdK+PJlYKtuGi
         KrbFSZjQJ7oA7SqLGKMIZboS6TtCUkPOB1dvbJZdeWlu5jN28uzSMcaqtwHRSLvE0tKO
         PUMw==
X-Gm-Message-State: AOAM533hpU6pq/+4TiTtO4ocB70arkorM2nbW0JOqywiqYy5wUd0zhv8
        USVeVPq8aknJTInzmQvYYrkXhA==
X-Google-Smtp-Source: ABdhPJwVC8MKd1vm071VRJRXaqyeKtlMiHmYQZ0TpGQP/SNUSu5amnBQKqwqI0LBLWvYE9IE23mpPQ==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr26055932wmq.172.1638655102741;
        Sat, 04 Dec 2021 13:58:22 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id az4sm9249960wmb.20.2021.12.04.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 13:58:22 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 RESEND 1/8] dt-bindings: i2c: exynos5: Convert to dtschema
Date:   Sat,  4 Dec 2021 23:58:13 +0200
Message-Id: <20211204215820.17378-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204215820.17378-1-semen.protsenko@linaro.org>
References: <20211204215820.17378-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos High Speed I2C bindings doc to DT schema format.

Changes during bindings conversion:
1. Added missing required clock properties (driver fails when it's
   unable to get the clock)
2. Removed properties and descriptions that can be found in
   schemas/i2c/i2c-controller.yaml [1]
3. Fixed the example so it can be validated by dtschema

[1] https://github.com/robherring/dt-schema/blob/master/schemas/i2c/i2c-controller.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
Changes in v2:
  - Added R-b tag by Krzysztof Kozlowski

 .../devicetree/bindings/i2c/i2c-exynos5.txt   | 53 ------------
 .../devicetree/bindings/i2c/i2c-exynos5.yaml  | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt b/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
deleted file mode 100644
index 2dbc0b62daa6..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Samsung's High Speed I2C controller
-
-The Samsung's High Speed I2C controller is used to interface with I2C devices
-at various speeds ranging from 100khz to 3.4Mhz.
-
-Required properties:
-  - compatible: value should be.
-	-> "samsung,exynos5-hsi2c", (DEPRECATED)
-				for i2c compatible with HSI2C available
-				on Exynos5250 and Exynos5420 SoCs.
-	-> "samsung,exynos5250-hsi2c", for i2c compatible with HSI2C available
-				on Exynos5250 and Exynos5420 SoCs.
-	-> "samsung,exynos5260-hsi2c", for i2c compatible with HSI2C available
-				on Exynos5260 SoCs.
-	-> "samsung,exynos7-hsi2c", for i2c compatible with HSI2C available
-				on Exynos7 SoCs.
-
-  - reg: physical base address of the controller and length of memory mapped
-    region.
-  - interrupts: interrupt number to the cpu.
-  - #address-cells: always 1 (for i2c addresses)
-  - #size-cells: always 0
-
-  - Pinctrl:
-    - pinctrl-0: Pin control group to be used for this controller.
-    - pinctrl-names: Should contain only one value - "default".
-
-Optional properties:
-  - clock-frequency: Desired operating frequency in Hz of the bus.
-    -> If not specified, the bus operates in fast-speed mode at
-       at 100khz.
-    -> If specified, the bus operates in high-speed mode only if the
-       clock-frequency is >= 1Mhz.
-
-Example:
-
-hsi2c@12ca0000 {
-	compatible = "samsung,exynos5250-hsi2c";
-	reg = <0x12ca0000 0x100>;
-	interrupts = <56>;
-	clock-frequency = <100000>;
-
-	pinctrl-0 = <&i2c4_bus>;
-	pinctrl-names = "default";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	s2mps11_pmic@66 {
-		compatible = "samsung,s2mps11-pmic";
-		reg = <0x66>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
new file mode 100644
index 000000000000..16853f6edc53
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-exynos5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung's High Speed I2C controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  The Samsung's High Speed I2C controller is used to interface with I2C devices
+  at various speeds ranging from 100kHz to 3.4MHz.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,exynos5250-hsi2c    # Exynos5250 and Exynos5420
+          - samsung,exynos5260-hsi2c    # Exynos5260
+          - samsung,exynos7-hsi2c       # Exynos7
+      - const: samsung,exynos5-hsi2c    # Exynos5250 and Exynos5420
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    default: 100000
+    description:
+      Desired operating frequency in Hz of the bus.
+
+      If not specified, the bus operates in fast-speed mode at 100kHz.
+
+      If specified, the bus operates in high-speed mode only if the
+      clock-frequency is >= 1MHz.
+
+  clocks:
+    maxItems: 1
+    description: I2C operating clock
+
+  clock-names:
+    const: hsi2c
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    hsi2c_8: i2c@12e00000 {
+        compatible = "samsung,exynos5250-hsi2c";
+        reg = <0x12e00000 0x1000>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-frequency = <100000>;
+        clocks = <&clock CLK_USI4>;
+        clock-names = "hsi2c";
+
+        pmic@66 {
+            /* compatible = "samsung,s2mps11-pmic"; */
+            reg = <0x66>;
+        };
+    };
-- 
2.30.2

