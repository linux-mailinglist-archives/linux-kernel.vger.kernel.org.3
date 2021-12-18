Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8EA479C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhLRS2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:28:22 -0500
Received: from ixit.cz ([94.230.151.217]:42002 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhLRS2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:28:21 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AD8F32243C;
        Sat, 18 Dec 2021 19:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639852099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZUgYlveHu1wptl4mcHz9Z2Py2LFB1xJOtEmdujskRTQ=;
        b=2VpmnA+vyPZ6aMDMxQEF9KcgrBJX998gk/MHHpSTIBwwwVkCY2wDGV/53Pe01q40PVxn50
        6hcgOpDaWwKPq2UleMzWmFepXAJ2kMQdViUZuuLCM672qV1F+VJwKC9kJg+Dn9DG/AkrXq
        ef9d6vCYuVpi+aayCyAesAWqFAP6sgg=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-binding: soc: qcom: convert rmtfs documentation to yaml
Date:   Sat, 18 Dec 2021 19:28:16 +0100
Message-Id: <20211218182816.17151-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm Remote File System Memory binding to the yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2: also removed old txt binding file
 .../reserved-memory/qcom,rmtfs-mem.txt        | 51 ------------------
 .../reserved-memory/qcom,rmtfs-mem.yaml       | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
deleted file mode 100644
index 8562ba1dce69..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-Qualcomm Remote File System Memory binding
-
-This binding describes the Qualcomm remote filesystem memory, which serves the
-purpose of describing the shared memory region used for remote processors to
-access block device data using the Remote Filesystem protocol.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be:
-		    "qcom,rmtfs-mem"
-
-- reg:
-	Usage: required for static allocation
-	Value type: <prop-encoded-array>
-	Definition: must specify base address and size of the memory region,
-		    as described in reserved-memory.txt
-
-- size:
-	Usage: required for dynamic allocation
-	Value type: <prop-encoded-array>
-	Definition: must specify a size of the memory region, as described in
-		    reserved-memory.txt
-
-- qcom,client-id:
-	Usage: required
-	Value type: <u32>
-	Definition: identifier of the client to use this region for buffers.
-
-- qcom,vmid:
-	Usage: optional
-	Value type: <u32>
-	Definition: vmid of the remote processor, to set up memory protection.
-
-= EXAMPLE
-The following example shows the remote filesystem memory setup for APQ8016,
-with the rmtfs region for the Hexagon DSP (id #1) located at 0x86700000.
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		rmtfs@86700000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0x0 0x86700000 0x0 0xe0000>;
-			no-map;
-
-			qcom,client-id = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
new file mode 100644
index 000000000000..2998f1c8f0db
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Remote File System Memory
+
+description: |
+  This binding describes the Qualcomm remote filesystem memory, which serves the
+  purpose of describing the shared memory region used for remote processors to
+  access block device data using the Remote Filesystem protocol.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: qcom,rmtfs-mem
+
+  qcom,client-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      identifier of the client to use this region for buffers
+
+  qcom,vmid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      vmid of the remote processor, to set up memory protection
+
+required:
+  - qcom,client-id
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        rmtfs@86700000 {
+            compatible = "qcom,rmtfs-mem";
+            reg = <0x86700000 0xe0000>;
+            no-map;
+
+            qcom,client-id = <1>;
+        };
+    };
-- 
2.34.1

