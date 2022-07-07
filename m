Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052CD56A379
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiGGNZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiGGNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:25:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EB31361;
        Thu,  7 Jul 2022 06:25:08 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 814EC22248;
        Thu,  7 Jul 2022 15:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657200306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfVNhUaiKivo0ZTq1LnzNfkdUYyvDKnK+aAp1PrLvvg=;
        b=pnqNtZBCzcBWgRXo3iY/d2uLR1qZ/2SmpKnl/Fea/BBL079ibUmVQhZxGKbJF0xZuZACMy
        Wy3KHt2IdZyBim6IK7CSsWN6mMXI5vyCTDw+S60k41acOzemU9EIaj8b8sYCMjBn5zsj2L
        6cM2vMRFCGX8/fB0Y69wgZs5XNcXPNQ=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/2] ARM: dts: kswitch-d10: enable the USB device port
Date:   Thu,  7 Jul 2022 15:25:00 +0200
Message-Id: <20220707132500.1708020-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707132500.1708020-1-michael@walle.cc>
References: <20220707132500.1708020-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is driver support for the USB device, enable it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - add pinctrl node, Thanks Claudiu

 .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 5a6c5f7c371a..3eecaa1b7205 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -76,6 +76,12 @@ usart0_pins: usart0-pins {
 		pins = "GPIO_25", "GPIO_26";
 		function = "fc0_b";
 	};
+
+	usbs_a_pins: usbs-a-pins {
+		/* VBUS_DET */
+		pins = "GPIO_66";
+		function = "gpio";
+	};
 };
 
 &mdio0 {
@@ -200,6 +206,13 @@ &switch {
 	status = "okay";
 };
 
+&udc {
+	pinctrl-0 = <&usbs_a_pins>;
+	pinctrl-names = "default";
+	atmel,vbus-gpio = <&gpio 66 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &watchdog {
 	status = "okay";
 };
-- 
2.30.2

