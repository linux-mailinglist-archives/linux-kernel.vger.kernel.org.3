Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9646B5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhLGI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:29:38 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:11631
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232662AbhLGI3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:29:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvs67OxCGNPh55oduZr8c2BozR5dBMbXBqxzadAhvLMYTFXO/Hzg8BNOh7T03L/MyRQNUtlJ84s9wAPiAmlfxyTloZNEymdvflw48kIMrZ5F0RVJgVNcqV1IwTOoI9dVo1ToJUDPrVug75a40GVIc0bu4wxcF68ktRWJCbQSahEsnb8+VFa26NhmBIY/4oxNBfxx2aJl3aX34koQJWmOzpNfQ1ljwHMW3iR5Z0It1AzEfSCRRUe+aZoWKUmdG5KOUh3zrad51wbtRWJUTd+tp5/ZquLJNUmfEzgRHeBrqhZQouDjhP5Ys3T7d0KXn4OCQInpS74JgQih1oRkQ/Z/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iceZUBGFfFJacvhh2SyFahzcqY3LIWeknmOtYXejuaY=;
 b=CUAuY2IyWPQKPccCDNRUBAkPRKT2xDJfy81EMAHXtJBlrqqNY9nljsOfQJWNh3AS3ubwyDBt0ARW78t6WE0niaXGqNJG5tp2NgZPb55k97fMZacK+BweRpUJncXs7KB56MNs2CloVKhjix3IlrxSwI0ovEd1/OACKPHHPFE2UVtVL9yGHSywayQ3lY9+iErQygGjVgu+DJW+fy9AaT98NyYzz2bwPo0gVeRhM9l3xpJess3GwneaQk7T/4hNzXx6/owul4tGnNIfaHZaqwaNFFUvjlTj6NoVPck5vHNgFg2GCjbGc/yQMJS+Dj28vOfd6/NPlNnooBaiEirkF9kbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iceZUBGFfFJacvhh2SyFahzcqY3LIWeknmOtYXejuaY=;
 b=XTdu8F02R1bOJdywDYv/w7mqUsoCs9e/kv+pJ2AxB3Hd420WCa+upQX8+6R3LdkjW1/1Xc9Sd8dpXj4JrV4uMwbOGh9asbMDVJCd2/mfQJHO3pIGTCWtywm6mcANAEAv7tnfaERPbQbzky6PkO9s9mIhLKowCV2Q839gJ8O2usk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 08:25:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 11/13] ARM64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Tue,  7 Dec 2021 16:24:26 +0800
