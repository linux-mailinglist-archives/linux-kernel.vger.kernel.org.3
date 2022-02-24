Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372674C224F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiBXDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiBXDMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:12:34 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0254673FF;
        Wed, 23 Feb 2022 19:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YszLmKuGgga2CO1JfYCUgv6nadjoW/ptQs+qnJEFaIvuW2vjX1di0qYfht9RyM4XqKv7O7khoMxAivk8LPkgir5lyJLWhIYrGZspnVPwp6yt6Q3NA6dTkiX4bzXZO7Pee4nRm5tXv5fKgtrOMGz4lLbeA47wszVrA4+TfPCRoSfzdRZCTYhFgpOvgCkmKD+oi513Umdik+Ga+6gc66HbEtdi97reXqV7diNOmKnrYrKAmAN+8JOh77B0eyOKxN0zkEiKPcI85mg2aHkfPkIA6JHumrgIEZo8AMRy/qyKpz4Wlrt4CUcyg1OXe9ClUmzQSKSeOCGhNlLVe8XLWgPYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=enaBisK1M+bGssbFmpr9+rvbQ08H/iN5LmvBKbkySlyeZqWs/ybVBUXfQgxzXGFLmf+76szArcvtuAVlvFQAqKDqmsg62XFyDjhaFHlRgqQ783WvOUSqSucWJM+0jYm5Qo5S54doYtOS38ho08cteQ1+8w0YdbW8ECSbUJZpMwnV62+szPQNLZVfXaoHWDNmy3MAZJw81L1eIHvGVINyDUrStGczHO/T84smLcmsuyF11o0bAhVirXri8wJjkMyhZ4WoErM5ZU8p15IUArBym8J7PuepoDcpAbvLk4XdsmZ35zKkvEF5MZaGNDlDCT2hUTjoCZpNsHwpFwkWkje/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=OlGt6+oStnjXJ/NexRHRYCi0ET8uMWUXFV0A0LYgVS+tk6tyatPUxCZ/1ffyk4wp+xd0qBGDtMQZumUZgQsqz3ucD7rynn/UazXMCEs1iX+JyYDOeTdV5yxuDtf/zDlpCpyg+/5pSAURxDtSyV/1Q7dWFCL7Dwg/VxhhDn5Igos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 11/15] arm64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Thu, 24 Feb 2022 11:10:09 +0800
