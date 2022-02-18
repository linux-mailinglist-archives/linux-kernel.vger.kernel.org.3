Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B764BB54F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiBRJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:18:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiBRJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:13 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4D9FEC;
        Fri, 18 Feb 2022 01:16:56 -0800 (PST)
X-UUID: cc028a83800b49e99bc316c9ab689c23-20220218
X-UUID: cc028a83800b49e99bc316c9ab689c23-20220218
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 21078361; Fri, 18 Feb 2022 17:16:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Feb 2022 17:16:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 17:16:52 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 17/23] arm64: dts: mt8192: Add vcodec lat and core nodes
Date:   Fri, 18 Feb 2022 17:16:27 +0800
Message-ID: <20220218091633.9368-18-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
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
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 936aa788664f..543a80252ce5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1291,6 +1291,64 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
 		};
 
+		vcodec_dec: vcodec_dec@16000000 {
+			compatible = "mediatek,mt8192-vcodec-dec";
+			reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
+			mediatek,scp = <&scp>;
+			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
+		};
+
+		vcodec_lat: vcodec_lat@0x16010000 {
+			compatible = "mediatek,mtk-vcodec-lat";
+			reg = <0 0x16010000 0 0x800>;		/* VDEC_MISC */
+			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
+				<&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
+			clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+				 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+				 <&topckgen CLK_TOP_MAINPLL_D4>;
+			clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat", "vdec-vdec",
+				      "vdec-top";
+			assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
+		};
+
+		vcodec_core: vcodec_core@0x16025000 {
+			compatible = "mediatek,mtk-vcodec-core";
+			reg = <0 0x16025000 0 0x1000>;		/* VDEC_CORE_MISC */
+			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
+				<&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
+			clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+				 <&vdecsys CLK_VDEC_VDEC>,
+				 <&vdecsys CLK_VDEC_LAT>,
+				 <&vdecsys CLK_VDEC_LARB1>,
+				 <&topckgen CLK_TOP_MAINPLL_D4>;
+			clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat", "vdec-vdec",
+				      "vdec-top";
+			assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+		};
+
 		larb5: larb@1600d000 {
 			compatible = "mediatek,mt8192-smi-larb";
 			reg = <0 0x1600d000 0 0x1000>;
-- 
2.18.0

