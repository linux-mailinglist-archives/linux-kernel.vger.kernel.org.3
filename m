Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A66565259
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiGDK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiGDK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:29:05 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AEB26C0;
        Mon,  4 Jul 2022 03:29:03 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 6D212240008;
        Mon,  4 Jul 2022 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656930542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSXnCRxUl4U9Qi112GF1nMAAGUftrLkrbGlg6cMy5Gg=;
        b=cBz/PcInNbBTr5htwUDKttOie/ZgPjXmHxtQhYCqfNrs2NACOTx9Dtw8V+zRJuBapjAqlR
        3TyQE0Qi7DRJYNw9E8pTY2XjibFpklli0uHxIyIfeh2sOSFlbuu+6b70th4TfOgPtTKECo
        OTA0yPA8TDNO0BEAUFj26eMIwXJXLP0T6Mdt+2JlL3DD74ievXF326IayDluLoPWWSMPtc
        axmKiHjTiaNC7tVfrToH6ALAjg79Uv/f0Ex8yvQ039283WWTP/ZnLroznTshBGDrM3okYO
        i1AL4VFmKdCsmZJPiWcLOPH0MOnZ79e55W3rq3vUQ7j59Lv1hqWzeGNzyXItOA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v5 3/3] ARM: dts: lan966x: Add UDPHS support
Date:   Mon,  4 Jul 2022 12:28:45 +0200
Message-Id: <20220704102845.168438-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704102845.168438-1-herve.codina@bootlin.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UDPHS (the USB High Speed Device Port controller) support.

The both lan966x SOCs (LAN9662 and LAN9668) have the same UDPHS
IP. This IP is also the same as the one present in the SAMA5D3
SOC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 3cb02fffe716..a54fee5254a4 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -84,6 +84,17 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		udc: usb@200000 {
+			compatible = "microchip,lan9662-udc",
+				     "atmel,sama5d3-udc";
+			reg = <0x00200000 0x80000>,
+			      <0xe0808000 0x400>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_GATE_UDPHS>, <&nic_clk>;
+			clock-names = "pclk", "hclk";
+			status = "disabled";
+		};
+
 		switch: switch@e0000000 {
 			compatible = "microchip,lan966x-switch";
 			reg = <0xe0000000 0x0100000>,
-- 
2.35.3

