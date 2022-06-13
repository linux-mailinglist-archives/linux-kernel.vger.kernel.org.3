Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868C549B10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbiFMSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiFMSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:03:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2019C753
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=f32apliLknBYuX
        3QjNK6nbzvMqWF1qtjkhfLOx93EX0=; b=w3hQhb1OsiBpDBdTjt66UTbzcbZlaw
        TrCscJxOqe/hN1twyDRSBCD6tM93G8OYGrtbL32GgbkyvQsoa+TVkuHU1BLkGER9
        BDhLeYKL8zYpROlKvPHaZumuXiTFeuRCNPQJdTQV3oxqxCO56XGIiLD+gF+ARlFa
        IcwcUydA9X8eY=
Received: (qmail 1316263 invoked from network); 13 Jun 2022 15:49:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:49:19 +0200
X-UD-Smtp-Session: l3s3148p1@gy7/jVThfCRZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Linh Phung <linh.phung.jy@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: renesas: r8a779f0: Add SCIF 0 node
Date:   Mon, 13 Jun 2022 15:49:13 +0200
Message-Id: <20220613134914.18655-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
References: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
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
and DMA properties added. SCIF0 works fine, SCIF1+4 skipped because they
haven't been tested yet.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index c872030ec4fe..2cae951c4375 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -305,6 +305,23 @@ hscif1: serial@e6550000 {
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
 		scif3: serial@e6c50000 {
 			compatible = "renesas,scif-r8a779f0",
 				     "renesas,rcar-gen4-scif", "renesas,scif";
-- 
2.35.1

