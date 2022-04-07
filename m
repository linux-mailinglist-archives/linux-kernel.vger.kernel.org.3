Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21794F7888
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiDGIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiDGIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:00:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944E1107E5;
        Thu,  7 Apr 2022 00:58:17 -0700 (PDT)
X-UUID: 60ccdfd55e934aa4adae7d3157f64aa0-20220407
X-UUID: 60ccdfd55e934aa4adae7d3157f64aa0-20220407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 447750194; Thu, 07 Apr 2022 15:58:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Apr 2022 15:58:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 15:58:07 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
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
Subject: [PATCH v6 02/34] dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
Date:   Thu, 7 Apr 2022 15:56:54 +0800
Message-ID: <20220407075726.17771-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
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

