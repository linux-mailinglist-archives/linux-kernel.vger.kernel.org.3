Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F05AEF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiIFPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiIFPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:49:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1317065
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:01:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b17so2548934wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RFbXFQoQSCcMrXYnrqTFzJRbaNckpV/VF3fD68bEuvg=;
        b=lvl2VXEqQOmA8ccPQqAzBjN11/6vQpsYBhBhQljMFB7GNWIMVobtUzr7gJNA/tqBuY
         E+q0qLaVVW2EVX71Vy0Fw2/9XnK4x8NDZn+OrwIB/U06lTjyJTVafDl6RVHG7z9k1deQ
         MdqQUlqdgBt63k3H/vZtfXkFFz7hBl/OMPDr3e/+FjdG1VJn7KitAUUmu2+TJaazTFog
         HuJPCQtRhD3Lkyq62UFSP44sRaYQDQXXbnsS/sLXpySh+d1bY5YfYtkUnNT4OBHhwh/T
         61vOU+Q5rg8IdQxzml+fLHOAZpW37u9SctdtYloaaCa2biHK0jwqE9p/NadOv6n9d+7e
         sqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RFbXFQoQSCcMrXYnrqTFzJRbaNckpV/VF3fD68bEuvg=;
        b=EdK9VGQSSj9+HTB+KoTnMkaxBJWUFcSYUBRbbkg9XV1PLgjmScpEAM7gc2BGDWhsDT
         3NnIh0UC6EnjhGmGw0p9cSEYG1sHPe6kNoQqeuaZ4UwOv2EC2mKP4Gh5ouAbIbRxRxpb
         GHO/Ahf3UJIPfJJZ/cNfPkLSXpqMkf604pmWif1qoYOkM6zxQOLzpp+6PtUfUZ9zOFhD
         5Oi5cdGMqG+ko62BGJ9c88d1AWMM++mq94/lDvHrG24JU2RsjFiclWkHkKFSfthahBkJ
         5MhnzrBTDuKOZxRSvtol7+FDxif5RUDQIcjaW8apqAKPCdTrUFIriSB4YQ8wL7l+g7wN
         J3tw==
X-Gm-Message-State: ACgBeo0ZpejlKkPemSvAOIOOoQ90Q0+XmkH8Uzdohdb2G97l/W/Ttws8
        SNJc9345c681+wqQ0Q+RsHpyJg==
X-Google-Smtp-Source: AA6agR6Gt/2+vte/tWacOMwE6Q2Z/Ptx3ATRQfya3CHDu0zHAvI8Smy8+KtL9ZYNsHlQhPaR7jmryw==
X-Received: by 2002:a05:6000:2c1:b0:226:e7d0:f098 with SMTP id o1-20020a05600002c100b00226e7d0f098mr19601633wry.578.1662476468265;
        Tue, 06 Sep 2022 08:01:08 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c465600b003a839b9ba0asm20080246wmo.40.2022.09.06.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:01:07 -0700 (PDT)
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
Subject: [PATCH v11] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Tue,  6 Sep 2022 18:01:02 +0300
Message-Id: <20220906150102.3399115-1-abel.vesa@linaro.org>
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

Changes since v10:
 * addressed all comments from Krzysztof
   - removed items where unnecessary
   - added maxItems where necessary
   - used double quotes for consitency everywhere

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 -------------
 .../bindings/misc/qcom,fastrpc.yaml           | 122 ++++++++++++++++++
 .../bindings/remoteproc/qcom,glink-edge.yaml  |   4 +-
 MAINTAINERS                                   |   2 +-
 4 files changed, 125 insertions(+), 91 deletions(-)
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
index 000000000000..429383391eb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+    const: qcom,fastrpc
+
+  label:
+    enum:
+      - adsp
+      - mdsp
+      - sdsp
+      - cdsp
+
+  qcom,glink-channels:
+    description:
+      A list of channels tied to this function, used for matching
+      the function to a set of virtual channels.
+    $ref: "/schemas/types.yaml#/definitions/string-array"
+    maxItems: 1
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
+    maxItems: 1
+
+  qcom,vmids:
+    description:
+      Virtual machine IDs for remote processor.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
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
+        const: qcom,fastrpc-compute-cb
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
+  - "#address-cells"
+  - "#size-cells"
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