Message-Id: <5caf3c46e1b77ad02781783f9e883dd760a43112.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c66ad29-efea-4ca8-a832-08d9b95b2c24
X-MS-TrafficTypeDiagnostic: AS8PR04MB8200:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8200CA1A53DCBAE3C6CAB726E76E9@AS8PR04MB8200.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y3dhEuHu36XhZVU8h4mcIWNNPw95i7yyosEFyMCcWhpx395YtmW/I2XSrXjsEnpgZ2Xo2SDxrEYvTXR1s8h0Ri3mjc/1eKkf4TccfnWFSp+zkD+qlfniiIEuu+Hoo8fYV3U4QjnIPXMkT6V+EC6tt+5qRdvyfPEergTBtjpYY9JuZYC4+fEN6beQQaSFfaTOBkWwUM82v+OxQJqiJTtLNHu1dwovMHoDs/3LF/5LFtxw52xAWamSkKPRYi9hJwvlJ8Csv0GqzrGunttPOJhcyJTCTUOB3h/hHLHaU1O85c8I+4qSJB4edPeXZdosGI2/C8ln2QgxDgAyYYEWLSgMl+Wcne1iOy+fLtL/iHxNRB+Pi/x/yVq07BsXFH7qPrHYi46vCuvO/xkn6oVlZHEpkfl13ajHfGFK+jBGV8/t0HHwCbiD0Q/etphBXCJBZLTBFsbVMS85NxudfPrSG52pjYGIq2VV1St1Ll1OcA7HyAE6SIxxQPb8E95+ZHu3mAKI+jNyi+FwekHQ7YKIHbTD2g4XaYUfwrItUx9g8Mnpx9n64ziiQMX/B24HPYK2gi4BBdSq66SSQLaMzXBSDluBESy1UM7pLK/Ck2hQZN6yzxMmlJZSynPgym+SsmO2uvATmGCv07YkWdVBjp0aR2wFowWRpvGKejZNUGFJjML5unkDErGuOxaEsWZHk1OB3JPCSEn7eelxXWkgQuDYXMXjMIyh1t+tBGilqVgGeCxhN0RnfB31lc2rvNHhBOnHfgZosSflkCqi1+/ewUuIju4/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(8936002)(6666004)(66946007)(83380400001)(8676002)(66556008)(38350700002)(6486002)(38100700002)(36756003)(2906002)(316002)(52116002)(5660300002)(7416002)(44832011)(2616005)(508600001)(956004)(186003)(86362001)(7696005)(26005)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xm/xPZ9T+KXrqhit7fYAfKU5fA/dNDsnW2GNsvJX4xoirMQiISXswS5K325w?=
 =?us-ascii?Q?Ob/BeL9IVBirHe+w+1hA/8t5VtJ1mcKeoVUk2UqgVFSzBYq1A8oeI+Q3FEnf?=
 =?us-ascii?Q?1hZgxVr/CcyzxYSWtdFX5yVvvtH8UWwNvc6xntFpqy004CLdLvTujvLmzbc3?=
 =?us-ascii?Q?xilbiMEHqAXQfeMAw5M7gbWeEwqK916dO4ZxRmapG1m2qAaoOn/9/BOQdCm1?=
 =?us-ascii?Q?hMEhOSVyZjazJn1tTTD18xnAeFJ2BUr15Mwvt0fPwNX1+ygHAvTaw4CAKNPq?=
 =?us-ascii?Q?YS5kza3elLcDaL1uw26weuyJzlMkrsrL2X88jXrO0nwystSkZhICdtcy6KFx?=
 =?us-ascii?Q?XaNTZ6GNii6CjY0dDpJ2s3/yKOE4DLytp4ZctkKfR+ccgb7/VOSokyYo+yrh?=
 =?us-ascii?Q?i/IS187ZAxJLRe+OtDjTl6lUv/D7e7epHD/0fTcC0l5/en9uTxYsFJTlYfz0?=
 =?us-ascii?Q?EIHE4mnkpC8e4Mcv7iBAtMNmC4eEb0FLYox+f0q7jgUjFLoiPqaBSzYdJ3G7?=
 =?us-ascii?Q?JPA1HiPe0vF8+6f+Z5nenj96zU/5N8ZEHH+lfZ21SfuXglDuN3Ziid8NLFos?=
 =?us-ascii?Q?bA75OJoWeaMPGsS00HoNQZGnTFC9XztJ1pVkXnvqaopeIXwWFN2ETxB1oUW1?=
 =?us-ascii?Q?OksnGbdaNCw59Im0Vyg3j+7JL2Cw9ihaf0jYBnakMl6LvU64o84G2pnxHIQ2?=
 =?us-ascii?Q?TathVdOgoTLkPXWPcYJ/oWG3M2+zaQpCIJZ6qp0qcvKhMOWAp/RqMzrOSCDb?=
 =?us-ascii?Q?T7E3npQe+WNaCCClCQej0k3sjGeymrLayuIBxMvTZQ5D/nFMoyacFU6FZEL8?=
 =?us-ascii?Q?fYtGzLcb53L4ETbQRNniHKxK0GEi4Yy/zSmnU15FsxJlFBo+u88QoK6Ff+du?=
 =?us-ascii?Q?qecAP6aGXIIPVmrhthXfXgp+VSQHuX4BnH9F0q4UwejyOE1YWIel7ZEEUkXp?=
 =?us-ascii?Q?tsRH1Cx9n2im0zXKsMBrn5ia5IuzeTQY/L0mPijjb479c+2P2XJftzpaaebb?=
 =?us-ascii?Q?hTgJo/QX1onAFoolFZPzFsqDK0R8GDsFuRu51aD7poKxdXKvW/VVGpIsw/8Z?=
 =?us-ascii?Q?giXCgFSkxG8ae1JnHIRlhVM8pgWy+Ldx07c9laqe/wKjBRtjM8FreIBREbRk?=
 =?us-ascii?Q?J7vtBEOiS+3MISDMO6PzGwLrP3+wGTmlu9o3QfGhPpvNzBEM0PkRZ7hZQChO?=
 =?us-ascii?Q?ArQSQY+XjZ0GBU6/WCi0juHtMfmtM0SWJP9ID7FTRvWiNXqPJbekNR+QMLSA?=
 =?us-ascii?Q?ZsGYTGepbvFUF5Laks2cWPDpEbnRwNb7EpUTW5qylE6OkUxrqB2EqHtqjUA/?=
 =?us-ascii?Q?DP6ntpJUaHzd7n/1e46aK55O98VVNm7O/P6QIRkY3L855ynBExYt8YT2xja5?=
 =?us-ascii?Q?2x1epj6puInXnDvFKDH7xhl+89BGu61uA1auIi8yjdOmuGlSK2HL5Vlqlc4O?=
 =?us-ascii?Q?8NgMhGvUpztC1j+DwUca97JeDYVrBEKH5KUmyZlanMKcfxw7o/MEqtKnTDS5?=
 =?us-ascii?Q?cLHBQNbvOnN7iWmqoVJzztxBgWO8YzJx7F5Gsu8XYqyGDCDYrr6q8ETQdnPD?=
 =?us-ascii?Q?eaOmhg+mEdSvghOqiO4GHXBt3rcBlfguFRZQBOm5tkY2ia9+IcRBo/oNVDuf?=
 =?us-ascii?Q?wMhm5ZJjgpeh37g3jlLSJz8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66ad29-efea-4ca8-a832-08d9b95b2c24
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:48.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH7iW0XN6Rmq02uTgCZNLe3a24TD9mijk69wU4FOa64myzPnWUU5a/6QhT8N2zjM7YtEKfZ2EbzJpABD/OR76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Video Processing Unit node for IMX8Q SoC.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 72 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 17 +++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 +++++++
 3 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
new file mode 100644
index 000000000000..f2dde6d14ca3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -0,0 +1,72 @@
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
+		status = "okay";
+	};
+
+	mu1_m0: mailbox@2d020000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d020000 0x20000>;
+		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
+		status = "okay";
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
index 863232a47004..05495b60beb8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -196,6 +196,23 @@ &usdhc2 {
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
index 617618edf77e..6b6d3c71632b 100644
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
@@ -134,10 +137,30 @@ reserved-memory {
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
+		decoder_rpc: decoder-rpc@0x92000000 {
+			reg = <0 0x92000000 0 0x100000>;
+			no-map;
+		};
+
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
 		};
+
+		encoder_rpc: encoder-rpc@0x94400000 {
+			reg = <0 0x94400000 0 0x700000>;
+			no-map;
+		};
 	};
 
 	pmu {
@@ -259,6 +282,7 @@ map0 {
 
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
+	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-adma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
-- 
2.33.0

