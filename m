Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B01517E54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiECHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiECHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:18:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95437031;
        Tue,  3 May 2022 00:15:06 -0700 (PDT)
X-UUID: 54b803bd331945b1a7b0bf9d176817c9-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f3ad91a8-27f2-4aa6-95a8-99996b61ebc0,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
        m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:f3ad91a8-27f2-4aa6-95a8-99996b61ebc0,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
        D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:29a2822f-6199-437e-8ab4-9920b4bc5b76,C
        OID:641a58b95193,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 54b803bd331945b1a7b0bf9d176817c9-20220503
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1110697514; Tue, 03 May 2022 15:15:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 3 May 2022 15:15:00 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:14:58 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v7 02/36] dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
Date:   Tue, 3 May 2022 15:13:53 +0800
Message-ID: <20220503071427.2285-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
mainly are PCIe and USB. Different with MM IOMMU, all these masters
connect with IOMMU directly, there is no mediatek,larbs property for
infra IOMMU.

Another thing is about PCIe ports. currently the function
"of_iommu_configure_dev_id" only support the id number is 1, But our
PCIe have two ports, one is for reading and the other is for writing.
see more about the PCIe patch in this patchset. Thus, I only list
the reading id here and add the other id in our driver.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iommu/mediatek,iommu.yaml         | 13 ++++++++++++-
 .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2223408e91a9..eed59ec00e78 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -79,6 +79,7 @@ properties:
           - mediatek,mt8192-m4u  # generation two
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
+          - mediatek,mt8195-iommu-infra      # generation two
 
       - description: mt7623 generation one
         items:
@@ -131,7 +132,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - mediatek,larbs
   - '#iommu-cells'
 
 allOf:
@@ -163,6 +163,17 @@ allOf:
       required:
         - power-domains
 
+  - if: # The IOMMUs don't have larbs.
+      not:
+        properties:
+          compatible:
+            contains:
+              const: mediatek,mt8195-iommu-infra
+
+    then:
+      required:
+        - mediatek,larbs
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/memory/mt8195-memory-port.h b/include/dt-bindings/memory/mt8195-memory-port.h
index c10e8b61f1e8..70ba9f498eeb 100644
--- a/include/dt-bindings/memory/mt8195-memory-port.h
+++ b/include/dt-bindings/memory/mt8195-memory-port.h
@@ -387,4 +387,22 @@
 #define M4U_PORT_L28_CAM_DRZS4NO_R1		MTK_M4U_ID(28, 5)
 #define M4U_PORT_L28_CAM_TNCSO_R1		MTK_M4U_ID(28, 6)
 
+/* Infra iommu ports */
+/* PCIe1: read: BIT16; write BIT17. */
+#define IOMMU_PORT_INFRA_PCIE1			MTK_IFAIOMMU_PERI_ID(16)
+/* PCIe0: read: BIT18; write BIT19. */
+#define IOMMU_PORT_INFRA_PCIE0			MTK_IFAIOMMU_PERI_ID(18)
+#define IOMMU_PORT_INFRA_SSUSB_P3_R		MTK_IFAIOMMU_PERI_ID(20)
+#define IOMMU_PORT_INFRA_SSUSB_P3_W		MTK_IFAIOMMU_PERI_ID(21)
+#define IOMMU_PORT_INFRA_SSUSB_P2_R		MTK_IFAIOMMU_PERI_ID(22)
+#define IOMMU_PORT_INFRA_SSUSB_P2_W		MTK_IFAIOMMU_PERI_ID(23)
+#define IOMMU_PORT_INFRA_SSUSB_P1_1_R		MTK_IFAIOMMU_PERI_ID(24)
+#define IOMMU_PORT_INFRA_SSUSB_P1_1_W		MTK_IFAIOMMU_PERI_ID(25)
+#define IOMMU_PORT_INFRA_SSUSB_P1_0_R		MTK_IFAIOMMU_PERI_ID(26)
+#define IOMMU_PORT_INFRA_SSUSB_P1_0_W		MTK_IFAIOMMU_PERI_ID(27)
+#define IOMMU_PORT_INFRA_SSUSB2_R		MTK_IFAIOMMU_PERI_ID(28)
+#define IOMMU_PORT_INFRA_SSUSB2_W		MTK_IFAIOMMU_PERI_ID(29)
+#define IOMMU_PORT_INFRA_SSUSB_R		MTK_IFAIOMMU_PERI_ID(30)
+#define IOMMU_PORT_INFRA_SSUSB_W		MTK_IFAIOMMU_PERI_ID(31)
+
 #endif
diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
index 7d64103209af..2f68a0511a25 100644
--- a/include/dt-bindings/memory/mtk-memory-port.h
+++ b/include/dt-bindings/memory/mtk-memory-port.h
@@ -12,4 +12,6 @@
 #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
+#define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
+
 #endif
-- 
2.18.0

