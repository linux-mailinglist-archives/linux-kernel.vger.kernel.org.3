Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B24EE7C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbiDAFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiDAFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:32:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E93A1B5;
        Thu, 31 Mar 2022 22:31:00 -0700 (PDT)
X-UUID: ce8d35dc7fbf46308f63b481d3a9c5fc-20220401
X-UUID: ce8d35dc7fbf46308f63b481d3a9c5fc-20220401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 594310020; Fri, 01 Apr 2022 13:30:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Apr 2022 13:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 13:30:54 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 1/1] arm64: dts: mt8192: Add mmc device nodes
Date:   Fri, 1 Apr 2022 13:30:52 +0800
Message-ID: <20220401053052.2160-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220401053052.2160-1-allen-kh.cheng@mediatek.com>
References: <20220401053052.2160-1-allen-kh.cheng@mediatek.com>
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

Add mmc nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index a6da7b04b9d4..23eb92057cb9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -989,6 +989,39 @@
 			compatible = "mediatek,mt8192-msdc";
 			reg = <0 0x11f60000 0 0x1000>;
 			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11f60000 {
+			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
+				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
+				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
+				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
+				 <&msdc_top CLK_MSDC_TOP_AXI>,
+				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
+			clock-names = "source", "hclk", "source_cg", "sys_cg",
+				      "pclk_cg", "axi_cg", "ahb_cg";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11f70000 {
+			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
+				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
+				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
+				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
+				 <&msdc_top CLK_MSDC_TOP_AXI>,
+				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
+			clock-names = "source", "hclk", "source_cg", "sys_cg",
+				      "pclk_cg", "axi_cg", "ahb_cg";
+			status = "disabled";
 		};
 
 		mfgcfg: clock-controller@13fbf000 {
-- 
2.18.0

