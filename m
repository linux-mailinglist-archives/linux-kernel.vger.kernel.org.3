Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F9539F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiFAIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350438AbiFAIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:09:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2096.outbound.protection.outlook.com [40.107.92.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1D1C11C;
        Wed,  1 Jun 2022 01:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNDD8E/ODT7EAXbTKtadv8yrdH33+F1msLsHNZaFikrvjciMbxTATUrzVhGBMM6AhPWKuaCWFmQfeT5pAmB3S6IHlrQ10OBCjTy0186qCiWbTmoz06vQkzsNiD7rCLSihVWKpGxSBRRIEi94s1hWr1Lqxbb5Y1NqGfBSIadKztsAkjAamHYlE3katRFVdOUSP01fOT/eIODEEmkIK2Ryypx3TPjpFpuMca0llrq0tdJ2RvDAz9/H3xMkYAC3qfxWVx/1Ttn0K5G/7PGMK8bVnmdxAX9Sm2PqewgAlSlcisxNVaVFByHKrSPzSrzJm2OZX29cGNFa2Te1layhCPzhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TVwymzelNr75EUroJFYmhhmcm/lH+cSt4lkunOpZls=;
 b=EDRhCYFRY5Ak1msA3MDF9/WXvTc1ZfDUuiCIVTBGJFlehKpOld2kSmzaPQgFVbk8pjMMaC4am/GwqVpOauu7XRtW/1IGr/+3bq+2jPyMaB09yyPXy9XyV2a3W9grbkNSwy+lwxhJ9gLBE0aU5eLmN5fLHoXjowwhjNO60yMTusjYPlhjAm/RPAgmTvyR3MjQdB29Jn2pJEZcKwL5QoEWrAFEBsDYcvZpet2BEIpNgwRTKNx6HiSftv4dMdr3mJb7qn1LOAzSFPpSekMUZPAQr8DlluEfx3rJpQEGIbuA+95L2qgv1dFtd2w7UPmWq0EjkifdzL89JvVXgan4lNwXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TVwymzelNr75EUroJFYmhhmcm/lH+cSt4lkunOpZls=;
 b=DVpGsejpEHoBADVpB3ZwCNN6x9awR/fVYy+kBRZqWxvfeW0RpGiuEj1NlO379cmg8NHWTpDKccJ8TnYv32Jf8A9K1ZRj4l//3Cw2Dq8Gepotis3fOaNb/tIW2Ip0MfLR7fwNKDvCxUCTE0g3rX9vNgdIot5M9BJ44y9mxPg1Bpn4aT5b0Nwsni7sjkyAxTDPSAf3eP47AGJrz4oaCESO410TEYmmPtcYaRVlEQXfTu8OlOJeYXC+RcxBigiYaBmdiKMtOKksMOcJvEnlgdS8C3p2F53XW9GyyXMjLXwWHVEUI98q3vTYsT4vK1mYKrVakepAaMAIvj+482s0xcRzoA==
Received: from DS7PR03CA0278.namprd03.prod.outlook.com (2603:10b6:5:3ad::13)
 by CH2PR02MB7014.namprd02.prod.outlook.com (2603:10b6:610:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 08:09:16 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::83) by DS7PR03CA0278.outlook.office365.com
 (2603:10b6:5:3ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 08:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.161)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.161; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.161) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 08:09:16 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB02.corp.JABIL.ORG (10.10.47.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Jun 2022 03:09:01 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 1 Jun 2022 03:09:00 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH 1/3] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Date:   Wed, 1 Jun 2022 16:08:54 +0800
