Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96C49E44F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiA0OL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:11:57 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:39551
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237306AbiA0OLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLuuVUBYOYvtp85VH8OOwtUe4v7TfUzPK6+bJiWB1o4zSOpOpibVjCN5Cvh+9dPL9Am8aGDsKM4OaNyYsFS3J47L7zjIjDdDyMC6IkQvBlw1Af1RK/p4ybHb+JoAWm350HAibkPCBUFsqmU+cCI7TncbhEpsL/NY0E2tVK2onvp1InlzNRKSMQizPQRG5qXjSIxKeasPh01JYRhm5HVX1InikIX3EveznvNOIoH7onRq8Gv5qmyotNZfkVegHu6TWdjIZp0o41TjEcyEsQ+Xn3snK/HevSZGjy5tBLjxoH5p6w4UVZfYHyMkr6U/Hz4jnUxKMDSlO0deR0FjJe/Lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRc5R1X4Cvg8rNGNUpZOcSFll5ZvlXEO7Q+N5Nfr+7o=;
 b=iqtY4kHcgxzENrw08CGHEJXK4PQf8yY9IUbIUjWQlwoFax5U0+JrXbjEoZVL3+IB62edFbGoX6JE32sxHFPb3Hn/Vm5Z9iuIdmRexS50BCIeyojjgrS2fJe20uex+PH5qjnEA6cY+DnzryIMGbVw8P4A+WJHIb3xVkvhDwX6IjT2/28F+v/Qswm4FtM7jnI2o9Y8PAPk5gvXHkAr0CRopuZyU2BF/WySZG93ljaKuJgjAGLwcAIhYVuiFxyOiMHmXuxK+jl6IYL2APDpB6MfjUHh+HXChi0Y38l5S5znG0Q3YJWOwqBrf7B3dGdP9lU1MD+tKlT9rejFhT7CJrUdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRc5R1X4Cvg8rNGNUpZOcSFll5ZvlXEO7Q+N5Nfr+7o=;
 b=FJGnPGgw6n4US37/gBC9xJT++Ux+EAhcHeYBVJaP7eGhO+FPljs7nctN1DFHYNE4PaHIaxF/soIVP7+R6Aiy1EmxDKdog2GZiLoqyVt1QEvHu8YctUbTw2jRILPhlmM/xJmKwXfn1vXRl4U3SkQEfaaCOSD2S5fqcG3snpD4dzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 14:11:47 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 14:11:46 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <frank.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/2] arm: dts: imx7: Use audio_mclk_post_div instead audio_mclk_root_clk
