Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A950DE68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiDYLFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiDYLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:05:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615FAFADE;
        Mon, 25 Apr 2022 04:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIdEUSSaDN2LjNq/uIm0CUa2wEH0Bg90ZVux7e8WVOlUpu4nE4hjjzfm1WK3OO+yI27um3lfc4BKgjxIyXdMwmWm7WYHQ0hN1lN+dHVgiRsfAc+x0vwF6lSR8fGB5gCAVcwJX+Ys9EaJzgHIdv57dJQENCJUY0geWScSZR1ShVoc3vjA9f9HINQGGVvnO8mAdLDnMlfYls2uKFjUl39H4Z/YtwBgpGd6DygEcHCVGCxcJ5yN5487LymrBEDTq1zwOWBhQAcJn4tYvFty2FVuJECjqAYqEfE28ZeB0Xz2lIYvD2Jdu5wA7uE+fR2D7eRuYdJtOy4xr0SfFZmjv8/COw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHEboQgJm2Ss9qvKcUd7+ET3I16s8/OellgAtvRbaPA=;
 b=cSp3GDFSSHiZrktmHT1UykahuvIStCf26Mo7LGvzk9GLaF929E/+onM3hbn5xMtXBN9MMuSvgYJEU0gP8XlIFlHtiIM8PTk2gaWaKjWBRGfCJJtTbp7lbuzDkH9lvXMzCihSfkBS8oyUoxlY3VGmFWiUR3N9kCQwtOJdcnUyLlblyF/4l+Y411h6r/Mmn8Uls5L4b6vBr18LrG9LxKrvEqD2DaLslpUbRTZYug86dTTjRhp/u8Ln7SK9GOvGQxcD29Z2pnQYsbtrTPF9ao5hjQXM83jqSIgHi6Vw5Z9XccyIzvX/D5nMFPLtWy6RbiaiVbMTLM0pO/lqbjkjWS860w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHEboQgJm2Ss9qvKcUd7+ET3I16s8/OellgAtvRbaPA=;
 b=iq+bEsNbZKkSH0qD7KCIKAnLAWEtJd+0cFPGMUtINroC8PQ/fm9zs4XWXlsoTGqTWHuKJ2XdtUfZEEH04yZJsj5OwwhclhcNBcCrZLEx5tHPdnW3nOFBbEt0bHhSqtnohdK65fo7N60b6ZUjDG2fC0l9XaNXwWxbuHYMkGOAZVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 11:01:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:01:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Mon, 25 Apr 2022 19:03:29 +0800
