Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F59517A29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiEBWqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357693AbiEBWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:11 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A60E0C2;
        Mon,  2 May 2022 15:41:40 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BA1532225D;
        Tue,  3 May 2022 00:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLWEvQ8H+N+3ves5MQiRM3TPUboBDqPSmRhE9EEJUOU=;
        b=WAxU/t/88HEbE3Q+VI5LbQcqn0mMy3+OUBscftabnkHQfSha+X9STuQjjPZ8KJvNUkKiZg
        AXmRQlcXzOaCZVESiO70BqkJXxI/VkW8EToF2AuhkB5RbpxdkcFYOyEs17ECLPga56Kxm5
        L9AhR78s3VucnnlqJB5NUlQ+VYRpKW4=
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
Subject: [PATCH v4 12/13] ARM: dts: lan966x: add switch node
Date:   Tue,  3 May 2022 00:41:26 +0200
Message-Id: <20220502224127.2604333-13-michael@walle.cc>
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

Add the switch node and its 8 children ports. All are disabled by default.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index d8185f5c7bfc..38e90a31d2dd 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -84,6 +84,68 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		switch: switch@e0000000 {
+			compatible = "microchip,lan966x-switch";
+			reg = <0xe0000000 0x0100000>,
+			      <0xe2000000 0x0800000>;
+			reg-names = "cpu", "gcb";
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "xtr", "fdma", "ana", "ptp",
+					  "ptp-ext";
+			resets = <&reset 0>;
+			reset-names = "switch";
+			status = "disabled";
+
+			ethernet-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+
+				port5: port@5 {
+					reg = <5>;
+					status = "disabled";
+				};
+
+				port6: port@6 {
+					reg = <6>;
+					status = "disabled";
+				};
+
+				port7: port@7 {
+					reg = <7>;
+					status = "disabled";
+				};
+			};
+		};
+
 		flx0: flexcom@e0040000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe0040000 0x100>;
-- 
2.30.2

