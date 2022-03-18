Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6294DDC11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiCROtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiCROry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:47:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682932E8425;
        Fri, 18 Mar 2022 07:46:15 -0700 (PDT)
X-UUID: d7833e34f1374964954f557a41c3c59d-20220318
X-UUID: d7833e34f1374964954f557a41c3c59d-20220318
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1640452583; Fri, 18 Mar 2022 22:45:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 22:45:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 22:45:55 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 18/22] arm64: dts: mt8192: Add display nodes
Date:   Fri, 18 Mar 2022 22:45:30 +0800
Message-ID: <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
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

Add display nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 111 +++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index a77d405dd508..59183fb6c80b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1205,6 +1205,13 @@
 			#clock-cells = <1>;
 		};
 
+		mutex: mutex@14001000 {
+			compatible = "mediatek,mt8192-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+		};
+
 		smi_common: smi@14002000 {
 			compatible = "mediatek,mt8192-smi-common";
 			reg = <0 0x14002000 0 0x1000>;
@@ -1236,6 +1243,110 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 		};
 
+		ovl0: ovl@14005000 {
+			compatible = "mediatek,mt8192-disp-ovl";
+			reg = <0 0x14005000 0 0x1000>;
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0>;
+			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
+				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+		};
+
+		ovl_2l0: ovl@14006000 {
+			compatible = "mediatek,mt8192-disp-ovl-2l";
+			reg = <0 0x14006000 0 0x1000>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
+			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
+				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
+		};
+
+		rdma0: rdma@14007000 {
+			compatible = "mediatek,mt8192-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
+			mediatek,larb = <&larb0>;
+			mediatek,rdma-fifo-size = <5120>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+		};
+
+		color0: color@14009000 {
+			compatible = "mediatek,mt8192-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+		};
+
+		ccorr0: ccorr@1400a000 {
+			compatible = "mediatek,mt8192-disp-ccorr";
+			reg = <0 0x1400a000 0 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+		};
+
+		aal0: aal@1400b000 {
+			compatible = "mediatek,mt8192-disp-aal",
+				     "mediatek,mt8193-disp-aal";
+			reg = <0 0x1400b000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_AAL0>;
+		};
+
+		gamma0: gamma@1400c000 {
+			compatible = "mediatek,mt8192-disp-gamma",
+				     "mediatek,mt8183-disp-gamma";
+			reg = <0 0x1400c000 0 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+		};
+
+		postmask0: postmask@1400d000 {
+			compatible = "mediatek,mt8192-disp-postmask";
+			reg = <0 0x1400d000 0 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
+			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
+		};
+
+		dither0: dither@1400e000 {
+			compatible = "mediatek,mt8192-disp-dither",
+				     "mediatek,mt8183-disp-dither";
+			reg = <0 0x1400e000 0 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+		};
+
+		ovl_2l2: ovl@14014000 {
+			compatible = "mediatek,mt8192-disp-ovl-2l";
+			reg = <0 0x14014000 0 0x1000>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
+			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
+				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
+		};
+
+		rdma4: rdma@14015000 {
+			compatible = "mediatek,mt8192-disp-rdma";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
+			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
+			mediatek,rdma-fifo-size = <2048>;
+		};
+
 		dpi0: dpi@14016000 {
 			compatible = "mediatek,mt8192-dpi";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.18.0

