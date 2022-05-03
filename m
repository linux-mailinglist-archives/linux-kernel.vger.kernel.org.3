Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04A518451
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiECMcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiECMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:32:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0437BC7;
        Tue,  3 May 2022 05:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmpJr6njUoh0Mf5F8YvZilbPCQH/ptaiIFGSm84gBtRh0mEfg9txvV+2Ey6NgrZereMyJNVccSkj5dP6ym4s7YKE2X2OXNGD2ArbcLRQPSBwmG8Pt0ftqpheQ/5ZudcPNIaQMM23gdZgACoXf3Ms8kbIwpqhVoCa5/IzrgFrPl/5nk8s11YjA4dut4T+dmPLqTV5zl260QnnD5fFGwC8J/r1cx585EWpn+NX+hNa9vEdjl7xXzLpl2psrZ/tztB0UnZWlr6LaVCY7rv9rza9u0lUWuS+knqNRmuX9pOx2ZcrBNsOfuwZ4ysozzzcYMtiK1PgkbMCZKcZnO51SoFcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmGYNDqGzoqjdHhVAyeDac03qqihuhha4+tEDpD/uoo=;
 b=BSt10debQBE2M1vx3HQewPnshht+UaQX8oryNwM3XN9I1iV5am+nG3WBDS70AKT5XrYGT10rTt/1vrHLY0ezPnPN22IOipvC8MJ1kTUGFsNmOpXQZz+g8k1sREWKfKti0fzg6VkV3RsqGgwsNsV5EQ8EfPHtrGNWDWLj38umx3VD1NaD6GX0QKjw0U4OSTVIers7C0UG/wsfrhnjsrVVl3xsKXEspy84bCfL92YzxMUAWGDGjJfR6Kcpl/40X7cetiVm9ShAVlQxLppJosSgzWlmM97F2tlVJRu+/B1PqE4VScjBwqweSdj+ltMAwBXwe3Aowq6hP/UZcAsxhJ4Wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmGYNDqGzoqjdHhVAyeDac03qqihuhha4+tEDpD/uoo=;
 b=K9gnUstNk2L6+h4gH51URWIgvDPgigJ28CUW3/RpVvLyEt8EdEq3JzWrC4rQUmEU//yi9GTEz6Br82WMHD7BsTrr339ZVLFKzJ4UZ+4RNvJwyGBQJ7NVaFgzT61n9KWyR3N8nq3kN9fLRPC6BsK8dtGZUnwtOfZpJee01Pqt200=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2528.eurprd04.prod.outlook.com (2603:10a6:800:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 12:28:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 12:28:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Tue,  3 May 2022 20:29:50 +0800
