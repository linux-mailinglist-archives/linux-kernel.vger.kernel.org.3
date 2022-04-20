Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A0508185
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiDTG6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbiDTG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:58:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5D34B9B;
        Tue, 19 Apr 2022 23:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdU2jw3PXIpIHCvpn1N/aJtItX3lvw7jF1/AIH7grxpyz4EuaZRaPPSrAuIBdZQetdV+bM5PdrDNdhXbExDjBD769VSxMl01Q6mcmLuTDl5NPPXpEyStJqCyLTSC25RG2Ce8/ac3ZahL8DX3fYgjww4z7qK5JsvVPnc4WQMsEygIzoygFmPEEp2GfVsZQlBoWjcAlkO8BnyBfVYBWwpi8OydMDiK5DNfNMA1UfUPzB6tESN3agkGHKO1WnvWqv0/NJqiN75koQWNKNkUoa5JvQp/dEto6yPyEepzOaJzE5UpcofRU/UmCYAfwJOSGG1Y0flXdA0ue3JIBfw4Jis9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Y630WwpncdXAE37EKAtpJf1SGlcI/VJCLYdmM22P4=;
 b=dINKPvP2Njexb5QDGg9wqZBiY0E9KMbJ20598p+RSULLp4K+y795H7W9iDkwp0mua5gvGXJDoc1liPWUQrjGySaOJsd5M+cdY/cXd8+1yWVkc/gKm3lmVxlmItkjUaV/bZxNUpIXRvrh++7S37kUSMll4tqVgzmHJc/pV3j0HNq4IS1Oh18g7ir0ZE5R12EE9UHKDdeP/+lPTkvav04BMqLHg65m/T14dAFT7lhmOr+DthMsSMuAGNpPu7iB8FQJNI+Cmx/im7onsmKTT2B5zrWBNoK9a94xavNJ2A+OCPgw1qGeHct6qjaD60gfqO5nXwzOQXgivPFZmJ5bf8roKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Y630WwpncdXAE37EKAtpJf1SGlcI/VJCLYdmM22P4=;
 b=AELtzfIHjYez9JAXxQ5A7mRQ5SvBn2ggPYJZTDl3e+BWvIQ1S2N9Aj46nUEjbBe+OR6uOfYvZ3/lN3ai/c/Zz0cMPt4ue4HzsW/4YmqXBDOqE1nkxRnDAV05LK8meO7uV5dj19r94MYLCRD7I701kiwp5OV6Vo+i8fslEheR/ArzPOS0xrXZMUnn89hvgS7P0zbnHiRQ+WZiVI+AXyD0NZUOpDfnwLTV2tiZFS8+8qys6rzYV1F09uFuQs0fmc5Zf7ig7FH3QBMAYKlavWNUSOA22VvqNNq7LPyhgdh9YTiU/QNVaej4Gjy0eCJ+5gQlLMOD0I1yg8Ik2suFtGotWQ==
