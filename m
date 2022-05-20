Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24C52EF12
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiETPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350792AbiETPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:23:51 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68A13B8E7;
        Fri, 20 May 2022 08:23:48 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AE52740008;
        Fri, 20 May 2022 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653060227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hodHHbnMphQrf6mSg4FnD5vW8CvNnZ5zwZ57s3yWBkg=;
        b=DC4NVEPD7dzjvGc5eD0ToMLnuYbFDF+SFzSJBWtcAerlH4ar/4yoyRKFt7s4DwFiooQfxx
        wPPZOYH2h2Jfjh0P4s3bKZWTiMTE7FOxM+D9fA8R52I1jP3BkXGBXjloZw3B/cmwop2HTR
        E0ACz1oI4L/ZGvF/jUUIUf05pEw75bDHHHcmz3Sh/QYec+0lEGgIvy/GZh9Au5mSVkyP6e
        XeX6iFcunk0H1XYRp+arbUp7Lh+NephRtMJ0mrbNOGFD0ZX+w4SSZ+4Ddr4Cu36iH8JYOz
        D4m5ArGl3dj7Fv/DEtnompRfh5PlN7rebEJPi0fXhrbudw00j+YvM704CGrX5g==
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
Date:   Fri, 20 May 2022 17:23:35 +0200
Message-Id: <20220520152335.352537-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520152335.352537-1-herve.codina@bootlin.com>
References: <20220520152335.352537-1-herve.codina@bootlin.com>
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
index 7d2869648050..8313e71ecc37 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -211,6 +211,17 @@ can0: can@e081c000 {
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
 		gpio: pinctrl@e2004064 {
 			compatible = "microchip,lan966x-pinctrl";
 			reg = <0xe2004064 0xb4>,
-- 
2.35.1

