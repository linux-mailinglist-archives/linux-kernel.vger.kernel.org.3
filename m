Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE59F5ACA40
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiIEF7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiIEF6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9523337A;
        Sun,  4 Sep 2022 22:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hebj6jqJgm9qsJ009yEXxkfVD5Vqa14jJAaAhBggEnHACZZLfKl59yJcowJelkYlwaJ3Ii7SEJKwBVdjPBsA54HYodlS73/POI6ih9z5u//9NZE4bUnTdvccbyj90/VvnTsVTwKToKp8CDORLPlLed1xAaGAXl82hRnLQwkJ3nSDQxhZS8JoLVVfg98S17aeT/9oKjM8tlWVr6swULFwNlHrBt3LZjkTKiigfuuEgl3J0BCNORTM/5Axmk3NGkstXph5BUuHWtKT/DVBCcgMLZal37NPVZfxB86VF3o8I66CRfEd5uWRL7jYph4k8kGzW6DAqyEiUTbHh9DRQf2jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=iziG1Nh+lMSuXa4faat14w2+bmYUl2yuISiJIn0BZ4KKbzAMAczsrxyN3rSCGh140dSMpk9LpvwEnQ6V698IATAGIRmI8EBTq1uB43j8bai0LpFF55uSVV81ugrAegMKYklvaufDX14g13VtMopMTxJrDDYDs0aeEWlmREb8DUxJFQi/FqEPRZuZeFJ6uciZFJLGQz/2hWSewl3eePpu3Y5po09r85U5zm8Yx1bGJ+PEW5nSQ2YWl0PmIxFuk1sTRWSKT+gvVAlPx29f5bW/bP+0NBXcZWzMQVL0hZGMsQO6Y2xSyJq07W4qANK8KWbnKL+t9+27sgrVoyfOPPrLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=g5erMHRlS0BCS+k5j+kZFhykITUh1AkA82315ZQy4R6xn1MGaOkQ8xYcsyhOsrUfo+mjwq+6URxiQvJl6xudas1lNEF8O7imONUKFIlFF9bb/ClZFGJj4UH0KQZq5E66gHWK/u6sUXUoQ5LDQ3S4VmgQqkTwVr8vkyrtCPqsjVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:57:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:57:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V4 3/8] arm64: dts: imx93: add gpio clk
