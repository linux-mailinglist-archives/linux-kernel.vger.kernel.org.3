Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555D4BD606
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiBUGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:13:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344999AbiBUGMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:12:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4329A;
        Sun, 20 Feb 2022 22:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxAO8yokLBHx3avuKRnLTCfrCFKdByowwJhRxIEqpxgDUx7kih5si2y2BqZ+qT/aQQAdt/9UU9ftvlgcWzvjWyxkuDgRTrQlGAlvwMDqG3WaSWK6eqYRBCQqNo7MLFoG0kajmWCAKNi+TggMPZPgMR8MDyyJel6hTkOSqM48VuZqplfkQgoM3MuEM3o0P/GFr0gfSGSot0EchRmj4k/POlPIzlNG6IPvhrQ4K6RgdhFA1pYfbj3XJh/+rolDOU628pelwA/rSFgJ6TrAStD0GMnGIlRKr9j6duOobM6CRuJsV8m7nsy5ruZzv6zaM+QU0jw3ZaGAm8c8bcmqgikPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=NDFHQuX+3XlEzfS35VPe7LHpE93RzP4uZ7PHxxvVr48s7oh2umTonMcWXN2ugkwWpUPii6GCFVApda/ogKtOHz3T+i6ay06cF76wq7UrJ4s0F8x4cmGU+IeBP9Rj7NWDP6Koi4qOez0IyGUyNBeX62u2QkzY3d3BMRH/RsXbOOBlHEFgRh9yUj78AFzg1iyf9ePwiTpVz5A+QnYi8GekMCy2eH2OZoo3yuMxaLr5/37+hipYqg2/PrsMa+SsWil6yamYV3ySHWA23lWTz/GbbxnfkQk4h6l5t6xbFKh1jxBOFbW/CfX2Mltxze5jkZJKyloZHkE26FajBv1y8ub37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=SHjS9lcUYgZJjFniSQCwzbYWZpaYLvel/f0mZMauvugjlmcof6evclW/HjLo4vhe7T6yzfXpMUSZkvyUumDZZyea689RSC+dwOr8uskVoJQeYFF87pYBHDV0/Rw93+EOyVW+O2ygLsWvXPtgrkO3KndIlnkYhD2ciddsti6W4yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:12:09 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:12:09 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 11/13] arm64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Mon, 21 Feb 2022 14:10:30 +0800
