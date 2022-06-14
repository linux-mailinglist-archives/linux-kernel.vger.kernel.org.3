Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1D54ADC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353543AbiFNJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355083AbiFNJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:51:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0D47ACF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=+l+T+tGL+i1JhctM1j4raCDRYAT
        MrBRR4BdzIHpV94k=; b=myn601+mMg3mheHUoVS+qIFP4ZUud/opYUXaxR3YKav
        gOXn0jzIKvjUXK9/FeiNctgbmjOwyF7t7qgERLvaDT0eg0cLRt0MrqFsVX8i2pVI
        yRl87omThnz+MR/3gQnbUi64HkccG2PEwFF+AWFnsfhkvu4DJD/PgFVqccIeAEX0
        =
Received: (qmail 1659380 invoked from network); 14 Jun 2022 11:51:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 11:51:13 +0200
X-UD-Smtp-Session: l3s3148p1@UgZGWGXhGhZZD+ws
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: renesas: r8a779f0: Add HSCIF nodes
Date:   Tue, 14 Jun 2022 11:51:09 +0200
Message-Id: <20220614095109.8175-1-wsa+renesas@sang-engineering.com>
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

Extracted from a bigger patch in the BSP, rebased and DMA
properties added.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: include all HSCIF

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index d89064f86d85..6efbd1fe1e68 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -271,6 +271,74 @@ i2c5: i2c@e66e0000 {
 			status = "disabled";
 		};
 
+		hscif0: serial@e6540000 {
+			compatible = "renesas,hscif-r8a779f0",
+				     "renesas,rcar-gen4-hscif", "renesas,hscif";
+			reg = <0 0xe6540000 0 0x60>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 514>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x31>, <&dmac0 0x30>,
+			       <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 514>;
+			status = "disabled";
+		};
+
+		hscif1: serial@e6550000 {
+			compatible = "renesas,hscif-r8a779f0",
+				     "renesas,rcar-gen4-hscif", "renesas,hscif";
+			reg = <0 0xe6550000 0 0x60>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 515>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x33>, <&dmac0 0x32>,
+			       <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 515>;
+			status = "disabled";
+		};
+
+		hscif2: serial@e6560000 {
+			compatible = "renesas,hscif-r8a779f0",
+				     "renesas,rcar-gen4-hscif", "renesas,hscif";
+			reg = <0 0xe6560000 0 0x60>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 516>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x35>, <&dmac0 0x34>,
+			       <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 516>;
+			status = "disabled";
+		};
+
+		hscif3: serial@e66a0000 {
+			compatible = "renesas,hscif-r8a779f0",
+				     "renesas,rcar-gen4-hscif", "renesas,hscif";
+			reg = <0 0xe66a0000 0 0x60>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 517>,
+				 <&cpg CPG_CORE R8A779F0_CLK_S0D3>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x37>, <&dmac0 0x36>,
+			       <&dmac1 0x37>, <&dmac1 0x36>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
+			status = "disabled";
+		};
+
 		scif3: serial@e6c50000 {
 			compatible = "renesas,scif-r8a779f0",
 				     "renesas,rcar-gen4-scif", "renesas,scif";
-- 
2.35.1

