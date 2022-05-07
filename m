Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52A51E4E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359700AbiEGGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445952AbiEGGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:55:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02E05DBD3;
        Fri,  6 May 2022 23:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMuT/lOFwQrnX2lgOP4+RKdvxvqS+CGWzvOwgJEPqPk/8mEtjPkGCIDxZqIA2of3QB86kR3qGl0pQG32xfpc9kBaDcYwpyDn3AiuuhnTrsL6lZ4VE4lmqo+b8Z2l/iuaY+F7jqIhny7d3Q3ixYpFhlmD9+WOQC+8WjxYsz5POB002DTJhkf4UNSDbHDmBstrvqwsctA7LT8yK8mpXo4DgX59NmKBFWrhdVQGS7e67JUv6C6GnqRAd64c7YJQTrid9dQFSUs3inC0S+ne5arKpqQmtQhOngUzED4T8Zl1nkyvMtdan8X5Azuw4WCnu+s6x3xqEaYL74lYaGBnRZjTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lADrSBfeOtc+fAvLn9oEN2szH5YhBTKGFX+eMM3xbPA=;
 b=Ow1Qo7ZeaFmpouwkfXKpE3rg0EXaHmp8WLk5QDmsY0l5bxJxLi5GQ+WGrzLKqTGaSOtnNnc6b40q6E6YzokIGA99ZKGw90P+34FM7HdGJQLHQ4vOGEaa5+E9i8wWLkinLdFhOg5coQgpKJZDl6dovBTKmomcHfiUwZ0o+ZqK6S3FKFj/mm3n2UaWY3W0+7/c9GYBGY9DWiKAtm2M/hziLZX1V3K5w/feRXUWcYpQWSj17x1hwG9sR09t7wyw88/dmIz+Y8F+PdYKL3HZoNiq/t4kv90kLRWnJzUj5EEbxXdu4bwuzWLabTc7RW89Zcnn62xk4QttTiLX1uguEsj45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lADrSBfeOtc+fAvLn9oEN2szH5YhBTKGFX+eMM3xbPA=;
 b=ZRjnifSorVu52nuC7DgERm9j/GGjyF2SbKsuS9c1Iegc0wEa1auCFbQepn3+5PSqDekTB/mGJJY+285dcaMinu3CZof+N2x6GQh16NzkAeAvLZiR1fvmzfQL7qdSH3lPJrdc3KkEjtzhlJiX+Bv/YIMIUei7xXUFccrnuDyPAbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:51:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:51:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Sat,  7 May 2022 14:53:08 +0800
