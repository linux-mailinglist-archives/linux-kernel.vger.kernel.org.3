Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10A56B50B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiGHJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:05:39 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7821F62C;
        Fri,  8 Jul 2022 02:05:35 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 14CF92007F;
        Fri,  8 Jul 2022 11:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1657271132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2cGXUPiakn1ZaffBgtmDGpCRG1NODkxKQEmT9hQ+1SY=;
        b=mpAbdggiXyuIS0sNoVDjnjUwhHeXvISksNYBU4wmP22jqTtz9W6Gj80ir777quQ/Vw1Uxa
        6SotLqAagvMFC3Fn0aGu2UJDOtFl/N5DutNIBKbGfgpxQgMz+AzaLOF3w+tB1HMmikhnFx
        CHLHaWKmJRh0UfLpCb9cTspLBDRRgRE=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] dt-bindings: firmware: convert Qualcomm SCM binding to the yaml
Date:   Fri,  8 Jul 2022 11:04:31 +0200
Message-Id: <20220708090431.30437-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SCM firmware binding to the yaml format.

This commit also:
 - adds qcom,scm-mdm9607 into list which has only core clock
 - adds qcom,scm-sm6125, qcom,scm-ipq6018
 - #reset-cells, because the property is already used

Signed-off-by: David Heidelberg <david@ixit.cz>
--
v5:
 - add qcom,scm-sdx65 from new commit to txt binding
 - add freshly merged qcom,scm-sc8280xp
 - add interconnects
 - add accidentally removed # from #include directive
 - move mdm9607 to 3 clocks (thx @Guru)
 - fix compatible string in example
v4:
 - added clocks minItems and maxItems
 - removed quotes from $id and $schema
 - adjusted description of TCSR HW block
v3:
 - add preceding patches for ARM and arm64 adding missing compatible strings
 - extended with missing compatible strings
 - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
v2:
 - changed maintainer to Bjorn
 - document #reset-cells

 .../devicetree/bindings/firmware/qcom,scm.txt |  61 --------
 .../bindings/firmware/qcom,scm.yaml           | 147 ++++++++++++++++++
 2 files changed, 147 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
deleted file mode 100644
index b3f702cbed87..000000000000
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ /dev/null
@@ -1,61 +0,0 @@
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
- * "qcom,scm-msm8976"
- * "qcom,scm-msm8994"
- * "qcom,scm-msm8996"
- * "qcom,scm-msm8998"
- * "qcom,scm-qcs404"
- * "qcom,scm-sc7180"
- * "qcom,scm-sc7280"
- * "qcom,scm-sm6125"
- * "qcom,scm-sdm845"
- * "qcom,scm-sdx55"
- * "qcom,scm-sdx65"
- * "qcom,scm-sm6350"
- * "qcom,scm-sm8150"
- * "qcom,scm-sm8250"
- * "qcom,scm-sm8350"
- * "qcom,scm-sm8450"
- and:
- * "qcom,scm"
-- clocks: Specifies clocks needed by the SCM interface, if any:
- * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
-   "qcom,scm-msm8960"
- * core, iface and bus clocks required for "qcom,scm-apq8084",
-   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
-- clock-names: Must contain "core" for the core clock, "iface" for the interface
-  clock and "bus" for the bus clock per the requirements of the compatible.
-- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
-		   download mode control register (optional)
-- interconnects: Specifies the bandwidth requirements of the SCM interface (optional)
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
index 000000000000..9fdeee07702f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,scm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM Secure Channel Manager (SCM)
+
+description: |
+  Qualcomm processors include an interface to communicate to the secure firmware.
+  This interface allows for clients to request different types of actions.
+  These can include CPU power up/down, HDCP requests, loading of firmware,
+  and other assorted actions.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Robert Marko <robimarko@gmail.com>
+  - Guru Das Srinagesh <quic_gurus@quicinc.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,scm-apq8064
+          - qcom,scm-apq8084
+          - qcom,scm-ipq4019
+          - qcom,scm-ipq6018
+          - qcom,scm-ipq806x
+          - qcom,scm-ipq8074
+          - qcom,scm-mdm9607
+          - qcom,scm-msm8226
+          - qcom,scm-msm8660
+          - qcom,scm-msm8916
+          - qcom,scm-msm8953
+          - qcom,scm-msm8960
+          - qcom,scm-msm8974
+          - qcom,scm-msm8976
+          - qcom,scm-msm8994
+          - qcom,scm-msm8996
+          - qcom,scm-msm8998
+          - qcom,scm-sc7180
+          - qcom,scm-sc7280
+          - qcom,scm-sc8280xp
+          - qcom,scm-sdm845
+          - qcom,scm-sdx55
+          - qcom,scm-sdx65
+          - qcom,scm-sm6125
+          - qcom,scm-sm6350
+          - qcom,scm-sm8150
+          - qcom,scm-sm8250
+          - qcom,scm-sm8350
+          - qcom,scm-sm8450
+          - qcom,scm-qcs404
+      - const: qcom,scm
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  interconnects:
+    maxItems: 1
+
+  interconnect-names:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  qcom,dload-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TCSR hardware block
+          - description: offset of the download mode control register
+    description: TCSR hardware block
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
+        clocks:
+          maxItems: 1
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
+              - qcom,scm-mdm9607
+              - qcom,scm-msm8916
+              - qcom,scm-msm8953
+              - qcom,scm-msm8974
+              - qcom,scm-msm8976
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+            - const: iface
+
+        clocks:
+          minItems: 3
+          maxItems: 3
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
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+
+    firmware {
+        scm {
+            compatible = "qcom,scm-msm8916", "qcom,scm";
+            clocks = <&gcc GCC_CRYPTO_CLK>,
+                     <&gcc GCC_CRYPTO_AXI_CLK>,
+                     <&gcc GCC_CRYPTO_AHB_CLK>;
+            clock-names = "core", "bus", "iface";
+        };
+    };
-- 
2.35.1

