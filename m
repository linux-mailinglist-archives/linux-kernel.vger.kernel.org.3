Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D457FCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiGYJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:47:19 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5187113F7E;
        Mon, 25 Jul 2022 02:47:17 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93846201358;
        Mon, 25 Jul 2022 11:47:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 329E120016C;
        Mon, 25 Jul 2022 11:47:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E394D1802204;
        Mon, 25 Jul 2022 17:47:13 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
Date:   Mon, 25 Jul 2022 17:31:07 +0800
Message-Id: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
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
 .../devicetree/bindings/sound/fsl,sai.yaml    | 175 ++++++++++++++++++
 .../devicetree/bindings/sound/fsl-sai.txt     |  95 ----------
 2 files changed, 175 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sai.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
new file mode 100644
index 000000000000..adcd77531eba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -0,0 +1,175 @@
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
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - fsl,vf610-sai
+        - fsl,imx6sx-sai
+        - fsl,imx6ul-sai
+        - fsl,imx7ulp-sai
+        - fsl,imx8mq-sai
+        - fsl,imx8qm-sai
+        - fsl,imx8mm-sai
+        - fsl,imx8mn-sai
+        - fsl,imx8mp-sai
+        - fsl,imx8ulp-sai
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: receive and transmit interrupt
+
+  dmas:
+    minItems: 2
+    maxItems: 2
+    description:
+      Must contain a list of pairs of references to DMA specifiers, one for
+      transmission, and one for reception.
+
+  dma-names:
+    minItems: 2
+    maxItems: 2
+    items:
+      enum:
+        - tx
+        - rx
+
+  clocks:
+    minItems: 4
+    items:
+      - description: The ipg clock for register access
+      - description: master clock source 0 (obsoleted, compatible for old dts)
+      - description: master clock source 1
+      - description: master clock source 2
+      - description: master clock source 3
+      - description: PLL clock source for 8kHz series
+      - description: PLL clock source for 11kHz series
+
+  clock-names:
+    minItems: 4
+    maxItems: 7
+    items:
+      enum:
+        - bus
+        - mclk0
+        - mclk1
+        - mclk2
+        - mclk3
+        - pll8k
+        - pll11k
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
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Boolean property, required if all the SAI
+      registers are big-endian rather than little-endian.
+
+  fsl,sai-synchronous-rx:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, indicating
+      that SAI will work in the synchronous mode (sync Tx
+      with Rx) which means both the transmitter and the
+      receiver will send and receive data by following
+      receiver's bit clocks and frame sync clocks.
+      fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
+
+  fsl,sai-asynchronous:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, indicating
+      that SAI will work in the asynchronous mode, which
+      means both transmitter and receiver will send and
+      receive data by following their own bit clocks and
+      frame sync clocks separately.
+      If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
+      default synchronous mode (sync Rx with Tx) will be used, which means both
+      transmitter and receiver will send and receive data by following clocks
+      of transmitter.
+      fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
+
+  fsl,dataline:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      configure the dataline. it has 3 value for each configuration
+      first one means the type: I2S(1) or PDM(2)
+      second one is dataline mask for 'rx'
+      third one is dataline mask for 'tx'.
+      for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
+      it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
+      rx mask is 0xff, tx mask is 0x11 (dataline 1 and 5 enabled).
+
+  fsl,sai-mclk-direction-output:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present,
+      indicates that SAI will output the SAI MCLK clock.
+
+  fsl,shared-interrupt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present,
+      indicates that interrupt is shared with other modules.
+
+  "#sound-dai-cells":
+    const: 0
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
+        dma-names = "rx", "tx";
+        dmas = <&edma0 0 20>,
+               <&edma0 0 21>;
+        big-endian;
+        lsb-first;
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