Message-ID: <20220601080856.1548851-1-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 387d52ea-7d3d-4ba4-42ff-08da43a60570
X-MS-TrafficTypeDiagnostic: CH2PR02MB7014:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB70146E0294845A0752A10F15EFDF9@CH2PR02MB7014.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZAi/2+goEoVQFKm9ZJLfOnP5ZduSrhucRUZQ0Ji2YLwyQVq1vGQJJU6iC7pIKDKZtXHFCzQf7LyZiJG0Iov/1AdslKAn33eIqARCqr+hLa3/MDQx132agLNs34zJEp8f5nOquQHIO0ILt4dHykxl0//QGenAwilLkRKZr+sO3IcNu6ggDLQ+V73KTTJ7tNd4bBb/v/W/U3s1UGevQ39dM2xtSVY3ZrJBQgxnssc6YMWW/xQPOAKEWG2kFMK//zpFegNsD9AWGTkEj00dIqo8YLsfXYzKaGXbgvQnukdKuHI2YXISqDtqqGYKktyDj5E2NYFo+s6N9Lq+Mvxa3TWiXHrw5bcsMh5NgGPvMwGOjRLV+/jPYLstVJFbgsT+lhnhQJQMpjHI0+Nx7hnPkuSXoiaBRq8gfLNh/J2NTgE1ULkCfNbfPdKDuRsFY9cWyal5jZLQVz7VGCUPg8MS2ZW5GDv24RiYfO8m/hi8TcBGxRn9ije1TpvSYni+yuOZKYc0CKXzYDeDzailbKInG78ynPqKFJMky97/2R1WCqPYDXhz/YoLohL5yd/YPxa5TDImceVrLqyuFeYQd3mHvapRkHroLNhESGDpBicVq59Wp60UaL55gYl7ll43xOGdAN5YfFJkWwt4dgA1xnE6Dk8mLGlWJpPQuzKB8ZoVr1Le9cC4VaUJupLcu9IhHVX6vOw5PTWxqXUTOfw4AZmiOOBtw==
X-Forefront-Antispam-Report: CIP:8.14.198.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(45080400002)(4326008)(5660300002)(70206006)(70586007)(86362001)(186003)(40460700003)(316002)(508600001)(8676002)(8936002)(1076003)(26005)(82310400005)(36860700001)(356005)(82960400001)(81166007)(30864003)(2616005)(2906002)(6666004)(54906003)(47076005)(36756003)(110136005)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 08:09:16.0284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387d52ea-7d3d-4ba4-42ff-08da43a60570
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.161];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7014
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

---

v6
- Delete unneeded blank line at the end.

v5
- Compatible value chamged to "jabil,rbp-bmc".

v4
- Add document the new compatible.
- Delete redundant blank lines.
- Add a new line at end of file.

v3
- Adjustment entries are ordered by name.
- Remove the bootargs property and modify the stdout-path property.
- Group multiple LED devices into a group.
- Modify the "gpio3_71" node name format.
- Delete unneeded blank line at the end.

v2
- Disable empty i2c bus.
- Remove gfx node because aspeed-g6.dtsi isn't supported.
- Modify the led format and add some properties.
- Fix wrong indentation.
- Add stdout property in chosen node.
- Rename temp to temperature-sensor in i2c bus 0.

---

Signed-off-by: David Wang <David_Wang6097@jabil.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 442 ++++++++++++++++++
 2 files changed, 443 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..5339e9339ce4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1543,6 +1543,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
+	aspeed-bmc-jabil-rubypass.dtb \
 	aspeed-bmc-lenovo-hr630.dtb \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
new file mode 100644
index 000000000000..902be5fa15fd
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Jabil rbp";
+	compatible = "jabil,rbp-bmc", "aspeed,ast2600";
+
+	chosen {
+		stdout-path = "/uart5:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
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
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+
+		led-0 {
+			label = "identify";
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_INDICATOR;
+			retain-state-shutdown;
+			gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			label = "status_amber";
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			label = "status_green";
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "keep";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			label = "status_susack";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			label = "power-amber";
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			label = "fan1-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-6 {
+			label = "fan2-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-7 {
+			label = "fan3-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-8 {
+			label = "fan4-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-9 {
+			label = "fan5-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-10 {
+			label = "fan6-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
+		};
+	};
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
+	status = "okay";
+	pinctrl-0 = <&pinctrl_txd1_default
+			&pinctrl_rxd1_default
+			&pinctrl_nrts1_default
+			&pinctrl_ndtr1_default
+			&pinctrl_ndsr1_default
+			&pinctrl_ncts1_default
+			&pinctrl_ndcd1_default
+			&pinctrl_nri1_default>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_txd2_default
+			&pinctrl_rxd2_default
+			&pinctrl_nrts2_default
+			&pinctrl_ndtr2_default
+			&pinctrl_ndsr2_default
+			&pinctrl_ncts2_default
+			&pinctrl_ndcd2_default
+			&pinctrl_nri2_default>;
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	temperature-sensor@2e {
+		compatible = "adi,adt7490";
+		reg = <0x2e>;
+	};
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
+	gpio3_71: gpio@71 {
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
+	/*P0-P7*/       "reset-button","reset-out","power-button","power-out","","","",
+			"led-hartbeat-n",
+	/*Q0-Q7*/       "","","","","","","","",
+	/*R0-R7*/       "","","","","","","","",
+	/*S0-S7*/       "","","","","","","","",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","","","","","","",
+	/*V0-V7*/       "regulator-vcc-sdhci0","regulator-vccq-sdhci0","regulator-vcc-sdhci1",
+			"regulator-vccq-sdhci1","sio-power-good",
+			"led-bmc-fw-config-done-n","","",
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

-- 
2.30.2

