Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F1497140
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiAWLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:18:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56072
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236312AbiAWLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:17:04 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0ADE73F1D8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936623;
        bh=MzcCCtaILPUwt6JujPkbi14iVM2cWS8sO8WH+yvwjrc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CKi1yqQhqlHbHsTc8ManRE8KH6Zuo7FEh9RrOz7Lv7Ipk0ewjS0Y9/AGT4vzU+aox
         fdPm7kdYcIPq0tICpp5jt4tbUIp7yfwa6yixoL1eIvtfWNvP/OQxqAahy0+rRfXhPR
         j7O0yMH6vCoOcL1VPgmSs7SgjpY1/+06FJdyY5NXFT/PJr+NdUcbxyATscm0crb9aQ
         Ea+8+Op9tO4PhIUBQnF4vns2q5PlLKwsYg0wHR9AWZkoQC8Zs36nrBjn/93rfX2wQP
         GEx29YTPtuWExRbBWz39YhWCS8EIKBiGBLRT1VBGe5F5kXpTgEakaNbp1Wr9jkuHtx
         3xtfUd56Lpk+Q==
Received: by mail-wm1-f72.google.com with SMTP id a189-20020a1c98c6000000b0034e32e18a21so6660250wme.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzcCCtaILPUwt6JujPkbi14iVM2cWS8sO8WH+yvwjrc=;
        b=mBBYKj59eQVEZtoo2mGRgxHCiWd6prD4xVfCLYoPdUy6JL9fJnNPlYBvX0oiy5uO0+
         JNTXpnoc6A8c9te411tzGVEUcchMQ+NIkUa9wRA2NOfWqGLvaPpiOT5YXIim5CSM0vLw
         UowU9WS874vnXvqClES7YlQ06DH3pScq7cyRsbeDiQwD2tnw93TnyFqBstdMoews95qw
         32JLNmQ7dQWqiajPhW7ahR025Dl3a/t1al1inL+I4zXNEeNNL4ud2AhVkc6aHlfXPGJH
         3Z4DJl8sNkWGd2OkNmmtpdxUGGlGFu27rzxQA59xUhzOeFYtvvHFFi/D/1FFr6pa15de
         c0Wg==
X-Gm-Message-State: AOAM531gn+7fcoo6fL8SDQtlomgn0QOO1UqPbs3EJ/nKbJrVuP+/4z+a
        h4Azl5a/j2P0tspqK2zT3lGmzLCnkdw6W53lcGEz5zZaELXrl8+BOmoIHHb/O4h8GLQTmBrJ3hq
        N5EmbdCqu64JhXmlrrQdk0YxszDBYeQJ0m16CN/b6IA==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr10440920wry.463.1642936621934;
        Sun, 23 Jan 2022 03:17:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8vEp7Vbb4edxetjja0CtTBaq3tLQ3uCo8NoID5rxQyu48rFqaGBrpxZUr1gN+im28clIKWw==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr10440914wry.463.1642936621736;
        Sun, 23 Jan 2022 03:17:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:17:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema
Date:   Sun, 23 Jan 2022 12:16:43 +0100
Message-Id: <20220123111644.25540-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos SoC USB 3.0 DWC3 Controller bindings to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/usb/exynos-usb.txt    |  49 -------
 .../bindings/usb/samsung,exynos-dwc3.yaml     | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index f7ae79825d7d..61c03c0ef19f 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -64,52 +64,3 @@ Example:
 		phys = <&usb2phy 1>;
 		phy-names = "host";
 	};
-
-DWC3
-Required properties:
- - compatible: should be one of the following -
-	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5250/5420.
-	       "samsung,exynos5433-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5433.
-	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
- - #address-cells, #size-cells : should be '1' if the device has sub-nodes
-				 with 'reg' property.
- - ranges: allows valid 1:1 translation between child's address space and
-	   parent's address space
- - clocks: Clock IDs array as required by the controller.
- - clock-names: Names of clocks corresponding to IDs in the clock property.
-                Following clock names shall be provided for different
-                compatibles:
-                 - samsung,exynos5250-dwusb3: "usbdrd30",
-                 - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
-                                              "phyclk",
-                 - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
-                                           "usbdrd30_axius_clk"
- - vdd10-supply: 1.0V powr supply
- - vdd33-supply: 3.0V/3.3V power supply
-
-Sub-nodes:
-The dwc3 core should be added as subnode to Exynos dwc3 glue.
-- dwc3 :
-   The binding details of dwc3 can be found in:
-   Documentation/devicetree/bindings/usb/snps,dwc3.yaml
-
-Example:
-	usb@12000000 {
-		compatible = "samsung,exynos5250-dwusb3";
-		clocks = <&clock 286>;
-		clock-names = "usbdrd30";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		vdd10-supply = <&ldo11_reg>;
-		vdd33-supply = <&ldo9_reg>;
-
-		dwc3 {
-			compatible = "synopsys,dwc3";
-			reg = <0x12000000 0x10000>;
-			interrupts = <0 72 0>;
-			usb-phy = <&usb2_phy &usb3_phy>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
new file mode 100644
index 000000000000..22b91a27d776
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/samsung,exynos-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC USB 3.0 DWC3 Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos5250-dwusb3
+      - samsung,exynos5433-dwusb3
+      - samsung,exynos7-dwusb3
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  ranges: true
+
+  '#size-cells':
+    const: 1
+
+  vdd10-supply:
+    description: 1.0V power supply
+
+  vdd33-supply:
+    description: 3.0V/3.3V power supply
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+    description: Required child node
+
+required:
+  - compatible
+  - '#address-cells'
+  - clocks
+  - clock-names
+  - ranges
+  - '#size-cells'
+  - vdd10-supply
+  - vdd33-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: usbdrd30
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos54333-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aclk
+            - const: susp_clk
+            - const: pipe_pclk
+            - const: phyclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: usbdrd30
+            - const: usbdrd30_susp_clk
+            - const: usbdrd30_axius_clk
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb {
+        compatible = "samsung,exynos5250-dwusb3";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&clock CLK_USBD300>;
+        clock-names = "usbdrd30";
+        vdd33-supply = <&ldo9_reg>;
+        vdd10-supply = <&ldo11_reg>;
+
+        usb@12000000 {
+            compatible = "snps,dwc3";
+            reg = <0x12000000 0x10000>;
+            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+            phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
+            phy-names = "usb2-phy", "usb3-phy";
+            snps,dis_u3_susphy_quirk;
+        };
+    };
-- 
2.32.0