Received: from BN9PR03CA0551.namprd03.prod.outlook.com (2603:10b6:408:138::16)
 by SN4PR0201MB3519.namprd02.prod.outlook.com (2603:10b6:803:49::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 06:55:50 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::ed) by BN9PR03CA0551.outlook.office365.com
 (2603:10b6:408:138::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 06:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com;
Received: from jabil.com (8.14.198.160) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 06:55:50 +0000
Received: from usplnd0hub02.corp.jabil.org (10.10.47.157) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 20 Apr 2022 01:55:43 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub02.corp.jabil.org (10.10.47.157) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 20 Apr 2022 01:55:41 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <joel@jms.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     David Wang <David_Wang6097@jabil.com>
Subject: [PATCH] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Date:   Wed, 20 Apr 2022 14:55:38 +0800
Message-ID: <20220420065538.4070503-1-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d09ccbbe-b549-4350-ad03-08da229ace2a
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3519:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35192C06B1EA34B9B681FB33EFF59@SN4PR0201MB3519.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTLgNYrhJXaXT6H4F3EFXUeSNVvuuwoR7XCDqq2YaGEq6TV5LjB6KpYqzOFPg8Q70MbD9tez48XEuDt2lX0RatNlQ7i7kZiPx4WtQ5EuD/Cl3+9lPcfLtIeqTrh0OOLSGktWinLBgzkXgNL3PNW3/dsyqWVDluTNcVJ1evdmoq9MUglmoREOslx015YHxp+zF743toY0p2NgNQvFX52J2E4Lrtq5L5z2eG511lWJ6XMqJ6xMjWMa06oeHeTXvvWuHAqigStgFZERewrjH+7U4GNGqnjOT1L6UePugtjHQUsNF431fPnqyjgwkNHcR2/2pORR0YmOisAv/uFX+QsPr7HiIVQ2dGrMKkDLkdKnXrfcG8qtg3GvEpdx2FyheF4ZSrS6op2JA94oPbgz9U0PSVHS0rnuBTngjdhIOgZP6NOHeM3XNIRqu509T7OyiuOFu6eIfbEPhWtyxm22ZQcHbnZNGjucq9482/1XOcgHi9oixMUY140XY8A9HwJRMFRKUZYQCI2J/CSfFbSoOMSuGgcEZl9IzCOmplcLN2oJPijuPJ7HFiyHn2G9s/vTBPLAiduGsZPjz9kWcxkWJt+Fj+ytsfSRFQF178nIS4EibyAKuQqTC6dd3Aizh/WYjCgOJXvCLHQTHOltpywTYd9SD7i5gU5dLAwqyAYyDKe2DsODgZRpWRon8STJz4IvVbDdtTAgcF+oCcW67L8TwBpQtLtwIb2UO7iwd183Mys34Mk=
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(30864003)(2616005)(82960400001)(8936002)(107886003)(1076003)(5660300002)(356005)(81166007)(8676002)(4326008)(2906002)(6666004)(110136005)(47076005)(336012)(26005)(70206006)(186003)(508600001)(36860700001)(36756003)(83380400001)(70586007)(86362001)(40460700003)(316002)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 06:55:50.4776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ccbbe-b549-4350-ad03-08da229ace2a
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3519
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
 .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 383 ++++++++++++++++++
 1 file changed, 383 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
new file mode 100644
index 000000000000..80763ff48b2a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Jabil Boy";
+	compatible = "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
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
+	leds {
+		compatible = "gpio-leds";
+
+		identify {
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
+		};
+
+		status_amber {
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		status_green {
+			default-state = "keep";
+			gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		status_susack {
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+		};
+
+		fan1_fault{
+			default-state = "off";
+			gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
+		};
+		fan2_fault{
+			default-state = "off"
+		};
+		fan3_fault{
+			default-state = "off";
+			gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
+		};
+		fan4_fault{
+			default-state = "off";
+			gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
+		};
+		fan5_fault{
+			default-state = "off";
+			gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
+		};
+		fan6_fault{
+			default-state = "off";
+			gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_amber {
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
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
+		&pinctrl_rxd1_default
+		&pinctrl_nrts1_default
+		&pinctrl_ndtr1_default
+		&pinctrl_ndsr1_default
+		&pinctrl_ncts1_default
+		&pinctrl_ndcd1_default
+		&pinctrl_nri1_default>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_txd2_default
+		&pinctrl_rxd2_default
+		&pinctrl_nrts2_default
+		&pinctrl_ndtr2_default
+		&pinctrl_ndsr2_default
+		&pinctrl_ncts2_default
+		&pinctrl_ndcd2_default
+		&pinctrl_nri2_default>;
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
+
+&uart5 {
+	// Workaround for A0
+	compatible = "snps,dw-apb-uart";
+};
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
+			"FAN1_PRSNT_N", "FAN2_PRSNT_N", "FAN3_PRSNT_N", "FAN4_PRSNT_N",
+			"FAN5_PRSNT_N", "FAN6_PRSNT_N", "FANCTRL1_FANFAIL_N", "FANCTRL2_FANFAIL_N";
+	};
+
+	gpio3_71:gpio@71 {
+		compatible = "nxp,pca9538";
+		reg = <0x71>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"LED_FAN1_FAULT", "LED_FAN2_FAULT", "LED_FAN3_FAULT", "LED_FAN4_FAULT",
+			"LED_FAN5_FAULT", "LED_FAN6_FAULT", "PU_U12_IO6", "PU_U12_IO7";
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
+&gpio0 {
+	status = "okay";
+	/* Enable GPIOP0 and GPIOP2 pass-through by default */
+	/* pinctrl-names = "pass-through";                  */
+	/* pinctrl-0 = <&pinctrl_thru0_default              */
+	/*		&pinctrl_thru1_default>;            */
+
+	gpio-line-names =
+	/*A0-A7*/       "SMB_DCSCM_I2C2_R_SCL","SMB_DCSCM_I2C2_R_SDA","TP_GPIOA2","TP_GPIOA3","SMB_CPU_PIROM_R_SCL","SMB_CPU_PIROM_R_SDA","SMB_IPMB_STBY_LVC3_R_SCL","SMB_IPMB_STBY_LVC3_R_SDA",
+	/*B0-B7*/       "NCSI_BMC_I210_NCSI_PRSNT_N","NMI_OUT","IRQ_SMB3_M2_ALERT_N","FM_SPD_SWITCH_CTRL_N","RGMII_BMC_RMM4_LVC3_R_MDC","RGMII_BMC_RMM4_LVC3_R_MDIO","FM_BMC_BMCINIT_R","FP_ID_LED_N",
+	/*C0-C7*/       "","RMII_BMC_I210_TXEN_R","RMII_BMC_I210_TXD0_R","RMII_BMC_I210_TXD1_R","","","CLK_50M_BMC_MAC3_NCSI","",
+	/*D0-D7*/       "RMII_BMC_I210_RXD0","RMII_BMC_I210_RXD1","RMII_BMC_I210_CRSDV","RMII_BMC_I210_RXER","","RMII_BMC_OCP3_A_TXEN_R","RMII_BMC_OCP3_A_TXD0_R","RMII_BMC_OCP3_A_TXD1_R",
+	/*E0-E7*/       "","","CLK_50M_BMC_MAC4_NCSI","","RMII_BMC_OCP3_A_RXD0","RMII_BMC_OCP3_A_RXD1","RMII_BMC_OCP3_A_CRSDV","RMII_BMC_OCP3_A_RXER",
+	/*F0-F7*/       "","","","","","","ID_BUTTON","PS_PWROK",
+	/*G0-G7*/       "FM_SMB_BMC_NVME_LVC3_ALERT_N","RST_BMC_I2C_M2_R_N","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N","FM_FORCE_BMC_UPDATE_N","FM_BMC_CRASHLOG_TRIG_N","FM_BMC_CPU_FBRK_OUT_R_N","DBP_PRESENT_IN_R2_N",
+	/*H0-H7*/       "SGPIO_BMC_FPGA_CLK_R","SGPIO_BMC_FPGA_LD_R_N","SGPIO_BMC_FPGA_DOUT_R","SGPIO_BMC_FPGA_DIN","PLTRST_N","CPU_CATERR","PCH_BMC_THERMTRIP","FM_CPU1_CATERR_N",
+	/*I0-I7*/       "JTAG_ASD_NTRST_R_N","JTAG_ASD_TDI_R","JTAG_ASD_TCK_R","JTAG_ASD_TMS_R","JTAG_ASD_TDO","FM_BMC_PWRBTN_OUT_R_N","FM_BMC_PWR_BTN_PTHRU_N","TP_FM_BMC_PCH_SCI_R_N",
+	/*J0-J7*/       "SMB_CHASSENSOR_STBY_LVC3_SCL","SMB_CHASSENSOR_STBY_LVC3_SDA","SMB_FPGA_REG_R_SCL","SMB_FPGA_REG_R_SDA","SMB_DCSCM_I2C12_R_SCL","SMB_DCSCM_I2C12_R_SDA","SMB_BMC_FAN_STBY_LVC3_R_SCL","SMB_BMC_FAN_STBY_LVC3_R_SDA",
+	/*K0-K7*/       "SMB_HSBP_STBY_LVC3_R_SCL","SMB_HSBP_STBY_LVC3_R_SDA","SMB_SMLINK0_STBY_LVC3_R2_SCL","SMB_SMLINK0_STBY_LVC3_R2_SDA","SMB_TEMPSENSOR_STBY_LVC3_R_SCL","SMB_TEMPSENSOR_STBY_LVC3_R_SDA","SMB_PMBUS_SML1_STBY_LVC3_R_SCL","SMB_PMBUS_SML1_STBY_LVC3_R_SDA",
+	/*L0-L7*/       "SMB_PCIE_STBY_LVC3_R_SCL","SMB_PCIE_STBY_LVC3_R_SDA","SMB_HOST_STBY_BMC_LVC3_R_SCL","SMB_HOST_STBY_BMC_LVC3_R_SDA","PREQ_N","TCK_MUX_SEL","","",
+	/*M0-M7*/       "TP_SPA_CTS_N","TP_SPA_DCD_N","TP_SPA_DSR_N","PU_SPA_RI_N","TP_SPA_DTR_N","TP_SPA_RTS_N","SPA_SOUT","SPA_SIN",
+	/*N0-N7*/       "TP_SPB_CTS_N","TP_SPB_DCD_N","TP_SPB_DSR_N","PU_SPB_RI_N","TP_SPB_DTR_N","TP_SPB_RTS_N","UART_BMC_TXD2","UART_BMC_RXD2",
+	/*O0-O7*/       "BMC_FPGA_GPIO_0","BMC_FPGA_GPIO_1","BMC_FPGA_GPIO_2","BMC_FPGA_GPIO_3","FM_BMC_PCH_SPARE_R","FM_CPU1_DISABLE_COD_N","NMI_BUTTON","PDB_PCA9538_INT_N",
+	/*P0-P7*/       "RESET_BUTTON","RESET_OUT","POWER_BUTTON","POWER_OUT","","","DISPLAYPORT_MUX_AUX_R_SEL","BMC_HBLED_N",
+	/*Q0-Q7*/       "TP_BMC_FAN1_A_TACH","TP_BMC_FAN1_B_TACH","TP_BMC_FAN2_A_TACH","TP_BMC_FAN2_B_TACH","TP_BMC_FAN3_A_TACH","TP_BMC_FAN3_B_TACH","TP_BMC_FAN4_A_TACH","TP_BMC_FAN4_B_TACH",
+	/*R0-R7*/       "","","","","","FPGA_JTAG_MUX_SEL","DISPLAYPORT_MUX_R_OE","DISPLAYPORT_MUX_DX_R_SEL",
+	/*S0-S7*/       "RST_BMC_PCIE_MUX_N","BMC_RST_RTCRST_R","PRDY_N","FM_FLASH_SECURITY_STRAP","RST_IPMB_SWITCH_R_N","A_P3V_BAT_SCALED_EN","REMOTE_DEBUG_ENABLE","FM_PCHHOT_N",
+	/*T0-T7*/       "GND","GND","GND","GND","GND","GND","GND","GND",
+	/*U0-U7*/       "GND","GND","GND","GND","GND","GND","GND","GND",
+	/*V0-V7*/       "SIO_S3","SIO_S5","TP_BMC_SIO_PWREQ_N","SIO_ONCONTROL","SIO_POWER_GOOD","LED_BMC_FW_CONFIG_DONE_N","FM_BMC_SUSACK_N","TP_IRQ_BMC_PCH_SMI_LPC_N_R",
+	/*W0-W7*/       "ESPI_IO0_LPC_LAD0_R","ESPI_IO1_LPC_LAD1_R","ESPI_IO2_LPC_LAD2_R","ESPI_IO3_LPC_LAD3_R","CLK_24M_66M_LPC0_ESPI_BMC","ESPI_CS0_N_LFRAME_N_BMC","IRQ_LPC_SERIRQ_ESPI_ALERT_N","RST_LPC_LRST_ESPI_RST_BMC_R_N",
+	/*X0-X7*/       "CPU_ERR2","SMI","POST_COMPLETE","TP_SPI_BMC_SAFS_R_CLK","TP_SPI_BMC_SAFS_R_MOSI","TP_SPI_BMC_SAFS_R_MISO","TP_SPI_BMC_SAFS_R_IO2","TP_SPI_BMC_SAFS_R_IO3",
+	/*Y0-Y7*/       "BMC_PWR_AMB_LED_R_N","IRQ_SML0_ALERT_BMC_R2_N","JTAG_CPLD_BMC_MUX_R_SEL","IRQ_SML1_PMBUS_BMC_ALERT_N","SPI_BMC_BOOT_R_IO2","SPI_BMC_BOOT_R_IO3","PU_SPI_BMC_BOOT_ABR","PU_SPI_BMC_BOOT_WP_N",
+	/*Z0-Z7*/       "CPU_ERR0","CPU_ERR1","PU_TP_PWRGD_P3V3_RISER2","PU_GPIOZ3","PU_GPIOZ4","PU_GPIOZ5","PU_GPIOZ6","PU_GPIOZ7";
+};
+
+&gpio1 {
+	status = "okay";
+	gpio-line-names = /* GPIO18 A-E */
+	/*A0-A7*/       "TP_GPIO18B5","TP_GPIO18B4","RST_EMMC_BMC_R_N","","","","","",
+	/*B0-B7*/       "","","PD_GPIOB2","","RGMII_BMC_RMM4_TX_R_CLK","RGMII_BMC_RMM4_TX_R_CTRL","RGMII_BMC_RMM4_R_TXD0","RGMII_BMC_RMM4_R_TXD1",
+	/*C0-C7*/       "RGMII_BMC_RMM4_R_TXD2","RGMII_BMC_RMM4_R_TXD3","RGMII_BMC_RMM4_RX_CLK","RGMII_BMC_RMM4_RX_CTRL","RGMII_BMC_RMM4_RXD0","RGMII_BMC_RMM4_RXD1","RGMII_BMC_RMM4_RXD2","RGMII_BMC_RMM4_RXD3",
+	/*D0-D7*/       "EMMC_BMC_R_CLK","EMMC_BMC_R_CMD","EMMC_BMC_R_DATA0","EMMC_BMC_R_DATA1","EMMC_BMC_R_DATA2","EMMC_BMC_R_DATA3","EMMC_BMC_CD_N","EMMC_BMC_WP_N",
+	/*E0-E3*/       "EMMC_BMC_R_DATA4","EMMC_BMC_R_DATA5","EMMC_BMC_R_DATA6","EMMC_BMC_R_DATA7";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+	status = "okay";
+};
+
-- 
2.30.2