Date:   Thu, 27 Jan 2022 16:10:51 +0200
Message-Id: <20220127141052.1900174-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0178.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::32) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c2441e-6d44-4a1c-4f37-08d9e19ef36f
X-MS-TrafficTypeDiagnostic: AS8PR04MB9208:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB9208F2FFC639BC2FF9A74885F6219@AS8PR04MB9208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/3OoIdLwZZR6AuyEoPFiXUBufCHec88kbr3ZTZqxxr3hmbQ5s27pskqJDv3REKT2dTYWGQcGIk8HiMAp/1R+iiONP6xlE+KxyxIj4otEyojYKz42SOqfvP8AzWxSAqp1nLImLkW7uLs5hB3nhNclc1FcUeGfadV5SuBhD2AptHglqiaVwSnDVV72y5lahl6c5HLImwVti0lyNHyz/j3uiC823zc488/vsTAV6BHuXD3qt/dbnW4jrzwoWRHbKg8xdhdmPi6a4v8VPq2n7UIvsq7Z2l6saOdzNwpe0+hjuggipH+8H5gvela5On4C4GzJ73Z9/SPx23ieoCvOs06I92geE40vl+bQRLGz6ofgeRkn0okHW1HN7wc2o1OC4Nj7Z4W5dLEo6El7o7zk9mnpbFzWznEqIbxiCFXWPrwGViRhrZtBysLexowVMZIieAx2eKYC+KBU9qbQeJfsZmbP4YjfXX/yo/cySLaJjsEc0U0CRORU0hH5w8RDIebvWWQMwlLqg/SHuD0ytb260BOGCcF5QOAF6y3IIsuJ46BM2tyaCBeogy0LkyolIfZYX2OE+SeIy6ZcKLGbyCs4Ixr30ZFi1rGTpvlcjnNWmecAnHREhFOOa2dhyXlchhCf/peGYeYnBSV/fHIsJfv1TXBO1oRnt8CutoLASHFMNQnSkeDd5XxadROyCLUWI8w6Ta+/VZyNdFOMUaxT5fqkCOTUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(86362001)(110136005)(66946007)(83380400001)(316002)(38100700002)(52116002)(26005)(186003)(38350700002)(2616005)(6506007)(1076003)(4326008)(6666004)(66556008)(8676002)(66476007)(8936002)(508600001)(5660300002)(6512007)(6486002)(2906002)(36756003)(7416002)(44832011)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxUNcF3zaNScPAgzBr2sBVyY45/DXRuGt/ZCUq2bF9ZzTV1P3TuqipUp+8yC?=
 =?us-ascii?Q?w7G9gQgiECVICX7ZGtl4NAM/kljYsDAm/cAjJaeSAieUTxqQsBaNCCsD76rk?=
 =?us-ascii?Q?ymyNnkAh3dBEU42Nd7oFmpL+/MG4Ze0j5GoD8ki/FWg35fSFEXlskSmRieE0?=
 =?us-ascii?Q?pfR8y8v5a7sYJahqt/Bso4ZXzEbHPjHkrUAl9DlJ5gZ1Icg9J3bKgF6Wp2gi?=
 =?us-ascii?Q?G2O9lCxUca0/UVLJyR63CpNKx60y4mfaUilJRe82tuvPD6906mxnZkAGmF9k?=
 =?us-ascii?Q?/ywwNM3EE8Uql+1l8lun9YOqna1OSgMfkLM83fFVcip8ALcQ7aOfMKRQ4Ana?=
 =?us-ascii?Q?UpKx6fFwXU3ql2aY+AvrXdEkYwnwgxQ6+Jt9MtusCDGKmMCSZ53rE2GNe8DK?=
 =?us-ascii?Q?Fi2MxMv7Mo7utLYM8GLaa07bh/XotkGj3qoCoCkYjNaGn3rH2XndFRMgh/ig?=
 =?us-ascii?Q?6FZIjE3ukzw6IvIoqpasWegO9G6zre9hgFwoYnKvyNfLeDhRao3GzGEFPZPy?=
 =?us-ascii?Q?gQX/xOm02zHmXmK4Lv7xwKbQcItjx1CnsNJB1nWqbsAmJlhEC2Bh5eU1+zYm?=
 =?us-ascii?Q?COcJUaljVq7uVC5sY6waKKuIUckKmw8okp5UQAiibX89/yiMkm+cNSfsNqss?=
 =?us-ascii?Q?aHUSeIAbpg94YzYagjK3z08MjBliUryYDzkMUOH5yicMmJlJ/5bMYKEllnwa?=
 =?us-ascii?Q?kGb11DXcaMRq8Xz0l6jniw6rJPfpt4BTUMPTHRZRmbcQM1i/ResyHGMXJocR?=
 =?us-ascii?Q?aIb9O7dCGU28x2ByDVC3z+aFOdPGGxCzs49qttb2SgD9LRS0vlne2EmQ5a/N?=
 =?us-ascii?Q?kW0Z1VWF554aEBKZZJvKm8td0zmIrMZRdZeO2TSY0PN3FvT7NwAx/ELyv0wz?=
 =?us-ascii?Q?sK8yMXw4xhZ+pElEd5/WvZ1L+V6q5OwhF0mowBXrFpC8kh42+PSFjQxKdgbo?=
 =?us-ascii?Q?uFAut994ODsmX2ZoagNFriUxqacIKsjPWp/M4aG8Iy5XybaxmhDfhnV61iLn?=
 =?us-ascii?Q?X0oKu9NNqJsOuLP5WWrmnWcz2S5kYPCZ0js51pM/gom72RgahVW/UcO0Wgd2?=
 =?us-ascii?Q?oMkzkohnUet7bpsFS62JgKo0Tb6kh8GWyKq4o4pN9rMU7doKEQVwXl9tenNO?=
 =?us-ascii?Q?ueP1trvr1dqCLuCycGPl4M+E3FAK7bcyEYlFU0Ua0nIqYcn8XtH1aDmlbhQ3?=
 =?us-ascii?Q?MPesaIA/iu3RnLES3Ate7K7RHWlkLM+UeMsIBPKoBn9dMCpTYzzVHXepZDPg?=
 =?us-ascii?Q?8qxS/fWbwhU0Rs9NGBjMLHMlKQceHqTlxzou2xC/q3C3kM8Jg/F5hNpl+a14?=
 =?us-ascii?Q?kDWZuFsx/5VXRdxVjZAieJnLVad6o6TvnI8zDAYxQOv4xnFSJmTPEDrkTWcw?=
 =?us-ascii?Q?OdrOb6BWC3NY+JEvoewtxMmMJYMnVLmKgTU+GnJOyTmMzv7XQHE9NUmzwlUe?=
 =?us-ascii?Q?mhz3fDu4cvHJ1zTyh+r86FNAbQJC9sJp1tD8C6RGwtRV6fqzw7JwnVO2dBVw?=
 =?us-ascii?Q?WSDN2wxy08tGlZuYTqzjQCFaZZvLRneq+io/18E3nS1jWB1x1kBNZBz1q1Bc?=
 =?us-ascii?Q?WbDHo8TnB8V9vKvqoPkD5hHhRgZTWy8K4KaCw++Ej/a12FrznYbGF//4i5Fw?=
 =?us-ascii?Q?ZzxVozQYYsUcV4gjUCJ9F7w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c2441e-6d44-4a1c-4f37-08d9e19ef36f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:11:45.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5PNfeNte9mo6q9bPmiSBCpzdY5/9KTO+yOVzp358V2ZfcBLOhgYGR3Oa0XWxrUUQFBuOlLaNO7uF7w33xy/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio_mclk_root_clk was added as a gate with the CCGR121 (0x4790),
