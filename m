Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681A56519B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiGDKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiGDKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:00:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED1DEE4;
        Mon,  4 Jul 2022 03:00:42 -0700 (PDT)
X-UUID: ee433ed36b6342508a5f68f62fe2413b-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:c87c619b-310d-4cfc-a20e-47d05723410c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:87442a2,CLOUDID:cfd68dd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: ee433ed36b6342508a5f68f62fe2413b-20220704
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 286135175; Mon, 04 Jul 2022 18:00:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 4 Jul 2022 18:00:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 18:00:31 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 14/16] arm64: dts: mt8195: Add iommu and smi nodes
Date:   Mon, 4 Jul 2022 18:00:26 +0800
Message-ID: <20220704100028.19932-15-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220704100028.19932-1-tinghan.shen@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu nodes and smi nodes for mt8195.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 451 +++++++++++++++++++++++
 1 file changed, 451 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 618fb2fa195a..cb2b79dc08d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8195-memory-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
@@ -725,6 +726,19 @@
 			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
 		};
 
+		iommu_infra: infra-iommu@10315000 {
+			compatible = "mediatek,mt8195-iommu-infra";
+			reg = <0 0x10315000 0 0x5000>;
+			interrupts = <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+		};
+
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8195-scp";
 			reg = <0 0x10500000 0 0x100000>,
@@ -1439,6 +1453,64 @@
 			#clock-cells = <1>;
 		};
 
+		smi_sub_common_vpp0_vpp1_2x1: smi@14010000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x14010000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+			       <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+			       <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vpp>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		smi_sub_common_vdec_vpp0_2x1: smi@14011000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x14011000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vpp>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		smi_common_vpp: smi@14012000 {
+			compatible = "mediatek,mt8195-smi-common-vpp";
+			reg = <0 0x14012000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+			       <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+			       <&vppsys0 CLK_VPP0_SMI_RSI>,
+			       <&vppsys0 CLK_VPP0_SMI_RSI>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		larb4: larb@14013000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14013000 0 0x1000>;
+			mediatek,larb-id = <4>;
+			mediatek,smi = <&smi_sub_common_vpp0_vpp1_2x1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+			       <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		iommu_vpp: iommu@14018000 {
+			compatible = "mediatek,mt8195-iommu-vpp";
+			reg = <0 0x14018000 0 0x1000>;
+			mediatek,larbs = <&larb1 &larb3 &larb4 &larb6 &larb8
+					  &larb12 &larb14 &larb16 &larb18
+					  &larb20 &larb22 &larb23 &larb26
+					  &larb27>;
+			interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_IOMMU>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
 		wpesys: clock-controller@14e00000 {
 			compatible = "mediatek,mt8195-wpesys";
 			reg = <0 0x14e00000 0 0x1000>;
@@ -1457,24 +1529,116 @@
 			#clock-cells = <1>;
 		};
 
+		larb7: larb@14e04000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14e04000 0 0x1000>;
+			mediatek,larb-id = <7>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&wpesys CLK_WPE_SMI_LARB7>,
+				 <&wpesys CLK_WPE_SMI_LARB7>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
+		};
+
+		larb8: larb@14e05000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14e05000 0 0x1000>;
+			mediatek,larb-id = <8>;
+			mediatek,smi = <&smi_common_vpp>;
+			clocks = <&wpesys CLK_WPE_SMI_LARB8>,
+			       <&wpesys CLK_WPE_SMI_LARB8>,
+			       <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
+		};
+
 		vppsys1: clock-controller@14f00000 {
 			compatible = "mediatek,mt8195-vppsys1";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb5: larb@14f02000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14f02000 0 0x1000>;
+			mediatek,larb-id = <5>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vppsys1 CLK_VPP1_VPPSYS1_LARB>,
+			       <&vppsys1 CLK_VPP1_VPPSYS1_GALS>,
+			       <&vppsys0 CLK_VPP0_GALS_VPP1_LARB5>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		larb6: larb@14f03000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14f03000 0 0x1000>;
+			mediatek,larb-id = <6>;
+			mediatek,smi = <&smi_sub_common_vpp0_vpp1_2x1>;
+			clocks = <&vppsys1 CLK_VPP1_VPPSYS1_LARB>,
+			       <&vppsys1 CLK_VPP1_VPPSYS1_GALS>,
+			       <&vppsys0 CLK_VPP0_GALS_VPP1_LARB6>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8195-imgsys";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb9: larb@15001000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,larb-id = <9>;
+			mediatek,smi = <&smi_sub_common_img1_3x1>;
+			clocks = <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_IMG>;
+		};
+
+		smi_sub_common_img0_3x1: smi@15002000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x15002000 0 0x1000>;
+			clocks = <&imgsys CLK_IMG_IPE>,
+				 <&imgsys CLK_IMG_IPE>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vpp>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_IMG>;
+		};
+
+		smi_sub_common_img1_3x1: smi@15003000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x15003000 0 0x1000>;
+			clocks = <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_GALS>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vdo>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_IMG>;
+		};
+
 		imgsys1_dip_top: clock-controller@15110000 {
 			compatible = "mediatek,mt8195-imgsys1_dip_top";
 			reg = <0 0x15110000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb10: larb@15120000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15120000 0 0x1000>;
+			mediatek,larb-id = <10>;
+			mediatek,smi = <&smi_sub_common_img1_3x1>;
+			clocks = <&imgsys CLK_IMG_DIP0>,
+			       <&imgsys1_dip_top CLK_IMG1_DIP_TOP_LARB10>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_DIP>;
+		};
+
 		imgsys1_dip_nr: clock-controller@15130000 {
 			compatible = "mediatek,mt8195-imgsys1_dip_nr";
 			reg = <0 0x15130000 0 0x1000>;
@@ -1487,18 +1651,129 @@
 			#clock-cells = <1>;
 		};
 
