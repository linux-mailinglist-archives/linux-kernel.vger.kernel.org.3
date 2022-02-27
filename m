Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7948D4C5EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiB0UjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiB0Ui7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:38:59 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 099606D84F;
        Sun, 27 Feb 2022 12:38:17 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="111718897"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 05:38:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06A3240E81B0;
        Mon, 28 Feb 2022 05:38:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 09/12] arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the SSI0 stub node
Date:   Sun, 27 Feb 2022 20:37:41 +0000
Message-Id: <20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SSI{1,2,3} nodes and fillup the SSI0 stub node in RZ/V2L
(R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 80 +++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index a3623e70f02c..e3a9f78b7fb8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -96,9 +96,87 @@
 		ranges;
 
 		ssi0: ssi@10049c00 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
 			reg = <0 0x10049c00 0 0x400>;
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
-			/* place holder */
+			status = "disabled";
+		};
+
+		ssi1: ssi@1004a000 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@1004a400 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a400 0 0x400>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x265f>;
+			dma-names = "rt";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@1004a800 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a800 0 0x400>;
+			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
 		};
 
 		spi1: spi@1004b000 {
-- 
2.17.1

