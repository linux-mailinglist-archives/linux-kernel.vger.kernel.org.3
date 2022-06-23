Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0855897D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFWTpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiFWToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:44:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72D10578;
        Thu, 23 Jun 2022 12:37:13 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 976A566017ED;
        Thu, 23 Jun 2022 20:37:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656013032;
        bh=/LxDQPxHfyiUgre3GB0q3RHmhgoanHBngDjpfGX6Yog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIJmxzUzOGfV1BE9Z0Gl813sbwN2bP6aPOeYICMsWlLBhiyw4cZHuqfQwcoTESyXP
         26OdUbC0sFhQDxvVVYfyziQsR4dIKL0aw+7+iOTMw04i73FV3uY2MUWpHoDJ3QHPft
         LBfycqcEv8D/U+tobyVXMm9P9XCx+WhduJShgqt4hyZEqERJYQZ0Qdjlh7guDqnGp3
         8O0dZKwAmcK6QeAFt/EOVuQMUs5YTbnyOA2WJesqGv/zCNtOPS9E2NtyUsz26vwxfB
         g3vYlbR+R25VGetwCC00lXXZko8tdV4y2p0G9ZGuDlP6b1150NxuVM0j9HeVTE6osv
         i4NL/dGxAA1nw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: mediatek: Set fixed-clock for missing XHCI clocks
Date:   Thu, 23 Jun 2022 15:37:01 -0400
Message-Id: <20220623193702.817996-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623193702.817996-1-nfraprado@collabora.com>
References: <20220623193702.817996-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XHCI controller hardware always has all clocks wired, however
depending on the SoC, some of them might be fixed (ie not controllable).
These fixed clocks were previously omitted from the devicetree entirely.

In order to better describe the hardware on the devicetree, and to have
a fixed order of clocks for all SoCs, add the missing non-controllable
clocks as phandles to a fixed-clock node.

By keeping a fixed clock order, this gets rid of dtbs_check warnings on
mt8192 and mt8195.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Instead of simply reordering the clocks on mt8192, added missing fixed
  clocks for all arm64 dts
- Rewrote commit message and title

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 18 ++++++++++++++----
 arch/arm64/boot/dts/mediatek/mt7622.dtsi  |  5 +++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi  |  9 +++++++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi  |  8 ++++++--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi  |  9 ++++++---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi  | 18 ++++++++++++++----
 6 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 623eb3beabf2..941d6a19075c 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -816,8 +816,13 @@ usb_host0: usb@11270000 {
 			reg-names = "mac";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT2712_POWER_DOMAIN_USB>;
-			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
-			clock-names = "sys_ck", "ref_ck";
+			clocks = <&topckgen CLK_TOP_USB30_SEL>,
+				 <&clk26m>,
+				 <&clk26m>,
+				 <&clk26m>,
+				 <&clk26m>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			status = "disabled";
 		};
 	};
@@ -880,8 +885,13 @@ usb_host1: usb@112c0000 {
 			reg-names = "mac";
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&scpsys MT2712_POWER_DOMAIN_USB2>;
-			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
-			clock-names = "sys_ck", "ref_ck";
+			clocks = <&topckgen CLK_TOP_USB30_SEL>,
+				 <&clk26m>,
+				 <&clk26m>,
+				 <&clk26m>,
+				 <&clk26m>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 146e18b5b1f4..04ba0773dda3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -752,8 +752,9 @@ ssusb: usb@1a0c0000 {
 		clocks = <&ssusbsys CLK_SSUSB_SYS_EN>,
 			 <&ssusbsys CLK_SSUSB_REF_EN>,
 			 <&ssusbsys CLK_SSUSB_MCU_EN>,
-			 <&ssusbsys CLK_SSUSB_DMA_EN>;
-		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			 <&ssusbsys CLK_SSUSB_DMA_EN>,
+			 <&clk25m>;
+		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 		phys = <&u2port0 PHY_TYPE_USB2>,
 		       <&u3port0 PHY_TYPE_USB3>,
 		       <&u2port1 PHY_TYPE_USB2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d1f3dc5dec35..3b64651f7a43 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -943,8 +943,13 @@ usb_host: usb@11270000 {
 				reg-names = "mac";
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 				power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
-				clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
-				clock-names = "sys_ck", "ref_ck";
+				clocks = <&topckgen CLK_TOP_USB30_SEL>,
+					 <&clk26m>,
+					 <&clk26m>,
+					 <&clk26m>,
+					 <&clk26m>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck",
+					      "dma_ck", "xhci_ck";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index e92a0b8c1ee2..fe114f70f677 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1471,8 +1471,12 @@ usb_host: usb@11200000 {
 				reg-names = "mac";
 				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
 				clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
-					 <&infracfg CLK_INFRA_USB>;
-				clock-names = "sys_ck", "ref_ck";
+					 <&infracfg CLK_INFRA_USB>,
+					 <&clk26m>,
+					 <&clk26m>,
+					 <&clk26m>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck",
+					      "dma_ck", "xhci_ck";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 733aec2e7f77..fd2ab1f2a1bb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -723,9 +723,12 @@ xhci: usb@11200000 {
 			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
 						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&infracfg CLK_INFRA_SSUSB>,
-				 <&infracfg CLK_INFRA_SSUSB_XHCI>,
-				 <&apmixedsys CLK_APMIXED_USBPLL>;
-			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+				 <&apmixedsys CLK_APMIXED_USBPLL>,
+				 <&clk26m>,
+				 <&clk26m>,
+				 <&infracfg CLK_INFRA_SSUSB_XHCI>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			wakeup-source;
 			mediatek,syscon-wakeup = <&pericfg 0x420 102>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 3ad14e0e0956..8e9783953795 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -571,8 +571,10 @@ xhci0: usb@11200000 {
 			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
 				 <&topckgen CLK_TOP_SSUSB_REF>,
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
+				 <&clk26m>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
 			wakeup-source;
 			status = "disabled";
@@ -636,8 +638,10 @@ xhci1: usb@11290000 {
 			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
 				 <&topckgen CLK_TOP_SSUSB_P1_REF>,
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
+				 <&clk26m>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck","xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
 			wakeup-source;
 			status = "disabled";
@@ -657,8 +661,11 @@ xhci2: usb@112a0000 {
 						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
 				 <&topckgen CLK_TOP_SSUSB_P2_REF>,
+				 <&clk26m>,
+				 <&clk26m>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
 			wakeup-source;
 			status = "disabled";
@@ -678,8 +685,11 @@ xhci3: usb@112b0000 {
 						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
 				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
+				 <&clk26m>,
+				 <&clk26m>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
+				      "xhci_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
 			wakeup-source;
 			status = "disabled";
-- 
2.36.1

