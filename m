Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5CB545E81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347472AbiFJIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbiFJISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:13 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF75A23428B;
        Fri, 10 Jun 2022 01:18:11 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 4789716A4;
        Fri, 10 Jun 2022 11:18:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 4789716A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849138;
        bh=lwyWyOK1nXgLe3QnPATCiNk6Mfk5wQ5Jb1rS0FxolVA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Il7nEgMdm5C8vlcGQUDUpMRj10ccx7oOKEmRE5zwxOFt9D4pHV8IUDxQ15zNgb0Ar
         ZqOqlt65VoSQGX221r2L4jvGauxsv0NSEI1rbqMzb0k7aCea+Dj80CLThyopN/aYJg
         knB0Pk5cKazWxB6Zb6uATblGKPmoDl/hpKdTlkKo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 03/23] dt-bindings: ata: ahci-platform: Clarify common AHCI props constraints
Date:   Fri, 10 Jun 2022 11:17:41 +0300
Message-ID: <20220610081801.11854-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed in accordance with what is implemented in the AHCI platform driver
and the way the AHCI DT nodes are defined in the DT files we can add the
next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
by design, AHCI controller can have up to 32 IRQ lines.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v2:
- This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.

Changelog v4:
- Fix spelling: 'imeplemtned' and 'paltform' in the patch log. (@Hannes)
- Add the interrupts property constraints. (@Rob)
- Add forgotten '---' patchlog-changelog separator. (@Sergei)
---
 .../devicetree/bindings/ata/ahci-common.yaml    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index e89bda3b62cc..12a97b56226f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -31,12 +31,16 @@ properties:
 
   reg-names:
     description: CSR space IDs
+    contains:
+      const: ahci
 
   interrupts:
     description:
       Generic AHCI state change interrupt. Can be implemented either as a
       single line attached to the controller or as a set of the signals
       indicating the particular port events.
+    minItems: 1
+    maxItems: 32
 
   ahci-supply:
     description: Power regulator for AHCI controller
@@ -52,14 +56,13 @@ properties:
     maxItems: 1
 
   phy-names:
-    maxItems: 1
+    const: sata-phy
 
   ports-implemented:
     $ref: '/schemas/types.yaml#/definitions/uint32'
     description:
       Mask that indicates which ports the HBA supports. Useful if PI is not
       programmed by the BIOS, which is true for some embedded SoC's.
-    maximum: 0x1f
 
 patternProperties:
   "^sata-port@[0-9a-f]+$":
@@ -80,8 +83,12 @@ $defs:
 
     properties:
       reg:
-        description: AHCI SATA port identifier
-        maxItems: 1
+        description:
+          AHCI SATA port identifier. By design AHCI controller can't have
+          more than 32 ports due to the CAP.NP fields and PI register size
+          constraints.
+        minimum: 0
+        maximum: 31
 
       phys:
         description: Individual AHCI SATA port PHY
@@ -89,7 +96,7 @@ $defs:
 
       phy-names:
         description: AHCI SATA port PHY ID
-        maxItems: 1
+        const: sata-phy
 
       target-supply:
         description: Power regulator for SATA port target device
-- 
2.35.1

