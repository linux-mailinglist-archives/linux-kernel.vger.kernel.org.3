Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BA482AFD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiABLyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40008
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233036AbiABLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:12 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48F2D3FFDB
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124451;
        bh=dVLQ1qN9FW9xMlqjzpYbQn0o4kW0DEZo+VJEeUILFvE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VkLTfxrgohixGnpnF0OPndUnuhRSxZhbLqtQjwMxZS+6a7h/g2XDd0VmNyFdkixbR
         7KPvvkbejWO4TUWsznr9JI3fGpj7vkfmqRpQKQAu7FFWAaK+STxC5wr1Le0nz/VwTi
         5IIq+1KT6YdaVEEL/Pz7XgwiHFRwsI4aVZVFi9HAxjdhJd7XgUN0eAUq7az08j8qPr
         ZpKVtQ2YTZ7bZG2eYL/QU3qKQ8ZIB4FKbTe9jRAgQuo77Ep74H2Mx0zRiM7u/1w/AP
         7ZSoOo0XNnstQT+rr3HZm5T+jHtnRrKpKIRJ6Xogxlo+RnxbATKJn5HJY2Scg0SCeT
         PYKPetxIAy94g==
Received: by mail-lf1-f70.google.com with SMTP id k25-20020a056512331900b004259a8d8090so5772323lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVLQ1qN9FW9xMlqjzpYbQn0o4kW0DEZo+VJEeUILFvE=;
        b=zJ9kFtfsMufb4xngGBDPUjD0WWGKPIYiJHP7s/8DCrPAi64DiCYLJ2PI0Nl8IO093a
         bNtoBXpNhWgCJ30OR7+jIk93T353AIFQr15iG/KmvfvKxcFJoq4hyuw0ZWHcw5nhivOn
         gkKPqKNlT6WoJ+lyQqzV0Hw64ihqGdvo+oloMK0pfK4f81A+OnvAKU7Jp/mmTY3lzaQF
         ncGbX7F8PW4GrYzr7GqZrCcelcBGGq9MpJz87rU+hlh47P9KlwnAyl5RvMckCn2cNgOJ
         fYbIfG9nEJ70lIu64sXl5W9Wcfd8NCmV+GXI+z9i6JLTUY9ywrvKgeLniz8Yfs1iod5R
         jxuQ==
X-Gm-Message-State: AOAM532QRyC+BI4uRcw7uKJ7d1vA0lZebF+QlG0rzcCDzfq28ybdP6SZ
        79tAqn6xUTuA1ioxj/dOGisDHCjpT1VeSrh1qM02HNavTZEtqbPJoUVTHlPlPytcDugpwNCoXIX
        GWdyI6esBvL7aac16afZxsElZYfmzRZ8YVkXw3UlHlA==
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr37114357lfb.359.1641124450734;
        Sun, 02 Jan 2022 03:54:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPGbVl4ddCFrxN4q2rhTZV7vAxvBmnmt840AkVm4ahxLYb5H0jNIPb/mo9eB4T4/WQgDZERQ==
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr37114349lfb.359.1641124450547;
        Sun, 02 Jan 2022 03:54:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:09 -0800 (PST)
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
Subject: [PATCH 7/8] dt-bindings: clock: samsung: convert Exynos5410 to dtschema
Date:   Sun,  2 Jan 2022 12:53:55 +0100
Message-Id: <20220102115356.75796-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos5410 SoC clock controller bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos5410-clock.txt       | 50 --------------
 .../clock/samsung,exynos5410-clock.yaml       | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 -
 3 files changed, 66 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
deleted file mode 100644
index 217beb27c30e..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Samsung Exynos5410 Clock Controller
-
-The Exynos5410 clock controller generates and supplies clock to various
-controllers within the Exynos5410 SoC.
-
-Required Properties:
-
-- compatible: should be "samsung,exynos5410-clock"
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-- clocks: should contain an entry specifying the root clock from external
-  oscillator supplied through XXTI or XusbXTI pin.  This clock should be
-  defined using standard clock bindings with "fin_pll" clock-output-name.
-  That clock is being passed internally to the 9 PLLs.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos5410.h header and can be used in device
-tree sources.
-
-Example 1: An example of a clock controller node is listed below.
-
-	fin_pll: xxti {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "fin_pll";
-		#clock-cells = <0>;
-	};
-
-	clock: clock-controller@10010000 {
-		compatible = "samsung,exynos5410-clock";
-		reg = <0x10010000 0x30000>;
-		#clock-cells = <1>;
-		clocks = <&fin_pll>;
-	};
-
-Example 2: UART controller node that consumes the clock generated by the clock
-	   controller. Refer to the standard clock bindings for information
-	   about 'clocks' and 'clock-names' property.
-
-	serial@12c20000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C00000 0x100>;
-		interrupts = <0 51 0>;
-		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
new file mode 100644
index 000000000000..032862e9f55b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos5410-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5410 SoC clock controller
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
+  include/dt-bindings/clock/exynos5410.h header.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,exynos5410-clock
+
+  clocks:
+    description:
+      Should contain an entry specifying the root clock from external
+      oscillator supplied through XXTI or XusbXTI pin.  This clock should be
+      defined using standard clock bindings with "fin_pll" clock-output-name.
+      That clock is being passed internally to the 9 PLLs.
+    maxItems: 1
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5410.h>
+
+    fin_pll: osc-clock {
+        compatible = "fixed-clock";
+        clock-frequency = <24000000>;
+        clock-output-names = "fin_pll";
+        #clock-cells = <0>;
+    };
+
+    clock-controller@10010000 {
+        compatible = "samsung,exynos5410-clock";
+        reg = <0x10010000 0x30000>;
+        #clock-cells = <1>;
+        clocks = <&fin_pll>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea5655a29c3..0aa6a2728a7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17036,7 +17036,6 @@ M:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
-F:	Documentation/devicetree/bindings/clock/exynos*.txt
 F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
 F:	Documentation/devicetree/bindings/clock/samsung,s3c*
 F:	Documentation/devicetree/bindings/clock/samsung,s5p*
-- 
2.32.0

