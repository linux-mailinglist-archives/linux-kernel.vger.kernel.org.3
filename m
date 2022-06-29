Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B95560688
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiF2QrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiF2Qqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:46:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE23E0C1;
        Wed, 29 Jun 2022 09:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0salAeY9CB6u5UqKE40avueIMkhpFC5cLXqsD6ILj9Q9zLEXWsH7yzPj4HqwVs8pXdnxztsp6/Xz2kJlp/244DuAd7YryOdtaYOQamMb056wr1HC23OJXwvaE+QqNuXqqRo/dnHJ5UE9uJEg6owj56ivFfQ44U7SaDwweTz+QXQX1Odn8YRd62rA1ua6RHu/xxMFeu+34i/8KfBo0BZkqPdXGM9gQd/uFvO/PhzhWsw7vJCtNmjw56CBDTjUnm9RT8YHZGkCX3dEsVr7SjjC/4zc9f9++egNgr0sJQUw//AkpNrGmjeqLkg+WrcpN6sGYPuDCiq3rJrqR4s062cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=KHegec7QmP8uiGbzmouWcz/A13EKIbfV56nNhkrMXpgZCSJ4JsCFMq6PQ7qhMyD2ZfPG4NrHXbE7eKW6I6iZELNx0+ojs81pf7GdClxNeZe7/azehB6tHL0VbgZvyjKOWJ6aT/99yZYizMUJTpjExgQHpO3laLfJ/VX79hXGIwQhdquf5Xj14V/YDEvqD6t16UDgcW6Mpai9Lq2OJa2/6lqBywTgoLy0bCSYh916K8DFwwm0Nv67PTH5sHDUbqwdf6fX3YBchaDLWciXQQ9wJnctqU5YKRgAc9cHkkrKUrUNAUH/bJ+OQ6iIWr/Ntzq2YOCSb9dxhTkXUbBuFebqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=aJ/9cVQeQFLIf/x8JAgjlrPy2h6MN3DVnY6EENbPsMm0PlHJ2fjDMW7g222CdhTaq6tuAbIxUSIwkEynrEqtsA75mTi2knuu0Ki8S0D9dYZZgGKUXM3b0OzP6hwr+LMr1BZGaOmCSan76gzfbcZIbooEGe3CKd5dECGB+iyzlis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:31 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:31 +0000
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 12/14] arm64: dts: freescale: imx8qxp: Add fallback compatible for clock controller
Date:   Wed, 29 Jun 2022 19:44:12 +0300
Message-Id: <20220629164414.301813-13-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24d16f8-3f47-44fc-6b60-08da59eec78f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCUYU6WKvdVXgNAzX3NYLv1p5AqI3wgWtp8AZCEqSTzjYy7OVQexEbcZiinvWat4cSIglJ9mr8lw2xCSZF5JmI8HIbJPQDAWApuic1JSRTVLkr3j8B8k435IrCsCXps1Pe6E/guDgoTYBcyraqK79B7njWoWpfG9PMj4zqGRyNDeE9z9EuVUKST5XkzIGZ9wHFTA9FcxBcLeFdo3kFgRlXGWvwgGgfpYQo+WDv+RSBY6PyGFxXaM9r0n1RHopIUtmdI+JA9AVNGezABGYlPiujxGd9r1U+ur8fTkMHNmk1zYmOcCRmUgvZg2oDUv9CPb8l2U8waujAK80oVsM7Ahu+bGH388piQ3HufcJqIVXqhEcBplgy6aZs3eZ8lQk/7KIGHinRCEefa1586JK/kVmHysUZjOSYx2cfZuFc21WmD0ug+lNzllQyC5Ylr6FeB57wxid9VhGUIozADhyEXikXt3iVd+PG1tgfR6UWHr+nZ7xbBINQ8uLSGWY+MPTszQpvXhVzrrlfZ6Fh94qdvfZSl+lCE23p8MlUoJsA6RmnPXNAMHeF3/p+2Jrmx1mVAeYkCP6nu/ilcnYrJxLFUtfXqE2+AxbS7cqFY2DJXZN5kv3gFJF6ibEX9wFahhXsY002uRNGM4fk8deUXxWbX6ojeRK3SCL1zgv1tlZuPXYfPjPtZt9ANx8EgxzK2ctaM8xtU+jf5RIId9GnIxXaJmuBnLJxJfQmimqwIQq+WdWea//g0T0VXHfhHTwxvQvYnCNLQLtD4O7RuHsRdUN1FUTQptqQAbJmqvhSE1SAMkSio+sj1duRS8jmUZspvNQmWNGj2vBPU4u0RHMQyN5GnvLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(4744005)(1076003)(38100700002)(7406005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UC6D+nME1+dH3VToPuYT9nnYQ594HQ2dUJD+xqINl1qgn5tFZNuallSQGF?=
 =?iso-8859-1?Q?tPKUzDNDTRW7r78e3KcKJE1V/MY8aIKbpbYpPNa4POId4qskeS/SRMIJmM?=
 =?iso-8859-1?Q?Zms0RVTvWJ6+7zEPA5HonI2UdnLGgZqghC8uZ7iSbOCWr5c7s3wmXwgehN?=
 =?iso-8859-1?Q?J6HLtYWqnV5wxbXH8byV83wtN1EZz9IpgLzIrjTJcl3CyInO8Y6+PVu5vX?=
 =?iso-8859-1?Q?QDqKTP8brgMbeSF8jGWxDWYgQcD5j+HGy2wsMG4iVpbndd6m8WZpFHcUOU?=
 =?iso-8859-1?Q?NLNQSB1n/O7zY8zxxA9kbW7A7l9W7hAiV0rzcP20WT/4fHU7zXfkpRn4Yu?=
 =?iso-8859-1?Q?pspT4vaozHWQxPFIlVM+tzRm4wyAluVRQmXrJ8jDK0OAd06TTm0Hu04ias?=
 =?iso-8859-1?Q?akkZmc2bJRTO4xZIK4HR7+FoKRcmcxiKt+BdLWbPnSDkY6Rr5ETTFV5YhR?=
 =?iso-8859-1?Q?h2vLFQ8Y4/SazNOdx7ZRPhzrQhKKahT+WKb0YvyPt95jFXNyEV2qPkFm2z?=
 =?iso-8859-1?Q?OFbg3WhQe71844dvK8fG+fuxPfA0eSDQ7agCAS/bynPQHhcz15IzXTCqR3?=
 =?iso-8859-1?Q?iROBqmsgdzNjetAvO0lsNXCupD/ruJG6Yl7dqGKM4V8y4QKJyTL6Lu/XJV?=
 =?iso-8859-1?Q?rwYPl8h8H3jQ5dSfT5ShMS25RozSTEuXJZvMoDywuoG3Zhaf4Xo4zsiV6n?=
 =?iso-8859-1?Q?q4ihEQi7QMOkNk/gldjv/w0pi/PjQw0AD5HeIOcsmHXW6eKsk4/uo7+9+Z?=
 =?iso-8859-1?Q?SBbjuzpy1gayyONtMxF8WhmS4/XvtuQj+8z4NCilebcnbmBVg8lPKjzPVj?=
 =?iso-8859-1?Q?LNoK9NMsa/EQy27EdLstdtRjGV+ChoXkB3ZKyTI9KXN+Ug+s38T+60Uost?=
 =?iso-8859-1?Q?oPTC0zVhGiJgD3IlJwrPH6sfdV/D/buFdK4jOTISSHkBWT7YKRNky+ZUkK?=
 =?iso-8859-1?Q?kSnN9WLA+7A02FNRhBkpudGNahfnh46vruSmKQBp7n9b5POgDGZPNAGFna?=
 =?iso-8859-1?Q?R8EPYnnryIt3euJZ1QAI0b6U3mVEamToaXCad3KNGpAHiH8LKZ0rJkaf4a?=
 =?iso-8859-1?Q?FECKPXHYik0U6zY3VPDCCGVpe3cz1TYf8wP0RfLovXcxH5XNzOwgLJvwOt?=
 =?iso-8859-1?Q?dc5SdBz6iwM6PZBIMlZZRWDUmut88g7xP6mJfO0rQHUhKh6WIEgwAcjBCV?=
 =?iso-8859-1?Q?olvSkID/Kcnrw0RPrgjOME4I5p7sd6JVZ9v8gVW4NJb11oYHh6KsTU0/wz?=
 =?iso-8859-1?Q?xvkmOtUfn/iW2/JihLqHKA+PjKQr0WMGBLkpxi+pbHgLwtnbIHe3KywTHt?=
 =?iso-8859-1?Q?BlMQi2m1zopHJgy3xqyXsqXSK3zttJMB3/opPlQNljbYb4wp2KdTCYP8nI?=
 =?iso-8859-1?Q?HuHD9Qco8dO+NWjip6nWJewqPd10Kl0EWmi7UBo/QA48laiQ1MoikzpoeZ?=
 =?iso-8859-1?Q?hlf4dv/MdVSou/q8RGryBWY47wWmXX6wb24s+cAVY8vEr8TgTJUJX06B6N?=
 =?iso-8859-1?Q?EJ1KqU//scfsLPgv7xznfyZtZpVsbanzzkx11yhxis/O6elpPiF4e9RdnC?=
 =?iso-8859-1?Q?iQ6oRKF8MACrg/115Xicj3R+YCFaxkXqMY66phQojnFBh7OinSLMWiZjxu?=
 =?iso-8859-1?Q?7FqR6axIlqvy/zRj9ficGD7ECet62W3X6C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24d16f8-3f47-44fc-6b60-08da59eec78f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:31.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jks24hGWAtjbWArZah9LKbgxYj1eSTmQJr6mx9XWDKbNJn2JdDteXyZjoIDYuZfGx+by5ZGj/yWmeifg5Jd63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

Both i.MX8QM and i.MX8DXL use the fallback fsl,scu-clk compatible.
They rely on the same driver generic part as the i.MX8QXP, so
lets add it to i.MX8QXP too, for consitency.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4f8cd7339112..d0f56e4dee77 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -216,7 +216,7 @@ pd: power-controller {
 		};
 
 		clk: clock-controller {
-			compatible = "fsl,imx8qxp-clk";
+			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
 			#clock-cells = <2>;
 		};
 
-- 
2.25.1

