Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAD54C6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbiFOLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiFOK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617D51E6C;
        Wed, 15 Jun 2022 03:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbdPbWTwMdj9bXLfdDxSYAcefVapMhYWxnLFWXVlD9foRczcGulJ++8B8+zdHBtVQ2YVk/hUYvRIEWDPeIvJxoed8S0hipE5it+8oOjAVFOVDVK0u6bKy/VIW4FkTXwth+ekJxkDkjkTzYcWfpFWQwdxTCRvhuFdqXZrlghNYLuvQCky17SJOPS8JiSpNTtAZK1FJTPODzJyvg7wWa0lUMWVDYUhw3cTQ6L7E6c73PnhIF2zao5bQQYbHnDjG+QDGvERHggIMCqadaq8ouMMO6kvTjYDDiJGeU1rhulKBw188R2pVdzUszSZ8dXpTGow9n8ntcYnaMBO9iCNf8Zbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gheaOgW574tFSrNwWeyqRHYK0J56IpUdnhdkI5r48oc=;
 b=C1bBiBKcPR4dMVFd+c3iCh9MMX9WY6pJUHenqH6x6osjdjsXuuDkmlGhbFzViG+V/pGOZTVJzShSVVpmrawSyToLf9iEjSX1JWj8dtUQ5gRXZ/MqVYSH5EmFI6NOnqxR3+6GgE1bhLrRcaxl58skL3wu0qFdefY71Lby7b201iu1RES2hftiZJmJFunTYsG2FEqeMJYJBkWxCRUvcSt5CNK3e6PMA+L38otEogGyKk9TKS9Y/9RDYYfMTA3JsUdBaW6oMY1BFaNnZtOHCeKn7XpXHV42QWGZY1slIpxa5PlPIEeXPSAHP8iXq9ICVHQZFqVaMxGg9iDwRL6EzcZZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gheaOgW574tFSrNwWeyqRHYK0J56IpUdnhdkI5r48oc=;
 b=firectpNad2FBPhHXXbhWHQGYKuwPa2lOzMQlVmq5k8eIJfpA/D8C1g80dHaNSiA2MsiDs48x+27t+4QDUxZ3J7uR4HuDy+9J/dUuTeYdp6n++RVi5FUzU0ikfGpZGslesbHCjjvmUkTolb+bot0rQ2Jg63zTEpcggJiWKLyPkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:18 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:18 +0000
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 01/14] arm64: dts: freescale: imx8qxp: Fix thermal zone name for cpu0
Date:   Wed, 15 Jun 2022 13:58:21 +0300
Message-Id: <20220615105834.743045-2-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18998a8-3c71-46ec-f191-08da4ebe17ef
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3939B345D7AD85E88C548A7D92AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9GrVJU46iK6yZN8HYeeRFJV88j+KIQa7chH7IeqHHPQTnLXNeY9KJJtLKcABf0aKbEbOvfVwZrAR2yHg0OrypNxxuXFxzxEr6EyjNlLHvxlNqvwPFzKlVBFLIeHfdKwYoznS7Fr98VyfxYjPqPsurSI7TUHOGu4I1LNSUxjPl68LSZES9R8S3WRKOiv6rgjB7BDUnmQoe3uBA/qIM6GhXsSlDVD7AQqMGIF3phpeaaxUF6VpMTHkFBYhPCEmGzxTEmSaS0owC2cEN9tuItLcXit35wKukltthZbM21syjf+3ojEpfpIVxOrHqo6rmjew296ztjhIEKmCos9XDHQznPX9jX9sdp+Y9MVzfIIGpM1PWNrHnqKqYOLIR1hoREsGoIaN99Bz6eBtWYlrOwnyeJMKTJM0JvaMnxTVgUO6vGgRJ9yBs8Km3RXkk+29zBI9zj3a76kS/Ktiz0w+1zc60vUDZ/0YtVGtWb7ph+ETRnntxHYuxr54XSod4e/pSLhSEbUivKdedhAsc65B/fxRg99f/4m3eAeXovozupxe4rv7pFRS+CgzdSLmtxYrXLCgkr8AStZblp8VeUmGsxvTm1qn5zSSCBt1Miq3SJYiPjDrSs9frdKZ8I4SX+spvR1ggOv8/3TBm/fZP5yd+v7mXi7+KYf6wosKZp4N6Ym4n05a0+uDZrLFWpfmvHudEZE46hKcRafn4I/9C62AGXiUBdp4EmTAKt5eOy2Jf0vUx0TSYxg912dVUeUVnKTqH7w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(6512007)(508600001)(6666004)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(4744005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nZZIk27A/i5uFOecs93fnOLjVGiXJD6AhD+AfoMGo+P1Dj9rfcrqwgvUhL?=
 =?iso-8859-1?Q?UR997eL03vH9bUu8u0MPljAK357u2FT9D0+aU8XH9ZaMXSN7wDrGxKJCHe?=
 =?iso-8859-1?Q?Vp4DLIrFqQhgy9sX+5WimatgjxxPpV4u7u0QsWZJiEUJFHlSzVeRfJyF9t?=
 =?iso-8859-1?Q?357/iwBhJR2La+Q/BkuZ6BVdHcEiYnf4WpRhiWhSlWLq7b3IgP+T0Y84/+?=
 =?iso-8859-1?Q?9yqUX3F9nk9k2YBiAwBLKwFHArx1YOts510b3GMxkOqsFlbDY/ApuloaMX?=
 =?iso-8859-1?Q?HvZFoMNTzm5Ehe5fdJi8iEPGhCBNhpaMvAZAlGbK8TRlo0lWwH+HBmr3Pm?=
 =?iso-8859-1?Q?6WKhlDNa7rmYA9ZWZmQcPpQ5UGaydK8+MOPLWKHR4gmrtApNbK4aEwjeKD?=
 =?iso-8859-1?Q?/B57VYP5iML5/OFk4ownEJu6ZyZSfRPDL87a8G9a9cmt1eTT4HXb7SrHLt?=
 =?iso-8859-1?Q?a/QUAcTO0cFsDOPImHvvVwOx1GuzgDlfTTbG1j8h2Csmb6uAv2ueMALnOg?=
 =?iso-8859-1?Q?gWi/Q0XvvNGVARtI6BO54ZkH6X9ELDKskjhWDKF8b/Rqg62OevVGCu3gtz?=
 =?iso-8859-1?Q?pBcAssFooVPzJDFbp8OGCQeXkVvHns+YUnVNE2jBDaHU7k0AKI2/1Bb1q7?=
 =?iso-8859-1?Q?N3ng4NQsD1jMc8AUqlywVzwrXNzzrTJo/0+IEQaIiux2P03Waes0oC2ikf?=
 =?iso-8859-1?Q?QbzBvlYVfiS/DxzKtCquhPDGkfpPEwEBmM6uh7sO2cay3wbt3RaKmrm/DI?=
 =?iso-8859-1?Q?I2CYon+OVpaYqL4qu2vDD3gjGhsBvrBh2RgzrCZaSZbsijXWvKT2MpkH0X?=
 =?iso-8859-1?Q?lKXlCkm4/zVbBVq+eCeiSHynb/nzyO1y0e9BLLHNtxpN8jzDHIal3UBgUa?=
 =?iso-8859-1?Q?k1q7Shs4oSxRdEi474RYtRE3T7G3zm2nZD9rd22dtNPyczBIFLvjcvnI6m?=
 =?iso-8859-1?Q?xJhsr7kEN4ayNQ9CPuLUUARwlu0Cegl0KPU+jvILivsi8paeIg6NO/VlGQ?=
 =?iso-8859-1?Q?A6s2bFxoOYKXlLlcOZc5QkM1cyoMRiwqYEISoQz4/QJphA+u95FUHTBILC?=
 =?iso-8859-1?Q?NO7KLQYfM4qTfxtrHxR78IOG//ruTbt0LWnvP3Okbo+0DmMSpN/Wd1sFco?=
 =?iso-8859-1?Q?xFLYVdqKGnPnNKMBUOoLOxjys709osQgeDKVsKOfSt0BN92o7Uupw1uwh9?=
 =?iso-8859-1?Q?b8sk5qnQvcR/TRuoDrufGImiggFMkjPtgW25RWtv3uVjFVXsHej18VaVh5?=
 =?iso-8859-1?Q?gcCUTQN/aM22ThiBLrfYCiTa9JrWSoyR62OvJ32r4EZxmaPDlv5WHJiL9h?=
 =?iso-8859-1?Q?iTtRImXPCR+4VRxuyZFRpo/758NzQP6pkisExHGa+t9MLIJwD9gGYRMLf7?=
 =?iso-8859-1?Q?xg7yjELoXUAuK6fDWTJ3a/wcni1IbyNhn0BxvMdde9NpEHDChLjaEfzE1y?=
 =?iso-8859-1?Q?Aal/bjX4SklnDI0cUEosZQO+b7rMHvTiSWtNYoe9rzwnGD4rq9u0SN31Ch?=
 =?iso-8859-1?Q?RHRTHDyVvTzLyQUxoZ6bqnX0LQODgbikou144Puobuvw9QVy0I2mXMA9Tk?=
 =?iso-8859-1?Q?J2KevSfH96W3rKVjsmWdfwZJYxDWSiyFtvBY4cqBAgnsLWZA5A3hS6u8ch?=
 =?iso-8859-1?Q?kaUmNXajXVDbipA2U9fVW2iNabAGwRBRs7bO+OruYUsXQsN43Fx+6KdNMR?=
 =?iso-8859-1?Q?jcQaRXuK4H5S/TvcrrUfrsTPtjoAjPnTH64N+Ob+w6O9BL6m1gaBd+pD42?=
 =?iso-8859-1?Q?s5jbsG23NDDmWV62EVQDFtE1tQrIzbk28UzyRCDPhDAiK4k/G/uWaR5vh8?=
 =?iso-8859-1?Q?zK0be5E8Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18998a8-3c71-46ec-f191-08da4ebe17ef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:18.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpx3yyv1WEk7+OUMcGo+gntRrJ79oAOZXsgFIxTyX63Ok7hFhoixuo+qACpq0Va3iUjxDmJ2VjArjIAYXE6RvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3939
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

