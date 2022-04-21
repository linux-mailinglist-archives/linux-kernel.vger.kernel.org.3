Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CC50A43E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349544AbiDUPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiDUPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:33:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557209FC9;
        Thu, 21 Apr 2022 08:30:56 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E35C4221D4;
        Thu, 21 Apr 2022 17:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650555054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DB5FAoSbLWdhpEwEjh6IFzH77cBk+PmntaqbnGfcqjU=;
        b=kbvPYtwokdnUQQv4zexXnjhwUc8QJc5g7JEo/zNQowGai5zb7X02ijc+4W9XlCXzcC70Si
        YD2PB3smg9y3gEbZuYqOnos8K8e9iRfbdn1RlK8RdMqlLydGnIs9/X4Cp9gwJqK+enp5VE
        kFZI5HRbKHUt+HydQgnM0craUf6g5Tg=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
Date:   Thu, 21 Apr 2022 17:30:44 +0200
Message-Id: <20220421153044.3496643-1-michael@walle.cc>
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

One thing added here, compared to the original binding, is the clock
controller subnode of the LS1028A SoC and its "simple-mfd" compatible as
used in arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi as well as the
little-endian and big-endian properties.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 ------
 .../arm/freescale/fsl,layerscape-dcfg.yaml    | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.yaml
new file mode 100644
index 000000000000..4396e96ecfc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,layerscape-dcfg.yaml#
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
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dcfg@1ee0000 {
+        compatible = "fsl,ls1021a-dcfg", "syscon";
+        reg = <0x1ee0000 0x10000>;
+    };
-- 
2.30.2

