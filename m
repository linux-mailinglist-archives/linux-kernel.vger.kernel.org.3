Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056E7565B39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiGDQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiGDQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:17:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364121261F;
        Mon,  4 Jul 2022 09:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drg8jeYxZB+ZDqGKyx+tvOjY+Xt6gQNBKLxU1Cy5CKRlE2qJuJTmLx6Rfgq7FfwUVHaSxLShvVK+Q0B93Muh5lDvhpGOORFEA4/Oy2oAIUgNVGwNRNahprQPzh9wqqwPGY/ZJxjuYgYC942hW1liDjNaR3WRzLWn7GA4Ai4jmHyx+jXuCfJGlTDEQHSw/SrESWojtnpUu3khXViZKk8cSB26tPW0yOrq45RzCUMCT4m/R3Gk25oJDgkmNZKQfx8JK9jvlZ/73+gWkmA4gW1grg3nR20JFD8YPnpZ0kF29fT8DlhA7lFxgp8r9n7FK9xa9M2KkGzQPxx0eKB5Dc0s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z975GfFeLaXwZjVEq1de9w2k7fbWofhdKzN2yvGNXGk=;
 b=AI0ZgU0BTD2IEQUj8tLht5N7m9qbfJQq8BMs2ZCZahMsrirzBQ7Ty3maws30f8pBX4/JdN236c1um0KqTDcBDb32IcCVYVvHovYoW3y1/KDxnon29IYwp69T2Kuz1KXWMeHiT9x+H2vgyZigPweM4EWYx2svrdGcDWLprd7rTJKU+oC8oFwWCXo2SSgeCfDBPh16rms7q1gaBaHg+Ys9wn6BNRSfTBdNV+/AOw1+w0GZ6xERK7yiWumjypPDzGyGiKBk/87GsXnRDVFqElKuAfj0lvRmtkgQLgLtDUEWdBugE1Y/d/z7MCgRfKQTIlUsCK5tGYbxH2zJciZHtAf1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z975GfFeLaXwZjVEq1de9w2k7fbWofhdKzN2yvGNXGk=;
 b=DE8+yRpurM3ZjCb9u8PxpB0L1pBesmf+PvqI2nNOWOqowhuVuKkh4v1VzS2N0Gx2xEUrCorq/BuELMwOXjUeECi+z9ZEBIQ5wWKly+tAUwuq+X7eXgAPcLYWo8CMoTRxB1VLTDoVgwqMaqiCGdNJ77weE9E85Uqfqkp3Ruf5PKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:50 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:50 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v7 10/15] arm64: dts: freescale: imx8qxp: Remove unnecessary clock related entries
