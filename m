Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9F565B71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiGDQSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiGDQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:18:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B8613CC2;
        Mon,  4 Jul 2022 09:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br5+O5NVIHkHA6pAQ34rcrUbgXCUcBIsK+KB9aE0w0+J3WaWsNB28BUEe1DS30EPTIjApGASrPktNjDM6sjYlwyUp9EALIY72kjamrFHPtxFxyo0fM34nSdoJ4hl97U2Cg4TI9AXWF0wZuE54p3zgC80+4A84xi55kj8cY8OW06qZRaztkJzmOquBGCjhvQG+Sd64rEBJeNvdiViAH0CyYaGKghqpO/KCYXuLKMkhIRrGAfqH5+L9KkDUOyd1vs3kWMgBk8Px2sg5hmF9G33KiTJj5dEPtLDm5gpAKPx99SFyPG4UFrCYx1XEOalnAxWAYMn9W1zicpczJYOdQr0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rSBLwEg9Ywy/odhIL35m14Ux9xPXDXGX4gRctHFqyI=;
 b=KbIX5qIiSX9vUOtoy5yXXbN+CBII+Qu1NGvlun6OzINJoupR5OT40JuTDRDHzsLgnZu132viGN/CHrz4ZD8lnkMC48hNVMhoLUgKYQDagQiCHRjiH5qVMEqUgZpayuHL8WvEZeYQ7mE7GYLNsjQmkpafCaMunBG0ByUBVW0lU8l7jMNUEYWzrkO+vdqYEjjaBQWpL05DQW/GzEXjrz6hOB9y3zxkB4SXzt7e/e5m3R146+F3Yi9wtj6KTkVnDQsu4ynDh7rkBix8fOGwkW1Ct7h/aYn9WF6uHPJP1xU7rsEIm27C7udr54jh/m/cXQl7igv6h4FiMgfaHmWlrpni4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rSBLwEg9Ywy/odhIL35m14Ux9xPXDXGX4gRctHFqyI=;
 b=NfJ7qlpVu+sE45wU+ETUj8n3RospwDX6m2R4RQoG/3KrDsO2HsOd0IYWBU73WknwPdX9SDCvZYK71U1X7YNQn8r3fx9UR1CZonluhaR3jm+MgT4uZvmhzS1bm7BjdYb9OXU+51XBXX0eyLBv6DVjtEV/WHoiB73ILdn6ZHn56j4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:17:02 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:17:02 +0000
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
Subject: [PATCH v7 14/15] arm64: dts: freescale: imx8: Fix the system-controller node name
Date:   Mon,  4 Jul 2022 19:15:40 +0300
Message-Id: <20220704161541.943696-15-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d74d7fb-82f0-4d32-bfb6-08da5dd8a0fa
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ig/wiDBMLzyEy+zc2R2VGiZ3ra+q5rEUgzkhZJC5RoO3lP++8gjJUUknE+gXMq1Q/FD1OLN2xtmMGKz/tuEqm30l0v/av82sTJUixiieWvQJRZFivuYYK2Mj6Y1tdo31NzT1AJBL3erLy+267/EmzRvTFcC/o7o7jTH4BF6GqrSNASLcfCRDB0OagxlctPJP8j8FHhgCcK+jFjmqdFjaVHX+xSNaxtv4QkitZuDgWS76vZ2k8ObQ92kHFSIWQFeSsxPgB234lx8cFeLXOLtxgL3AiopSKxVbSdQ+c5HxlrXmv26j0XX3FSp0ILbmsl2++O2qrgroWp/Wh3g+p2Leq9XAh8+gIOsXglzI12YViRVfxctc6XlC0S4SG4ako4RTwgBQSxeVtQkLjXj48XGtfPzkgiVA7Ofla4jYFsfgXw+6Bs2V6bOHq0mUmQWkb83clLo2afIpRu2N2ZUrljF9n5pYOZdx8lvY1aiAMQf2StHXeEH5NE0ZxBVVuu8spiOD1OptpwGin81fDmdzRapVhfm4+wrHH1lsFUG/AUuqgzAxfb2SGFFCBLKuAsoX237a3PNEfWsDcJYrFnspnAkSBYw6OwKfkkrh35XogezTd826XYmRPLbS5XSu9eUVg4MNF10L+REJZWkYCGF/swEiUIyaxc2M5YJFC9JNLDLUZlL4u2RsRzRJwbhT84Czb1Qp0KIiH2RMO8KIdFod1W+Mua9rx7bJZwzML6i2AsPOJWMb8NPr8l0hQlo1SUndxAuul+lmxexHeydKtoS2iMGhFAjeK/DAhqADID+Yn9l4zoarGv1D/aI6qi7J8BAB/QjMecI/T7l1YpVKgqEL/SLASQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(7416002)(7406005)(6486002)(478600001)(8936002)(26005)(6666004)(6506007)(41300700001)(2906002)(921005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2jTl57wAPg62T2Ulu67EeA+t1UdpbyCmawO5UJer1cEb3ZUZDp92YaqiIF?=
 =?iso-8859-1?Q?AjwRKV5APQuwxiyOp8EWR1N2XfYjL8wRo4vrXVtNBT81dMYK/huMloJiDq?=
 =?iso-8859-1?Q?BM9xyeFvPFsGwb0Pii7ZnRd7sTEkdELmYb4boKTgbTvnvUX3/H2dVSCYDC?=
 =?iso-8859-1?Q?GMpfKoneQ3R1Xn5Z0QFzwnrIXvJwK2IoGrBBNbRb039trjIadbfqC/8SuG?=
 =?iso-8859-1?Q?dqUr4pEY9RwfQnaUFCVlpjsjd5ERnnsJdd2CVKDqMP6b4h01BONAmjmWeo?=
 =?iso-8859-1?Q?sN1HYdrHOG6zYX8nMtbsLrD577iYJZYIzCj4ZMbcnPghuy5TBKU3pzAkO2?=
 =?iso-8859-1?Q?YpJ26ViH9Nn2fFziOYyQXmTZp+HK5VgqfqmnKldMI2gf2XugspJX2FUqbv?=
 =?iso-8859-1?Q?fHMCfD4q9O3Z7yNqy5KOkJH0ZAdErL7ZHS2+DlCbEiM04IjiUCq62nhnU6?=
 =?iso-8859-1?Q?Im+ErrNgyPzKpCc+ZOgflSLtTcr+WBqR2I6B6GxAk9kFGUYktw3c1OXeNe?=
 =?iso-8859-1?Q?SUlhw/fL86FcTt340MZ+9qZJm59Npvj7AHs323ieVcwlBHhn1TYWktDVC0?=
 =?iso-8859-1?Q?kQbnT4wHk79kVXiw+CShskfM9x5ccJx1+MOmJLfTxyh0IUDNSj8AhwZ/xf?=
 =?iso-8859-1?Q?B+fZVeSeshVDjnLPd5z2JPEz6quziyLZFxSOh/k7e4EL+IHgqlMh7csFsu?=
 =?iso-8859-1?Q?lE5fkxRgfttv2wu1CCzqnZwUxQJnYEp3h8AQ9Lyqqrf69yzYaqPQui+HSU?=
 =?iso-8859-1?Q?cuB7EblkPcbaNdE3Xqge0TeOiwbbs+44qEdkpbjklXTinZk2Gue36gEA7W?=
 =?iso-8859-1?Q?Vx/QI5C0iqhcp796ptn4iOR1JRe9f0mpj/5+aeFRzOeGO9vhZg318VYyEE?=
 =?iso-8859-1?Q?EXJRC+UzcRh9goNpcNGmJt1yXX0DoVnmkwHlBE0dO8LLjh6dpt3oii2TBQ?=
 =?iso-8859-1?Q?RMiUbeLwEz+tf0Uuhgqtxs6Bdf9X8iGjU0THn1DDxr6iuWYEDgRHuoSeHz?=
 =?iso-8859-1?Q?5t4SHZF2hEVBFEKj/nrLj6MYYx+Kw5WgXiKqmVEml/LwzrEBrZPaMTsxSh?=
 =?iso-8859-1?Q?93Kj9z/GVJcGOq5TAlEtuDBCV4w4zBUthVtlhF4iAV2DkPjItzs+AlwtHA?=
 =?iso-8859-1?Q?DM4BBEBFFaiRP98LGx6FieATQa3xE8RXlABKJBXeFc2FhYvWcgSrkNja6v?=
 =?iso-8859-1?Q?MPE99/6dfGRTeSKZ6KqRAyIUhYoFGFZvVWLDG5TPnP2Zi6KK23A8yIw4lT?=
 =?iso-8859-1?Q?thyQgbkYY0aqhg2d9DTZdXpa93FDFC0ZC2v3WrKAPOl49Ti091QlO3KZSj?=
 =?iso-8859-1?Q?0kmsad8pPAE6iOc9r4AIH9ioSdeZNmF0I4gN8jb4xDZITltqFnZwoa60Vl?=
 =?iso-8859-1?Q?kAPJQxFjdNp5bmhJho6PFuzbVQW8UPgyS1WRt/M61H3zhxvrQtX+PAa19J?=
 =?iso-8859-1?Q?xmpdGT22E+NTNqI+EOucvyem5cF0/dYsGP+xvnUKVX3vk2SfUba0QXYUkY?=
 =?iso-8859-1?Q?vzqkLpIFbTJJqK5ubKCQynT/bxd4wpJE8FM5UGoRIBP0u4k+4llu5osjoa?=
 =?iso-8859-1?Q?4FGQ5j9RGuVzwJGqLjHP2+zBifHwnrkZEuONXkFr+grMUVednYwtTOOAXd?=
 =?iso-8859-1?Q?nU6JK+AKWUJ/2RnPORFJR14FGDR95TJPFM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d74d7fb-82f0-4d32-bfb6-08da5dd8a0fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:17:02.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP5JRl5ShlwBoR43wrOQumFZ4zYaHrymJDbqYMIx9ZPXlj5DK6ruE0xYClMkD+JUJxTLsmVg94LbSN1FDvtvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

The proper name is 'system-controller', not 'scu'.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 5ad1c9a5933c..c9c2b6536233 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -181,7 +181,7 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
 	};
 
-	scu {
+	system-controller {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0",
 			     "rx0",
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 563a006ababe..ddcc0131b861 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -201,7 +201,7 @@ psci {
 		method = "smc";
 	};
 
-	scu {
+	system-controller {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0",
 			     "rx0",
-- 
2.25.1

