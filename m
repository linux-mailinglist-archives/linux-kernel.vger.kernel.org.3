Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA324C1FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiBWXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbiBWXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:27 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0A5A589;
        Wed, 23 Feb 2022 15:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659476; x=1677195476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MKLa2yx3nWTCH8/dR6dYi3DXpTMspvp8pf1dvGQZKQ=;
  b=BxT4wK+FRMFIICKFGVQQTIT9V2dermF6KI2W939JQZ/uU1GHSAoKXMow
   gBWu/gcBP7yxpvr9pXF7+wZQxqC3/raDURV5AitTNTbgpmK+hW7srEWKi
   63iNYhtMdDpCjW/grMeTzN2dH7SoiCQQdw7sY7U14hih4HDTxc0DkRL1m
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Feb 2022 15:37:55 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:55 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:54 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 02/11] dt-bindings: Add binding for gunyah hypervisor
Date:   Wed, 23 Feb 2022 15:37:20 -0800
Message-ID: <20220223233729.1571114-3-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Linux is booted as a guest under the Gunyah hypervisor, Gunyah
applies a devicetree overlay describing the virtual platform
configuration of the guest VM, such as the message queue capability IDs
for communicating with the Resource Manager. Add the DT bindings that
Gunyah adheres for the hypervisor node and message queues.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../bindings/gunyah/message-queue.yml         | 100 ++++++++++++++
 .../bindings/gunyah/qcom,hypervisor.yml       | 122 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gunyah/message-queue.yml
 create mode 100644 Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml

