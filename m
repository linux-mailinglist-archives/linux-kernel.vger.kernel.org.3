Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBB4DDC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiCROtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiCROry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:47:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282512EA913;
        Fri, 18 Mar 2022 07:46:20 -0700 (PDT)
X-UUID: 0efc8d6c5a95496595c7e16e0c9e0f88-20220318
X-UUID: 0efc8d6c5a95496595c7e16e0c9e0f88-20220318
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1772467285; Fri, 18 Mar 2022 22:45:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Mar 2022 22:45:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 22:45:58 +0800
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
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 21/22] arm64: dts: mt8192: Add gce info for display nodes
Date:   Fri, 18 Mar 2022 22:45:33 +0800
Message-ID: <20220318144534.17996-22-allen-kh.cheng@mediatek.com>
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

Add gce info for display nodes
- It's required to get drivers' CMDQ support

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 08e0dd2483d1..f0f0f067c023 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1203,6 +1203,9 @@
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8192-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
@@ -1212,6 +1215,8 @@
 			reg = <0 0x14001000 0 0x1000>;
 			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
+					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
 		};
 
 		smi_common: smi@14002000 {
@@ -1253,6 +1258,7 @@
 			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
 				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
 		};
 
 		ovl_2l0: ovl@14006000 {
@@ -1263,6 +1269,7 @@
 			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
 			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
 				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
 		};
 
 		rdma0: rdma@14007000 {
@@ -1274,6 +1281,7 @@
 			mediatek,larb = <&larb0>;
 			mediatek,rdma-fifo-size = <5120>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
 		};
 
 		color0: color@14009000 {
@@ -1283,6 +1291,7 @@
 			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
 		};
 
 		ccorr0: ccorr@1400a000 {
@@ -1291,6 +1300,7 @@
 			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
 		};
 
 		aal0: aal@1400b000 {
@@ -1300,6 +1310,7 @@
 			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_AAL0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
 		};
 
 		gamma0: gamma@1400c000 {
@@ -1309,6 +1320,7 @@
 			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
 		};
 
 		postmask0: postmask@1400d000 {
@@ -1318,6 +1330,7 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
 			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
 		};
 
 		dither0: dither@1400e000 {
@@ -1327,6 +1340,7 @@
 			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
 		};
 
 		dsi0: dsi@14010000 {
@@ -1351,6 +1365,7 @@
 			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
 			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
 				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
 		};
 
 		rdma4: rdma@14015000 {
@@ -1361,6 +1376,7 @@
 			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
 			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
 			mediatek,rdma-fifo-size = <2048>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
 		};
 
 		dpi0: dpi@14016000 {
-- 
2.18.0

