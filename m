Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10949562C59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiGAHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiGAHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:10:13 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044868A0B;
        Fri,  1 Jul 2022 00:10:11 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 34E29100006;
        Fri,  1 Jul 2022 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656659410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAVl3S8ScYCQZWxGRYXT6xqPfVpbnnDskmYQYuu02mo=;
        b=RdVNE00Qe16mfApzHbUeADqeDz3OVtP/S7p2Cv8BDCRDmQULMk0TDlkhkArGFMb+8mA9mW
        YbrrIVfgNXWp6qKNkfwSxttfIp9aHTHUZk1jonuIUhLYjyFho8rQ+2174l6vXdsD8t+evL
        Qvht+2YPXxm9FmWrfr4o1JIXzDJwRgXH3fxqLYDprqfSIXz5QFHa/Hmf9dMlWgbjFGgq53
        gTTpTv+0WrOJSDluCnfoanKlPy9eXOWkWq5HT5PoAL4+zQlfk0zqd4bIR28ByTlaeBk7K2
        buvHVktN3qKapGtMmN1ixHGHkOERCl1llrFprAT2J1ErmlcSdABTMeueyiBzzg==
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
Subject: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Date:   Fri,  1 Jul 2022 09:09:28 +0200
Message-Id: <20220701070928.459135-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701070928.459135-1-herve.codina@bootlin.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
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
index 3cb02fffe716..c98e7075c2b4 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -458,6 +458,17 @@ cpu_ctrl: syscon@e00c0000 {
 			reg = <0xe00c0000 0x350>;
 		};
 
+		udc: usb@e0808000 {
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
 		can0: can@e081c000 {
 			compatible = "bosch,m_can";
 			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
-- 
2.35.3

