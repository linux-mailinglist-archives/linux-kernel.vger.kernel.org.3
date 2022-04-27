Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A57511905
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiD0Mwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiD0Mwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:52:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBB32BFC2E;
        Wed, 27 Apr 2022 05:49:36 -0700 (PDT)
X-UUID: f319f698508f4df18e5397f555705c36-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b8a58ba0-fdd8-4603-ba32-bfb24066b7f4,OB:30,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
        m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:b8a58ba0-fdd8-4603-ba32-bfb24066b7f4,OB:30,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
        D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:c1aee82e-6199-437e-8ab4-9920b4bc5b76,C
        OID:414e160774dc,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: f319f698508f4df18e5397f555705c36-20220427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1677077419; Wed, 27 Apr 2022 20:49:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 20:48:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 20:48:07 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Jieyy Yang <jieyy.yang@mediatek.com>
Subject: [PATCH 3/5] arm64: dts: mt7986: add pcie related device nodes
Date:   Wed, 27 Apr 2022 20:47:39 +0800
Message-ID: <20220427124741.18245-4-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220427124741.18245-1-sam.shih@mediatek.com>
References: <20220427124741.18245-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PCIe support for MT7986.

Signed-off-by: Jieyy Yang <jieyy.yang@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 17 +++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 52 ++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index eb14e82d74b1..4a555df1eff4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -25,7 +25,24 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
 &pio {
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk", "pcie_wake", "pcie_pereset";
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 069d3a9bdac9..7d77b5727528 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -240,6 +241,57 @@
 			status = "disabled";
 		};
 
+		pcie: pcie@11280000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0x00 0x11280000 0x00 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0x00 0x20000000 0x00
+				  0x20000000 0x00 0x10000000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_SEL>,
+				 <&infracfg CLK_INFRA_IPCIE_CK>,
+				 <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
+				 <&infracfg CLK_INFRA_IPCIER_CK>,
+				 <&infracfg CLK_INFRA_IPCIEB_CK>;
+			status = "disabled";
+
+			phys = <&pcie_port PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie_phy: t-phy@11c00000 {
+			compatible = "mediatek,mt7986-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			pcie_port: pcie-phy@11c00000 {
+				reg = <0 0x11c00000 0 0x20000>;
+				clocks = <&clk40m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		ethsys: syscon@15000000 {
 			 #address-cells = <1>;
 			 #size-cells = <1>;
-- 
2.18.0

