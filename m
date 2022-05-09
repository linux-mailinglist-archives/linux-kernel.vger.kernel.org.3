Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE551F637
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiEIHfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiEIHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:32:50 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50086.outbound.protection.outlook.com [40.107.5.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E217D3A1;
        Mon,  9 May 2022 00:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bggeGu2sIo87pFm1KMpvVXG8YRRPpbtgPJiobh63z/z6q2WGGPLjE9l6puEewIHH37+2pY+O2U2gBW3+9eYFhyQoFUKLzkn09YTyjgw3aGOozetWBsokprDHTvjMv1csXQw6xPd7Tk7GIn8twhl/KnEBQ3TIH+7JxzQkpdBnezcjRykzxHm9jvca/BZ1xm808c3RKIgDBWvuBLnnn41+tz9bAJHRxA2NCGsbXVE6C2TZ7Pjv+Tllbwh4iXIDWMgW/ILvhSWBWUjmdm4UvZ4qlCVN5nabSBkn8aD2POg6EJHGdM18WziTRbjYjBtw7aMcLfqf/mQ0dywwA8JmIVnd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3uk4BJazamrwy8MyMGKhge05b2WFRpgGtDbsiN+6Vw=;
 b=Mze4J5GCJmcE8vzRAOagyJcv71WwdjtRj9RlAMGR9ro/oAgjwW3Un2xOQb6TGXmnEA0mQMHv4/eYRUqyLLdMU0gKE3I1WXMY3jWA9MuaxvntuP4sI8Px+I/6e4osKJrrS2ntqkY3CaqUDhF4D92GyarViUWDL980lygPYG/vZe7KC7/CIfN5J7YseWxJONHHafPYyIvsUT6D8dL/xSwLqBa0rs3gFb1sDeVxz9HF8LpE4lpI7gRkHNatWiUilEmJJp2RtNNl+pjl3TFB1fUDyNdX7LICHhhiIzKBJnyqIN5w/MQrK6cmSo0KB9VjNCJcdq/waMA8POS7YEFgrT/AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3uk4BJazamrwy8MyMGKhge05b2WFRpgGtDbsiN+6Vw=;
 b=blwxRnt86N/7K4ue8fCxuBa7F+hq1HGcf58EWhvqEJshIgKk8kiESiC8jDz+BIBu8LCif00kunHhcuYa+MRfnMTzX6WspjHKKRy04C/uBCTSQpUpj5Es0Cq02gW9yz7Xq3xNJxGxm1vZof8seQzCPxOtE/21cPVfG48hh9FNssM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3330.eurprd04.prod.outlook.com (2603:10a6:208:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:27:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 07:27:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
Date:   Mon,  9 May 2022 15:29:10 +0800
Message-Id: <20220509072911.3268668-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf7005e-4c65-44b3-716b-08da318d6366
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3330:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB333006661B8AD60990C1F87AC9C69@AM0PR0402MB3330.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeSODf88axWSajM86OC8K75AHVMUjnPeyaNkf2qVL5UgG8S59hXFzEHEzAi8JTL8UO50S/CYjcx/wnjolbb/5h3BGt1nJ8TJC7nw2WQTaRmxhJPppPC2ChzPDbeyFzaQCH0ETnXxAyp89ezwyBUX1xXkVeNe1XUPp1dSNmhWZ1MThyu58skTh/hYsQNMAuQo6F8v+cnQSVSiUVSAmVWJq0nk5rYrLD8PGVilT4w9WMcITBMCJYu7XiDRq4NPrGNMIOLfMARnZgN09UYQF7QDUC4mJkHdKkKI0eMGvyWY58W77N3zPgDVbwcbv5nfc63h3b4Ra0Kqx6qri7HbAwmbt8Lh4vWrs+evaMjQO9PBxvhPVKvq+bEyKgBGehZgywVPINMEo3poaC2UpUfpcyHN3QJJtI8IW7DCxrFMh33ol3zbk8535O7mLO8Z0L7tw7UEEItqRdR1R3OXMciiflQ6Q8OHmrI2AvfcAf+aYmzXDdWSvImX4FoacHbYmBl9X8qorbem1nGKBO9NrPWzprq2zull2vrJjvCty2Sx9gO51JJjo3VmUQBrS79JlU052tDc5BBvkkipdMPxFUY8twl+ZBYnH77P7e3jNdsrUqVZBjfxbDFKLsKR4T82Hy8/cOJbipVtclEi+Dm5agISogAFn8TuMEDfxdn88qG7d0mV20eQTChnU8Vs3TE5krbotNxNMZIUpG2q3NDp8UZVwmwpQogxSJVUTVB0FqZrQw1W7BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(6512007)(8676002)(4326008)(52116002)(8936002)(86362001)(5660300002)(66556008)(66476007)(26005)(2616005)(66946007)(316002)(6486002)(508600001)(38350700002)(1076003)(38100700002)(186003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14c4CUzzzRh1pF9TwVbkZAm5pQKvxKab9BBbAx0ug9TFao+RI/T+puKwA3MQ?=
 =?us-ascii?Q?E0GDoiqoemx9TEeBFEWB9cPklDJiyFleBs1TggPuOD6iNSEQpGQwTKxQnbaS?=
 =?us-ascii?Q?J2i8OJ4qgxisRhZXOorcXzk32HrVrPoHVHEzkw7zSq/V8sIzr5WhCZlFY/X5?=
 =?us-ascii?Q?+g4igkVryME1I5g/TDQkilnKlaXSMHg4d9k7QKQpTSb/k6QFYujgyvjGyq4q?=
 =?us-ascii?Q?VcV+Hc8AoXQdpqSpuWYiKcFPVB7kDAvg/PsmjkzhLtuFC4q98vXK2pHt7T/h?=
 =?us-ascii?Q?QTkfn1lakYpmAkQwOMzGXPD9TWHUyKzjQrqWixwf1Jnv80FW4JvkBSexd3LI?=
 =?us-ascii?Q?iIozMZwopgbCTxMKW+k2mc8HvfTuUcRsmZmo0C5q4V2nuNVCkL3db2qtqIW4?=
 =?us-ascii?Q?wmLfTBd7DTi4A/zooGXURcmeUW8uo4mNwmbmV4AStSYhPtxO+PUNjCDxPdX7?=
 =?us-ascii?Q?4MGOkHqz838wVZ0f/eZD0YgpKv/cHfvXJx6WfnnboEk+6oQyH04J8dBzevJW?=
 =?us-ascii?Q?91YzpUMBLWVrOm2SWtjr2xLnmxU5wEsKKORdCrymPLbgbyf4Yc5D1Cll3Svr?=
 =?us-ascii?Q?wzUqdjsv4ixXQkkq+85HCyqexZq+SVX0JXliwTf4g7OtLaiALE+L8llj/eQN?=
 =?us-ascii?Q?clyw5+kap11VFO7RiDXwGf+AiyJRkogTBk0Qu44ofZ0EXRpoFlPtb+HLgEgX?=
 =?us-ascii?Q?itF1Zp+If7SFc3y4h65j3GmEUQC1GzbP3wp5ZlAi1FPV4OovozFXPj653nnU?=
 =?us-ascii?Q?xV3pvihUfal709JZhit6YF4oCanJCAiP8SaxlSC3zWjJtbNnMUcN5tt6wFOv?=
 =?us-ascii?Q?TDS3h+Sqmn+LtNfD4H0TGHwRashl2hA8vvLHhLpidXA7qvX2NEZ4nCMOeoo4?=
 =?us-ascii?Q?Tgukiy7hMaI7QhBmlHFu4MwOJdKUgGFwuxq2O6m6kNe5C91f+EOuVylSTGuy?=
 =?us-ascii?Q?h/GKQ/L4xMWPhPtJ83HBb7wv7ZqCd0KkkMvnRgZdxvgvXbaNCyN98S9ORF16?=
 =?us-ascii?Q?4qF+VCprPx5fnyqBVlVYwUykRFyVDlDdMp4P2u0AbGvv5TcP70rYpazoMjeP?=
 =?us-ascii?Q?4xubU3aEx38OWLBY5fjSg6UbQNGyIANxeR6XXS2AYzTUQB5Mzd9OOAyI+SEe?=
 =?us-ascii?Q?ju4KE3H+aLnZx0F5lx3hiAeJmg1c7Viw+RFlGkuAcDvT+uZWrcdm5hZI5GE6?=
 =?us-ascii?Q?A4QuOVGkLYQNe4unulhqMl2nhm3ouI9nvuBxJ0IyEV0isLXKKfVOCGShgDoE?=
 =?us-ascii?Q?jelNBvLKOBR8UblAWEdxgyUbRWITSBX7Bd9BKaMtyncMkNfMRhMhDNbc/8rT?=
 =?us-ascii?Q?RlgpCfFg1WR3kUH74rLF+XQkD2v2+muqrwBcFFxl4cSWHYyjyVm9hoUToF1G?=
 =?us-ascii?Q?MCAuIad+JKJTyhB6U7mTcb61XwN4ty0PBbhK4vmCNXWvfURnN2UrWV8lcyP2?=
 =?us-ascii?Q?vaqdgglklyUXs9ocKNoC8nbzYZVDsXRqfzghCFc3y7kZJTBLLPRAgIv7nRho?=
 =?us-ascii?Q?7yBD/1jzIaJx4q+lg3Wb73XjPeahXJlaB3m2vjs++amCXQ3c1hpd/YbbPJ2W?=
 =?us-ascii?Q?VAHpTJ+B2xrVmm/CIhUUv2pIqf9KQGgsu4KcoO6sEZOhTTHZeRLcuzHvZv5y?=
 =?us-ascii?Q?eCwYaF+ekWBAR+X1iREV3n8oxE8FK+hujt2xtPo7iedHZurq0iLUkIwPSPvv?=
 =?us-ascii?Q?q0i0mCgsxTOUBYCnudEfy7WA3+ZKwm40ygiBWtOHe+m6Ku7eykV+PE9okzeX?=
 =?us-ascii?Q?33MCKSNMGw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf7005e-4c65-44b3-716b-08da318d6366
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:27:35.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUAj1klbEXymVf2gNVldDpmHOVT9qukS/Zvx4xeM0F9j0RdKx3eAtES4FVSaMQd0t4jaC40wxNDy5XDXQ7c/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
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

