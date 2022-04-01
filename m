Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1A4EF8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiDARMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiDARMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:12:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181C92DA93
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:10:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c7so5257147wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtc0r33WP14cEsrZqwD4QZdIHMMUqw4VRfbzyFN9zcI=;
        b=T86KnLvcENK6vxHzQQBGs+xno70D0fUd5uHERzr2EUB2h1RyMvB3L8bFM2kARK2wEw
         zpqa8lwLvGiCtLqaU7Xyo8BIJiwzW8xifpHUHbYVWtMTts+ysAd19ytTaH+Uy3w1xZx3
         7REKmZmq8Oo42q3J2zKP3nxjAmwaSozY7nE/Qk3IlNPPvi+lIimmabSia+I/truHNKEc
         GLXqVkJnvF77KGkJiYW8sjZmvz1S24oFDNPafeCgjL5wsxb1y/V9v/5pPKRuD4hhm8nC
         65d6WzqNF0IZ+jDniL2urfXfGhQKDywghq/LeNIthHTNMalGtX0FMcUQY653Az+w9SZ/
         drJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtc0r33WP14cEsrZqwD4QZdIHMMUqw4VRfbzyFN9zcI=;
        b=a3DtS37EZOe8ORLGSoazeno3nJfyWh4wkCgfwquBTenuhA+O7N6lJ8e5JTZI3pB2UL
         KlqcKLPhu27o0uQZ8cIaauEtmbzN0i98peNix57R7hmaHF0u3SzkGVLjSSgJdS4lvG4H
         KE18A8UGI6Xty2lQMyPiosWTxhXcAwWGpOvMIs4gfZZbKsChKgIOZSRdlPjAAHwVybCd
         lAfA8S+YdRssj8pjVBugi0j3AY9DuK5yX+eB4389YQeqWoTbqRK9/r9SwxRSPJVaj38c
         hi6gPg9URBrq1i0wi/+r2gMiloZJopbpeXXffo7VzjP6Ej/rU9fZghX7/KftuW1X/W+v
         3ugQ==
X-Gm-Message-State: AOAM533DFpPD4vClCTb0bB4FcQjKAy50mJA9aMYRsjLhrRDstNDmMKnI
        LrVWUK79trJ394+uHJjoXLvykg==
X-Google-Smtp-Source: ABdhPJweuNmNgYcc50tSfFZ4+bVpsorn2yZtJtgONlQG0fxnUHa8+DlQjc/iAekVuWT/1loBlkWiOQ==
X-Received: by 2002:a05:6000:1010:b0:204:c3c0:ad93 with SMTP id a16-20020a056000101000b00204c3c0ad93mr8342432wrx.311.1648833038514;
        Fri, 01 Apr 2022 10:10:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm2601728wmq.45.2022.04.01.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:10:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: soc: qcom,smp2p: convert to dtschema
Date:   Fri,  1 Apr 2022 19:10:35 +0200
Message-Id: <20220401171035.1096670-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Convert the Qualcomm Shared Memory Point 2 Point bindings to DT Schema.

Changes against original bindings: enforce only specific names of child
nodes, instead of any names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/qcom/qcom,smp2p.txt          | 110 -------------
 .../bindings/soc/qcom/qcom,smp2p.yaml         | 145 ++++++++++++++++++
 2 files changed, 145 insertions(+), 110 deletions(-)
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
index 000000000000..8c362ce3c05b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,smp2p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shared Memory Point 2 Point
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The Shared Memory Point to Point (SMP2P) protocol facilitates communication
+  of a single 32-bit value between two processors.  Each value has a single
+  writer (the local side) and a single reader (the remote side).  Values are
+  uniquely identified in the system by the directed edge (local processor ID to
+  remote processor ID) and a string identifier.
+
+properties:
+  compatible:
+    const: qcom,smp2p
+
+  interrupts:
+    maxItems: 1
+
+  mboxes:
+    maxItems: 1
+    description:
+      Reference to the mailbox representing the outgoing doorbell in APCS for
+      this client.
+
+  qcom,ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to a syscon node representing the apcs registers
+          - description: u32 representing offset to the register within the syscon
+          - description: u32 representing the ipc bit within the register
+    description:
+      Three entries specifying the outgoing ipc bit used for signaling the
+      remote end of the smp2p edge.
+
+  qcom,local-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      The identifier of the local endpoint of this edge.
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      The identifier of the remote endpoint of this edge.
+
+  qcom,smem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      maxItems: 2
+    description:
+      Two identifiers of the inbound and outbound smem items used for this edge.
+
+patternProperties:
+  "^master-kernel|slave-kernel|ipa-ap-to-modem|ipa-modem-to-ap$":
+    type: object
+    description:
+      Each SMP2P pair contain a set of inbound and outbound entries, these are
+      described in subnodes of the smp2p device node. The node names are not
+      important.
+
+    properties:
+      interrupt-controller:
+        description:
+          Marks the entry as inbound; the node should be specified as a two
+          cell interrupt-controller.  If not specified this node will denote
+          the outgoing entry.
+
+      '#interrupt-cells':
+        const: 2
+
+      qcom,entry-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The name of this entry, for inbound entries this will be used to
+          match against the remotely allocated entry and for outbound entries
+          this name is used for allocating entries.
+
+      '#qcom,smem-state-cells':
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 1
+        description:
+          Required for outgoing entries.
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
+  - interrupts
+  - qcom,local-pid
+  - qcom,remote-pid
+  - qcom,smem
+
+oneOf:
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
+  # inbound and one outbound entry.
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    shared-memory {
+        compatible = "qcom,smp2p";
+        qcom,smem = <431>, <451>;
+        interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+        qcom,ipc = <&apcs 8 18>;
+        qcom,local-pid = <0>;
+        qcom,remote-pid = <4>;
+
+        wcnss_smp2p_out: master-kernel {
+            qcom,entry-name = "master-kernel";
+            #qcom,smem-state-cells = <1>;
+        };
+
+        wcnss_smp2p_in: slave-kernel {
+            qcom,entry-name = "slave-kernel";
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
-- 
2.32.0