+		larb11: larb@15230000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15230000 0 0x1000>;
+			mediatek,larb-id = <11>;
+			mediatek,smi = <&smi_sub_common_img1_3x1>;
+			clocks = <&imgsys CLK_IMG_WPE0>,
+			       <&imgsys1_wpe CLK_IMG1_WPE_LARB11>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_DIP>;
+		};
+
 		ipesys: clock-controller@15330000 {
 			compatible = "mediatek,mt8195-ipesys";
 			reg = <0 0x15330000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb12: larb@15340000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15340000 0 0x1000>;
+			mediatek,larb-id = <12>;
+			mediatek,smi = <&smi_sub_common_img0_3x1>;
+			clocks = <&ipesys CLK_IPE_SMI_LARB12>,
+				 <&ipesys CLK_IPE_SMI_LARB12>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_IPE>;
+		};
+
 		camsys: clock-controller@16000000 {
 			compatible = "mediatek,mt8195-camsys";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb13: larb@16001000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16001000 0 0x1000>;
+			mediatek,larb-id = <13>;
+			mediatek,smi = <&smi_sub_common_cam_4x1>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+			       <&camsys CLK_CAM_LARB13>,
+			       <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb14: larb@16002000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16002000 0 0x1000>;
+			mediatek,larb-id = <14>;
+			mediatek,smi = <&smi_sub_common_cam_7x1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys CLK_CAM_LARB14>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		smi_sub_common_cam_4x1: smi@16004000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x16004000 0 0x1000>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys CLK_CAM_LARB13>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vdo>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		smi_sub_common_cam_7x1: smi@16005000 {
+			compatible = "mediatek,mt8195-smi-sub-common";
+			reg = <0 0x16005000 0 0x1000>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys CLK_CAM_CAM2MM1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals0";
+			mediatek,smi = <&smi_common_vpp>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb16: larb@16012000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16012000 0 0x1000>;
+			mediatek,larb-id = <16>;
+			mediatek,smi = <&smi_sub_common_cam_7x1>;
+			clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>,
+				 <&camsys_rawa CLK_CAM_RAWA_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb17: larb@16013000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16013000 0 0x1000>;
+			mediatek,larb-id = <17>;
+			mediatek,smi = <&smi_sub_common_cam_4x1>;
+			clocks = <&camsys_yuva CLK_CAM_YUVA_LARBX>,
+				 <&camsys_yuva CLK_CAM_YUVA_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb27: larb@16014000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16014000 0 0x1000>;
+			mediatek,larb-id = <27>;
+			mediatek,smi = <&smi_sub_common_cam_7x1>;
+			clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>,
+				 <&camsys_rawb CLK_CAM_RAWB_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWB>;
+		};
+
+		larb28: larb@16015000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16015000 0 0x1000>;
+			mediatek,larb-id = <28>;
+			mediatek,smi = <&smi_sub_common_cam_4x1>;
+			clocks = <&camsys_yuvb CLK_CAM_YUVB_LARBX>,
+				 <&camsys_yuvb CLK_CAM_YUVB_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWB>;
+		};
+
 		camsys_rawa: clock-controller@1604f000 {
 			compatible = "mediatek,mt8195-camsys_rawa";
 			reg = <0 0x1604f000 0 0x1000>;
@@ -1529,24 +1804,103 @@
 			#clock-cells = <1>;
 		};
 
