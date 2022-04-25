Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0B50E221
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiDYNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiDYNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:46:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500E4990D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so27116483pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtYPSm9oSbFQeZNqnGUrjmQxFrmgVwpq2/2TKTH9v0g=;
        b=CBgFr/wnyUplKIpV5xPudpb2pioGRmJhYWlX0BOdZbeXaBowdPJ2J4EEnU9ZKd6L0t
         E+3Z4NoNSl+atR6nNJuRNWgigmEGKk5m/KV5boZHsLidfwNjMcVSjBy5MBJsiwb1aq8n
         yOeXV6LtFZpfJQ4pJ/Jo31iVGZKi+wyhvlBIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtYPSm9oSbFQeZNqnGUrjmQxFrmgVwpq2/2TKTH9v0g=;
        b=UpBeDr/zGPKxAyN4/so+VdsPoZdlOmKAdzWMc9pkXamyLO/UPn14dVH9ZjgflYZ1N8
         bJNxrRUWWyvu/JwmdkRkgEhqyMNNizY6tiXMuA9Azn3gO4bKIwhlyUSCD0jllXxeS2g7
         GOFF8wzXDO8durwLi+Qa6hlGhxyeGZhST/fNOXEBh+s2cne8t4YRpDorur7jhKKJq4ja
         gxUHuPZztWYNihGbChRunxqHvDW3U8R5cDxyT6XdprNiwoxPDoiRbJe+A/qZZ++W7qkz
         at7fF3V3QgMsH6Qla2XRJWxCfPnMDt31O+4AjKm+79VElm4QhLGrJgyiJ7C1rpl2bf/E
         ENow==
X-Gm-Message-State: AOAM531IgqQOqGl80jji9gSO+o9U6VmV8SY9fPTHku4Jy0JczNlSW3zf
        T5AexJf1VAJc4LYjlPoU/+f76Q==
X-Google-Smtp-Source: ABdhPJwOpH+a1ApL4mHFLGkW9mGC+YSayGydOQjH5FLMgzXEpKYfDGM4yksHaJyhNLd9TT0mSi+Skw==
X-Received: by 2002:a17:902:b696:b0:156:b63:6bed with SMTP id c22-20020a170902b69600b001560b636bedmr17732140pls.24.1650894178740;
        Mon, 25 Apr 2022 06:42:58 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b0039912d50806sm9810089pgf.87.2022.04.25.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:42:58 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus SoM
Date:   Mon, 25 Apr 2022 19:12:23 +0530
Message-Id: <20220425134224.368908-2-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
References: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
 <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus
from Engicam.

General features:
- NXP i.MX8M Plus
- Up to 4GB LDDR4
- 8 eMMC
- Gigabit Ethernet
- USB 3.0, 2.0 Host/OTG
- PCIe 3.0 interface
- I2S
- LVDS
- rest of i.MX8M Plus features

i.Core MX8M Plus needs to mount on top of Engicam baseboards
for creating complete platform solutions.

Add support for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3 :
  - added the newline between properties and child node .
  - modified the pmic node as per previous updations .
  - arranged the nodes and its properties as per alphabetical order .

Changes for v2 :
  - corrected the naming convetion of nodes as per existing
    sources and bindings
  - added the iomux to the end as per nxp convention.
---
 .../dts/freescale/imx8mp-icore-mx8mp.dtsi     | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi
new file mode 100644
index 000000000000..5116079cce22
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/ {
+	compatible = "engicam,icore-mx8mp", "fsl,imx8mp";
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pca9450: pmic@25 {
+		compatible = "nxp,pca9450c";
+		interrupt-parent = <&gpio3>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		reg = <0x25>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <720000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2  {
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1025000>;
+				regulator-min-microvolt = <720000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <3000000>;
+				regulator-name = "BUCK4";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1650000>;
+				regulator-name = "BUCK5";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1155000>;
+				regulator-min-microvolt = <1045000>;
+				regulator-name = "BUCK6";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1950000>;
+				regulator-min-microvolt = <1650000>;
+				regulator-name = "LDO1";
+			};
+
+			ldo3: LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1890000>;
+				regulator-min-microvolt = <1710000>;
+				regulator-name = "LDO3";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+};
+
+/* EMMC */
+&usdhc3 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	  0x41
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+		>;
+	};
+};
--
2.25.1
