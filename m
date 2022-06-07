Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984453FC91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbiFGK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242250AbiFGK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:57:50 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AAAB82DC;
        Tue,  7 Jun 2022 03:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We4zgh09WpENawPIOdl9wervWOeg6wRdHF6zgQ7AH3dBrTqn0vJMLwyGk7NIAnxe23k5oWT7/Kt/utb37gr8wrmW2IIj/Xmh6nLD+9mfyutBGd8tp2JpCjDsC3+zoul6IBF8AKWVjqVEJJX7R9/8ihEben/UErceP8eB9roCZ78bnXu51xT7nyenafsP2PzH4+EDzUovQ/4a1LkxTOgNlIBAJjhUpS1FuV5wv5eFGk2IBAyAj2fJgYRcKdA62qEMMaK7DtZLdZ8zUPgzkGyejRejb24BDevSeSy0ynjRRD/QTZIMkk04g6T80YCoaEwf/6rg6+hDSHwCyGYjaQlPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vvI+yoOrwD8TXBgZIdZT2/yd2tRJsbEjerDGdJFo1A=;
 b=CwzPfeeey53wZ6oXdwugkHuSXSYDp8L3jOx3zJMCmWR/gHkNBimHOaHBJ3iilwlnp0f3X0dc1JGxTk/Avr0twJoWv2LKSZXwwjtzHyks3GJhnp7Ja/vAYUoGu75VU2kkRHUJrenp+6W7IWzV8cpigOcsaCHwDn1nEDsCsQRnkID/ZnlbWrQ7aw0uvsy/f6Ns53V4QVnHxGDiKx3rBcPmp8b6wcXruymVz/ZCfzdTaKIYzOVtrkfXjGhCsGoGxt8I3I2115054+7085zpAQn9UJJjiykBqsV9pDw6MQEm5kKjVXRcKp2/GiJ/8Yn7IN5yTUz/8gVq80sH+eyg00u0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vvI+yoOrwD8TXBgZIdZT2/yd2tRJsbEjerDGdJFo1A=;
 b=otFGvhnO8J17cdwodnQ+R3r7gMGjdq6fzzZudDSzpAcqnvrOpHrKEVwq+ndQZufw2vTviklt13zxybxZ76K3EMe3/gV118NWYsb7bagTz137WCZiGX9OFMoLJVsfOPpTPruzA9PDhBKeDUtqXFJ7oORJL+9VKSqZdw9jzT0aQDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4221.eurprd04.prod.outlook.com (2603:10a6:803:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 10:53:37 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 10:53:37 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: freescale: imx8qxp: Fix thermal zone name for cpu0
Date:   Tue,  7 Jun 2022 13:52:55 +0300
Message-Id: <20220607105255.1811769-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0556.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::19) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e719da6b-8d09-4947-7d4a-08da4873f9bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4221:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4221F757B84377E2213583C8F6A59@VI1PR04MB4221.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9E60KkKKLHUMNlH2KabuzbO/COSZJCf3EQiW8iCmZhjimnruxo/tBaIkK7qCNnMZYdhEi0FKcsXoa7bNykAFY+rRB29TOIx7sTgC1HbpGzP+YoKrxnypFvv8sx67UySCYg8xP8khYNzDgXJyJBnWOIiBsbB/vHle/PkAvQ+yG3VGVCPAEbbgl5fl4ymARehR3VFiZGPV0j7ub3/XzkQ4snqtLDgsvkc4mdu2dUBbQQcHzjW/vw/9hXeo0CytkNrsalThndROelos66zVueYjHgV5PAIhlNV6UNXdxHyTXv9jYKIlYrMhX5tl4ET72VKybuDnEP/a69ylhnJ1WUe8VjWmo1wNEQhwmL6WoPTk9PaF8TPmzXKecRGa/n80uUJpmMHrNVPvjuOsZF6OWhyBJH5EEE4Su2VO3Z+z7MoQs4rKcOF3yeK4Bt7G+qssCvKelddgfKbOdSy9msLJVWRAaavkHa4kAle8TxGG7iRgyGk2acmyWMo0Vw8I5hAhtMSKe4lVg4DVOV5ozzGP5AYqOf1A3G6po4zjKQWJueFAP3x28Y4PitLq3da4L7UxJsOIrb9lrFwGOvxiygDnSb4R7VYtIYIiVQcVl7kYy9cE11C8GpPATbexi4Cg4Buq+Eb9p6TGIwpKovpMFqOvR6aTkWMpCQC3PtRixzjug7gDw4qL1stmpRii7Fk8BfDl5mV2T7vD0MjOUnNzPPfs1wYqFm3NcJ8I43D34fG9YTwITM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(44832011)(36756003)(6512007)(26005)(4744005)(1076003)(5660300002)(38350700002)(316002)(2616005)(38100700002)(54906003)(66476007)(8936002)(86362001)(6666004)(110136005)(6506007)(66556008)(66946007)(508600001)(6486002)(4326008)(8676002)(52116002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOk198HYp62yVR8GPQv9diOxSvIciHbP/88bSs+RKwUIxl2joVOVCNJlCElB?=
 =?us-ascii?Q?RvA63/tpGY9oMNcpiyXO0xyBaEZ9VP0RWOByPs502kM1fbTqBzy96R86lps1?=
 =?us-ascii?Q?hEutwbPB5beAq7/1wZ5e2afuGjjzH2OvFWiQyV2afukODJe2yfW3+wPPibAc?=
 =?us-ascii?Q?77S2xU4Vk1WGugB2i946qlGoR60teaHXWY0q/pq+kJkoCfRT+ynOc2MrZ9XW?=
 =?us-ascii?Q?+kG++j/B6X8gBTYxbKAv21NG/6OM3nzhqMy5ZbLygyl3pQd0o6dbruQG8ioU?=
 =?us-ascii?Q?9XBX2LtRZSxSNRMXOCCHNlGuYEBcgnF/p3MZStD35rQe9QqzYY6o3SshLvQY?=
 =?us-ascii?Q?741Z1vH8Sbiz6JvovGcwzcgHje1LsTNkMxI0+De+jGjdEL1V2DVunWJo1xSP?=
 =?us-ascii?Q?wp0zoosZT3q/XyoeJ/QNjkAQQ9gryOZojLEKgDJ28EaAUG1NGCs1x2J8jv5V?=
 =?us-ascii?Q?h3Wz+74h+angT64suCc41IwnfkFvlXEe2KTyiWYML7FOPShmjuZH3XWsCBCo?=
 =?us-ascii?Q?3rNpn+uNJ0VVHTDAVeArnm6xpZN5agzz1ZWmf7R71sp4UdRlRxMoEjG8lLJi?=
 =?us-ascii?Q?jMZWpVhMx1z5PIX6uRmZOhU3pXrnPt/TKtlR1B/HTT0sSLTzdFV1YUvIP6Pp?=
 =?us-ascii?Q?1PQWOK7n6Ykv8MNt9QBaYRfM92PQzThz6icZFmI1uY0UNl2W7syKI+zFj7AI?=
 =?us-ascii?Q?PGMPucBuZBUNrP9zrtZlJcgD1A/UnmbCyZV5asXKglCR+Fqdw0WWVhtxtepu?=
 =?us-ascii?Q?ypSNVx8dGNd20yKo4o7O/VJ5ytDZ07Gnkhy+Jv59axKRnOBjqzNbiSppGb/5?=
 =?us-ascii?Q?rfXmqkgYJ0RrmfuhlY86K429uu2Z5UGtvqPtBRWP/O3bWY7xBGGdlUL77uuj?=
 =?us-ascii?Q?nEjBXMjJZe4z+rLKK0eRnqiP3UWtuMSwAxJMJMs/h/KbmovBI3jl9UNIsZhc?=
 =?us-ascii?Q?v2W5ZZpNZ23HcwwlkOcdi9WB7XrfippN/5CShvZl7dXpuDI55ROk83/OLldn?=
 =?us-ascii?Q?TiyIASryKGYg0vLvjhp8gqSOg7Fag6Z0/xNNxow5kYO+p1UTbJLMs67G9MNV?=
 =?us-ascii?Q?aEE2groREtUYUbBUQp3EvA8L6usKdxp0Zp3MXGAk4ccV4HoJpEdxDSAQ/u/Y?=
 =?us-ascii?Q?mgErZHv0o9GSdK3ptCDAA7Z14S0kdWX7XxnBGSU1MP0oNdfgLsB92NC4dxth?=
 =?us-ascii?Q?CpDqXxtLWA+5JHmCkbbrKrl25Gx9Rl6x3t6jpyP9jYn633QFy0nIgZx4/g1E?=
 =?us-ascii?Q?bJ550od0D9ktEz8aC9jO56Nz9DKEbq26l0iUVu4DjzkBOiGBFux3/fgb2t8b?=
 =?us-ascii?Q?ei2MD5aPmumUR4A9eUi1zKI6Rj8NEsYVxrv1XEWMA1LGY2s+2zEjL+R/eov7?=
 =?us-ascii?Q?DC7UCRLTmIOFPgDdlcIAHY2Ajytpb6O0sKfBE1rh9/KLlb9Xl/YzqXEOkvEw?=
 =?us-ascii?Q?8abB/xJC6e6QBQQb1dysVbyPBMJyE0ei4HGsr09mK+cv1BGGU1jqOFk1+SIJ?=
 =?us-ascii?Q?W0bfYsihkLnv2yiGKLWUZm/S0ndqW965rlQZkECJXVNEzldScpK9re6mOj4T?=
 =?us-ascii?Q?VacwokQzGD4CXNmv4T/fsq4Zt7gj45h1YPrYC0R0TOv819kFM1RLC9ghZDr1?=
 =?us-ascii?Q?WkVPam8H6zt/aW4/8ZbSPSIOWhL5EUG2F6LdJWYNzw76Fz8c+5+5oYjDD+XH?=
 =?us-ascii?Q?c4tM+8ckDW+LsRwqrFN3AQslN0aZJWo0X8bFdYsf8/IYJt/ag7cZyRg5sdsC?=
 =?us-ascii?Q?7ZjPOXvciQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e719da6b-8d09-4947-7d4a-08da4873f9bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:53:37.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcjdZbu3NzGWsCgc1sLBiFhb6r1Qq/SUbnxiRV/kMXtRVt3OTCNGYN/QOz7uWyNRz5FNU1R7UXWwhEaxnvwJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.34.3

