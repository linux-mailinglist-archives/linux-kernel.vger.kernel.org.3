Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB056A2C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiGGMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiGGMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF72C64B;
        Thu,  7 Jul 2022 05:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuA9/LBw5XVcvToJyILnZM6Eiabsr8yy/SsQhY628dfTESXhIduZ/ls13aHRyQniby4j8maX56TF6cWBjiSq1FlNyBg8UPSQ3Ght6kZxItP6F05R7ggJCyKT7ARGNJp76f0oyVqsqO+lQPpnekRdRwRE0lVFUARsqYzQFkLXiFDjfAwmsRR0cVbe34H3+HRe/+vIXxzInTdfPg/0OqA0xU4qrozi8/fBzyBGe3XquK5n32u20AUWzvGc2W1Q9/VnRun1YAscgebit9T1oKqN8jjNRiYFYzeu1MwL8didscckRLYxKPzZ/Y9XGhmogLArMOU7bMK7HQur7V0+sPKwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=bWVgyG3XKSmTXu0CKRUyJG/Gp6fNL/p+6fSbs379Rt7Hyi/RakidtDKFlgaw5JSGRLuQdVWMr+4F8es45e7bgDo31HQRUbNLR6JDDOAibRxdTpKGnWTjbn/8tl+ZuGsvCz2vGfoXjU0yDc7kiccZomOThud1jkR/xK8v/i4ARzC3i817m6T61cvUNwz885tRC3gD2r5IK1HMT6yEb7VE8RzEZBzWewp1dVaaSOT0z923OeMlrWS1H9PaIIaQtJfXKo5yCZmScL9lrjaTkk5JcYW6g9Fv09ICiQvLfHHNIXz/WZAiB4R/7CclDWuSNN6MBHuDESxth2ht1THhcN9jgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=Z7thCU9pzow+KnoYyjtg3zzKY0AwZ/3QhEak4ioyFumxXQFig1GNxRmfgXA87OIYVq89vDzsCpYdJHIuFERScuJtn8fi8e0H2dVEZzUcUOBqAtKrbrtaQs9RfZJLKUS7RnzzlNmG+tyyd3dixp0P9bFt4uncJjfyc7Pehn2NuIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 12:51:28 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:28 +0000
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
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 12/15] arm64: dts: freescale: imx8qxp: Add fallback compatible for clock controller
Date:   Thu,  7 Jul 2022 15:50:19 +0300
Message-Id: <20220707125022.1156498-13-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2ee1df-1ec4-42e5-89e8-08da601768c1
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtKbfBOpvJLvs0jHy6tvLmFaLvaf7qkgNOvxudDPYTChDo4G2ovuqqbbwVbCSd2urWdk0UCiTDcPuCbqhIRUktvB+xUjDbEBlryUXl2iaaESLya3pfa989aWCQWOMuwYDJDY/pM99ospaQiNyfA5x1ElOaSqzf8cUff15BkgPLhXBebit7ed78n4q6M4UprJolyEcMfVqIUVxojb3WgHdeXg0AXTO6+jBEYogZ8U3Ewzbi+j6l/B4x1LjC84U5UMrA0MStK1f+24c0vHFGB+IeRuFbPzg7RT/osDIX6H9PzpPG3OJ0DRf7KhTulGpC16XwYj6uRjwd8e5PGaHwX3w47XWr73ZT2XiBxRhAqI7+HhtG46O01BaQ+dMRtGSp6KivXxgtTS6g6V7f4CghDAGp6PaBUlE5vfz/G+C6pNzwCzgvrKVAfBmkofWlVdMqoZ/rxFZqtBy1BgmKsdJFEcV8ZiuhWep88Y33jPd80yWjmxNVhx9TqKoJypAEW63SEy8w+2RLJUUkfnzZcolqzsLpAUSyVhyl/3rmV3B6+bDy272SOVnoK59N+I4gNak8JeWeZm2YXIj395aIBJONqHu6h+OlTWgehWAXudWWQATvdWIYr1rqhDWQ7Fl63mTqbD3ufkdS0lGtRYDAt94kdZRD2nviXc2FhcLIGDEXEfbha/ru/8c+jdLcvhpQyndZlCcNU0JzeyHhhVXy901LtZtYfVyvHiPbfXPk5TSYA2LSvXrbljxeUWbsBVQW3pKc9yHqEdNaryg2gUK7RRLu79plc58K5PeK1bjwCvVHCwYpE8eNYDmPG9rhPfddLrV/eZa4rrA/QjBHdk7f+89bO3zlxnWsRx0/jaFEUr3hhxaD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(921005)(5660300002)(7406005)(4744005)(7416002)(8936002)(8676002)(66476007)(66946007)(83380400001)(6512007)(86362001)(316002)(26005)(2616005)(4326008)(186003)(1076003)(38350700002)(6666004)(478600001)(6486002)(38100700002)(52116002)(66556008)(6506007)(110136005)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BK5WdWBLbljTaqkYz6jxExa9FJEw3esJZrAAty2lqVwqAsvljzUsIir4yY?=
 =?iso-8859-1?Q?vVtO3xnRnpG/cvMqCc8+yHRGQRd7hMwKIdJNVBmQ+ko+h7GN3xTy/uJXJa?=
 =?iso-8859-1?Q?qZ7RyJ1jBj13wZ8j1Q9gJ0xZC7n7d2abmaiPXirrdNFQNHC4C9apZSVAXT?=
 =?iso-8859-1?Q?JS++/0NNzhGon6PzJC+nx3GfwCENSQ9Ab65iKCc/9R2Tj6PlEMZHm1SKB2?=
 =?iso-8859-1?Q?GBx+xwWnn4ywTEctgo5JtLgqH64KvyKKCqTQKWy6AE5jI4wc9p/i3e9aL1?=
 =?iso-8859-1?Q?KPSh4TYmoxUKx1nABkHaqTAL7Nn7zLkZioXC8ObugFDpWJhp32QP87IxcM?=
 =?iso-8859-1?Q?e+MmhQjajy1Bdqd/tJMbqpFfE41db4a73bSVtIl2t08II6zYuLvJ8yhJZW?=
 =?iso-8859-1?Q?s4cddGRNFXqgDCTVot+plgsoA/mtBIyHzxn/dy7h7xssjGWAQ1OIBdsGvm?=
 =?iso-8859-1?Q?jIjz1+I5i5JvpR5oFCp1zmTJyQawSQXczOkhTWlf/Fd9zDJ2AE1scfhBci?=
 =?iso-8859-1?Q?c5ZNXvOaGSbgvqUTngIW6BCxgl3oH7OaHB+ehHruKuR/Hp8SKRk0plyEYt?=
 =?iso-8859-1?Q?gZEd78sXsYF+roefD+Fe+oiWoDxS2aekerP2O/3HY3fxqX4Ci/vEvbiHPg?=
 =?iso-8859-1?Q?Su0JH9hnDjPWzmC2plipYR8GkUFjqGIGsV+aNCr7t7Glp/4fgEtmXCoQ4f?=
 =?iso-8859-1?Q?iqPoej7WEWlu+t6MPF3L1rcuKdZMYkMd2vLINYbfMSwhfWDlSSW2+tXE3l?=
 =?iso-8859-1?Q?NA0y0YCUq3a3ULXBn8JpwdxY3nN5PeSNHa93S1+W55ukuyVbMldkdMJYOQ?=
 =?iso-8859-1?Q?dRlC9r8G0NtaF7Ro2t+FG1NyN2/OZvGID7finCG+feDjr0aWcs/qbZ9Fu7?=
 =?iso-8859-1?Q?IX1AH1VVqGthRFf4YlWUgkJUP8F6mnNEzoRottJDOWHEq72bbZixKjWvy1?=
 =?iso-8859-1?Q?ClItMYBvCW6aLvkmR5CErhaYGsv560a6H5Xp0Xk8n0cBBNL/pbLa25RtDK?=
 =?iso-8859-1?Q?dZgvqMDJ1GXJntUiu/1632rxxW2ohMoCJlEqpR6L5+J8WIv+a3MUh7ZjzU?=
 =?iso-8859-1?Q?hwdU2ahlR4Qe/PfcYufpIajswyn/5QPcSOZVQmV4ALwNl360PWeNDvRAxn?=
 =?iso-8859-1?Q?wAle3c3huyi1R1QVltrilVLwsuy5AN4vkt9urlNJ71rI2gXWrNEHy5a/IE?=
 =?iso-8859-1?Q?d0+2J+VbsyPgLuNyr2GvVKnbxVZNS9Ee1rAvsKE3dn4lInbWgo8uq4xFXk?=
 =?iso-8859-1?Q?RJ7DWhJhAdBx5nbgm2aTN2JrACiX7puK+7G2FOE/FTIUhl/aJMxgjN8SiS?=
 =?iso-8859-1?Q?1VD1hzEYthAYHsi/EDXWB0HkNJnNbZfFTAiQeVNjzH4XuWmn2WL0SGgag7?=
 =?iso-8859-1?Q?RnA/o1mpp3lW1gJEnkWTvwdm7SILxt/IQlDotk/HtJOrWVQ/pJklt+1t6s?=
 =?iso-8859-1?Q?kqq8GqxIhhvzaAPIji+qJsn6PvBbdm1uB8IvJ87kWEI210NcuWQb77ikVa?=
 =?iso-8859-1?Q?+A/uYe9qDC3SkEozsbQxwsl7XPMjXcRnX+RRkNrKarn1uG5PJx+thZ4SgI?=
 =?iso-8859-1?Q?jFSLlTxGq9BbMkr28Es1y++vpdAgY02HupY2gBSBFuA3KEABhAwXI1RIi6?=
 =?iso-8859-1?Q?utjlCp2lXRahpS36iaZkI4gFJgq/1m628o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2ee1df-1ec4-42e5-89e8-08da601768c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:28.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twoUF5j7OGlvnQS0WgeZc5ekJ58Ip3Af1p6BYJw/zTmNDy3tW2pS2eM6FffjcKRRG3PaXQu770e1+RA0vHypVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
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

