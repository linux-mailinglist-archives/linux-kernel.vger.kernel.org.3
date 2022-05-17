Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D5529A55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbiEQHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiEQHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD214578C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z2so32808885ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DJsn/mWARyNVzFFXmoMpEbl4HOTy1K9KwSYNDuFj9U=;
        b=tX0S2rPvPxXu1gxVAyHLA4IigsrtkxiNYbCB9ZWci1DAh/PV6oHyPahbk9vfx96W6P
         W1AEKpsnrACJggLhkibH+HKSlwQSgDp72nEMH6xZJmsLa/OCooEliXjprpiBb8oid305
         7f3qMhiFkonRiURXY13leUP2dHaYM+n95z0aiAWr3sdmWHVFITAgc8wFzWENYgMH9C32
         lm6fIBcqNSSwVkwfCao1pEmCQeeYF0mDzoQyrI5//rsCo6CCToajKVukt+UhKOWCo0dw
         YDx7x1WAY9Zpb3bB3MqXva/P1BOa1lyfJ47Ghh63XlJql8r6gzvD9d2WmtKm0OAjjER5
         TN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DJsn/mWARyNVzFFXmoMpEbl4HOTy1K9KwSYNDuFj9U=;
        b=CpzcUBt+6iSCDt0QYF68EEE48rUM9Rlm4nhQo6uCspvnJ8iRTGMQ1JzMR1QvtE2NAt
         6u+DA6VwXhEuc7c/0+SjoeenEDycZlKRGKq0q7ecH+gFeBfS/YQRiFIpykQq8GkJG/Dd
         B0WmhZgPFDxk0TFPCpMiehn2C0mCIivsf/GKugvJi+4kkVRl4QB62Esf/PTelkzeSWVs
         CaxKlEwsZg189e/HRqhqFhxFWChPIDr50ZzR9Nb8+7gyPcEGgRLPiHZk7/sJ1X0ioh5d
         Rra/9W30HJzqujdgKrR2FY2XGVbWBwbW8iU23ZV0ryDv3XlkYbV6LIaW719OgYH2CU1U
         2mPA==
X-Gm-Message-State: AOAM532t0oV29ArXHo6BX7gfS2AWwwHLuGRGYJ+IpnV/5SioGhY1y6VK
        VJ+xBKm4bGiQJcJLerYMTlqXdw==
X-Google-Smtp-Source: ABdhPJw9wi36hEQlHYvDqC5oCxBJcpriV+CqViVf5bwsdEh1BBquoGhaJm901prYo0InIM51Vhlc1A==
X-Received: by 2002:a17:907:2da9:b0:6f8:6104:659 with SMTP id gt41-20020a1709072da900b006f861040659mr18681405ejc.556.1652770887470;
        Tue, 17 May 2022 00:01:27 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 08/12] dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge
Date:   Tue, 17 May 2022 09:01:09 +0200
Message-Id: <20220517070113.18023-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
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

'smd-edge' property appears in multiple bindings, so split it into one
place which can be re-used.  This reduces code duplication and adds
strict schema matching for smd-edge nodes (instead of just
"type:object").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Remove ref from label (Rob)
2. Add tags
3. Remove too many blank lines in schema description
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  2 +-
 .../bindings/remoteproc/qcom,smd-edge.yaml    | 85 +++++++++++++++++++
 .../bindings/soc/qcom/qcom,smd.yaml           | 53 +-----------
 3 files changed, 88 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 4dfbfece1ec7..3072af5f9d79 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -148,7 +148,7 @@ properties:
       three offsets within syscon for q6, modem and nc halt registers.
 
   smd-edge:
-    type: object
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
     description:
       Qualcomm Shared Memory subnode which represents communication edge,
       channels and devices related to the ADSP.
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
new file mode 100644
index 000000000000..06eebf791e32
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,smd-edge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SMD Edge communication channel nodes
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  Qualcomm SMD subnode represents a remote subsystem or a remote processor of
+  some sort - or in SMD language an "edge". The name of the edges are not
+  important.
+  See also Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+
+properties:
+  $nodename:
+    const: "smd-edge"
+
+  interrupts:
+    maxItems: 1
+
+  label:
+    description:
+      Name of the edge, used for debugging and identification purposes. The
+      node name will be used if this is not present.
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
+          - description: phandle to a syscon node representing the APCS registers
+          - description: u32 representing offset to the register within the syscon
+          - description: u32 representing the ipc bit within the register
+    description:
+      Three entries specifying the outgoing ipc bit used for signaling the
+      remote processor.
+
+  qcom,smd-edge:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The identifier of the remote processor in the smd channel allocation
+      table.
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The identifier for the remote processor as known by the rest of the
+      system.
+
+required:
+  - interrupts
+  - qcom,smd-edge
+
+oneOf:
+  - required:
+      - mboxes
+  - required:
+      - qcom,ipc
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    remoteproc {
+        // ...
+
+        smd-edge {
+            interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+            qcom,ipc = <&apcs 8 8>;
+            qcom,smd-edge = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index e6f9ffa1c0ea..a609c3425816 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -21,51 +21,12 @@ properties:
 
 patternProperties:
   "^.*-edge|rpm$":
-    type: object
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
     description:
       Each subnode of the SMD node represents a remote subsystem or a remote
       processor of some sort - or in SMD language an "edge". The name of the
       edges are not important.
 
-    properties:
-      interrupts:
-        maxItems: 1
-
-      label:
-        $ref: /schemas/types.yaml#/definitions/string
-        description:
-          Name of the edge, used for debugging and identification purposes. The
-          node name will be used if this is not present.
-
-      mboxes:
-        maxItems: 1
-        description:
-          Reference to the mailbox representing the outgoing doorbell in APCS for
-          this client.
-
-      qcom,ipc:
-        $ref: /schemas/types.yaml#/definitions/phandle-array
-        items:
-          - items:
-              - description: phandle to a syscon node representing the APCS registers
-              - description: u32 representing offset to the register within the syscon
-              - description: u32 representing the ipc bit within the register
-        description:
-          Three entries specifying the outgoing ipc bit used for signaling the
-          remote processor.
-
-      qcom,smd-edge:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          The identifier of the remote processor in the smd channel allocation
-          table.
-
-      qcom,remote-pid:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          The identifier for the remote processor as known by the rest of the
-          system.
-
     # Binding for edge subnodes is not complete
     patternProperties:
       "^rpm-requests$":
@@ -91,17 +52,7 @@ patternProperties:
 
         additionalProperties: true
 
-    required:
-      - interrupts
-      - qcom,smd-edge
-
-    oneOf:
-      - required:
-          - mboxes
-      - required:
-          - qcom,ipc
-
-    additionalProperties: false
+    unevaluatedProperties: false
 
 required:
   - compatible
-- 
2.32.0

