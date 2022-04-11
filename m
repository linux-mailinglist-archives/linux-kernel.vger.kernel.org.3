Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063374FB404
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbiDKGx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245075AbiDKGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:53:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092819C00;
        Sun, 10 Apr 2022 23:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOu3AjEJSAOYii8iFKaptD6F2faZxLC1MIJBfBHoKjDrK6BhtnnbKOib0kZ+41Uffi6sxpdRxfyPy+YOINgvZUaWBZse9eKxLK4V33/J8nSdG1lSqntCoz7RLSU8HDS4en/IXw56hQOyCz7g7rHurt4qUgBAgUvBMhvAzo/PEc/nPQ0niaFK9ZYLSxoMsQg7n2rNApTSPQ+iFmhE3PN/EUizjHu7nM/aig7w2gAElJpsbf1qutXQYTDn+q6Ppeio2ktQw0It4a2UGz3N5Zbv9aNzbZOZS+PnlgiF1Jdn8CiM6pt498+AY9gHq1Mbwfbli4KPBs4N19YTPn1xokE6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvP/ZuRIV4k+QLgNpkCvYMSIdt8mSOVZw3DEI2i2qdk=;
 b=Fh1bs9ACdQ3kLBU7Nh4MmekjUK7qG062tlD2kdncUOKOxmKSvTgH1inw3MxNv2CXmA11WXnralk+s63G++ay/Xc71Lvh3lG4Jpwrb34Bd7w6xaDRnauCpEjvRHWNwCBKi/bMjLCPgMj3Yan316WlPc0zI4CTzyTwYJLWKq82yPz/OzlYazlnPbunIox4Umov35irm5PHgPIAA7X2Rv3gj9qOOlRDtfq190DurRRym4naS0LKYxjN5wtlEXfVUfcKJtc+XQ/uA7+pIHFyOsCFx5m64l1q8/CgnhNhK9ufoWnuX3yEno02D+BfaWwixHs/+rvVcMUZFV0OoAwKYjdFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvP/ZuRIV4k+QLgNpkCvYMSIdt8mSOVZw3DEI2i2qdk=;
 b=rL7g/q9gAbZ48xTfWWXReb5lin8HqsuNX54NUj3S5zgl60yZsmBXK6I8L4EMa5njFRQngp62bzzOFTJNseOVC9cT/7NrpGYLa5rgh7UZ4Oj0QMRkdCSE/h0JPJbU6bXDlpxUv0MVZkoBG2Veee/naECuPNYYP4JBBTu22Vtd1xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:51:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:51:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v20] arm64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Mon, 11 Apr 2022 14:50:49 +0800
