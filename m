Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D493463034
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhK3JxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:53:03 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:37188
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240476AbhK3Jwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDOtjF+LmWVeH8FYmqNyrQ2VVaU7NC3E6ZbGDIq3mVPJlX1RDnb0qKlCv+oQijN05MnDrGXdgrMvlEzDZKDQ8+CQOPepzxtiwjK3Atyz7vl9g/f+hWXvrtr3WBwJHMLeyf5LJ+YXKuxz5Hr1uCYheUsu95tIcJMaJ1XzSTuDMo3+dM9AJb1A6A4kNdHRH/OEsC4EhUHPMb2bscNZpumyouK8tycxiHFONW0uHKkfG4ZXSQ0RND3qScfFh5CDmjNo9GlYo/yZ8F6XDNfphc9R8QaIWSuvccr7ZucVRH3VafGccAc5hGsR+m3tqYSoFECV0+K1040A2b+HMHK6qG814w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iceZUBGFfFJacvhh2SyFahzcqY3LIWeknmOtYXejuaY=;
 b=lobJY3wUGPiyLAHcCEK5Wb29YTG/ErCc6BOWQboS67U0dYMme9xlfgIBYivJ7hdRfGcXcPBg2eJt7t1pWzf/djwaKnfgWbtj64kFdG+SHx6Oo3HGxGPNG0nJVtaWvI7zcqHukEoHMvHG0Okwc9AOxkP8iQPgQKxZxxv+3Qo5+rkvITOJ715CuUNaVvULxO6qKMlNPxyJUmhVBuf4NCh8FBAarBA3GNg6WXqBO0FWVMmwyi5jVSAKCb1mX1OKPA/D15cjl0UkQD6pB1CtjZRO3N4nyeFZF51EnKb9Ral5HKSl/ypX9lC0aP3yoO0oyAXXO8+M96Uz9FEpDGRi6VeYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iceZUBGFfFJacvhh2SyFahzcqY3LIWeknmOtYXejuaY=;
 b=nl//vPLkgFwPtIDwBkROC3TLwoWk00kDDLgRJ0ehF0Y7kD1EXq40ZX0vpYZqkz+XZam/KuBxVWkltwYTzw6YFydvQjQpyj5eVLdZ7jYzT6LAN39liollW/2f1FOEd6qAsz95K4Sp5B2mxOQXehJegZc3JTlA0Pclc/xS9/C7xTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0402MB2884.eurprd04.prod.outlook.com (2603:10a6:203:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:49:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:49:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 11/13] ARM64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Tue, 30 Nov 2021 17:48:12 +0800