Message-Id: <5230b886dea5f3f2cf8df3c3ff2499aab95cfcef.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e268d8bc-de04-4af5-1966-08d9f50117d7
X-MS-TrafficTypeDiagnostic: PR3PR04MB7322:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB73226338AD011DEA8C7A73C6E73A9@PR3PR04MB7322.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRmZACSJXl0Em0Tn8oB17J6qpfRudKNlyaWP+V+kCY9ihCJapDiDWgunCmPInRwfyO+IzLvGdIxf5Yo5vQkWcOn410PvoGQI4VdpTNg7Ae1lmUZXYVPNHJMepRptXQscDmQMvNvObh/AL/oBYw3qzRRv0xLDnn8HIliD05rgAUw0Up/qU1nVaigs/UuSltE172lWjzXLiosPVbv9+9eCZJKgoF7JUimCUvaZPYSFFSEDPbA0kV6/rzg32hO68sIeHzgMZ7ON9JyWf0j1s2NZitNOgr9na58OOCyVEilLGPQsWvE0rTeNDxc/c51Jsd5NbheYuRJPNygNgovjwNkyFI30redhqj7536Ds1LHJPJw2pRxd9bHy+e/7EMwdFlJdmIAI1Cwgm0LMuyi5ZRuPV3fuI5arGWVYimpjowt2K1HC293zDeqd/mKLuRE1bu8zWf47wJ5ReGwKQEWVu/LyJjeJNEQv2RnlkOk48bgHB3+Srqs9L/wG5LoWgcDZyR0L84lk6IwpGJsL39uElnbjvzJV6T2stayhd2AtHmlYiGzFttKQHOIYKThBkSiyOJJ+DF3Nqmn4iYJY0wawIx3eDnA4vwjvjt5b+kn5YXWbRn3V5Pv3LuNP2mzG+gTx3jTXQjwmGLcOO93nguRiuaXf5fX4vBzPcC1r8gfjR5KqgWhyvXvYogB0R2dM95rZzSf8v8TcrPH42jccbL1HA1Njylbkl85HQTQFJHEE7LYPmK2Rx3Y/+fuqJkZVMr4d62ZLbFILGJ0teN4O0AniK84z8hXAvHPt6I3RDM1GlE8fEtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(66946007)(66556008)(36756003)(44832011)(26005)(186003)(2906002)(508600001)(316002)(86362001)(7416002)(5660300002)(38350700002)(38100700002)(8936002)(2616005)(4326008)(52116002)(8676002)(6666004)(6506007)(6486002)(6512007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jT8886xJ0+mRfK+KCLj6f7nUl5pAU/zAOoZWuPlTrwcN4uR0XiwQaGy7u9yq?=
 =?us-ascii?Q?POkhJq9odT/rEYfPUhdctoGlrPLAz/CezLci6DuJv5W+mNuRCqAc1l+dWDUA?=
 =?us-ascii?Q?N1I9AIn6mmCneoYSWM4Ewq9oHMCbgMM0pvT9dE+aZpdT1PFlEuayt7lcU7FY?=
 =?us-ascii?Q?tnHXi6gJcnLETD4xpPz3lP3k7eKicD1/fLoECljvSyqImmEE6LoViNyU+gGa?=
 =?us-ascii?Q?O653diIV6sqfAgqcjhLOWMU93eIKQpEsR1ZMjUapmMsuUtfUAsnb8VbS88gm?=
 =?us-ascii?Q?Zz+FuxoR4Q0oMDhXUkF+tcZ/1qG9yEG1MjQ7XnqHCTVVxd6ri0mgsY7IFQ+F?=
 =?us-ascii?Q?Z3i3VA9axpMXUylO7Iyh/jz6x53w7fPFscbVw0bdF1sOflZZDzpqObkLhULy?=
 =?us-ascii?Q?Yjg7sNz0rqq5i9ETP6MhOg7KBSLQzdwvB2UXvtohSmiK9Q/ZxxqqVTTKaXEx?=
 =?us-ascii?Q?wg23QDMLjmfZitTgU3WYqX16TcSVcfjL97ebODbejpUS0PFyjoIL3uuiH5eH?=
 =?us-ascii?Q?lSvAcMGC0iQhsNJvnMsA9jDD4d9pQVbHmPgOqQwUmRjZIXQPYunTF3xEMT6w?=
 =?us-ascii?Q?Ct2Y70TgdeS3pWLYPEL75MJ8FKbHr7GEXEN11ZYEDSaR1w7E8sfcIuqw04AT?=
 =?us-ascii?Q?zutNv9OscmO+WW06yFnUAeewDHBjzXk2ce8tK5bsMpXFQCA45VBF1BtScbBs?=
 =?us-ascii?Q?KoJTPfR8LAo/yENNe0K0+3kUQRzi+jOq/vPhkIcmPnVbrhOscBK2rwck8PAP?=
 =?us-ascii?Q?qHlVfbHExXksWef/jzVGc3LyiGyED4Y+hxYER3lPHfirNhCx24PjKxRGUZkX?=
 =?us-ascii?Q?bg6/USjVX+WE7nz6UkjlKgyJmqVKdalH0bry4FZqFbhb+HD7WQhs2Cfl6QdB?=
 =?us-ascii?Q?YZeePV2IU/xyWZxLJn7PMgU71uKRJTRxyibHxi5uQDN+ZZiwSnkjfl4lR9nX?=
 =?us-ascii?Q?FTweMsASJDoLFlgw6KCWOfJoA90zqAgRkTzKtsbTJOhudlJkH1ciKwg5DyEU?=
 =?us-ascii?Q?y+6qpEyQigs44IMReebNjd/ZthMNvRpz6AFYAlSODQ8sXyVGcgs6QelIo3db?=
 =?us-ascii?Q?+RqhXe/NoONg0m2LfzfIL7bBDBYgH6JZ/3+MEyaVlzucNG7DJhb7tvsg42gP?=
 =?us-ascii?Q?7eZpOERrb+mOMnMEhYfRwwmxmyxZZjU+FPjJBhzx/WocsyaMfy9Lpfvn2gES?=
 =?us-ascii?Q?vxBeK0VCxPaXro07Xq4wh7RiIWEOyQ3HcIQieDNSwJevtMyZ7JiFuRB5c/CH?=
 =?us-ascii?Q?8gcvvBiDg2djeQ9PmarV56RlQbvXJfATs+UBmXiyBXrO43HPq5Z7a686on/s?=
 =?us-ascii?Q?0DSFfb1oTB/k5H3kX98Vszzt28lbADOGG6qXFvqcN7BlQB9WT0UADtE4T9q6?=
 =?us-ascii?Q?QeEM72485BB8U2HD2T7AORv6TUWHvBW7TWowgLSimakYBtdxmajCSumcyk9t?=
 =?us-ascii?Q?3BONwGKrH+PMI6zbiOJQpll0uvQTJ4iBh5petu0qUkUxsXwmxynmx710IHA5?=
 =?us-ascii?Q?/hCs2qigEw0+V64XjrLITJG2GmUCkh2OMprKxWGDXk3SHgaB2i79IY259ilh?=
 =?us-ascii?Q?NBDE+G3YYtCztp/A67PWkZThz4NISHCJp6kfL3Qpcymz06TgUPgG1b+Hq18o?=
 =?us-ascii?Q?g7HAT63Zj93hn2q7sQ8sJsQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e268d8bc-de04-4af5-1966-08d9f50117d7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:12:09.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ5bxBxEDiZoT4wi6NgFVF0ie71/ozDyAyviJQcDoYFM2wzrLgUncIIckYkp4Y118Vo0JdeMhGBibdpA9g4R1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
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

