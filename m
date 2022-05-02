Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D5517A28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiEBWqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376784AbiEBWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:14 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DBFD20;
        Mon,  2 May 2022 15:41:41 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 63DAB22260;
        Tue,  3 May 2022 00:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quewXMLWRGuNF9x++PYzltF9q3n3loXTwHKkv1bRl80=;
        b=S6XX6MD6Qfd5FP38C5rYyyDzh+gBnoUBB5GRQDCtLOehVyQdtg74gt1KsU5d3tSIgVHhNd
        /azGu+C/VqbpJCLsZfQvajEB5tHixNAdqAlS9WC7+koMEeIQM16Sb4644ev+LVc8vLwkdB
        XPsp9rjhoEhH05Y/J34JJLJPdzh4H4E=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 13/13] ARM: dts: kswitch-d10: enable networking
Date:   Tue,  3 May 2022 00:41:27 +0200
Message-Id: <20220502224127.2604333-14-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502224127.2604333-1-michael@walle.cc>
References: <20220502224127.2604333-1-michael@walle.cc>
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

Enable all the necessary network related nodes, wire the pinctrl
configurations, add the PHYs and connect them to the corresponding
network ports.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts | 16 +++
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts    | 26 +++++
 .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 97 +++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
index 7b12cbe11c58..0f555eb45bda 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
@@ -76,3 +76,19 @@ fc4_b_pins: fc4-b-i2c-pins {
 		function = "fc4_b";
 	};
 };
+
+&port2 {
+	phys = <&serdes 2 SERDES6G(0)>;
+	sfp = <&sfp0>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&port3 {
+	phys = <&serdes 3 SERDES6G(1)>;
+	sfp = <&sfp1>;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
index 4b35f6c46e7f..5feef9a59a79 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
@@ -11,3 +11,29 @@ / {
 	compatible = "kontron,kswitch-d10-mmt-8g", "kontron,s1921",
 		     "microchip,lan9668", "microchip,lan966";
 };
+
+&mdio0 {
+	phy2: ethernet-phy@3 {
+		reg = <3>;
+	};
+
+	phy3: ethernet-phy@4 {
+		reg = <4>;
+	};
+};
+
+&port2 {
+	phys = <&serdes 2 SERDES6G(0)>;
+	phy-handle = <&phy2>;
+	phy-mode = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&port3 {
+	phys = <&serdes 3 SERDES6G(1)>;
+	phy-handle = <&phy3>;
+	phy-mode = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 4c1ebb4aa5b0..4cab1b3b3b29 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "lan966x.dtsi"
+#include "dt-bindings/phy/phy-lan966x-serdes.h"
 
 / {
 	aliases {
@@ -52,6 +53,12 @@ fc3_b_pins: fc3-b-pins {
 		function = "fc3_b";
 	};
 
+	miim_c_pins: miim-c-pins {
+		/* MDC, MDIO */
+		pins = "GPIO_59", "GPIO_60";
+		function = "miim_c";
+	};
+
 	sgpio_a_pins: sgpio-a-pins {
 		/* SCK, D0, D1 */
 		pins = "GPIO_32", "GPIO_33", "GPIO_34";
@@ -71,6 +78,92 @@ usart0_pins: usart0-pins {
 	};
 };
 
+&mdio0 {
+	pinctrl-0 = <&miim_c_pins>;
+	pinctrl-names = "default";
+	reset-gpios = <&gpio 29 GPIO_ACTIVE_LOW>;
+	clock-frequency = <2500000>;
+	status = "okay";
+
+	phy4: ethernet-phy@5 {
+		reg = <5>;
+		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+	};
+
+	phy5: ethernet-phy@6 {
+		reg = <6>;
+		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+	};
+
+	phy6: ethernet-phy@7 {
+		reg = <7>;
+		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+	};
+
+	phy7: ethernet-phy@8 {
+		reg = <8>;
+		coma-mode-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mdio1 {
+	status = "okay";
+};
+
+&phy0 {
+	status = "okay";
+};
+
+&phy1 {
+	status = "okay";
+};
+
+&port0 {
+	phys = <&serdes 0 CU(0)>;
+	phy-handle = <&phy0>;
+	phy-mode = "gmii";
+	status = "okay";
+};
+
+&port1 {
+	phys = <&serdes 1 CU(1)>;
+	phy-handle = <&phy1>;
+	phy-mode = "gmii";
+	status = "okay";
+};
+
+&port4 {
+	phys = <&serdes 4 SERDES6G(2)>;
+	phy-handle = <&phy4>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&port5 {
+	phys = <&serdes 5 SERDES6G(2)>;
+	phy-handle = <&phy5>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&port6 {
+	phys = <&serdes 6 SERDES6G(2)>;
+	phy-handle = <&phy6>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&port7 {
+	phys = <&serdes 7 SERDES6G(2)>;
+	phy-handle = <&phy7>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
 &sgpio {
 	pinctrl-0 = <&sgpio_a_pins>, <&sgpio_b_pins>;
 	pinctrl-names = "default";
@@ -88,6 +181,10 @@ sgpio_out: gpio@1 {
 	};
 };
 
+&switch {
+	status = "okay";
+};
+
 &watchdog {
 	status = "okay";
 };
-- 
2.30.2

