Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1465AE413
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiIFJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIFJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:24:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C8DCE4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:24:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bp20so14003598wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/9p6tPkpItrqvs+0dClALJqZr+x69C7J2yQNFYfdHJs=;
        b=JhcuGE1BVafvxTP0umn2UEIg+TF1/A4zA8GJN5ZzwdZbxrwiSdB1BA+60aHy4amrQu
         1xDJHrP3trbEXbX6Z+CtikGX5iMcnJCV7QLpiUAdrrOP4QWmt2NLnxMeZTH3bwQk2r0p
         i8e8GWZW/GiZscpIs6Y8Cg7M6T3yurDWrL2UGRLIBtLCWyWOwzN1DBlKywi1p1TkWXVk
         D8JbwsR+ClA4HT/SQEq2ZipuC2vlY+/qrFeUxe2nojsRaUs1NzCin8ZtgPyWo0UWkQ9y
         4V5TpfQgkY7QJxlY95i11tjSOg5q0WkFXHzDabRDVedvR7tFb4Z1HFMYc0ZV0tdK8IU3
         0fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/9p6tPkpItrqvs+0dClALJqZr+x69C7J2yQNFYfdHJs=;
        b=GphXX0i/X/vtCCMTEe6uX20y/WWYpfh501r8+kCU5EwmFy+QA9FQZc34ziUipZbC2u
         nzSxMPU/SKAMT667t2c85wgyq4zHXxtDGkIr5ErdRAL9+k2bI0FqKkpaW3gDkv16s/If
         RuGHMQMUBdzaZBaLdRopMWFzB6J/3s7+NyIIPu4nIEbfhM0gICY9BxmDUA0B8ief+fg+
         ArOlXV+Bo5Fe5iXDhBEssI9TbNY7C6UzoK8VoSi7ZAsUaxdrCzOcXPOY6LDmJXLkbO3h
         yCpEGgvEJpRfwRT0sLC5IX15fzgqz5dJ1zyJ/3YCQSgm2aY/vM8J/wgHZQmE0LpvzvDQ
         Wu9g==
X-Gm-Message-State: ACgBeo0fdQNg2mIds0dEVnfcRpdza/RCSqoN6iX1DxW3PcXDUejo0wSx
        JdL7tDZKDXz/1OS/b/ZZHwZPog==
X-Google-Smtp-Source: AA6agR4FlgurWIrvqkXHOW2e1wSqPC0ZKP5EL4obYeB8DASelbVgkn8a2eeXyUca1m8rTLVROXaVxQ==
X-Received: by 2002:a5d:648b:0:b0:222:cb51:a57 with SMTP id o11-20020a5d648b000000b00222cb510a57mr26739732wri.287.1662456264206;
        Tue, 06 Sep 2022 02:24:24 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d6b41000000b002250c35826dsm11691236wrw.104.2022.09.06.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:24:23 -0700 (PDT)
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
Subject: [PATCH v8 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Tue,  6 Sep 2022 12:24:14 +0300
Message-Id: <20220906092415.1989720-1-abel.vesa@linaro.org>
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

Also change the file extension referenced in bindings
remoteproc/qcom,glink-edge.yaml from txt to yaml.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v7:
 * fixed file extension in glink-edge yaml, issue reported by Rob's bot,
   and changed the commit message to reflect that too.
 * removed from commit message the mentioning of qcom,non-secure-domain,
   as suggested by Krzysztof.
 * added the qcom,vmids in the yaml, which was there in the original txt file.
 * mentioned in the commit message that the parent node name in the
   example is changed from smd-edge to glink-edge, since this is a
   change made compared to the original txt file

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
 .../bindings/misc/qcom,fastrpc.yaml           | 123 ++++++++++++++++++
 .../bindings/remoteproc/qcom,glink-edge.yaml  |   2 +-
 3 files changed, 124 insertions(+), 89 deletions(-)
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
index fa69f7b21eed..170b0601839a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -25,7 +25,7 @@ properties:
   fastrpc:
     type: object
     description:
-      See Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+      See Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
 
   interrupts:
     maxItems: 1
-- 
2.34.1

