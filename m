Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63ED53C9C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiFCMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbiFCMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:15:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774C39B8A;
        Fri,  3 Jun 2022 05:15:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 253CFP0Y122098;
        Fri, 3 Jun 2022 07:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654258525;
        bh=YoWLvrq7QDqg9g9ZGyYPJAamjcdAAoFZffqn4aPenFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gkFBTTssn8mmrsogpKBNe+ic50U8pELmBV/qLLwNR6CG3kIuZCVRm8u3OF/XZUMhU
         39kZnydU0EeRRWAUJO6Yhqn6AEamaRW/U68XSEF6FrBNKNMTw5dcXFUAH7nYOgy4Q2
         0HboNm2wcis0/jzAGgCy8UU2bc82RBHvRnAt1jxo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 253CFP3r097480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jun 2022 07:15:25 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Jun 2022 07:15:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Jun 2022 07:15:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 253CFNGU128924;
        Fri, 3 Jun 2022 07:15:24 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <robh@kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: remoteproc: Add PRU consumer bindings
Date:   Fri, 3 Jun 2022 17:45:15 +0530
Message-ID: <20220603121520.13730-2-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603121520.13730-1-p-mohan@ti.com>
References: <20220603121520.13730-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add a YAML binding document for PRU consumers. The binding includes
all the common properties that can be used by different PRU consumer
or application nodes and supported by the PRU remoteproc driver.
These are used to configure the PRU hardware for specific user
applications.

The application nodes themselves should define their own bindings.

Co-developed-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
V3->V4:
* Addressed Rob's comments regarding max and min Items.
* removed the dependencies tag as it was redundant.
---
.../bindings/remoteproc/ti,pru-consumer.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
new file mode 100644
index 000000000000..df384b44259b
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common TI PRU Consumer Binding
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  A PRU application/consumer/user node typically uses one or more PRU device
+  nodes to implement a PRU application/functionality. Each application/client
+  node would need a reference to at least a PRU node, and optionally define
+  some properties needed for hardware/firmware configuration. The below
+  properties are a list of common properties supported by the PRU remoteproc
+  infrastructure.
+
+  The application nodes shall define their own bindings like regular platform
+  devices, so below are in addition to each node's bindings.
+
+properties:
+  ti,prus:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandles to the PRU, RTU or Tx_PRU nodes used
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 6
+    description: |
+      firmwares for the PRU cores, the default firmware for the core from
+      the PRU node will be used if not provided. The firmware names should
+      correspond to the PRU cores listed in the 'ti,prus' property
+
+  ti,pruss-gp-mux-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      enum: [0, 1, 2, 3, 4]
+    description: |
+      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
+      This selects the internal muxing scheme for the PRU instance. Values
+      should correspond to the PRU cores listed in the 'ti,prus' property. The
+      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
+      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
+      same slice in the associative array. If the array size is smaller than
+      the size of 'ti,prus' property, the default out-of-reset value (0) for the
+      PRU core is used.
+
+required:
+  - ti,prus
+
+additionalProperties: true
+
+examples:
+  - |
+    /* PRU application node example */
+    pru-app {
+        ti,prus = <&pru0>, <&pru1>;
+        firmware-name = "pruss-app-fw0", "pruss-app-fw1";
+        ti,pruss-gp-mux-sel = <2>, <1>;
+    };
-- 
2.17.1

