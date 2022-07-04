Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DD565B67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiGDQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiGDQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:18:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9AB12630;
        Mon,  4 Jul 2022 09:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF2k8xypeyPlJXr6mZ3N+/BBYwnTqvGl7n/PhUmKvAoev7ou6j3IPgkLZRe8BwOLs2u0e2pPA8IF7F3glbi3i8gg8FGyqin7g0WSFksc5uHgSvft8uVraIs2srbUL6sX8Fe2CajhUB3oX0gMAeNzpuHa5DbWrYlmHZePe4YJczdtupzWEVabbHjMWuigetv0vp2/DtD8E3A9H9d2Y7k+Ud2aXxdmKgihXNImMdy2kswAzpHQCENtSYPjokyjOqH+m5GPLorQm9gjwC++uEg0as69eUu0IdW+3MmyZWqq0/gXRliBxIwVexO2tX3fExygEzNK8ZyQibXkp5nFItCWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=BcPdKZM3sFDp+ThyrJCVXI3Y8rM52N74EdzkPciMq76NXKNkgJV+sL/BeatuMiF3YFXK4R3RkCpBfWT3Ce2TYTEUYT4oMbQOxlpW+n7uYAfM8uUEPHFgXx3ztzTMWjKFcdE0u+Iw5t+Hocni72Q3FEGLEKsZ5jSjjf/NCyStFC28zy0N2n1Rc8v/4vQBv2omWQYkH3F73lVoXRxveMzbatioD1cGHm4NF+pNOlPsjwN6ZApZSyrIN1G8bwLUlY5eBRGRUXFFnb6vzPb01AV/Mm7VrXctL499aclSgNQyUYiDf2DZxqhiq6Xlif1F7NP0Mro+ijOQNSzHSyprmg1dxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI4oejGXuCy2Y2FQ+M8kieCzFeO0K5hroMLoeq7AZ0c=;
 b=Pv+2gjGbh+Sf6hiaqA+W86YyK7JwigCTTH9G4z/3Q7vue/KKd4ahYk3e1KHiLdTHPju6Ya0pH17Ah3qkjs5JtUaQMh2BeO+STuLGOc4zsQYDBzX47oS0Ldbi4T5EnLdzgEoX2G6PH/CDSjCWuFmgoWw7/FR7TOOmoLNBribMLuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:53 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:52 +0000
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
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 11/15] arm64: dts: freescale: imx8: Fix power controller name
Date:   Mon,  4 Jul 2022 19:15:37 +0300
Message-Id: <20220704161541.943696-12-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7b66dc4-c845-4635-e29b-08da5dd89b4e
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LL8AlWstwtOmuZZ6et6gaGlWgqkZ1J/TbX9v/z+GBJDPmE7PJT1UU+c1tPossSI1iJ1qtebbirhXJbwev4QnREjIm4QtwzP6lo/nMYjzAlagq+41e3UhPHVZHvC+/PdWeEqjTXIEN+sBkkoNsi1GZ2nkZ+KjYjCtYhteMZFEGxSaV8/sYUeYMMPkZAyUJV98klz0/RVjIcU1haeLpRkL4ybvQS3jYy0b6ysp2WBFuxRtS2APUiUdt9lslLGjgoEJi8jJtpjb20gNT+jd61pRHjmPsWnGbZCrJknN/0rKawX7NVbq7gcq3wOHBt4xxHdgkhov/m3DUgbQJAHkePemQqT7QmggXhgR4c8uENRi7W04yH/K3fjGzRt3oP993I0EvEm3FtJrwVTstcX3P8fx5U3T0qMtB/uxp5roIDAYupfTcIBg0IcFLlJz+fpM8yY3hh2xpAPkFRYYfwD10qiDgXvfwOkai5kD+5dXLYWRMUkAS1sOInPkpOz/T+Ww/rgKz+FHnE/G8saTDCee5uAZwraHieXK08/rKITkWAPOWNlwdLz/WePLCvwkogacTfrzr5T5yGxvVyE014eGInzyfa5NmGdmGv9nuipRDWYzTnUGo/19MqLCcv/y25GMV4pHkEwqlMts552vlgjK8qgrAgcNo61+hYFYoERuGyDvFupGEqNcecP4q1HSpmGUPBRTnuJhovGOEs0+yaQ+9fRVe5s0r6T+EeZvAYEmviDkQncNEMkYUzOf98BhjsNOdbwYdyYSa8fgBRIowOdJzcgsouYl3DbvWmOoYWNuz/8ClOZB4zB36Hjx0F2UT4M/kJOc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hqPlUbSq94+EPc/cwL9aY2sGVFvaVl5OtAFNZhiZHJioXgc4A0ZhxqbisV?=
 =?iso-8859-1?Q?h5I5ttppd0vFzuAJfLDz1TLI+yGz4LuPyehMlO7sq5zydKrwGtyVdRl+Yh?=
 =?iso-8859-1?Q?4xyQcxST+MOhh5XgjrPCfk0wY9xyj9yicScQvdKMlZ/PWloSNSVmO52jh6?=
 =?iso-8859-1?Q?P7hZu34vuvuIwReQt/YscrogTIXSQ0KYLuLS0wpOTZdDcTE7jSbA3D+aO1?=
 =?iso-8859-1?Q?HL5SxhaK95QHkQJ8H4bK4AFIzAfZUYquHVER4mVNA+QDFJ/O/8TRXMYyKH?=
 =?iso-8859-1?Q?xr5xEYsZPviWYfiX+7w5cSJsx4iQB7ZKOU3Chb7SOZMU9aq8743WwZ+HLL?=
 =?iso-8859-1?Q?HGECmbvEngoZU552pj4O80h1zLX2uILhQNk47NG8i7HXhhm8TKFeE7XoT4?=
 =?iso-8859-1?Q?W7qsTgUI5rHZ0oQTC/AFkjnCflsnQ5WOHtPzT5ieVpGwZI9S4+9x5kOYIZ?=
 =?iso-8859-1?Q?DY9fLzrOQhllzh1Z6vjhENAwPICPAtbkVVHojHTXof8vLT/HAP3ThOJQXR?=
 =?iso-8859-1?Q?nowroHg0FG6b5X8P2xa8fEQEi58Jh7731kXA/ISDA/dnlulEEQiWyxoeNH?=
 =?iso-8859-1?Q?laQ8vcEg4FcjlYAAhB4rg7wb2gsUYi+UwIXa3EVB9CoiFKYeqxCpVITUfE?=
 =?iso-8859-1?Q?fkqsnuuQS1+1rhtjj2naydlplHw0Vjjz1D5lK9EXo0M1TU8bFPPyOsGVsM?=
 =?iso-8859-1?Q?34OmNCaESJJXOsW3tv4o2wp6k2PdFndNcqhWh0ds3m6rnVQxml+Q0/teel?=
 =?iso-8859-1?Q?5Nd/dPyPefWuC+ymYiXnpyUG4Biqz0fgrRDFM45cCCP323WY/DdBWheAiU?=
 =?iso-8859-1?Q?uhSzBAtSGJZp9c2eRZit7cTN/rCgVFdnucgk83G9MGoVT8n4zBTi3CS9pI?=
 =?iso-8859-1?Q?u6NxUEnYt62HSa1CdWt9kGC1lY4q6BNGu1Bg2uq1Tr+zXzd6uconiVpkMS?=
 =?iso-8859-1?Q?meZ4oe+aEe24wygAd/fXQmUdn7J7BA7DKoThFxFUfNBw8/CN75jzCrvUtT?=
 =?iso-8859-1?Q?FspfxLt78jYyFDFqIRNyO9puXuhGz9D+EP7eAurtCGj3tgfnu3/jfT0yqU?=
 =?iso-8859-1?Q?kyLhiwXUkf9OMRXiohF8lTFXJrp0QFqLcj+ciuhU9Hm9gaZ7vSpqN//qE3?=
 =?iso-8859-1?Q?4Z9cdHx9VNtTYxaMmkjXtuSAom50MpnM05St7Rl8bCr16T4shmh+9UgzbZ?=
 =?iso-8859-1?Q?Jx9GSPgyRkDVU1IUJZVcrEGaYY4qxrKgek9/Nm74iu1xwIXePwPM9SJbK+?=
 =?iso-8859-1?Q?INvX5re34MJv+Gw3YgFItLfvD0nrWcWAzXb0EKIZbnQGTrG/dJwbHYM/9B?=
 =?iso-8859-1?Q?fro9vE+CJAaPQpait7JQqZ7qKvxwXlXCoLF72psy+DenYfNhX8PHQEaMyM?=
 =?iso-8859-1?Q?QTj2qpfVCtLzHu7b1Qyv+58Nap4b63mpwEYp0aibtdWELWSCW6GLJGjM9k?=
 =?iso-8859-1?Q?1H7ZvcvA8H1Iv9j+Fwgt1Nh7s6pkPUeH0IyKCzaGt70IWwr190GlI0SDAl?=
 =?iso-8859-1?Q?jT5lhnZYrXe33UbCEGzN4l+OpWzxgAvLbK06EnMKvpVO8g4kopcF6VCkrI?=
 =?iso-8859-1?Q?vNXabQ3mkQ7nTY6jQKJ3w2BXWX00JQM9k8eYCeQWaJDNNQUhzwJ1g75gd/?=
 =?iso-8859-1?Q?f5orfhrgUfdqrGfmUVmDUdBqKUN8lydz2e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b66dc4-c845-4635-e29b-08da5dd89b4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:52.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW7sTEzgellDNYWXRqfTJns05ejks1OQkrTJg3YwpJsGjKk+IRGPbx9ZeWR9H3gkblbweQnN/bdBizfY0Rd5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

The proper name is power-controller, not imx8qx-pd.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 4f767012f1f5..5ad1c9a5933c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -190,7 +190,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qm-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 878c2aa663f1..4f8cd7339112 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -210,7 +210,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
-- 
2.25.1

