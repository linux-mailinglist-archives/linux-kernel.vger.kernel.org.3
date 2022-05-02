Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCD517A27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386204AbiEBWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbiEBWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD4E094;
        Mon,  2 May 2022 15:41:39 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2739D22259;
        Tue,  3 May 2022 00:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vzO+oKgDSaVbLDInS6cU89cYjO6q21VAAN84a2Gs6g=;
        b=Y6pQuvWFMv6MdMUlm5rWGSFtakp4S7olxxV3Obe8YwNEaYkeChYQ9MffIaTL1SVqwa9hEF
        Q+VFC8nEontE9UgcRdMZ6AzufLLmMAVp39/HcBEFtau7+tah9hJy+a20Wmz3QtNEMFtbge
        Vglf+qEaL2cEidblISE8kbb8iQQDUW4=
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
Subject: [PATCH v4 10/13] ARM: dts: lan966x: add reset switch reset node
Date:   Tue,  3 May 2022 00:41:24 +0200
Message-Id: <20220502224127.2604333-11-michael@walle.cc>
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

Add the switch reset node which will later be used by the switch driver.
The switch reset also resets the GPIO controller and the SGPIO
controller, thus it also has to be connectected to these nodes. This way
the reset will only issued once for the first device requesting the
reset.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 0442735910da..7020b31322d8 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -391,6 +391,11 @@ watchdog: watchdog@e0090000 {
 			status = "disabled";
 		};
 
+		cpu_ctrl: syscon@e00c0000 {
+			compatible = "microchip,lan966x-cpu-syscon", "syscon";
+			reg = <0xe00c0000 0x350>;
+		};
+
 		can0: can@e081c000 {
 			compatible = "bosch,m_can";
 			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
@@ -406,10 +411,20 @@ can0: can@e081c000 {
 			status = "disabled";
 		};
 
+		reset: reset-controller@e200400c {
+			compatible = "microchip,lan966x-switch-reset";
+			reg = <0xe200400c 0x4>;
+			reg-names = "gcb";
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
+		};
+
 		gpio: pinctrl@e2004064 {
 			compatible = "microchip,lan966x-pinctrl";
 			reg = <0xe2004064 0xb4>,
 			    <0xe2010024 0x138>;
+			resets = <&reset 0>;
+			reset-names = "switch";
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&gpio 0 0 78>;
@@ -453,6 +468,8 @@ sgpio: gpio@e2004190 {
 			compatible = "microchip,sparx5-sgpio";
 			reg = <0xe2004190 0x118>;
 			clocks = <&sys_clk>;
+			resets = <&reset 0>;
+			reset-names = "switch";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.30.2

