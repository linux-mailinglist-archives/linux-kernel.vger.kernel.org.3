Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1174E9B71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiC1PqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiC1Ppx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:53 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA93F4A3DB;
        Mon, 28 Mar 2022 08:44:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AB3D11E28D5;
        Thu, 24 Mar 2022 03:16:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru AB3D11E28D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080998;
        bh=eeErETj9Vnf2vjh0M8zdlhJKpAR+2sPG/Bj/+NDbLw0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mB3Gpj6H5M4zbvSeQqwTUsLvyafhUBvGkFrsV2AixagL4Ac9RmajNG4XqqS/o1F1P
         k9ZhlNOooHVLHqSB0hVDy33L9JlBH9YjqIAtzC4AFPdeYpKuO578TYxDFnRWM8qXgH
         RG64HcVrYzekG+hiMeAlmgDE1nCjBnZF9d1fWleo=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 10/21] dt-bindings: ata: ahci: Add platform capability properties
Date:   Thu, 24 Mar 2022 03:16:17 +0300
Message-ID: <20220324001628.13028-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
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
 .../devicetree/bindings/ata/generic-ahci.yaml |  9 +++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index 054819930538..1901c55a5468 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -67,6 +67,19 @@ properties:
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
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -88,6 +101,40 @@ patternProperties:
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
@@ -101,6 +148,25 @@ patternProperties:
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
 required:
   - reg
   - interrupts
diff --git a/Documentation/devicetree/bindings/ata/generic-ahci.yaml b/Documentation/devicetree/bindings/ata/generic-ahci.yaml
index 957f45c4f488..6c147350b5f9 100644
--- a/Documentation/devicetree/bindings/ata/generic-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/generic-ahci.yaml
@@ -74,14 +74,23 @@ examples:
 
       interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
 
+      hba-smps;
+
       sata-port@0 {
         reg = <0>;
+
+        hba-fbscp;
+        hba-esp;
         phys = <&sata_phy0>;
         phy-names = "sata-phy";
       };
 
       sata-port@1 {
         reg = <1>;
+
+        hba-fbscp;
+        hba-hpcp;
+        hba-mpsp;
         phys = <&sata_phy1>;
         phy-names = "sata-phy";
       };
-- 
2.35.1

