Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3E5718C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiGLLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiGLLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:41:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21686AD869;
        Tue, 12 Jul 2022 04:40:57 -0700 (PDT)
X-UUID: 9241ccb2893b4ba2b60ffb7342ae2628-20220712
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:7a9c118b-7cad-414f-aa34-6f12c54b3f65,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:7a9c118b-7cad-414f-aa34-6f12c54b3f65,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:f42d46d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:44b38631aa1e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9241ccb2893b4ba2b60ffb7342ae2628-20220712
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 23568853; Tue, 12 Jul 2022 19:40:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 12 Jul 2022 19:40:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 12 Jul 2022 19:40:51 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 4/5] arm64: dts: mt8192: Add display nodes
Date:   Tue, 12 Jul 2022 19:40:45 +0800
Message-ID: <20220712114046.15574-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
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

Add display nodes and gce info for mt8192 SoC.

GCE (Global Command Engine) properties to the display nodes in order to
enable the usage of the CMDQ (Command Queue), which is required for
operating the display.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 146 +++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index a997f34cc3ad..92478e57f16f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include <dt-bindings/clock/mt8192-clk.h>
+#include <dt-bindings/gce/mt8192-gce.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/memory/mt8192-larb-port.h>
@@ -20,6 +21,14 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		ovl0 = &ovl0;
+		ovl-2l0 = &ovl_2l0;
+		ovl-2l2 = &ovl_2l2;
+		rdma0 = &rdma0;
+		rdma4 = &rdma4;
+	};
+
 	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -554,6 +563,15 @@
 			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
 		};
 
+		gce: mailbox@10228000 {
+			compatible = "mediatek,mt8192-gce";
+			reg = <0 0x10228000 0 0x4000>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+		};
+
 		scp_adsp: clock-controller@10720000 {
 			compatible = "mediatek,mt8192-scp_adsp";
 			reg = <0 0x10720000 0 0x1000>;
@@ -1189,6 +1207,19 @@
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+		};
+
+		mutex: mutex@14001000 {
+			compatible = "mediatek,mt8192-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
+					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 		};
 
 		smi_common: smi@14002000 {
@@ -1222,6 +1253,121 @@
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
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
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
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+		};
+
+		rdma0: rdma@14007000 {
+			compatible = "mediatek,mt8192-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
+			mediatek,rdma-fifo-size = <5120>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
+		};
+
+		color0: color@14009000 {
+			compatible = "mediatek,mt8192-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
+		};
+
+		ccorr0: ccorr@1400a000 {
+			compatible = "mediatek,mt8192-disp-ccorr";
+			reg = <0 0x1400a000 0 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
+		};
+
+		aal0: aal@1400b000 {
+			compatible = "mediatek,mt8192-disp-aal",
+				     "mediatek,mt8183-disp-aal";
+			reg = <0 0x1400b000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_AAL0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
+		};
+
+		gamma0: gamma@1400c000 {
+			compatible = "mediatek,mt8192-disp-gamma",
+				     "mediatek,mt8183-disp-gamma";
+			reg = <0 0x1400c000 0 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
+		};
+
+		postmask0: postmask@1400d000 {
+			compatible = "mediatek,mt8192-disp-postmask";
+			reg = <0 0x1400d000 0 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
+		};
+
+		dither0: dither@1400e000 {
+			compatible = "mediatek,mt8192-disp-dither",
+				     "mediatek,mt8183-disp-dither";
+			reg = <0 0x1400e000 0 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
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
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
+		};
+
+		rdma4: rdma@14015000 {
+			compatible = "mediatek,mt8192-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
+			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
+			mediatek,rdma-fifo-size = <2048>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
+		};
+
 		dpi0: dpi@14016000 {
 			compatible = "mediatek,mt8192-dpi";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.18.0

