Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4C4F23C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiDEG5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDEG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:57:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356B24F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:55:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so17523280ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V38z6KNkG0po4D2d3HPJjL+6I1e/SaURvPwZ2pkI1iw=;
        b=tPtw9CQMpVJHh48w3R8UFCjRkqd9gPxoBFkIoBF4qaxba3O3PFDAAj7V8hcdVZ/rln
         gk6IedKPIWb+ZCvDcS9mNNGmjWqOXGNtVo421kWWlyBxjXRMCgLdjAAQkHlZFoaIscSW
         Tb91LtFcRGriSs8b0UBhv7XMvNSyztqRLTuvOWp/gZw0v1VdP9Ck8u+8Vs5+mwWfg1Ch
         H30tcQZgvl4FLPFFR/jSToVc4jlELMj9OmESSV54J494BuUoNzmyG3kGPUM9WlE78lKI
         QbMOC5gHzTfRGQYG++nEZ0feVqbP4Pjf6yudg9HlkXYKLUuhwsYpPgIpsNXj0XGE6sUH
         Mlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V38z6KNkG0po4D2d3HPJjL+6I1e/SaURvPwZ2pkI1iw=;
        b=sn77ODgr/mdr6rXdVpKpS+zIBV+mU9TMaVYVpPHhb+oxqHNwp/wIF34mP8aW9DtLbO
         bJ/PzzgLdoynTroErh/G8r49ruVSZeJxH2VicWzWamh1kBGB8AN7LqyJjjK3FSiww+Fp
         9F4GhFk7nRphXXtw1hHzNHcgSwRruXqUcPjyp6tE9PY78lM8KTpAHnILNEM2gTvzp9wP
         UGh/WlltV6r0zO1VCdKVt5qIc70e7/X5m7DzIBKQdUQ9rswOEoG7JDjbQuXYAop0PcRd
         pPykapvnhg9Ie8j70VLEVeVjT+mHEodYO+av+sLzN76vD+493OmrWgAhf3L1jZ1GBvsU
         S16g==
X-Gm-Message-State: AOAM533X7lIjkU1mLYjeYPkj5UwJnne8+Y2wwBXHE3YiOPRjlRQ4UJ5A
        rE4bSzeuSkzHmBLct0tDOoVm7g==
X-Google-Smtp-Source: ABdhPJzC1j6ts7p8CPXN/UyNDuwiyF6wmEYJBVY9WiGN2C958BD7fCvkUbny2vlzFgjCmgclLgW4nw==
X-Received: by 2002:a17:907:94cf:b0:6e4:a60b:bae5 with SMTP id dn15-20020a17090794cf00b006e4a60bbae5mr2033338ejc.476.1649141715632;
        Mon, 04 Apr 2022 23:55:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm6453247edw.75.2022.04.04.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:55:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: soc: qcom,smsm: convert to dtschema
Date:   Tue,  5 Apr 2022 08:55:12 +0200
Message-Id: <20220405065512.26521-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm Shared Memory State Machine to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Skip "^.*" from pattern.
2. Fix subjectprefix.
3. Add Rob's review.
---
 .../bindings/soc/qcom/qcom,smsm.txt           | 104 -------------
 .../bindings/soc/qcom/qcom,smsm.yaml          | 138 ++++++++++++++++++
 2 files changed, 138 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
