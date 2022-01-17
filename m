Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344EC490834
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiAQMGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:06:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239581AbiAQMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:36 -0500
X-UUID: 0feedd9c73d44a5993b52a51963760df-20220117
X-UUID: 0feedd9c73d44a5993b52a51963760df-20220117
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 346831367; Mon, 17 Jan 2022 20:06:33 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 20:06:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Jan
 2022 20:06:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:30 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for mt8195
Date:   Mon, 17 Jan 2022 20:06:08 +0800
Message-ID: <20220117120615.21687-4-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds encoder cores dt-bindings for mt8195

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../media/mediatek,vcodec-encoder-core.yaml   | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
new file mode 100644
index 000000000000..d1e7bfa50bce
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
@@ -0,0 +1,214 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek Video Encoder Accelerator With Multi Core
+
+maintainers:
+  - Irui Wang <irui.wang@mediatek.com>
+
+description: |
+  Mediatek Video Encode is the video encode hardware present in Mediatek
+  SoCs which supports high resolution encoding functionalities. Required
+  parent and child device node.
+
+properties:
+  compatible:
+    const: mediatek,mt8195-vcodec-enc
+
+  mediatek,scp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
+    description: |
+      The node of system control processor (SCP), using
+      the remoteproc & rpmsg framework.
+
+  iommus:
+    minItems: 1
+    maxItems: 32
+    description: |
+      List of the hardware port in respective IOMMU block for current Socs.
+      Refer to bindings/iommu/mediatek,iommu.yaml.
+
+  dma-ranges:
+    maxItems: 1
+    description: |
+      Describes the physical address space of IOMMU maps to memory.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+# Required child node:
+patternProperties:
+  "venc_core0@1a020000":
+    type: object
+
+    properties:
+      compatible:
+        const: mediatek,mtk-venc-core0
+
+      reg:
+        maxItems: 1
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: MT_CG_VENC0
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - assigned-clocks
+      - assigned-clock-parents
+      - power-domains
+
+    additionalProperties: false
+
+  "venc_core1@1b020000":
+    type: object
+
+    properties:
+      compatible:
+        const: mediatek,mtk-venc-core1
+
+      reg:
+        maxItems: 1
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: MT_CG_VENC1
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - assigned-clocks
+      - assigned-clock-parents
+      - power-domains
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,scp
+  - iommus
+  - dma-ranges
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8195-memory-port.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    venc {
+        compatible = "mediatek,mt8195-vcodec-enc";
+        mediatek,scp = <&scp>;
+        iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>;
+        dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        venc_core0@1a020000 {
+            compatible = "mediatek,mtk-venc-core0";
+            reg = <0x1a020000 0x10000>;
+            iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REC>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
+            interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+            clocks = <&vencsys CLK_VENC_VENC>;
+            clock-names = "MT_CG_VENC0";
+            assigned-clocks = <&topckgen CLK_TOP_VENC>;
+            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+            power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+        };
+
+        venc_core1@1b020000 {
+            compatible = "mediatek,mtk-venc-core1";
+            reg = <0x1b020000 0x10000>;
+            iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_REC>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
+                     <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
+            interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
+            clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
+            clock-names = "MT_CG_VENC1";
+            assigned-clocks = <&topckgen CLK_TOP_VENC>;
+            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+            power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+        };
+    };
-- 
2.18.0