Message-Id: <20220507065309.3964937-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
References: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6631a7df-9271-4821-fcff-08da2ff6095f
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2527:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2527BE01FDFCFE94E5562AB3C9C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6xafEiETtmRBaoOSe5Y//7ATVM1oIQfU95R7bVMf+mOW8ry8k88bKCk+A5xqOtbPNvJBI52uXjGfEYefn5MlRoCl7nxVCJPV0M0jglmYM80nk+6hUIoH1RRTDIlUzsfE63q0YQ8yq0yFziWsOlhrgBKrzifSOkf2H5xTo6Eo+sHONpto9kxm2+a0VN6n4pf3BrhaHFwiYtOIVZPG7qihxZytlRnD96Gm42Z95YbEivFAUikKXWkvEn1UeowDxNLN00sjAYY3sOVUg1evwTlll085rgTfLWCO6vg643g5xuh5mOztdspnwsZ+1YFXbMYICYD11OcvuE2FyD5d3gvc2CGKp6sw8VRNRF21RpQJnLIoBo+Xt4PP+wgnCjaK36jdpnYYzO8VoybxFAVgLUtGL+9XZtvk/Ll5yzHk2HIdco739rW10SyB6MDzEySA+qfBFMYKksCOezayEJrayU5Ur0z/lLFScFFn4XA5N4KNJmam+vcW3ey//o75v0RiJio8eNjMDX/ORGX6U+H90c22U5gIq7d+jmcxF6v9U+zs0NYMROAEJ6vvZ3sxy9EUgg/7D+enGxYABS51uQU37sl6CuZXpNV6tDAjMqb9cb6Em0gKsQ6FD57YstaTT940EkeOn9bRVuY4s+5qQVRJzs7OeTiDa9YC37cJwZw4ErDfZ03zJs12FpbkAY/JCnGXm85XPBpwtS1HzyhG7v9ZiTrTjxczyHGRROQPh2u+XjN9x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(186003)(38100700002)(66556008)(66946007)(38350700002)(66476007)(8676002)(4326008)(52116002)(6506007)(26005)(1076003)(2906002)(6666004)(6486002)(508600001)(5660300002)(8936002)(316002)(2616005)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UKAfh5MtsenS9MDdmzD+8mOSWy/GCmcIQZA+zihYnCrpZbP7oTfq54ihISu?=
 =?us-ascii?Q?WRor+5HSvXOJs9dalf1E9VDffPkVszx8+rnQ19c4LUrZMLP4/wn+tqP9dkye?=
 =?us-ascii?Q?TYL78EN0MpLNe9CyWh92iJ1pyXxT2CG/huvVx9B+XsLqt1Pvs71O4OzBvMq5?=
 =?us-ascii?Q?PRlEKEe5HJ5aY8cVC0ghvujmv/Y0kONieV84Fs6p0PLinpYpkMSP1xow6gAv?=
 =?us-ascii?Q?v1aKFZAFvckfgDAOInjpPg5h+TKRTp+RnmxZEJGoAHD+zN7B9Gnrt1V3wkWm?=
 =?us-ascii?Q?/9pA8zU4fr6Ay0pUaFRXcb78Ky7u969UeJ0yG0hlziuUhIi0qtwVg5pnr1k7?=
 =?us-ascii?Q?RG1cxA/uKPtPjT5THsDshYjmWe9aaHE+9Vg2f8Qjrrch0kbMfkyssDwgAsVt?=
 =?us-ascii?Q?yQt52HTK1odUFJ7VOPDjljgnSA/73TftKgnlYZbWgJbS+aXJ7vftIj1KeeYB?=
 =?us-ascii?Q?7KXkCQDGbJyBYbZiISUtnLWYOltcmsPqUwDxs1TyXhf9vjK3qoDhIzTa4FW6?=
 =?us-ascii?Q?NJVpkmk4mNjSP+EfktZD9JA5VS0ArRaU1MlziSoYiuhXtbeh9e0Or2ky+qI6?=
 =?us-ascii?Q?a4OVivhOdLMT0LqBsCEUkPayGSLI5RXKT+TdSizR6RWXzkAuKuhl0pCWZCej?=
 =?us-ascii?Q?IeI8XvMkhYZe8Rv6BDmQKYX5p5eXsRXWuNDqvmykedVxDgVJF4JmqcjSsBzo?=
 =?us-ascii?Q?5TeS+eiIhq/DRYRpdIPKucc4NyDqdOuIeVVehZQ85MWqgF6mqJckJk0I1XXu?=
 =?us-ascii?Q?Gk6JT/J5XLtWCjnlW6F8VS3Q1R4UQGZwik8zAhS+CpRxyo0GeDH64wyZcLA1?=
 =?us-ascii?Q?xJJPKwS0gyVG+a7xzrwrFeabrWh/UNCldO2ds9vxMwD9nr3lK6hyB56Wo/Zy?=
 =?us-ascii?Q?hWPkb1A/+5H6q2iqazU6WVSmForGyaCX4pBM6RzATO0bV912H2GNg0QVpzco?=
 =?us-ascii?Q?kQszAarpR3a0+59Z0ddDzeMbspp5qeYcfkIhW2WXLMo8fDkDTprz8g09VlnN?=
 =?us-ascii?Q?wTlTTW58R7uYmJ+EZOd4x4s5TLsrJL2xF6s72tDKzFMUfM8wTDNf03sZ0guo?=
 =?us-ascii?Q?0ciDfGARsYDjJIzFUrmE7BAdSmtCUa9FGGZ/t91DnTc9mFDiMWa/Cp0h6Ne3?=
 =?us-ascii?Q?wIbd87uh1GXWUr9tLFK91pgj2ht16CwjkFqidqlKGQo2XaIKucmMT6oGa5kq?=
 =?us-ascii?Q?YfBwbOyT9216s9KTorXMg1OW0Luc4FHrC1TDPiEYRLQ+pwEEM/vhBRk6hYEY?=
 =?us-ascii?Q?RuPnZFZdcZrglsQeypRFWU6EfM2LXf9HWUK/PMthPPO+KVyWKinNzXfz9r85?=
 =?us-ascii?Q?roZ7T2KU8sdXcWb3Qku+79F5Z8yyjOJ9xx4SThHdTd3sMWc3fLUx/dAwT8nb?=
 =?us-ascii?Q?oSU1mdVoXjDShnK5rs1aO8ai7ks8Y2qDGpkIjxUr3IlXdp9rUUxIyC8+TUtD?=
 =?us-ascii?Q?tqe597MHBg9GMuuRkHfg5RHcFhcpZ9kwbEZ+APB18AtT//WW+McG3Vgyg8ym?=
 =?us-ascii?Q?4dvVX/eHlYqEpHo41xHJ+4Jfb4wuCbNzkLK55n3uZEDqSk2drRn3Etkg84Bg?=
 =?us-ascii?Q?U13gGkWBET5e2NwTbNkCd+gJlGQR++Nl/tHKYpI2E+jAyUUlonzUr//3BRqS?=
 =?us-ascii?Q?LnR7IcHaDaTq9Rlyj7iJhOFMpshHlAuRya1ueiUu7Bf/U49fJyPpkNOLV7Ob?=
 =?us-ascii?Q?T80k+u1glQYyA5XDdHDwMMkr9uiZJnPt+vVAwK4pVY0Wlmi3oxfvEixn9h3L?=
 =?us-ascii?Q?L8gmYEQZNg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6631a7df-9271-4821-fcff-08da2ff6095f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:51:39.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt1yIkUJ7SKt8AgODsne2VX9gHrzV/2Q+myET/24dvmB7Poz9wk1N5W3CamO0qEv7wUYSaDB1rXM5hvkm1mSPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable lpuart & SDHC for console and rootfs

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index cdf9dfcbe020..562fc1e389a4 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
new file mode 100644
index 000000000000..c29ea733a775
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ */
+
+/dts-v1/;
+
+#include "imx93.dtsi"
+
+/ {
+	model = "NXP i.MX93 11X11 EVK board";
+	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
+
+&iomuxc {
+	status = "okay";
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x31e
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x17fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+};
-- 
2.25.1

