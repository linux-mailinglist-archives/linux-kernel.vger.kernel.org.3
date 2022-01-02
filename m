Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECADD482AF0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiABLyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39952
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233008AbiABLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:09 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31ABA402E5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124445;
        bh=6MziEDmxDLLq7dpcXtr5w/qlbjRnfWWI7dqaJWWHokU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Xbv5pQbyVnZFG1Mesxn4+Pag5JZFjBEBsH8cQICTV5MPBCA3EHTIOOherHrLBtIb2
         VqaZGMqtqKzA7qA0A3tx0Ff2KzkeT+mgbWrMP1nle6YqRrqlHD8Uk7a/eQBbRb5K5s
         O2YuhwFyE6Gh+kTuQZQX9i42giqnrCyDhPV97xaLyrYQAp3QduaOqvlWiBFIHU5vyx
         YzrC1dSwIADZTFRuEOge4Z1uAulh2mz2x5qiIlGHPAiWS+FwGFF2ieDzRRYuBVH88L
         fx92nDgw6rceO1IHOc6n2dHKQYjFWi19f9tKcG150nF8H7X4a6RIa7p7eeqTWtrwkt
         5+A2DaMgzgIJA==
Received: by mail-lf1-f70.google.com with SMTP id t196-20020a19c3cd000000b0042a2598bebaso1478034lff.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MziEDmxDLLq7dpcXtr5w/qlbjRnfWWI7dqaJWWHokU=;
        b=RJJG5cvBJEFt/OKVZp6mSx1eGApXKxEbIxPMU3CoScJ5LHuoID2u1Pu/HPV4/u1vw/
         LPI4zV6scHmQFPgoIW7KgeoBTLkodaLi6kTN7WGvTvrH5CEi191XdX6JLFmlaxMcimur
         3oxfy7HdSOkvnLNIVuJf7c7KVPFTYqBxM1mDL+T2knTcsxlTrYI2XEsTI9L9ViD9JhAq
         Yo3zJRokS8ZFLIPUkz92Dnz3+Vn6ctnjgpPCGUyBZlM3qKrnbd2Tcc8AersZFs/JrAoT
         EfUSX6YtdCOefR3IJDIxjcJ56YX74qaJBl8ePM+KJWGPAUlVOmE+PIZzlq1IWeuaTLBA
         1Z1Q==
X-Gm-Message-State: AOAM531ednKCYmBzKkBLUjGSdIZoCfwKfgP+W4Fo5YSwOxoNgMa+yqvC
        pk0nrfh4FJ3lqpl+Ua87MG2RFhwN61qJCPzPbG3NVHXpNcsvX1065XkFgz1fxQT3edz6ZGhkh/k
        GLsckjRYUbqlPA+6I3VAW7Q2iQJQ4lraANdAadY7gdg==
X-Received: by 2002:a05:6512:3c9f:: with SMTP id h31mr38088180lfv.334.1641124444380;
        Sun, 02 Jan 2022 03:54:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo80y7gqQgbsygu/GP4o2FHWOa/oS3yhGl52Nvj2Alj7wN7WyHOnWpKsRZDHFXhj+29X0ojw==
X-Received: by 2002:a05:6512:3c9f:: with SMTP id h31mr38088175lfv.334.1641124444168;
        Sun, 02 Jan 2022 03:54:04 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: clock: samsung: convert Exynos7 to dtschema
Date:   Sun,  2 Jan 2022 12:53:52 +0100
Message-Id: <20220102115356.75796-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos7 SoC clock controller bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos7-clock.txt          | 108 -------
 .../bindings/clock/samsung,exynos7-clock.yaml | 269 ++++++++++++++++++
 2 files changed, 269 insertions(+), 108 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
