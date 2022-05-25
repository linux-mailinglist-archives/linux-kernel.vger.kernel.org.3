Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAF5335E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiEYDme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEYDmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:42:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5F4F474;
        Tue, 24 May 2022 20:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKWI8cYvsnVsboE0PRkh46iyWpMmcMgTk5mkSSRsIFZAiKJwKGfLY4/LFndsAG8BJGmefM/rXgBZ9APDXORo4fPW3BJdBRehLCLmJhzZLGjX900m5kRLLwpwvHwtKeXAPKvSdpPrh2xYuRsM030iXBeHWCYTJLUCi8ivbg2+tgsCDxZLC5fqEgTjq26VaOkOe4ZBh94VMz+o1PDI90SdzdBgSvBoauUPqMfJh4E01mxiNUOI7k7D9s20dVIKhGNXaVnkCERTyhJEgQtuFYCOdH5Gm1Qm/WvbAk0SFteoHGMFWYNYBR2Mk6BPVbWkOnjKhiU0O7ivC6BRj8T1EnTwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsM5qatjLf19PeobT+q8kJX0LC9x6hG1Y/A3guGj6CY=;
 b=kps0kTNOZmu2hbBbdcJ40senUlP/gDl7zbII2VeOVDH4SQ4HoteyBKXfgIMqe0yjVTEhUX+SJgzjs6/lSRGicpeKwfgPfuGAGKsOA0j9ZukNrRdry8S0+QoBf0Ibx9XM/7Y4CM9WPXGmhIDzZcVjcBEgKaBGDaNHFoAKHc2KzW/ThR32OiOfEzuOcpIlj+bCOSVUNsIuujjLhttPHb5efXkeQsZk2S9gzIYRBxUEReNsLofh7Rbdx3HQoLqNWPmcBn/oTB1vtaOI+JJ6AyFP6m7ZHcyBSrtKT2nLBlLRXBmcaV5+fAFSJ9fXcAWTARpDwMz7HAMLzWqiuWxVVJPmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsM5qatjLf19PeobT+q8kJX0LC9x6hG1Y/A3guGj6CY=;
 b=AOrkYb/0VOz2tVo2zE/OT3+jrjRPuyhsqRr1zhAR3hxxL3DhgQT7OwazrmIvEl8SjHEvN1v3GRJK2zPr3IIgOmMweB+NAV1UOPSb8XwIYKxAXLWqhTLyD5NbuxpBO2ruEULq9CdHo9AIVn/fG7ytKhv1jZkBZxvIKXlcLrUohsN4MjOFRYGFx13aFIlE/AcbezwQ/TYsDCKRXWjGNd0GGRjDD+RlA1Iifr/2v3hCvBiBepN9M2S+QjL+1H8PYpLw3ldNopIgptqWgoLryLbPSSIyV/9uIBswnreKfyG2Vy1VP5xsUYndyPS6a/8cdnFQEYAPsIBpLgpDbkCI07QZJQ==
Received: from BN6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:404:121::18)
 by DM8PR02MB8262.namprd02.prod.outlook.com (2603:10b6:8:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Wed, 25 May 2022 03:42:28 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::24) by BN6PR18CA0008.outlook.office365.com
 (2603:10b6:404:121::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 03:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.160) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 03:42:27 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 May 2022 22:42:20 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 24 May 2022 22:42:19 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <ben_pai@jabil.com>,
        David Wang <David_Wang6097@jabil.com>
Subject: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Date:   Wed, 25 May 2022 11:42:11 +0800
Message-ID: <20220525034211.1402577-1-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66453616-4a66-422c-53ca-08da3e0096f4
X-MS-TrafficTypeDiagnostic: DM8PR02MB8262:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB826298C5654B041FFAF443ECEFD69@DM8PR02MB8262.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbbvYtUx3TMDKmCptrSQ5pLr5ZK1wqr5JgU9RrkKfl8W0txoTETDLlVR8YelqpW8AtD8XW+ndEUSUTZAZP6EtZdI+QGVI44YkqnBKbgiQ0S4bcgkdH36QqLlXB8Jfav2mrzBH26Lxh/fuc3Xktc/IJqa9g8AuD3kIt4eDrZ+TP1AG+raMPbkqxCNPwMc9kzJcaGjLLyfho+/nnPFKzlbfHJhQvfhNKfeIbS6RU9IISOI8arVrQZOjC1v7OiaiQCweRs/DCLqxfoOZ2Udwn4ZHiR4mbAUZEhGdoeNwlqLNWd1rfmqXiUzPVER74q39Wj8xeuNKg1XGPXae9TXjkannSoOrQ6XQlw15YbG97UACOak5n2F74tHP/d305egDEBtlpiXB+JgUJPGoNxyCWTaJzaa++apQWUWZm0bcsSShtG1A7lr+bjgNbDpIpBzm36f3bcSeqHQT2/B/gTAmNZuGpBqdyyASBVDaO8J6XI7tZ74Q6IiP9XtBgzzxmiJSYsXgEnvWH90LaK160pbz63Exkvm2wYPYwWeN7d7IaCjknS64MyyjXgvwhxSjCHB6s1WmkVGJ9n1C1/84BfAzzo8xkmiZfVKmDrR+3N94T7pKvZgPWdTzByUrl8kIb6gsodajIxksFQtIDaQb7Hcb+wZJa/V1KQLX4z7rR0l1VTt+op9u28WS+MozICoXkselxp1I4s9Fwk/jytLFwG7Z0e4+A==
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(8676002)(316002)(2906002)(47076005)(81166007)(186003)(54906003)(107886003)(1076003)(4326008)(36756003)(70206006)(82310400005)(110136005)(36860700001)(5660300002)(8936002)(30864003)(82960400001)(356005)(40460700003)(26005)(508600001)(2616005)(83380400001)(6666004)(336012)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 03:42:27.9081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66453616-4a66-422c-53ca-08da3e0096f4
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8262
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
 arch/arm/boot/dts/Makefile                    |   3 +-
 .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 449 ++++++++++++++++++
 2 files changed, 451 insertions(+), 1 deletion(-)
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
index 000000000000..0e1450f66372
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
@@ -0,0 +1,449 @@
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
+	compatible = "aspeed,ast2600";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8";
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
+		led-4{
+			label = "power-amber";
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	fan_fault {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+
+		led-0 {
+			label = "fan1-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			label = "fan2-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "fan3-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			label = "fan4-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "fan5-fault";
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_FAULT;
+			retain-state-shutdown;
+			gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-5 {
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
+					"led-hartbeat-n",
+	/*Q0-Q7*/       "","","","","","","","",
+	/*R0-R7*/       "","","","","","","","",
+	/*S0-S7*/       "","","","","","","","",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","","","","","","",
+	/*V0-V7*/       "regulator-vcc-sdhci0","regulator-vccq-sdhci0","regulator-vcc-sdhci1",
+					"regulator-vccq-sdhci1","sio-power-good",
+					"led-bmc-fw-config-done-n","","",
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

