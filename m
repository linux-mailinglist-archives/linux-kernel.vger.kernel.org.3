Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03F946A001
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442854AbhLFP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390786AbhLFPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5BC08E854;
        Mon,  6 Dec 2021 07:32:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so44394857edr.5;
        Mon, 06 Dec 2021 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gveqmkuyIR4bXSaTi07K6nL81ssSlpbpC6muAjWMIRU=;
        b=W4iWhjqXHW+WVMOufWI0+R/mHFE6K4cRvagSsMQK7dcnQaEV+XAvwmq2331nyPNVF1
         /3Vxuq7mJwuSUILV8s1TSkCJOi0ty39XBTx+TlASvItqjERzRDNQSrFZZGp3NvCFDoZU
         ZPnI/UH1MdevrVRUV0LvuMTrw8nZd7fFrptaEeiQ1/YlHr6/n2utUcU6YCS4vPIpzO7B
         9NxdTpsxYlXHKQxQU7W++SeZz4nlbqQYfJijh+5Y31XUCZNK/4oH9GgrGgNB4HrFvqAZ
         BZh67t6oNfOqrX66HBaICabBuPmM2o7AJATWl/LWydioUJDxHzi5iEvqC9RcEZuLu/T/
         XeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gveqmkuyIR4bXSaTi07K6nL81ssSlpbpC6muAjWMIRU=;
        b=Gr7NXxKHrJiQ8jG84Ulv7w7xE+2XggFvp2ZiaoQlJ9L7kguxwbXKpLGmiMaOH0qeLs
         dteYu84/L5dHPIBuxpuk1rBH6QJg+tnhDZz37XdJRTJwg6nrnRGcWsiS6YdoRQqEk7Zc
         UAqm2f45VOIeihgGMkurU+HCbjnTEnOGrz5U7DtzHRWFboXl3TlCMjWCuUhNkVko1WRb
         84eAJHvGyt9OcH6SygR1Dh/I0XKXhl1RfwEjDeI/rg6bpy36iEOf2+Q/ta/7rNEIkpec
         bg9pEMaDSFYrPcOAeFpovYe1FB9V4LBE8PrHSEPQp5A3bZsBYQ8o+JgyXjIp1eIWwUSx
         Tx9Q==
X-Gm-Message-State: AOAM533/X8A2FBBlFU/E7MSQHdovYEjpzKsxw87Zwm4B/E2EFRpO8uuD
        VibCO3pCXYqaD6xL1P6ueP6IyMqXS3q92EXz
X-Google-Smtp-Source: ABdhPJxbexjhBXpemMwB6tWA3w2N3JqlZHww98XrGEJywP7wRwatR1fHYUj39n+EzZi3c6e5cVJHQQ==
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr47557718ejc.95.1638804746575;
        Mon, 06 Dec 2021 07:32:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id d19sm7364688edt.34.2021.12.06.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:32:26 -0800 (PST)
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
Subject: [PATCH v4 2/7] dt-bindings: clock: Document Exynos7885 CMU bindings
Date:   Mon,  6 Dec 2021 16:31:16 +0100
Message-Id: <20211206153124.427102-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206153124.427102-1-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
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

Changes in v3:
  - Nothing

Changes in v4:
  - Fix leading 0x in example.

 .../clock/samsung,exynos7885-clock.yaml       | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
new file mode 100644
index 000000000000..7e5a9cac2fd2
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
+    cmu_peri: clock-controller@10010000 {
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

