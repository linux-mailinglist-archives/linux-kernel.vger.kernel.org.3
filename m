Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6929254ADBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiFNJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiFNJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:52:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC542ED2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=Zua+hVq6A147kxWQc6xwYdWO5u2
        LpwDIn3Cdp+cdV64=; b=AtbzRnbzEMMJdhn3zyxmhg5EvicYG3KqmGVzDo5BsDc
        nBALNSG2ZyEabbQua8e1sCpkoMLGlV30ugSaLjgLjUjxs/7Ya0yil04oPniFOAkp
        EvcCUpZfxNEJN5Yps4bOS1LFHwTyyUvv75cdAr4fzWeAG7dUs24M5jx0VDe9b/u4
        =
Received: (qmail 1659849 invoked from network); 14 Jun 2022 11:52:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 11:52:44 +0200
X-UD-Smtp-Session: l3s3148p1@jzy4XWXh/DxZD+ws
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: renesas: r8a779f0: Add SCIF nodes
Date:   Tue, 14 Jun 2022 11:52:42 +0200
Message-Id: <20220614095242.8264-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linh Phung <linh.phung.jy@renesas.com>

Extracted from a bigger patch in the BSP, rebased, reg length corrected,
and DMA properties added.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: include all SCIF

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 7b27260c0fd7..5460c85a2f0a 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -339,6 +339,40 @@ hscif3: serial@e66a0000 {
 			status = "disabled";
 		};
 
+		scif0: serial@e6e60000 {
+			compatible = "renesas,scif-r8a779f0",
+				     "renesas,rcar-gen4-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3_PER>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x51>, <&dmac0 0x50>,
+			       <&dmac1 0x51>, <&dmac1 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
+		scif1: serial@e6e68000 {
+			compatible = "renesas,scif-r8a779f0",
+				     "renesas,rcar-gen4-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3_PER>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x53>, <&dmac0 0x52>,
+			       <&dmac1 0x53>, <&dmac1 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
 		scif3: serial@e6c50000 {
 			compatible = "renesas,scif-r8a779f0",
 				     "renesas,rcar-gen4-scif", "renesas,scif";
@@ -356,6 +390,23 @@ scif3: serial@e6c50000 {
 			status = "disabled";
 		};
 
+		scif4: serial@e6c40000 {
+			compatible = "renesas,scif-r8a779f0",
+				     "renesas,rcar-gen4-scif", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 705>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3_PER>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>,
+			       <&dmac1 0x59>, <&dmac1 0x58>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 705>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller@e7350000 {
 			compatible = "renesas,dmac-r8a779f0",
 				     "renesas,rcar-gen4-dmac";
-- 
2.35.1

