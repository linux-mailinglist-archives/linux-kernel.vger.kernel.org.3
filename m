Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C756A2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiGGMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiGGMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D422C12A;
        Thu,  7 Jul 2022 05:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEc1sFPpglmvdUhqUFWe/B3EnegVRyet1dzb1XJpl+J8NcJD8/Wj38PQcs8si5VmtZfJBhNFVl6SM6Yc6wEOxyq9jrGThPyN7LlArUrP2OyVPBO983zVrLuAkHsPJcirQR0XfalTdFVnXL6yGj+manJ4DDa3HIo8Q0B6G5FVf5euTbrOIMwRXWwASuExrJLGz++eTGJNJwie0eNLByyEGiewsNfMN/N1jnC333z+rPlx3VLwanpKn+bsf1N5WVBHhzLg+NxGU4u1eQK+EZCOFa1Eg01bCZvhMLua73XSM14rmH2Ac1AzmnfelK+UHrMNkkySYzfGYHLiP1DLeXQ8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvYcKREa/S/Th/sEmMrOM2okvZKRcuZWak7e+NSPRmU=;
 b=T3OTZvwd+0csGsSNluGVMNvBBRFJK+oiWWNGU5q6KMtj4S0be2Pnu0wijna/RG1grJzMjlqZWLlofhn2jnNPGT1XbkcSID+LrpQPEhfYLYopfEJzC9oPX5/wjsPLijz33f/6UWuMMpKpGqKWRM0LNwWaofw+g9yyB+BocRO6ebfr+3i/W+PhBTrOTo7ho+Hd+IL2OVJJbY5KHTSSSzVh2Ebz3HKceS8iGziHBGlV6rgbMAVfZ9koR/aBSJ+td/IOOzd+v9eQsjGP8lHzVBHteO2LdHl24ycG30yn0o40HssfGSR6sKvCOGwP2okZaVf2gpyLY8CGe37m/uOni1t81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvYcKREa/S/Th/sEmMrOM2okvZKRcuZWak7e+NSPRmU=;
 b=Uql8qfh3pUXYARgLWBDhgc8KJv2xLQpUOyVitTrkg3mb47yCQi2RsQr/EM8Ddhiw9w26J+YzYBvBN0wvwxuce2YzIMP56qwNtLdSvncS4MG4LsLqHtuc5Emuu+yYtQPk/OgPuGxB867k+uDtM1HIJ4Wtrqr/RmH4sMww6xjSgkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 12:51:31 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:31 +0000
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
Subject: [PATCH v8 13/15] arm64: dts: freescale: imx8qxp: Fix the ocotp node name
Date:   Thu,  7 Jul 2022 15:50:20 +0300
Message-Id: <20220707125022.1156498-14-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7ec7bf1-8737-4813-8058-08da60176a86
X-MS-TrafficTypeDiagnostic: DU0PR04MB9276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMzZWRsdTWyEG1mgpBWnCup0wobCYhwn2X0WT/aqSR5tRERT6weI1im+mY8Zxg9cKdLj8DSxNKA214vMYehf7kS2QGw6BOagvAxSNn0BZkWk/b+RYcUNzaJpwdXHYCmOKav9IbcmvP0dwBrfitEHPG+nmcwQZhI4JVylw7zTI+XjVdJu+/6dPNQxDFrcwazNNgq/A8JqzaKKXVQzfFfOvEayNtAPUI/FbU+e1WlPhPUjNtHKc8rhDmdaCttJ+pcthb2f+DLykHuicOwthJaiJg04AlBityB+j/JpyxECyfXTE/M0AI/88BL55fPdiFa+3bxXrCzfm0fYBAscXPDkvOR8khiGs/9Nj13YTVJzFlZIJnNvdN0LOmwZa/ZIHJzBT5HdLEFm8A1bnniJUU9UrZxYMDButRMocoxvD0aYWccMGiafSPwaLk3D/hjR18a7M5DH+VEo4KU5v+2WoKnuS73l5REwBTyvO04TejkCjWqcWF7JyEWUqd5YLUfFi0/u/4FETORpPLBA7DuGEDniATmcAbyyy+DY/XQC5+U6c2yvTyKU43eRdP+htFXBk8ItSgLbelbyuZKVMfSSj+caMakUtgVMHezzDBN2S7kDNZcLxJnvhN5GviUOos9P7GBKGertA2UDKfpH1wPrQW3WITLSSZyfyDqjNMoGZAfxcZUWrDVjDZFWszglrOAzKltx/fKmR7DT9iMmcKq7sN0i30NwNKfnEg9RoArMGy+LP/FglpZtVPjk1QN8Q+ce4WIGZztKMCSlW+26GWtjQKTLQB7OMdrqDJJisqyETETfJsR5y03d7hj2V65kiydk/T3k7iNWiVX+L2MDl7io8DOjBVdjdT3y+h9QT+IWZIib7p0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(921005)(5660300002)(7406005)(4744005)(7416002)(8936002)(8676002)(66476007)(66946007)(83380400001)(6512007)(86362001)(316002)(26005)(2616005)(4326008)(186003)(1076003)(38350700002)(6666004)(478600001)(6486002)(38100700002)(52116002)(66556008)(6506007)(110136005)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ncumuXJT5RnsRlev7Wy9RwCcf3/0KvOUIlM8zO8iLYGjpWEDNquUdUmC3S?=
 =?iso-8859-1?Q?JUNnII48w0oJwTCuoIMV8lw7jVmVET257FSQUBQg25dkRu3N6IrTt8WEHz?=
 =?iso-8859-1?Q?nPEMmFUUp0EXHW5zs/a5KtFOLS8iT0TKJoRIlIqRkXq0GoK20xWHay5Dhe?=
 =?iso-8859-1?Q?BECrRCjweVnPXRe531nmEzylTIGBt6Jz/43XbjO/ZBqmfQKHK+DHyY+iGK?=
 =?iso-8859-1?Q?suArXhneMpYSdQbVTeu4+0kHrXM6hngdcY/RYAC1yZoGkNM7zIQ+LMbY/a?=
 =?iso-8859-1?Q?6o/x8uIw8CW3tIbpIhISekKXXHpj2eZOqBT1xwQXLCGvjAMhuXlSnKsBsS?=
 =?iso-8859-1?Q?B601dl3JV1XD4A44JS328UTAEr1rr2bZgG3HnTiNK4FSK87fO4PUWmulrJ?=
 =?iso-8859-1?Q?4cckSGWNJVDJkCcKHyBSbAcmHut55zh5HQZaSdEC/WRsxIs2H2DKGzsydU?=
 =?iso-8859-1?Q?om2jNwPP9PU2St86sgeom7zcOvZc3MXHSM2Cyp9pf3vYYcFR3EqU07yS+w?=
 =?iso-8859-1?Q?xn5FQjnTwMq7SQSL5mBcYrm7JoSvV9W9qbOmhhlqVoLLFPzRvfXoqfgMYV?=
 =?iso-8859-1?Q?IJ40VklxtcrkrMl9ljXk0p/1/wlZblKmltsRB3l6NficJgz53rAstt/JQx?=
 =?iso-8859-1?Q?r/yBWkteQdIHHeyEZqmUl0mF5wxZFN5pPwzM+onchgEx5kymCJgfQOJmel?=
 =?iso-8859-1?Q?dnSAOJlQ9JfGIfaaVVITff7lSypWNt94RAM3J/s1zK/R9R5x1DRofUrJhf?=
 =?iso-8859-1?Q?smlTvfszgO+HmXzXP7J6xdsaUR4JVUEOR+ZbOlLFLZ8wFekX/4AASX1VS6?=
 =?iso-8859-1?Q?XHvuVnP4Zkhp2PTUw6kDS7CEcH4GbDDUVo3392qwzzvg15+BfC9CInPaF3?=
 =?iso-8859-1?Q?ZHiJVJcQm25IhIOMXgruVEMOtQAWeiYq8KSh4/dqin5VysmMpMDXgvzAY6?=
 =?iso-8859-1?Q?2+nr3g8Vj6lmITXtiKprYZ0m4h3OEerOAgkOHKX+vIxENPktU2Sm+zucmM?=
 =?iso-8859-1?Q?VDkeEwQ/3Rld7+wzpbRwAmvRwhoyvgMSx1kTyLHOXxQltKyJ1oH6onRQFN?=
 =?iso-8859-1?Q?BcWuHL916mJRmKKXxODws4yYRjBLsYVu+RwTnV1RN37uMww7qVJ+9K4Ldp?=
 =?iso-8859-1?Q?dF7SFB9etoRrJDygFGwSpv0qg6ASCXS9pfB38vIsmzGy/iUEUAS589KxCZ?=
 =?iso-8859-1?Q?upweuiOhn7yNuqXPTRpTJfqKBoUZQc7HjNVXfVgfJTecLZ1wRtPpykUhtl?=
 =?iso-8859-1?Q?jA2/WHBHzwL8O3fbtfU1PwwHmcBml28FhZtfWGz0Q5wv262n5Xgheqw+k/?=
 =?iso-8859-1?Q?pN4yK1JhyNq1Fyt6FAH9eQzX01o8qm0a6ovMyy/Uk+OBCwdEeTE1mq9ym+?=
 =?iso-8859-1?Q?AOUgw9OaT+EAJ8+jv02lOF8BHi3HhOU8pDhDS/UXld0mfz/l7+Ng9O1V/j?=
 =?iso-8859-1?Q?MlrCi7lnbmCCCSmphk/y5VKA7z49ZuV1TK8ALL9Hvd98NCHyRQ4+ZQj0T7?=
 =?iso-8859-1?Q?YmXkPsw57Y7v1bjQkSP/srb9DKbB7TbrErzNBez8BmUotZ5KYRSFB0xp9+?=
 =?iso-8859-1?Q?f9iswlId5firR/uvD2aNJb5KtGfis/48YczPmXbkBynTSnftnxesUkBetQ?=
 =?iso-8859-1?Q?7Q/q9nf1HKTngLYMo645C/MZhtPDNBX1Ki?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec7bf1-8737-4813-8058-08da60176a86
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:31.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuR8ZAJ1tpdQF5f0ooU2zUWKoG0w3yoa1kxey2SalAv0v2ley5gMKZgG8y5cYojM0Dm2tI8s36np04bI/vMOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

The proper name is 'ocotp', not 'imx8qx-ocotp'.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index d0f56e4dee77..563a006ababe 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -224,7 +224,7 @@ iomuxc: pinctrl {
 			compatible = "fsl,imx8qxp-iomuxc";
 		};
 
-		ocotp: imx8qx-ocotp {
+		ocotp: ocotp {
 			compatible = "fsl,imx8qxp-scu-ocotp";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

