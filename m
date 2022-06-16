Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E901654E798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbiFPQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiFPQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D327FE4;
        Thu, 16 Jun 2022 09:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGZQEir9oOHS6lMWpzm2hlo2xl2QTTyvhWLZCgvcHjYXjO4Q9OM/DM3lLZJ4ppsSY2s18XdtK9x4uXjmihF4FIYOTdgmh+NSVZ8cX8Qjl5zfgVcWTaqeYVCUhuTkeRUvcvUQ+IbAEfX6Ze91hh/TWgJiabLvyfde9N80vJXSWiHLjJp5MbZ82aEYatR6d5xHkOD/4uH4w2vhghd81k/XJLKXKXbb50LzhJ8OcTpYSeUGiLsHGviebkP/GeaU0YNh6MZm8XKyuH3tUQ62Cy941HHWNGoL9ex5jYGIZiakr3PVaC6WFnOQsE6K4x/q6wVOH2t6NZYNArN+Ew3a+VySjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UK4aVxciwAbclzCvjsYtCOSu9thkTDNwGp3BJr09ZY=;
 b=C6SlCyuL2+dJbJoT5zeMiYpQ5FArK6F7tMPJBjAZ502s29ZTx0T4tLCJYtqJUhh2a9Z+W2S7CHpwI6Mv3s4h1lkIK5q5aYm9JU5uXVDAcoHx39qB5FTJTfY025cURA4srMhLM074vBoJpY8Si7gLp4L7EPd233mm0zIyNWNSv+hk9w3EKN0gkx7Erfa5eNC6QBnEFerUT984VffUoTKHxlTicJXJR8KMFfihGex1PvVwbyFmfv6o19cwJupe0CLZZeNpxcxdl9mvhY/3ToVAwGkzFEJWxebWIYOtRspqgfqhZln/5Ho1CWmdUKvRWxekW9zGk2MHlYmyuWk7dCYvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UK4aVxciwAbclzCvjsYtCOSu9thkTDNwGp3BJr09ZY=;
 b=IXh0rZIk9Z1o4zxk37iHObrf062ktZw34AOJxY7U5qudlsxABl9QIteXaiTh9opekEiPZQ5OiUHi2Qv1Dqjn4/nu/q9unXS49bZN27xgC4Xt5msblMooA6u/OMWPK6Qa3bY6+2OCVwk683xNd+bVf8pBKxnooQ1q/5Ly30UtKq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:43:48 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:43:48 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 01/14] arm64: dts: freescale: imx8qxp: Fix thermal zone name for cpu0
