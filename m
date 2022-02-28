Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D714C6E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiB1N0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiB1N0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:26:13 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409542657E;
        Mon, 28 Feb 2022 05:25:34 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7E1A22223A;
        Mon, 28 Feb 2022 14:25:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646054732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=abmqdbBeNgx6suTFoI0RuzJ2gA54tHckW0E9a+phtN4=;
        b=GbAm5Gl/9TbdVh6xpsFmGKmHkQbCc1t1Wkk2gEA44/Osy3W+6A3Q5XNv2xSoeUSk+Ex1c9
        Gzs8mN5suVA4CQro1sFidtY0mo88t/gpbpNEKqcAcEt1lAD60d0gMG98MYX1JD8j6TwTc4
        gUhBtdyDwnCeMWJsce7cAaKPyxM7nOA=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: imx8mn-evk: add QSPI flash
Date:   Mon, 28 Feb 2022 14:25:23 +0100
Message-Id: <20220228132523.2679099-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

There is a 32MiB Micron MT25QU256ABA1 serial NOR flash on the EVK board.
Add a device tree node for it.

Tested on a 8MNANOD3L-EVK.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index c3f15192b76c..dc75d6d13bb3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -110,6 +110,22 @@ vddio: vddio-regulator {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <166000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -267,6 +283,17 @@ MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
 		>;
 	};
 
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
+			MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
+			MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
+			MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
+			MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
+			MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
-- 
2.30.2

