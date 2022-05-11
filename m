Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5375240BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349142AbiEKXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiEKXSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:30 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2EEA16D4A2;
        Wed, 11 May 2022 16:18:18 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 59D5CBAD;
        Thu, 12 May 2022 02:19:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 59D5CBAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311144;
        bh=Tp7JizJiwv3qj/uwnJATD46+Utw0USu+X23L16/Kc0o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eTPFdokdoTEFCCZ6+DoyVvBITfqgvqhA1IJdJddH+3GZo3t2uNoyDUFh41krkLZMV
         ZQYlN19u++Uia7sEdBMtmLKCi0eFJYUNkEw/Y4t00Pg83rBIecGk5q9oCSwAVzWWNM
         1PSKDBrpANx+qyYiKYKRvYL1al0UMLBVe/hRIORc=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:16 +0300
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
Subject: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common AHCI props constraints
Date:   Thu, 12 May 2022 02:17:50 +0300
Message-ID: <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed in accordance with what is imeplemtned in the AHCI paltform driver
and the way the AHCI DT nodes are defined in the DT files we can add the
next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
by design.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Changelog v2:
- This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
---
 .../devicetree/bindings/ata/ahci-common.yaml      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index 620042ca12e7..a7d1a8353de3 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -31,6 +31,8 @@ properties:
 
   reg-names:
     description: CSR space IDs
+    contains:
+      const: ahci
 
   interrupts:
     description:
@@ -71,14 +73,13 @@ properties:
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
@@ -89,8 +90,12 @@ patternProperties:
 
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
@@ -98,7 +103,7 @@ patternProperties:
 
       phy-names:
         description: AHCI SATA port PHY ID
-        maxItems: 1
+        const: sata-phy
 
       target-supply:
         description: Power regulator for SATA port target device
-- 
2.35.1

