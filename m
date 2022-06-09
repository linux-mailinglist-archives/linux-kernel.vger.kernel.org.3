Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4B5449ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiFILXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiFILXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:23:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316884A2C;
        Thu,  9 Jun 2022 04:23:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9E8D66017C9;
        Thu,  9 Jun 2022 12:23:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654773789;
        bh=BzU2sp5uWjhJVZc+Pbqb4F7Rd9WBetm2NBJji/SvJBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bz5vhmF1Y531BltL8wLWNs23X4odbGrcHRtG8SI8DJFGEkmoec7IyE1m6R3bOYM5a
         sR54DiZ9U+6IvkH3mTKJfO2ql0PJdAV0IV9MPv/wRZ+qB3tSCtiMa7GKip1cK9OXx8
         9OLmpH/wh3xtvfGksl62D9Vjv0qzK9EM2LhgBcSeIaLZro1l7PhQxJ9VRK+BAmwPTf
         SFQO+wwYrVHUUyIQ4ITKiTzSqxcEyBttlHfyw4Bif6zaq7NHPqKMVrmdFo5GQmIq0N
         dlG0B7K6YRHk2Uo38lCxAolvwOBpXsjTCsCGVDXWMGy7QqOz1gTRwUScXGlIWBnSCp
         acOquf7Xzl9Sw==
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
Subject: [PATCH v2 01/10] arm64: dts: mediatek: mt6795: Create soc bus node and move mmio devices
Date:   Thu,  9 Jun 2022 13:22:54 +0200
Message-Id: <20220609112303.117928-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
References: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMIO devices should be inside of a soc bus node, as it's done for the
vast majority of ARM64 devicetrees, and for almost all MTK devicetrees.
Create a simple-bus soc node and move all devices with a MMIO address
space in there.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 105 ++++++++++++-----------
 1 file changed, 56 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index c85659d0ff5d..167f90bd991a 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -117,59 +117,66 @@ timer {
 			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	sysirq: intpol-controller@10200620 {
-		compatible = "mediatek,mt6795-sysirq",
-			     "mediatek,mt6577-sysirq";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		reg = <0 0x10200620 0 0x20>;
-	};
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		sysirq: intpol-controller@10200620 {
+			compatible = "mediatek,mt6795-sysirq",
+				     "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200620 0 0x20>;
+		};
 
-	gic: interrupt-controller@10221000 {
-		compatible = "arm,gic-400";
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		interrupt-controller;
-		reg = <0 0x10221000 0 0x1000>,
-		      <0 0x10222000 0 0x2000>,
-		      <0 0x10224000 0 0x2000>,
-		      <0 0x10226000 0 0x2000>;
-	};
+		gic: interrupt-controller@10221000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x10221000 0 0x1000>,
+			      <0 0x10222000 0 0x2000>,
+			      <0 0x10224000 0 0x2000>,
+			      <0 0x10226000 0 0x2000>;
+		};
 
-	uart0: serial@11002000 {
-		compatible = "mediatek,mt6795-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0 0x11002000 0 0x400>;
-		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt6795-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	uart1: serial@11003000 {
-		compatible = "mediatek,mt6795-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0 0x11003000 0 0x400>;
-		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt6795-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	uart2: serial@11004000 {
-		compatible = "mediatek,mt6795-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0 0x11004000 0 0x400>;
-		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt6795-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x400>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	uart3: serial@11005000 {
-		compatible = "mediatek,mt6795-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0 0x11005000 0 0x400>;
-		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
+		uart3: serial@11005000 {
+			compatible = "mediatek,mt6795-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11005000 0 0x400>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.35.1

