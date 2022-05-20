Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B252EB27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348728AbiETLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348700AbiETLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:52:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC69286D4;
        Fri, 20 May 2022 04:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7yGtQiXD8Di4XgHWb8hJqOs8LnE3i5YXVtZiCqv2alvw+z9PwDIxd1y0KoHK+uNSzY3JkMV2I9OdfcMP++BgP4QT5i73cGs1OlQc1bgQf5C0c/ncqYgeIuURqHWQ5yQfL8kclWGLsNtQbLVefjODJ6Db7JA/4LfKaoc592dn/tkkjjREcWOfn/4bHCV+/m0/vXapUOIv6jz8uCc+YGUPtz8LSmNNqBC9Ni8S0hOvIpq42qTvVxpLGrumrduon+n3OleicZ9So8228pQmYsAmzKOEES9VL3sb0bhgnP3k7XjfyHNnOHN3hSzkPX9diZXqdyk4+sGpd1ZgDxiA7o8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vngeJfDzPkzgLuGUkxaqvjwv+JoXsWk292010NmNIck=;
 b=TKDoWEGAem1ireik67eCWNzud8BGpBe/bDgF5q/QwO6T82b0AXhszaIg4SwSmp72WGsBaJq6jT7xpIejODJ30OTPN+vKyAApPzRGvCLpeKFBnHl1DowCbstBu8+mTj7ZZ0cux8v6/yPr9ulbLPUxiM57u7jbErt8SViEDAiTSRyN98iJa3CMPkkZALOvdDXzfadefVIaOWyM8VnNvK/8HsRra1nwpkTvnfTGjv9TMX4g2fOBcwcFMO5qVCXOQM754bBjBeGBR6BmDas49IIq8ce6/n1lqY8VNPVZE2HWY2L4rX3bGU8ODzN9KikpyOUR+km5489W8oCahz2Caloleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vngeJfDzPkzgLuGUkxaqvjwv+JoXsWk292010NmNIck=;
 b=ZHiXXtXi7MV81q4SAzF/oLgLNzRgx9G/XD5VByGntqs0qD1ceaXcfVvg163maafUJz64Mj3G/U8GI4tLWwTzYXQ5YqhiN+AHhQpxH+CYTd9LR2UR2ZXcuvkpUPkwh99K2f2LnAen7Sg26SPYcI4/g8ey1BOQUnLwCmWFV4wCnQ1Zm5nCCK3OItJrrIQausrYW0kFfvZssmcVaCXv0iIf6u87i8jG5gWurPhdG/X0poEfbcCOCvf/ek97qH9oBDJn2/QWp/at3DtflgO9Skoi9+34+IyUlwgs7tjKx0gZuDt/BsLt+SX0pM6J7TnzXy+lzSe3503pLoavajz46zeWpA==
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 CH2PR02MB6806.namprd02.prod.outlook.com (2603:10b6:610:aa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 11:52:00 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Fri, 20 May 2022 11:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.160) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 11:51:59 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 May 2022 06:51:58 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 20 May 2022 06:51:56 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <David_Wang6097@jabil.com>
Subject: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Date:   Fri, 20 May 2022 19:51:48 +0800
Message-ID: <20220520115148.3589628-1-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b5c2e5-1953-49af-63dd-08da3a5725f7
X-MS-TrafficTypeDiagnostic: CH2PR02MB6806:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6806D035142FF3620172A837EFD39@CH2PR02MB6806.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3wqysRZqZlqquGMR/kGv+D+R92R+3yZwaSLgGKhMoCzPcQ6O7uqT330aGpzeO3Fcm2Og6uH2phJkUrBO0H6YCCtRiBJDOPGm8H3HZ1QR3oDiQ3XemVJuOR4zKlZ18pLzUApWz7IUSbC1rGt1/j+7JL6ObHFzQ3SNZ7RR+svb9nSjoV81x7rnR2FdciCySVn+wm2RCA0z2j1sAyd/hhYiqpwHcdFvPNK9fl6wdLo6mYuT/0i8chug4mBWwkDfe1AtrjBBECANgGIS1PRUZSxazEZQ5mYA/n7spq+aZwe2xo5p2dEyWoSjUPZ1e7/RDdEmWTVZDvgFQotLMZPnJnrShzb2Ea+oC5U0Ky9W6n23Ra7lonEKxa5yPw13IUc7xuttlgoWOEloaBnelHGvNfy6ncZ9rkbZ5nOkm8oMvKZe3FOzVu0PE4H1p6iAaIeApIcnj9SAivTehCk3xd7E9bwW8M7RznGvtUFH2qqYOIjWd5ITiS/xQsBz12wBffL71xl8pQzHw84B+B1fp+GGQLiDS3Wkomn62xOIO5UVOaQK5yz9hCDBxoSsbhw3unctkNRtejCVvyfTZSvmuZcqFbvPJxsEAAClRZmI1JjuLYN3uV62wxPWBPbn3w8EbGwtCeGEQLVVO8FXq1ATFgcpYiMlHrvm1BQhEflsOb3lul9NVv57xP2RTIe7RSYI3H9lxnjXmNJlG0w10ts3qPDNf7MuA==
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82960400001)(5660300002)(40460700003)(8936002)(30864003)(356005)(81166007)(86362001)(2906002)(36860700001)(54906003)(110136005)(8676002)(26005)(316002)(186003)(107886003)(36756003)(1076003)(508600001)(2616005)(82310400005)(6666004)(70206006)(70586007)(4326008)(83380400001)(47076005)(336012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 11:51:59.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5c2e5-1953-49af-63dd-08da3a5725f7
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial introduction of the jabil server with AST2600 BMC SoC.

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 arch/arm/boot/dts/Makefile                    |   3 +-
 .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 479 ++++++++++++++++++
 2 files changed, 481 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..9c395178fc89 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1566,4 +1566,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-tyan-s8036.dtb \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
-	aspeed-bmc-vegman-sx20.dtb
+	aspeed-bmc-vegman-sx20.dtb \
+	aspeed-bmc-jabil-rubypass.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
new file mode 100644
index 000000000000..77418895705a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Jabil rbp";
+	compatible = "jabil,rbp", "aspeed,ast2600";
+
+	chosen {
+		bootargs = "console=ttyS4,115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	vcc_sdhci0: regulator-vcc-sdhci0 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHCI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+
+	vccq_sdhci0: regulator-vccq-sdhci0 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHCI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
+
+	vcc_sdhci1: regulator-vcc-sdhci1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHCI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhci1: regulator-vccq-sdhci1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHCI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
+
+	leds {
+				compatible = "gpio-leds";
+
+				identify {
+						default-state = "off";
+						gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
+				};
+
+				status_amber {
+						default-state = "off";
+						gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
+				};
+
+				status_green {
+						default-state = "keep";
+						gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
+				};
+
+				status_susack {
+						default-state = "off";
+						gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+				};
+
+				fan1_fault{
+						default-state = "off";
+						gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
+				};
+				fan2_fault{
+						default-state = "off";
+		};
+				fan3_fault{
+						default-state = "off";
+						gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
+				};
+				fan4_fault{
+						default-state = "off";
+						gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
+				};
+				fan5_fault{
+						default-state = "off";
+						gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
+				};
+				fan6_fault{
+						default-state = "off";
+						gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
+				};
+
+				power_amber {
+						default-state = "off";
+						gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
+				};
+		};
+};
+
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio1 {
+	status = "okay";
+
+	ethphy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio2 {
+	status = "okay";
+
+	ethphy2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+
+&mac1 {
+	status = "okay";
+
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default>;
+};
+
+&mac2 {
+	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
+};
+
+&mac3 {
+	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	non-removable;
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	clk-phase-mmc-hs200 = <9>, <225>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+	};
+};
+
+&uart1 {
+		status = "okay";
+		pinctrl-0 = <&pinctrl_txd1_default
+					&pinctrl_rxd1_default
+					&pinctrl_nrts1_default
+					&pinctrl_ndtr1_default
+					&pinctrl_ndsr1_default
+					&pinctrl_ncts1_default
+					&pinctrl_ndcd1_default
+					&pinctrl_nri1_default>;
+};
+
+&uart2 {
+		status = "okay";
+		pinctrl-0 = <&pinctrl_txd2_default
+					&pinctrl_rxd2_default
+					&pinctrl_nrts2_default
+					&pinctrl_ndtr2_default
+					&pinctrl_ndsr2_default
+					&pinctrl_ncts2_default
+					&pinctrl_ndcd2_default
+					&pinctrl_nri2_default>;
+};
+
+&uart3 {
+		status = "okay";
+};
+
+&uart4 {
+		status = "okay";
+};
+
+
+&i2c0 {
+	status = "okay";
+
+	temp@2e {
+		compatible = "adi,adt7490";
+		reg = <0x2e>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	multi-master;
+	status = "okay";
+
+	gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(O, 7) IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"presence-fan1-n", "presence-fan2-n", "presence-fan3-n", "presence-fan4-n",
+			"presence-fan5-n", "presence-fan6-n", "", "";
+	};
+
+	gpio3_71:gpio@71 {
+		compatible = "nxp,pca9538";
+		reg = <0x71>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"led-fan1-fault", "led-fan2-fault", "led-fan3-fault", "led-fan4-fault",
+			"led-fan5-fault", "led-fan6-fault", "", "";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&fsim0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&sdc {
+	status = "okay";
+};
+
+/*
+ * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
+ * toggled by GPIO pins.
+ * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
+ * power load switch that provides 3.3v to sdhci0 vdd, GPIOV1 is connected to
+ * a 1.8v and a 3.3v power load switch that provides signal voltage to
+ * sdhci0 bus.
+ * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
+ * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
+ * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
+ * sdhci0 signal voltage becomes 1.8v.
+ * AST2600-A2 EVB also supports toggling signal voltage for sdhci1.
+ * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
+ * as power-switch-gpio.
+ */
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	sdhci-caps-mask = <0x7 0x0>;
+	sdhci,wp-inverted;
+	vmmc-supply = <&vcc_sdhci0>;
+	vqmmc-supply = <&vccq_sdhci0>;
+	clk-phase-sd-hs = <7>, <200>;
+};
+
+&sdhci1 {
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	sdhci-caps-mask = <0x7 0x0>;
+	sdhci,wp-inverted;
+	vmmc-supply = <&vcc_sdhci1>;
+	vqmmc-supply = <&vccq_sdhci1>;
+	clk-phase-sd-hs = <7>, <200>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&gpio0 {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/       "","","","","","","","",
+	/*B0-B7*/       "presence-ncsi-i210-n","","","","","","","led-identify-n",
+	/*C0-C7*/       "","","","","","","","",
+	/*D0-D7*/       "","","","","","","","",
+	/*E0-E7*/       "","","","","","","","",
+	/*F0-F7*/       "","","","","","","id-button","",
+	/*G0-G7*/       "","","led-status-green-n","led-status-amber-n","","","","",
+	/*H0-H7*/       "","","","","","cpu-caterr","","cpu1-caterr-n",
+	/*I0-I7*/       "","","","","","","","",
+	/*J0-J7*/       "","","","","","","","",
+	/*K0-K7*/       "","","","","","","","",
+	/*L0-L7*/       "","","","","","","","",
+	/*M0-M7*/       "","","","","","","","",
+	/*N0-N7*/       "","","","","","","","",
+	/*O0-O7*/       "","","","","","","nmi-button","",
+	/*P0-P7*/       "reset-button","reset-out","power-button","power-out","","","","led-hartbeat-n",
+	/*Q0-Q7*/       "","","","","","","","",
+	/*R0-R7*/       "","","","","","","","",
+	/*S0-S7*/       "","","","","","","","",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","","","","","","",
+	/*V0-V7*/       "regulator-vcc-sdhci0","regulator-vccq-sdhci0","regulator-vcc-sdhci1","regulator-vccq-sdhci1","sio-power-good","led-bmc-fw-config-done-n","","",
+	/*W0-W7*/       "","","","","","","","",
+	/*X0-X7*/       "cpu-err2","","","","","","","",
+	/*Y0-Y7*/       "led-power-amber","","","","","","","",
+	/*Z0-Z7*/       "cpu-err0","cpu-err1","","","","","","";
+	};
+
+&gpio1 {
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xCA2>;
+	status = "okay";
+};
+
+&kcs4 {
+	aspeed,lpc-io-reg = <0xCA4>;
+	status = "okay";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+	status = "okay";
+};
+
-- 
2.30.2

