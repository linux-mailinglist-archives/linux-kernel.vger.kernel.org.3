Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244E049F3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbiA1G3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:29:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242393AbiA1G3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:29:10 -0500
X-UUID: b02262b5534f4d32b9529e3dc2dc5059-20220128
X-UUID: b02262b5534f4d32b9529e3dc2dc5059-20220128
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 946290845; Fri, 28 Jan 2022 14:29:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 14:29:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 14:29:05 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 3/4] arm64: dts: mediatek: mt8195: add efuse node and cells
Date:   Fri, 28 Jan 2022 14:29:01 +0800
Message-ID: <20220128062902.26273-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse node and cells used by t-phy to fix the bit shift issue

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: use hw auto load for u2phy which has no this issue

Note:

 depend on the reviewing patch:

[v9,3/3] arm64: dts: Add mediatek SoC mt8195 and evaluation board
https://patchwork.kernel.org/patch/12711296
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index a363e82f6988..240a21708806 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -695,6 +695,53 @@
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			u3_tx_imp_p0: usb3-tx-imp@184 {
+				reg = <0x184 0x1>;
+				bits = <0 5>;
+			};
+			u3_rx_imp_p0: usb3-rx-imp@184 {
+				reg = <0x184 0x2>;
+				bits = <5 5>;
+			};
+			u3_intr_p0: usb3-intr@185 {
+				reg = <0x185 0x1>;
+				bits = <2 6>;
+			};
+			comb_tx_imp_p1: usb3-tx-imp@186 {
+				reg = <0x186 0x1>;
+				bits = <0 5>;
+			};
+			comb_rx_imp_p1: usb3-rx-imp@186 {
+				reg = <0x186 0x2>;
+				bits = <5 5>;
+			};
+			comb_intr_p1: usb3-intr@187 {
+				reg = <0x187 0x1>;
+				bits = <2 6>;
+			};
+			u2_intr_p0: usb2-intr-p0@188 {
+				reg = <0x188 0x1>;
+				bits = <0 5>;
+			};
+			u2_intr_p1: usb2-intr-p1@188 {
+				reg = <0x188 0x2>;
+				bits = <5 5>;
+			};
+			u2_intr_p2: usb2-intr-p2@189 {
+				reg = <0x189 0x1>;
+				bits = <2 5>;
+			};
+			u2_intr_p3: usb2-intr-p3@189 {
+				reg = <0x189 0x2>;
+				bits = <7 5>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
 			#address-cells = <1>;
@@ -877,6 +924,10 @@
 				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
 					 <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>;
 				clock-names = "ref", "da_ref";
+				nvmem-cells = <&comb_intr_p1>,
+					      <&comb_rx_imp_p1>,
+					      <&comb_tx_imp_p1>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
@@ -901,6 +952,10 @@
 				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
 					 <&topckgen CLK_TOP_SSUSB_PHY_REF>;
 				clock-names = "ref", "da_ref";
+				nvmem-cells = <&u3_intr_p0>,
+					      <&u3_rx_imp_p0>,
+					      <&u3_tx_imp_p0>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
-- 
2.18.0

