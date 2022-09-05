Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023765ACA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiIEF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiIEF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4732073;
        Sun,  4 Sep 2022 22:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4Bv9OI0DdSUoElVFtWe5gMTN36bPifPRCKTz6T0YgO/obmv0A2ujEam8BmnbB4RAStTdpuFVgJQXBY76iJMbcKEmJI9xYiFAQzfgohYN7aQdmnblHUe2YYJLGPp/N+Do5KBt4Ln4OUV1yScvAD4HPOwxio4RRVV7PZxc4kEYZKOielw5vtgTJ2Wiea8ZTFkgAk1neUZYjSnoIF6piSoactBuZnqTSIZATAEnGayOBEglGM8EzP/OjLU+Tt8CE5oxdxsKNWerio9ySdWqY45BwcezO1nPy1XJ/VT8XhFwiUCYM9W9MD5W9YMW6NsFNmYalTVSD8bcgIwSLfDMOzUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viVKialAoXkKRlIo/uaV9mrIm4JHaKRya2DMff3jt9M=;
 b=Nj4MYY2hqpMsW00HX88Y9CZ8eumuBxC+innTVdTz81moY2ePQbLDq+ayWdXc/uln2Ggh+au1rezOFIadoQcOqOa8No743HgyTGnUaWC1ij6Ywv5uztuxD7Hnw7gqMb2ZvKAeVxfJgoncXVlJUAGTL3/u1jWKHpAzEioYs9jJJSp4xTya40GV9hSaFSdWZyJteFYq1T4hHdJjVKRcXpXC7bVOg1QP5by3qh1bnCAExI+Oad6kznPGbNs2G+B3pJi5rgpkWFhjPF2J+jyNdo1hqCzC59CczmwV4NCMHV6xsw0RLRpXF31Z0AIQp6fwvZr0GUgK1i/vaxe34qPXASNlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viVKialAoXkKRlIo/uaV9mrIm4JHaKRya2DMff3jt9M=;
 b=kDmZkeFb9o+AuOeNiUswZ7LqG/hVdeSyNCgimVBSfwkS6mvU0H/1KSjG/ghlcN1EsD4A/jE/uBNAk80a7Ptwmz7YzJPZAGWJpFnZpRktHSkQFaI8It7xr4y5BS/Xu1LmKzfr6tdO1t0ePv/emt/imQ4DpL2wgc1HUCvwGKN4EpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:58:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:58:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 7/8] arm64: dts: imx93: add lpi2c nodes
