Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0C572D20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiGMF3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiGMF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:29:30 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 438CA2C669;
        Tue, 12 Jul 2022 22:29:22 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 4A2DABC7;
        Wed, 13 Jul 2022 08:31:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 4A2DABC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690275;
        bh=lftDM8bVxbb6i7gbnpPybwAsln7Ng23i+K1fZlPSI1c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=I+RgMRmMiS97H6YUChrAdxi4bvT+cimRkKYmsrAeCDCOy8+7EEm1dqvOPMmm4lwsF
         Wxr/dxZ9hHrW4girB4l8pkFIjdQwtXU/HLTN8WwLUFnDl6eGsp71IFwyCp/6oTJoa4
         V5pZeKIOj5P4V1ZEMxDfnFLPcuKNX0+z68LJFEFM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:19 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/23] dt-bindings: ata: ahci-platform: Move dma-coherent to sata-common.yaml
Date:   Wed, 13 Jul 2022 08:28:54 +0300
Message-ID: <20220713052917.27036-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing doubtfully any SATA device working without embedded DMA engine
let's permit the device nodes being equipped with the dma-coherent
property in case if the platform is capable of cache-coherent DMAs.

As a side-effect we can drop the explicit dma-coherent property definition
from the particular device schemas. Currently it concerns the Broadcom
SATA AHCI controller only.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.

Changelog v4:
- Move the dma-coherent property to the sata-common.yaml schema instead
  of removing it.
- Remove the Hannes' rb tag.
---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml  | 2 --
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 --
 Documentation/devicetree/bindings/ata/sata-common.yaml    | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index c146ab8e14e5..9304e4731965 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -87,8 +87,6 @@ properties:
     description:
       regulator for AHCI controller
 
-  dma-coherent: true
-
   phy-supply:
     description:
       regulator for PHY power
diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index 235a93ac86b0..4ee74df8e58a 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -41,8 +41,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  dma-coherent: true
-
 if:
   properties:
     compatible:
diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 7ac77b1c5850..cb88d3e25e73 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -31,6 +31,8 @@ properties:
   "#size-cells":
     const: 0
 
+  dma-coherent: true
+
 patternProperties:
   "^sata-port@[0-9a-e]$":
     description: |
-- 
2.35.1

