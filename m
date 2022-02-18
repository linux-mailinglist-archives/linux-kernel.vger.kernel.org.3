Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F414BB52E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiBRJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:17:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiBRJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB71117E;
        Fri, 18 Feb 2022 01:16:50 -0800 (PST)
X-UUID: cf2f7da9140d4f098cc3b515a4a63132-20220218
X-UUID: cf2f7da9140d4f098cc3b515a4a63132-20220218
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742451437; Fri, 18 Feb 2022 17:16:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 18 Feb 2022 17:16:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 17:16:45 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 10/23] arm64: dts: mt8192: Add PCIe node
Date:   Fri, 18 Feb 2022 17:16:20 +0800
Message-ID: <20220218091633.9368-11-allen-kh.cheng@mediatek.com>
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

Add PCIe node for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index a935a22babbb..4533c794effc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -886,6 +886,44 @@
 			};
 		};
 
+		pcie: pcie@11230000 {
+			compatible = "mediatek,mt8192-pcie";
+			device_type = "pci";
+			reg = <0 0x11230000 0 0x2000>;
+			reg-names = "pcie-mac";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			clocks = <&infracfg CLK_INFRA_PCIE_TL_26M>,
+				<&infracfg CLK_INFRA_PCIE_TL_96M>,
+				<&infracfg CLK_INFRA_PCIE_TL_32K>,
+				<&infracfg CLK_INFRA_PCIE_PERI_26M>,
+				<&infracfg CLK_INFRA_PCIE_TOP_H_133M>,
+				<&infracfg CLK_INFRA_PCIE_PL_P_250M>;
+			clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
+				 "obff_ck0", "axi_ck0", "pipe_ck0";
+			assigned-clocks = <&topckgen CLK_TOP_TL_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D6_D4>;
+			resets = <&infracfg_rst 2>,
+				 <&infracfg_rst 3>;
+			reset-names = "phy", "mac";
+			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0 0x12000000 0x0 0x12000000 0 0x0800000>,
+				 <0x81000000 0 0x12800000 0x0 0x12800000 0 0x0800000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+				   <0 0 0 2 &pcie_intc0 1>,
+				   <0 0 0 3 &pcie_intc0 2>,
+				   <0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		nor_flash: spi@11234000 {
 			compatible = "mediatek,mt8192-nor";
 			reg = <0 0x11234000 0 0xe0>;
-- 
2.18.0