Date:   Mon,  5 Sep 2022 13:59:10 +0800
Message-Id: <20220905055915.3878000-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 071c1f20-74e4-49b0-1a55-08da8f0392ab
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0+jPAFdLamByBLlLpefiPyo8kyMzM1EQ3yusRCAj/SalvBN0uuC+sE1X3PfKnsv9R5xSM1ftzg5tt8KxTfqLnd6BL+wLZZLcC/RCDQyKm0w5UZzufO7gJYiEm5jJ3p0YrOt57X2T+dNBzzmKOAu8aHWWu3iW5jHAViRKUB2Xht7HLDdFRdzT3ZfU1B5z9EiND1cNhc75f8on8kc1rP/vYtpnNHbNJiHGtSVATfNgDHAncV2z7C+2oqCk/ewFcnj2qXNaBlJ/6bgqFfnIPLgNnURfCTi5CqcyTvmjplOBzYcnnSveRN2PEnH65qMwUMc5A+syJEwfDqD1LKCyfMPxg7vjqbJewGU4WUmj2UHMzyQA7QO4S9UvGNfChPXMPtWC4+q1FQCKNBeyqxvdnkmWhZ1eL08AshWqAnUbxAom9Ks1T4cEjW2NnM9EUNSyIz3aMTetDUcE69gFbT9B25NlB7XwAmbJwj54ew3dAlX7Hkhh+nA9D+cnHTwmN8nN6Oz/YVZ9/NL23HiF42Q+vlFMfzNeRBUtiuLDKEbTd7jcmNHLYlrnNWPzLoJcLfoB2s/hrlXx6/c+4VutVgu3G6NY8hyJaJ5dScecIpXtCdVVId13/EYhHV8Rhugwwy4R4f3Gvmazm5/qdQV1QsC1d5KGsPXzRTQgBPUo6quiTTKhUBCT67Oh0iWeZEAXilw4ZV8na960kuOmHzIEX4yIWuh52iPy1YyphwK/wrXZCjRTqdB9VM6TyXi/GpKKaUrHLcuUejFEGWJ7ckeIa12wT/EbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(54906003)(478600001)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xuYYk25yUOEKhFDDg42TZA4Qgyb8WjRJU1VCYPRpOXoThLDPcoKa4mKMRTk?=
 =?us-ascii?Q?J6NuH6mi3O7rquJaZ6diXgQhYg5CdsveHYoUa4DG/cqZw+aJIEB4glFckm4I?=
 =?us-ascii?Q?qMkwvceC07pbZ5BYH2RPMvAaLsR0uS/Gsg6t+bJsosTdrDUmtUyZpt0pGN7P?=
 =?us-ascii?Q?A1z8IWRO9o26N8zSto8xTwGQ8ycnWID86z+t7pqbT0gOmWtNVYFn+p/je/rl?=
 =?us-ascii?Q?bCxQupEgbxGdzRRFgQzyBkPGZD6nYp6Aig4fuAkYUr9xlNezZSjJ0+Y6V1DH?=
 =?us-ascii?Q?ZN8xvsZfTT3LtSrFeZTD7znj+FmGo90Ya63MKNguah0F0Ql21bzQ807rctqG?=
 =?us-ascii?Q?6WFMW6syCRk5+OrxFNv2xJcObz5rKl/lDvTckivgyS3nAnsBCGMgni4Immzp?=
 =?us-ascii?Q?f6PRc1KfXSNV71L/WfUScmWl1hh/9UEX6W76XVPDF087s92HgyobaHa6Jl02?=
 =?us-ascii?Q?tr7ZytjuR7YE/CYPWi9/OZe4O+brIMAXcZAW14rm+ZJjDNOa1t8kpRqqO4aP?=
 =?us-ascii?Q?4efqTv+lIKmRWuz9XNfD8dsSSlpugHDK1LM5iwjj8UYNMBseC/kuRaRLvTM0?=
 =?us-ascii?Q?mXidr0/opTjjGPWHlhhbZoNqWtPDXMKHzOR0iVwPeXzBKzC323dpcxnsbot0?=
 =?us-ascii?Q?TyBtAlYaILbtVhdw4E7NSA3r6e+1dsZUdIw01DW1Vcy3GTvmOOScoPSIW/OU?=
 =?us-ascii?Q?vGAMgT684S/fzEdXNCj6jucY9dhIJVfHMbqIvt/oFHu2WsB9yBBAg13zhDCE?=
 =?us-ascii?Q?ucVthFb3Q40dgbpVv8bQ2C54YnKW26OBKljrinFjX5trYCuFmv/AzoT1XA0k?=
 =?us-ascii?Q?U123lGjSaAmhGOfypHzGhiqGCIJi5fGo/+787degD20nJfch0We/XOswdsv7?=
 =?us-ascii?Q?aMf5XfFpXJE1AdX54DvO/RYIsF5r5m/TyQgdfHnVoL3GAqCRlHt1MIUnSQsx?=
 =?us-ascii?Q?T4/t6OwpZ957Ai0GqC9MBwli4hLl7l9blhB/KbShZjdJIRiWRTCYK55i6m5s?=
 =?us-ascii?Q?scVlKXgY3z2x2Bh2H4WWaM1cTW5OuSzxQJq9deggJbTwLEht6Hhu4PEfjzHt?=
 =?us-ascii?Q?me5jotT3V+TJv6loqqPRAaBrOkGDw57udBYFC+IIZWvl2UR7xobXEYaQP1OB?=
 =?us-ascii?Q?Hyu/jt+OhmmFgvr1f9EZsDg8FcMf4ETMx95/rP2XYz3b6K5xlOp1KTBG6rCp?=
 =?us-ascii?Q?2oZC98w9mKSf1vkvJxNdbTCnzWA2PFAvmoZ3bn4nKfOChHIFGmq7L9/s2wDb?=
 =?us-ascii?Q?ZCW4W/bODVRUelCv073UFtM46om6tl9mj5Dt/wWsEnd5Ob5l6MKgK2PUXh4u?=
 =?us-ascii?Q?qm/OYBnyMFYIl89zEa4+n9S5xzT74ZXNSxij8Z9b4U7k5U2/sBbZiCAjRllv?=
 =?us-ascii?Q?G6I6aAQqaXXTiIhoTsYDzryNLsIm65eEwzTq6Hmib9SZdTiPcutGb9pGTEfy?=
 =?us-ascii?Q?TRGhslcnfcdaiXksS+QFf0PP9TU7BKIanBQMNgqI/JWcUKAoUmluyRXFi0hV?=
 =?us-ascii?Q?9M7kqFzEgTOKczpvZycqN3S7uD2a++IJkxM/FHJ+UGu0Dw8AlsnZ9ZffIYwd?=
 =?us-ascii?Q?OXXR7jPGseboek1Qu61R07fd2Udmn1HkWc0mqskk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c1f20-74e4-49b0-1a55-08da8f0392ab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:57:53.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyiHPDh17fse2Cf2zyoie4hh0vn3/70w4rraNnC9hW18jhw1rAgNx+kbCJgrIICdmLDYqi8/zuSp1n/FM3v08g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the GPIO clk, otherwise GPIO may not work if clk driver disable the
GPIO clk during kernel boot.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 431dc239631d..26d5ce4a5f2c 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -295,6 +295,9 @@ gpio2: gpio@43810080 {
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
+				 <&clk IMX93_CLK_GPIO2_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 32 32>;
 		};
 
@@ -306,6 +309,9 @@ gpio3: gpio@43820080 {
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
+				 <&clk IMX93_CLK_GPIO3_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 64 32>;
 		};
 
@@ -317,6 +323,9 @@ gpio4: gpio@43830080 {
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
+				 <&clk IMX93_CLK_GPIO4_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 96 32>;
 		};
 
@@ -328,6 +337,9 @@ gpio1: gpio@47400080 {
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
+				 <&clk IMX93_CLK_GPIO1_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
 	};
-- 
2.37.1

