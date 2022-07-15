Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A965760F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiGOLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiGOLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:54:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2E88F0A;
        Fri, 15 Jul 2022 04:54:56 -0700 (PDT)
X-UUID: bf7906bc41b64bf29111a658b8e28b12-20220715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:3b4fe7d1-76d3-44d0-80a7-6bb6936e1b08,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:5d9c6764-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: bf7906bc41b64bf29111a658b8e28b12-20220715
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 933088656; Fri, 15 Jul 2022 19:54:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 15 Jul 2022 19:54:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 15 Jul 2022 19:54:50 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Brown <broonie@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Update bindings for nor flash
Date:   Fri, 15 Jul 2022 19:54:43 +0800
Message-ID: <20220715115443.4154-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

The spi-mtk-nor controller of mt8173, mt8186 and mt8192 have their
DT data. They don't use mt8173 as fallback.

Using the fallback of mt8186 to enables the controllers to support
mt8188.

Not all of spi-mtk-nor controller need interrupt property, so we
don't mark interrupt as required.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml        | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 41e60fe4b09f..970b1119898b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -23,6 +23,10 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - enum:
+          - mediatek,mt8173-nor
+          - mediatek,mt8186-nor
+          - mediatek,mt8192-nor
       - items:
           - enum:
               - mediatek,mt2701-nor
@@ -30,13 +34,13 @@ properties:
               - mediatek,mt7622-nor
               - mediatek,mt7623-nor
               - mediatek,mt7629-nor
-              - mediatek,mt8186-nor
-              - mediatek,mt8192-nor
               - mediatek,mt8195-nor
-          - enum:
-              - mediatek,mt8173-nor
-      - items:
           - const: mediatek,mt8173-nor
+      - items:
+          - enum:
+              - mediatek,mt8188-nor
+          - const: mediatek,mt8186-nor
+
   reg:
     maxItems: 1
 
@@ -64,7 +68,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - clock-names
 
-- 
2.18.0

