Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACE4C119C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiBWLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbiBWLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:42:04 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2B13EA3;
        Wed, 23 Feb 2022 03:41:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOj2OcNViNfcNA1TXVFyaTXeBbzQb81Lr2VcVz12kt6yWbiUEgLPbTFQotG6CMEGaFYvV63FXfCRxOJOaqU2Dua1GebwGIWyojB7Hw8iaCHC5iPbR8yWH1hoJtyjB55+gbh7kypZYQhh4v8NNUlsoQ0aXhTsfyGxIHQk9kiXYjMrxWmx5q4+2LnQr+kUEGI1FVo1GgONAZy5Xc6WzMTJ2fziGlVLYPkk3cFcSQOcvcO4tviX5UtW4oguSpZqd97sUuIxZaVK55hkaEEjpOqlVN01j6zEMzImh4WBrWBYr1GHdiPqpRZdMFZijTLUuF5dIGGAn/2jPIniGTOu0R8GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=O6uQhKvuQDeJYKBa18O8AP5BF3f9M5NgIXo1bszLQaocD7085XFRYIVklPvsC/95xZYUDz2smDAO24BseuTj+9csUBq+1r0qWlpuvvNT7TIUG2cZkF/2Kydbx2dYw9YhiWHBcPMrvzxxYupOgCVPWvQIAeOnos/KABzrDSvzx2EEo0QF1xPFSlwysLGzv//ME8cbAGt9lvO0i5I1HShK+kLeNeD4C8MNPzSs4pYvSMvgE2+vKOcCC5bZp3Yfqm1IsP4u4IiiAsY2M/WbKfACMpVqQd/mftpfR8BUJnzUHNUyxlSCPD9BEIcDHkyEGjI51GQN2608+YZHf141dz5Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vELxgDcf3paHloMBeM3iOwH8y8UnrFwSX/a8dQguHug=;
 b=kyyxYfuS2UVrkACXoWyO/NiPyu0oObZ14AV8soJUJE9S/SxDY7Xthma186Ge2j5MCSNOQ46VmPLWZF1YSyJf3rmc87wAe+eAXPZQizzJ+CJcos1Pn/KGADaZniVPbKfZXkoPNPoj7T+8ljMCuBjJUJ5DeR4GuXDhVWNAFSfBbfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3416.eurprd04.prod.outlook.com (2603:10a6:209:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 11:41:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:41:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 11/14] arm64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Wed, 23 Feb 2022 19:40:04 +0800