Message-Id: <bba00854125e0bb5ee6e9a12227d639d013453a5.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5149b752-c697-49a2-a19a-08d9f7436407
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB8013352201C45D1F529F3790E73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjckppgQGyQ+XvOs6iGiJGsEuIkJ/PEqHcwL6mqQI26iceNUO38cVzsc2N3XgIACIgJnkNhK/7zN0C0XrtyX+DsFxgfcdGYTB8LtJIcBHD0geFmRwRrK2JIXO05//Lf4T5p+tAW940XOMrebc5yklAh2BcMFST/rndAQ9Z2DVEX3gAE56uNBy2NB2txbOruLFtImugWgRCFoGlcY5bgWJ4ECdGUeUwZFYpIOupp1RYarJqBigmVLl9Ilp1zSEqi2HfykpG2a8FIuhzqpCEX+BwVv+zOSNqBxB009BuQ1AhJQPVR4MT79uetRi4vaiJTwpwlqWR3rtOeN5NmW4EiUiQ264O+RTEHcGG+WevwBF9f/sj2qSS5ejCXCAdifSEG74nK1TPxGjs/20ynFsV/a9/LPc7BumWsSdREqP/557Pp4ZpNu+OfBht+/cZ5c8c++H5VAyi6gZhSFDjwFTZvy6G2diY2Zp7gPHvw2+Vu+8ZYOjvkPyX2v5o1ctzCe85E7RbOvvLDGu5XCEZDcLXIHAhy341XLTxg6KQtif64qn9lZB2YmSxKaudo3fob2QuHeq8BnKimcqOmgZCNUPsb9vaDIFteFwZbS0gq2968w5Wsm3Kaof0SO8S3kJpdoLDfLazylBeylAX5hqkOV0u9frv0K2lhfqEj4Mq1ZsM7+1rXDMeoNLLrv/s1xox6YNE+pnICzgyILoBkS4CiIojsWkokTZThqWt3Yk+6BgnEA4TxyvGdKKnVvHiFDg6VUNV4WP00H+z0QqtHkBCBup8ScEh/h3IE2nh7uKHuqkB/r2Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(508600001)(6486002)(52116002)(6506007)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(83380400001)(66476007)(66556008)(36756003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t9EC+EXUaUQKkEK9d5CZG8mEyZFYJZKxLAA5f4JDEaReFbVhDkYdzHEbApYy?=
 =?us-ascii?Q?T93l7/Kxy58jP9a5RZ+rVEyeu8oRg+GWodpvumqFCvrKxZx/h1C2y3g40l8Z?=
 =?us-ascii?Q?D8YlVlKVkt6/VPqb12JsaTVoj3CrFlYmBk6K++8vwzvzhCBDjJ9NGzjZf+9W?=
 =?us-ascii?Q?0kljiOVXWH3mg105m0cZSJh4mXATLuwk7H+5mIrZZA4pbm/BjsXXkm4wqkN0?=
 =?us-ascii?Q?2MDAcZp5lOxbEWkFHOkNQfkE+ukPjLwAz6u4qiKXrywIzMASCn5r1LPFo5B2?=
 =?us-ascii?Q?0lB1p7AXlUana+xMbgUSjD4fhSBoD0LVWfMngA814fB3wPk5VzzA9ZoP2Nwd?=
 =?us-ascii?Q?Nj/CyUNDQrutGvYdVJDnAEsC0GlF/8QF2MeEVTS3oWrR4nfficsqVoDR02ph?=
 =?us-ascii?Q?d8Iw7c2G6dVT/smpVYQVaOTtpS8BERLTAlWtN4d616gzwcjOxWsA7jX/qhXZ?=
 =?us-ascii?Q?KtzUS9alfRulFElA90Z+IagL6yLCFUHk2MkJrCAhFOxxL4pRVU8ulCyU++iX?=
 =?us-ascii?Q?fub2xBrNQNKbAM8lDDGq1YP3/erYBr0l9PTA6ZUSLG7Xq5XkvtAzlY8/yeao?=
 =?us-ascii?Q?X1b1euz6pi0C6zM4lVuddxOX7KeMU2DctYxcVAklvHWwycaL9lbhGjc8BjZF?=
 =?us-ascii?Q?k+HrxTB5rofu1t6VxG3Xtjsw6TWFP4AtDJ8BW9HfBDmmnlqDnobriXeYmGBq?=
 =?us-ascii?Q?i9yaAhBq3OqYyd2NNOEp3jwihVPS8I8jLlBNVkWlyfDV+teKrT5MHbVXaY+m?=
 =?us-ascii?Q?5GyEbzaHuhd37NphXV3KTOU5yg7rtTVKyUJTf30Dsz+uIh007mYAHBhdKkkN?=
 =?us-ascii?Q?HoC8fZhqAp8NBzrO+vbfSUYCsXAOix6rkIIiIqRXhODTLNYdiEatfSEjHW54?=
 =?us-ascii?Q?TzeWTaXottwbnPZupdSKkB5iOrobpgCnJftbJss/p5tZ0BCA0jLrjWT7OG5g?=
 =?us-ascii?Q?hTiHxKZPowWH+1/8ftu4F9pL3W3Gz4UV5C4YBBHAhC21LijaQIQbqXALB7LG?=
 =?us-ascii?Q?oV4vDWyQ7uPPMOVR+mmVmjSCp5G+pPozZRbXiymkvJZThCWlq5WCbe6qzyRB?=
 =?us-ascii?Q?yxHEDhFdEymrRxMVO55enX+PeV33/S/zdAEXYPyshJI6nzJlOCjHHjpsE5wP?=
 =?us-ascii?Q?Ho6Ofj2XKwcpG5NX6rxQ9WKmkRUOvBNYSr90WwHXWohp0MoezITMdUqmociq?=
 =?us-ascii?Q?xpJ8mo3rKDhnlINSqAzOc1iYYfCB/kaMBTJEMR+yEFPIk4u3I57Fte/m2Xs3?=
 =?us-ascii?Q?Q8UtAuEwm2zOxea9TRKvCyaeLDHA4MC0AeZXVoeXn2O9sAi8089VUkLBkMOa?=
 =?us-ascii?Q?sKF5ADK6UXB35Soyyq+rZJUm3Twpy6W4ld/qMcaidJvF+AWk/mrolilMk/vT?=
 =?us-ascii?Q?47S20xb5533hJHbv8bmDG74wlCP1SZGsbpwXgciTLEe1/sukEzGm45P0P9wG?=
 =?us-ascii?Q?HKv3cgytQFbaWdSMDBLh3213PbFerg1GZvcuLdOgUzexicQDeYNyXyb9rmSJ?=
 =?us-ascii?Q?3Yp7e7PUlqoKw0E2I6VsaDsVf4LPE8KwbUqqszYK1JTJvghWtxjePd7v+CJW?=
 =?us-ascii?Q?vPYn601GxlAAni/sBbiyA8DNNmnDcUovyLkbaTOwEiI3RPexrBuWhNeuRo6O?=
 =?us-ascii?Q?NQfl6jHS2hxpDqVc6PH+ubg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5149b752-c697-49a2-a19a-08d9f7436407
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:46.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDYmKbccnryRPAjUICG7WxL+7jhktQjA3xnmDxayhMzTDJO22dZ6PWVNloh2uBhdqM8PahpuZr9+ahgTezJuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 73 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 25 +++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 ++++++
 3 files changed, 122 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
new file mode 100644
index 000000000000..a08d796a8cd2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -0,0 +1,73 @@
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
+	vpu_core0: vpu_core@2d080000 {
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
+	vpu_core1: vpu_core@2d090000 {
+		reg = <0x2d090000 0x10000>;
+		compatible = "nxp,imx8q-vpu-encoder";
+		power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu1_m0 0 0>,
+			<&mu1_m0 0 1>,
+			<&mu1_m0 1 0>;
+		status = "disabled";
+	};
+	vpu_core2: vpu_core@2d0a0000 {
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
index 863232a47004..44347a076722 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -196,6 +196,31 @@ &usdhc2 {
 	status = "okay";
 };
 
+&vpu {
+	compatible = "nxp,imx8qxp-vpu";
+	status = "okay";
+};
+
+&mu_m0 {
+	status = "okay";
+};
+
+&mu1_m0 {
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
2.33.0

