Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED150D1E7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiDXNS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDXNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:18:47 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB3DE93;
        Sun, 24 Apr 2022 06:15:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [185.14.232.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BDB0524CEB;
        Sun, 24 Apr 2022 15:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650806141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdcXMwu4StCDfRuTYNtvpLD+CnAXeUVdYF37s7EbreU=;
        b=VG9iHFerBI9Cz0raVcbmWn9zE6CMctfUAgRYWg6kcv06hKspdnQ2osqyUAzO4b3M/1xp31
        UhIr4dKGljKnAlU8Fy9C2YjP9iyjqgkj3FwBUxaYuHIlYf/Ejwn2iLdRMuHFxELsVyNh9X
        JM8MGeZcoRJnIxMAZk2bbCuCHZX4M9g=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: soc: qcom: convert QCOM SMP2P binding to yaml
Date:   Sun, 24 Apr 2022 15:15:21 +0200
Message-Id: <20220424131522.14185-3-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424131522.14185-1-david@ixit.cz>
References: <20220424131522.14185-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SoC SMP2P binding to the yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - dropped constraints on sub-node names,
   converted patternProperties to additionalProperties
 - adjusted name from "Point 2 Point" to "Point to Point"
---
 .../bindings/soc/qcom/qcom,smp2p.txt          | 110 --------------
 .../bindings/soc/qcom/qcom,smp2p.yaml         | 136 ++++++++++++++++++
 2 files changed, 136 insertions(+), 110 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
deleted file mode 100644
index 49e1d72d3648..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
+++ /dev/null
@@ -1,110 +0,0 @@
-Qualcomm Shared Memory Point 2 Point binding
-
-The Shared Memory Point to Point (SMP2P) protocol facilitates communication of
-a single 32-bit value between two processors.  Each value has a single writer
-(the local side) and a single reader (the remote side).  Values are uniquely
-identified in the system by the directed edge (local processor ID to remote
-processor ID) and a string identifier.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,smp2p"
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: one entry specifying the smp2p notification interrupt
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
-		    signaling the remote end of the smp2p edge:
-		    - phandle to a syscon node representing the apcs registers
-		    - u32 representing offset to the register within the syscon
-		    - u32 representing the ipc bit within the register
-
-- qcom,smem:
-	Usage: required
-	Value type: <u32 array>
-	Definition: two identifiers of the inbound and outbound smem items used
-		    for this edge
-
-- qcom,local-pid:
-	Usage: required
-	Value type: <u32>
-	Definition: specifies the identifier of the local endpoint of this edge
-
-- qcom,remote-pid:
-	Usage: required
-	Value type: <u32>
-	Definition: specifies the identifier of the remote endpoint of this edge
-
-= SUBNODES
-Each SMP2P pair contain a set of inbound and outbound entries, these are
-described in subnodes of the smp2p device node. The node names are not
-important.
-
-- qcom,entry-name:
-	Usage: required
-	Value type: <string>
-	Definition: specifies the name of this entry, for inbound entries this
-		    will be used to match against the remotely allocated entry
-		    and for outbound entries this name is used for allocating
-		    entries
-
-- interrupt-controller:
-	Usage: required for incoming entries
-	Value type: <empty>
-	Definition: marks the entry as inbound; the node should be specified
-		    as a two cell interrupt-controller as defined in
-		    "../interrupt-controller/interrupts.txt"
-		    If not specified this node will denote the outgoing entry
-
-- #interrupt-cells:
-	Usage: required for incoming entries
-	Value type: <u32>
-	Definition: must be 2 - denoting the bit in the entry and IRQ flags
-
-- #qcom,smem-state-cells:
-	Usage: required for outgoing entries
-	Value type: <u32>
-	Definition: must be 1 - denoting the bit in the entry
-
-= EXAMPLE
-The following example shows the SMP2P setup with the wireless processor,
-defined from the 8974 apps processor's point-of-view. It encompasses one
-inbound and one outbound entry:
-
-wcnss-smp2p {
-	compatible = "qcom,smp2p";
-	qcom,smem = <431>, <451>;
-
-	interrupts = <0 143 1>;
-
-	qcom,ipc = <&apcs 8 18>;
-
-	qcom,local-pid = <0>;
-	qcom,remote-pid = <4>;
-
-	wcnss_smp2p_out: master-kernel {
-		qcom,entry-name = "master-kernel";
-
-		#qcom,smem-state-cells = <1>;
-	};
-
-	wcnss_smp2p_in: slave-kernel {
-		qcom,entry-name = "slave-kernel";
-
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
new file mode 100644
index 000000000000..9d728c76f7b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,smp2p.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Shared Memory Point to Point
+
+description: |
+  The Shared Memory Point to Point (SMP2P) protocol facilitates communication of
+  a single 32-bit value between two processors.  Each value has a single writer
+  (the local side) and a single reader (the remote side).  Values are uniquely
+  identified in the system by the directed edge (local processor ID to remote
+  processor ID) and a string identifier.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,smp2p
+
+  interrupts:
+    maxItems: 1
+
+  mboxes:
+    description: >
+      reference to the associated doorbell in APCS, as described
+      in mailbox/mailbox.txt
+
+  qcom,ipc:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: >
+      three entries specifying the outgoing ipc bit used for
+      signaling the remote end of the smp2p edge
+    minItems: 1
+    maxItems: 32 # no hard limit
+    items:
+      items:
+        - description: phandle to a syscon node representing the apcs registers
+        - description: offset to the register within the syscon
+        - description: the IPC bit within the register
+
+  qcom,smem:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: indentifiers of the smem items used for this edge
+    items:
+      - items:
+          - description: identifier of inbound smem items
+      - items:
+          - description: identifier of outbound smem items
+
+  qcom,local-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies the identifier of the local endpoint of this edge
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies the identifier of the remote endpoint of this edge
+
+additionalProperties:
+  type: object
+  properties:
+    interrupt-controller:
+      description: >
+        marks the entry as inbound, if not specified
+        this node will denote the outgoing entry
+
+    '#interrupt-cells':
+      const: 2
+
+    qcom,entry-name:
+      $ref: /schemas/types.yaml#/definitions/string
+      description: >
+        specifies the name of this entry, for inbound entries this will be
+        used to match against the remotely allocated entry and for outbound
+        entries this name is used for allocating entries
+
+    '#qcom,smem-state-cells':
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description: required for outgoing entries
+      const: 1
+
+  required:
+    - qcom,entry-name
+
+  oneOf:
+    - required:
+        - interrupt-controller
+        - '#interrupt-cells'
+    - required:
+        - '#qcom,smem-state-cells'
+
+  additionalProperties: false
+
+required:
+  - compatible
+  - qcom,smem
+  - qcom,local-pid
+  - qcom,remote-pid
+
+anyOf:
+  - required:
+      - mboxes
+  - required:
+      - qcom,ipc
+
+examples:
+  # The following example shows the SMP2P setup with the wireless processor,
+  # defined from the 8974 apps processor's point-of-view. It encompasses one
+  # inbound and one outbound entry:
+  - |
+    wcnss-smp2p {
+        compatible = "qcom,smp2p";
+        qcom,smem = <431>, <451>;
+
+        interrupts = <0 143 1>;
+
+        qcom,ipc = <&apcs 8 18>;
+
+        qcom,local-pid = <0>;
+        qcom,remote-pid = <4>;
+
+        wcnss_smp2p_out: master-kernel {
+            qcom,entry-name = "master-kernel";
+
+            #qcom,smem-state-cells = <1>;
+        };
+
+        wcnss_smp2p_in: slave-kernel {
+            qcom,entry-name = "slave-kernel";
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
-- 
2.35.1