diff --git a/Documentation/devicetree/bindings/gunyah/message-queue.yml b/Documentation/devicetree/bindings/gunyah/message-queue.yml
new file mode 100644
index 000000000000..1a96d3de2a19
--- /dev/null
+++ b/Documentation/devicetree/bindings/gunyah/message-queue.yml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gunyah message queue
+
+maintainers:
+   - Murali Nalajala <quic_mnalajal@quicinc.com>
+   - Elliot Berman <quic_eberman@quicinc.com>
+
+properties:
+  compatible:
+    items:
+      - const: qcom,gunyah-message-queue
+      - const: qcom,gunyah-capability
+  peer:
+    description: VMID of the VM on the other end of message queue
+    $ref: /schemas/types.yaml#/definitions/uint32
+  allOf:
+    - if:
+        anyOf:
+          - properties:
+              qcom,is-sender: true
+          - properties:
+              qcom,is-full-duplex: true
+      then:
+        properties:
+          qcom,tx-message-size:
+            description: Maximum size in bytes of a message which can be sent by this queue
+            $ref: /schemas/types.yaml#/definitions/int32
+          qcom,tx-queue-depth:
+            description: Depth of transmit queue for messages sent by this queue
+            $ref: /schemas/types.yaml#/definitions/int32
+    - if:
+        anyOf:
+          - properties:
+              qcom,is-receiver: true
+          - properties:
+              qcom,is-full-duplex: true
+      then:
+        properties:
+          qcom,rx-message-size:
+            description: Maximum size in bytes of a message which can be received by this queue
+            $ref: /schemas/types.yaml#/definitions/int32
+          qcom,rx-queue-depth:
+            description: Depth of transmit queue for messages received by this queue
+            $ref: /schemas/types.yaml#/definitions/int32
+    - if:
+        anyOf:
+          - properties:
+              qcom,is-receiver: true
+          - properties:
+              qcom,is-sender: true
+      then:
+        properties:
+          reg:
+            description: Hypervisor capability ID of the message queue
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minItems: 1
+            maxItems: 1
+          interrupts:
+            minItems: 1
+            maxItems: 1
+    - if:
+        properties:
+          qcom,is-full-duplex: true
+      then:
+        properties:
+          reg:
+            description:
+              Hypervisor capability IDs of the message queue
+              The first is tx side, the second is rx side
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minItems: 2
+            maxItems: 2
+          interrupts:
+            description: The first is tx interrupt, second is rx interrupt
+            minItems: 2
+            maxItems: 2
+  required:
+    - compatible
+    - reg
+    - interrupts
+
+
+examples:
+  - |
+    display-msgq-pair@abbf0da3c3c965cc {
+      compatible = "qcom,gunyah-message-queue", "qcom,gunyah-capability";
+      interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
+                    <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
+      reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>; /* TX, RX cap ids */
+      qcom,is-full-duplex;
+      qcom,tx-queue-depth = <8>;
+      qcom,tx-message-size = <0xf0>;
+      qcom,rx-queue-depth = <8>;
+      qcom,rx-message-size = <0xf0>;
+    };
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
new file mode 100644
index 000000000000..f637d51c52f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gunyah/qcom,hypervisor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hypervisor node to define virtual devices and other services provided by a Gunyah hypervisor
+       to this virtual machine.
+
+maintainers:
+   - Murali Nalajala <quic_mnalajal@quicinc.com>
+   - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |+
+  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
+  describes the basic configuration of the hypervisor. Virtual machines use this information for
+  initial discovery that they are running as a Gunyah guest VM.
+  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: qcom,gunyah-hypervisor-1.0
+          - const: qcom,gunyah-hypervisor
+
+  "#address-cells":
+    description: Number of cells needed to represent 64-bit capability IDs.
+    const: 2
+  "#size-cells":
+    description: must be 0, because capability IDs are not memory address
+                  ranges and do not have a size.
+    const: 0
+
+  qcom,gunyah-vm:
+    type: object
+    description:
+      The VM Identification is a virtual node that conveys to the VM information
+      about this virtual machine in the context of the hypervisor-based system
+    properties:
+      compatible:
+        oneOf:
+          - items:
+            - const: qcom,gunyah-vm-id-1.0
+            - const: qcom,gunyah-vm-id
+      qcom,vendor:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Vendor of the Virtual Machine, e.g. Qualcomm
+      qcom,vmid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: contains the VMID of this VM as a 32-bit value
+      qcom,owner-vmid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Contains the hypervisor VMID of the VM's owner. The owner
+                     is the VM that allocated and created the VM. VMs directly
+                     managed by the resource manager, such as the primary VM do
+                     not have an owner.
+    required:
+      - compatible
+      - qcom,vmid
+      - qcom,owner-vmid
+
+patternProperties:
+  "^qcom,resource-manager-rpc(@.*)?":
+    type: object
+    description:
+      Resource Manager node which is required to communicate to Resource
+      Manager VM using Gunyah Message Queues.
+    allOf: "message-queue.yml#"
+
+    properties:
+      compatible:
+        oneOf:
+          items:
+            - const: qcom,resource-manager-1-0
+            - const: qcom,resource-manager
+      qcom,console-dev:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: if set, the resource-manger will accept console logs from the VM
+      qcom,free-irq-start:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Set on ARM systems which use a GIC. First VIRQ number which is free
+                     for virtual interrupt use.
+    required:
+      - qcom,is-full-duplex
+
+
+required:
+- compatible
+- "#address-cells"
+- "#size-cells"
+
+examples:
+  - |
+    hypervisor {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "qcom,gunyah-hypervisor-1.0", "qcom,gunyah-hypervisor", "simple-bus";
+        name = "hypervisor";
+
+        qcom,gunyah-vm {
+            compatible = "qcom,gunyah-vm-id-1.0", "qcom,gunyah-vm-id";
+            qcom,vendor = "Qualcomm Technologies, Inc.";
+            qcom,vmid = <45>;
+            qcom,owner-vmid = <3>;
+        };
+
+        qcom,resource-manager-rpc@0000000000000001 {
+            compatible = "qcom,resource-manager-1-0", "qcom,resource-manager",
+                          "qcom,gunyah-message-queue", "qcom,gunyah-capability";
+            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
+                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
+            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
+                  /* TX, RX cap ids */
+            qcom,is-full-duplex;
+            qcom,free-irq-start = <0>;
+            qcom,tx-queue-depth = <8>;
+            qcom,tx-message-size = <0xf0>;
+            qcom,rx-queue-depth = <8>;
+            qcom,rx-message-size = <0xf0>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index bed175adc4c3..6a918f653eac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8400,6 +8400,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
 M:	Murali Nalajala <quic_mnalajal@quicinc.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/gunyah/
 F:	Documentation/virt/gunyah/
 
 H8/300 ARCHITECTURE
-- 
2.25.1

