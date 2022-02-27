Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8894C5ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiB0Ujl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiB0Ui6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:38:58 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A05BB6D1AB;
        Sun, 27 Feb 2022 12:38:15 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="112525459"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2022 05:38:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A57A40E81B7;
        Mon, 28 Feb 2022 05:38:12 +0900 (JST)
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
Subject: [PATCH 08/12] arm64: dts: renesas: r9a07g054: Fillup the WDT{0,1,2} stub nodes
Date:   Sun, 27 Feb 2022 20:37:40 +0000
Message-Id: <20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Fillup the WDT{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 50cb2f0e6e73..a3623e70f02c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -614,18 +614,48 @@
 		};
 
 		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800800 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt1: watchdog@12800c00 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800C00 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT1_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT1_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT1_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt2: watchdog@12800400 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800400 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT2_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT2_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT2_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm0: timer@12801000 {
-- 
2.17.1

