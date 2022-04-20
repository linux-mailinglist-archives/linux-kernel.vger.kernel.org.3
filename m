Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73B5090BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381863AbiDTTxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381837AbiDTTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:53:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049126AD4;
        Wed, 20 Apr 2022 12:50:31 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DDE1B2224F;
        Wed, 20 Apr 2022 21:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650484230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+2wbtmJ40mW8xdZ+umvLRALaNAAZ+oaK3bLtMXtcFQ=;
        b=bujfa3M4RcfhQ3zj3SJFhdkH6n8mqPlZdctJG4FAWaK5dF5gVaEtd2zs+hkqY5lggRbSyO
        +2u1YHvWlYgrEnEaLQOhAZeDkLXCDZfigt+jm6TIcFtgNIcTeghyDpcA94Szpm3T5L/H40
        /eqSC74KqHiuh1m9/y8ZxCmWv2Y1YYs=
From:   Michael Walle <michael@walle.cc>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/3] MIPS: mscc: ocelot: rename pinctrl nodes
Date:   Wed, 20 Apr 2022 21:50:17 +0200
Message-Id: <20220420195018.3417053-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195018.3417053-1-michael@walle.cc>
References: <20220420195018.3417053-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl device tree binding will be converted to YAML format. Rename
the pin nodes so they end with "-pins" to match the schema.

Signed-off-by: Michael Walle <michael@walle.cc>
---
The YAML conversion patch is alread in
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

 arch/mips/boot/dts/mscc/ocelot.dtsi       | 4 ++--
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index e51db651af13..cfc219a72bdd 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -225,7 +225,7 @@ uart2_pins: uart2-pins {
 				function = "uart2";
 			};
 
-			miim1: miim1 {
+			miim1_pins: miim1-pins {
 				pins = "GPIO_14", "GPIO_15";
 				function = "miim";
 			};
@@ -261,7 +261,7 @@ mdio1: mdio@10700c0 {
 			reg = <0x10700c0 0x24>;
 			interrupts = <15>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&miim1>;
+			pinctrl-0 = <&miim1_pins>;
 			status = "disabled";
 		};
 
diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
index bd240690cb37..d348742c233d 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
@@ -22,12 +22,12 @@ memory@0 {
 };
 
 &gpio {
-	phy_int_pins: phy_int_pins {
+	phy_int_pins: phy-int-pins {
 		pins = "GPIO_4";
 		function = "gpio";
 	};
 
-	phy_load_save_pins: phy_load_save_pins {
+	phy_load_save_pins: phy-load-save-pins {
 		pins = "GPIO_10";
 		function = "ptp2";
 	};
@@ -40,7 +40,7 @@ &mdio0 {
 &mdio1 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&miim1>, <&phy_int_pins>, <&phy_load_save_pins>;
+	pinctrl-0 = <&miim1_pins>, <&phy_int_pins>, <&phy_load_save_pins>;
 
 	phy7: ethernet-phy@0 {
 		reg = <0>;
-- 
2.30.2

