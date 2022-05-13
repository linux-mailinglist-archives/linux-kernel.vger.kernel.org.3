Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92275526076
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379668AbiEMK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379651AbiEMK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:59:10 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E942A28F6;
        Fri, 13 May 2022 03:59:08 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 778A810000C;
        Fri, 13 May 2022 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652439547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDbhCUB50i3TiYKzQUORArQ45Vtm0wzVgFF/9jjJq7k=;
        b=EjIfoxCZEAaI659zwbW5ETc78Lfde1yiNztIhoL9nhnZxcvo7Uy0pVD/CRVcL6DO2KC1ah
        6rkxF6Ef6/E81TmwXTWa6XHWwlK25WPDuykl3SZLV6ISgrSz1q/ti0zTQnMJwowlnwLM6/
        JeeSo8fRDiPBwzHmtBAUMv2iKpKEc+jpRpWzWWBPYWCbC9eFwU+Tdg/RcRC4yhtuahCoww
        ueFgo8QJpwtI1Def90xEqdCpVIfMZufEiBEaPASFQKPvJRW2Q/+mzCC4TOgqEgpuV+KNC9
        S1YAl3AQ8xTBDEfVO063yJyffJPGhmvrMtvn9yHMYgsikmW0VPFXgBcu57VuvQ==
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
Subject: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
Date:   Fri, 13 May 2022 12:58:50 +0200
Message-Id: <20220513105850.310375-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513105850.310375-1-herve.codina@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UDPHS (the USB High Speed Device Port controller) support.
The UDPHS IP present in the lan966x SOC is the same as the one
present in the SAMA5D3 SOC

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 7d2869648050..4c09f3166d27 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -211,6 +211,17 @@ can0: can@e081c000 {
 			status = "disabled";
 		};
 
+		udc: udphs@e0808000 {
+			compatible = "microchip,lan996x-udc",
+				     "atmel,sama5d3-udc";
+			reg = <0x00200000 0x80000>,
+			      <0xe0808000 0x400>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_GATE_UDPHS>, <&nic_clk>;
+			clock-names = "pclk", "hclk";
+			status = "disabled";
+		};
+
 		gpio: pinctrl@e2004064 {
 			compatible = "microchip,lan966x-pinctrl";
 			reg = <0xe2004064 0xb4>,
-- 
2.35.1

