Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBE479CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhLRUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:50:52 -0500
Received: from ixit.cz ([94.230.151.217]:42114 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhLRUuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:50:46 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 96BBB2243C;
        Sat, 18 Dec 2021 21:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639860643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SPbbkeP1sGPm5LCVGx2XF3KQc2r04SYqHiM88lPcVw4=;
        b=UsY6mKorbpx7guY13PFJR3DbCGngPBh+OHdYrho/roLBO6xn1POvWdcyQUTbBkAQEzyA9I
        uxv7b4UNZSe2w+re1aCe0MbcMD6j2p2kKA+T8nRIzE8bPE392x7EYFrtjcVzEPuzSmfVL9
        CwyAOexAuJfwHb5lHYmF6m3xvUo+hnY=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, Alex Elder <elder@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-binding: soc: qcom: convert QCOM SMP2P binding to yaml
Date:   Sat, 18 Dec 2021 21:50:39 +0100
Message-Id: <20211218205039.35994-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SoC SMP2P binding to the yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/soc/qcom/qcom,smp2p.txt          | 110 --------------
 .../bindings/soc/qcom/qcom,smp2p.yaml         | 139 ++++++++++++++++++
 2 files changed, 139 insertions(+), 110 deletions(-)
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
index 000000000000..40d1c42e917b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,smp2p.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Shared Memory Point 2 Point
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
+patternProperties:
+  "^((master|slave)-kernel|ipa-ap-to-modem|ipa-modem-to-ap|)$":
+    type: object
+    properties:
+      interrupt-controller:
+        description: >
+          marks the entry as inbound, if not specified
+          this node will denote the outgoing entry
+
+      '#interrupt-cells':
+        const: 2
+
+      qcom,entry-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: >
+          specifies the name of this entry, for inbound entries this will be
+          used to match against the remotely allocated entry and for outbound
+          entries this name is used for allocating entries
+
+      '#qcom,smem-state-cells':
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: required for outgoing entries
+        const: 1
+
+    required:
+      - qcom,entry-name
+
+    oneOf:
+      - required:
+          - interrupt-controller
+          - '#interrupt-cells'
+      - required:
+          - '#qcom,smem-state-cells'
+
+    additionalProperties: false
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
+additionalProperties: false
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
2.34.1

