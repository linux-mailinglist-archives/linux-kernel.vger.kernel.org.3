Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C447F03F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352593AbhLXQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:50:20 -0500
Received: from ixit.cz ([94.230.151.217]:49730 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236414AbhLXQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:50:19 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A47842243C;
        Fri, 24 Dec 2021 17:50:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640364618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0hPROkzSJG3RWXzy2nCv6OuuMMuRGi/5ZutaTzY09Lk=;
        b=TcVg8jctekCD9HNYhsjtS9+GsoVBlMGETFqIK7lOqlJuvIuKn4o1+skshZISOhFcJRNB6b
        bi38/U2DeY51ffzMOoDSSXQqr7CTIiGsKpKbO69QAwfDTIu6oXOivSDYGqj+ovd171N6tw
        rvagwEfKgkkL4rbWvuS5esxMaz72WE8=
From:   David Heidelberg <david@ixit.cz>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date:   Fri, 24 Dec 2021 17:50:14 +0100
Message-Id: <20211224165014.56308-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm IOMMU v0 implementation to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
 .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
deleted file mode 100644
index 20236385f26e..000000000000
--- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* QCOM IOMMU
-
-The MSM IOMMU is an implementation compatible with the ARM VMSA short
-descriptor page tables. It provides address translation for bus masters outside
-of the CPU, each connected to the IOMMU through a port called micro-TLB.
-
-Required Properties:
-
-  - compatible: Must contain "qcom,apq8064-iommu".
-  - reg: Base address and size of the IOMMU registers.
-  - interrupts: Specifiers for the MMU fault interrupts. For instances that
-    support secure mode two interrupts must be specified, for non-secure and
-    secure mode, in that order. For instances that don't support secure mode a
-    single interrupt must be specified.
-  - #iommu-cells: The number of cells needed to specify the stream id. This
-		  is always 1.
-  - qcom,ncb:	  The total number of context banks in the IOMMU.
-  - clocks	: List of clocks to be used during SMMU register access. See
-		  Documentation/devicetree/bindings/clock/clock-bindings.txt
-		  for information about the format. For each clock specified
-		  here, there must be a corresponding entry in clock-names
-		  (see below).
-
-  - clock-names	: List of clock names corresponding to the clocks specified in
-		  the "clocks" property (above).
-		  Should be "smmu_pclk" for specifying the interface clock
-		  required for iommu's register accesses.
-		  Should be "smmu_clk" for specifying the functional clock
-		  required by iommu for bus accesses.
-
-Each bus master connected to an IOMMU must reference the IOMMU in its device
-node with the following property:
-
-  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
-	    phandle to the IOMMU and the second cell is the stream id.
-	    A single master device can be connected to more than one iommu
-	    and multiple contexts in each of the iommu. So multiple entries
-	    are required to list all the iommus and the stream ids that the
-	    master is connected to.
-
-Example: mdp iommu and its bus master
-
-                mdp_port0: iommu@7500000 {
-			compatible = "qcom,apq8064-iommu";
-			#iommu-cells = <1>;
-			clock-names =
-			    "smmu_pclk",
-			    "smmu_clk";
-			clocks =
-			    <&mmcc SMMU_AHB_CLK>,
-			    <&mmcc MDP_AXI_CLK>;
-			reg = <0x07500000 0x100000>;
-			interrupts =
-			    <GIC_SPI 63 0>,
-			    <GIC_SPI 64 0>;
-			qcom,ncb = <2>;
-		};
-
-		mdp: qcom,mdp@5100000 {
-			compatible = "qcom,mdp";
-			...
-			iommus = <&mdp_port0 0
-				  &mdp_port0 2>;
-		};
diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
new file mode 100644
index 000000000000..989f7dc643a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: "http://devicetree.org/schemas/iommu/msm,iommu-v0.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm IOMMU for APQ8064
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+
+description: >
+  The MSM IOMMU is an implementation compatible with the ARM VMSA short
+  descriptor page tables. It provides address translation for bus masters
+  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+properties:
+  compatible:
+    const: qcom,apq8064-iommu
+
+  clocks:
+    items:
+      - description: interface clock for register accesses
+      - description: functional clock for bus accesses
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: smmu_pclk
+          - const: smmu_clk
+      - items:
+          - const: smmu_pclk
+          - const: iommu_clk
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: >
+      Specifiers for the MMU fault interrupts. For instances that
+      support secure mode two interrupts must be specified, for non-secure and
+      secure mode, in that order. For instances that don't support secure mode a
+      single interrupt must be specified.
+
+  "#iommu-cells":
+    const: 1
+
+  qcom,ncb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The total number of context banks in the IOMMU.
+
+# Each bus master connected to an IOMMU must reference the IOMMU
+# in its device node with the following property:
+#   A reference to the IOMMU in multiple cells. The first cell is a
+#   phandle to the IOMMU and the second cell is the stream id.
+#   A single master device can be connected to more than one iommu
+#   and multiple contexts in each of the iommu. So multiple entries
+#   are required to list all the iommus and the stream ids that the
+#   master is connected to.
+
+required:
+  - clocks
+  - clock-names
+  - reg
+  - interrupts
+  - qcom,ncb
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
+
+    mdp_port0: iommu@7500000 {
+            compatible = "qcom,apq8064-iommu";
+            #iommu-cells = <1>;
+            clock-names =
+                "smmu_pclk",
+                "smmu_clk";
+            clocks =
+                <&clk SMMU_AHB_CLK>,
+                <&clk MDP_AXI_CLK>;
+            reg = <0x07500000 0x100000>;
+            interrupts =
+                <0 63 0>,
+                <0 64 0>;
+            qcom,ncb = <2>;
+    };
+
+    mdp: mdp@5100000 {
+            compatible = "qcom,mdp4";
+            // ...
+
+            iommus = <&mdp_port0 0
+                      &mdp_port0 2>;
+    };
-- 
2.34.1