Message-Id: <20220503122951.4147636-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd3a8a7b-4b73-42a8-3273-08da2d006e5d
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2528:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB252805036949613AEF91DF8FC9C09@VI1PR0401MB2528.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8s2eKGpzSvJw8SzPqaFCTxXHPJsuKNdxbUiK063l7zSQJu6WmPFMvm0XxjHr9PwUoNAhSX7o6whWgYLDJHYP1gXyaI3rLv60eHDCnJ7gC7incSIm7/snQbQ3ngUx6nvgYOjVU4aJG6kNlTA197Yrq+VXnzd2KWGABSOxfIEtwEd8op60D0w59Q5i/9EAXomC4Okpfq+H6+W7wpG71MV0HbBH6T5twQEkYebSegMFPBVusScCZ1n8ysrvYD9Pb00xtGwmfYEn4rGp0R7EpZYn5zsLkQKcwxf1QwQqNFkyDmCIJL1CEkgmSIkhjzSs07t/mHkM75CGkuaKZ2yFIFw0e1uwwpF5WFQ9sYSpb1t4Ll0E7GDWZY5rUNv7tZgaUuNzaXVG5JiHom0YsixhCY8Gu1wVfHAyKFJneA+0vNCqn3LGYBCesL+nSjK0N2Hl2AugMt/Uzb8EIRDRx/vcEXJSpr/vHMjHEwAwSsEcR8IP8j8C5RcWI2Sc27/tpfTssvRHNEzzcLv8ue1So1dR6w/fVa5uA8DLkJ6+MW48J3y3ek/6YnBd6QZbFZrcDiYiKVcf6lxP8jTnCnzS+w2ngFZbssX6K7Nmb7hyA5XHFDRvqt9oZMeZVPQN6D2Gz58PRvpAfjiTCwh5ODtE/3zB9QoHlS5ZWkZaBSsKmEcAdZCwjap8+3S3yD5miR5O+aLKiclIlyJizH30dQOwoJr0JfjeFO0xbkKPwRUnlIal6W5O9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(38100700002)(38350700002)(8936002)(52116002)(6512007)(26005)(6486002)(508600001)(316002)(2616005)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(86362001)(66946007)(2906002)(5660300002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q9CkSPp3wk/OvElWGmg5RR7ueGNpISoUVH8FFnFGSC4Ppbkkga6LBpp0TlC7?=
 =?us-ascii?Q?XJz5wvugD4H7QjDSv6pn6uS8ZcYuWiAHj0cM2nN9dMlkzMhQLS6E4y5B6qea?=
 =?us-ascii?Q?mkUXEjeXixKn/A1qfhOufSHH9DAKpbjiXbe6YmfD7KpcegCwdhOjXoxWYpqE?=
 =?us-ascii?Q?fXyAO7QXr2iyAMVhCCpqO5GBjjqke/6aINHsBd/5qdhCBCwfZdIzP1/ltsKf?=
 =?us-ascii?Q?E0XPXXYhtua3zYKOUMfePZtJP+2VC5aNoNzO040sGomlLulLpPyTwhZNy7M4?=
 =?us-ascii?Q?NUrZe+eD2p6Ci6oVlVjM9D0apXstrpYPJOn11xN5m7I7CiV7WEixHJ8MIpwq?=
 =?us-ascii?Q?WeSzVKLSZ0nyh1RZ5HFU/+j+vE2UKbN4QeZJx8FrniGWRRBvIU7drRA63Ahi?=
 =?us-ascii?Q?OJ5Z+75UHkiNCqciYytD4yGMQoP0Z8GGjOJqePC7WOiyApTnKqesPVSo6b4X?=
 =?us-ascii?Q?EJ9x8/ryyMhuE430QNBtv9WTxEnCQtZkn4d+IntW0yS3GCs89IVZ6KczYKHE?=
 =?us-ascii?Q?cO0ZK/92nXYjwpf4hH75Cbr96RkXwRs8tExUXYGSuoPZb3+d6YZ4+RHt1ZFi?=
 =?us-ascii?Q?rTojyDHlXBc3+YQgE8MsFihahrvEinOLwplG+FrfVA7LKIpCIyuAif19jC0/?=
 =?us-ascii?Q?rfmEVchE+Bc6RtlceBLd/KvClm/bR7ru64hz3GRYbO3Yz264TmdDYO2OdZvO?=
 =?us-ascii?Q?lBJVmIgCA0xWG2DIJ6i8IenmsyjYjaSOWEAIhwXujL/ZS3+tA8orp7SQgO4/?=
 =?us-ascii?Q?fcohbw9pbU9sg3E1tqL6Iwib/CMiVU5nglGvs4YVLNYbcC4fFFIT0802Lp+J?=
 =?us-ascii?Q?1UBZuzYgR24kznzc3DOWu0GtD+SLSjBsndkX3K0WK8iEkJeFVA3hhjARWSV/?=
 =?us-ascii?Q?/HWS/NWzQ5FbqgHeBmNeUeSJzBZeRMRhtYch/nNtmYbAUdoaBKp6RMc//7Xz?=
 =?us-ascii?Q?FY/ZQbIFB6nhnb0/03w5qahbspgmOGIS2m/j+opIDo3nBCMA+ihc7Jl6AVKA?=
 =?us-ascii?Q?FbdGRabhK4mNOeVSwimf44i9IWXwasds0twcaRcOZpsGmtb6C9IJYzycxxus?=
 =?us-ascii?Q?wIUmWy8EwedAooBfxtHIvVrlCyL6tWEYEvfiB5GQxTURrgxcqsyLKZ4NS95F?=
 =?us-ascii?Q?fiUImKv9TrQSQXJ2PNJhqw4DpNroCZV/jVeNqEA9NACvKikt8Y8uwuE4yUeu?=
 =?us-ascii?Q?ApisZa1A+pX4fsdBYw6w0c7C8mVE4YkCwu+PIKQBPp/VaOZYxRnls2mSnE7T?=
 =?us-ascii?Q?xNp0tkrvN3oPNTBYU7q1zQazp7yl0BMEoOTEe3bx8xQKnY7tA4vIWXj87jzJ?=
 =?us-ascii?Q?rdZ60+c9Nn1yQjDWJqES4cqxXGGL087QHGc8cbAgm3OXxfxg/4LY4fV/ps1R?=
 =?us-ascii?Q?1nWv0ee/0uagvFjGWL1j6nWVEEJZ30kxStQnuEeUv4BtX4TO0cyARdRIpKVB?=
 =?us-ascii?Q?rf6KGixyAkQSsmXT3YDkPw7G67CAYRVavxzk0E1dXHd4CGhH+Y+AJogxGdmQ?=
 =?us-ascii?Q?alzfL9HluoI9ctlVXDkk4DsMrZSyqymPW0MMcFLGq9sN95ldm1qD5PaPs2iW?=
 =?us-ascii?Q?2SP+JUsZir6Nkyoylh/c4ke5aai+h2hsWORu3ZxF9rC/Qes9C0uMOfx4cr59?=
 =?us-ascii?Q?oK4Ruy5zmMVzZ1NJG3nq1iuuWta9SadW+M8KOgVfWXn/uTI1NqgQCpLtXzpe?=
 =?us-ascii?Q?IAKN7/f6/1rm85MhkQTlNRkzToF93vhGFQQ1g0oD5nHrT+LJN/0TSwDVqubr?=
 =?us-ascii?Q?DY+d4a2sqQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3a8a7b-4b73-42a8-3273-08da2d006e5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 12:28:30.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4e7SGcQWFncvUX4rZO/9Lky/NzdodY2hHGCR3wEw/UURr6G5w0w8AXhcd6tHR7uHS+TQIgIqIEKNgB9nUfvQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2528
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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
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

