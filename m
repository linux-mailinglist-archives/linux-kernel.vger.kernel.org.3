Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38705A7AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiHaJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiHaJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91876D21F6;
        Wed, 31 Aug 2022 02:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfkWbo2D55MKzRSbglWqXqWF0XiKsNbT2GGEAc6SY+BOOcObkG93mnZDuIgcIc5Wuupc/UxeJH5hc+a6twuhm9xfZ4Bs4Tt4nkeJr32bUyNxOPmmLuDTAC1wO52543vbI3YVyDxK4SPEXfVcP/QoP73ByJMQPfDjog/sePenZm3yJEkX6a05Uta/BktJgmiTJM7Ks+PHk8kasyFle47MSxJNdN6Zs1sCjWG0lak+nUVrDHwP9qdH7INH7EVjsah0RoyHfrEi3yPWoErSebjkun+bmEIwCC+v2vAtzWd/R/wrS6H+wMoGMUZ5m4f/aLeeA8Yxg3210rZPYb7PCX+NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KkVVSdy5o3tD9kl9xMcRzHotMk2Hi6mnYgMs66deM4=;
 b=Bk7/VNwHPrbX4j2XZ12a3stfPSGCLrU0p1M7JUSrCHoCdxhxkkBD7fMIZVeiHnU1K4xE3ZjeAV+K23ecW0ogjxLgMPhGXSOYR976bywUMb5xuta95DHxeFAZisixs2hEy/DMX9cEOdvaSBKOwmPaL62cED7VYtjnVgkPDOAR0m0aylw1skbG8k2YqOa7yYFqZJbme61MJ00xAo7AzrYCZdz7cTgLLY77xpc5y0nONuhwMTCumvnDFGV8IybSLmoKsjaDmo5h8VTlbKH2MpajiRPxKUfkQRAQ8HewUBGhkbc+vKWzO18hEQvvbdbClsgZggL8seVQIN85CpkGb5aQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KkVVSdy5o3tD9kl9xMcRzHotMk2Hi6mnYgMs66deM4=;
 b=QkkXeeV7ib4k8uTP61iBcO0J2xZUYGH7uFW+hp8zHS598j73Y/MRPDs0NPu5U2ZJrM33lcsgNnUKTUvNh2UjAuTgvy4fOunbQH9G2YvbWto+1324bxm2xrexv+bd76ygXs2sbSAQV/R3BcgFrA7+fpDZL29J/KMSRi4eqAVDkh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:59:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:59:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/6] arm64: dts: imx8ulp: increase the clock speed of LPSPI
