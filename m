Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05F565B78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiGDQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiGDQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:18:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A61209D;
        Mon,  4 Jul 2022 09:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsQruQ645w+b2V9DxVz2DRu9lPbXKE1xzRWskWfAFDE80UOTYFlyErEiWDO5FKN3Hi5+Qw1/IO5CXJW8ZZK8IhnrAyxYYckh/VU/Ij1SO6EVzcdFcNMonoI+LElNLTdQzvg+4bMc57TBQpvyDW5IpOl6CyJJQv4orAzbQZkWRjJOofpgRZHG9NvQqgNcB+VwZjepx0sR6axVH3SfnldubNVjzdk+16qpmokonuUQgivkzrJZ2iCs+53Ta4iNFhse+as53aWMA8fhPRHmFgnmyWzKeR6+I3E6sRdeiSQi86NbQxXOfAoG8mojNDLxljLtEq4xxu21ieQLgJIZ8K8zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvYcKREa/S/Th/sEmMrOM2okvZKRcuZWak7e+NSPRmU=;
 b=XKhsI0P1D+SEVA7AyuLJjOjBpsJI9FfC0O/77j6Du6mtNj99QeIJTTIRrgqIIEVhpElszr+nIqTn7lfmpLxGBnzRwwzJgjQlMaAirJzWCowFWImqFdRKas3k8A70wJngJi6YiaEd3IaXUQPRDAee1uaeH7v1/xnp/893GAGCVQEcSm2a8eQE9Bwaf0FCNrqL9wfji4rofs6Hph6pb/yd6TMHGIquFxcPYkGSJSR67HbSbNgYR4+4Tko/e0KN+QTK9f7veDdA7gok5QXcQxNAKSoB/NchkUCBe/fzYfpNSfl6pY7gtHTJcftlNL3AwlbqrVfSgTQELbWsrIrIQeJg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvYcKREa/S/Th/sEmMrOM2okvZKRcuZWak7e+NSPRmU=;
 b=JUzgahhlkZBmtx6TBJbMuEKyRzTQp/PvKgH7HQKq3pC+3slpF+ebqrWj838tmhLaPxPdG4L13Im68KK8lp0SDENYQsx3psmtkBqEPmFv03l7bqSv3qO5c6ZHAuycMT4yeV52eB/fuxX+JzKiKX+wXDoCg93OAeasnPb0ObNzM7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:59 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:59 +0000
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
Subject: [PATCH v7 13/15] arm64: dts: freescale: imx8qxp: Fix the ocotp node name
Date:   Mon,  4 Jul 2022 19:15:39 +0300
Message-Id: <20220704161541.943696-14-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 392c58ab-4880-4145-f24b-08da5dd89f1d
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sNaO+fI/ZDZBWBW0nAkYQGT2bgAQQEcvVvSgraPoPA/ICha/tSgBdvbpi/mCo9ewg0DoJWcotU3IAYVEPRnQgpkZnKBnSKWksd9Q/NefEZC8o+TlF55CqSmYK56PVjQbgPcZtCIP6qxOXl4LrnudhdgkXlTx5JOusfgBkZLHhXwUrgAcQO4pY/x9CfH+YmUr8UzrKIBeEpl4AI7l6JDFq1UkGzx7n9qYFe1MrlFVQ2asrjYDYx4eRGsSWy6ObNPbF+CjikfczU3EUxf10Wscpe3exVbOTpIwaLchlemXFBYM7ntr7CUquQBMEA1vsmVdkquVm27kQIou7F6Ld4rh2U5PkjuWHjRX0eINx4Oju+NGA0/GirCxIebMwBgvpdiWG/3he4W/YTOgcCGJDFH4nInYalseiXbw9FDFXuFpC7HIOZU73PK1uCKjKvBbbmd+w6BKrNgXnWgx+nNHRlnXgAq7ayPmz7dmQnQtPUN/F1Ybp7D4zDWiqj1XuuiLRcllmYOfpIXwxl4WGlEfAbY57rd614wIHo8w4zGMms51BRMyJhHeeWZ8dyyQQHjD3CFPn8yRcx7cOPeBIxpMtzhF77DT5lrTfRi2Z2uSFIjBaGDBMxiTT3lm19vDAklFx+hcV+5BzSgG/I9aeBUIqwXC32UwFfp22r4YJVpviNFKTkLR3q1AlcgVrtRFP2yyUPXg/Py5W8RlNp2kxPli6vz5wad5EJdpYKAmT0+ExSeE3DSz2d15DY56uerD2QrY9WcsU/pJRkCo4xNwJKpX3VXaZatuYgOL4QgkfK/74S/zDVXTh6NiUlKtaqaZgG/bfMj028xLqrRfxsRbCCLMygP/2eIXa+or0AbljbBmtYhsvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(4744005)(66556008)(7416002)(7406005)(66946007)(8936002)(66476007)(6486002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?v4xwa625C9nqPj1FQbU4QiPI4+RKVV9IkVCZIfgl9f+SjQ+ijA8R82bbXa?=
 =?iso-8859-1?Q?wudv4NSA3Yoy+TmXquRzP3N72/qMtsgOPuCSY3WQPma0pPeSNpOL7EIm2T?=
 =?iso-8859-1?Q?RqNhN6CQuo4I7MyaDPoQ8QBMHkaKzjoOsV6tL3b0v8nOrYNIUwFebS6/Ih?=
 =?iso-8859-1?Q?Iqp0pmHsTAiDDDbCf9tYpDAWxfstFTntfZZeT2Wb/UqvB/Mv6lWkqVfha+?=
 =?iso-8859-1?Q?V4vPwmAbC+a5cE0NV4UYUMRFVV48ek3s5qmzkSY5XBoXu0Bp3024+EBcjo?=
 =?iso-8859-1?Q?AAgY49xpili6hJ22bPNZlMGn/Ax4awJ0yov92oM7a2bZ3sjWhh3TC2gQWG?=
 =?iso-8859-1?Q?zlAWcklFghqz/w1npHcKRhHqfTceYapCuW8CUjt4vG6qw9K3s8H2hmvTer?=
 =?iso-8859-1?Q?V+7TI6Fweue/tyzn/g6hkMz4Nk4qs4VCaHqQ1U34w/4TorX6f5ZgwWtjYO?=
 =?iso-8859-1?Q?HehrcRQkI+sisjwD9dTlxjNteIzyCifqRiV7Rjbd9Y07PWdK8M9kChNW5z?=
 =?iso-8859-1?Q?v1onIhkyXazaK8bwV7uIPgExWFpgjq6Z3DP93hkkwWPULupBNLIgTDftWE?=
 =?iso-8859-1?Q?SMkbne+U90kbT9ArRAkZfeLCrYJQaZxvjq7Qhw9tgC4bPpacBT9v0PbRRG?=
 =?iso-8859-1?Q?n9DAK6maVxKyfgaOXyaumXxkcADi425pwz6Wu/8a9NlCU+sAlC1Jv8L9pt?=
 =?iso-8859-1?Q?nTGj68zxqslPHxZM2s7RuYKJmfWIFQ2Bt4BShxYj+xj0ArquNQI07nIWag?=
 =?iso-8859-1?Q?DXv2mL7biGtQItv9eU4TWbAYFtYQu0KELdCxM/gmw+dTmKBEOZgM3WvK6/?=
 =?iso-8859-1?Q?B2M2N7FxM6xChC7pJ+bYZR/aaleAeUQgTu5OfDU14WBfXSLnW9+pJAW/jD?=
 =?iso-8859-1?Q?6WiGQJWlBHGkr762VphnUB0YL8v8/t/xUrLauhYridW/pBVQIxTPyXZlg/?=
 =?iso-8859-1?Q?thg+w42BTqI/VLoIUJW1AAWvvuGVbcl3sCD8Dv2BgM38O4zgNWtayf/4Zj?=
 =?iso-8859-1?Q?QQ57ggyRfWk9Nh160efTcWTPrF0hRqVi0yNBjOLtsisf7gWZop0PXOorEH?=
 =?iso-8859-1?Q?u/35Ry9pnP4/6NNWjsCTbIDKkKxMB5NKvlxiDRzD0s0/4rjVfNbolLIx2Y?=
 =?iso-8859-1?Q?bruNSjaOIlI2oLgBixRi12protsoyJeU/V07dyJQ6/20MxhRb7c2ggfntz?=
 =?iso-8859-1?Q?yUZCNCu+OrVxieYggEm60tC9e6LFxSoHGO1Qo86Eo96CjTy1co7BM2fsQj?=
 =?iso-8859-1?Q?o5rVrY+7jH9XyCs2jt6rCxwn5YFcBGBIeewxNM7uy5xO22NX2hJuoSNPsM?=
 =?iso-8859-1?Q?ByCYev28zZQ7ERBBFow3cYPi3fg8nWzDdl2Z06S/IFHymmbK/mi5Pq1JNj?=
 =?iso-8859-1?Q?P2quw6aVaVPzV4c0YfHc4Saltqa2sunfkAEgLmA+y3CzBOpIaDFhRCcOGN?=
 =?iso-8859-1?Q?Etk54N/woQYBrIJmPyXIF44bqrANTeHAwurI670ZrNTRrJF9c+yewa9ekK?=
 =?iso-8859-1?Q?7kVk3ZwjklZa9v4lLPhBRemvdp5yTwEiRckdqQSv2LZxBdE6awnJb2LiWJ?=
 =?iso-8859-1?Q?Exw6yKQ4qZVIfFhA1rCqA9VTDyWnPF0QfMYNjDd1ldewOJsWgjPogmlkFu?=
 =?iso-8859-1?Q?wt/Xiol0sY3ezBWgf49P5I6vvta7SR0q/t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392c58ab-4880-4145-f24b-08da5dd89f1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:59.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XkfrT5YhJoxO/MPrvgzwMIGHcWzWwYI//KCHZshueklkut0XU39dkkXEv4atG8iOO++PE/ZNPJVnjbn7v7L8Q==
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

