Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74793479D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhLRVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:36:03 -0500
Received: from ixit.cz ([94.230.151.217]:42164 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhLRVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:36:02 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 309AE2243C;
        Sat, 18 Dec 2021 22:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639863360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YHRge3bUDoDMh2nznf7wZYZYCRWtrOGMZUeO3tamWnc=;
        b=OkzNcL46UQYp/TqxiQbBlwxTX9ni9NsM9/KAUM+3AVGBppuF9pkJ3fxg8ydHlKb7xVhv3h
        E91weWNFUnnDBLDACsm22wpAJgAmYMHnUju1x+Q2PRfBdhK3BIeTjhp80HYa2fOmbF5Znw
        sjLQ/f+t2irCs5/zvTl+eCwoJijRutg=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: dt-bindings: soc: qcom: convert GLINK binding to yaml
Date:   Sat, 18 Dec 2021 22:35:56 +0100
Message-Id: <20211218213556.42061-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm GLINK binding to the yaml syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
 .../bindings/soc/qcom/qcom,glink.yaml         | 106 ++++++++++++++++++
 2 files changed, 106 insertions(+), 94 deletions(-)
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
index 000000000000..11a7c845ea0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
@@ -0,0 +1,106 @@
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
+patternProperties:
+  ".*":
+    type: object
+    properties:
+      qcom,glink-channels:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: >
+          a list of channels tied to this function, used for matching
+          the function to a set of virtual channels
+
+      'qcom,intents':
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: >
+          a list of size, amount pairs describing what intents should
+          be preallocated for this virtual channel. This can be used
+          to tweak the default intents available for the channel to
+          meet expectations of the remote
+
+    required:
+      - qcom,glink-channels
+
+    additionalProperties: true
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
+additionalProperties: false
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
2.34.1