Message-Id: <20220425110330.1630984-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
References: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23a8cd6-e21b-4c34-4f56-08da26ab02fe
X-MS-TrafficTypeDiagnostic: AS8PR04MB8420:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB84207A0F98FB5C3B7107D2A3C9F89@AS8PR04MB8420.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De24o5cHBAE4X0maKHLBgL1M24W4KWcVw5PgOa+d/haHhY0kuowgYVmduT61hICAuUucWQb+D7OMB/cos+mTRoC3R/2iI2ocLgD8dg9vk9M7Gle78yL8rJoXxEcn3Uz3EKPO3cCTlm5de+PNrIJ24cybKFnp9h0Gh74D66bicNWlUcw1FQ/X5j/v/mOzvKB5z8kbXlhIFD/OsXQX7jLx+NFkA2CICfSu/ELmtnbq99XjTE7RAjcz3LU9gsnNU1fuNZbdGmHtkNY1Q4q8KZXtQsCDSOiPuKim1dg+hSxlIvHae5zqYxk27ROmfYMF/PSBZsJX08hQuoTck3fBOwxYI1rM7ZEXmrI6xSdkWL6GoKrVCkISisw4ffYreNbZqTPyf4qjyKBW3A4dsTgLPwhzr91H7ssMRiwZ9viSPLhMIJhn1RPnaH2nRq7KJFQLG919R51/aepU1fqs3jWC+ABi0Bl6Mzq8gb8udqpuQ9/XWAD7VaLyZx/hVbzAI4CXGCKnox8n4int+GQ9psjk5CdzDEYwFH2KEZvdz/pvDzZZJbLnLJ74RdFf/qhK3IWAyhzp5ofQ3fzxNTDI/uWMH96QKWUWFXU8N72eGDPbIIk9UryrJxRGz78qs+e4H8WfW3ltcEGFwSVEW9nEkMILCBUbVLCQrWY9q75nnsVnOz+C41rawi7Zw1oqNqJkS4WDgC1y8HWrY6rDGUMZaS5E+ye5CtMsmWdK8Ccreq7jBn0LeDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(5660300002)(2906002)(316002)(38100700002)(86362001)(8936002)(66476007)(4326008)(66946007)(8676002)(66556008)(6666004)(52116002)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(6486002)(508600001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H66Dvd7q10fYTlHz634sW45g09ZE+Mg/bFDWqP6JIR3oIYNQ7gi0+Nx1G0xh?=
 =?us-ascii?Q?Qc3uLxBWO6Ey/IblaxeFL1tWPEWC6erkjztHUNLaRJbvuFO1zkKHpJl1Uos1?=
 =?us-ascii?Q?yoxNe+GT7UUeDkhX9w8Tb6iDZq7b7VRhld0g20QG0SBOWCBIcHvZl/com/Ha?=
 =?us-ascii?Q?W+qLz6XJ4sHV30gNZRPPRqcGW1Uk4dZmWrT28v6EJT5AFP/f0VZHdKv/jIvX?=
 =?us-ascii?Q?uNtn8qFKRzLllJuLrvUhD+PcwKVSIMrNbTsrxbbDeN+dtHW4ORKY212EkLhs?=
 =?us-ascii?Q?0aml7t9lU9MjAkSeO+J/26lp7ByJYxjbeaW7JktDoYkuKk6p/DNEGjaq+mpH?=
 =?us-ascii?Q?O4UkPd+QuktAcmBLNtWpCKyxq1wUpzsKFCln89+a0kCChLSuNXw5jWQDWlIj?=
 =?us-ascii?Q?mUfRHHCjkO3tx/p+EGhLJdP0DrqqkMt1F4t0zGdTCYKF837u0HbdmsmRvK2B?=
 =?us-ascii?Q?HDR3+a1Y0vuKlnddLhC8LXJJb+pqD7OShi6K8mcXFK76ip7bkU5My0vau9YS?=
 =?us-ascii?Q?PmyIsxW4VVI5FXbzY+KPB+/qmFHi0HD//nAzRJffR7r4ibxyuO9TtUTXlu6x?=
 =?us-ascii?Q?iqYdf74iDbZHQsXG4gdt4YgMDI2P79vN+LWLIm4XRR9OEVB886Ze0JZJiXi+?=
 =?us-ascii?Q?+dA6qBnoE+FIrA7uI5keE1Sx3ET98CG3cgXrOd4hupfG4Fp5saDmYv9cttuU?=
 =?us-ascii?Q?rnnbe1K95gh4BgAgQtbpNwDDfEYzvETF9tfoA6hUGZLwwIgP7vwBqnQgn5B2?=
 =?us-ascii?Q?7e+BSkDrV1euoMX5rVbGVXPPnhZwDDvqP1WjaTR6A9HI4x8xcMKmdU3PAZFR?=
 =?us-ascii?Q?Men7LM2UznEEcRAjZSnGoM54PCTnyNmkRXwnWFDDuwTwbvg7F2eb9AEuZJan?=
 =?us-ascii?Q?dWwxXFJ2wGLNVe4wg/sBBGvc6T65vhwoQTcQ3KYTzD2s1Ss1xZLzvzhmRhGu?=
 =?us-ascii?Q?loGdeg95iNpSd99XoHIGxYlM8HNDkguHA7tA/5HmExDMZARTGbYk7vLARzD1?=
 =?us-ascii?Q?iAoRKe1bglnTAtroOAEPO6IiTU0ZmFAUh4r2XQPw61fOKNzIt5yom1Kns1dK?=
 =?us-ascii?Q?cnNh1CLWgLTOoc4YkAKUsSfImzj/zhTXNTHpyjanWrZZ4MBhmInnHw3I+nrX?=
 =?us-ascii?Q?teNIOcozkzguFPGPOI+QFl+WLsHlADriXnwQowsmC1wi3ye9Ei/r3fWdmuc9?=
 =?us-ascii?Q?iUeCmugWXO27kHenrUxgt7QKl+JoSY9x/otqoYfRSAy6nLevHOP7yuunguve?=
 =?us-ascii?Q?f/g9Gsun8J2YMOJ1RksjgfmGl3snIO3S/f5juCWJvxnWLtJLe4TD9+kbKCtd?=
 =?us-ascii?Q?BmGMYQXjG28TSfvC9L/gZlAcUrdvp3yt9T1AAkboxi26X8UD5vSJnm5/feUJ?=
 =?us-ascii?Q?thtyL56FysPudEvcMnoud7zTQMxjVRaGnpjihL25C1wQjpaeJijVCe6D0IzF?=
 =?us-ascii?Q?1XP7/TKJ7t8sQNLw9s3casGMAJtrVI9tOFFaQF2CRfGAvj9zeI3rhALRkDAQ?=
 =?us-ascii?Q?LUcLW390bJwTLS2ma7mNsy9WqLEULy9tzP4vik1t4VIlIzw9yTIAPUaIpp+f?=
 =?us-ascii?Q?v7Np4GDayXvVwkYJeoxI1Icc40exae5TC1X+vQUpZ5Vmb7GEZ6zP9Qv/FVoj?=
 =?us-ascii?Q?X7K3jn00e07fJekJxwcowH5rG5bRJpIXfXcvVU/P7hyRMg8y7cx2py8fhgPT?=
 =?us-ascii?Q?hZWXGdKtwwKEI4m5S5S5FENSnDcK9xFf5kPZb+wVGX21gJneZ3H6W47tpvHx?=
 =?us-ascii?Q?0Rkm76wkZA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a8cd6-e21b-4c34-4f56-08da26ab02fe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:01:55.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc/lBlz8AQLtC4DGdc926lZ3st1fnZKw8ZiA4nf264CAQjmsdmjohehh72pVk1sHbLHwPoDiRpwOySs9WU9pkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 851e6faf8c05..955706c666d8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
new file mode 100644
index 000000000000..5ee63e3e4759
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -0,0 +1,130 @@
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
+	pinctrl-names = "default";
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