deleted file mode 100644
index 6bf1e7493f61..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ /dev/null
@@ -1,108 +0,0 @@
-* Samsung Exynos7 Clock Controller
-
-Exynos7 clock controller has various blocks which are instantiated
-independently from the device-tree. These clock controllers
-generate and supply clocks to various hardware blocks within
-the SoC.
-
-Each clock is assigned an identifier and client nodes can use
-this identifier to specify the clock which they consume. All
-available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos7-clk.h header and can be used in
-device tree sources.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It
-is expected that they are defined using standard clock bindings
-with following clock-output-names:
-
- - "fin_pll" - PLL input clock from XXTI
-
-Required Properties for Clock Controller:
-
- - compatible: clock controllers will use one of the following
-	compatible strings to indicate the clock controller
-	functionality.
-
-	- "samsung,exynos7-clock-topc"
-	- "samsung,exynos7-clock-top0"
-	- "samsung,exynos7-clock-top1"
-	- "samsung,exynos7-clock-ccore"
-	- "samsung,exynos7-clock-peric0"
-	- "samsung,exynos7-clock-peric1"
-	- "samsung,exynos7-clock-peris"
-	- "samsung,exynos7-clock-fsys0"
-	- "samsung,exynos7-clock-fsys1"
-	- "samsung,exynos7-clock-mscl"
-	- "samsung,exynos7-clock-aud"
-
- - reg: physical base address of the controller and the length of
-	memory mapped region.
-
- - #clock-cells: should be 1.
-
- - clocks: list of clock identifiers which are fed as the input to
-	the given clock controller. Please refer the next section to
-	find the input clocks for a given controller.
-
-- clock-names: list of names of clocks which are fed as the input
-	to the given clock controller.
-
-Input clocks for top0 clock controller:
-	- fin_pll
-	- dout_sclk_bus0_pll
-	- dout_sclk_bus1_pll
-	- dout_sclk_cc_pll
-	- dout_sclk_mfc_pll
-	- dout_sclk_aud_pll
-
-Input clocks for top1 clock controller:
-	- fin_pll
-	- dout_sclk_bus0_pll
-	- dout_sclk_bus1_pll
-	- dout_sclk_cc_pll
-	- dout_sclk_mfc_pll
-
-Input clocks for ccore clock controller:
-	- fin_pll
-	- dout_aclk_ccore_133
-
-Input clocks for peric0 clock controller:
-	- fin_pll
-	- dout_aclk_peric0_66
-	- sclk_uart0
-
-Input clocks for peric1 clock controller:
-	- fin_pll
-	- dout_aclk_peric1_66
-	- sclk_uart1
-	- sclk_uart2
-	- sclk_uart3
-	- sclk_spi0
-	- sclk_spi1
-	- sclk_spi2
-	- sclk_spi3
-	- sclk_spi4
-	- sclk_i2s1
-	- sclk_pcm1
-	- sclk_spdif
-
-Input clocks for peris clock controller:
-	- fin_pll
-	- dout_aclk_peris_66
-
-Input clocks for fsys0 clock controller:
-	- fin_pll
-	- dout_aclk_fsys0_200
-	- dout_sclk_mmc2
-
-Input clocks for fsys1 clock controller:
-	- fin_pll
-	- dout_aclk_fsys1_200
-	- dout_sclk_mmc0
-	- dout_sclk_mmc1
-
-Input clocks for aud clock controller:
-	- fin_pll
-	- fout_aud_pll
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
new file mode 100644
index 000000000000..f3fa6c7ef48b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
@@ -0,0 +1,269 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos7-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos7 SoC clock controller
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Expected external clocks, defined in DTS as fixed-rate clocks with a matching
+  name::
+    - "fin_pll" - PLL input clock from XXTI
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/exynos7-clk.h header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos7-clock-topc
+      - samsung,exynos7-clock-top0
+      - samsung,exynos7-clock-top1
+      - samsung,exynos7-clock-ccore
+      - samsung,exynos7-clock-peric0
+      - samsung,exynos7-clock-peric1
+      - samsung,exynos7-clock-peris
+      - samsung,exynos7-clock-fsys0
+      - samsung,exynos7-clock-fsys1
+      - samsung,exynos7-clock-mscl
+      - samsung,exynos7-clock-aud
+
+  clocks:
+    minItems: 1
+    maxItems: 13
+
+  clock-names:
+    minItems: 1
+    maxItems: 13
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-top0
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_sclk_bus0_pll
+            - const: dout_sclk_bus1_pll
+            - const: dout_sclk_cc_pll
+            - const: dout_sclk_mfc_pll
+            - const: dout_sclk_aud_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-top1
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_sclk_bus0_pll
+            - const: dout_sclk_bus1_pll
+            - const: dout_sclk_cc_pll
+            - const: dout_sclk_mfc_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-ccore
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_ccore_133
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-peric0
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_peric0_66
+            - const: sclk_uart0
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-peric1
+    then:
+      properties:
+        clocks:
+          minItems: 13
+          maxItems: 13
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_peric1_66
+            - const: sclk_uart1
+            - const: sclk_uart2
+            - const: sclk_uart3
+            - const: sclk_spi0
+            - const: sclk_spi1
+            - const: sclk_spi2
+            - const: sclk_spi3
+            - const: sclk_spi4
+            - const: sclk_i2s1
+            - const: sclk_pcm1
+            - const: sclk_spdif
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-peris
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_peris_66
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-fsys0
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_fsys0_200
+            - const: dout_sclk_mmc2
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-fsys1
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_fsys1_200
+            - const: dout_sclk_mmc0
+            - const: dout_sclk_mmc1
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-clock-aud
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: fout_aud_pll
+      required:
+        - clock-names
+        - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos7-clk.h>
+
+    fin_pll: clock {
+        compatible = "fixed-clock";
+        clock-output-names = "fin_pll";
+        #clock-cells = <0>;
+        clock-frequency = <24000000>;
+    };
+
+    clock-controller@105e0000 {
+        compatible = "samsung,exynos7-clock-top1";
+        reg = <0x105e0000 0xb000>;
+        #clock-cells = <1>;
+        clocks = <&fin_pll>,
+                 <&clock_topc DOUT_SCLK_BUS0_PLL>,
+                 <&clock_topc DOUT_SCLK_BUS1_PLL>,
+                 <&clock_topc DOUT_SCLK_CC_PLL>,
+                 <&clock_topc DOUT_SCLK_MFC_PLL>;
+        clock-names = "fin_pll",
+                      "dout_sclk_bus0_pll",
+                      "dout_sclk_bus1_pll",
+                      "dout_sclk_cc_pll",
+                      "dout_sclk_mfc_pll";
+    };
-- 
2.32.0

