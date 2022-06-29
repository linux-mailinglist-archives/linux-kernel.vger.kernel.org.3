Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326E6560679
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiF2Qqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiF2Qpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D87D3D4BA;
        Wed, 29 Jun 2022 09:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9dVr8OyPLYeIkelkeVGyHgiRbEbrxtPQA9km8EVkbuJnMRDpPgiabB0eTfoaKKrnDT4ZGEB1p8PcAcXtyet1g7VglcTAvWA91NLO8cKe8Vt+zgq7j7QMLFmcdOiZXetu+niy2YlvJnFbTJkLMrEnDf6z9IeXO9zl3X6xEYwoMBQdMY+ZMxTnpx7vYhKQ900kxdYegZUPt0+YLJAl3FlM7ARsWZ7KedDH35oAeMpfK1Q7K5ERXIEzPs3ulSLGrQkdSL59vFgeS8Kw1jrlpNVyy1rIxCwr2x1GN2Z587apZl8nODvS1QBUxpommfwy0hf7oiQQ5dobyucn5b1i6ieKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELyxV3xh4ZMJ+yrYxyaap+GeJfDsgkYb3oRnCqy4DtY=;
 b=VRPQt09xRx1wu43SYM5qUscXZPpjBC1LSVGmEMu8H0cOvpo2WrFvYGk8m6M8sWjWquI8ofpM/PbXOi6aj8JMoTnOd+EDSm0gr6ueiE2JUupOmUFewNR0F9UB7iA17Yc1e5RrBYNODzDWCHBreAZA/TNJ3XmWe25CdbI7nzi0v3BHhagtgZ1oAtSVFctC1WGT9diKbnWiriFB1QkzjI3EPFh2jVtlF7lVKKof9/OLSFnMvU7kwpeGZZmI2Ex7OsBAKdwR2+1APKyArCWP9GCqBEzosxQPLl04N9VaI4BxWbwsxY96KgTuSxbmMIJVv9fvTL3+FWhjSFgEnGCHb48UnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELyxV3xh4ZMJ+yrYxyaap+GeJfDsgkYb3oRnCqy4DtY=;
 b=DDnUPwYzBfrm+Ped0k38W9bZeSkqsImDBF1+1e/6ctFLu6hrU+419x70O60c4W8aRpjDy5Ddo2PpSUqbDJJi90qp/2PDcCQcIfOXuAlNqjiInNWqHr+jwIAn4xqzpKie0r+EwMGxF0Fwbxp1o9j6qTvdWwSgWSWprD5w16BxZ3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:25 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:25 +0000
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
Subject: [PATCH v6 10/14] arm64: dts: freescale: imx8qxp: Remove unnecessary clock related entries
Date:   Wed, 29 Jun 2022 19:44:10 +0300
Message-Id: <20220629164414.301813-11-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0cfc4c51-8ecd-4090-8f00-08da59eec437
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TN0USpCV/jd/x4bXx+wnwmj8gO0lRTj1/w9DSD4Pz4QxUJkA0M7Ky7V5G5PazBdqv7ufpfXOv1rpmx3HeY4EdqGE1c6QoqNje6vrRZeLvEIjc5/yLMNryVmthpDIGvGl8p3mdKYPNjVZdSK9bsqxJmclyvH/9fzMjMYi9YxezS8/JUN3c2rBS1tCY6ZmU8v/fcAO4g56ms7vPYyFn+s9OjB92RhJ+Pici6tCPwGBO9UpT/WCd97dsuRCbUdaISlA9zRhnMmw0npICv4IbEs+TcwvvHWcm+3QKGF8jvOqdhh1HZrE8EWeL9IevmTwhe/iQ+lxErLhIttaSqLu9r2U3WiagCZg7cpJw7tSJQnfuOmBv8S7BjjpBaCzB75tcdDUTUxYPOLkyQrHl2VgXDbO3ZWFbT48VxuW33wqy7vSzomJ1OpHqE6FFip+TGGEhkazfCV1Uo0ClsgLtcm1GGG8eW/9iDCC8aAu0fao7iVafEVbtChtMTww7qpSemCm4y+ShBQhEq5/GegytfD6ce9zATpo9H3B2qSyZZRVKcHq4iEqbWjRjgK0L2g7SLiPzm5JpPZvWeekM8hycQCKtan6+XPVZaREYDuGRB2ZIuBGNeW5pXSlDttxQN2kOS3pdgjveu12544V0x7vl0Qyt1JlmndcS+7rxUfCfBO3uVNguD2HVygLuaxWHztDzZe0MHczsExJb8rbTeEOnFRCqjP+QtNZECFnX1Ar1kIdXM5pv7MKwPCUgkM9490N9z7icQztcxt8///ztuWDdgNM88YbhONNRhNKXW0W5sgeCBau7qwB25gR1EvhtmYplLWLr+ROFPxR3Y342qNDOXkh6U9xeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(4744005)(1076003)(38100700002)(7406005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6NUhY+mFI219yDutmcafBARq6dSb28+AzAeJAa/idzVZWL1crzoSaLcKMw?=
 =?iso-8859-1?Q?f3TC1pPm/3JeRv8a7CDX+0BV7S59EG33RTfp2OleCj+HR/jZK+iCGfYmxK?=
 =?iso-8859-1?Q?cuoAMPvxwujk4i11Nwf8Hul9FTPGcz00kux4GUhn74YW0e/uBwF8YfCyvB?=
 =?iso-8859-1?Q?817EpxJ899P9qsem/m8Ji6alsfv4LeqY31Rr9CYKMOTnc4OPe7JkS0EhaM?=
 =?iso-8859-1?Q?15FGpZFfDxzfzq88TTYB6DAn5nZgnXUFrhT0Pio66vE+lSPMfZ6ffPzzH5?=
 =?iso-8859-1?Q?UXmJ2Qquk6PMyLO/H8dee33D30B79i0p00f3e1GNUe9xTkOpuHzEObe7V/?=
 =?iso-8859-1?Q?mWYD43w+esAibS7BPEPYC4hPnA9VLiqF0pvLAU8JXC0bsai0bNHC6qb+Mm?=
 =?iso-8859-1?Q?l7UECwzsHOpcy5ATkfqjM78pLDaTxqrOq/4wp0qss2v1vxtcjabPSNoXvD?=
 =?iso-8859-1?Q?tBfMips2/taRaY7/MIFYT+p30YQzfu5Ok+WkwKxMC4bNHqwnLjY0xIGQT6?=
 =?iso-8859-1?Q?rB54F/maem6zCirZe6ympE8I2BpPtjTohsGHyLrp0pClMWSAoJ8FGClA2i?=
 =?iso-8859-1?Q?ly5jpvAw9i0gTGKDJppW4AglaOp6heT9yEqAQNGNzo0hfqlbB+89/D9Uyc?=
 =?iso-8859-1?Q?svpV0gSPuBsWr69QGOFP6+ElBkmTXZdM8kjDWohAx6lKPy/rznNGuZorPa?=
 =?iso-8859-1?Q?X7T5n5GERO7xtH1NtTwvr1HTGeDJOyoWSnwWm0QjIp87BTp/Qy0yfG5JLD?=
 =?iso-8859-1?Q?laIP+lNDCTqJFbBBPR1mG4ILmLL5JSTNhzwC/1O3lAvRjKfn0d0hrVVsS2?=
 =?iso-8859-1?Q?wj59GHaVGfvcrDQKb+AFitKSg8w/rrUXxBAFVDyYYKEgb/vyh/j1juZO59?=
 =?iso-8859-1?Q?F4W8Tyb9m8//2sojqujtZitxd1U8B/9R6XHvrdzsUQzUD/zBo17r4pKVy7?=
 =?iso-8859-1?Q?t5sxX5WLHCC3pbtRdes/JdE+IdzzVE9eGRCJKzoPveVl9k3l0v6lY61/CE?=
 =?iso-8859-1?Q?WI4fJF5dMubVQzQ5LiPgVI8dWbBv3ENrKSdg52MMReCxWB29XDTv7wN2Tz?=
 =?iso-8859-1?Q?PCtjvFomqX7B7wYX2UQ+EHTa6oIxVyN7ff8KLTUOTXz7w0TodlTWLbyji5?=
 =?iso-8859-1?Q?N6fKaD+6DI8Qmv5Sw3ZPK1B3rkTbwFl0/KdvVo5r1ScQYmd6pFraC78kE4?=
 =?iso-8859-1?Q?F/glSk57Tth95nY+K15Lt4oNwjXk9kI5Tp/rWpP52E4f1Eabt7XNbZIrl1?=
 =?iso-8859-1?Q?D9WnIyBGMdRuAvKvaglz98SsZtwyQfV4U6wUn5ynee7M2T+l4I/iBAKRsG?=
 =?iso-8859-1?Q?kVJApH3wmMr2i9gBXl+TP52lTJUITbEMO/SQOKjaT5J/usBP/+ll0MDcIe?=
 =?iso-8859-1?Q?Mmc3CVt3oxLlXCaN1BmMtVN5WnK++8BdPECrKXJgILugPz+cJns8ezqZg0?=
 =?iso-8859-1?Q?VVOieiPUqnZyigm4B9sTI5dX6Sb6uVH4mOCIHfRT80mY/5RL/2q+H68LZi?=
 =?iso-8859-1?Q?V84KgrlMU8DflUMKrO4FQftZc0PU/X5c+Hnc8fvASTUtTgO6gWiApGS1BY?=
 =?iso-8859-1?Q?qFkYD8Py3Aad+n47in0VfAIJylJeXgTFslxy9vg0/Wm9w2A/fp/rHK6dFX?=
 =?iso-8859-1?Q?2C5DvVkk8yVgWvCEO4hBgaeObkEmOxdXNr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc4c51-8ecd-4090-8f00-08da59eec437
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:25.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YJPRUFRUFe6rViXrCNmJZMA4qhEYQ0b8wEkWz0OzREmNmknoyqXy9uZz/YtlUpT30dHvxOaWVpjsv5RuMvsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

"clocks" and "clock-names" are not used the driver, so
remove them in order to match the yaml definition.

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