Message-Id: <7330d63786ab3f580ffde5a214b1c1e6613e72b7.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638263914.git.ming.qian@nxp.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:49:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccaab118-cc23-4bca-69d1-08d9b3e6b0ae
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2884:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2884C2693405999323DA897DE7679@AM5PR0402MB2884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpWvpUjnBCS4pgvpB/pLBMiSe2ybXCtf1nIijucsqauShIfhIbHc2KkOo3O5qcboO+65weDoWWPPal32K8px+XblHyTBS3QVG4C96i7FknIxlA+2xlsnI31MfLIP5F5yxOiqf4qCWI2CfgEUlWXL9SJMS+kkOqIJuA7HB78lp/ZP/wpErnnJSTzEH+6mU60aq3Avn8dFlwP4+8D6LPvmkhAnwiCM5Y/JxMHH07zGGMjM2R+ApRoV4x6fjiceVtB6HUJ7svhdnMCm5OoYPDmOUo5mozIEwaE4mNjGkTMIAUrBwKi6r2+8me5CrYIW7+kSjZA+LAWgo2dxj586XrCWYNTp5U2k4+ZXnxQbHu9Ir2UxC3lQjjtarVVndd1cgTToBppJX8viO4pZX7j7Ha7v9AgDPs2svvH3ZM9it0vWlZWDVlagjMlAHc+M5oUKejvHI3a7R5xmySgv6lLnCklO7MFUqia8SkX9X2b/1VwdZLGKOF8COkJ1gvjYWT0f+9PlVo2jny5sXe0g2d+RJgFt/uZNbTe4xxM53bke+6d8/VncOEQ200MxvnY04ZJ/1FGIRHNF8gN1eD6kNvSnEWZ/zyDfDgA9e6PQ/Fn31iUvnKhrzDi+SiLsNcm2DcwTSMai7xnZrGYl3Q1tjDNtQN6G5tZ+NNSgf4j04F4eE4td1KSYR8kgxkhYsvmPK8mV9frNxKoIPjaCeXD8XyMXHz17g5Q4qq0nuoIhrfoTWOjSzZxXpOz9Xv989+/0BchGc2KoKVQ5wAj6NOVf+Bjq2QxBew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(36756003)(86362001)(52116002)(66556008)(186003)(4326008)(2906002)(7416002)(6486002)(316002)(8936002)(8676002)(38100700002)(83380400001)(7696005)(6666004)(38350700002)(956004)(44832011)(26005)(5660300002)(508600001)(66476007)(66946007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUGp2tUZHqHB0GvCcpkFeT0Wl3K6ACUX/PLvSex2uA/IuB60sg0VihbeX/Md?=
 =?us-ascii?Q?dKbWhRSCLJEKDDlox5LNxdOxCEyTTAKKLm1pSvLAdwKbhbJ0zzm4HsNkzKdt?=
 =?us-ascii?Q?1nsPvh2XjCSqIYBK4V4fctVJDTMBa9N8OyjRGy89CrgN/FpZEn5cugs9YzCj?=
 =?us-ascii?Q?tM1OXiEIkFOYKRBozr9E6ClC+sWVC6Ndf7ejRzWiM4Xx+Pp02F9Sh/c8961M?=
 =?us-ascii?Q?mKrJ06m4cZ6HAdfxRBay1IkiUVFiK6mHcQL+uEQDZp8VfBCI7MSb8EQrijyU?=
 =?us-ascii?Q?uaCXXUX2vrLzvPgS1xJfT56dH6utPJPUsCOlU1f7x54iyqm85LfEQ2180SQ5?=
 =?us-ascii?Q?ji2NY+RPYZAnjfchXgGVRqifLU0nP1YjMcMBJ2WbetqxVPGepVUc/f26K1px?=
 =?us-ascii?Q?7baw9WhnTk3rDNyBeP/DRfJUQorkYtMw5hoPrC1EOXwQaFJZsm5bzX0+GJpt?=
 =?us-ascii?Q?DpEr5pSCuV50ai3XKSbL4EPzmRFOUaIIbZo4QPbbf/tt2mFN+r0NGc+2AFd0?=
 =?us-ascii?Q?CkjP5MTGcYQuQPKGKXKLP2ykdzgbfMLfRoztbvJClKXsIgifse4/KAgYfoUk?=
 =?us-ascii?Q?oX87ZsUDYiFABuLRhgbKuS7MmDRC3N6AbSw3IZNS5xcIc+/tqCQ8vVuHMtTt?=
 =?us-ascii?Q?HP+x+T0okPWb4/lPAEhvs94wqp3oO7aiClEkwnt0ezmyDCdoGNUsRH8NQvLJ?=
 =?us-ascii?Q?PClV5uYdpLvXjjDKVTv5wglOx9VlI+9JzCtJRV5ZrgGk2oadvdYJcwVAXYF+?=
 =?us-ascii?Q?PEs6XgGau6kiU8yQI9KkRGf8Mp8K3TXHmIzCDRdSl9HJZgN6p8wSjJnCHKkM?=
 =?us-ascii?Q?6rIz7+0cAA5v44jKcpnGTdzxUJXPxLDrIdywehn8paFbvMdLWyW12dST3IZ3?=
 =?us-ascii?Q?mo5/hSjHmUWlplwVRpYuH+YGjpVB0rB+TQ+2Wzx5Po7ypQRJeJrzpPu/MBpF?=
 =?us-ascii?Q?bNlHQiy3iClMVUOEXPnAoAZPuV3q8szNnXMJ+/31WUP/+spt42unqd9FYB7m?=
 =?us-ascii?Q?O5DnPaYTTBmVmEiOvejY9bYN+pezEcVlf7caOAQm3Be8Y9QSP0c/jJgtpToZ?=
 =?us-ascii?Q?NzcWZTtzAFdHinbBO4iSkfLusDSyPp1RpazLQjdDp8798fgOLSAYx8tyGgL/?=
 =?us-ascii?Q?7dCuUoVogoYIP8YnBmrJdBo0AdfZhtYIXEgUq+8g4POy44upzYdxFz6AyPOj?=
 =?us-ascii?Q?/K+YIYryxOS0UKZrp/JAt9lYj/POadTHxF/fySgCUAT7tNa51JuA56KZVqcI?=
 =?us-ascii?Q?rWQzz4rDiD3+jwM9WL9WXZ4C3igjmracF1xuXyuvhMzHBnDN7N2L84ybLhfY?=
 =?us-ascii?Q?wDkcIdbpu263gvEgHLQJFXrO3PwhpMYg7FDoRVbw+KXiTHNFbI4+SqECPR4W?=
 =?us-ascii?Q?IzU6vooF0Quq0k5cjVIaTojYVfUkFndBi71u6SHV6fq3Bt4cS0xKd21CgFui?=
 =?us-ascii?Q?9Ck6xYxNMu+LI66HnwEQL1B7+tcO3ASjGXqfOEICGOoISm8vD7EmcqZ9hcgP?=
 =?us-ascii?Q?Z5yySRd2r9sxd22nQUJ1D5WOW/YlTzmsNqxOmOEcw1GH4UJ/FjUajBZPhiXQ?=
 =?us-ascii?Q?GGvBDclPzShJFyihvcem67JVs7rFJNUiuWcKjNfJXyyIy8mSJhv9kBqSXuSz?=
 =?us-ascii?Q?wRjqLaZ940Ca0Ae2SaKsISw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaab118-cc23-4bca-69d1-08d9b3e6b0ae
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:49:23.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcUK3GdtQ7rMpU/oeHKBwp6/4c9OQkvUntN5tUDE4ftRsRMYlI3pkTH5sT26yoxeB1k+FN8vUZScypdOhgcMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2884
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

