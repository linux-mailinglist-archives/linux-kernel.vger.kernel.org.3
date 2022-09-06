Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA55AEE36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiIFOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiIFOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:51:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150EFA262B;
        Tue,  6 Sep 2022 07:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRrJw/KfWh7mjKY9ooZoKeMP8hlssB0J0MK97GAtZAGoG11fhMFTwbZS3U6Fwr9UWqwYg/RxQbvjMU2GqZb/eqy2wOCAZpu73s8MJDEoby/FPAfne5uAY5kMQWoG3jSnghgztfyvhOXvOSPPF8/GG92sqqXEntyapAoaycSUeEzK7ZsRAlN9r4wn5kPoa59ej5srJj/gDwV7w6ypqEFxV/1M8TSs9/ntaAsdixeg4J4gIFm5FLrn73o3XICzbYR+FKdn27s7cMlIJptlZ6JlSX5/RP4E1ckhDLgzf06nC9i9sG1dC/MJHCiLKQkpcfmNWqluT4yLiaiZ/cT3oFRt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPNERYjPGhAdjhyZDco9ML7IVxH2tLGiq4SPkPsDxso=;
 b=Vk6DYnCOImcpEtyxGTVVkKA3V8rSf9I913yRK23hkguzTMpKMhH/BGq3gHlgLZjQrnrAF0dPEyS1grJFvr0cpb9vor1ZYPf8TCBdXDqKd8Roe04PURSpQ3LA63M7+hmZX5+bQ4vibiqZapaWRQC7TjX08geiCCynKDKlzl3pl5lM1jrDQnOma5i6sJO7Dpu7sWv19c2CyQWXM1Ui1PUMTAq694XDMmQFJnEKTV1Ovxd2+vVmCGPRtb2dcUeyF4K2liXCxrgt1/bryOay/SEyt5V/SI2XDI56T2gTOPixq9GIHEsBRjHc1wSIk/oqZU3+G7urWPGrRcXCwfxYHcXafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPNERYjPGhAdjhyZDco9ML7IVxH2tLGiq4SPkPsDxso=;
 b=qwnY7eMqBLsgwOJaTV7HqQSqH6uoFcEy/0+TKTyzmnjQc5/Eal4WR4N1BVhHzGcMHX/NS2mDmrUd9mhaDQCZim9qBiLea1onXBtPqjUl4+KrGvL5/JjTJvWRPOcHeH9s622jQQQhUtL97NU8vdheThoWvk4cJLp4/UIUsrBYsxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:55:31 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:31 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH v7 3/3] arm64: dts: freescale: add support for i.MX8DXL EVK board
