Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A54EFC7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbiDAWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353189AbiDAWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:01:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB61C6495
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:59:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so8602607ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GV+7pAZohwI4MwdjqMNQX+D+U+rbeGwoLu73W6afMP4=;
        b=ZBOh3r18k94t1Nd8We8CztDWD2n2VD6cwmAbOrOLf+nAcMXUPCIy56rg9iOC7HcMLt
         JTSjRAF50LGJiFE7M9yHs6DT2R/UWoXzwHUyJqvhl1WnDeWGNYqZSm2527b8rclAjcY9
         z0qwyx9LMfrq3/b8mahIzKwZgzaXuvlIf9NnPC0KsT/b2t/im4MaOt/OOYz5yuYmbBFe
         HHWKti6/Y0CqWdTmsJTcGGivSCmpupUDqRMcpkGt3+z2HTtTopbIdNIRL8fsY2lvCB0M
         N7gVtLQTo1Iahms9uAwLOwhK8QNWNquJlvBg97Wj2o1/NYwRRxAOPmVDxTr4rE0pLUiB
         vBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GV+7pAZohwI4MwdjqMNQX+D+U+rbeGwoLu73W6afMP4=;
        b=KuASysZMNHXkvHnRjm2xZlI/jvYrQFxwH5yhp1TS8wQJ/WUbCSFud07c0Z+zvWdd0w
         OsrXSLxLSLOmrH7yk1s+Fpfe+uCbkhVqBCooKFPXvSKwjmZR3p+w1xjV7vMuAf9QPbcq
         Xy7ATP8Q31uQhtQ0cgBbn7VlUJH+Si/jG84RGahL7wM2RN+X/XEWOg6oPbxn0ZwbQhWP
         FucrGVdAP5H1toK8/Ze7J01BXW1cvvxMzGtBoz0QoL/o+6sZFSTz8206y3/B2ZyVb2rv
         zvngLqK9t6HjOsabItQDYsUehNbPb/A76JxRivFIj4Ftl1koRCIrjAhHOu+KDrPViZsJ
         O4oQ==
X-Gm-Message-State: AOAM530aHymDNBPCgmHSLxbhv5iEWw+N4pyQlDFfbgcnW4YWyUfjikR9
        BgsIn7si/7DGZczi5dww4yyWioWPH40SS0lc
X-Google-Smtp-Source: ABdhPJxt29ToBqJIoq8d5LJdbtpfa3FI0Jelg40i4cQ33FmwhmnorZA7v0HF47cWmInhdYms2Fog+g==
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id i8-20020a1709064fc800b006d85059f998mr1596592ejw.487.1648850392641;
        Fri, 01 Apr 2022 14:59:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm1444995ejc.27.2022.04.01.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:59:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,smsm: convert to dtschema
Date:   Fri,  1 Apr 2022 23:59:49 +0200
Message-Id: <20220401215949.222965-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Convert the Qualcomm Shared Memory State Machine to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index 000000000000..a40d7fa13325
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
+  "^.*@[0-9a-f]$":
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

