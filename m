Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7A4E9B61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiC1PqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiC1Ppy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:54 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 056224A3E1;
        Mon, 28 Mar 2022 08:44:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 384E51E28DE;
        Thu, 24 Mar 2022 03:16:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 384E51E28DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648081005;
        bh=KrUo+i/9CiTNQNY1Lv9K7N6HJQQfuan8/c6RBDZemY0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JjA8l0IF0wENkQ35sS+hjd0o1EeJ75KbTFWy9fieqH2F/B3VSZY3cZeDt66QOozNi
         XWk7EyGnV/9VUaWAWrlz609mh+tPIP0OocNAfKCjQi/r/4SPR3lJVCBieHXMBv9oUU
         G5DTGAdWg+RaLRBapM/C06ayl/5+Nx5AerjanBlc=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:44 +0300
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
Subject: [PATCH 18/21] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schema
Date:   Thu, 24 Mar 2022 03:16:25 +0300
Message-ID: <20220324001628.13028-19-Sergey.Semin@baikalelectronics.ru>
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

Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
with the next specific settings: two SATA ports, cascaded CSR access based
on two clock domains (APB and AXI), selectable source of the reference
clock (though stable work is currently available from the external source
only), two reset lanes for the application and SATA ports domains. Other
than that the device is fully compatible with the generic DWC AHCI SATA
bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../bindings/ata/baikal,bt1-ahci.yaml         | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
new file mode 100644
index 000000000000..960d88d97926
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 SoC AHCI SATA controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
+  DWC AHCI SATA v4.10a IP-core.
+
+allOf:
+  - $ref: snps,dwc-ahci.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: baikal,bt1-ahci
+
+  clocks:
+    items:
+      - description: Peripheral APB bus clock source
+      - description: Application AXI BIU clock
+      - description: Internal SATA Ports reference clock
+      - description: External SATA Ports reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+      - const: ref_int
+      - const: ref_ext
+
+  resets:
+    items:
+      - description: Application AXI BIU domain reset
+      - description: SATA Ports clock domain reset
+
+  reset-names:
+    items:
+      - const: arst
+      - const: ref
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle reference to the CCU system controller. It is required to
+      switch between internal and external SATA reference clock sources.
+
+  ports-implemented:
+    maximum: 0x3
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      snps,tx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Due to having AXI3 bus interface utilized the maximum Tx DMA
+          transaction size can't exceed 16 beats (AxLEN[3:0]).
+        minimum: 1
+        maximum: 16
+
+      snps,rx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Due to having AXI3 bus interface utilized the maximum Rx DMA
+          transaction size can't exceed 16 beats (AxLEN[3:0]).
+        minimum: 1
+        maximum: 16
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/bt1-ccu.h>
+    #include <dt-bindings/reset/bt1-ccu.h>
+
+    sata@1f050000 {
+      compatible = "baikal,bt1-ahci", "snps,dwc-ahci";
+      reg = <0x1f050000 0x2000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      interrupts = <GIC_SHARED 64 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&ccu_sys CCU_SYS_APB_CLK>, <&ccu_axi CCU_AXI_SATA_CLK>,
+               <&ccu_sys CCU_SYS_SATA_REF_CLK>, <&clk_sata>;
+      clock-names = "pclk", "aclk", "ref_int", "ref_ext";
+
+      resets = <&ccu_axi CCU_AXI_SATA_RST>, <&ccu_sys CCU_SYS_SATA_REF_RST>;
+      reset-names = "arst", "ref";
+
+      syscon = <&syscon>;
+
+      ports-implemented = <0x3>;
+
+      sata-port@0 {
+        reg = <0>;
+
+        snps,tx-ts-max = <4>;
+        snps,rx-ts-max = <4>;
+      };
+
+      sata-port@1 {
+        reg = <1>;
+
+        snps,tx-ts-max = <4>;
+        snps,rx-ts-max = <4>;
+      };
+    };
+...
-- 
2.35.1

