Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2C55B514
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiF0CEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0CEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:04:45 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB257EB5;
        Sun, 26 Jun 2022 19:04:43 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60CE81A1A6F;
        Mon, 27 Jun 2022 04:04:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D44631A1A73;
        Mon, 27 Jun 2022 04:04:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AEDEF1802205;
        Mon, 27 Jun 2022 10:04:39 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH v2] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
Date:   Mon, 27 Jun 2022 09:50:13 +0800
Message-Id: <1656294613-27867-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NXP MICFIL binding to DT schema format using json-schema.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- add decription of interrupts.

 .../devicetree/bindings/sound/fsl,micfil.txt  | 33 --------
 .../devicetree/bindings/sound/fsl,micfil.yaml | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
deleted file mode 100644
index 1ea05d4996c7..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,micfil.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-NXP MICFIL Digital Audio Interface (MICFIL).
-
-The MICFIL digital interface provides a 16-bit audio signal from a PDM
-microphone bitstream in a configurable output sampling rate.
-
-Required properties:
-
-  - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
-			  or "fsl,imx8mp-micfil"
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the micfil interrupts.
-
-  - clocks		: Must contain an entry for each entry in clock-names.
-
-  - clock-names		: Must include the "ipg_clk" for register access and
-			  "ipg_clk_app" for internal micfil clock.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-Example:
-micfil: micfil@30080000 {
-	compatible = "fsl,imx8mm-micfil";
-	reg = <0x0 0x30080000 0x0 0x10000>;
-	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clk IMX8MM_CLK_PDM_IPG>,
-		 <&clk IMX8MM_CLK_PDM_ROOT>;
-	clock-names = "ipg_clk", "ipg_clk_app";
-	dmas = <&sdma2 24 26 0x80000000>;
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
new file mode 100644
index 000000000000..bf24faed7a4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,micfil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP MICFIL Digital Audio Interface (MICFIL)
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  The MICFIL digital interface provides a 16-bit or 24-bit audio signal
+  from a PDM microphone bitstream in a configurable output sampling rate.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mm-micfil
+      - fsl,imx8mp-micfil
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Digital Microphone interface interrupt
+      - description: Digital Microphone interface error interrupt
+      - description: voice activity detector event interrupt
+      - description: voice activity detector error interrupt
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+
+  dma-names:
+    items:
+      - const: rx
+
+  clocks:
+    items:
+      - description: The ipg clock for register access
+      - description: internal micfil clock
+
+  clock-names:
+    items:
+      - const: ipg_clk
+      - const: ipg_clk_app
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    micfil: audio-controller@30080000 {
+        compatible = "fsl,imx8mm-micfil";
+        reg = <0x30080000 0x10000>;
+        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+                 <&clk IMX8MM_CLK_PDM_ROOT>;
+        clock-names = "ipg_clk", "ipg_clk_app";
+        dmas = <&sdma2 24 25 0>;
+        dma-names = "rx";
+    };
-- 
2.17.1