Date:   Wed, 31 Aug 2022 18:00:16 +0800
Message-Id: <20220831100016.3649852-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
References: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b860d6-253e-4599-ff39-08da8b377421
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuvlZ22e65cCsDPU2tXdWjskpw+WOak/qMt3jCFvgrp/SxLNnlbevTvfHyXKwsPD9G0rAzPwDVDPusZPIcnraQ8+hqZW0f4l2yuu1dLOI/RxRGqASgWWPtXjkSLBQJ6eoUw5WoKNQ1uabGMcwMzkm9qoezbjVXXqRgcpPPUcq1oP4ezwthcdWrHvokz+x++LIl2zBpM9P2UhL6OQG2tD/m2JdXWgR3ygf1OFneoTmzPdT+gtCCy8yyKeFqBrLjhk1IOdg3S6ZVa3uQzVFfIOIUJ472e5XVHGDBecwzeJZniNA5mx5QV1qlVPoaEEN2RcLD0XiGBLwt863oCljBAROw3GuTp7ei9ke5erh8nAc+cOHupS/Yf6YvNb0HlfHjM9ZqiEu8m/64Kh/VFfCAtzUNnEqojNEyI96m++D6pOk0ufpXg5YwTvDlXCdCzMCasKpbznnT//0xVuBm3/QAXoUEAXEwRYsYBDY1iPOsWkm8VL/RYTbrzlG6WL7CWlKS2JQ/SLn3L4EOphPJUOYSYqefpKEcZ4EWQqG27TCpV2kAWuVKE4liFAToO2TPWPDQzrmywkOSdZUJzlejYOR7GmL3VmIrYoZ7nbf4t08xrdVqESw0WOA60L3poxsQ3I6+opEht069ddkHynRHnnpi64ZRViQrcQA5KHc976osLGGno0RcQXWAHlwsy/eP2TZ9iUiZeiCwr2kKJPFLo/RHfMKgHkNetW8sO79kDTYDOuTLCN3zoB0uRrdY8616DsQigr3LhGOVGMAp2EXUAxH8PiXQ4r0c7YuG11K7jOryx3SHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(54906003)(66946007)(8676002)(2616005)(1076003)(316002)(6486002)(41300700001)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxSs16dVD47GFmczUZq0ObCrZBrQiNTxiwIoWEcyb/6F/9i/Nfy8gwGJdWqQ?=
 =?us-ascii?Q?GcqvJAuqY6KeV/IWfK9X7oqceme6a6MGMNDyeLwMlkbBfjssi1S3Ry6NxiFT?=
 =?us-ascii?Q?kWox2DbkkrUFiWzrc5/k2o8xbq1GC4Y6tMZRNoIqoPQH0+I4xAP8P8xsSHMC?=
 =?us-ascii?Q?iGvpwDAu9ZvB9TCGl4bsS9tnr0700m3DN370O4MihWpLP+OyAGPrXs+nUfEi?=
 =?us-ascii?Q?O521BbG41QQj6l1waAbmDVvAn9zVoFB9I2WsyX73fwYwi49GjOt/esSTUWe4?=
 =?us-ascii?Q?Ij6qQ9NtkuPl61EOuEWsX7YKW3cZ2HyayhuNssZCxBnk9+mkY+GgsL2opsqT?=
 =?us-ascii?Q?VtCKl5CbvBX98SZ7tGkLBcSyWSKfYCk5QJ/Ftvd2+POe4hxc+FOAiZ1IBnCG?=
 =?us-ascii?Q?MZI6GMrd07Tru/4DqbQ4x0UX5HRb9s7ELPFqNStznVQr4t0sbeuORNOEyPoz?=
 =?us-ascii?Q?dFyQuvKWo2DcAdzkKfdJnQGoOH31jv7rcEgadPonfL5j4XTOqHyS1aQwNeYz?=
 =?us-ascii?Q?pvjT3p6q9wVew1e7nAMAlHkdDAs11FtPLvHpPh2d125/xdHrm/rbxFIXR6YY?=
 =?us-ascii?Q?vv5V57ErIge9WtgRdM/UCGwSmwbeppChBSHAAKa5SlntI+s7pEhlAIb5uV1Q?=
 =?us-ascii?Q?6D7NfNpc0xCtY8W384176bGoTB+rRdv4yvP6/xH+b9A5QBQL8qQCguVkVZxx?=
 =?us-ascii?Q?DpSgmHHJ9NDToOhLQfd/Ch5qgBrBTUiosI73XW1RJCNNLOtWksdiEjUJ+NMc?=
 =?us-ascii?Q?5bN7QKDaue+kdrlRaOCRrBJWbhbw43t+Ys1iMOGUKOi9d3IzBApt8CiiQRxz?=
 =?us-ascii?Q?APwps87d2d6hl3BH99vrHP3Gfdq044kvF3GXGQ1IhTO20Gqbe3r1CrDJUUt+?=
 =?us-ascii?Q?ZVk/XGxMiEpF/cN3c+/X9YWQG0zFpchnc7biiapKL0E8/PD2zZ2BksjR5/Yv?=
 =?us-ascii?Q?ZXoMgm4JeAXEF/aMWxGx8Icgya7JK5/J/8bZ0MdTv8NCdf6j14JajEkzftDm?=
 =?us-ascii?Q?nrCEkKLexPoercjFG5EdrXIQUBfXrk+nNSjQKrY0Cib+Giub9aSE96x7L0We?=
 =?us-ascii?Q?SMY8iD+iscu68o3dRrsPD+RtIS1fPUV7vSnYR3wRiie+7gARvMbRgZbbkAQK?=
 =?us-ascii?Q?I2QsPNm6oxXM79KQQvWyqrbLYC+IOgMZevWFGjxwlbQ6T9nfTry4S9pR6gTl?=
 =?us-ascii?Q?1JwmlYlWC94gSuHZR1wMwDIVEbFgsOtC2I/SJSUNctcP4axfJ0rFwNuONUn4?=
 =?us-ascii?Q?PnGd8rl65UWTiZ/+e/5EensLBQC+87a1Pwo7uxrunsCdhLahqNHqvsVDOXOP?=
 =?us-ascii?Q?yS1GNaCR0UG/VlhS0n+nYuISWyp1w6xACOw/CvbEtuLEf0pH1rIYj5E/CxN5?=
 =?us-ascii?Q?o4u714FLGlLZI4TTg5B2ZpxGhgu2LMESaa7UbIkr00HHDticHdNuL6oCojQL?=
 =?us-ascii?Q?kOgBRSisEjaZj2kgTuw6xA+QTb3f6azHn6W7QRDiOBzLWlcKwYmHP8rnZ2Ua?=
 =?us-ascii?Q?lcQEzSejtvB40+ts87B2OsZaP4qqVrglSa8dM48KNHv102VRINW2+7KcrWdW?=
 =?us-ascii?Q?1BH646s6UGBdzlFHMWsw7o9J/Ntg6xfe3Xmz067t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b860d6-253e-4599-ff39-08da8b377421
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:59:11.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cSOJ+5XzX4Nx7tbAKAsTm72Z9f5YwZ1v1LyWq57/3Plc8aCo6cnpmWkyGEU7KuYR2ZjYpC7sh/prLL0Pi2qng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

LPSPI transfer max speed is half of the root clock.
Increase the root clock speed to support faster data transmission.

And update the parent clock of all i2c/spi with IMX8ULP_CLK_FROSC_DIV2
which could produce accurate clock for i2c/spi usage.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 54ccf31896b7..6eeeacb2f931 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -226,7 +226,7 @@ lpi2c4: i2c@29370000 {
 					 <&pcc3 IMX8ULP_CLK_LPI2C4>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -239,7 +239,7 @@ lpi2c5: i2c@29380000 {
 					 <&pcc3 IMX8ULP_CLK_LPI2C5>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -272,8 +272,8 @@ lpspi4: spi@293b0000 {
 					 <&pcc3 IMX8ULP_CLK_LPSPI4>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
-				assigned-clock-rates = <16000000>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
+				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
 
@@ -287,8 +287,8 @@ lpspi5: spi@293c0000 {
 					 <&pcc3 IMX8ULP_CLK_LPSPI5>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
-				assigned-clock-rates = <16000000>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
+				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
 		};
@@ -315,7 +315,7 @@ lpi2c6: i2c@29840000 {
 					 <&pcc4 IMX8ULP_CLK_LPI2C6>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
@@ -328,7 +328,7 @@ lpi2c7: i2c@29850000 {
 					 <&pcc4 IMX8ULP_CLK_LPI2C7>;
 				clock-names = "per", "ipg";
 				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
 				assigned-clock-rates = <48000000>;
 				status = "disabled";
 			};
-- 
2.37.1

