Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56C4C5ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiB0UjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiB0UjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:39:14 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 848526D19A;
        Sun, 27 Feb 2022 12:38:24 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="111718907"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 05:38:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 38F2040E81BF;
        Mon, 28 Feb 2022 05:38:22 +0900 (JST)
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
Subject: [PATCH 12/12] arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes and fillup SPI1 stub node
Date:   Sun, 27 Feb 2022 20:37:44 +0000
Message-Id: <20220227203744.18355-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add SPI{0,2} nodes and fillup SPI1 stub node in RZ/V2L (R9A07G054)
SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 8bbdcf48bb61..9e730171efa8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -179,11 +179,52 @@
 			status = "disabled";
 		};
 
+		spi0: spi@1004ac00 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004ac00 0 0x400>;
+			interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI0_CLKB>;
+			resets = <&cpg R9A07G054_RSPI0_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi1: spi@1004b000 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004b000 0 0x400>;
+			interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI1_CLKB>;
+			resets = <&cpg R9A07G054_RSPI1_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* place holder */
+			status = "disabled";
+		};
+
+		spi2: spi@1004b400 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004b400 0 0x400>;
+			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI2_CLKB>;
+			resets = <&cpg R9A07G054_RSPI2_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial@1004b800 {
-- 
2.17.1

