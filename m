Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0937F482AFB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiABLy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40036
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233049AbiABLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:13 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7A553FFDF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124452;
        bh=sVrUpDSg8NwWhYRmOsqO9mine4H/Vnj5+07GmNGcxww=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fT+lttOZh7Tabf/uEbRNhZ9t89ymalHnGcBxohaNWdvzA4C/8dOsOoq41OjLG1EOw
         3Xh1Hhx02FVmZKtsEe2WTYHUB97qx073qQJ50qvEqtC8+/3yUi41SeOLLs9sNXXIxf
         9ummlI4Xuu2Umk0zqfZXJH9EUD/1dtEMIX74REmRJLdrXBzUArQPuMmTBiY1ZEKVCi
         FFv/+189B8rodT+cIf7F1jLmGJrHKryrzghbEKUmPjXkroX5/0scyr62j+p4vtR49J
         XOFb8XN0zL0J3OBw97r+DtsD9wTizSX0XyP8SiySdbXjQpo6b/Ccdc4aXj7VZX9rbr
         jI3QLMyzqwhOA==
Received: by mail-lf1-f70.google.com with SMTP id bq6-20020a056512150600b0041bf41f5437so5761620lfb.17
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVrUpDSg8NwWhYRmOsqO9mine4H/Vnj5+07GmNGcxww=;
        b=vNwvLk64JVmI/xygvMuUCYo4hbWnQCwOXSZpBrkrl9Kove7SOnS3wxIZJt1hN6i/dG
         1wtGhp6ZrKwdAdkUqpNeWX2i4ahtgTBlOE1cB3xx4SDmS1oAaUJqb5vfjJKCfNc/yuwA
         DyhDnAW1zuQAYEupVhWz3IBi5g39Hpkbw6KCT2DuKqOarqTZne8JmsIX6jf4kI4yDHCs
         hVGVXi7INfkywcDdbFHCKVPT6cKkKHCSa5hNGECtYuSR7tMrip/tnAkldR7OvsbrQqRb
         tlmkwrlaqBcCO3EzdiAw3P5rbRUSCEGXuxw8KXGio6AZAVBP2y2BFEGfRWiVuJtdLYgb
         Z+hg==
X-Gm-Message-State: AOAM533pzw3mqJ4OoesLWrOqgVZ01OMWYMY66bfIS9SMPCzBtzJ0qkLh
        mfjFDiLbubcFBry5FsgxHsrMH+cYVOsWzSOlGC0o6gl7Ku7iPIS2wQluGHpcT0X01YOtpau22sR
        CV0If0rYaVfsz3rSLm0wBMcI6RXG55h2qBuSWEYXXRA==
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr35791118lfd.515.1641124452124;
        Sun, 02 Jan 2022 03:54:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVLcAnxsmuOJwZg89oMc4pN6NZpd/ZGA4WiB2lx0Oy+EyRcH1AVaPN8nRjmzTgrsVPy9sWGA==
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr35791106lfd.515.1641124451919;
        Sun, 02 Jan 2022 03:54:11 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:11 -0800 (PST)
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
Subject: [PATCH 8/8] dt-bindings: clock: samsung: convert S5Pv210 to dtschema
Date:   Sun,  2 Jan 2022 12:53:56 +0100
Message-Id: <20220102115356.75796-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung S5Pv210 SoC clock controller bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/samsung,s5pv210-clock.txt  | 77 ------------------
 .../bindings/clock/samsung,s5pv210-clock.yaml | 79 +++++++++++++++++++
 MAINTAINERS                                   |  1 -
 3 files changed, 79 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
deleted file mode 100644
index a86c83bf9d4e..000000000000
--- a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* Samsung S5P6442/S5PC110/S5PV210 Clock Controller
-
-Samsung S5P6442, S5PC110 and S5PV210 SoCs contain integrated clock
-controller, which generates and supplies clock to various controllers
-within the SoC.
-
-Required Properties:
-
-- compatible: should be one of following:
-	- "samsung,s5pv210-clock" : for clock controller of Samsung
-	  S5PC110/S5PV210 SoCs,
-	- "samsung,s5p6442-clock" : for clock controller of Samsung
-	  S5P6442 SoC.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/s5pv210.h header and can be used in device tree sources.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xxti": external crystal oscillator connected to XXTI and XXTO pins of
-the SoC,
- - "xusbxti": external crystal oscillator connected to XUSBXTI and XUSBXTO
-pins of the SoC,
-
-A subset of above clocks available on given board shall be specified in
-board device tree, including the system base clock, as selected by XOM[0]
-pin of the SoC. Refer to generic fixed rate clock bindings
-documentation[1] for more information how to specify these clocks.
-
-[1] Documentation/devicetree/bindings/clock/fixed-clock.yaml
-
-Example: Clock controller node:
-
-	clock: clock-controller@7e00f000 {
-		compatible = "samsung,s5pv210-clock";
-		reg = <0x7e00f000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-Example: Required external clocks:
-
-	xxti: clock-xxti {
-		compatible = "fixed-clock";
-		clock-output-names = "xxti";
-		clock-frequency = <24000000>;
-		#clock-cells = <0>;
-	};
-
-	xusbxti: clock-xusbxti {
-		compatible = "fixed-clock";
-		clock-output-names = "xusbxti";
-		clock-frequency = <24000000>;
-		#clock-cells = <0>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller (refer to the standard clock bindings for information about
-  "clocks" and "clock-names" properties):
-
-	uart0: serial@e2900000 {
-		compatible = "samsung,s5pv210-uart";
-		reg = <0xe2900000 0x400>;
-		interrupt-parent = <&vic1>;
-		interrupts = <10>;
-		clock-names = "uart", "clk_uart_baud0",
-				"clk_uart_baud1";
-		clocks = <&clocks UART0>, <&clocks UART0>,
-				<&clocks SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
new file mode 100644
index 000000000000..dcb29a2d1159
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,s5pv210-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P6442/S5PC110/S5PV210 SoC clock controller
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
+    - "xxti" - external crystal oscillator connected to XXTI and XXTO pins of
+      the SoC,
+    - "xusbxti" - external crystal oscillator connected to XUSBXTI and XUSBXTO
+      pins of the SoC,
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/s5pv210.h header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s5pv210-clock
+      - samsung,s5p6442-clock
+
+  clocks:
+    items:
+      - description: xxti clock
+      - description: xusbxti clock
+
+  clock-names:
+    items:
+      - const: xxti
+      - const: xusbxti
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
+    #include <dt-bindings/clock/s5pv210.h>
+
+    xxti: clock-0 {
+        compatible = "fixed-clock";
+        clock-frequency = <0>;
+        clock-output-names = "xxti";
+        #clock-cells = <0>;
+    };
+
+    xusbxti: clock-1 {
+        compatible = "fixed-clock";
+        clock-frequency = <0>;
+        clock-output-names = "xusbxti";
+        #clock-cells = <0>;
+    };
+
+    clock-controller@e0100000 {
+        compatible = "samsung,s5pv210-clock";
+        reg = <0xe0100000 0x10000>;
+        clock-names = "xxti", "xusbxti";
+        clocks = <&xxti>, <&xusbxti>;
+        #clock-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0aa6a2728a7c..d7db7054455d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17038,7 +17038,6 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
 F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
 F:	Documentation/devicetree/bindings/clock/samsung,s3c*
-F:	Documentation/devicetree/bindings/clock/samsung,s5p*
 F:	drivers/clk/samsung/
 F:	include/dt-bindings/clock/exynos*.h
 F:	include/dt-bindings/clock/s3c*.h
-- 
2.32.0