but according to the reference manual, there is no such gate. Moreover,
the consumer driver of the mentioned clock might gate it and leave
the ECSPI2 (the true owner of that gate) hanging. So lets use the
audio_mclk_post_div, which is the parent.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi     | 4 ++--
 arch/arm/boot/dts/imx7-mba7.dtsi        | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 4 ++--
 arch/arm/boot/dts/imx7d-pico-pi.dts     | 4 ++--
 arch/arm/boot/dts/imx7d-sdb.dts         | 4 ++--
 arch/arm/boot/dts/imx7s-warp.dts        | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 62b771c1d5a9..f1c60b0cb143 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -40,7 +40,7 @@ simple-audio-card,cpu {
 
 		dailink_master: simple-audio-card,codec {
 			sound-dai = <&codec>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		};
 	};
 };
@@ -293,7 +293,7 @@ codec: sgtl5000@a {
 		compatible = "fsl,sgtl5000";
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1_mclk>;
 		VDDA-supply = <&reg_module_3v3_avdd>;
diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 49086c6b6a0a..3df6dff7734a 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -302,7 +302,7 @@ &i2c2 {
 	tlv320aic32x4: audio-codec@18 {
 		compatible = "ti,tlv320aic32x4";
 		reg = <0x18>;
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		clock-names = "mclk";
 		ldoin-supply = <&reg_audio_3v3>;
 		iov-supply = <&reg_audio_3v3>;
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index e0751e6ba3c0..a31de900139d 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -288,7 +288,7 @@ &i2c4 {
 	codec: wm8960@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		clock-names = "mclk";
 		wlf,shared-lrclk;
 	};
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
index 7b2198a9372c..d917dc4f2f22 100644
--- a/arch/arm/boot/dts/imx7d-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -31,7 +31,7 @@ simple-audio-card,cpu {
 
 		dailink_master: simple-audio-card,codec {
 			sound-dai = <&sgtl5000>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		};
 	};
 };
@@ -41,7 +41,7 @@ sgtl5000: codec@a {
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		compatible = "fsl,sgtl5000";
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
index 70bea95c06d8..f263e391e24c 100644
--- a/arch/arm/boot/dts/imx7d-pico-pi.dts
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -31,7 +31,7 @@ simple-audio-card,cpu {
 
 		dailink_master: simple-audio-card,codec {
 			sound-dai = <&sgtl5000>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		};
 	};
 };
@@ -41,7 +41,7 @@ sgtl5000: codec@a {
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		compatible = "fsl,sgtl5000";
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 7813ef960f6e..f053f5122741 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -385,14 +385,14 @@ &i2c4 {
 	codec: wm8960@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		clock-names = "mclk";
 		wlf,shared-lrclk;
 		wlf,hp-cfg = <2 2 3>;
 		wlf,gpio-cfg = <1 3>;
 		assigned-clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_SRC>,
 				  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
-				  <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+				  <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
 		assigned-clock-rates = <0>, <884736000>, <12288000>;
 	};
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 4f1edef06c92..e8734d218b9d 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -75,7 +75,7 @@ simple-audio-card,cpu {
 
 		dailink_master: simple-audio-card,codec {
 			sound-dai = <&codec>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		};
 	};
 };
@@ -232,7 +232,7 @@ codec: sgtl5000@a {
 		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		compatible = "fsl,sgtl5000";
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1_mclk>;
 		VDDA-supply = <&vgen4_reg>;
-- 
2.31.1

