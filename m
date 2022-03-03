Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FE4CC229
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiCCQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiCCQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:04:26 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EA15DDDB;
        Thu,  3 Mar 2022 08:03:40 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 12757223EF;
        Thu,  3 Mar 2022 17:03:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646323419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EPUuD0gT2UnTi7nbEdSvISQThsVfNgCE2QHLS2TQEo=;
        b=LHdq38nKonSoGipiSnkOwbOLc81hbbgQBZJGqcimN7Ad/gYSZlmnyCX4uYJQjc3HAhVH22
        tgnIttnEWLW4H86Rt6Rr95lU2LTjbcgCg/g2P1gYcEcMUCX3XdLiUB6UDovVCiKT/QHUOT
        5P5MBROmIudL03StmmlvzLt4dwJFpp4=
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
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
Date:   Thu,  3 Mar 2022 17:03:20 +0100
Message-Id: <20220303160323.3316317-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303160323.3316317-1-michael@walle.cc>
References: <20220303160323.3316317-1-michael@walle.cc>
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

Add all the usart nodes for the flexcom block. There was already
an usart node for the flexcom3 block. But it missed the DMA
channels. Although the DMA channels are specified, DMA is not
enabled by default because break detection doesn't work with DMA.

Keep the nodes disabled by default.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index a7d46a2ca058..bea69b6d2749 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -92,6 +92,19 @@ flx0: flexcom@e0040000 {
 			#size-cells = <1>;
 			ranges = <0x0 0xe0040000 0x800>;
 			status = "disabled";
+
+			usart0: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(3)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
 		};
 
 		flx1: flexcom@e0044000 {
@@ -102,6 +115,19 @@ flx1: flexcom@e0044000 {
 			#size-cells = <1>;
 			ranges = <0x0 0xe0044000 0x800>;
 			status = "disabled";
+
+			usart1: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(5)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(4)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
 		};
 
 		trng: rng@e0048000 {
@@ -129,6 +155,19 @@ flx2: flexcom@e0060000 {
 			#size-cells = <1>;
 			ranges = <0x0 0xe0060000 0x800>;
 			status = "disabled";
+
+			usart2: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(7)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
 		};
 
 		flx3: flexcom@e0064000 {
@@ -144,6 +183,9 @@ usart3: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
 				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(9)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
 				clocks = <&nic_clk>;
 				clock-names = "usart";
 				atmel,fifo-size = <32>;
@@ -178,6 +220,19 @@ flx4: flexcom@e0070000 {
 			#size-cells = <1>;
 			ranges = <0x0 0xe0070000 0x800>;
 			status = "disabled";
+
+			usart4: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(11)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(10)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
 		};
 
 		timer0: timer@e008c000 {
-- 
2.30.2

