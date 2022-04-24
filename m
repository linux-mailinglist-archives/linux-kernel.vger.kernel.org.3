Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C713950D12C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiDXKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiDXKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:39:03 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Apr 2022 03:36:00 PDT
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D2FB7FF;
        Sun, 24 Apr 2022 03:35:59 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 0560D2007F;
        Sun, 24 Apr 2022 12:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650795399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsxlHSCxfLkkpkO33EFxBJss/Y+p5nxxc/qA09xOduY=;
        b=oVJr/PwOq3gjJ+cvMMYV0Vqkys94BMt9RRAl0kDxzpMijPzBvEG5Vq0KJx+80+0dIuRbae
        CSr8ADB1Yyvq91gamdcmeBuFuUV9/Cox7Y2A0pfuOHwRFqWKQHGPGU6hEMb18jy1EYRDTe
        tRu0gWgUqrEeECTjsOxO/v/j1NZBz7Y=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Date:   Sun, 24 Apr 2022 12:16:37 +0200
Message-Id: <20220424101637.20721-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm GLINK binding to the yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v1:
 - remove quotes around qcom,intent
 - use additionalProperties

 .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
 .../bindings/soc/qcom/qcom,glink.yaml         | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
deleted file mode 100644
index 1214192847ac..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-Qualcomm GLINK edge binding
-
-This binding describes a Qualcomm GLINK edge, a fifo based mechanism for
-communication between subsystem-pairs on various Qualcomm platforms. Two types
-of edges can be described by the binding; the GLINK RPM edge and a SMEM based
-edge.
-
-- compatible:
-	Usage: required for glink-rpm
-	Value type: <stringlist>
-	Definition: must be "qcom,glink-rpm"
-
-- label:
-	Usage: optional
-	Value type: <string>
-	Definition: should specify the subsystem name this edge corresponds to.
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the IRQ used by the remote processor to
-		    signal this processor about communication related events
-
-- qcom,remote-pid:
-	Usage: required for glink-smem
-	Value type: <u32>
-	Definition: specifies the identifier of the remote endpoint of this edge
-
-- qcom,rpm-msg-ram:
-	Usage: required for glink-rpm
-	Value type: <prop-encoded-array>
-	Definition: handle to RPM message memory resource
-
-- mboxes:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the "rpm_hlos" mailbox in APCS, as described
-		    in mailbox/mailbox.txt
-
-= GLINK DEVICES
-Each subnode of the GLINK node represent function tied to a virtual
-communication channel. The name of the nodes are not important. The properties
-of these nodes are defined by the individual bindings for the specific function
-- but must contain the following property:
-
-- qcom,glink-channels:
-	Usage: required
-	Value type: <stringlist>
-	Definition: a list of channels tied to this function, used for matching
-		    the function to a set of virtual channels
-
-- qcom,intents:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: a list of size,amount pairs describing what intents should
-		    be preallocated for this virtual channel. This can be used
-		    to tweak the default intents available for the channel to
-		    meet expectations of the remote.
-
-= EXAMPLE
-The following example represents the GLINK RPM node on a MSM8996 device, with
-the function for the "rpm_request" channel defined, which is used for
-regulators and root clocks.
-
-	apcs_glb: mailbox@9820000 {
-		compatible = "qcom,msm8996-apcs-hmss-global";
-		reg = <0x9820000 0x1000>;
-
-		#mbox-cells = <1>;
-	};
-
-	rpm_msg_ram: memory@68000 {
-		compatible = "qcom,rpm-msg-ram";
-		reg = <0x68000 0x6000>;
-	};
-
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-
-		mboxes = <&apcs_glb 0>;
-
-		rpm-requests {
-			compatible = "qcom,rpm-msm8996";
-			qcom,glink-channels = "rpm_requests";
-
-			qcom,intents = <0x400 5
-					0x800 1>;
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
new file mode 100644
index 000000000000..12ccc875ff0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,glink.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm GLINK edge
+
+description: |
+  Qualcomm GLINK edge, a fifo based mechanism for communication between
+  subsystem-pairs on various Qualcomm platforms. Two types of edges can be
+  described by the binding; the GLINK RPM edge and a SMEM based.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  $nodename:
+    pattern: "^(rpm-)?glink(-edge)?$"
+
+  compatible:
+    const: qcom,glink-rpm
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: should specify the subsystem name this edge corresponds to
+
+  interrupts:
+    description: >
+      should specify the IRQ used by the remote processor to
+      signal this processor about communication related events
+    maxItems: 1
+
+  mboxes:
+    description: >
+      reference to the "rpm_hlos" mailbox in APCS, as described
+      in mailbox/mailbox.txt
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies the identifier of the remote endpoint of this edge
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: RPM message memory resource
+
+additionalProperties:
+  type: object
+  properties:
+    qcom,glink-channels:
+      $ref: /schemas/types.yaml#/definitions/string
+      description: >
+        a list of channels tied to this function, used for matching
+        the function to a set of virtual channels
+
+    qcom,intents:
+      $ref: /schemas/types.yaml#/definitions/uint32-array
+      description: >
+        a list of size, amount pairs describing what intents should
+        be preallocated for this virtual channel. This can be used
+        to tweak the default intents available for the channel to
+        meet expectations of the remote
+
+  required:
+    - qcom,glink-channels
+
+  additionalProperties: false
+
+required:
+  - interrupts
+  - mboxes
+  - qcom,smem
+  - qcom,local-pid
+  - qcom,remote-pid
+
+anyOf:
+  - required:
+      - qcom,remote-pid
+  - required:
+      - qcom,rpm-msg-ram
+
+examples:
+  # The following example represents the GLINK RPM node on a MSM8996 device,
+  # with the function for the "rpm_request" channel defined, which
+  # is used for regulators and root clocks.
+  - |
+    rpm-glink {
+        compatible = "qcom,glink-rpm";
+
+        interrupts = <0 168 1>;
+
+        qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+        mboxes = <&apcs_glb 0>;
+
+        rpm-requests {
+            compatible = "qcom,rpm-msm8996";
+            qcom,glink-channels = "rpm_requests";
+
+            qcom,intents = <0x400 5
+                            0x800 1>;
+        };
+    };
-- 
2.35.1

