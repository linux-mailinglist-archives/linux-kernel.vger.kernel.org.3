Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821844CC22F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiCCQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiCCQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:04:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A58187B9C;
        Thu,  3 Mar 2022 08:03:41 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E47A3223F6;
        Thu,  3 Mar 2022 17:03:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646323420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOHb81f6UjTpy/o++osD43lpaRTuWZcu/2E7PE6CXxA=;
        b=abuUEQ/zGzluu5mT0ZzbVlfNgbdmEbU1+ftwK2a2CuMvWek5MqX7RGD3gKJbhydWzHmv0S
        DO2cf5V1DlYHeBfBRDJCRnKYetqf2ywawas5RqHrugybdeR2N1pVRxLbCiZ2AzGZzMhvck
        97FlmFBGObbciyYoaVm+FCYAxUnCgs8=
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
Subject: [PATCH v1 5/6] ARM: dts: lan966x: add flexcom I2C nodes
Date:   Thu,  3 Mar 2022 17:03:22 +0100
Message-Id: <20220303160323.3316317-6-michael@walle.cc>
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

Add all I2C nodes of the flexcom IP blocks. The driver supports
FIFO, DMA or both combined. But the latter isn't working correctly.
Thus, skip the fifo-size property for now. DMA is doing single byte
reads in this case.

Keep the nodes disabled by default.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 0616927f1bb1..c4aab7f65790 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -120,6 +120,19 @@ spi0: spi@400 {
 				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
+
+			i2c0: i2c@600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(3)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				status = "disabled";
+			};
 		};
 
 		flx1: flexcom@e0044000 {
@@ -158,6 +171,19 @@ spi1: spi@400 {
 				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
+
+			i2c1: i2c@600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(5)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(4)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				status = "disabled";
+			};
 		};
 
 		trng: rng@e0048000 {
@@ -213,6 +239,19 @@ spi2: spi@400 {
 				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
+
+			i2c2: i2c@600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(7)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				status = "disabled";
+			};
 		};
 
 		flx3: flexcom@e0064000 {
@@ -251,6 +290,19 @@ spi3: spi@400 {
 				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
+
+			i2c3: i2c@600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(9)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				status = "disabled";
+			};
 		};
 
 		dma0: dma-controller@e0068000 {
@@ -308,6 +360,19 @@ spi4: spi@400 {
 				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
+
+			i2c4: i2c@600 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(11)>,
+					   <&dma0 AT91_XDMAC_DT_PERID(10)>;
+				dma-names = "tx", "rx";
+				clocks = <&nic_clk>;
+				status = "disabled";
+			};
 		};
 
 		timer0: timer@e008c000 {
-- 
2.30.2

