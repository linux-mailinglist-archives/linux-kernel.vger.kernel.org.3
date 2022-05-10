Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C98521127
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiEJJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiEJJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:42:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA636B52;
        Tue, 10 May 2022 02:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N97D7lYk/JkxWcGpf0VI9ZGMeZvIOwI/G0DUUFOb63zfCvrQA2kpW5ZGvp//yrHfTxDm8Dv23pYH4OBMCMiYkLQ1QrfO6BkeW1C/FZrKxdtd9tOgP2maWjlUC6NoWh/BsXj+Cj2nK29b28eVHg+RWUA85GRCTGYYcoIHMkNibQWxswvMTqsk9qKJcYx3RM68fMWQZ80rz/aZpV1NV2+59FJQD5rs2+geH9iqjbdj3ZQWze7+gSAhu5UEQzCtSRunN8SarhPUNIME0Nsq5PCZkA1WezFniD8UZ7b522HLkwpvqQM6sDRvHfNpeISruvC/+fbyegKapHqfnUJaLSlJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POqLW0V4gZ4OP514nVxbs033KxW/HALly6POnQWGx90=;
 b=brQfsPFrvuNNCJHtkCaBqAIQXadgyoGX7RV+tuIcSjfCpQdO0ZvUTygFml6BwnvZ4yPQ1cQnFaJLWv0f1xEWCBz3IL62p5ZDxZVNX+FKHjehyx+DOMhcQKqbetQUkwcRC/+4pSfbIFEsxCNIvpBliC0E/B2VYSVDt/M3gyRcXfxQkD8lwzEnmErQhnQVefTwigNx8zI4CfhcivASZIs/rcXf4hcStuF+6X5lHQ8KTvHNJqgsfOFJ1C1tgnnTHB4OpF2m6iCrki+whHfwtX/eTdD31wiCxsazL/C7ywMiqnivMcv4TxHrFysa/i9CZXHJuiy2mxUGCKy29VRP7YkaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POqLW0V4gZ4OP514nVxbs033KxW/HALly6POnQWGx90=;
 b=LD9+18YnfaIPZpjoHVDd61mdFxJvJZcjIkhbGCL1JoY72fjnMfzUHAmXdoiR5QCGe5Q0FIgRvZluKlxAzCpBkPeJ8PmQCQSG+O4oSLP8Gmr7HZAx0CZkTre3AEOJCeQGPbve/crFISCPF3WkYLbwn0B8IiD+PBOxoIR2ORDVpSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9406.eurprd04.prod.outlook.com (2603:10a6:20b:4da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:38:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:38:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V5 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Tue, 10 May 2022 17:39:45 +0800
Message-Id: <20220510093946.335036-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510093946.335036-1-peng.fan@oss.nxp.com>
References: <20220510093946.335036-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5370c134-1397-4607-f9d7-08da3268ce83
X-MS-TrafficTypeDiagnostic: AS1PR04MB9406:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS1PR04MB9406E4DCABB07BACEEA33BB2C9C99@AS1PR04MB9406.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Go2oP00fjGcbdzH5KD1BShBaaiOwl+8+TMd0x17z0gwCkKzAP11xvn6czmxeBiyvHsJC4Qn8/T4LYzPQMc2BjPX+mF3q4kcJNoAyuIbLufC8CAlWgSnq7JZ3s72vD9GZB4JIdXFJhl4eZqvEw3EZd8PNyt/I2NcFN1sfDjEjbNGxsf14/+nYxH6pSk336JL2MjiabVwgWmuqk/M8PQPCTRUzedxoDmGzPu8ayru4IsUuNiYglIcQwioO8qNH6gqq616vquliEG7zhoA8RuUekAXdZPc0Nsw3tr8RbCpg34NNcS3p4lRbqhVNq8pkueN92kIedOsuarDg08hRtKXkmzv0aBDn5ovhJVZRCr/NjX6d6idvPoHWVyCPot5r2VVNVNgLO72HDASMBiIfstXB2zaWUEztTX4YyHDQdyRAIPLvLl447qy8Gu359pH8psX7RPIESADm4aGlTcukHFVXL7956J9txK2OjQ9wKodbentWfG5Btm2FJT88Ew9Y1nGtytt5k3/A9IZ7saPPOgXOB41vyYs55McD4+zfgJr99sO58zcFkBbLLC64lhwMEWk0M3KXuVcfH9QAt6COTcqoxoJsPfPELznvmmCAHgBXPkgKnCddhsR627FIR5B8q6ckNcARN2fwHXhZcRilzJ6U/JFXopvEsK7jTfD94kKtqqtn+kJtY3/Xz+fjWahnRV46HwetuwJXFfuhiXL/kpjHGLeCB6KKgZmV4fuKjgizWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(2906002)(5660300002)(54906003)(38100700002)(38350700002)(4326008)(6506007)(8676002)(66556008)(66476007)(66946007)(52116002)(6512007)(1076003)(6486002)(186003)(26005)(2616005)(508600001)(6666004)(86362001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFUwKGfK4s4mO7Y4SEd+5Xn4uwYP5dezWr3H+E7XqKYJI20nLVJEEpqvj0Bp?=
 =?us-ascii?Q?O5IW3YlGU078BsrguUh+ogic9B88vu+o1gvqwgJi8LmzVdRgg4zB7GC4SXrb?=
 =?us-ascii?Q?25YKKjAY9CKj3oF1oDa97STmwUr9heBa0zkUoW08KyoH3K189WYEgIHIxmsW?=
 =?us-ascii?Q?0m9wIcJrLGcGPZpYbpOR3QgHPWrpemQSrxiL2AUQ1wKRrPdQYHkTy+KnxWUa?=
 =?us-ascii?Q?x5iUgX9NyhuQae76tXDDd3F4OAERs3fpSA6u9jBUPW3ocH0jbGzTZ/Jjdsfd?=
 =?us-ascii?Q?zwdNse6RhW43GyECR4cM8dl+e5RgxPclBOv7k4AaZmN4DYhjhNVVwEK4kWAI?=
 =?us-ascii?Q?TDFGFzZTyicDbDst5/mOQuplA6FtqxcCnPYm5CJJozP1Yc6lEWXn5n5xwKRW?=
 =?us-ascii?Q?UJw1lfyPqUcz1JUJwMRmTIaeafZO85oLO5rJU8PYbESVuJmC9PQX9d9quNKj?=
 =?us-ascii?Q?Zqm+1B5kI/cOiwBHAdSQ4+fZAQogGPzdlemSl3vBD5H34dbjH/zn5+M4dPjs?=
 =?us-ascii?Q?g3aEDx9+b4SHXGy8grH3AEFvbKoURD4owXMdXIDzS1aMcTJ4RZIycJ1U7ksA?=
 =?us-ascii?Q?MSp7XySvCLQ4DPN1kiVhcuHZkFmNfcWrqpenAXw0M8F1+tTAYJZLJF/d8P6K?=
 =?us-ascii?Q?fGSgoBeZPYfDTKY843uKCx2DtKuUFFJI3/AzwbACHOsO6cp53vCFsF/HnR+o?=
 =?us-ascii?Q?G95+G9spoF9ASAKvUZdMDCE4rMqQfkESL60ZHalNbOb3L2x34xfb8wSCCRoo?=
 =?us-ascii?Q?XcbQQMSiviDEQh0T7DE6dQyemkoxSjxj65W5i0tEf9imcSqElmV0jQiMHkF7?=
 =?us-ascii?Q?a6wVEU03Fg6hCkKud2k3Sshtw7hrTABPPzqfkz+IkkYoBmsj8HQcXQtHdb/i?=
 =?us-ascii?Q?bA6/XXHNb8IT7Lf5n3WphFmHagU9+UdSHgy4ZzGE8mNG6z/3U8vaVzU+sqJM?=
 =?us-ascii?Q?+0KZANg0eC7oYZbFs5ZtNHOkUyDy9gKn31tLCw6uKSaTPQHqDxJNpnWTH30y?=
 =?us-ascii?Q?3YdDH/H/1HSQ4FoEMx2p+Dlogy40hFjHRqfFJArTxLOTnY9qacgLsqjBpbe8?=
 =?us-ascii?Q?RUzqDjGBUQN2AtR9vDG/Mj720yT8KMnXD6pUh7WXCDRg/2cP+4QnvnlUsIUV?=
 =?us-ascii?Q?Q+OHO/t2ugdXxCyUIz1155mRTh8tqFMyCO/IgyYHr+ipBmFnSqSOAVQZ4cV1?=
 =?us-ascii?Q?/1nfxD0mUINAPtYhIxCoJjz/5RHMsFc+bh77swhf0EShNrzO7Lm66fJtVEVa?=
 =?us-ascii?Q?WPo2/Us381HBrjvaofrF9qxtpeGkwP//AhA81fFGKRGIElUobm3hIPZzFccM?=
 =?us-ascii?Q?sEw4YZVSz7WWwDmMFqGrmF3DB4aiW7vYhLrRkB/8B4cUOH1A///BpcHbu1IH?=
 =?us-ascii?Q?MdNVOP46bYK9nlHt+dBEE91mWZEOy4cp+cviyIUQE9aX5xIkO8SQ9Wgs+Hxm?=
 =?us-ascii?Q?JgoOVUDC6n+IYJ5IeNx997bYBI1fZN2GkyuNscTIAMRG5joL8RHc3oFcRtCF?=
 =?us-ascii?Q?3/eJbzQZxvoa6Qgd+7DTjAFgJjg0F24qI/2YOv0RZexZjnFI3vrZsSz2eI1w?=
 =?us-ascii?Q?A18zD4ghe/ilHfSrmINEhCi2gFSP6odkojG5Oei6ewVR2aQihgNGYVMdNVfu?=
 =?us-ascii?Q?TbyJq4MFOsjCJDDkvGTVy87N/bfYRbBvEFI23ug85f0hGoLA6aeBHeIhYZZK?=
 =?us-ascii?Q?TdEHgL6w9PN5HnW0ZMApD376wAGKr2BYuxD9S8gQnKXNpP29fpVuGnn8AQJD?=
 =?us-ascii?Q?DN4ySyM7sw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370c134-1397-4607-f9d7-08da3268ce83
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:38:15.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr3WKWHUrQaeekZJc33WWdwh/6kxwer5BAMx3hVANOrCo+cJbH37EvAtE/GO1//LCcaDe0LFkJEHqJ2oaO3bdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9406
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

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 238a83e5b8c6..c288bda8aa36 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
new file mode 100644
index 000000000000..86ae41a5bd76
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

