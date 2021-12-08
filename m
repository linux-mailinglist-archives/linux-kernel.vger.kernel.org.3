Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3C46D0CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhLHKVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:21:46 -0500
Received: from ixit.cz ([94.230.151.217]:60090 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhLHKVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:21:45 -0500
Received: from localhost.localdomain (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 45A2F21F5E;
        Wed,  8 Dec 2021 11:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638958690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QJ2xEIeX42XFq2W7dJr/T6LZGzm+TwSyalep9iOyqKQ=;
        b=u+iDm3qsiBKaRMPieLRRF9atqBQDKJv2T5k8iTz1FadF1HGK9M7wNd1V58WNHuoGFudbm+
        C9HQd+c9UuWZtqxm32gskCfXuvltLdrjk6F0YDga+t3t6fes2IfxqjebvhOUtcogrYuILa
        AZ56vlh+fo2vM7QUR9TGzpyJ3bm3jBg=
From:   David Heidelberg <david@ixit.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Wed,  8 Dec 2021 11:15:08 +0100
Message-Id: <20211208101508.24582-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
dt-entries correctly and any future additions can go into yaml format.

Also:
 - simplify example
 - embrace compute-cb@ subnodes instead of just cb@

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 v4:
 - combined mine and Srinivas versions of the patch
 - previously found issues should be fixed

 .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 ---------------
 .../bindings/misc/qcom,fastrpc.yaml           | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
deleted file mode 100644
index 2a1827ab50d2..000000000000
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
index 000000000000..f42ab208a7fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm FastRPC Driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  The FastRPC implements an IPC (Inter-Processor Communication)
+  mechanism that allows for clients to transparently make remote method
+  invocations across DSP and APPS boundaries. This enables developers
+  to offload tasks to the DSP and free up the application processor for
+  other tasks.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,fastrpc
+
+  label:
+    items:
+      enum:
+        - adsp
+        - mdsp
+        - sdsp
+        - cdsp
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "(compute-)?cb@[0-9]$":
+    type: object
+
+    description: >
+      Each subnode of the Fastrpc represents compute context banks available on the dsp.
+
+    properties:
+      compatible:
+        items:
+          - const: qcom,fastrpc-compute-cb
+
+      reg:
+        maxItems: 1
+
+      qcom,nsession:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        default: 1
+        description: >
+          A value indicating how many sessions can share this context bank.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: true
+
+required:
+  - compatible
+  - label
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: true
+
+examples:
+  - |
+    smd-edge {
+        label = "lpass";
+        fastrpc {
+            compatible = "qcom,fastrpc";
+            label = "adsp";
+            qcom,smd-channels = "fastrpcsmd-apps-dsp";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compute-cb@1 {
+                compatible = "qcom,fastrpc-compute-cb";
+                reg = <1>;
+            };
+
+            compute-cb@2 {
+                compatible = "qcom,fastrpc-compute-cb";
+                reg = <2>;
+            };
+        };
+    };
-- 
2.33.0

