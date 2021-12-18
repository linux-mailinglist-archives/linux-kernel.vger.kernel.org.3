Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13F479C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhLRTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:40:46 -0500
Received: from ixit.cz ([94.230.151.217]:42074 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhLRTkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:40:46 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7FE252243C;
        Sat, 18 Dec 2021 20:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639856443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+zgMDT7Rh2+ghvyZRtD81AJIH6xYk3s1MTub8cbCqso=;
        b=jduf5YbHHb0z4dNj4w4boAb8x3so/QmfPOFsN/3/LCBHtnrnD3SAFpwiUlVMIuN9p5ZzVY
        2wbxf0nTy6m4HCrj/pmbfQBc1NUj+J4wLojA3SlBSOPzPfQ7sEuCnWrhIkvGHclhsvfkSh
        /fVgL6hFeixzcI/C9ZER9hwQm/VJF/k=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: firmware: convert Qualcomm SCM binding to the yaml
Date:   Sat, 18 Dec 2021 20:40:37 +0100
Message-Id: <20211218194038.26913-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SCM firmware binding to the yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
This patch comes with followup question -> since not all definitions
follow `"qcom,scm-*chipset*", "qcom,scm"`, should I change them or adjust this
binding to cover all cases?

 .../devicetree/bindings/firmware/qcom,scm.txt |  54 ---------
 .../bindings/firmware/qcom,scm.yaml           | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
deleted file mode 100644
index d7e3cda8924e..000000000000
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-QCOM Secure Channel Manager (SCM)
-
-Qualcomm processors include an interface to communicate to the secure firmware.
-This interface allows for clients to request different types of actions.  These
-can include CPU power up/down, HDCP requests, loading of firmware, and other
-assorted actions.
-
-Required properties:
-- compatible: must contain one of the following:
- * "qcom,scm-apq8064"
- * "qcom,scm-apq8084"
- * "qcom,scm-ipq4019"
- * "qcom,scm-ipq806x"
- * "qcom,scm-ipq8074"
- * "qcom,scm-mdm9607"
- * "qcom,scm-msm8226"
- * "qcom,scm-msm8660"
- * "qcom,scm-msm8916"
- * "qcom,scm-msm8953"
- * "qcom,scm-msm8960"
- * "qcom,scm-msm8974"
- * "qcom,scm-msm8994"
- * "qcom,scm-msm8996"
- * "qcom,scm-msm8998"
- * "qcom,scm-sc7180"
- * "qcom,scm-sc7280"
- * "qcom,scm-sdm845"
- * "qcom,scm-sdx55"
- * "qcom,scm-sm8150"
- * "qcom,scm-sm8250"
- * "qcom,scm-sm8350"
- and:
- * "qcom,scm"
-- clocks: Specifies clocks needed by the SCM interface, if any:
- * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
-   "qcom,scm-msm8960"
- * core, iface and bus clocks required for "qcom,scm-apq8084",
-   "qcom,scm-msm8916", "qcom,scm-msm8953" and "qcom,scm-msm8974"
-- clock-names: Must contain "core" for the core clock, "iface" for the interface
-  clock and "bus" for the bus clock per the requirements of the compatible.
-- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
-		   download mode control register (optional)
-
-Example for MSM8916:
-
-	firmware {
-		scm {
-			compatible = "qcom,msm8916", "qcom,scm";
-			clocks = <&gcc GCC_CRYPTO_CLK> ,
-				 <&gcc GCC_CRYPTO_AXI_CLK>,
-				 <&gcc GCC_CRYPTO_AHB_CLK>;
-			clock-names = "core", "bus", "iface";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
new file mode 100644
index 000000000000..3a7261734fad
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/firmware/qcom,scm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: QCOM Secure Channel Manager (SCM)
+
+description: |
+  Qualcomm processors include an interface to communicate to the secure firmware.
+  This interface allows for clients to request different types of actions.  These
+  can include CPU power up/down, HDCP requests, loading of firmware, and other
+  assorted actions.
+
+maintainers:
+  - Andy Gross <andy.gross@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,scm-apq8064
+          - qcom,scm-apq8084
+          - qcom,scm-ipq4019
+          - qcom,scm-ipq806x
+          - qcom,scm-ipq8074
+          - qcom,scm-mdm9607
+          - qcom,scm-msm8226
+          - qcom,scm-msm8660
+          - qcom,scm-msm8916
+          - qcom,scm-msm8953
+          - qcom,scm-msm8960
+          - qcom,scm-msm8974
+          - qcom,scm-msm8994
+          - qcom,scm-msm8996
+          - qcom,scm-msm8998
+          - qcom,scm-sc7180
+          - qcom,scm-sc7280
+          - qcom,scm-sdm845
+          - qcom,scm-sdx55
+          - qcom,scm-sm8150
+          - qcom,scm-sm8250
+          - qcom,scm-sm8350
+      - const: qcom,scm
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names: true
+
+  qcom,dload-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      TCSR hardware block and offset of the download mode control register
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,scm-apq8064
+              - qcom,scm-msm8660
+              - qcom,scm-msm8960
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: core
+
+      required:
+        - clocks
+        - clock-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,scm-apq8084
+              - qcom,scm-msm8916
+              - qcom,scm-msm8953
+              - qcom,scm-msm8974
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: core
+            - const: iface
+            - const: bus
+
+      required:
+        - clocks
+        - clock-names
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        scm {
+            compatible = "qcom,msm8916", "qcom,scm";
+            clocks = <&gcc 104>,
+                     <&gcc 77>,
+                     <&gcc 86>;
+            clock-names = "core", "bus", "iface";
+        };
+    };
-- 
2.34.1