Date:   Mon,  4 Jul 2022 19:15:36 +0300
Message-Id: <20220704161541.943696-11-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c15670d8-b2e9-4fa8-d7e4-08da5dd89995
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsH/dUwM9JDyB1bUJfXl6UpUa2WqYxTh1j2EGjJC2P1BE2Mek54UPEQnJVTeMVtrC9+RrXzzax5OnXrH9KcCGlc4TD26rftSlkQXpHJhUsiG7fD5KnPUwZPE/ZsZ6ohWPjzGw6FaCeQK7k6aNBhGx5l3sIFyTFP1Oywj1xIDFJp0yk8I+l2OdHB9SsikyUOOG9DhMfin+VEsNOnBci0Q1gTHfwrZ7n2ED0Ukeh6kcAgOnnHprI3mjmd8Z5TCuirsj1Dt0+WMKCN3ksapw9B6WjIp1BNcKuVq+29VN1kPM9r/p3c10YlObq7zycm9VyZ+6t1ViZ0QSelWmDPgFmUzekNcfieki/1JIUg21zzl/XcHReoU0EDKrb5MGdMEjkOxh/A+KnvbqXZKBOKAvEjAqpnFVsnxGLdCYTBos8CbsjuIaWjaDKPUZci452ipp255oqPTZXhn4DXQBuHW24fcwYbtBC7R5N1sO4bKJwT74/5A8Z69vorzpNR/oY7x/lSzbyktd/agHeyL9kv2a+Hah1bjr0vGjjCICc03MrDC2jy519/zCux5TaTiJWwQBxQPQ9/NJpYsTjEqejOxT8oj6KfIfJHTWkI5ktTE5MhWALrDdtZNOGo5GJNBVWe3IFdM06cR3MYSa8J/zQ/xJrUgna+MQZoelPq7h4+aCMBerm9wnsg/dbWbJU4pzQzcEwa1trHsWynLqfrRq46EmWs+Xdyc2nCNI9rL4AjKqq7cFyBwADGOTI87R3TqLSHP3829OobIrikfGq2ZmodmXCsaAE8twwaN6LNLgCu/GiLRX7AYVATXKnEW7CKAiIOUDHiXza5Jf6b0TFKtdpZD4zoRVLFXK0hKABD/2hrb2ZoGUcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(4744005)(66556008)(7416002)(7406005)(66946007)(8936002)(66476007)(6486002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CiUbClxLwge5Z1UpvZ40P8ZZeSudStnOazrCxjn2xFWBZ0lWK3Il1w0mW8?=
 =?iso-8859-1?Q?poj6ESttKtlPtym+PCBE31hyYVPiAYP8DpiGo6w6mFXKNa2fX9+IceVymX?=
 =?iso-8859-1?Q?k8Vt8ZHhqNgu1E8yk94SmvxRKq3U3s1mf+qvX5F/TYPyWratqsRuy/dwIf?=
 =?iso-8859-1?Q?jy/6ZRIjKeKO0xpN7nvSqVKq4yWEej/9WpUdDJQmsqB/tV/X+hqQza0KpI?=
 =?iso-8859-1?Q?HzSmvBg0fXo7/nl5WYTMVp2M/Esy0h7JLseKgOXPZOHskzGhl1o67bpoU4?=
 =?iso-8859-1?Q?Lwhtt4w3MbHd/xFzfcmco0Y0tuVLr53QB3GV4M/hVY2uk4S/fPkAXX30lx?=
 =?iso-8859-1?Q?gXYID7RH9PSDHqm8JJAaXplm3P4Vl2v/1k11fPA8pB1H8tPvuu2wle6+pJ?=
 =?iso-8859-1?Q?bwype+8uEvR7SFWNytkqK2iSAARYBnCVZTqkoWClu+6gFNIdAQQJSHOexD?=
 =?iso-8859-1?Q?unlYtNIWgqKHnL46WaD10cIHxjwxCH2ItRkIZ2P064IV0D6oZ8s9fc92CY?=
 =?iso-8859-1?Q?o9DOxr4BAfqR1gWy5bCwRGhme0g2G7YkW5Mv0z2kSVJsLlTQFx4waG7coZ?=
 =?iso-8859-1?Q?nihZJxFvl/t18t27lYY3XBDsRE7c//36Q3uJO81M0hgllEaMJHcJ+As7D2?=
 =?iso-8859-1?Q?P6ZHgBXk4vOHCipJoQkD8sH6DiuZYANIVMJ/BkpOprOTQslz3eRewNpN8u?=
 =?iso-8859-1?Q?VmpSF0V+XmtGITplBu4I/KlHCPEjj1Rq+Q4u1XgmQKtNkbTWOYg/LHAGrs?=
 =?iso-8859-1?Q?zzqgQQmxsPsS29pMzOIbyf8W8fbtqtDw5qbtz64z21y2iGoObHwh8K09Zz?=
 =?iso-8859-1?Q?OSdHO5Zzyp90VrJpcZ6Tply5v04zcGRSmButjq+9/8GJWLAPEr+XuZb+1h?=
 =?iso-8859-1?Q?9noQYOMvz+jFwoYlSZ/bXAWTndLVKkRRWbiAFJgq2UPyT3ROCSNmW/BBgf?=
 =?iso-8859-1?Q?CIXoBMtNgAlhON145Swd0/a2JpWKJJqYBvw/xRGy9wp4vqhGe4gZDNVc/B?=
 =?iso-8859-1?Q?/YZO8T5zZequ5PgiiTDhE8tnYlO/gUwXWGnR2/zGlsyHMu3PXFURWrX9zP?=
 =?iso-8859-1?Q?wCY/gqda1VNdiHU99T5ZKBuzAF78WxQ4M+Ye+vaBWDF4LpxPDaw7sy0dTC?=
 =?iso-8859-1?Q?BV31qdxzMdRfygKnEIgQHSGV7Au0WzBQYDpckTmAX8CkVaOBSUqu08N1v1?=
 =?iso-8859-1?Q?fqEgoXtOJMZaBMmxblqlrJPRS4M5odmdbbegA3VYA3/4SIp2z9h1/DAPBn?=
 =?iso-8859-1?Q?3l5ML5pg+k9B60mNmk3YVUJ98CdF7QKgOHy6CVY9B1hCwzr2Ca36z3Nu8+?=
 =?iso-8859-1?Q?hNBCMVK9nx5jQP8vtmmGS6/GDsVKtUHYNcn17u4tVuCEjnV3mTJSATfslq?=
 =?iso-8859-1?Q?c6Csy8FT18MtcCzVMjNwHw/CXFKzvs/qcUUYFk+NJfrCDDAkN6F85Rbbjj?=
 =?iso-8859-1?Q?8kK3W09DdOqdohJtBgckLts2RyRfzfNniX2fPOz6jaqu9bByByUuWHY5qh?=
 =?iso-8859-1?Q?ldhr/9Nq8x3wJxnDev5WrvBSBoOLG14GK4O5l8AZGw8gYMH/tqwju8lYyT?=
 =?iso-8859-1?Q?syXiEpn3Jzk1Bx7AQ9ocVQt6ZsDjGV+cys/tUPwtAAmzaKQK4Ym3aFRw22?=
 =?iso-8859-1?Q?CTKCyktdp0QLw+FgqtJcfqwaAxY/XBH94B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15670d8-b2e9-4fa8-d7e4-08da5dd89995
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:49.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCRoKCtd4DVDGq15fAt0OPXMYsaHqa+XrLAiDya01ESBaGOOmG5p5IdnzHpZZKihjizzvd1L1tZWbVCV7Dd8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

XTAL clocks are not exposed by SCU to OS via OS<->SCU communication protocol,
so remove unnecessary entries.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 483996a1f2d5..878c2aa663f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -218,8 +218,6 @@ pd: imx8qx-pd {
 		clk: clock-controller {
 			compatible = "fsl,imx8qxp-clk";
 			#clock-cells = <2>;
-			clocks = <&xtal32k &xtal24m>;
-			clock-names = "xtal_32KHz", "xtal_24Mhz";
 		};
 
 		iomuxc: pinctrl {
-- 
2.25.1

