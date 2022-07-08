Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4430156C1E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiGHTn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiGHTnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:43:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795387372;
        Fri,  8 Jul 2022 12:43:20 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D32E566019F4;
        Fri,  8 Jul 2022 20:43:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657309399;
        bh=HsUUHgmSxVGoE99t9D33ofg+0MT1fLdgE9yRIXfbc5k=;
        h=From:To:Cc:Subject:Date:From;
        b=NFlrFAEcQLDYh2KzyNiBIAanYfG78/212pnVJp/Ef9PyFL98XpD1yTDF3og3uAbrk
         EK6tDvCNILxi2YjDcfGAbaK0fZLkjNNCAf7d0988Ad3c9W+FsFHULfFHrDz+IpvGCA
         oW4cfvzaJwE7TixCDvINh/sW/E9hhV1HhCqALfU/Gh83Gl6PE2DChRkJy9188zWfGh
         EvlF6ZqzEBXFBUkaWpKfkFLmQSTgTGP04x5xwNGQj+SjacFzoRTpDwEyHGDYacmLG1
         viBzuZNL395uGOq30CNCOkJ9qT9hkC+nNcYyt9fVqr/mDQpRWV0jIcLr8tDyEQRZuB
         j8b0Xz41iaDdg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: Add missing xHCI clocks for mt8192 and mt8195
Date:   Fri,  8 Jul 2022 15:43:14 -0400
Message-Id: <20220708194314.56922-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
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

The MediaTek xHCI dt-binding expects a specific order for the clocks,
but the mt8192 and mt8195 devicetrees were skipping some of the middle
clocks. These clocks are wired to the controller hardware but aren't
controllable.

Add the missing clocks as handles to fixed clocks, so that the clock
order is respected and the dtbs_check warnings are gone.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
A previous attempt to solve this also made all clocks required and
updated all MediaTek DTs using the xhci binding [1].

To avoid the DT change noise, the binding change is now being reverted
[2] and only mt8192 and mt8195 DTs are updated in this commit to get rid
of the warnings.

[1] https://lore.kernel.org/all/20220623193702.817996-4-nfraprado@collabora.com/
[2] https://lore.kernel.org/all/20220708192605.43351-1-nfraprado@collabora.com

 arch/arm64/boot/dts/mediatek/mt8192.dtsi |  9 ++++++---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index cbae5a5ee4a0..869958fd420c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -724,9 +724,12 @@ xhci: usb@11200000 {
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
index 066c14989708..725985e599be 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -560,8 +560,10 @@ xhci0: usb@11200000 {
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
@@ -625,8 +627,10 @@ xhci1: usb@11290000 {
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
@@ -646,8 +650,11 @@ xhci2: usb@112a0000 {
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
@@ -667,8 +674,11 @@ xhci3: usb@112b0000 {
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
2.37.0

