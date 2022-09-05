Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72705AD573
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiIEOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiIEOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:47:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C26252
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:47:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso5816358wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OduaGW9nRB1fMO6LmhdxoHqh6SOlcNIe7BUgka7IDIs=;
        b=JlHsmhdr/HrIefMqDVRjJO6P4RSKckrG1psa+II3I3DmgoHLuElyEn13Hoor7AkFOW
         qP9WnzuXgkNuQUqy0TmqFPgsEH96EtX9jke3tCLB73HLws/2gb6Wy4rkaRPfZ9Dg54de
         N2I516kVej7aI/2J3fNnA8Lmt9GadvBENGNP7NFUtEc3ffgq+FS+sM7NSOQLJ8QsfRcT
         l9TibsvTe/3dRPMAld6/uHD39F587xo4L37cZJMQs3W7TTznlqmGaQRSTlzBcfV6kfZ8
         STovt1IkX0mVFaT62OKlMJ1WZnBHXaWlVQIoT4k8wEcBTlBJYivpcZTEb114iaXOEYFi
         k5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OduaGW9nRB1fMO6LmhdxoHqh6SOlcNIe7BUgka7IDIs=;
        b=YZ3I7sfkITFUHYEqzNkDzmnNS2hewKT99amUIosMinfB/qLkwixHB+xAsQdWeHl2BT
         vR9sp6ui6KKub5tbTJq2pr/QrnMWwwVDC5W5dVzgV35oXsshuD7Ja4R3WrGEQpmwCaDf
         F1DcQkbxLtvCx1ipBuD3WP200By2UQHvquKbVp0lN4G2steaFQrB5NTgdCUdOAEYWzTP
         HeEWuBHKkZ8Pwoq+lInicRvxf5C+vShPxinI8/x1skPBuxLTWR8gWXLpOs2Q/Fl4dRBX
         P7UtWHCuXXb03ecEZsX8KXtvMNlPO9pgNiwpYvJz54n6dYTFU+0VXaZxtbF/Pf5FFJ3B
         BL+Q==
X-Gm-Message-State: ACgBeo1PwPUqACbDLp8sW1CqhWnUmSo/vUE8VMpBS+r8lOcI4bwV5Pb0
        ZkpBTPZnF3wBVA8T+sAAZSOOwVAx+AewO6G7
X-Google-Smtp-Source: AA6agR6fFb+nlKh47jOls2Futbp8YMunFz/goxL0k5nxDnvTBzhnc75sJtEwnEp7u3Z3wcBTQu7Eyg==
X-Received: by 2002:a05:600c:2853:b0:3a8:3d66:2653 with SMTP id r19-20020a05600c285300b003a83d662653mr11194167wmb.156.1662389229651;
        Mon, 05 Sep 2022 07:47:09 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm18990244wms.23.2022.09.05.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:47:08 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v7 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon,  5 Sep 2022 17:45:53 +0300
Message-Id: <20220905144554.1772073-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
dt-entries correctly and any future additions can go into yaml format.

Use compute-cb@ subnodes instead of just cb@.

Also add qcom,non-secure-domain, qcom,glink-channels and
qcom,smd-channels missing properties to make sure dtbs_check doesn't
fail right off the bat.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v6:
 * renamed the parent node name in the example from smd-edge to glink-edge

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
 .../bindings/misc/qcom,fastrpc.yaml           | 118 ++++++++++++++++++
 2 files changed, 118 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
deleted file mode 100644
index 5ec124b138a6..000000000000
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ /dev/null
@@ -1,88 +0,0 @@
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
-- qcom,non-secure-domain:
-	Usage: required
-	Value type: <boolean>
-	Definition: Property to specify that dsp domain is non-secure.
-
-- qcom,vmids:
-	Usage: optional
-	Value type: <u32 array>
-	Definition: Virtual machine IDs for remote processor.
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
index 000000000000..2b446272cc14
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,118 @@
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
+  qcom,glink-channels:
+    description:
+      A list of channels tied to this function, used for matching
+      the function to a set of virtual channels.
+    $ref: "/schemas/types.yaml#/definitions/string-array"
+
+  qcom,non-secure-domain:
+    description:
+      Used to mark the current domain as non-secure.
+    type: boolean
+
+  qcom,smd-channels:
+    description:
+      Channel name used for the RPM communication
+    $ref: "/schemas/types.yaml#/definitions/string-array"
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "(compute-)?cb@[0-9]*$":
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
+required:
+  - compatible
+  - label
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    glink-edge {
+        interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                     IPCC_MPROC_SIGNAL_GLINK_QMP
+                                     IRQ_TYPE_EDGE_RISING>;
+        mboxes = <&ipcc IPCC_CLIENT_LPASS
+                        IPCC_MPROC_SIGNAL_GLINK_QMP>;
+        label = "lpass";
+        qcom,remote-pid = <2>;
+
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
2.34.1

