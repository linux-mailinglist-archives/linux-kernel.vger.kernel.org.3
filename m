Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4C4E9B62
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiC1Pqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiC1PqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:10 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0AF64B1FB;
        Mon, 28 Mar 2022 08:44:19 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5C42F1E28DB;
        Thu, 24 Mar 2022 03:16:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5C42F1E28DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648081003;
        bh=1/peTMhACn/4I9OfiU31IzCtzYGZV9wmtQ/qd/T8cAs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=k5rFx7t9E87k4MGD2euV4HeB0/QOjmHysVmphhbGXTAp9Ccmt1H2zwYxr8MySlaFn
         RI5eLOLPWvu6DrOxK+jJI4w0DKbNNFiOCVM4PiM++K9ACQzKuSfBsIOovjZLzLkuHE
         EUYpBcfscweESdytSNtOAL3LO+lwcsZvNDtx1KgM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 16/21] dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
Date:   Thu, 24 Mar 2022 03:16:23 +0300
Message-ID: <20220324001628.13028-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
SATA controller except a few peculiarities and the platform environment
requirements. In particular it can have one or two reference clocks to
feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
control for the application clock domain. In addition to that the DMA
interface of each port can be tuned up to work with the predefined maximum
data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
more than 8 ports. All of that is reflected in the new DWC AHCI SATA
device DT binding.

Note the DWC AHCI SATA controller DT-schema has been created in a way so
to be reused for the vendor-specific DT-schemas. One of which we are about
to introduce.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../bindings/ata/snps,dwc-ahci.yaml           | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
new file mode 100644
index 000000000000..b443154b63aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC AHCI SATA controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  This document defines device tree bindings for the Synopsys DWC
+  implementation of the AHCI SATA controller.
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: Synopsys AHCI SATA-compatible devices
+        contains:
+          const: snps,dwc-ahci
+      - description: SPEAr1340 AHCI SATA device
+        const: snps,spear-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
+      and embedded PHYs reference clock together with vendor-specific set
+      of clocks.
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    contains:
+      anyOf:
+        - description: Application AXI/AHB BIU clock source
+          enum:
+            - aclk
+            - sata
+        - description: SATA Ports reference clock
+          enum:
+            - ref
+            - sata_ref
+
+  resets:
+    description:
+      At least basic core and application clock domains reset is normally
+      supported by the DWC AHCI SATA controller. Some platform specific
+      clocks can be also specified though.
+
+  reset-names:
+    contains:
+      description: Core and application clock domains reset control
+      const: arst
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+      snps,tx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Maximal size of Tx DMA transactions in FIFO words
+        minimum: 1
+        maximum: 1024
+
+      snps,rx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Maximal size of Rx DMA transactions in FIFO words
+        minimum: 1
+        maximum: 1024
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@122f0000 {
+      compatible = "snps,dwc-ahci";
+      reg = <0x122F0000 0x1ff>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&clock1>, <&clock2>;
+      clock-names = "aclk", "ref";
+
+      phys = <&sata_phy>;
+      phy-names = "sata-phy";
+
+      ports-implemented = <0x1>;
+
+      sata-port@0 {
+        reg = <0>;
+
+        hba-fbscp;
+        snps,tx-ts-max = <512>;
+        snps,tx-rs-max = <512>;
+      };
+    };
+...
-- 
2.35.1

