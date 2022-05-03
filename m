Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC6518E69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbiECUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiECUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:13:46 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A508403C9;
        Tue,  3 May 2022 13:10:12 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 90D5EBC0;
        Tue,  3 May 2022 23:10:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 90D5EBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608645;
        bh=zyEGv+36zyeeJ4S0Wls9R252Y4Cs1w7GDhpbUZted1Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=g6jrVKhZ7nju7RpINdXasQHUXXpaDxZ3bhf4C1Uq9WLVQn+xFQF2sIELjGYsi1aGB
         GG3O2BU5JrLX7YnVn+G26nL+f68CijLeAb9heTE5aA3/dhhdD2Hi21ixj8t6ZBT8Ua
         /PRCzyrgsdaxTxTub2OyUy5dIrpFGC+fRyhg3+Jg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:11 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 12/23] dt-bindings: ata: ahci: Add platform capability properties
Date:   Tue, 3 May 2022 23:09:27 +0300
Message-ID: <20220503200938.18027-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case if the platform doesn't have BIOS or a comprehensive firmware
installed then the HBA capability flags will be left uninitialized. As a
good alternative we can define a set AHCI DT-node properties to describe
all of HW-init capabilities flags. Luckily there aren't too many of them.
SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
support determine the corresponding feature availability for whole HBA by
means of the "hba-sss" and "hba-smps" properties.  Each port can have the
"hba-{hpcp,mpsp,cpd,esp,fbscp}" defined indicatating that the port
supports the next functionality: HPCP - HotPlug capable port, MPSP -
Mechanical Presence Switch attached to a port, CPD - Cold Plug detection,
ESP - External SATA Port (eSATA), FBSCP - FIS-based switching capable
port.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Alternatively we could define them as a bitfield, but having a set of
boolean properties seemed a better idea since in that case we can
implement a simple inter-dependency rules for them, which can't be done
should we take the bitfields path.
---
 .../devicetree/bindings/ata/ahci-common.yaml  | 66 +++++++++++++++++++
 .../bindings/ata/ahci-platform.yaml           | 11 ++++
 2 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index 70f915748270..371f5bd90639 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -75,6 +75,19 @@ properties:
   phy-names:
     const: sata-phy
 
+  hba-sss:
+    type: boolean
+    description:
+      Staggered Spin-up Support. Indicates whether the HBA supports the
+      staggered spin-up on its ports, for use in balancing power spikes.
+
+  hba-smps:
+    type: boolean
+    description:
+      Mechanical Presence Switch Support. Indicates whether the HBA supports
+      mechanical presence switches on its ports for use in hot plug
+      operations.
+
   ports-implemented:
     $ref: '/schemas/types.yaml#/definitions/uint32'
     description:
@@ -97,6 +110,40 @@ patternProperties:
         minimum: 0
         maximum: 31
 
+      hba-hpcp:
+        type: boolean
+        description:
+          Hot Plug Capable Port. Indicates that this port’s signal and power
+          connectors are externally accessible via a joint signal and power
+          connector for blindmate device hot plug. It is mutually exclusive
+          with the ESP feature.
+
+      hba-mpsp:
+        type: boolean
+        description:
+          Mechanical Presence Switch Attached to Port. Indicates whether
+          the platform an mechanical presence switch attached to this
+          port.
+
+      hba-cpd:
+        type: boolean
+        description:
+          Cold Presence Detection. Indicates whether the platform supports
+          cold presence detection on this port.
+
+      hba-esp:
+        type: boolean
+        description:
+          External SATA Port. Indicates that this port’s signal connector
+          is externally accessible on a signal only connector (e.g. eSATA
+          connector).
+
+      hba-fbscp:
+        type: boolean
+        description:
+          FIS-based Switching Capable Port. Indicates whether this port
+          supports Port Multiplier FIS-based switching.
+
       phys:
         description: Individual AHCI SATA port PHY
         maxItems: 1
@@ -111,6 +158,25 @@ patternProperties:
     required:
       - reg
 
+    # eSATA can't be enabled together with the HotPlug capability
+    oneOf:
+      - required:
+          - hba-hpcp
+      - required:
+          - hba-esp
+      - not:
+          anyOf:
+            - required:
+                - hba-hpcp
+            - required:
+                - hba-esp
+
+    # HotPlug capability must be enabled together with Cold Plug
+    # Detection and Mechanical Presence Switching.
+    dependencies:
+      hba-cpd: ["hba-hpcp"]
+      hba-mpsp: ["hba-hpcp"]
+
     additionalProperties: true
 
 required:
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 76075d3c8987..6cad7e86f3bb 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -117,14 +117,25 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
+        hba-smps;
+
         sata0: sata-port@0 {
             reg = <0>;
+
+            hba-fbscp;
+            hba-esp;
+
             phys = <&sata_phy 0>;
             target-supply = <&reg_sata0>;
         };
 
         sata1: sata-port@1 {
             reg = <1>;
+
+            hba-fbscp;
+            hba-hpcp;
+            hba-mpsp;
+
             phys = <&sata_phy 1>;
             target-supply = <&reg_sata1>;
         };
-- 
2.35.1