Date:   Tue,  6 Sep 2022 08:53:42 -0500
Message-Id: <20220906135345.38345-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85165dab-446f-4c45-d8a0-08da900f7682
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVCnQpPqCMtmUc+/90mRmC/faGRHB6nrrxTcWnH7cM2bQkMLKEoxXpj7Wg9t1b7CQRFMvyJ16SyWU5LEH+gB6NmKI9K5GcQ1k0YMyi3uiVH1SdLNpuRvrtH9UVuY5+eFUps5yiKnx6+twds5K3rxIKCrASbMrHyXsgwvpDakQe9whbCBvwzPd984zTxIVglgKJMy1Ry00n5SNNAlGocnAi2/cdQbr1KrfV2clO9+Yi88/D+gVmTsXjJNwOzc9u8f0nBSJVDOwbkx53dBbqVN3F9TZj3R5C5Cak5NMPDbq4cSOmxMIBVFdn3qF7j76uJdhOtIyTj1eXdHnoiEPEnMlSilypuVMK+jmy2XCSa4sTj0Rl1lW6I7AXOWh3OuJQyJtKvCS8C7SP+8TjYV7kDtHJ5dnoPpF9wDh4XZYpp3BI246eF5JGkTU2q0RvtXJUo2lmGfN1tY3oRK6reOFAavCTNPxQeETpo/M57voWuBxLtMzgqW5VtSdU20S/HqOEQnCTbGM4e0zESkG3q/ErPHQPVTqvXSZE9ef2lLjEAt/9YQC9qLqtPk8th6t8R+ITSCRpIgcZh7iwqCAD+gR4i0AC93qMtzfNWHUEBLMSV/qE6WrJtthlHx32R16bBaa0sL80zHkh84pI27CuXS8TIJV7YcCAkUCL+qThs5ZUZ3A7W/khxX7VQj9N6HA0I6nbZ683NoS+qnc5okOrYMbGcMddpuaTenAeS6k7bzHtNA2YA/CddiV5gD3v687HRfJ0lxOnwdo/hMHqql5o6fvmWaNFA8UCCjyrP0MnSj0GDfFJNUZyl0d2V1zAirE7haUKf+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(83380400001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(2906002)(2616005)(7416002)(30864003)(5660300002)(44832011)(8936002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gqW4pL+/OccE2jtKoUEM1FVJ9P4agLboJSpBg9Tyc8YAGlPLUXcENBtaZ5d?=
 =?us-ascii?Q?VLmPDQOUN0e1fjJ7bdQPlyAaSOClAWfWiizNtgf4Xrzqn6KrDnF9Jp6dlEls?=
 =?us-ascii?Q?FO+aBW92Qpnm0NVrRBmXE1DK+ddkHLhQLa+GTKo1nomGC66YYzJFt0kD4Rkt?=
 =?us-ascii?Q?k5lyubfG1SAHOR9BDNxJGUdjgchiJ1bqieOBj63i1FIx0Pil1KYrH4mn6yWf?=
 =?us-ascii?Q?CDOCND1+S5bJpvQU5cZcKzqLFMRdVKDPAgx7d6JJhjxsF4+uBRRAvGRdjFrc?=
 =?us-ascii?Q?njlWJfZbP9iEeuPi4+oIniG3kKr5rlaFHuK+ZcrrjYK7GutpT9X6c2haw/Mn?=
 =?us-ascii?Q?Q5sFKuBIYMaZ7z0WhVgrOW64T9diedVdcgX5maNe5SOXNVsMxlYtb3QPEGOq?=
 =?us-ascii?Q?DkMMoandh8HUIR388zxpgyz4yNLdpVnUiI/hMM/cAF4wVauhwXd0SKQIPIuq?=
 =?us-ascii?Q?88rgvTPxHF93x4UVh+OGsZUyMgTDvOTzVzHFhWXvTb/XGRiAlVcLXPEBryrx?=
 =?us-ascii?Q?CFIkpoa/jI7tyRvZR0cLSd1zWPCllCjXzWaAhEdu0APmUdz3OcnFyJimeYEl?=
 =?us-ascii?Q?5S4I3y32g42QIaFDePEW5nHhEzWZVkrDiCbr9UTE4Zc+iChBvSKzhCyvhE6s?=
 =?us-ascii?Q?NHzIXT8agGn8tlGT/UFFbimgoq2GwZ3F9of6AAnoUwqMz5hbqLeXRfczGbWf?=
 =?us-ascii?Q?Y3iZxSJZeFfAnlvofI9tIApYgX3XlBRYawS/GWaRpvT7hf8NVwMJ9yNnwwct?=
 =?us-ascii?Q?huw19R8aEEZYxCNGlj3+lzUz+lQ7Q0pLXwgciy6XstEMkOOXowYj3kgLFl8v?=
 =?us-ascii?Q?WEtH8ua1KogdHu7CByCwmUEMf0/DKKK/UY4O2k92/PuGwMOsGEBo/Chq92BH?=
 =?us-ascii?Q?GVL0BbGyq3azBwrDP87illTZxcYU7QX65ZHhwhH9ylZu08VJiMOg0pGPQbBO?=
 =?us-ascii?Q?BxZ43idDr8UFS8RqaWbJabIcfK3ybr+qKK7DFyBNnMZCpATLothwUUdNltrN?=
 =?us-ascii?Q?OsW/rIBW71cyWskteKFciEezVmrOoaOSxWJzsNkJDYEO8fTYrQLcRcjuGDz7?=
 =?us-ascii?Q?o8zAYiiueW5KiJ0mrRF7Tky3tfmQvVUsCmx+xxO65pRO4Sua5L/AemOMw6zA?=
 =?us-ascii?Q?P2iNzJzsKSR/fC9mWnCnV+2vg5iIufrN4gksQByfnE4YCtBp1Glv2QM6NDw3?=
 =?us-ascii?Q?9pPk4uGv/LtjLHeHNFKMhi5JZLd4rkIBkpubPBVUV//d+aK6QKnlVfp8le4k?=
 =?us-ascii?Q?1CeMvf02fyeZuI4ee+VnSsb8cIYvNo1/MPPjBLEUlOsmPeQtu+9Ske0wJl7K?=
 =?us-ascii?Q?qd7um9spMZMgXmi/v6QZ3AL7mn1evmaGEeyZ6WO9mBxJiAhs2irYMmUFuKI8?=
 =?us-ascii?Q?3qoGrmPDhARVbd/IC7mblW8mM7SfhipWB5hceikhbEh6rJNfQaBQT6kG8Q7i?=
 =?us-ascii?Q?I17/+S1N1iYMNmOiKakpMEHnCuOaCkU5u8nbsy63PCSgow8I6zESBg/ZE2XM?=
 =?us-ascii?Q?g9c95Ffh5d2DQ4sCQEN1RIbpdQagDfpQRgOVIhhNs9jbsB8BuF2wK1x2Sgwp?=
 =?us-ascii?Q?UbwOJ3yJx2yMid0pnRrLSB7v3MHaYbawYOcDFP/t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85165dab-446f-4c45-d8a0-08da900f7682
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:31.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZE3FKrxnIX43/AmYkXdIIeFGIvfaUcD9nBx7OLQFsdbFPLb9TlqxK7Z57qAihgk2vOY1l5SvB0LnePp4HRgkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to support the EVK (Evaluation Kit Board) for the i.MX8DXL.
The patch has enabled the serial console, SD/EMMC interface, and
the eqos and fec ethernet network.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 426 ++++++++++++++++++
 2 files changed, 427 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8bf7f7ecebaa..2741205efe84 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-85bb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
new file mode 100644
index 000000000000..868c75945af3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019~2020, 2022 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8dxl.dtsi"
+
+/ {
+	model = "Freescale i.MX8DXL EVK";
+	compatible = "fsl,imx8dxl-evk", "fsl,imx8dxl";
+
+	aliases {
+		i2c2 = &i2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart0;
+	};
+
+	chosen {
+		stdout-path = &lpuart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Memory reserved for optee usage. Please do not use.
+		 * This will be automatically added to dtb if OP-TEE is installed.
+		 * optee@96000000 {
+		 *     reg = <0 0x96000000 0 0x2000000>;
+		 *     no-map;
+		 * };
+		 */
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x14000000>;
+			alloc-ranges = <0 0x98000000 0 0x14000000>;
+			linux,cma-default;
+		};
+	};
+
+	mux3_en: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "mux3_en";
+		gpio = <&pca6416_2 8 GPIO_ACTIVE_LOW>;
+		regulator-always-on;
+	};
+
+	reg_fec1_sel: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec1_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		status = "disabled";
+	};
+
+	reg_fec1_io: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec1_io_supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status = "disabled";
+	};
+
+	reg_usdhc2_vmmc: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&lsio_gpio4 30 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <3480>;
+	};
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	snps,reset-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
+	snps,reset-delays-us = <10 20 200000>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			eee-broken-1000t;
+			qca,disable-smarteee;
+			vddio-supply = <&vddio0>;
+
+			vddio0: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+/*
+ * fec1 shares the some PINs with usdhc2.
+ * by default usdhc2 is enabled in this dts.
+ * Please disable usdhc2 to enable fec1
+ */
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	rx-internal-delay-ps = <2000>;
+	nvmem-cells = <&fec_mac0>;
+	nvmem-cell-names = "mac-address";
+	status = "disabled";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			reset-gpios = <&pca6416_1 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			qca,disable-smarteee;
+			vddio-supply = <&vddio1>;
+
+			vddio1: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pca6416_1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca6416_2: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9548_1: i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			max7322: gpio@68 {
+				compatible = "maxim,max7322";
+				reg = <0x68>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+		};
+
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+		};
+	};
+};
+
+&lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&lsio_gpio4 {
+	status = "okay";
+};
+
+&lsio_gpio5 {
+	status = "okay";
+};
+
+&thermal_zones {
+	pmic-thermal0 {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+		trips {
+			pmic_alert0: trip0 {
+				temperature = <110000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			pmic_crit0: trip1 {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&pmic_alert0>;
+				cooling-device =
+					<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	cd-gpios = <&lsio_gpio5 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
+			IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1		0x0600004c
+			IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN	0x0600004c
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			IMX8DXL_USB_SS3_TC0_CONN_USB_OTG1_PWR		0x00000021
+		>;
+	};
+
+	pinctrl_usbotg2: usbotg2grp {
+		fsl,pins = <
+			IMX8DXL_USB_SS3_TC1_CONN_USB_OTG2_PWR		0x00000021
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			IMX8DXL_ENET0_MDC_CONN_EQOS_MDC				0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_EQOS_MDIO			0x06000020
+			IMX8DXL_ENET1_RGMII_RXC_CONN_EQOS_RGMII_RXC		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD0_CONN_EQOS_RGMII_RXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD1_CONN_EQOS_RGMII_RXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD2_CONN_EQOS_RGMII_RXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD3_CONN_EQOS_RGMII_RXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_RX_CTL_CONN_EQOS_RGMII_RX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_TXC_CONN_EQOS_RGMII_TXC		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD0_CONN_EQOS_RGMII_TXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD1_CONN_EQOS_RGMII_TXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD2_CONN_EQOS_RGMII_TXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD3_CONN_EQOS_RGMII_TXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD		0x000014a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB1_PAD		0x000014a0
+			IMX8DXL_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8DXL_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x00000060
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x00000060
+			IMX8DXL_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x00000060
+			IMX8DXL_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x00000060
+		>;
+	};
+
+	pinctrl_lpspi3: lpspi3grp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_SPI3_SCK		0x6000040
+			IMX8DXL_SPI3_SDO_ADMA_SPI3_SDO		0x6000040
+			IMX8DXL_SPI3_SDI_ADMA_SPI3_SDI		0x6000040
+			IMX8DXL_SPI3_CS1_ADMA_SPI3_CS1		0x6000040
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			IMX8DXL_SPI1_SCK_ADMA_I2C2_SDA		0x06000021
+			IMX8DXL_SPI1_SDO_ADMA_I2C2_SCL		0x06000021
+		>;
+	};
+
+	pinctrl_cm40_lpuart: cm40lpuartgrp {
+		fsl,pins = <
+			IMX8DXL_ADC_IN2_M40_UART0_RX		0x06000020
+			IMX8DXL_ADC_IN3_M40_UART0_TX		0x06000020
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			IMX8DXL_SPI1_CS0_ADMA_I2C3_SDA		0x06000021
+			IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL		0x06000021
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8DXL_UART0_RX_ADMA_UART0_RX		0x06000020
+			IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
+			IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD	0x00000021
+			IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000021
+			IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000021
+			IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000021
+			IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000021
+			IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000021
+			IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000021
+			IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000021
+			IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
+			IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x00000040 /* RESET_B */
+			IMX8DXL_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x00000021 /* WP */
+			IMX8DXL_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x00000021 /* CD */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK		0x06000041
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3	0x00000021
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC1_VSELECT	0x00000021
+		>;
+	};
+};
-- 
2.25.1

