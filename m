Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900BE4DBF55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCQGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiCQGWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:22:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DAF6EB2B;
        Wed, 16 Mar 2022 23:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iesUl6zwsZe5HxRBni6HdgYp8Ys5Mx88umHQEV9uTfFclGTLKA3K9SF3MJ2+nFgVjicCrcNVb0Oq6XdBHveEIGmMc9Yr3At26/66wjWt4jQonc6yiV1OISUsqxx48UQ9mpacjCXW1RoQgxO9iSRP8y06hg/oFuRFN2+kYTg1SEnqgpub6Swky9DMeI3Q40mPh00m1vn2yJHVpj1HYdeIdiSJFUG/WjF0is4xmUFjOLHeOIcp1UB7AhWE8Udg7SsGHYmODkwuD0oWfevxlfPfbgbBnEBFM28wdDJ++ban0l/2iyuUl7G4I/NPjUpg2ZXoBV10CMz4GoU5oQZlqgJwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIxXwC3sM4wJ8/Qo+yjE8iUNe6GZq+O8YocjNWBQUJo=;
 b=FFueF8ZsIFYJS601XMUYx/E/BGN6gHc/zAxXg/TLZF1DytXaEppn4DwZONWpJiyGr+fHo//w9YfP3t/3/qbGGbIb62SqdqsRMpqqFl9imOSBzO2Sgek4QwtugObOAxBU2uE1UvdDejTfIK/njudD+mge80xNp+I8b4IoPbAs2rTcNKiPsDa97lQjGj3jdGKCrofDO9iEoQhlk41i/bU+WF8UmHHKLZOBfdam4K/NBEEenLB0h7f9hunEgsg9FABYtZIRUHKBf4AwRN7crEZ/jEA5bCrcfi8kJm+Fx6cXDYp/ripYqmT677pAGB1xIgCsju4IK9quAzStcIk4f0bpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIxXwC3sM4wJ8/Qo+yjE8iUNe6GZq+O8YocjNWBQUJo=;
 b=bMfXWpTZyYZ7m5GMstjDDE7zPcXn0jhZhcTs2YBBe6IeaqC+PdBhIftIYzfS8/rFP6ANbtwWI4epgtiert3Y2PFrFuul+DsbW3b+xZpY5pca7u+yZnAhOJ2mzakhkCd3oTmsXMQVBj2M16f6nknIzBj0jnaG7RYLD6C+WKgC4XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB4611.eurprd04.prod.outlook.com (2603:10a6:208:71::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 06:11:57 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 06:11:57 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v19] arm64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Thu, 17 Mar 2022 14:11:30 +0800
