Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3812D589600
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiHDCQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbiHDCQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:16:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABEC5FAD0;
        Wed,  3 Aug 2022 19:16:04 -0700 (PDT)
X-UUID: 6d676c1b10d84298a18c9582ff8c8f1a-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5fCIf5wtp6gFspyJMY/y1A+uU/gEPAqsxQlZLLO5Fgg=;
        b=LGdS4lTx/Pfyu67ibs7C65Zc+OS4IEbhpsMxRHhfn4a0YqgQ/RcHcekYdWuLpRXx2SB+0jfvErtzImRbpUw9AeGfpoLV8kItwnItsdu4vxYd0JyuFXTHk71Ld0MrQrxQi8jVPcAcX4yPtfezmAPjPSvuJsO74kSZtIBpZkpg9zg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c5816fe6-16f4-4479-9537-e62e5b350a57,OB:10,L
        OB:40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:c5816fe6-16f4-4479-9537-e62e5b350a57,OB:10,LOB
        :40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:3fc03bd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:6da8c764c868,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6d676c1b10d84298a18c9582ff8c8f1a-20220804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 174495039; Thu, 04 Aug 2022 10:15:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:15:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:55 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 03/20] dt-bindings: power: mediatek: Refine multiple level power domain nodes
Date:   Thu, 4 Aug 2022 10:15:36 +0800
Message-ID: <20220804021553.14867-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract duplicated properties and support more levels of power
domain nodes.

This change fix following error when do dtbs_check,
    arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller:
 power-domain@15:power-domain@16:power-domain@18: 'power-domain@19',
 'power-domain@20', 'power-domain@21' do not match any of the regexes:
 'pinctrl-[0-9]+'
	 From schema:
 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml      | 131 +++---------------
 1 file changed, 17 insertions(+), 114 deletions(-)

diff --git
 a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
 b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index b448101fac43e..321802c95308f 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -42,6 +42,23 @@ properties:
 
 patternProperties:
   "^power-domain@[0-9a-f]+$":
+    $ref: "#/$defs/power-domain-node"
+    patternProperties:
+      "^power-domain@[0-9a-f]+$":
+        $ref: "#/$defs/power-domain-node"
+        patternProperties:
+          "^power-domain@[0-9a-f]+$":
+            $ref: "#/$defs/power-domain-node"
+            patternProperties:
+              "^power-domain@[0-9a-f]+$":
+                $ref: "#/$defs/power-domain-node"
+                unevaluatedProperties: false
+            unevaluatedProperties: false
+        unevaluatedProperties: false
+    unevaluatedProperties: false
+
+$defs:
+  power-domain-node:
     type: object
     description: |
       Represents the power domains within the power controller node as
 documented
@@ -100,123 +117,9 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register
 range.
 
-    patternProperties:
-      "^power-domain@[0-9a-f]+$":
-        type: object
-        description: |
-          Represents a power domain child within a power domain parent
 node.
-
-        properties:
-
-          '#power-domain-cells':
-            description:
-              Must be 0 for nodes representing a single PM domain and 1 for
 nodes
-              providing multiple PM domains.
-
-          '#address-cells':
-            const: 1
-
-          '#size-cells':
-            const: 0
-
-          reg:
-            maxItems: 1
-
-          clocks:
-            description: |
-              A number of phandles to clocks that need to be enabled during
 domain
-              power-up sequencing.
-
-          clock-names:
-            description: |
-              List of names of clocks, in order to match the power-up
 sequencing
-              for each power domain we need to group the clocks by name.
 BASIC
-              clocks need to be enabled before enabling the corresponding
 power
-              domain, and should not have a '-' in their name (i.e mm, mfg,
 venc).
-              SUSBYS clocks need to be enabled before releasing the bus
 protection,
-              and should contain a '-' in their name (i.e mm-0, isp-0,
 cam-0).
-
-              In order to follow properly the power-up sequencing, the
 clocks must
-              be specified by order, adding first the BASIC clocks followed
 by the
-              SUSBSYS clocks.
-
-          domain-supply:
-            description: domain regulator supply.
-
-          mediatek,infracfg:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the INFRACFG
 register range.
-
-          mediatek,smi:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the SMI register
 range.
-
-        patternProperties:
-          "^power-domain@[0-9a-f]+$":
-            type: object
-            description: |
-              Represents a power domain child within a power domain parent
 node.
-
-            properties:
-
-              '#power-domain-cells':
-                description:
-                  Must be 0 for nodes representing a single PM domain and 1
 for nodes
-                  providing multiple PM domains.
-
-              '#address-cells':
-                const: 1
-
-              '#size-cells':
-                const: 0
-
-              reg:
-                maxItems: 1
-
-              clocks:
-                description: |
-                  A number of phandles to clocks that need to be enabled
 during domain
-                  power-up sequencing.
-
-              clock-names:
-                description: |
-                  List of names of clocks, in order to match the power-up
 sequencing
-                  for each power domain we need to group the clocks by
 name. BASIC
-                  clocks need to be enabled before enabling the
 corresponding power
-                  domain, and should not have a '-' in their name (i.e mm,
 mfg, venc).
-                  SUSBYS clocks need to be enabled before releasing the bus
 protection,
-                  and should contain a '-' in their name (i.e mm-0, isp-0,
 cam-0).
-
-                  In order to follow properly the power-up sequencing, the
 clocks must
-                  be specified by order, adding first the BASIC clocks
 followed by the
-                  SUSBSYS clocks.
-
-              domain-supply:
-                description: domain regulator supply.
-
-              mediatek,infracfg:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the INFRACFG
 register range.
-
-              mediatek,smi:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the SMI
 register range.
-
-            required:
-              - reg
-
-            additionalProperties: false
-
-        required:
-          - reg
-
-        additionalProperties: false
-
     required:
       - reg
 
-    additionalProperties: false
-
 required:
   - compatible
 
-- 
2.18.0

