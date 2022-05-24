Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC02C532D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbiEXPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiEXPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:15:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144318AE49;
        Tue, 24 May 2022 08:15:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 468961F42457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653405317;
        bh=m0AU3HdUdYE+d4SA4JTT6pql5QgFdvj8AwLIrplGxPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a73O03bOE/bCtDd1yg/RKh9c+xZHM71G2rQu1OWhb9VoQ7u5BHX8biSyKuAt3dEqU
         Y/5aX1jyldRvzgua6u4ZosaWWDh1JDZSgxFIgTImNbTe/oMj8u0oL42lCesGi7bW5X
         xwcPLrXov2YGpWviYh7ncd3a/TzcH5FYvHaOeqKekTEuzAsanCRF3V05IV3p2dW4HO
         mTMCkJMqJOE6Vg/W2usAoUSkiFH1ep39RCAP2lhgzbk/h0qCNAea9JxqdsASqxfcww
         nMrxx02/9BR/dYFs8ECmqI4GJAoPjELb54U3eAAL2wERt9haqsB+Z0l4LbM43FVxre
         VEbMjSMFQy9AA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     jassisinghbrar@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: mailbox: mtk-gce: Convert txt to json-schema
Date:   Tue, 24 May 2022 17:15:11 +0200
Message-Id: <20220524151512.247435-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
References: <20220524151512.247435-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mtk-gce documentation from freeform text format to a
json-schema.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/mailbox/mediatek,gce-mbox.yaml   | 124 ++++++++++++++++++
 .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 ------------
 2 files changed, 124 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
new file mode 100644
index 000000000000..bc64dac69f61
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mediatek,gce-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Global Command Engine (GCE) mailbox
+
+maintainers:
+  - Houlong Wei <houlong.wei@mediatek.com>
+
+description: |
+  The Global Command Engine (GCE) is used to help read/write registers
+  with critical time limitation, such as updating display configuration
+  during the vblank.
+  The GCE can be used to implement the Command Queue (CMDQ) driver.
+  Values for properties used by the GCE, such as sub-system IDs, thread
+  priority and event IDs are defined in 'dt-bindings/gce/<chip>-gce.h'.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6779-gce
+      - mediatek,mt8173-gce
+      - mediatek,mt8183-gce
+      - mediatek,mt8186-gce
+      - mediatek,mt8192-gce
+      - mediatek,mt8195-gce
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks: true
+
+  clock-names: true
+
+  '#mbox-cells':
+    description: |
+      The first cell describes the mailbox channel, which is the GCE Thread ID;
+      The second cell describes the priority of the GCE thread.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#mbox-cells'
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt8195-gce
+then:
+  properties:
+    clocks:
+      items:
+        - description: GCE0 clock for Multi-GCE
+        - description: GCE1 clock for Multi-GCE
+
+    clock-names:
+      items:
+        - const: gce0
+        - const: gce1
+else:
+  properties:
+    clocks:
+      items:
+        - description: GCE clock for Single-GCE
+
+    clock-names:
+      items:
+        - const: gce
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/gce/mt8173-gce.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        gce: mailbox@10212000 {
+            compatible = "mediatek,mt8173-gce";
+            reg = <0 0x10212000 0 0x1000>;
+            interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&infracfg CLK_INFRA_GCE>;
+            clock-names = "gce";
+            #mbox-cells = <2>;
+        };
+
+        /* Client device using a GCE Thread */
+        mmsys: syscon@14000000 {
+            compatible = "mediatek,mt8173-mmsys", "syscon";
+            reg = <0 0x14000000 0 0x1000>;
+            mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+                     <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+            mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+
+        /* Client device listening to specific GCE Events */
+        mutex: mutex@14020000 {
+            compatible = "mediatek,mt8173-disp-mutex";
+            reg = <0 0x14020000 0 0x1000>;
+            interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
+            power-domains = <&spm 1>;
+            clocks = <&mmsys CLK_MM_MUTEX_32K>;
+            mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
+                                  <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
deleted file mode 100644
index c2aeba63bd47..000000000000
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-MediaTek GCE
-===============
-
-The Global Command Engine (GCE) is used to help read/write registers with
-critical time limitation, such as updating display configuration during the
-vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
-
-CMDQ driver uses mailbox framework for communication. Please refer to
-mailbox.txt for generic information about mailbox device-tree bindings.
-
-Required properties:
-- compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce",
-  "mediatek,mt8186-gce", "mediatek,mt8192-gce", "mediatek,mt8195-gce" or
-  "mediatek,mt6779-gce".
-- reg: Address range of the GCE unit
-- interrupts: The interrupt signal from the GCE block
-- clock: Clocks according to the common clock binding
-- clock-names: Must be "gce" to stand for GCE clock
-- #mbox-cells: Should be 2.
-	<&phandle channel priority>
-	phandle: Label name of a gce node.
-	channel: Channel of mailbox. Be equal to the thread id of GCE.
-	priority: Priority of GCE thread.
-
-Required properties for a client device:
-- mboxes: Client use mailbox to communicate with GCE, it should have this
-  property and list of phandle, mailbox specifiers.
-Optional properties for a client device:
-- mediatek,gce-client-reg: Specify the sub-system id which is corresponding
-  to the register address, it should have this property and list of phandle,
-  sub-system specifiers.
-  <&phandle subsys_number start_offset size>
-  phandle: Label name of a gce node.
-  subsys_number: specify the sub-system id which is corresponding
-                 to the register address.
-  start_offset: the start offset of register address that GCE can access.
-  size: the total size of register address that GCE can access.
-
-Optional properties for a client mutex node:
-- mediatek,gce-events: GCE events used by clients. The event numbers are
-  defined in 'dt-bindings/gce/<chip>-gce.h'.
-
-Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
-'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h'
-'dt-bindings/gce/mt8192-gce.h', 'dt-bindings/gce/mt8195-gce.h' or
-'dt-bindings/gce/mt6779-gce.h'.
-Such as sub-system ids, thread priority, event ids.
-
-Example:
-
-	gce: gce@10212000 {
-		compatible = "mediatek,mt8173-gce";
-		reg = <0 0x10212000 0 0x1000>;
-		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&infracfg CLK_INFRA_GCE>;
-		clock-names = "gce";
-		#mbox-cells = <2>;
-	};
-
-Example for a client device:
-
-	mmsys: clock-controller@14000000 {
-		compatible = "mediatek,mt8173-mmsys";
-		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST>,
-			 <&gce 1 CMDQ_THR_PRIO_LOWEST>;
-		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
-				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
-		mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>,
-					  <&gce SUBSYS_1401XXXX 0x2000 0x100>;
-		...
-	};
-
-Example for a client mutex node:
-	mutex: mutex@14020000 {
-		compatible = "mediatek,mt8173-disp-mutex";
-		reg = <0 0x14020000 0 0x1000>;
-		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
-		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-		clocks = <&mmsys CLK_MM_MUTEX_32K>;
-		mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
-				      <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
-	};
-- 
2.35.1