Message-Id: <20220411065049.13188-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f25a51-c32a-4783-d53d-08da1b87a748
X-MS-TrafficTypeDiagnostic: AM9PR04MB8306:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB83066B927007B9AFE6858EFEE7EA9@AM9PR04MB8306.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/9L9/bDeYMEMQgzzmARHoPS55VGnt3b6RZZQSyohsgYuoIQJUusncKrhf6u713t5nI0QwQ80VYAV0AvxqX6bsmfJ5n6mPI9W+B+ySXdpR8zqFiiyhAaQ8X0R/4XhCo+Tk2Q+qC3IV0bc1tOczWUy3ELX9I5uG7AG0p/vGqplgbzajRHtPiq7n2vwbtMMjI4ARqN1hTyMKeLJK4PKAK8SZ8m6Ns00broHKDJQ/c3wYaFwAVHeJx0g3+1mnvMZJmZCHSbpQ1voa7dwEJgv+/GhNsX9ouj3iiYrHOWtokJ6cL/glXd7GATrbv1wBKVpfJnv9TLCF4gzNxX06WcaX6nfC4Y7Hi4dELtb8naMhHAKJoJc0Yv6sJg2EYa1jUPLeRUS1DKds30VbVmiFaDo9DVaM+rDbBztZWUETnuKnwEdu+KXV6J7GxzF60snW0gk+cGcOkP1g06IYG132ZIWhokTS8xWC4rKwtGTnnjupdwav+riCmXXGL8ushBQPa0PoC5SGbxcpEM4HB0pKPleNYL4REeStxDHJlNcuksfImHJ7AK4lmmonswavbl4BHKzdr/wztvpq1o9R3dH+X5ljsCZ7oIpZxEnoz6rVc0AsVs4YuRfN8lwn6xpDMSsLSfIeoacKTnmeu1dwXL+bD/WJwPYdjCjgjMxyL8ix2qEP9cZx4gmaPhZG3XrAxTi6+JTpliX3ReZE+uYa3i6u5iNwz7JheXeMIM6IBPcKD4mvnYCTuw9H8g2kBeaOmqrL1Kj3rRqnRGHmmVhmhwyTN1WuDJDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(38100700002)(8676002)(66476007)(66946007)(4326008)(38350700002)(7416002)(86362001)(8936002)(5660300002)(44832011)(2906002)(83380400001)(6666004)(6506007)(6512007)(26005)(1076003)(52116002)(2616005)(316002)(6486002)(508600001)(36756003)(186003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAy6R27Zk2hKGFpfKreTPjKR4c0lfJSlVfpt5DYMR+goYN3SAa30usG7praD?=
 =?us-ascii?Q?QBjV+LgFhkdTKENuXalsvCP2zieXW9Iq7eUOR7cx/diyMpWW/+NDzn13oQxX?=
 =?us-ascii?Q?YBlZSdBDim5C7y+zjzKVHjXsohBnb3fzHNZqQl5WaO/5561CGh3XPvELt/zc?=
 =?us-ascii?Q?B1jGOAKqt7OxNo7dwvXqXyfINB9eOQJZry4MaYcUiVRKleZkGRGLIB0DsqTV?=
 =?us-ascii?Q?NphYTju4XVIyR8XA2uhAMNXAjpqdeskERA/5osVxEKN/JxiPH5tDONGrG8Gh?=
 =?us-ascii?Q?jh8qE3jj3kR8gHPZclFVCqsx6U71ymk7Sz8ZqgVoTjhE1pyQPR9/n9MddE0V?=
 =?us-ascii?Q?e9opR1GJCNAZWROu32UYXhpuWrbDBPtPSbB+x2YXWfwENqSlS0/nPhXSSM5G?=
 =?us-ascii?Q?6HnPrIv6F/V1iHcgbb3/vvLjHavtUuOCyJ6x8+X3cvcaj2ZqGNmXaefsYqdR?=
 =?us-ascii?Q?o56A36lFxoWulfC5pmm9PkcJagowwhRFXcaJRaGsuOWFp6LemnHRPK8wzDh1?=
 =?us-ascii?Q?YD4LvHEgj6O3hnZS95ho7wVSRC9lJO6pjfVesp37tvXll2koA6EqNp68HKlC?=
 =?us-ascii?Q?PMLCFsmF/1nAeCXpOSW3LPX3963qd5dyh3Sbz+Vcd8QJCBNlzVUQO+mw9W4w?=
 =?us-ascii?Q?Csq2+QRqAMGghJpqVO/dJFAPGwIxiDwrj0kPJZ2ySkf9ocBkBulkbPXQWowd?=
 =?us-ascii?Q?7CRAJ9p7/3AKwBUoTeOaTs+qUzcPHeSt/7bStNStJzIHCi6jNYc2EFd5lYIa?=
 =?us-ascii?Q?E7jo8cT4aoq/Q3VisEUp94VvhIx2/50a2QbXL9UguGT6A8w3O6f06yU+IerC?=
 =?us-ascii?Q?IkGVwLRgUAnrgb5bs1lA14nZY3H17s7SMojRrt7NWi274+srGs8wJ9Jh2oPR?=
 =?us-ascii?Q?pqTa9PyJH6QQrvoGM+ZxniFiq0qgJutuMWJo6UvzRyxS1K44jBFMyh5zpfKF?=
 =?us-ascii?Q?pMufCa9eV51ZxSb1n6T2EOpWVqjZ83vthnojkNxUsiw6xncIPvfXqJLsIOBz?=
 =?us-ascii?Q?eKnmnW47fqDMbZ9JSKusPS6sxvN3GivArGdniJBIbHy04GEj+0RvwLgSfbIi?=
 =?us-ascii?Q?DCX+hxpWyTk4icHkqdEgNYQZ0LtraoZIPF55o2TnBcBvJ0M7iUIgbWci8I2c?=
 =?us-ascii?Q?ol7o5oWqUJ/9x3Mazzr6VkCv9jXwSfPFZRCG4v+1VFJacmPCAjQXoIFtAVy/?=
 =?us-ascii?Q?crcAi7BkYhcPlfDlfacQhhmE1p56wuecRu+Z+WrWaoUjXVyIJ3wzmUAGIaSJ?=
 =?us-ascii?Q?AGvwSdWo2Cipu7l41/6Ch2ePkfbHHRhC4aeax/ph9if4yM+mximIG0a1EwWw?=
 =?us-ascii?Q?tDVHP1TEzIZKwUjwfxUxdrsbFS2+wxw9eExMevX45WLNLcdVFyjyADjOffMT?=
 =?us-ascii?Q?BxvDtrn8VhQZj5dzQc5FvDBwsrRL29Q+yDFil5TZanTocFwScvqexuvCuIhd?=
 =?us-ascii?Q?joZH95MIs50UQQ+dmNt/skdOT1I0ID/tIEr3hZT+7gtwdbAIYtS6j5KjFKqv?=
 =?us-ascii?Q?a4CYQ9bi/OOv3YTYdt7AiJoMTvb5InxofLeZvAPAAO2TQ8I67NWX5sp+rJWU?=
 =?us-ascii?Q?MIu9VKt7NMe3qoIDzhSHilPBvkjYIjye5glSKQ+GL6wK20EjH3eynT6e8tR0?=
 =?us-ascii?Q?BrNCNfk3IQROD9MLpK+G8yBsuVWlVPOoxPWBBfcAo/dBnMoaNvc+7VKl/x32?=
 =?us-ascii?Q?CAXUPYcbsCHqW2Z3jkBhKKdfJn/rcccwoWLGx2HounuLcMzNMW/sZeJhZsce?=
 =?us-ascii?Q?0qS/BA/2oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f25a51-c32a-4783-d53d-08da1b87a748
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:51:06.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYX993M4Nlwa6sQDxtvxZfhAYSwKZj+h+qyKHmTSgN2FcIDyMGxiAAFZcsAqXrBLYyaOxakdkfEA+2HiTDboeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Video Processing Unit node for IMX8Q SoC.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 74 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 25 +++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 ++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
new file mode 100644
index 000000000000..c6540768bdb9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+vpu: vpu@2c000000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x2c000000 0x0 0x2c000000 0x2000000>;
+	reg = <0 0x2c000000 0 0x1000000>;
+	power-domains = <&pd IMX_SC_R_VPU>;
+	status = "disabled";
+
+	mu_m0: mailbox@2d000000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d000000 0x20000>;
+		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_0>;
+		status = "disabled";
+	};
+
+	mu1_m0: mailbox@2d020000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d020000 0x20000>;
+		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
+		status = "disabled";
+	};
+
+	mu2_m0: mailbox@2d040000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d040000 0x20000>;
+		interrupts = <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_2>;
+		status = "disabled";
+	};
+
+	vpu_core0: vpu-core@2d080000 {
+		reg = <0x2d080000 0x10000>;
+		compatible = "nxp,imx8q-vpu-decoder";
+		power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu_m0 0 0>,
+			<&mu_m0 0 1>,
+			<&mu_m0 1 0>;
+		status = "disabled";
+	};
+
+	vpu_core1: vpu-core@2d090000 {
+		reg = <0x2d090000 0x10000>;
+		compatible = "nxp,imx8q-vpu-encoder";
+		power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu1_m0 0 0>,
+			<&mu1_m0 0 1>,
+			<&mu1_m0 1 0>;
+		status = "disabled";
+	};
+
+	vpu_core2: vpu-core@2d0a0000 {
+		reg = <0x2d0a0000 0x10000>;
+		compatible = "nxp,imx8q-vpu-encoder";
+		power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu2_m0 0 0>,
+			<&mu2_m0 0 1>,
+			<&mu2_m0 1 0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 863232a47004..07d8dd8160f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -135,6 +135,14 @@ &lpuart0 {
 	status = "okay";
 };
 
+&mu_m0 {
+	status = "okay";
+};
+
+&mu1_m0 {
+	status = "okay";
+};
+
 &scu_key {
 	status = "okay";
 };
@@ -196,6 +204,23 @@ &usdhc2 {
 	status = "okay";
 };
 
+&vpu {
+	compatible = "nxp,imx8qxp-vpu";
+	status = "okay";
+};
+
+&vpu_core0 {
+	reg = <0x2d040000 0x10000>;
+	memory-region = <&decoder_boot>, <&decoder_rpc>;
+	status = "okay";
+};
+
+&vpu_core1 {
+	reg = <0x2d050000 0x10000>;
+	memory-region = <&encoder_boot>, <&encoder_rpc>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index dbec7c106e0b..a79ae33cbad2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -46,6 +46,9 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		vpu_core0 = &vpu_core0;
+		vpu_core1 = &vpu_core1;
+		vpu_core2 = &vpu_core2;
 	};
 
 	cpus {
@@ -162,10 +165,30 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		decoder_boot: decoder-boot@84000000 {
+			reg = <0 0x84000000 0 0x2000000>;
+			no-map;
+		};
+
+		encoder_boot: encoder-boot@86000000 {
+			reg = <0 0x86000000 0 0x200000>;
+			no-map;
+		};
+
+		decoder_rpc: decoder-rpc@92000000 {
+			reg = <0 0x92000000 0 0x100000>;
+			no-map;
+		};
+
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
 		};
+
+		encoder_rpc: encoder-rpc@94400000 {
+			reg = <0 0x94400000 0 0x700000>;
+			no-map;
+		};
 	};
 
 	pmu {
@@ -287,6 +310,7 @@ map0 {
 
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
+	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-adma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
-- 
2.35.1

