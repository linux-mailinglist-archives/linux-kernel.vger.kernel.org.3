Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A94634FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhK3NBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:01:35 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:64610 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhK3NBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:01:22 -0500
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:58:03 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:58:02 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:27:55 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 4EEC6203E; Tue, 30 Nov 2021 18:27:54 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: [PATCH 1/3] dt-bindings: misc: add fastrpc domain vmid property
Date:   Tue, 30 Nov 2021 18:27:48 +0530
Message-Id: <1638277072-6459-2-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
References: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fastrpc domain virtual machine IDs property. This property is used
to setup memory protection for remote processor.

"This patch depends on “dt-bindings: misc: fastrpc convert bindings to yaml"
(https://patchwork.kernel.org/project/linux-arm-msm/patch/20211130092846.18804-1-srinivas.kandagatla@linaro.org/)"

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 .../devicetree/bindings/misc/qcom,fastrpc.txt      |  78 ---------------
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     | 109 +++++++++++++++++++++
 2 files changed, 109 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
deleted file mode 100644
index 2a1827a..0000000
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Qualcomm Technologies, Inc. FastRPC Driver
-
-The FastRPC implements an IPC (Inter-Processor Communication)
-mechanism that allows for clients to transparently make remote method
-invocations across DSP and APPS boundaries. This enables developers
-to offload tasks to the DSP and free up the application processor for
-other tasks.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,fastrpc"
-
-- label
-	Usage: required
-	Value type: <string>
-	Definition: should specify the dsp domain name this fastrpc
-	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
-
-- #address-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-- #size-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 0
-
-= COMPUTE BANKS
-Each subnode of the Fastrpc represents compute context banks available
-on the dsp.
-- All Compute context banks MUST contain the following properties:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,fastrpc-compute-cb"
-
-- reg
-	Usage: required
-	Value type: <u32>
-	Definition: Context Bank ID.
-
-- qcom,nsessions:
-	Usage: Optional
-	Value type: <u32>
-	Defination: A value indicating how many sessions can share this
-		    context bank. Defaults to 1 when this property
-		    is not specified.
-
-Example:
-
-adsp-pil {
-	compatible = "qcom,msm8996-adsp-pil";
-	...
-	smd-edge {
-		label = "lpass";
-		fastrpc {
-			compatible = "qcom,fastrpc";
-			qcom,smd-channels = "fastrpcsmd-apps-dsp";
-			label = "adsp";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cb@1 {
-				compatible = "qcom,fastrpc-compute-cb";
-				reg = <1>;
-			};
-
-			cb@2 {
-				compatible = "qcom,fastrpc-compute-cb";
-				reg = <2>;
-			};
-			...
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
new file mode 100644
index 0000000..a9fd93c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Technologies, Inc. FastRPC Driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes Qualcomm FastRPC an IPC (Inter-Processor Communication)
+  mechanism that allows for clients to transparently make remote method
+  invocations across DSP and APPS boundaries. This enables developers
+  to offload tasks to the DSP and free up the application processor for
+  other tasks.
+
+properties:
+  compatible:
+    const: qcom,fastrpc
+
+  label:
+    enum:
+      - adsp
+      - mdsp
+      - sdsp
+      - cdsp
+
+  qcom,nsessions:
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    description: Virtual machine IDs of remote processor which is used to
+                 setup memory protection.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^cb@[0-9a-f]$":
+    type: object
+    description: |
+      Compute context bank
+
+    properties:
+      compatible:
+        const: qcom,fastrpc-compute-cb
+
+      reg:
+        maxItems: 1
+        description: Context Bank ID
+
+      qcom,nsessions:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: How many sessions can share this context bank.
+                     Defaults to 1 when this property is not specified.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - label
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adsp {
+        compatible = "qcom,msm8996-adsp-pil";
+        interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+        clocks = <&xo_board>;
+        clock-names = "xo";
+        memory-region = <&adsp_region>;
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        smd-edge {
+            label = "lpass";
+
+            fastrpc {
+                compatible = "qcom,fastrpc";
+                label = "adsp";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                cb@1 {
+                    compatible = "qcom,fastrpc-compute-cb";
+                    reg = <1>;
+                };
+
+                cb@2 {
+                    compatible = "qcom,fastrpc-compute-cb";
+                    reg = <2>;
+                };
+            };
+        };
+    };
-- 
2.7.4

