Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8952EB71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348935AbiETMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiETMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479114916E;
        Fri, 20 May 2022 05:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhmUgxZ548D70bLJ/d12i5+KJvy1OvcjpjNeB82T6KmXiSQMi9AO1P+tpESP84sr535cjLNcONGYpYCaERRYoA9rcvAiZCD//gnpa56B2dweb2+h6DoD2kHyVd0DGtyR7eT+QzbQU9RvQR9EeHsBbgWZzbAr5qfDM95hOD34xUxi5lNvzwD4X3by9ECH8LCtxO/ZALO0iHVx5qsM5xU2VnNBlUn5yttpfee8g2Vm4PQ6X7Dg0DYfSlfQMRQtUoc55Do6muruZq7hFdigB8M6FjLAbOpr5lyHgOashIgE/oDL05LMtCU9TFVoxO8/yjVYg4+D+xgKMDnoeOIbRrFKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDGBIOP3nZe/h0ZnMhQICm98uTt6ED3KRO6IbeqSN1A=;
 b=FlP53oKNW2ZWsYZc7QwYs167ivU6Ot2HU4k89WEOxIOjS1UvE+glG5VADctlsRMG1SQ/3I3ziMdO/f/lEK4vjcUeuoPIgx1Zjp8Q8fR8U5I4QNwFfzZsvNzf0So4SAXYTwqsP4rU6CUSh8ieEZU9infWEqlE1o+ZxNCiHnvx5UIw8BI2Eqv9yVFRKT1UJEwoUO6cVpsxBUoBL/x9M8tSX7yIV1WbnTt3oM4Sex0Q2zFIZRNGUQ8wvVjFPjp/SsH6MPFV0tPG6MYdxCbMRfneD7By90ZKhF8x8FZCF2GtgpabsgAElTWt2qviv/t4hCTvfvxNL6XTe5cv5XQGlZfUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.14.198.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDGBIOP3nZe/h0ZnMhQICm98uTt6ED3KRO6IbeqSN1A=;
 b=a7n8icbHndm62uPFj2EioGzRqm24joW5HxIU6abiSavKAnBNVtZELZVKYSYH4H6UD3J0GVnCoHnALX3gchzZy573PVG3BnoilUemTw3+c+m3cIm51o64V9r4oFUD4pSCKGhZBHukM7MKhc3fWhNlpiu0GeDRtLa+XPMxgrtQOj1mg8sGHj8lcbr9BiSNCJjb/YCmQpsaLtzdSXN52FIDBqRXFboGwszYqrOwAASUfiKGlLkZfWDo6dbryCb6twJNZes6CNXQo8kCV3tTE8rczXwPhN9ddFLA8ZXKci2uWse2vzDrAROvOM9FpqSV9JAvL8CPQNmkvIsayoZmikpJ6Q==
Received: from BN6PR22CA0058.namprd22.prod.outlook.com (2603:10b6:404:ca::20)
 by BYAPR02MB4581.namprd02.prod.outlook.com (2603:10b6:a03:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 12:02:17 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::a2) by BN6PR22CA0058.outlook.office365.com
 (2603:10b6:404:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 20 May 2022 12:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.14.198.160)
 smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 8.14.198.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.14.198.160; helo=jabil.com; pr=C
Received: from jabil.com (8.14.198.160) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 12:02:17 +0000
Received: from usplnd0hub01.corp.jabil.org (10.10.32.73) by
 USPLND0HUB01.corp.JABIL.ORG (10.10.32.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 May 2022 07:02:16 -0500
Received: from JDSBuild.corp.JABIL.ORG (10.10.7.5) by
 usplnd0hub01.corp.jabil.org (10.10.32.73) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 20 May 2022 07:02:15 -0500
From:   David Wang <David_Wang6097@jabil.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
CC:     <edward_chen@jabil.com>, <David_Wang6097@jabil.com>
Subject: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Date:   Fri, 20 May 2022 20:02:12 +0800
Message-ID: <20220520120212.3589911-1-David_Wang6097@jabil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462f5102-5d10-444c-f011-08da3a5895e9
X-MS-TrafficTypeDiagnostic: BYAPR02MB4581:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4581CBC46AABBBBF076B1EF8EFD39@BYAPR02MB4581.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdHYWbB0dXDsMA/j6qQ8gaEoQ5Jxr+wYRIyTMNlKIEgVu/m5mGlqK4MSBS0Iq0tRL8CXq6VlpLSCbTp0p/J5mJDm0VV0VxCcNi7Y8JtshunXBowNnPnuZ2xMIJMjADAlZO6TfwWSW1NblZGt2SrFIa1NIP4H6MxkJdo6jRPa9jTlb3MbQjzdMMeKfPtLf0+na4Ly7lB33oXoaj+0sokM0WbwBl3K31FfiW8AXIGaeLAcg+Ys0xPxQKuTRkt0zEczoS6wuwo1t3BqMKvVlRwT6uQcwKaE4UjlI98vnKTtSgL3WCTXgYBkf5iwzCgClBcuXzmEQtkW4RAaw4J87EqwsTn9yqwbA/nGTnknbOR6jdWnx0vBJAnlHii6L4t5BC84OmeuVZRe6W7swjCbXJNKSyGfs+oCmCoDClu0dRLcJ5JQl95dRahPF9+rbPqt8ZWYtWotvqwrcBQh0kVBz4J9GVtYYlQFWWfXFCRFGaZctm8iHBK2W+wd9D0MkL1fd5pdlECa9uMwnULA7UhZW95MzOfHSvIvRw4ny/50+gH6RegG2qlpkMVuApQYBGDGA6wTMFYPYq3fwCMf3f1RkS7mDnuarNP2gVDi33LtoIQq2+0CBF6fR00VzL87qNsh7D27VfnAwETnZq7Lai/jiKMzIR/RzavNe19yP/c54JiC95P/f3wFXSi/aSbOCXiqjpol/q+fIQokQCi0w537bGK6Mg==
X-Forefront-Antispam-Report: CIP:8.14.198.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(36756003)(82310400005)(47076005)(186003)(40460700003)(2616005)(336012)(1076003)(2906002)(107886003)(36860700001)(110136005)(356005)(5660300002)(30864003)(316002)(54906003)(82960400001)(81166007)(6666004)(8936002)(508600001)(70586007)(70206006)(8676002)(4326008)(26005)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:02:17.2234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f5102-5d10-444c-f011-08da3a5895e9
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[8.14.198.160];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4581
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
index 000000000000..5e46af30c9e9
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
+				};
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

