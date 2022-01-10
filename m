Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804DF488F27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiAJEHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:07:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44190 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiAJEHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:07:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20A46xa6123801;
        Sun, 9 Jan 2022 22:06:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641787619;
        bh=Gjl1FKT+aWb+mRhKRlR5Vfbp6EaHNR1QCi0xumwc8fA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C8+2PFO+xHDEEkmThxzfkTzHZ30FN2Je1KFUDNObMAxZ7BHP9IaDp2kL11hI7O7Jk
         HsdimoFghLlVjjdj84GW96ZRn4MUGB4cHmJDbGG+nQxZyZqbvf1NMGBcobJOPe2vxY
         I6cgojxkfmk+e2QtIonAihHgy4bC/Tc+da+iCGjA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20A46xGT055666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Jan 2022 22:06:59 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 9
 Jan 2022 22:06:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 9 Jan 2022 22:06:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20A46wak075255;
        Sun, 9 Jan 2022 22:06:58 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hnagalla@ti.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: k3-m4f: Add bindings for K3 AM64x SoCs
Date:   Sun, 9 Jan 2022 22:06:49 -0600
Message-ID: <20220110040650.18186-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110040650.18186-1-hnagalla@ti.com>
References: <20220110040650.18186-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 AM64x SoC has a Cortex M4F subsystem in the MCU volatge domain.
The remote processor's life cycle management and IPC mechanisms are
similar across the R5F and M4F cores from remote processor driver
point of view. However, there are subtle differences in image loading
and starting the M4F subsystems.

The YAML binding document provides the various node properties to be
configured by the consumers of the M4F subsystem.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
new file mode 100644
index 000000000000..8db9a3f6256e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 M4F processor subsystems
+
+maintainers:
+  - Hari Nagalla <hnagalla@ti.com>
+
+description: |
+  Some K3 family SoCs have  Arm Cortex M4F cores. AM64x is a SoC in K3
+  family with a M4F core. Typically safety oriented applications may use
+  the M4F core in isolation with out an IPC. Where as some Industrial and
+  home automation applications, may use the M4F core as a remote processor
+  with IPC communications.
+
+properties:
+  $nodename:
+    pattern: "^m4fss(@.*)?"
+
+  compatible:
+    enum:
+      - ti,am64-m4fss
+
+  power-domains:
+    description: |
+      Should contain a phandle to a PM domain provider node and an args
+      specifier containing the M4FSS device id value.
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: Address and Size of the IRAM internal memory region
+      - description: Address and Size of the DRAM internal memory region
+
+  reg-names:
+    items:
+      - const: iram
+      - const: dram
+
+  resets:
+    description: |
+      Should contain the phandle to the reset controller node managing the
+      local resets for this device, and a reset specifier.
+    maxItems: 1
+
+  firmware-name:
+    description: |
+      Should contain the name of the default firmware image
+      file located on the firmware search path
+
+  mboxes:
+    description: |
+      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
+      communication with the remote processor. This property should match
+      with the sub-mailbox node used in the firmware image.
+    maxItems: 1
+
+  memory-region:
+    description: |
+      phandle to the reserved memory nodes to be associated with the
+      remoteproc device. There should be at least two reserved memory nodes
+      defined. The reserved memory nodes should be carveout nodes, and
+      should be defined with a "no-map" property as per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+    minItems: 2
+    maxItems: 8
+#    items:
+#      - description: region used for dynamic DMA allocations like vrings and
+#                         vring buffers
+#      - description: region reserved for firmware image sections
+    additionalItems: true
+
+    unevaluatedProperties: false
+
+
+required:
+  - compatible
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
+  - resets
+  - firmware-name
+
+additionalProperties: false
+
+examples:
+  - |
+    cbass_main:  bus@f4000 {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      mcu_m4fss: m4fss@5000000 {
+        compatible = "ti,am64-m4fss";
+        reg = <0x00 0x5000000 0x00 0x30000>,
+              <0x00 0x5040000 0x00 0x10000>;
+        reg-names = "iram", "dram";
+        ti,sci = <&dmsc>;
+        ti,sci-dev-id = <9>;
+        ti,sci-proc-ids = <0x18 0xff>;
+        resets = <&k3_reset 9 1>;
+        firmware-name = "am64-mcu-m4f0_0-fw";
+        mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
+        memory-region = <&mcu_m4fss_dma_memory_region>,
+                        <&mcu_m4fss_memory_region>;
+      };
+    };
+
+...
-- 
2.17.1