deleted file mode 100644
index 2993b5a97dd6..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
+++ /dev/null
@@ -1,104 +0,0 @@
-Qualcomm Shared Memory State Machine
-
-The Shared Memory State Machine facilitates broadcasting of single bit state
-information between the processors in a Qualcomm SoC. Each processor is
-assigned 32 bits of state that can be modified. A processor can through a
-matrix of bitmaps signal subscription of notifications upon changes to a
-certain bit owned by a certain remote processor.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,smsm"
-
-- qcom,ipc-N:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: three entries specifying the outgoing ipc bit used for
-		    signaling the N:th remote processor
-		    - phandle to a syscon node representing the apcs registers
-		    - u32 representing offset to the register within the syscon
-		    - u32 representing the ipc bit within the register
-
-- qcom,local-host:
-	Usage: optional
-	Value type: <u32>
-	Definition: identifier of the local processor in the list of hosts, or
-		    in other words specifier of the column in the subscription
-		    matrix representing the local processor
-		    defaults to host 0
-
-- #address-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1
-
-- #size-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 0
-
-= SUBNODES
-Each processor's state bits are described by a subnode of the smsm device node.
-Nodes can either be flagged as an interrupt-controller to denote a remote
-processor's state bits or the local processors bits.  The node names are not
-important.
-
-- reg:
-	Usage: required
-	Value type: <u32>
-	Definition: specifies the offset, in words, of the first bit for this
-		    entry
-
-- #qcom,smem-state-cells:
-	Usage: required for local entry
-	Value type: <u32>
-	Definition: must be 1 - denotes bit number
-
-- interrupt-controller:
-	Usage: required for remote entries
-	Value type: <empty>
-	Definition: marks the entry as a interrupt-controller and the state bits
-		    to belong to a remote processor
-
-- #interrupt-cells:
-	Usage: required for remote entries
-	Value type: <u32>
-	Definition: must be 2 - denotes bit number and IRQ flags
-
-- interrupts:
-	Usage: required for remote entries
-	Value type: <prop-encoded-array>
-	Definition: one entry specifying remote IRQ used by the remote processor
-		    to signal changes of its state bits
-
-
-= EXAMPLE
-The following example shows the SMEM setup for controlling properties of the
-wireless processor, defined from the 8974 apps processor's point-of-view. It
-encompasses one outbound entry and the outgoing interrupt for the wireless
-processor.
-
-smsm {
-	compatible = "qcom,smsm";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	qcom,ipc-3 = <&apcs 8 19>;
-
-	apps_smsm: apps@0 {
-		reg = <0>;
-
-		#qcom,smem-state-cells = <1>;
-	};
-
-	wcnss_smsm: wcnss@7 {
-		reg = <7>;
-		interrupts = <0 144 1>;
-
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
new file mode 100644
index 000000000000..db67cf043256
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,smsm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Shared Memory State Machine
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The Shared Memory State Machine facilitates broadcasting of single bit state
+  information between the processors in a Qualcomm SoC. Each processor is
+  assigned 32 bits of state that can be modified. A processor can through a
+  matrix of bitmaps signal subscription of notifications upon changes to a
+  certain bit owned by a certain remote processor.
+
+properties:
+  compatible:
+    const: qcom,smsm
+
+  '#address-cells':
+    const: 1
+
+  qcom,local-host:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Identifier of the local processor in the list of hosts, or in other words
+      specifier of the column in the subscription matrix representing the local
+      processor.
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^qcom,ipc-[1-4]$":
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to a syscon node representing the APCS registers
+          - description: u32 representing offset to the register within the syscon
+          - description: u32 representing the ipc bit within the register
+    description:
+      Three entries specifying the outgoing ipc bit used for signaling the N:th
+      remote processor.
+
+  "@[0-9a-f]$":
+    type: object
+    description:
+      Each processor's state bits are described by a subnode of the SMSM device
+      node.  Nodes can either be flagged as an interrupt-controller to denote a
+      remote processor's state bits or the local processors bits.  The node
+      names are not important.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      interrupt-controller:
+        description:
+          Marks the entry as a interrupt-controller and the state bits to
+          belong to a remote processor.
+
+      '#interrupt-cells':
+        const: 2
+
+      interrupts:
+        maxItems: 1
+        description:
+          One entry specifying remote IRQ used by the remote processor to
+          signal changes of its state bits.
+
+      '#qcom,smem-state-cells':
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 1
+        description:
+          Required for local entry. Denotes bit number.
+
+    required:
+      - reg
+
+    oneOf:
+      - required:
+          - '#qcom,smem-state-cells'
+      - required:
+          - interrupt-controller
+          - '#interrupt-cells'
+          - interrupts
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+
+anyOf:
+  - required:
+      - qcom,ipc-1
+  - required:
+      - qcom,ipc-2
+  - required:
+      - qcom,ipc-3
+  - required:
+      - qcom,ipc-4
+
+additionalProperties: false
+
+examples:
+  # The following example shows the SMEM setup for controlling properties of
+  # the wireless processor, defined from the 8974 apps processor's
+  # point-of-view. It encompasses one outbound entry and the outgoing interrupt
+  # for the wireless processor.
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    shared-memory {
+        compatible = "qcom,smsm";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        qcom,ipc-3 = <&apcs 8 19>;
+
+        apps_smsm: apps@0 {
+            reg = <0>;
+            #qcom,smem-state-cells = <1>;
+        };
+
+        wcnss_smsm: wcnss@7 {
+            reg = <7>;
+            interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
-- 
2.32.0

