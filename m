Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360634F509C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842551AbiDFBco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457568AbiDEQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:51 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F1D265E;
        Tue,  5 Apr 2022 09:08:52 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A99672225B;
        Tue,  5 Apr 2022 18:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649174930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zWa7FnAehsT5VQr7sLCyyvpTKbFiugxFLtDfUCAJuI=;
        b=XunTJuQUxA29p74sdfOJKB1N2HvxSmZ0uPGck97xXobh1uOy3pi/IYKdu9N/gVf3ARji9B
        KsoYqS9YUv6tJqzpmpWWKIersCDxmIp+yuWq3lXHL8/bfeKbRKJ4cyUaUsklfF/rtYFdrC
        LEMI86uujTakJSp3WTJiDx4Y+cJaze4=
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
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 6/7] ARM: dts: lan966x: add flexcom I2C nodes
Date:   Tue,  5 Apr 2022 18:08:36 +0200
Message-Id: <20220405160837.4093563-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405160837.4093563-1-michael@walle.cc>
References: <20220405160837.4093563-1-michael@walle.cc>
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

Add all I2C nodes of the flexcom IP blocks. The driver supports
FIFO, DMA or both combined. But the latter isn't working correctly.
Thus, skip the fifo-size property for now. DMA is doing single byte
reads in this case.

Keep the nodes disabled by default.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index a37f2e58a1c2..342c8cee2b9a 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -120,6 +120,19 @@ spi0: spi@400 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c0: i2c@600 {
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(3)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		flx1: flexcom@e0044000 {
@@ -158,6 +171,19 @@ spi1: spi@400 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c1: i2c@600 {
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(5)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(4)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		trng: rng@e0048000 {
@@ -213,6 +239,19 @@ spi2: spi@400 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c2: i2c@600 {
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(7)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		flx3: flexcom@e0064000 {
@@ -251,6 +290,19 @@ spi3: spi@400 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c3: i2c@600 {
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(9)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		dma0: dma-controller@e0068000 {
@@ -308,6 +360,19 @@ spi4: spi@400 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c4: i2c@600 {
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(11)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(10)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		timer0: timer@e008c000 {
-- 
2.30.2

