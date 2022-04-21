Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F250A440
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390152AbiDUPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359696AbiDUPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:34:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217ED7673;
        Thu, 21 Apr 2022 08:31:22 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 40777221D4;
        Thu, 21 Apr 2022 17:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650555081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JdCg+YpeK6cuEDBAcZQNddcy4UjLpNx+E3WQ3o1hlck=;
        b=ZAK6ZIoGDjF4a8yCQdk3/gzdybksfXbID3YSjSUyrCJfViO7CF5H1+BipFchAIjuo+AE+l
        pg7iQqs71vqJwsolH1ixv9J5V7ou1JyjZVpBIn08asVvXHecocLHOOg2ucOE4gTP+PNuBn
        FBnrLRh1ms5LRn9K74tR3XFJKxMBq84=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fsl: convert fsl,layerscape-scfg to YAML
Date:   Thu, 21 Apr 2022 17:31:15 +0200
Message-Id: <20220421153115.3496834-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,layerscape-scfg binding to the new YAML format.

Added, compared to the original binding, is the interrupt-controller
subnode as used in arch/arm/boot/dts/ls1021a.dtsi as well as the
litte-endian and big-endian properties.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm/freescale/fsl,layerscape-scfg.txt     | 19 ------
 .../arm/freescale/fsl,layerscape-scfg.yaml    | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
deleted file mode 100644
index 0ab67b0b216d..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Freescale SCFG
-
-SCFG is the supplemental configuration unit, that provides SoC specific
-configuration and status registers for the chip. Such as getting PEX port
-status.
-
-Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-scfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg: should contain base address and length of SCFG memory-mapped registers
-
-Example:
-	scfg: scfg@1570000 {
-		compatible = "fsl,ls1021a-scfg";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.yaml
new file mode 100644
index 000000000000..b68a9bc68860
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,layerscape-scfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape Supplemental Configuration Unit
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Li Yang <leoyang.li@nxp.com>
+
+description: |
+  SCFG is the supplemental configuration unit, that provides SoC specific
+  configuration and status registers for the chip. Such as getting PEX port
+  status.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,ls1012a-scfg
+          - fsl,ls1021a-scfg
+          - fsl,ls1028a-scfg
+          - fsl,ls1043a-scfg
+          - fsl,ls1046a-scfg
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  little-endian: true
+  big-endian: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^interrupt-controller@[a-z0-9]+$":
+    $ref: /schemas/interrupt-controller.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    scfg@1570000 {
+        compatible = "fsl,ls1021a-scfg", "syscon";
+        reg = <0x1570000 0x10000>;
+    };
-- 
2.30.2

