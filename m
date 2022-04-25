Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E362450E2A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiDYOII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiDYOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:07:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3005B82C4;
        Mon, 25 Apr 2022 07:04:41 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B602A22246;
        Mon, 25 Apr 2022 16:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650895480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bUitewNJHajFmjL/ogC1mENRsNcvM4rPxiJv4gb2Hoc=;
        b=ukM1SZgQSSmvD2B13UP6HtlKZwz+OkIhyKhywqhhd9wtkkGSRzld1ZO24fMKcNLWBTYdCy
        RxMDh3ubMI0NiXgq+Bv5LFE0O3PiD7deTySmdG0ZQsS6620f+ls69MML+Mt8cWuuqxZ38c
        LzU9D2G6ujI0/24gBpq0c4Ta1pRgvis=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
Date:   Mon, 25 Apr 2022 16:04:33 +0200
Message-Id: <20220425140433.33936-1-michael@walle.cc>
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

Convert the fsl,layerscape-dcfg binding to the new YAML format.

In the device trees, the device node always have a "syscon"
compatible, which wasn't mentioned in the previous binding.

One thing added here, compared to the original binding is the clock
controller subnode of the LS1028A SoC and its "simple-mfd" compatible as
used in arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi as well as the
little-endian and big-endian properties.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - moved to soc/fsl/fsl,layerscape-dcfg.yaml
 - generic name for node in example
 - mention added "syscon" compatible in commit message
 - reference specific clock controller

 .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 ------
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
deleted file mode 100644
index 10a91cc8b997..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Freescale DCFG
-
-DCFG is the device configuration unit, that provides general purpose
-configuration and status for the device. Such as setting the secondary
-core start address and release the secondary core from holdoff and startup.
-
-Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-dcfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a
-
-  - reg : should contain base address and length of DCFG memory-mapped registers
-
-Example:
-	dcfg: dcfg@1ee0000 {
-		compatible = "fsl,ls1021a-dcfg";
-		reg = <0x0 0x1ee0000 0x0 0x10000>;
-	};
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
new file mode 100644
index 000000000000..397f75909b20
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/fsl,layerscape-dcfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape Device Configuration Unit
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Li Yang <leoyang.li@nxp.com>
+
+description: |
+  DCFG is the device configuration unit, that provides general purpose
+  configuration and status for the device. Such as setting the secondary
+  core start address and release the secondary core from holdoff and
+  startup.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,ls1012a-dcfg
+              - fsl,ls1021a-dcfg
+              - fsl,ls1043a-dcfg
+              - fsl,ls1046a-dcfg
+              - fsl,ls1088a-dcfg
+              - fsl,ls2080a-dcfg
+              - fsl,lx2160a-dcfg
+          - const: syscon
+
+      - items:
+          - enum:
+              - fsl,ls1028a-dcfg
+          - const: syscon
+          - const: simple-mfd
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
+  "^clock-controller@[0-9a-z]+$":
+    $ref: /schemas/clock/fsl,flexspi-clock.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@1ee0000 {
+        compatible = "fsl,ls1021a-dcfg", "syscon";
+        reg = <0x1ee0000 0x10000>;
+    };
-- 
2.30.2

