Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10725112FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359196AbiD0H5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359142AbiD0H5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:57:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808814585A;
        Wed, 27 Apr 2022 00:53:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD49C2224E;
        Wed, 27 Apr 2022 09:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651046027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHj8Kou7jO8BNYgik9QQT7XahJy0bju+c9x5EmPkq+Y=;
        b=K41lDRsp12VRgR/KMTqpEQY6DXk/ODC8VQLswwqFjFoVaVZAgh7vKd0E4rngFNFvjRBfOH
        FxCJUwcQhwzBb2tlcRrLaX4juliKKH0HW/QkuL0GbCeLlh73K0KugFVKpQ43Ehoo5LiMSE
        d8RV4NLT65Jzvd3oOPVY7Q5eZCU3/JE=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/4] dt-bindings: fsl: convert fsl,layerscape-scfg to YAML
Date:   Wed, 27 Apr 2022 09:53:38 +0200
Message-Id: <20220427075338.1156449-5-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427075338.1156449-1-michael@walle.cc>
References: <20220427075338.1156449-1-michael@walle.cc>
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

In the device trees, the device node always have a "syscon"
compatible, which wasn't mentioned in the previous binding.

Also added, compared to the original binding, is the
interrupt-controller subnode as used in arch/arm/boot/dts/ls1021a.dtsi
as well as the litte-endian and big-endian properties.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes since v2:
 - none

changes since v1:
 - moved to soc/fsl/fsl,layerscape-scfg.yaml
 - generic name for node in example
 - mention added "syscon" compatible in commit message
 - reference specific interrupt controller

 .../arm/freescale/fsl,layerscape-scfg.txt     | 19 ------
 .../bindings/soc/fsl/fsl,layerscape-scfg.yaml | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml

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
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
new file mode 100644
index 000000000000..8d088b5fe823
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/fsl,layerscape-scfg.yaml#
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
+    $ref: /schemas/interrupt-controller/fsl,ls-extirq.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@1570000 {
+        compatible = "fsl,ls1021a-scfg", "syscon";
+        reg = <0x1570000 0x10000>;
+    };
-- 
2.30.2