Message-Id: <0cbbf45ec306ca68b4bdbc8f61cd33e8c1d237ef.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5795046-a6b3-486c-ee30-08d9f6c16f3b
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3416:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3416AEAE0964D10B1F8625F6E73C9@AM6PR0402MB3416.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T+dawJmRyvdjzQwa658Q01oAVCWpwSirDnJbzvRKxMlEZpjL8GxKK1HANonjaPIpqUMVhLmvxZGkhCyO38BdY1pQf6CP2prSer1uzO9EJM8J80UTEnGpAy5gKVlBbS9N0zLgCh3vfchHJwE3MLt2ngGIy4t4K641dI9T5hk/BvE9OAaYmQbCwuT3/v5SSJvhntoGZKou4fmw7iiIiBW/C760eFhwBsqtoxZZ3o+IpTIoIyqw9kfYNGFNjwEwo+eQ/QIV/M2xGSSecKLgq+XjF2iYroar0dXityQmpK6y7XrBngZWa/VUO9DxJTahRtX38bHF6uCiUTrKHcEkYX91To4PzR3qiBnjc+Yi1uBas2/4+3GwQ5JVZoie9JsS6SXpCJg6jcYrokKVKatoHYDmrYtgo8O8hv6LQRrb5E25SUzZZ4IWvFnZU6cUMxSs9KBCAt1wO5H0Tw6/yO0fTLYrzOXzQL6j/L8ZKP9Yf67zu3WfTtX0x/wfVmtVlSqqLLmBfn6XQKuMx8DbfuhrX2MO159V0hVNSP0JnOpwmk2n7ulvUTdBPcDVOS1Mx6Jp0gecBDxoZ5ChhzAAMOy6p404VN75iiWcG05Q1X5pEj+tzBJTABBzrcU6+fL/pgAJq1PM6YM/GCOQEdQskhDdbChdepppX0o6uW+Dryt8ZA+GfFJcoyNAhR3zgUG4BcSbzfWO5zzo5emdPGs+j53mPZc0czHIHYVFbEPTBbwJZwryXFTusRMWAir+1xwjtR9Zy1a1xW/1UFV8U9kue7MUMVuBLwjllikMbesIyGGClIl6ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(6666004)(6506007)(6486002)(52116002)(508600001)(38350700002)(6512007)(2906002)(38100700002)(66476007)(4326008)(186003)(5660300002)(8676002)(8936002)(26005)(66556008)(316002)(44832011)(86362001)(83380400001)(66946007)(7416002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJOHk/cntjG/UROAksIOPK94LQ3aSIZwdlBkrtcyb9AC8miwEZLobNrRQxze?=
 =?us-ascii?Q?y0cAtXRtm0xdDnvftZiLwAHxAkoYkm7TumFG0AYSL2T8HxwcES6VFZ+DMMmU?=
 =?us-ascii?Q?wEr8g72cYZsjaSqnQfUJru8HdvNnk1od5z8z0FKc9eXTvKKZJT5K7LtdLBEB?=
 =?us-ascii?Q?ha1853rZMW7UlPBc5aLVSBqPo5UAxwMFgVtPhqFrmzo9nY0jxso70wcfq/vb?=
 =?us-ascii?Q?0KRC2u9zG8hrBG9ALQNgj/X7xI5HIvFgKmUaQ+7r8DbOmHxUm6lZ2w3pY57g?=
 =?us-ascii?Q?jWf8J6pOEMpb4mA+OCGJqbt0aV8VNUpFfuQyIWlKJDyznmgSkcuzKScTyuMO?=
 =?us-ascii?Q?fFfxBSaMoUok8cBbCwLr4xr1xE9eT0Ki262zCTmiwt5tCIrydLIhlFBYrvqj?=
 =?us-ascii?Q?yEGHTloaW1b/KrrTlTvFQOFmMXRtpMX+3/pgD/SkTF1tizxERnUKtlBhX/wi?=
 =?us-ascii?Q?GoEqNB6QE789kzfgD0tnfLD9/BTS8mgfwmqXcEF66uVIIU6R9YCDpKzou8ch?=
 =?us-ascii?Q?mcdURaEp9IR7F0zIVYl0kmJfskzeMTjD+d7GlkCrFVjihHh/P4X1Frf+eDlQ?=
 =?us-ascii?Q?WTS+EzKyrPqZQ8aLTlaxVmuvoANkcKcFAbrhjq4iNJ0trJ0VMrkR7ZsJjoPX?=
 =?us-ascii?Q?mmTr4YIEkksGQMHmUOcj8g8eqcAJRNxRG1HquYFET6dkAJQtiSFBkaMfYuDb?=
 =?us-ascii?Q?4UYgAZiGnmVYV+jnmxTote8Hk6sFtHpGLLy3i0TBuzMgK+sjgv099AB/sASz?=
 =?us-ascii?Q?z6OVaHv0q+psoyDBPiwdlAK9m/69hNSa7K0MDi3Ix+Mk9XB138XU8of6xBfh?=
 =?us-ascii?Q?5qNC92mQYb6JVYcYehtAeFvAVsNAUcBK4/rwp31N4fVBzmc6PvaCVoPX6ms0?=
 =?us-ascii?Q?1ZUf32thFvcvr1Z2BrMSxpVlWQYyVDdXRV9YPdGzOy4i5M+K9uVSINaiVvH5?=
 =?us-ascii?Q?i6smgocbqov6uwqLF/pLENPPipAfk2DbByhXr+M+hQCMozJQRdY/aV7suZRz?=
 =?us-ascii?Q?1R5Ss9oC6C8KJArV5EJri1AV2Fh3UYQtjDMwMAfjY9LnuZZKupCCLZmoX3Tw?=
 =?us-ascii?Q?GmXM0MUd8PVD/jIvTYRQWbAD61HZpFEkEqKDdgyT8mE63L+8E4YJuC30oLWG?=
 =?us-ascii?Q?VWs1ne4dR3LXu+IhRfhqeiQfBsr4X2uvvs7UiWI68r7V0lZ6brPz9uzooIsN?=
 =?us-ascii?Q?qxmH9vymGZ/dKXEV9MfH/u1XrLp45lcQrGHc7CzXWA8s0MvcsoaRMeKBN6SO?=
 =?us-ascii?Q?apDPK9mPg5unP0XTVbU80PwUsKiyJ1lvGPEs6fg+AImE99g6wBVHEQcJBgIG?=
 =?us-ascii?Q?ibEgck1ZP4eLOgJSVuSzRqwo+9wALen0JWJz86eEhQyzLjOdQbnktkheWJCv?=
 =?us-ascii?Q?C1WgOOWFfX5FR1sUEef7oe5xXRYvHVWrkb1SDCLbeilmU4kqb9nmW3ir1mjO?=
 =?us-ascii?Q?uKSYEjaC9cfEafCRmaMD3k2hcCFKksFFNOTgo3+YyUhF9nAprzTC9WHaeQth?=
 =?us-ascii?Q?VoMywD3Fefo79niJch34t6+zFZALT2A5qM5Np58l2VnZLXSsJr/jYoZdD3Yi?=
 =?us-ascii?Q?FqBnau//5+mQrf9zXK338u9tN6fAhQvIu6DlbtorphZxK0Tffy+c7h5ggPMa?=
 =?us-ascii?Q?dDQ7SHSwCmmM5XE14HBArjI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5795046-a6b3-486c-ee30-08d9f6c16f3b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:41:30.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw6vRlVeU9C2XusVa/EwueOx8OmIMtlW0qBvCBV5WhqXz6xZWQJ4jLidj/AbnUmQeu/19uDJKySiQe4pmqUQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3416
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