Message-Id: <20220317061130.20857-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdf7754-28e9-485e-831e-08da07dd0a41
X-MS-TrafficTypeDiagnostic: AM0PR04MB4611:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB46118C52B10BD87FFA7A08BAE7129@AM0PR04MB4611.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUOCqB+w8jSUbzIIJcE+vY5ZdysS5atlxryBy26m0aPzX1puAR+f775ytQGJVS6/2iY8xttEcBzbC2FQjkl+j90Uzxjy0KtW1ByUr4kCSXZs8SxtK8wtgeaM7+BHVVEGqWzqtC5vmD2NDgMN7ggSJHrT8DgbixWx7lsTEehSfzgCHIrfbH3eu7btfTomspoUExP0xuiSSLBNrhJlKHspxPQvvOrqicHpbhqVkWI0mzOZ3OXJ3hBn5+C3Sjn1dnOqH+uCLclrhzydqQfQkNGN5RG2NsmFQml80mv7RqL0deuy4PQvQr48G3R+PQjJg6+5zVLx5EhKMmksLsspbU08lF+SCG7ywuc8NoEuiGX6GM4S9F0QAyab6TpkqxiElHh9S6UZYOk346fj0gaTITXJQe52GZuqSyAd77k3x0G1/9/3UMuIXBqJV3KoyHnsnMYqp9VHObTtgubqhYMRVwDxoml4UfJv4E76lmBygc5bcBkgudLVcFzu/fZKgZR7qqQ6a7eN6zrCEj7llb0P0/wHSBhJS8nQXALTSZq0qUNieuhSJVUM7YfV2VFa4qE9Ug3OuvqKKXO52ny6Az4gRP+FfOhjsEJLFsqnZc5e+O3ibBtPxlgegoCBuCx0+3sm/R8n5h9EEhxGRf59pXEvB38qQPN940dtLYo4ErMWr+zNQbwbe+Um8VczFUBNtXpMqgNgWhmLond/5m2nSR3POevDQ6dHCFsTmo/9FBFv4b29vCzYa9v6UhSuTDnMayW5LSO9I3EbMRffSWST3fcMaf5MUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(2616005)(86362001)(6666004)(316002)(7416002)(6512007)(8676002)(36756003)(44832011)(52116002)(6506007)(2906002)(508600001)(6486002)(26005)(66556008)(66476007)(8936002)(83380400001)(186003)(38350700002)(38100700002)(66946007)(1076003)(5660300002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dr0jHLwz0cKNMjludiCeejQYStu4Ybcg2k1HJzy/FVok5ZENBQGattufVGIV?=
 =?us-ascii?Q?qjaDBSEbI6GZliPnjrY9SBFfdGHRUrObHXKMUzUiAvGdtD7tVVo80Imoo7KP?=
 =?us-ascii?Q?ngrRqj+IzefLcmYJaROOBQ93gpGo9vKlPyIgu4xZ7sdgLFNKr4DGBx6Shc3D?=
 =?us-ascii?Q?jVlGOLHWBAsgI1Xh1dbMX//D3kN/PjNRadNgYBtqU3s+wcoIRnarFGL74n+/?=
 =?us-ascii?Q?s2zzL7YpVSFOYzX4qlD8UlEML4+EqTzqYMYol1gvDhxQ+cFBNldREP+1vmzL?=
 =?us-ascii?Q?Wvhv31g65LG+aABpcyTYleGAPPhH4QJoEAzuRfLd6xHeFrqu89+KcmKjnf3u?=
 =?us-ascii?Q?M9bd0l0EeQb+/GpI/BZd0d6UhgOa+J7ZAtwK/02PIcYa2d7zOu/x/cTNvbRk?=
 =?us-ascii?Q?o/ypV1iONw/EFMzz/7TqdkGDJmYoGK643+v3UxlNIM/jM5xeogIVlAV2jQnX?=
 =?us-ascii?Q?HyxKCYNazAnpxVW4iY4cNhvNV7WJjXL5F9Y8oKIVQiXiaAXhw/8VIv8jZd/B?=
 =?us-ascii?Q?Ieu/KXtN/oW6p8nytjpo0sQ2rMClsgEdO8PlxjQCqrR4mA8WGtD0qQMsLAG/?=
 =?us-ascii?Q?1w7g9kNUo4js3ST6wwFlJYPzpSCcb94mJeleRdKqiyGKGcnOS4eGmufhlFaJ?=
 =?us-ascii?Q?GOhaFtDiUbj3OJZ7EBihZTG37gEbYw4VKbYVZi5rVoSamSZGL9mh6qHfPpq/?=
 =?us-ascii?Q?ovqoEnT16SbVfGTHfPaf0VmHZV9ZGu12XNpw9VqsDTkO0/4zE4uIVwBsy0Rd?=
 =?us-ascii?Q?6LZLrxNsnPDfe4IIAyb8wTEO5YO7Js5hRrt1tq32eK/98tBa3QSa5Qp8G78w?=
 =?us-ascii?Q?uLLMfR2LK4zeiSFlZFxpvoFUhOQ3Mw62C9miVxq0OexIElYgHUZUHK6R9WQM?=
 =?us-ascii?Q?V7RfBUGrVD3X98Ez4cAF9KIJ6Beye6YEYrshEhz0C0UwJQPAry9C2YJGd6cX?=
 =?us-ascii?Q?CRikGRXcAU9UaOf8aZAuN4KqtOHuStHcTH5M+XjCtUXdzoiKnwtcVS94Av1F?=
 =?us-ascii?Q?cQrVjG61fvJdZr3l/SAmRTGDALqzNEPpZqDaYQF1plGwQf2JBlAh0gTLbDjU?=
 =?us-ascii?Q?Lpckbkk9kLZt6OPu9wttPC/vkRSSDus7yeqShqhmZs6bke5X9HHxeyb9Suj/?=
 =?us-ascii?Q?KhO0gxu0AUMrqaJmiH6FfVULZgU3cx5aWlHEbpZ8YpeE363A+OrTTHlMmoWu?=
 =?us-ascii?Q?jkmEeq5Bo9/T+aGbaFaXXFKTM+TDT98a07nThafn8+0N7SdxyKB2z0CdX5sk?=
 =?us-ascii?Q?na+SaomfZwMcgAKUIhOpG3TYV4msAgGf1RusyA4UkXojfYOTJpNHMyz3d3u1?=
 =?us-ascii?Q?WrwuXfSuzaeoT1+N7PCWWMaoUnr8MaGqShCs0Vu/aBnd/otvAtQZZsPL5rAK?=
 =?us-ascii?Q?10SNZmPdCIoPTXqdxNjTzsByEWitZKRjyIyX9aET5L5oUm8yOYxoV4MvPXBi?=
 =?us-ascii?Q?rTGKwmB6fsV531vxK+qF5ZwEW6hQBBpt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdf7754-28e9-485e-831e-08da07dd0a41
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:11:56.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5LhSrS7MBF4RbTz2fHgPLCpjva75KV6YpYIm/HBROGuiqkM/oH4bN/vFJfrXKlecHWLJjqrZq5BwEdUqLoaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4611
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
index 000000000000..989f2bf07b5e
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
+
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

