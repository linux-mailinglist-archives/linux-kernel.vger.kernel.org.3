Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20B15842F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiG1PUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiG1PUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:20:39 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9F10FF0;
        Thu, 28 Jul 2022 08:20:37 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4819F1A014A;
        Thu, 28 Jul 2022 17:20:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEAC31A0139;
        Thu, 28 Jul 2022 17:20:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A4302180031A;
        Thu, 28 Jul 2022 23:20:34 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH v2] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
Date:   Thu, 28 Jul 2022 23:04:29 +0800
Message-Id: <1659020669-3946-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NXP SAI binding to DT schema format using json-schema.

The Synchronous Audio Interface (SAI) provides an interface that
supports full-duplex serial interfaces with frame synchronization
formats such as I2S, AC97, TDM, and codec/DSP interfaces.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- fix exclusive property issue
- fix order issue of compatible, clock-names, dma-names

 .../devicetree/bindings/sound/fsl,sai.yaml    | 215 ++++++++++++++++++
 .../devicetree/bindings/sound/fsl-sai.txt     |  95 --------
 2 files changed, 215 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sai.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
new file mode 100644
index 000000000000..3e3d99febd69
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Synchronous Audio Interface (SAI).
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  The SAI is based on I2S module that used communicating with audio codecs,
+  which provides a synchronous audio interface that supports fullduplex
+  serial interfaces with frame synchronization such as I2S, AC97, TDM, and
+  codec/DSP interfaces.
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,vf610-sai
+      - const: fsl,imx6sx-sai
+      - const: fsl,imx6ul-sai
+      - const: fsl,imx7ulp-sai
+      - const: fsl,imx8mq-sai
+      - const: fsl,imx8qm-sai
+      - const: fsl,imx8ulp-sai
+      - items:
+          - enum:
+              - fsl,imx8mm-sai
+              - fsl,imx8mn-sai
+              - fsl,imx8mp-sai
+          - const: fsl,imx8mq-sai
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: receive and transmit interrupt
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: The ipg clock for register access
+      - description: master clock source 0 (obsoleted)
+      - description: master clock source 1
+      - description: master clock source 2
+      - description: master clock source 3
+      - description: PLL clock source for 8kHz series
+      - description: PLL clock source for 11kHz series
+    minItems: 4
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: bus
+          - const: mclk0
+          - const: mclk1
+          - const: mclk2
+          - const: mclk3
+          - const: pll8k
+          - const: pll11k
+        minItems: 4
+      - items:
+          - const: bus
+          - const: mclk1
+          - const: mclk2
+          - const: mclk3
+          - const: pll8k
+          - const: pll11k
+        minItems: 4
+
+  lsb-first:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Configures whether the LSB or the MSB is transmitted
+      first for the fifo data. If this property is absent,
+      the MSB is transmitted first as default, or the LSB
+      is transmitted first.
+
+  big-endian:
+    description: |
+      required if all the SAI registers are big-endian rather than little-endian.
+    type: boolean
+
+  fsl,sai-synchronous-rx:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      SAI will work in the synchronous mode (sync Tx with Rx) which means
+      both the transmitter and the receiver will send and receive data by
+      following receiver's bit clocks and frame sync clocks.
+
+  fsl,sai-asynchronous:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      SAI will work in the asynchronous mode, which means both transmitter
+      and receiver will send and receive data by following their own bit clocks
+      and frame sync clocks separately.
+      If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
+      default synchronous mode (sync Rx with Tx) will be used, which means both
+      transmitter and receiver will send and receive data by following clocks
+      of transmitter.
+
+  fsl,dataline:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      Configure the dataline. It has 3 value for each configuration
+    items:
+      items:
+        - description: format Default(0), I2S(1) or PDM(2)
+          enum: [0, 1, 2]
+        - description: dataline mask for 'rx'
+        - description: dataline mask for 'tx'
+
+  fsl,sai-mclk-direction-output:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      SAI will output the SAI MCLK clock.
+
+  fsl,shared-interrupt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Interrupt is shared with other modules.
+
+  "#sound-dai-cells":
+    const: 0
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,vf610-sai
+    then:
+      properties:
+        dmas:
+          items:
+            - description: DMA controller phandle and request line for TX
+            - description: DMA controller phandle and request line for RX
+        dma-names:
+          items:
+            - const: tx
+            - const: rx
+    else:
+      properties:
+        dmas:
+          items:
+            - description: DMA controller phandle and request line for RX
+            - description: DMA controller phandle and request line for TX
+        dma-names:
+          items:
+            - const: rx
+            - const: tx
+  - if:
+      required:
+        - fsl,sai-asynchronous
+    then:
+      properties:
+        fsl,sai-synchronous-rx: false
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
+    #include <dt-bindings/clock/vf610-clock.h>
+    sai2: sai@40031000 {
+        compatible = "fsl,vf610-sai";
+        reg = <0x40031000 0x1000>;
+        interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_sai2_1>;
+        clocks = <&clks VF610_CLK_PLATFORM_BUS>,
+                 <&clks VF610_CLK_SAI2>,
+                 <&clks 0>, <&clks 0>;
+        clock-names = "bus", "mclk1", "mclk2", "mclk3";
+        dma-names = "tx", "rx";
+        dmas = <&edma0 0 21>,
+               <&edma0 0 20>;
+        big-endian;
+        lsb-first;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    sai1: sai@30010000 {
+        #sound-dai-cells = <0>;
+        compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+        reg = <0x30010000 0x10000>;
+        interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
+                 <&clk IMX8MM_CLK_DUMMY>,
+                 <&clk IMX8MM_CLK_SAI1_ROOT>,
+                 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+        clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+        dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+        dma-names = "rx", "tx";
+        fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
deleted file mode 100644
index fbdefc3fade7..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ /dev/null
@@ -1,95 +0,0 @@
-Freescale Synchronous Audio Interface (SAI).
-
-The SAI is based on I2S module that used communicating with audio codecs,
-which provides a synchronous audio interface that supports fullduplex
-serial interfaces with frame synchronization such as I2S, AC97, TDM, and
-codec/DSP interfaces.
-
-Required properties:
-
-  - compatible		: Compatible list, contains "fsl,vf610-sai",
-			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai",
-			  "fsl,imx8qm-sai", "fsl,imx8mm-sai",
-			  "fsl,imx8mn-sai", "fsl,imx8mp-sai", or
-			  "fsl,imx8ulp-sai".
-
-  - reg			: Offset and length of the register set for the device.
-
-  - clocks		: Must contain an entry for each entry in clock-names.
-
-  - clock-names		: Must include the "bus" for register access and
-			  "mclk1", "mclk2", "mclk3" for bit clock and frame
-			  clock providing.
-                          "pll8k", "pll11k" are optional, they are the clock
-                          source for root clock, one is for 8kHz series rates
-                          another one is for 11kHz series rates.
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Two dmas have to be defined, "tx" and "rx".
-
-  - pinctrl-names	: Must contain a "default" entry.
-
-  - pinctrl-NNN		: One property must exist for each entry in
-			  pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
-			  for details of the property values.
-
-  - lsb-first		: Configures whether the LSB or the MSB is transmitted
-			  first for the fifo data. If this property is absent,
-			  the MSB is transmitted first as default, or the LSB
-			  is transmitted first.
-
-  - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
-			  that SAI will work in the synchronous mode (sync Tx
-			  with Rx) which means both the transmitter and the
-			  receiver will send and receive data by following
-			  receiver's bit clocks and frame sync clocks.
-
-  - fsl,sai-asynchronous: This is a boolean property. If present, indicating
-			  that SAI will work in the asynchronous mode, which
-			  means both transmitter and receiver will send and
-			  receive data by following their own bit clocks and
-			  frame sync clocks separately.
-
-  - fsl,dataline        : configure the dataline. it has 3 value for each configuration
-                          first one means the type: I2S(1) or PDM(2)
-                          second one is dataline mask for 'rx'
-                          third one is dataline mask for 'tx'.
-                          for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
-                          it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
-                          rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).
-
-Optional properties:
-
-  - big-endian		: Boolean property, required if all the SAI
-			  registers are big-endian rather than little-endian.
-
-Optional properties (for mx6ul):
-
-  - fsl,sai-mclk-direction-output: This is a boolean property. If present,
-			 indicates that SAI will output the SAI MCLK clock.
-
-Note:
-- If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
-  default synchronous mode (sync Rx with Tx) will be used, which means both
-  transmitter and receiver will send and receive data by following clocks
-  of transmitter.
-- fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
-
-Example:
-sai2: sai@40031000 {
-	      compatible = "fsl,vf610-sai";
-	      reg = <0x40031000 0x1000>;
-	      pinctrl-names = "default";
-	      pinctrl-0 = <&pinctrl_sai2_1>;
-	      clocks = <&clks VF610_CLK_PLATFORM_BUS>,
-		     <&clks VF610_CLK_SAI2>,
-		     <&clks 0>, <&clks 0>;
-	      clock-names = "bus", "mclk1", "mclk2", "mclk3";
-	      dma-names = "tx", "rx";
-	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
-		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
-	      big-endian;
-	      lsb-first;
-};
-- 
2.34.1

