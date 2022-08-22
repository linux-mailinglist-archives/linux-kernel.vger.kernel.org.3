Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5059BAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiHVIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiHVIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:01:53 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604F2B19F;
        Mon, 22 Aug 2022 01:01:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05392C01B8;
        Mon, 22 Aug 2022 10:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155310; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Xyc3HeD/Wetg/6U2L3dZq0OudoqJsGiwjd9pgCHOEfw=;
        b=Et6pJqRCG7E1UVTxH8xhhD7/xz8qaLDjQvPnnAi3EAojwv0hUyklMEJpYiYCp5XV9+c3ym
        mR+01tuwuCbYy97lxfkigFiz3FKJQVRFrCuyUFhi1TFAZaA67FaANE1fRjH3QprfiP3XCK
        5Ka4BsGea0rEFXxLigrHeK5lElJU0TWzvklucE7Z6lc76nXHbXzKeH9JoiVKyGH4jQmiwZ
        aJ1o0Cdv6pMsXAdY0LOCa+/b/uJdYS35BSX8K95hm5Q/BvXjHAf4LkMeVj10i/kd+HKytq
        1lrjPQGGrLagI+LGj9/r83RGDn33xBpRQRtyKNkQ1zYMt1tQFonpYL4tKemNOQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 4/8] arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card IO voltage
Date:   Mon, 22 Aug 2022 10:00:57 +0200
Message-Id: <20220822080103.24016-5-frieder@fris.de>
In-Reply-To: <20220822080103.24016-1-frieder@fris.de>
References: <20220822080103.24016-1-frieder@fris.de>
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
Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>
---
Changes in v3:
* rebase on v6.0-rc1

Changes in v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts  | 3 +++
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index 4e5828fa815b..7af3c476fd9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
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
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 30299c2a98ea..33179157f619 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
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
2.37.1