Date:   Mon,  5 Sep 2022 13:59:14 +0800
Message-Id: <20220905055915.3878000-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 231300ca-3963-4a5d-e818-08da8f039c16
X-MS-TrafficTypeDiagnostic: AS8PR04MB8740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwzWJvEyDgtYv0Sme30EMVkmaBNDB2MQtlX8Lq40Xmg4T3lwZEx4xVe7bw6CTS/HOt2QG0IP4Xu+Cno7m055q4rBC8jeh0GtX+Lb9mqdBV+/+39TSJX/oU6w/8+rPZggpAIVZFIqryzcjomWkXRBOC9ptyXL4w2WWngzPH6KHfd4HRRJaNyRV+7WqJpNPAlbr8P0yTdtg+XzmXPE4m8UOnRYuG97XF/jAIB9KQGWSQzkG+cWAe2sKlm4mOSc5/Q5D5O8k1NkKjJoWtZ9291Ir+LDszf525CcKaomSzRjdeoEOkwsP7+gGxVmOCljzsSYs4cHr+IDQxPGreviCkWA2rkzjEC9uMPLDODTuuzJVu+V6Up82hsmLcot6nOpb/ZLtAH9UuO/17NbTUj6l+ND3sht6c6Ji+4u1Y8bCp21FgeTfgzOuf7YbkjxeAjHx6uPBW25PwnQSx7vmwWeQsnq47JQAgVag9cm3fNsaT5sWHDxPOS1fsSr0ailTyeSeoP2TQyZWAtiY9CAeJph00d4FSqX6oImuzLmfcw57rkBxvYwkangQ7yiJnG53iFg8FOisl0cuVaQUwodZfDMaKpmNScEAWf8S4VkgYJ13t3Cmo30c6xbF3lveXwOxyu9QBv5PJXgUi3QqOuapX4Ktl8Mm+SFswLGlhiVWR/9OwAG0yx3Ew6hEuRdQrBuNvAX1DeBSBquV2vIhSbiqgvak3uyQMRLCpUyilIXgi0oMcpNBzs0XT4bAiDVjjgEc6qXc7BeMvAT5c01/RVtNnbuG+Cy/q8sL5Z2334M/RJ09Su5rWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(83380400001)(38100700002)(316002)(4326008)(38350700002)(66476007)(66946007)(8676002)(66556008)(26005)(6506007)(52116002)(6512007)(8936002)(186003)(2616005)(1076003)(5660300002)(6486002)(966005)(6666004)(478600001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xO3blgORqKmOU1ZzFfcIrJMrH6sD7RzvjRxcfWgMstpnvYMjm4dKQWZnURlD?=
 =?us-ascii?Q?b92amfNiQD/u4UfB6PK45cYxpVEqA5BB0j9gSI+ucIOLzhsk4XM9DXaStmcz?=
 =?us-ascii?Q?5I1Rzklt1gnQokBRgketLS9MVbyV26PSqJ/oZjkpQ41wJe3omzaqQuQ1UdSa?=
 =?us-ascii?Q?94HG8pE+OQaxbYw2v+4BPZrr5Ic5qfEoaf6O84npNIbjILffK0DL8dnw5CA6?=
 =?us-ascii?Q?sEFOFd4jT/7dnZp/LLQBa5szikQOUKc39lW4Oa1vGPro4GsHoaR5gmSiW8lu?=
 =?us-ascii?Q?Bx7jE4rH3eSBMy0O3Q4GRZkybYGRKvyfvSa2wDmErwHU7gv92/y3228CZ37D?=
 =?us-ascii?Q?xlO69X67u6lXDSMupXbPyPgQlbBECfAx3SLmVRXBN665g4KLlJkgdCNGTECI?=
 =?us-ascii?Q?90KWxCj6q0gR+mvCQd7w1HOm3jX4A4Km6rvPd9uvQn3/K12cVtjPF8LH0UQe?=
 =?us-ascii?Q?z0OdRSnvvT24ebH99Iix5WxxuKlAROV7AkUK27/EdI7HDjrp8kSHtxeSFUXi?=
 =?us-ascii?Q?QxFI6VWwAPVLIJs0ZjuQLxnLvxfvCqWcehYskyOZj1OoRUxINUFdGdv6xV+i?=
 =?us-ascii?Q?djsJ5UFF7fFNgA3kQYXHIXGlQ5Xfvb7UPANF6DBkorBIea36lMK9y0uSPDLW?=
 =?us-ascii?Q?tM6e5k10c4zCU5/ixdD78ebdCOKWOqvCzMRI/dCakFMe1jtWWlxy+1wG4enB?=
 =?us-ascii?Q?CGTVbKdsm7+QjE43z/tN85PMdyw5R3u7rwvEmixyZ54R9xb8ZJpJhFcxyaxs?=
 =?us-ascii?Q?ZCkhQLiwxwLx+M87U2WldiUf1gR8KClEtZcxnPGopIq/UTXGX94/qgMnKKFY?=
 =?us-ascii?Q?abDz/oZ03nNIpOthXem/+dj+pepw+fz23EvgT8/7OZWTgVBiKMXRxib6gH4S?=
 =?us-ascii?Q?QYI88PuLTip2R7Qf4PgBLEg5hv0MpOwEF3u6Ay6NwEuEq0bR22ImSftZinll?=
 =?us-ascii?Q?CxO58x15F8P4+q5kq/AhfVwk1WPmTiPDbNMjp49p16ccebtWOXB78CpTmVEa?=
 =?us-ascii?Q?a57+bL/R7sxYUx6PqN/jKmHpFR/C0XQVXJAe9nQFINioJ7sO9kpeznIlveHb?=
 =?us-ascii?Q?9zfiM/C0NV2nwZ9c68bSAtaV0CswMS7GnpxjeQTihD3RLhVReJFtRmUbmVxm?=
 =?us-ascii?Q?5VarEQmWOG2MAaT2hzu04XjvSotr7kQX1kopHvLdrfuBXzhpdQyb15g/mcvU?=
 =?us-ascii?Q?2cx+NkeryHdP13/UNxvh3+0v+ZREiAICifhQm9BIOHOJNM9cIvi8MJMCeEdb?=
 =?us-ascii?Q?EfZLOjLOpXnSXZxIQJD6cQgg3gfh+gSICRwASJl4X34uzO5IWnOqHOPXuacT?=
 =?us-ascii?Q?xPWtfHtoHQddnOgjXbT3I/MhCb7rI1VG9SdDccuA3PfdB1Iw6907t81tkoXr?=
 =?us-ascii?Q?F7YmYQjYCem7x6bOtfXd368tKZ2+SruxQTmhdGgw2Zh/vtbl7D3ymb+cgAyz?=
 =?us-ascii?Q?LjzSg8jrmWSNDKrP9iMbnDxHpMcsSnTEa5BqIHNi5QTPseeRpksHKHkthhuD?=
 =?us-ascii?Q?s2pdvfIO2z2FbaXuNPhHBXyFZ5kDtZkYPWmSY/1tUrXUuPPdDcdnoiyamQUW?=
 =?us-ascii?Q?RkEl7ZAEmYZwyOFD/RmnVxVv1LSWvw7TeaauEe87?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231300ca-3963-4a5d-e818-08da8f039c16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:58:09.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmd39V13s3Ir3ManD+e8VJgGiQhkDBrlT9VS247vWx5HlRrDvDyFy9PFNttt+ZAFj5s6y+ARLCY0q6PdvnVj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 lpi2c nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

binding doc accepeted:
  https://lore.kernel.org/all/Yw3hfcQ2JV248GIo@shikoro/

 arch/arm64/boot/dts/freescale/imx93.dtsi | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 9f6e8a386071..1a5a6c51aec4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -16,6 +16,14 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
@@ -138,6 +146,26 @@ system_counter: timer@44290000 {
 				clock-names = "per";
 			};
 
+			lpi2c1: i2c@44340000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44340000 0x10000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c2: i2c@44350000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44350000 0x10000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart1: serial@44380000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
@@ -197,6 +225,26 @@ mu2: mailbox@42440000 {
 				status = "disabled";
 			};
 
+			lpi2c3: i2c@42530000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42530000 0x10000>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c4: i2c@42540000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42540000 0x10000>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart3: serial@42570000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42570000 0x1000>;
@@ -250,6 +298,47 @@ lpuart8: serial@426a0000 {
 				clock-names = "ipg";
 				status = "disabled";
 			};
+
+			lpi2c5: i2c@426b0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426b0000 0x10000>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c6: i2c@426c0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426c0000 0x10000>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c7: i2c@426d0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426d0000 0x10000>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c8: i2c@426e0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426e0000 0x10000>;
+				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 		};
 
 		aips3: bus@42800000 {
-- 
2.37.1

