Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78C0572F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiGMHrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiGMHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:41 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1BE5DD4;
        Wed, 13 Jul 2022 00:47:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 197EFC01D6;
        Wed, 13 Jul 2022 09:41:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698103; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=vD5IlybfnBFE7MfUHtq9HkeARrD9dbK3fsEI82fvNNc=;
        b=XwxpQ0f0zFrmFi+ZQOtWyRd82UBlK2whxnc/f7mMrVYq+g+gkl/5QWTxyBRbvjwUtFdhSE
        pQX5VKRfrO3f5TwX88p8Ij1I6i+Hp1gg3pp3AqUZnK85yfUgso9mP6IbV7GSjMCGRWxma/
        W8S71WGDiDvrGOxDbcpbKSZRd4NSMT4BWv7i+/2HFd0RydU0iPZ+6VHUo3cLcSvazniiCg
        NtAdoWksQ5FYsWDab4aspiXda7DTge6E6vOFE3+WXtwaaeGiMCb5hTUMUOBY8MG1Zr5SDq
        T4yDa4ioIIdmQI7rMgqI/uH36A+An3xmOoQvS56elr5Lo85dBMM5b1h5f45AqQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/6] arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card IO voltage
Date:   Wed, 13 Jul 2022 09:41:13 +0200
Message-Id: <20220713074118.14733-3-frieder@fris.de>
In-Reply-To: <20220713074118.14733-1-frieder@fris.de>
References: <20220713074118.14733-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

It turns out that it is not necessary to declare the VSELECT signal as
GPIO and let the PMIC driver set it to a fixed high level. This switches
the voltage between 3.3V and 1.8V by setting the PMIC register for LDO5
accordingly.

Instead we can do it like other boards already do and simply mux the
VSELECT signal of the USDHC interface to the pin. This makes sure that
the correct voltage is selected by setting the PMIC's SD_VSEL input
to high or low accordingly.

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 3 +++
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index cb8102bb8db5..bc46426ad8f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -321,6 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 
@@ -333,6 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 
@@ -345,6 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index b6d90d646a5f..77c074b491a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -86,7 +86,6 @@ pca9450: pmic@25 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -229,7 +228,6 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
-			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
 		>;
 	};
 
-- 
2.37.0

