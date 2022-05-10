Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F85215A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiEJMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbiEJMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:43:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE42B277A;
        Tue, 10 May 2022 05:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqXP7cme348tsJOHZBmLuRjO3o3LhA4Dp5cPBxTsJiQAyy1ZNv7NK1hG+GpZGhvx07f7bIqYGqwJgF/yfXO/m7LHIq/4GGY+KvxsCm3Cm0i7lh2O9yBT3Wz68bHsOWbKztIQ+0ZaGS/pOU/jdaCtARxaLOXzFOZg1sAvXGS3/OzEf1c1TXh8qGDlD+VtGwvab0RItUGoUgHZEF2JRQ0jW6lCQBQS0BEBe2Jxi8P/skHU74+gF3mmSEiFuVm14heMHdsOzdc/UgYq6pMj4DwxuLuRf9ZMIrce8jQyXSf26hBdOg6lOvuNGNo0MWZOpMnv96XaoPCLhhdR1y1tn0fzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1AMQ3cwHc/0U3RLzZvLQKEMiplyA3gUttCTU6YrsVY=;
 b=UxIypo0MIv7WEVz23q8t7CMl9tGfZUOSv8lZTx4WTHDC8pEiVYQrJfsQpLKDAWm6+opUq5iHpQ6uFyp8Fb6+yftMXEl2f44/Y2MLYrCK8wfQ3as+l40jTbEn0WZX0uU2+hib5EfEFiqs9AgMYHyy4se5tz/5NhvVvpOA9hrPVilQ83lwlrX9eYfhJ+cCdSKGYsowqLsGXId9BAiKaV7hTdvgPd59whgFCF9dYHJrAKgAkp1uTa+FzAkAtZqVwsmXDXxUmX4Q605iuiMoh1hJrL1z7lWFLgeBntM2WLbGXaM2WMoq98Fr4n0t0ET/e8qYLPdCuBL66Yi8B0NP6/Nujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1AMQ3cwHc/0U3RLzZvLQKEMiplyA3gUttCTU6YrsVY=;
 b=NQe1gf/E/wHJEDYsqzHbLiYwmcnVmuK0cb2KYZw6dujFphFxmBqi18gGVFYajNtEBpEKhphQzWzxlqYa143rIqNJZEfsrdNySpU8HtlS/F0PCnDo7U5fVT3qfuQR110uYspjjGodRl+y2vgEMFmipH8afovvu7R+Uv2R6v1apHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8937.eurprd04.prod.outlook.com (2603:10a6:20b:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 12:39:22 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:39:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V6 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Tue, 10 May 2022 20:40:49 +0800
Message-Id: <20220510124050.398891-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510124050.398891-1-peng.fan@oss.nxp.com>
References: <20220510124050.398891-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb98838d-5801-4785-61c1-08da32821bab
X-MS-TrafficTypeDiagnostic: AM9PR04MB8937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8937187F2524F2B9A57B4D71C9C99@AM9PR04MB8937.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+TJWIIPeQjMoECk8El8jWXWOoSvrZK1R09mCqdfnnKBabuCbC/qcJj/8WIn5w6R1AdgdBfgY5qE+J+0ywjP4RgvMW3iOs8zAosIb7+S042VmwMB7mlY6JCByxPwDON1/9MCFUI5lQoDm7lqeb+2GPjgAqTH+0O1t8e6RRlB6zleGeaq+5YGELX5FTp8w6OzmUP2eQ7suOVuvP8LMMn+NbT0IRmfgbPsa62FQ+4vBLtvnHnskQBr/+8ywVLZ/qv50iMrWiMCRnnDABJv1vxcQCwDZTdLZmi2aOnj3R+I8D+AZ6Ea+VXeZlffkUcii4d8FiIoVn/z1Jzj2/qs6qAI5lnUsdNxVggoaqZvEbPPXZwc3cc1z/uMqGXOB0FGkmhbFpF2ZCp3K6qqSVCRY2vFfcph1zBcW8sGIf176pR6Yfm7ueGKtrD3mamGs9S3dfbK3T5Lk8xkr+uBRh8XCEiT0Mb+uJRdq/t9Ei8bOMUszqd/E405ZYI6Y6SsriV9LT1aQ/nErNIejOElUrkJ9ls3jYDL9S6MWa2/l9jfJB2rkmmmbw5sJiaMrHNH/atWVGqqkEFQ4+umb/8rd9xsZ5bLti/FPD3lzYbtLkJoX1CVBhMQC5H1xH7WA465t0nQRorObPizWfbX1Ux5lPRu9SttVcIr8iDjVf8tdc+82OGyqjlMncAMRFrzVsvsE94ZNGIbOQMf2uHeJKAi6pO35JTu3n4QPUFenj9succ20EI5dnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(38100700002)(38350700002)(5660300002)(6506007)(1076003)(4326008)(186003)(508600001)(66556008)(66946007)(2616005)(8676002)(66476007)(316002)(54906003)(52116002)(6512007)(26005)(86362001)(6666004)(6486002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJZyhN8SnGoiRvmFtiwZ3/VdZKsyz4gzh1nPeb1pZBczovI2mqSdeFsQn276?=
 =?us-ascii?Q?WktHOZbIsseJ4KItBlG1UCvSklnRVwnVgVjXVPM3GF+YFJ24Ru16GkZTY1r5?=
 =?us-ascii?Q?DW1n4W+iX0Sn7XY2C4C/r1vc7xeiuBokwlBZr4pLSd9V/sWu7fQeslI+dzKD?=
 =?us-ascii?Q?jR/ioF+8hNN8iZ7sdcUeCX5vvHvj5qw/D0jpvKBwTusKDT/1UiLjIseJvCic?=
 =?us-ascii?Q?NormtQbnuYa7a3tYhaw6Gei8vA+DuRZXv7RHh8AVGJBqmHWxuAZGBtfb4YAG?=
 =?us-ascii?Q?Lrtv5yOXVv7iQKdP62/0/0tNj59QawfJDoAUWlFT6I1WvAOjQRWshZCAqlyM?=
 =?us-ascii?Q?gL4y1Td+0hl2vKZ8BynGbFE1Fk8bIF4IzXQA8zFx7X0Z6uUX3Hx4qyH5e4hS?=
 =?us-ascii?Q?erza+vkmerOa5DPWp/TWz9qPQxfqChsy7deX6N2ZwB29Qxojvf4HtSORaPtL?=
 =?us-ascii?Q?za149kZgGmHQJobb1CfmSy8lqM/b6NevWw2g+whjOuYvB92+/pZmpbgBeVy2?=
 =?us-ascii?Q?r+DaY9Z/wwSj87TZ9ee8Sg7hekinl/sleS02gEaV2AReEZU6aXixiEDwT8VS?=
 =?us-ascii?Q?KR6kA+y0WpZ4jGReeu24pXHtwh0Swe6ng0j6xJdGyz3Nvb2GnTsuus6fu+7f?=
 =?us-ascii?Q?bpD2kZ98qbYLpIEjglwty3Sl5jJ1/VXfhGs7K4yjV57u1pvkrT0IpobK2vM9?=
 =?us-ascii?Q?XAZsyPTpUiB4dWN1uORuCsKSs45PmQ72Yfkx8f+tMkrg234cdfJG8QbMTEhJ?=
 =?us-ascii?Q?njhXax3UBlS03qWIfpbbRCqGYAqnhz0aACD0+6qscUPYWhcw1l68hVoXj6QM?=
 =?us-ascii?Q?s2BuFSTMiRYfhE6o07tRtk8lVQvjltVj6a7m8s84TnnbvYRuW2LUuXP/n1AA?=
 =?us-ascii?Q?WVsyx1LrFt4tIMu2ofIIDr7i9oiIOxq+7eHqofJI/GosyvqzWC/78AwnBjnJ?=
 =?us-ascii?Q?r1LXCCNSiCZFlESjGzYqXhuU41RS9ZkG3ZVNcznEe6qFzEuGZN3GTbGkqbah?=
 =?us-ascii?Q?wZBp7UiK5FryNQ/ugwlJytZU6p/R7PGkqC+ELZkfjlKRMNY4UnlDeT9+bU0D?=
 =?us-ascii?Q?poBBLgM+JNAgIWGKM6JFt5E+N9i1cmVnM9IVKdrnaethCU5ogOiEEaQphr06?=
 =?us-ascii?Q?MYagu90g8j99ir1ttIZgXldDxVNqL+CC17o1uSFGrxK74JHtZKAANp4ZQz8j?=
 =?us-ascii?Q?gaJ44eY01yqaWeSuKQzIyFkgG+CYLsRbr+skMgsAeLD8cOYLw8KQpbZwPXeZ?=
 =?us-ascii?Q?KZYjSYvAu0x1oZRyMTO317A93aN6yweH+IzjaBxjkVcVZEWyz+DDC5KeFkaJ?=
 =?us-ascii?Q?59L7WxypN83+lDlDOh4LiaOx863eRMe9p2lqeoQO1kYoFKjvMNJody3ClKEk?=
 =?us-ascii?Q?jLiIrII14h9LosGbZCm+83hnfdByg7M/iM6+u/O8JAFYCx0WZhpqyPYfwtFL?=
 =?us-ascii?Q?Szf1DwmH2NEOcAu0RjfdAAALnNdRqg9Vs0Ne9YIrJULQyoIwnTX51S3BYJ1m?=
 =?us-ascii?Q?GSF9/xTK8/t3/P5cWUecdRnhRL3aex0EtWcs2pGpQCUpapJZAIgdCIwWDoRL?=
 =?us-ascii?Q?aEQ+D6B1fOglddiGUioySwIztAa4cHgqbK0lsN4Aj7uYQ44PP6b9gMLzi0ZY?=
 =?us-ascii?Q?rnE8CUTA6LtZn/EH36saQEPbtpEQFYi11KTFUuzF0STpkrjYthuzoRKPfn4H?=
 =?us-ascii?Q?RL2w9hWvs8xUO/iTF7P7HpFYnc+o6slTe2d7acAjEOPPBjY8UrlSceV4gvBw?=
 =?us-ascii?Q?vjGd4mOyQg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb98838d-5801-4785-61c1-08da32821bab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:39:22.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvCnyOTz0tpcfg0k232V8PBuQbuq2seZPjhJoudcmd/geBchhPCyhG+rQT4MS6D4lHsaS8jTbgLaae6axlug+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8937
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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
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
index 000000000000..69786c326db0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -0,0 +1,114 @@
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

