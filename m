Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49F65AE65D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiIFLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiIFLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:19:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C4B7E6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:19:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k9so14965077wri.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NyKadFygOs0Qr1Qv/r8zNvdjpghWKNsHGeyDw4u1B8c=;
        b=bBEFjV7Uj5Z919d7FQhE4I8MTlimWgBkzr+rjKSvKsaU8C8zcMRY/TbFeegPf+4+SO
         /iBdh8cou44uOw0h08kM0L1X2/+iqbYdF8n10qAOFM4ALfeBTkfrm982q0zWgT/Q6mza
         691+tJn1cPSNpRR+8IPYkUiBwSqgoiPkhsz71DfYLNt3m5BlfA+qOxBB76i1QO4GQ3P6
         CW/8hAh29Fhph7RmgEzQgm5b9uGNplo64BtJpWkqDLB++1M4iILOI6ftw/quRsd6696R
         gTIiPUiDJsAd4n8+qyLsveX3Tytsy2UvTaUDFjz7Jr6bQMC3GRwMvHmYFVGn1a7MFv2n
         ywGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NyKadFygOs0Qr1Qv/r8zNvdjpghWKNsHGeyDw4u1B8c=;
        b=PSuTzH6/brQDk75I2zBqY13plQ0zEvLvM2xyDHcpceT6h5NjPEYDUUkLgrzRlQCW9i
         EqpMV7aP0o4uj5YnyRlwql6rTfB0z342Fs7B7vvMqg7ihhBa5a896a0kJpRlNsLWiNtf
         8q9MXx9oGdd3n033362lZvKbegSJ3AjKiqqqkylH9buNWYiXvcm1Ih7c7mIImk7jnTHa
         yDuPpDLuI8gqaOZHFVC+nIhSh1yiHjq9eCoHkfq5QhefL9UAccZMhjlZDAiRyCblkSbm
         6hwgYduK4/MRaCopDrId9JuwKjcDPBSWcRl+8UBnMEd8CncKiWrUjAf+aT7hACwcAO9L
         +lag==
X-Gm-Message-State: ACgBeo0QK1zSDZdCIo2J7yvyUj2Mj69Kxaa1pWzScJqJUVG3xoA/095A
        3ut0qMgcUyZBzPiPBsc2GDFGZQ==
X-Google-Smtp-Source: AA6agR5EHK938s5jrMWdADg8SAk1jRrWQC2uVre+15nzkb56AQbjcHbcmvEuwTRWiLKrDWMiQHV3+A==
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id m5-20020a5d6245000000b0022541aea930mr27465778wrv.342.1662463178328;
        Tue, 06 Sep 2022 04:19:38 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b003a6a3595edasm14445348wmb.27.2022.09.06.04.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 04:19:37 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v10] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Tue,  6 Sep 2022 14:19:30 +0300
Message-Id: <20220906111930.2684225-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
dt-entries correctly and any future additions can go into yaml format.

Use compute-cb@ subnodes instead of just cb@. Add qcom,glink-channels and
qcom,smd-channels missing properties to make sure dtbs_check doesn't fail
right off the bat. Correct the name of the parent node in the example from
smd-edge to glink-edge.

Since now the qcom,fastrpc bindings document is yaml, update the
reference to it in qcom,glink-edge and also use $ref.

Also update the MAINTAINERS file to point to the yaml version.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v9:
 * squashed to the MAINTAINERS file update to not break the
   bisectability, as Krzysztof suggested.

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
 .../bindings/misc/qcom,fastrpc.yaml           | 123 ++++++++++++++++++
 .../bindings/remoteproc/qcom,glink-edge.yaml  |   4 +-
 MAINTAINERS                                   |   2 +-
 4 files changed, 126 insertions(+), 91 deletions(-)
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
index 000000000000..7f43b37bb2e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,123 @@
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
+  qcom,vmids:
+    description:
+      A list of DSP Virtual Machine IDs used for SCM memory assignment.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
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
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
index fa69f7b21eed..8953678da83e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -23,9 +23,9 @@ properties:
       Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
 
   fastrpc:
-    type: object
+    $ref: /schemas/misc/qcom,fastrpc.yaml#
     description:
-      See Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+      Qualcomm FastRPC
 
   interrupts:
     maxItems: 1
diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..ad697195fc59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16863,7 +16863,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
 F:	drivers/misc/fastrpc.c
 F:	include/uapi/misc/fastrpc.h
 
-- 
2.34.1

