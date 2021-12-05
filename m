Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C34468D9B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhLEWP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbhLEWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:15:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE932C061714;
        Sun,  5 Dec 2021 14:12:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so35000233edq.7;
        Sun, 05 Dec 2021 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaAXF/jM1quvdXKsD0jNnLghJPsfB9aR0znyeDSyiGw=;
        b=E5m1sH4H/YOEPR3AGlNNJC612lEmRcG4ln1xIZVUb+50RnfgyqXA4o+LTZh9pAKiIx
         RjEwDdGnhXcngIrPh2FjSyzE45vMi2/M2XYnL6bOe695KD/YQArsyR+XP8HY9fcGHPXV
         PLSTscMxIqjd7mMAz/FfrsgmuLn149ss8uguDlqDBEvGrv5L7iZEv3MTtIklQ4un4kVR
         xYFtnJF5WUzy9Ohvnfs0xN++afVXlEhhiHvxRB0AOEr30vH8pgMYRZKkyHCrZsukNudQ
         oQBXGKzez3l4gH+jDetvqUyC7xcDkJhuwMYOdSx2vvCwcw86Bl3srR1W9tU+c69aItmY
         HG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaAXF/jM1quvdXKsD0jNnLghJPsfB9aR0znyeDSyiGw=;
        b=4fkGVuUmh6pa6HRZjBRgh+CYhA5BwAFI6hCw047JV8KkcQIKzvZRCpnmgQWfkPK0n5
         a29etwDEn1JxBvrMDVVSDwRsbsHJm1HJAQsRaBRGwJURVHgO6c+FCjsQ6mnWZXWzuYvX
         RXIzO75IAJ6M1uBxRZqrLLKBckfFJHD6j4cuDmFH6KJNAbDzB+fDO4LbiSpRLlm/vYg7
         KbavwyLgml8WyqJ8FkhwNZMCJF71PwKu93XN4PZnuo4l/jQY2fYs4Nglh8HrmzYGtDB/
         LQpHN5fqd/4ZYesF4XNr0uRz1/ydc4A23EeU6JYc5xAheyJjq5pDaIBt8g2l3r9BpI2q
         HpFw==
X-Gm-Message-State: AOAM533BNEykDllD5E+ent2nzrvFQgzh1rIn2zG7yWRMsIVn074pVBFz
        PujPftsBvqg/HIN/zV/ID8w=
X-Google-Smtp-Source: ABdhPJwO5tGZSiB8zoyURNMpR8XLJOly4vBwQpwcmi8uV2VDvRLAeS6rs/BR6qWJEkJ3Y/gGbDLlAA==
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr41243227ejb.51.1638742346487;
        Sun, 05 Dec 2021 14:12:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id gb18sm5608079ejc.95.2021.12.05.14.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:12:26 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: clock: Document Exynos7885 CMU bindings
Date:   Sun,  5 Dec 2021 23:11:01 +0100
Message-Id: <20211205221108.193400-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205221108.193400-1-virag.david003@gmail.com>
References: <20211205221108.193400-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide dt-schema documentation for Exynos7885 SoC clock controller.
Description is modified from Exynos850 clock controller documentation as
I couldn't describe it any better, that was written by Sam Protsenko.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: David Virag <virag.david003@gmail.com>
---
Changes in v2:
  - Fixed double : in description
  - Added R-b tag by Krzysztof Kozlowski

 .../clock/samsung,exynos7885-clock.yaml       | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
new file mode 100644
index 000000000000..63f95d6ec190
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos7885-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos7885 SoC clock controller
+
+maintainers:
+  - Dávid Virág <virag.david003@gmail.com>
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Exynos7885 clock controller is comprised of several CMU units, generating
+  clocks for different domains. Those CMU units are modeled as separate device
+  tree nodes, and might depend on each other. The root clock in that root tree
+  is an external clock: OSCCLK (26 MHz). This external clock must be defined
+  as a fixed-rate clock in dts.
+
+  CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
+  dividers; all other leaf clocks (other CMUs) are usually derived from CMU_TOP.
+
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All clocks available for usage
+  in clock consumer nodes are defined as preprocessor macros in
+  'dt-bindings/clock/exynos7885.h' header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos7885-cmu-top
+      - samsung,exynos7885-cmu-core
+      - samsung,exynos7885-cmu-peri
+
+  clocks:
+    minItems: 1
+    maxItems: 10
+
+  clock-names:
+    minItems: 1
+    maxItems: 10
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7885-cmu-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+
+        clock-names:
+          items:
+            - const: oscclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7885-cmu-core
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_CORE bus clock (from CMU_TOP)
+            - description: CCI clock (from CMU_TOP)
+            - description: G3D clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_core_bus
+            - const: dout_core_cci
+            - const: dout_core_g3d
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7885-cmu-peri
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_PERI bus clock (from CMU_TOP)
+            - description: SPI0 clock (from CMU_TOP)
+            - description: SPI1 clock (from CMU_TOP)
+            - description: UART0 clock (from CMU_TOP)
+            - description: UART1 clock (from CMU_TOP)
+            - description: UART2 clock (from CMU_TOP)
+            - description: USI0 clock (from CMU_TOP)
+            - description: USI1 clock (from CMU_TOP)
+            - description: USI2 clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_peri_bus
+            - const: dout_peri_spi0
+            - const: dout_peri_spi1
+            - const: dout_peri_uart0
+            - const: dout_peri_uart1
+            - const: dout_peri_uart2
+            - const: dout_peri_usi0
+            - const: dout_peri_usi1
+            - const: dout_peri_usi2
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Clock controller node for CMU_PERI
+  - |
+    #include <dt-bindings/clock/exynos7885.h>
+
+    cmu_peri: clock-controller@0x10010000 {
+        compatible = "samsung,exynos7885-cmu-peri";
+        reg = <0x10010000 0x8000>;
+        #clock-cells = <1>;
+
+        clocks = <&oscclk>,
+                 <&cmu_top CLK_DOUT_PERI_BUS>,
+                 <&cmu_top CLK_DOUT_PERI_SPI0>,
+                 <&cmu_top CLK_DOUT_PERI_SPI1>,
+                 <&cmu_top CLK_DOUT_PERI_UART0>,
+                 <&cmu_top CLK_DOUT_PERI_UART1>,
+                 <&cmu_top CLK_DOUT_PERI_UART2>,
+                 <&cmu_top CLK_DOUT_PERI_USI0>,
+                 <&cmu_top CLK_DOUT_PERI_USI1>,
+                 <&cmu_top CLK_DOUT_PERI_USI2>;
+        clock-names = "oscclk",
+                      "dout_peri_bus",
+                      "dout_peri_spi0",
+                      "dout_peri_spi1",
+                      "dout_peri_uart0",
+                      "dout_peri_uart1",
+                      "dout_peri_uart2",
+                      "dout_peri_usi0",
+                      "dout_peri_usi1",
+                      "dout_peri_usi2";
+    };
+
+...
-- 
2.34.1

