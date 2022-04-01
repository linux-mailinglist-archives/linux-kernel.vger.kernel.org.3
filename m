Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499554EFAF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiDAUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbiDAUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407E220FD9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so8095722ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiPFOtlWEejbKt8Zxnyre/JEc7vI0iBx3VTQVKu5vkA=;
        b=l8XgkOE9d91y/CpuZuFaSNO7a2Wcb4OmjfUM51QetJzDzxxPUBLURw5tazfss0wOIa
         ltbxBuQAxXYJJLfWKQg8Kdw3tiWSkWibp+Msml/Q0dRh43lpxnPukfkvCtUv4wRvuq8Y
         RlW8Q9wAIMuYfXH2WSKjJvG+D60jInwekxukWfsCtt32haN48OaTL1zDfVY5XZvwHm9E
         92Pg4blUECXwXYviTFMqtjNDHTHxTAUi5rXF40LCN5PgzpFxAJ53Rl1rDoh0iD2nikxp
         OxizZaa4WkUqwzd/RmmoSANIUlZ+Dz6VVY7YaxIU2FJ3XTR/gqTuqCx7WnF8TbeYv32z
         VB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiPFOtlWEejbKt8Zxnyre/JEc7vI0iBx3VTQVKu5vkA=;
        b=RaPM//8xopqrdiG3U4vcedDLLzCzLkB/z/XWpI3TzGEhc2zIjNlzmf/uF+KDasHm2e
         MSuOwi+7pR9YPkiPFW5j2jhkx666Fs39SXEL1UkmKv1TAUcBbDtlozS3QncndQm6ssFH
         +rgOqIykIi/WmISIp3vcNG3+fNp09qt/ovBx7z016J1jBsWUvz9bXGNwavjCr/ireIsJ
         7BasdkYD/1T4dyVMtCAndkkSGii/TXb6tXbL51mIZFZr1QlmhCA5U8HE3WXad98dwlyg
         F+sTjRFi+YeAQ43Hjo33T3ugvn894MA3RzDQr0Zeg1LMvIFfJ5HKGX5GhdKSxAcx/I/z
         MA0A==
X-Gm-Message-State: AOAM533jzs80ilkKsrD2hLHnO2cW/OWW126O0FJyDgu7eaiwnw2SMoqU
        OqGbh2T0l+mxFViS4nAg8yBMVA==
X-Google-Smtp-Source: ABdhPJwKAGgFHHZ2Oh/ZNWxhKXLKprEwYbv1kdEFB9BfDYk6FKpJLSxdVt0vFz+KpzKj9MzlSUVC2Q==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr1319908ejj.275.1648843855143;
        Fri, 01 Apr 2022 13:10:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/10] dt-bindings: soc: qcom,smd: convert to dtschema
Date:   Fri,  1 Apr 2022 22:10:33 +0200
Message-Id: <20220401201035.189106-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm Shared Memory Driver bindings to DT Schema.

Changes against original bindings: enforce only specific names of child
nodes, instead of any names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/qcom,smd-rpm-regulator.yaml     |   2 +-
 .../bindings/remoteproc/qcom,q6v5.txt         |   2 +-
 .../bindings/remoteproc/qcom,wcnss-pil.txt    |   2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.txt |  98 -------------
 .../bindings/soc/qcom/qcom,smd.yaml           | 137 ++++++++++++++++++
 6 files changed, 142 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index f052e03be402..0daad8e3e260 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -12,7 +12,7 @@ description:
   resides as a subnode of the SMD.  As such, the SMD-RPM regulator requires
   that the SMD and RPM nodes be present.
 
-  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt for
+  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml for
   information pertaining to the SMD node.
 
   Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 8f1507052afd..b677900b3aae 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -250,7 +250,7 @@ the memory regions used by the Hexagon firmware. Each sub-node must contain:
 
 The Hexagon node may also have an subnode named either "smd-edge" or
 "glink-edge" that describes the communication edge, channels and devices
-related to the Hexagon.  See ../soc/qcom/qcom,smd.txt and
+related to the Hexagon.  See ../soc/qcom/qcom,smd.yaml and
 ../soc/qcom/qcom,glink.txt for details on how to describe these.
 
 = EXAMPLE
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
index a83080b8905c..ac423f4c3f1b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
@@ -111,7 +111,7 @@ and its resource dependencies. It is described by the following properties:
 
 The wcnss node can also have an subnode named "smd-edge" that describes the SMD
 edge, channels and devices related to the WCNSS.
-See ../soc/qcom/qcom,smd.txt for details on how to describe the SMD edge.
+See ../soc/qcom/qcom,smd.yaml for details on how to describe the SMD edge.
 
 = EXAMPLE
 The following example describes the resources needed to boot control the WCNSS,
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index b32457c2fc0b..bf862a11f721 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -12,7 +12,7 @@ description: |
   to vote for state of the system resources, such as clocks, regulators and bus
   frequencies.
 
-  The SMD information for the RPM edge should be filled out.  See qcom,smd.txt
+  The SMD information for the RPM edge should be filled out.  See qcom,smd.yaml
   for the required edge properties.  All SMD related properties will reside
   within the RPM node itself.
 
@@ -82,7 +82,7 @@ examples:
             qcom,ipc = <&apcs 8 0>;
             qcom,smd-edge = <15>;
 