+		larb25: larb@16141000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16141000 0 0x1000>;
+			mediatek,larb-id = <25>;
+			mediatek,smi = <&smi_sub_common_cam_4x1>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys_mraw CLK_CAM_MRAW_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_MRAW>;
+		};
+
+		larb26: larb@16142000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16142000 0 0x1000>;
+			mediatek,larb-id = <26>;
+			mediatek,smi = <&smi_sub_common_cam_7x1>;
+			clocks = <&camsys_mraw CLK_CAM_MRAW_LARBX>,
+				 <&camsys_mraw CLK_CAM_MRAW_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_MRAW>;
+
+		};
+
 		ccusys: clock-controller@17200000 {
 			compatible = "mediatek,mt8195-ccusys";
 			reg = <0 0x17200000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb18: larb@17201000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x17201000 0 0x1000>;
+			mediatek,larb-id = <18>;
+			mediatek,smi = <&smi_sub_common_cam_7x1>;
+			clocks = <&ccusys CLK_CCU_LARB18>,
+				 <&ccusys CLK_CCU_LARB18>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb24: larb@1800d000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1800d000 0 0x1000>;
+			mediatek,larb-id = <24>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+		};
+
+		larb23: larb@1800e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1800e000 0 0x1000>;
+			mediatek,larb-id = <23>;
+			mediatek,smi = <&smi_sub_common_vdec_vpp0_2x1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+		};
+
 		vdecsys_soc: clock-controller@1800f000 {
 			compatible = "mediatek,mt8195-vdecsys_soc";
 			reg = <0 0x1800f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb21: larb@1802e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1802e000 0 0x1000>;
+			mediatek,larb-id = <21>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+		};
+
 		vdecsys: clock-controller@1802f000 {
 			compatible = "mediatek,mt8195-vdecsys";
 			reg = <0 0x1802f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb22: larb@1803e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1803e000 0 0x1000>;
+			mediatek,larb-id = <22>;
+			mediatek,smi = <&smi_sub_common_vdec_vpp0_2x1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
+		};
+
 		vdecsys_core1: clock-controller@1803f000 {
 			compatible = "mediatek,mt8195-vdecsys_core1";
 			reg = <0 0x1803f000 0 0x1000>;
@@ -1565,6 +1919,17 @@
 			#clock-cells = <1>;
 		};
 
+		larb19: larb@1a010000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			mediatek,larb-id = <19>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vencsys CLK_VENC_VENC>,
+				 <&vencsys CLK_VENC_GALS>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+		};
+
 		vencsys_core1: clock-controller@1b000000 {
 			compatible = "mediatek,mt8195-vencsys_core1";
 			reg = <0 0x1b000000 0 0x1000>;
@@ -1577,10 +1942,96 @@
 			#clock-cells = <1>;
 		};
 
+		larb20: larb@1b010000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1b010000 0 0x1000>;
+			mediatek,larb-id = <20>;
+			mediatek,smi = <&smi_common_vpp>;
+			clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>,
+				 <&vencsys_core1 CLK_VENC_CORE1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+		};
+
+		larb0: larb@1c018000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c018000 0 0x1000>;
+			mediatek,larb-id = <0>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB0>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
+		larb1: larb@1c019000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c019000 0 0x1000>;
+			mediatek,larb-id = <1>;
+			mediatek,smi = <&smi_common_vpp>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB1>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
 		vdosys1: syscon@1c100000 {
 			compatible = "mediatek,mt8195-mmsys", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		smi_common_vdo: smi@1c01b000 {
+			compatible = "mediatek,mt8195-smi-common-vdo";
+			reg = <0 0x1c01b000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_COMMON>,
+				 <&vdosys0 CLK_VDO0_SMI_EMI>,
+				 <&vdosys0 CLK_VDO0_SMI_RSI>,
+				 <&vdosys0 CLK_VDO0_SMI_GALS>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+
+		};
+
+		iommu_vdo: iommu@1c01f000 {
+			compatible = "mediatek,mt8195-iommu-vdo";
+			reg = <0 0x1c01f000 0 0x1000>;
+			mediatek,larbs = <&larb0 &larb2 &larb5 &larb7 &larb9
+					  &larb10 &larb11 &larb13 &larb17
+					  &larb19 &larb21 &larb24 &larb25
+					  &larb28>;
+			interrupts = <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_IOMMU>;
+			clock-names = "bclk";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
+		larb2: larb@1c102000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c102000 0 0x1000>;
+			mediatek,larb-id = <2>;
+			mediatek,smi = <&smi_common_vdo>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB2>,
+				 <&vdosys1 CLK_VDO1_SMI_LARB2>,
+				 <&vdosys1 CLK_VDO1_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		};
+
+		larb3: larb@1c103000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c103000 0 0x1000>;
+			mediatek,larb-id = <3>;
+			mediatek,smi = <&smi_common_vpp>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB3>,
+				 <&vdosys1 CLK_VDO1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		};
 	};
 };
-- 
2.18.0

