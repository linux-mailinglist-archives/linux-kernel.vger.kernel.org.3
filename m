Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A1471814
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLLDrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:47:51 -0500
Received: from marcansoft.com ([212.63.210.85]:38710 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhLLDrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:47:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7A602425DF;
        Sun, 12 Dec 2021 03:47:43 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
Date:   Sun, 12 Dec 2021 12:47:25 +0900
Message-Id: <20211212034726.26306-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212034726.26306-1-marcan@marcan.st>
References: <20211212034726.26306-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple SPI controller is present in SoCs such as the M1 (t8103) and
M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
doesn't need any special properties, so the binding is trivial.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/spi/apple,spi.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/apple,spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/apple,spi.yaml b/Documentation/devicetree/bindings/spi/apple,spi.yaml
new file mode 100644
index 000000000000..bcbdc8943e92
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/apple,spi.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/apple,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ARM SoC SPI controller
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-spi
+          - apple,t6000-spi
+      - const: apple,spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi: spi@39b104000 {
+        compatible = "apple,t6000-spi", "apple,spi";
+        reg = <0x3 0x9b104000 0x0 0x4000>;
+        interrupt-parent = <&aic>;
+        interrupts = <AIC_IRQ 0 1107 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&clk>;
+      };
+    };
-- 
2.33.0