-                rpm_requests {
+                rpm-requests {
                         compatible = "qcom,rpm-msm8974";
                         qcom,smd-channels = "rpm_requests";
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
deleted file mode 100644
index 234ae2256501..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-Qualcomm Shared Memory Driver (SMD) binding
-
-This binding describes the Qualcomm Shared Memory Driver, a fifo based
-communication channel for sending data between the various subsystems in
-Qualcomm platforms.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,smd"
-
-= EDGES
-
-Each subnode of the SMD node represents a remote subsystem or a remote
-processor of some sort - or in SMD language an "edge". The name of the edges
-are not important.
-The edge is described by the following properties:
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the IRQ used by the remote processor to
-		    signal this processor about communication related updates
-
-- mboxes:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the associated doorbell in APCS, as described
-		    in mailbox/mailbox.txt
-
-- qcom,ipc:
-	Usage: required, unless mboxes is specified
-	Value type: <prop-encoded-array>
-	Definition: three entries specifying the outgoing ipc bit used for
-		    signaling the remote processor:
-		    - phandle to a syscon node representing the apcs registers
-		    - u32 representing offset to the register within the syscon
-		    - u32 representing the ipc bit within the register
-
-- qcom,smd-edge:
-	Usage: required
-	Value type: <u32>
-	Definition: the identifier of the remote processor in the smd channel
-		    allocation table
-
-- qcom,remote-pid:
-	Usage: optional
-	Value type: <u32>
-	Definition: the identifier for the remote processor as known by the rest
-		    of the system.
-
-- label:
-	Usage: optional
-	Value type: <string>
-	Definition: name of the edge, used for debugging and identification
-		    purposes. The node name will be used if this is not
-		    present.
-
-= SMD DEVICES
-
-In turn, subnodes of the "edges" represent devices tied to SMD channels on that
-"edge". The names of the devices are not important. The properties of these
-nodes are defined by the individual bindings for the SMD devices - but must
-contain the following property:
-
-- qcom,smd-channels:
-	Usage: required
-	Value type: <stringlist>
-	Definition: a list of channels tied to this device, used for matching
-		    the device to channels
-
-= EXAMPLE
-
-The following example represents a smd node, with one edge representing the
-"rpm" subsystem. For the "rpm" subsystem we have a device tied to the
-"rpm_request" channel.
-
-	apcs: syscon@f9011000 {
-		compatible = "syscon";
-		reg = <0xf9011000 0x1000>;
-	};
-
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <0 168 1>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests {
-				compatible = "qcom,rpm-msm8974";
-				qcom,smd-channels = "rpm_requests";
-
-				...
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
new file mode 100644
index 000000000000..e6f9ffa1c0ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,smd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shared Memory Driver
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The Qualcomm Shared Memory Driver is a FIFO based communication channel for
+  sending data between the various subsystems in Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,smd
+
+patternProperties:
+  "^.*-edge|rpm$":
+    type: object
+    description:
+      Each subnode of the SMD node represents a remote subsystem or a remote
+      processor of some sort - or in SMD language an "edge". The name of the
+      edges are not important.
+
+    properties:
+      interrupts:
+        maxItems: 1
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          Name of the edge, used for debugging and identification purposes. The
+          node name will be used if this is not present.
+
+      mboxes:
+        maxItems: 1
+        description:
+          Reference to the mailbox representing the outgoing doorbell in APCS for
+          this client.
+
+      qcom,ipc:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          - items:
+              - description: phandle to a syscon node representing the APCS registers
+              - description: u32 representing offset to the register within the syscon
+              - description: u32 representing the ipc bit within the register
+        description:
+          Three entries specifying the outgoing ipc bit used for signaling the
+          remote processor.
+
+      qcom,smd-edge:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The identifier of the remote processor in the smd channel allocation
+          table.
+
+      qcom,remote-pid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The identifier for the remote processor as known by the rest of the
+          system.
+
+    # Binding for edge subnodes is not complete
+    patternProperties:
+      "^rpm-requests$":
+        type: object
+        description:
+          In turn, subnodes of the "edges" represent devices tied to SMD
+          channels on that "edge". The names of the devices are not
+          important. The properties of these nodes are defined by the
+          individual bindings for the SMD devices.
+
+        properties:
+          qcom,smd-channels:
+            $ref: /schemas/types.yaml#/definitions/string-array
+            minItems: 1
+            maxItems: 32
+            description:
+              A list of channels tied to this device, used for matching the
+              device to channels.
+
+        required:
+          - compatible
+          - qcom,smd-channels
+
+        additionalProperties: true
+
+    required:
+      - interrupts
+      - qcom,smd-edge
+
+    oneOf:
+      - required:
+          - mboxes
+      - required:
+          - qcom,ipc
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  # The following example represents a smd node, with one edge representing the
+  # "rpm" subsystem. For the "rpm" subsystem we have a device tied to the
+  # "rpm_request" channel.
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    shared-memory {
+        compatible = "qcom,smd";
+
+        rpm {
+            interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+            qcom,ipc = <&apcs 8 0>;
+            qcom,smd-edge = <15>;
+
+            rpm-requests {
+                compatible = "qcom,rpm-msm8974";
+                qcom,smd-channels = "rpm_requests";
+
+                clock-controller {
+                    compatible = "qcom,rpmcc-msm8974", "qcom,rpmcc";
+                    #clock-cells = <1>;
+                };
+
+            };
+        };
+    };
-- 
2.32.0

