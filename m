Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0689A533719
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiEYHLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiEYHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:11:25 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4678F5FBF;
        Wed, 25 May 2022 00:11:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A7C45100012;
        Wed, 25 May 2022 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653462660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Vo9108VQlTnpt+qV7O1ggI75pFbssp26cf+E/xUTKg=;
        b=FjUAn8+dQt/kDdFahEAzg/CHBhBfIL/FL7rOOula+OHBO7DDDk8309LvHN8Fh5weJ5ddR5
        ey2lZnuEXRRUvZ/c67ZUu3PfY5kYNoyFpkJ7QE11867+xYBoip7bE9Fk7IBdsXNhKPlGL5
        C6i5rlvg2sBiy3BUjbadAkbJf7s+JpHdQ6jCAVPG/P9vyVJHhdytawukN1UzHzrN1plRof
        SrjFzcMSXEMSCPwLSlOzB4R3WdqQtcv9nS9Ia0+roEqXHjNa2p7v/GKf93uj12TcenZJYl
        klfIyY5/6HDZhMYFvJvPjzC8diWBRUMG3O4xDod7eXUOu0Vn/4LwvLddH4vwEw==
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
Subject: [PATCH v3 3/3] ARM: dts: lan966x: Add UDPHS support
Date:   Wed, 25 May 2022 09:10:36 +0200
Message-Id: <20220525071036.223396-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525071036.223396-1-herve.codina@bootlin.com>
References: <20220525071036.223396-1-herve.codina@bootlin.com>
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
index 7d2869648050..e086df741f99 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -196,6 +196,17 @@ watchdog: watchdog@e0090000 {
 			status = "disabled";
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

