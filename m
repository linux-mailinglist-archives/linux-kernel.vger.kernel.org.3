Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25734EC5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiC3Nkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbiC3NkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:40:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB815FD0;
        Wed, 30 Mar 2022 06:38:33 -0700 (PDT)
X-UUID: 706d24e3b87c450687c2a0842ac145b6-20220330
X-UUID: 706d24e3b87c450687c2a0842ac145b6-20220330
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1649239239; Wed, 30 Mar 2022 21:38:29 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 30 Mar 2022 21:38:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Mar
 2022 21:38:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 21:38:27 +0800
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
Subject: [PATCH v5 4/4] arm64: dts: mt8192: Add vcodec lat and core nodes
Date:   Wed, 30 Mar 2022 21:38:16 +0800
Message-ID: <20220330133816.30806-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
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

Add vcodec lat and core nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 3d61238fb102..0b2b52a8f5ed 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1115,6 +1115,66 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
 		};
 
+		vcodec_dec: vcodec-dec@16000000 {
+			compatible = "mediatek,mt8192-vcodec-dec";
+			reg = <0 0x16000000 0 0x1000>;	/* VDEC_SYS */
+			mediatek,scp = <&scp>;
+			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0 0 0 0x16000000 0 0x26000>;
+
+			vcodec_lat: vcodec-lat@10000 {
+				compatible = "mediatek,mtk-vcodec-lat";
+				reg = <0x0 0x10000 0 0x800>;		/* VDEC_MISC */
+				interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+					 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+					 <&topckgen CLK_TOP_MAINPLL_D4>;
+				clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
+			};
+
+			vcodec_core: vcodec-core@25000 {
+				compatible = "mediatek,mtk-vcodec-core";
+				reg = <0 0x25000 0 0x1000>;	/* VDEC_CORE_MISC */
+				interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+					 <&vdecsys CLK_VDEC_VDEC>,
+					 <&vdecsys CLK_VDEC_LAT>,
+					 <&vdecsys CLK_VDEC_LARB1>,
+					 <&topckgen CLK_TOP_MAINPLL_D4>;
+				clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+			};
+		};
+
 		larb5: larb@1600d000 {
 			compatible = "mediatek,mt8192-smi-larb";
 			reg = <0 0x1600d000 0 0x1000>;
-- 
2.18.0

