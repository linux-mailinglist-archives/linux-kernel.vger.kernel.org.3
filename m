Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220E4ECD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350727AbiC3TTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350698AbiC3TRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:17:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020640909
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:15:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so629650pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf3wWTmjziJMOn16oc1W5zoqBMd/yr5SzLsh5YHyWfk=;
        b=IX6V4gdxfijYJqMCadFv+aJfDMmFLSXeJx7ipJCXLcZhq4CWasu4Bub7D9ivmpJFXJ
         jpw/Zomrus+iSuhgMfAUr6tVNUZMrenvQKC6TvR3ps/EY2Ezms87PcwgmiwZSt56B2Um
         NdIn8fPfitVAuXOEVXA5nHwH4VbjjQW49wndY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf3wWTmjziJMOn16oc1W5zoqBMd/yr5SzLsh5YHyWfk=;
        b=WkFarj2koVNKtGyf7d4yK9z55/Po4aeAvAWSDByOc7W2bxAPrCc9VEshiS9Inu+48N
         6zey9eGPuxEGzM6WC/qOpeX4S/PaoNG+N/EOj53BBVAIx1cp+WA8uWDiWLJSPOVM/G+6
         p26xzgY9oMdodJbBToVVT29WQLzLmDDG+lkV+G9sTshb1gX/B03IOHMENSvx/sRMgoQH
         urtbSJl2ZR25KTmWy8kn7o7eucfaySbjVRgo3wgG3TQGy8o6iPQYZfvQ+Qckw8QstxPw
         pDZbIhByOeZPBcRS3uPK5yK8ItcMhVMy2QURXcCQ6SytH8EWN6KBW35h57r+hcUVVzwk
         1ReQ==
X-Gm-Message-State: AOAM530O5+1gI7TM5Gry1GqEgKtLUhiFKoWEdvAOfnmDiVEMtj+iPdEC
        175QZt0pqCZJF2IQTuc5GlpCUw==
X-Google-Smtp-Source: ABdhPJyCkoULiybe0p+o2nj8kK/d2psOLEZwTWyLeLzhf23vZtIxdCNN5tXzKWIRb3TL7mJqK+5wFg==
X-Received: by 2002:a17:90b:3a84:b0:1c7:bc91:a870 with SMTP id om4-20020a17090b3a8400b001c7bc91a870mr1192429pjb.155.1648667720346;
        Wed, 30 Mar 2022 12:15:20 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm2955451pjb.25.2022.03.30.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:15:19 -0700 (PDT)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH 3/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
Date:   Thu, 31 Mar 2022 00:44:37 +0530
Message-Id: <20220330191437.614065-4-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330191437.614065-1-abbaraju.manojsai@amarulasolutions.com>
References: <20220330191437.614065-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board.

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Plus PCIe
- MIPI CSI
- 2x CAN
- Audio Out

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.

i.Core MX8M Plus needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 176 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 7f51b537df40..66985eae4942 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -77,6 +77,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
new file mode 100644
index 000000000000..e0667299388a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+#include "imx8mp-icore-mx8mp.dtsi"
+#include <dt-bindings/usb/pd.h>
+
+/ {
+	model = "Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit";
+	compatible = "engicam,icore-mx8mp-edimm2.2", "engicam,icore-mx8mp",
+		     "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	reg_usb1_host_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_vbus>;
+		regulator-name = "usb1_host_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+/* Ethernet */
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,led-mode = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x19
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x49
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
+		>;
+	};
+
+	pinctrl_reg_usb1_vbus: usb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grp-gpio {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+};
+
+/* console */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SDCARD */
+&usdhc2 {
+	pinctrl-names = "default" ;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
-- 
2.25.1

