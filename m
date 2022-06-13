Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5032549A47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiFMRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347252AbiFMRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:40:43 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93039824
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=nNFUTHutgVGNjPFk6KiURpi6dow
        EACSz6iArJubNd9M=; b=AU0s+MxgUcJ+dt9rAAqEZ+XtbN3Pgl5SpYayA1AOoFv
        rH/Ux+TmrowKTCrpkQ3dtU/WgrQcpmA5BltIRmWGfm5AckG2SzJpL2J2Jg0yBjoX
        5yMtfhjyJAuBsl8+YCbe1zD80WZjs/UbqNo22d8Y4zMOynyInCADU89n1h8J3KNY
        =
Received: (qmail 1304708 invoked from network); 13 Jun 2022 15:10:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:10:51 +0200
X-UD-Smtp-Session: l3s3148p1@XAJjBFThL1ZZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: renesas: r8a779f0: Add HSCIF 0+1 nodes
Date:   Mon, 13 Jun 2022 15:10:31 +0200
Message-Id: <20220613131033.10053-1-wsa+renesas@sang-engineering.com>
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
properties added. HSCIF0+1 work fine, HSCIF2+3 skipped because they
haven't been tested yet.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index d89064f86d85..ebc4a052207a 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -271,6 +271,40 @@ i2c5: i2c@e66e0000 {
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
 		scif3: serial@e6c50000 {
 			compatible = "renesas,scif-r8a779f0",
 				     "renesas,rcar-gen4-scif", "renesas,scif";
-- 
2.35.1

