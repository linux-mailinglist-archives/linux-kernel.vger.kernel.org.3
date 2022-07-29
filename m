Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768B7584BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiG2GcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiG2GcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:32:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F517FE5B;
        Thu, 28 Jul 2022 23:32:18 -0700 (PDT)
X-UUID: c1a08bd514c44a8bb1cd56e12d39f744-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0b6ebd49-0d13-4679-b2cd-51959ac9c731,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:da60b9cf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: c1a08bd514c44a8bb1cd56e12d39f744-20220729
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1139290130; Fri, 29 Jul 2022 14:32:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 14:32:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 29 Jul 2022 14:32:13 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 03/20] dt-bindings: power: mediatek: Refine multiple level power domain nodes
Date:   Fri, 29 Jul 2022 14:31:51 +0800
Message-ID: <20220729063208.16799-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220729063208.16799-1-tinghan.shen@mediatek.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract duplicated properties and support more levels of power
domain nodes.

This change fix following error when do dtbs_check,
    arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../power/mediatek,power-controller.yaml      | 131 +++---------------
 1 file changed, 17 insertions(+), 114 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
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
       Represents the power domains within the power controller node as documented
@@ -100,123 +117,9 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
 
-    patternProperties:
-      "^power-domain@[0-9a-f]+$":
-        type: object
-        description: |
-          Represents a power domain child within a power domain parent node.
-
-        properties:
-
-          '#power-domain-cells':
-            description:
-              Must be 0 for nodes representing a single PM domain and 1 for nodes
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
-              A number of phandles to clocks that need to be enabled during domain
-              power-up sequencing.
-
-          clock-names:
-            description: |
-              List of names of clocks, in order to match the power-up sequencing
-              for each power domain we need to group the clocks by name. BASIC
-              clocks need to be enabled before enabling the corresponding power
-              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
-              SUSBYS clocks need to be enabled before releasing the bus protection,
-              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
-
-              In order to follow properly the power-up sequencing, the clocks must
-              be specified by order, adding first the BASIC clocks followed by the
-              SUSBSYS clocks.
-
-          domain-supply:
-            description: domain regulator supply.
-
-          mediatek,infracfg:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the INFRACFG register range.
-
-          mediatek,smi:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the SMI register range.
-
-        patternProperties:
-          "^power-domain@[0-9a-f]+$":
-            type: object
-            description: |
-              Represents a power domain child within a power domain parent node.
-
-            properties:
-
-              '#power-domain-cells':
-                description:
-                  Must be 0 for nodes representing a single PM domain and 1 for nodes
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
-                  A number of phandles to clocks that need to be enabled during domain
-                  power-up sequencing.
-
-              clock-names:
-                description: |
-                  List of names of clocks, in order to match the power-up sequencing
-                  for each power domain we need to group the clocks by name. BASIC
-                  clocks need to be enabled before enabling the corresponding power
-                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
-                  SUSBYS clocks need to be enabled before releasing the bus protection,
-                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
-
-                  In order to follow properly the power-up sequencing, the clocks must
-                  be specified by order, adding first the BASIC clocks followed by the
-                  SUSBSYS clocks.
-
-              domain-supply:
-                description: domain regulator supply.
-
-              mediatek,infracfg:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the INFRACFG register range.
-
-              mediatek,smi:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the SMI register range.
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

