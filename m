Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71ED5606A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiF2Qr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiF2Qqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:46:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E213EABA;
        Wed, 29 Jun 2022 09:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLHklbNwL9S/1558y7UnUKEf3iDR2iTvsPch8DYndT0x3l9LwofsMHWCcn9gRERGHetkuU1PCZXcbZaS+NHAK8ufEdPrdxF8Brd/1cfzw2REhHd3Q7bb+aibeNXN6aAIHRXWsO5SbHz48bVYEYex6tKGBY5sDXj4rp+duzPoS+1JZchRvlyyBE3BeasgbZECaK88MIzu40PyuByNCnuRHP2qjPB1iQxQqNYRM6uwrP+qrIopGI7Y2unKsYYDjGBOmJRSa9a8f0fy6/gFF55E54iw2apj6fDLRP6iPDxt9sVlbo6nOoNJ7cfkYPbF+rLgvTn8xLRrxRjari9rnG95cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGsQROb/MzF30q6TB5y/X0oOV3xRsVNkq6BK7+U5Y6U=;
 b=BiwgfByWhmqRSLaJpMiGzmuNY3cOVYcWqmBn41N5U6zLwA7ki1TXJhJ9Yxm/TOJR3LH4Y6h+TKlho3jyzIieNHKQBLWeFXCaFOW9GKR9PDl0FC5qntel1NaQLX+SYVDPvyct9ADePVvLwSgDX0aYdzEeJWtYeWi/I9trYP4e5un11f0CSqo9j5Gt88Db5F5RDomZasY3NrzPUFewvAsqc3MP9wo16QUdxqN7ZxFP/usQdvAFbv1TO+Nt85LflqNzWJRD3hCRpC6MUcyjllhP4LGSlwk97poGnRX8WVRnfL7Yh+OXBwFNylrFdhq1gtH9htYi7KXM9JTMrhFWEXMV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGsQROb/MzF30q6TB5y/X0oOV3xRsVNkq6BK7+U5Y6U=;
 b=jsmNQTVeO/xF8yZVGZpwlrhPX4qIZyg1c4uf2b/O4J9D21eQssCG/umK90YyKdYRwud+EmDDCQlgfx0dQmRvb0yhna/d3Zk52422iOaN0ppVJgIdIWcbbYo56+Ws02Wml6uwrOIEq0BusJP5NUC78LKcFGRyxFgReLi9mqx/3nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:34 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:34 +0000
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
Subject: [PATCH v6 13/14] arm64: dts: freescale: imx8qxp: Fix the keys node name
Date:   Wed, 29 Jun 2022 19:44:13 +0300
Message-Id: <20220629164414.301813-14-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46dcd9b6-d9d6-4d45-515b-08da59eec922
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn06JblN3L6yVGPI44ItR7Hvuh0gIMqMeEqn8HRbEcUkJDUrnQFSBKn3z5XsEqc/PKK95+GHaPWt45VdywNvcOvtHOEnsa9aBEpWuNzAThVyv2vOf/zdu2UwVC1bmT4TlEC2KMyJ9YCXAnZtq8r92uXZm1U9I7G7I5KSj0hFl9In629g1G8ke63mZ6XplnO3kwM6HxrSrjcWSNqwneXSqik/nek5kQE27UFH+jCX1L1lCpORlR6HOre6rVwxEJX6j+xQy8FGVrtYtRBRIyW/S90VlYdGUsnJISdlUxA0jZ52J1DnK4TLWcgsnh88afm5DQZnE1bajRjgwLhfuTtz93cUCcOSqPWJ+Uiy/LdFygU+D4FbTxul/CeYRojKnOliTJG4AtjayfgVFevQAbFcZIzb+XyTC/zsEmFg1yPR5LoQK+J1OpvgBKb572lBn5ZjyKhKfnhO71+1y2OUM/q8SPRJaxLiIt42fXjY2kH1v3kDCT1lW6Oi+v0uTOeQJbDPKeBnGE+XvnqD7x6AlgF43uINcHGxE+66F/USt4NUmcUQzrw+II62uVUclXaGrtbMAcD8fTGo0ECFoRlrh/irdat6qFUR2GUPbQuG0Ei900x1UpShnJXq5k65dgZ4UsUQnbnDOXb0EwDFSV4PrQt2BVu/NYSBkFuLQ3Xi9c3ZpNPCqp5qb6WtukJuPF2GVC9R1vqKm2nGzePUpGaETkHW+dtRXnT3lKTmzMG8HqZcifxca1+nvhsW1qp258t3ma2P7qr6MRQxHY5HWuG0GI4oUoS5ZENHlOe2ccs+DF03wayMXakhZfg70WQ3i0z80VHC9ivlIjOL5qSbAlEV0Esdng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(4744005)(1076003)(38100700002)(7406005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?w4iNC5MEhgfGPNWbSPRlZUL02iMdhCFWr8caD7qUF3j1c27JsUMcw5X8h3?=
 =?iso-8859-1?Q?NswQC6MrL2n42sUaewYGIh4jBTnu8pFF3koaW3BQWhnJJMAqdyaa2UUFO/?=
 =?iso-8859-1?Q?AvlkYqz7JWdchjupQ/YNmOVTauWVnGaaKba+o/ice+G48qBTcIPoMdsbmr?=
 =?iso-8859-1?Q?DCB8KLWrr25t+w1wiqPTdH3oNCLU14O8TlM556CGsinAUtfhX4pCvfjR2l?=
 =?iso-8859-1?Q?KqTBKpfKzXnehspaEamET1V2PHVDkWv+z1SdOU5YXkdy5LAFvCS+6pzlAy?=
 =?iso-8859-1?Q?Voeje5BClY9AL8OT0Rja7TEbl3I7axjSbPpYoYRTi7t/LZQ6TIpGNnQWJ1?=
 =?iso-8859-1?Q?F62DVTvyrwSaPnKzQPaPM35x0nKnl4hJuA8OCZro5DrVL0tiZR80uhESsG?=
 =?iso-8859-1?Q?owjfWgWxs5cpkOEZJ0J88ESi143N2Rw4fNqhjQSN3k2pWqgDE4nOr1izzi?=
 =?iso-8859-1?Q?qSo7mNbynvuSeUfkc983H8ozn25qixXRBgXhyPfv/qLSOEkcS82piho8H1?=
 =?iso-8859-1?Q?76OtaYr0bnQIvVIhjZxRSUe+bj32b+jVL5alsjRwLFgDW50V9fBQPFtdLQ?=
 =?iso-8859-1?Q?g+G0cJ75ub0kiHsMlHkfIvL1xVJ7CzMJ5muTiCLE4/zZoNZHwI7qJLu5Vr?=
 =?iso-8859-1?Q?xxmvM8m/KRGTcd8dBlHwC72ru94tz2f/P8SnLMAMo1uw8YTDiqJOQTfDiK?=
 =?iso-8859-1?Q?/uoKkl7bG02ShOYFQG936Mcp+B7yE5ImFYEiCyG8IXuxSYUScwUlnWWxAM?=
 =?iso-8859-1?Q?oZjen/2VI9UCaurfypC0bvcCaPi8IxOQHJ/AcC5sgCEYD+p8XNU+Qmgioq?=
 =?iso-8859-1?Q?9RptgIqD7jmXzYl1I5RkR3IZiNQcFJogIYIqlU8ff2zb0iKRAhPDFAY4s2?=
 =?iso-8859-1?Q?GAPeF83E+wec02umM/UrdwCz9O4d50qQT9XziBXsG9WH9DAfdVVZ0kqLzN?=
 =?iso-8859-1?Q?UmGkSmvnaIhHZ40RArRcxW2C5TMqBIevkr7QkwGFx5pkgtUEpiLuVEQsOR?=
 =?iso-8859-1?Q?NovgvfC8d0Z7RH1GlG8X8NX6mf2Yq0IyYZ/bxIjvM044tc3bE3BRqOd2o6?=
 =?iso-8859-1?Q?tov4l2ENep3tNR9WLhKio7iQn6kZzsiFJjh3rFgROWOR9LDlc7q6odd/jD?=
 =?iso-8859-1?Q?Xt72BPzxAfNOit6EOSbKtMzZyYXsgrwRmZ9Kq4jKIGtD1wrEtnVuB9/+nQ?=
 =?iso-8859-1?Q?6lRZq/6qPpOGkqyY1de1G1fcGKUDTADi0JmBWY3PNAiBFeTFBZKXWm+7SC?=
 =?iso-8859-1?Q?57HO5F0+HwO8StN3PFD+QSeCvcO1xE0Bj4RoJlNdnK+rF1Nvv8ZkIRkzJs?=
 =?iso-8859-1?Q?ydjvNcNa3PPnDjwBdcI/XYyKdH77AYUzSq22ebw1clV6Q1ncUNJp9+vGYy?=
 =?iso-8859-1?Q?K8nWnQlA+ho/i8Gpb9qnig1eQ/RPhZFKQsh3evrJkK9UvfJSih1FBII9ld?=
 =?iso-8859-1?Q?8ZsGsIJ+4mBpn8dcc/QLH/hNaHXZSYaMMHS5RfVWVN+T9AePBohnj8QC0w?=
 =?iso-8859-1?Q?qrlpBhKKh80c1xA7W8UHOapXqCEPeuV/UpSjY5A8X5EvQiELYv/JWy8AdI?=
 =?iso-8859-1?Q?SGw7WpaXw9hj7Ru7A6o5ZagfuGPR79RsWQmHbVfL2wVSqQ/262NcnQaLUe?=
 =?iso-8859-1?Q?355OJ4KwF999fZAKNWKTxnHpCBMSHHKJFD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dcd9b6-d9d6-4d45-515b-08da59eec922
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:33.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s72h7BmVwdKOoYSgyqmvkSpJ6Zi8Kgwe2vqmOi/PdIUur+WVbqkeZRB8N2/95hOp6jOYHUagl5FGjrUp5qq7kA==
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

The proper name is 'keys', not 'scu-keys'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index d0f56e4dee77..5db693535e53 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -230,7 +230,7 @@ ocotp: imx8qx-ocotp {
 			#size-cells = <1>;
 		};
 
-		scu_key: scu-key {
+		scu_key: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
 			status = "disabled";
-- 
2.25.1

