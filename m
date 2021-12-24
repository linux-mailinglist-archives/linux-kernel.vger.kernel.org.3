Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7B47F044
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbhLXRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:02:47 -0500
Received: from ixit.cz ([94.230.151.217]:49762 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236414AbhLXRCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:02:46 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 802A92243C;
        Fri, 24 Dec 2021 18:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640365363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HbmIZwLuV6VZPMQ2LsqtWZDS7tE+7vlqNV7H+vpBED0=;
        b=lfeE112a7wnQxddN8gP4N6WncHhMYn9EUXBgFow+Li0+umYK5u9LN9Uv+Y8U9Ws3fffWo/
        YxvXmVbiBWEGXbTHelN4pltsw1BYQDJWpO7gyTbEmAs+TcazwNmDfeZNcddBhd/sqbAGqF
        +I4LPzc8tdnONr068KDTr9pNY8XcM14=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: convert Qualcomm USB HS phy to yaml
Date:   Fri, 24 Dec 2021 18:02:41 +0100
Message-Id: <20211224170242.57816-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of Qualcomm USB HS phy documentation to yaml.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/phy/qcom,usb-hs-phy.txt          | 84 ------------------
 .../bindings/phy/qcom,usb-hs-phy.yaml         | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
deleted file mode 100644
index b3b75c1e6285..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-Qualcomm's USB HS PHY
-
-PROPERTIES
-
-- compatible:
-    Usage: required
-    Value type: <string>
-    Definition: Should contain "qcom,usb-hs-phy" and more specifically one of the
-                following:
-
-                        "qcom,usb-hs-phy-apq8064"
-                        "qcom,usb-hs-phy-msm8916"
-                        "qcom,usb-hs-phy-msm8974"
-
-- #phy-cells:
-    Usage: required
-    Value type: <u32>
-    Definition: Should contain 0
-
-- clocks:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: Should contain clock specifier for the reference and sleep
-                clocks
-
-- clock-names:
-    Usage: required
-    Value type: <stringlist>
-    Definition: Should contain "ref" and "sleep" for the reference and sleep
-                clocks respectively
-
-- resets:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: Should contain the phy and POR resets
-
-- reset-names:
-    Usage: required
-    Value type: <stringlist>
-    Definition: Should contain "phy" and "por" for the phy and POR resets
-                respectively
-
-- v3p3-supply:
-    Usage: required
-    Value type: <phandle>
-    Definition: Should contain a reference to the 3.3V supply
-
-- v1p8-supply:
-    Usage: required
-    Value type: <phandle>
-    Definition: Should contain a reference to the 1.8V supply
-
-- extcon:
-    Usage: optional
-    Value type: <prop-encoded-array>
-    Definition: Should contain the vbus extcon
-
-- qcom,init-seq:
-    Usage: optional
-    Value type: <u8 array>
-    Definition: Should contain a sequence of ULPI address and value pairs to
-                program into the ULPI_EXT_VENDOR_SPECIFIC area. This is related
-                to Device Mode Eye Diagram test. The addresses are offsets
-                from the ULPI_EXT_VENDOR_SPECIFIC address, for example,
-                <0x1 0x53> would mean "write the value 0x53 to address 0x81".
-
-EXAMPLE
-
-otg: usb-controller {
-	ulpi {
-		phy {
-			compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
-			#phy-cells = <0>;
-			clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
-			clock-names = "ref", "sleep";
-			resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
-			reset-names = "phy", "por";
-			v3p3-supply = <&pm8941_l24>;
-			v1p8-supply = <&pm8941_l6>;
-			extcon = <&smbb>;
-			qcom,init-seq = /bits/ 8 <0x1 0x63>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
new file mode 100644
index 000000000000..202c42754188
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,usb-hs-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's USB HS PHY binding description
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,usb-hs-phy-apq8064
+          - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8974
+      - const: qcom,usb-hs-phy
+
+  clocks: true
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: ref
+          - const: sleep
+      - items:
+          - const: sleep
+          - const: ref
+
+  resets: true
+
+  reset-names:
+    oneOf:
+      - items:
+          - const: por
+      - items:
+          - const: phy
+          - const: por
+
+  v1p8-supply: true
+
+  v3p3-supply: true
+
+  extcon: true
+
+  "#phy-cells":
+    const: 0
+
+  qcom,init-seq:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
+      Should contain a sequence of ULPI address and value pairs to
+      program into the ULPI_EXT_VENDOR_SPECIFIC area. This is related
+      to Device Mode Eye Diagram test. The addresses are offsets
+      from the ULPI_EXT_VENDOR_SPECIFIC address, for example,
+      <0x1 0x53> would mean "write the value 0x53 to address 0x81".
+
+required:
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    otg: usb-controller {
+      ulpi {
+        phy {
+          compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
+          #phy-cells = <0>;
+          clocks = <&clk 0>, <&clk 258>;
+          clock-names = "ref", "sleep";
+          resets = <&gcc 10>, <&otg 0>;
+          reset-names = "phy", "por";
+          v3p3-supply = <&pm8941_l24>;
+          v1p8-supply = <&pm8941_l6>;
+          extcon = <&smbb>;
+          qcom,init-seq = /bits/ 8 <0x1 0x63>;
+        };
+      };
+    };
-- 
2.34.1

