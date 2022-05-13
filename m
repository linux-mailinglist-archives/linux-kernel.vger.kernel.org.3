Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07B526810
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382858AbiEMRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382835AbiEMRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CA3122B;
        Fri, 13 May 2022 10:16:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9A82C1F463B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652462187;
        bh=xHDizGEAS5CEUxEZaxa3laKX/jFEH45gEkIh0l+Zvvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=norOKTi32tuUwqGq38L3Hc4rQbrVKvPwvxJ3Nj/2aEw5sd8upvUxOAaR+YWmKI9F3
         nDQr2MUsdwQ1ksgr94q5xytYzl83x9hX2EpZeGZWdTbJZyqTBcdmqPpIqEJVYecyfn
         inVEIsFvYifnB9JyLEl+KF0FmKDrDInSYiycOwl8lllrx23et5EUFJCry+ubx34xkf
         PwA3j7UpPVQo8DIeH/PxUp915eKaJfU8eVC0KKxg3+TXWAKl7Hu++qOmYHeAGuuf7g
         xwRRpCFR6sH2uuC12t92Uh88FOSOmcA8QZFp1MhDJTiRFggczrDajx03dIagDPp7J0
         zLXrReUdCMDeA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/7] arm64: dts: mediatek: mt6795: Add fixed clocks for 32kHz and 26MHz XOs
Date:   Fri, 13 May 2022 19:16:15 +0200
Message-Id: <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 32kHz and 26MHz oscillators as fixed clocks in devicetree to
provide a good initial clock spec, since this SoC features two always
on oscillators running at the aforementioned frequencies.
While at it, since the UART clock is actually referring to the 26MHz
oscillator, remove it and assign clk26m as "baud" clock for the UARTs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 363fa25b4edc..b6f7681cc151 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -142,21 +142,23 @@ l2_1: l2-cache1 {
 		};
 	};
 
-	system_clk: dummy13m {
+	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
-		clock-frequency = <13000000>;
 		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
 	};
 
-	rtc_clk: dummy32k {
+	clk32k: oscillator-32k {
 		compatible = "fixed-clock";
-		clock-frequency = <32000>;
 		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
 	};
 
-	uart_clk: dummy26m {
+	system_clk: dummy13m {
 		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
+		clock-frequency = <13000000>;
 		#clock-cells = <0>;
 	};
 
@@ -221,7 +223,7 @@ uart0: serial@11002000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x400>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&clk26m>;
 			status = "disabled";
 		};
 
@@ -230,7 +232,7 @@ uart1: serial@11003000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x400>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&clk26m>;
 			status = "disabled";
 		};
 
@@ -239,7 +241,7 @@ uart2: serial@11004000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x400>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&clk26m>;
 			status = "disabled";
 		};
 
@@ -248,7 +250,7 @@ uart3: serial@11005000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11005000 0 0x400>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&uart_clk>;
+			clocks = <&clk26m>;
 			status = "disabled";
 		};
 	};
-- 
2.35.1