Date:   Thu, 16 Jun 2022 19:42:50 +0300
Message-Id: <20220616164303.790379-2-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616164303.790379-1-viorel.suman@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c837a8ea-fdf5-4847-10b6-08da4fb762fd
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649EAC1340C018733CB51F992AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYGOI9SJEDj2X0OJyR/O3wrMzGX8CwM2JO8RhgCLqrk0Q1eR4QurXtrPtjJ0hUwuBNOkFVpqe1oAQGjbeN/ZuCvu3D/D7OomVtnXz61j51ilnM+FSK1mnnSFZcGO+ChgcnjZhyxD69HvoUzcqN21OozsmJ8TKQQ0RAuxTyUspbZS4nkPt0MItbxoiJEUbwY+VRCAR2BHlnS+0rG3GGRrTuGCQ3qXSxPOcDazfcwwpOshhi+xQ/HNsBvq/WcmweAntkAGdc/L6L3iCxmvyUfRWGGpvAB+pXLScpJgKHkry9Hr+AklHo3nDmKv7EySLpJdIuvDTl3GvjZGE8OlJlsa1foFaVPHfIv6JtiCpvwXqq0Y2dS7LPGrualzWysEvmJGuFtIYeqlB7C4bWM50EEdGM2qqYVhih0ftmJM5yjBQ2K2pBwKIfg9Aw0t6/1/XSguzB5Ix716DI7CTdNPLqSOxcCoTnjWyaOe/ABKzCRNtcKZ1UozQgnsJmgNqt8MkCtLp7mZXy4Ol9qoDnujJkcoanuubv1mLSPCApPMyhipUNaI/C6GVLbVLFpAfvHqTs6nEE7BOeIhrNKisiUdI5ab0/NkWm8WmuiQvIeQzpw9yrzN5lQm58lX34P8JxsyreUcdN0i8h74lP4oRgZO34H7dA+I4XxmhG/PqX3VBA6cv3jKAc/SbPxeq7QVj1er1bKf2jOHZnGqcCfiJIRx7tC6J6DQoXgnA9feb2krHwwlHSH96q9/V+21v9rku99LeNgb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(4744005)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(36756003)(6486002)(66476007)(8936002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?joy1zjDlgNnOXzfrtnPnTQvORRu29IQqCFSFkeVSB5X8NvnO3qRdUp/iyZ?=
 =?iso-8859-1?Q?8o/cSPAZPbkC/IyaRv7rHUBo8BDHv56UUSZ7fKEzWJXib6s210Sd4ynycN?=
 =?iso-8859-1?Q?WxsBD7ucsXTC2QOfberRmtzsE52ZkD93rll7TxYGUvIYimNI4LZ1d0KmqG?=
 =?iso-8859-1?Q?J3vTj6/PxoBGmfP/BgXzMNfI1FSzQaRQi85wAI0AkA7ZiB/XtR096pKwRt?=
 =?iso-8859-1?Q?XXiWt2MLZW9eVYAMKF5gZLFTHEYnND1623A1S0zMbudw//P7vnKPsQoVQc?=
 =?iso-8859-1?Q?4oltljfPfVzif94Ibr57rHB29aOjS9HDo00CZMLdwttMxUjr+8vTcEXeMm?=
 =?iso-8859-1?Q?VQZaXanKDF2UL/do+Uc8jwqGXbfB5GKWgCIe9TQ/LdzdIIn9qRmRyjWPa9?=
 =?iso-8859-1?Q?vErLxiMppuLSRoSeBv8k9juf8i5ZjK99cYfdGE+CQqWxtyZBtjJCpowBro?=
 =?iso-8859-1?Q?Ogs3VJ3IyChLA+Xtm2g10WJNIhcvCOJ41xUJooTDddlReLoYnWXJ8xGg9L?=
 =?iso-8859-1?Q?YtxbM7JZspbCpJ3S16TzXna9kyJIHj77/tWvvGfozZ4enhHNBDk0akbTSg?=
 =?iso-8859-1?Q?uU34iGp+uEgDG5f1bxJwN7UTn//nReQNgftdaYgjVAUTQwKc/Gm5wID237?=
 =?iso-8859-1?Q?/7R7nV5seNzKMsXkllppboiGsYZPxq1QGjIFkX2+b9Xa/r4Wsmddi+buHj?=
 =?iso-8859-1?Q?DGrHKauCa2PNb11vKamfDtbwGwvju3LrTHMlCY+WPNsoI96kLRuAr9DZWU?=
 =?iso-8859-1?Q?lkZR5I3I8C/Q6MuTOP2WP1BKjwdzrWfuIeVpmhwgfYhcgqaU8y14uvez65?=
 =?iso-8859-1?Q?HT7A2w54+EAkYioBSd7pziqGxUnF7sB5nAo0n+u1r9zQFN3PN4dhE9fYW0?=
 =?iso-8859-1?Q?FqnPQon4ms3UIa+QWwWCUGhoskwJk0SsX6bbBY7WJpY9CsB1LRHGbYRVhq?=
 =?iso-8859-1?Q?cuHdc3bOsw11+vfcr8Nev8UhvCDgW+sCC/1315e7BYJ0aYzEWtliyJaB8l?=
 =?iso-8859-1?Q?jgosdSFlSbvsmZmjZkJHaoKfOzVmA6dy9ghvl34RlpCP4aZhpJKTq372Xx?=
 =?iso-8859-1?Q?+Ku/8CxJKNCzRxUH3KRTI9B/0r2qT6nKU87AQnTah/nMWcGLel3V7zsO3k?=
 =?iso-8859-1?Q?eurIdhUwfQM1DKMW1PN2fjw+2rlTlNx0Iat9TOxYbnWkioy+NUc+L0RmxS?=
 =?iso-8859-1?Q?vMT2T04FdJ4SuOHRvh5T6SFGwfnAZ7qqEyjy8WLLg38yLsyg055D9IzS3b?=
 =?iso-8859-1?Q?xJi1Rj9E+/W1KukWbV1CKjNEme4gzvDiTbfH2gKBBx5lySxHXzXNwTe+Ed?=
 =?iso-8859-1?Q?UV6Z7oDOgKmPy/ZoCv8kXKanF1SOKv0qMUGmz42QGbGAzt47ujjmFm9pMn?=
 =?iso-8859-1?Q?Ehzb3ccuGywOC59MiTI0FwiHJK66CwPCHOY97NqEFj790NiuP3SCzAJ6jx?=
 =?iso-8859-1?Q?feN7IC/nqfFu/jKrmN8qA9tNxFlrGOxSW46IQ7/9jjNrCtvxxmam6lbMMd?=
 =?iso-8859-1?Q?TTxv2F99XI9ayyZuAvqKf9PA9KZqckx8cKDhV+oiaW1KDQk88XVi33PCJz?=
 =?iso-8859-1?Q?19hQHeZOA+o6vFkoJM8PoqUx3OQrzfRZ09o00ovk+wWZlMy40zQX6vNccm?=
 =?iso-8859-1?Q?mOfIfobIFp2N6nsA6ybbU9q7mabGhrulAUAkMPckwDjlDkpt9vxEvox0+I?=
 =?iso-8859-1?Q?t6Bl5E7PDCuagSXi4bfYK6AR2dAifWyIIOhD0MhcmfeINIXInY9pUpUi/s?=
 =?iso-8859-1?Q?LeJoIoxzaluGroaE4j96hJ2xqgtR89rk8kQ0YJU/U7uaIoYTqw0oKw5Nxg?=
 =?iso-8859-1?Q?z+WLqa5alQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c837a8ea-fdf5-4847-10b6-08da4fb762fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:48.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYI0i1O6quZy51y8uM+T9xt9T32CqTmAzSBTIjcsekkHtEtjvGsipxoR1Q4dDBOeJY8zTm8XDw2+ChuQcnkD5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

The proper name is cpu0-thermal, not cpu-thermal0, so change it to that.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index a79ae33cbad2..483996a1f2d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -276,7 +276,7 @@ xtal24m: clock-xtal24m {
 	};
 
 	thermal_zones: thermal-zones {
-		cpu-thermal0 {
+		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
 			thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
-- 
2.25.1

