Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836459277F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiHOBaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiHOB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B50013CD1;
        Sun, 14 Aug 2022 18:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu4s4k5QGWUfhor4e+kFDUjO0P1ObNQgNAUAbTL5hGCiCZahQoCJ7J6BsK4Ux5OyRbSfd96HPjlgK/ds8YmyvGPuXYkLIBXTy5P1bCxXOxOsWY6utjQ2Z+vRNs2VqHF9gSyKukQ37t1A86pURCBsrHn9lLDrX8PdsjROo8GE37DkwwiBldOjyo85/te0G9AbVhI/IKFPbl87xfR4a3Sl6F3UkNJcmgsjEMd54Htu0r1nynKHln9ikd/dD2MUFkW1vqCJAECMzNPbti0b0qf8zjqV1M5E0dI42agBxlNJhWWHiIkNTx0tdqp0AVSWJPjRC9iMu/hfo9wlAznY4SM88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghvN5Dc4aMi35VaLpIEmRI0W9auI0qicRtDbkzuin7w=;
 b=fk0NzY1sQ2/HVBjfg4sUNQGADyAK3TShvI2MbqG6WwqErsms9S1dTqjC1sKlxxdOyZssGv7M7+Y4FyTX4DfFQZEhNh6589nFZfpEbQXqyqkwFT8YXfBOQyrCp5aSOjsPBz/lrlwhXD3pwkbcp1t0clrfnNi5kRiwQ7xvAs1g9Lgj3mI+r4Lf8PFO12GJPkiWeqQqHZywu6mdC7DEkN6KhLZuABfQid2iukmXwl16zEvr1Czws5OS03MLhNp2sHwX6eizBG18u+bvSaNi1fOshoOhmKR06kBSyMTbGy0hkmpeCtfNOuq2NzE0G8a5Wan4V+ohQ6UWCox+y36qUmVlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghvN5Dc4aMi35VaLpIEmRI0W9auI0qicRtDbkzuin7w=;
 b=L+nfXnQngwkbWF1FrWJ3yquuw9tJqMD5/d+WSDxuRGAgxPcGof7cCX2KkMBPMJd0w/fKyjcqTSmOJw+VM0zTNwvHtE/l7CscjsJs3MFKwnptjBz8Axd40aDHsISIFKd9eD8qABMRqK20GVEXhMffdOhwEVozrTjLFgIV56J4pak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 6/8] clk: imx93: switch to use new clk gate API
Date:   Mon, 15 Aug 2022 09:30:37 +0800
Message-Id: <20220815013039.474970-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b2f9e3a-4395-47e9-cceb-08da7e5d9dbc
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjaHaruV7YRImp0FN6K6jaI7PB7AUm47KvBGsVXu268BoJSswGj+9A09MyBqeLe0zOW5lWn/x4kx0EG4Z2HilEozqRnkdwM3hIH8Ky3QFqVKEh84asbi3LwRMYPAU/X6/fyhAWiZ1D4UKiVj5YKuT5Z5fqj7cVBFH0GTVJ2ux0Pdces7p4Ir2oskfI8PtWnvJ0ckCoVeu7CO/PGDC7bKBxCU9LveAQ1jzw8DVYjjyc4vqOshg9Ma1Mdso3HVV3y34iA98hyraYXxRnTNW4/F6z5HuiFWzOpheXPGJA7ZpW/lM9NGqkka6SbuOvmja1nehjM0mkf2EK2Sjd7f2I2tfdaXjytAjJHqxRklf34+wx/bve2k8P8UTiQK1hRqqNIpnLyWRmzFhG1m9DlLPj6b8Q5lZ8QQZo1PE33a/1k/3nTM5wEvom3fqjMGAqoRWsONPANvBSgM9e06xEGt/Eax9jTqjEmmvvyDqj3GByCa0zi9p16FK/r2z9/CK5evIwL3M7oeKmyJbZVhvf7z/k7EHu7ieUEOn5AcrPuPeSiXAD6GTv1Um53AQXPFTCXc7LIP12m4vT6BOtOamHeXbSlg9h53XQR7/HS+cz4Xh3gD7hvvh2Rpg9TPHsSVr/nMFpyRvIqWAowocpQejNSmsVp+0yKpXo9EOAKSYSoaOZ8JNZoV1Lgw1GmQMa3PPzPqROt5WZO2LACDrAshApmak+v0rR4ihIKaZCZip1nNK770y/QJ8WWU3wvUGDblSFaP2AGpv9nhBwgIC3mbIvaKSohBotAvSTsWBTnnao0XJlWta/N+H1goMTysSbpktc//8nkc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1DjinlLlOKi5QSGBkgNznj/PhEnOCS9+FpwaC2Wj6VakK0ocS5VohqvgScT?=
 =?us-ascii?Q?S/B7OO+2yeplkTQjYan8IKmISHVhuM6VYxskB1gnVI+0TDL0n+Em97M4vibK?=
 =?us-ascii?Q?qBo3oBHSyruv5V6eI+sQxqhFh2nKtRYffFVZEQWRhyOr77524FbBFK8gGtL4?=
 =?us-ascii?Q?PTcNxCddPAhmPz/VJfr816aF5Z5NgTH9f3+l1NbPHqvLkqkBpEIWsSsQwSiM?=
 =?us-ascii?Q?P8jOFeInQaWs8SZX66L625lja4M50wNQet4h8s6maDdidr4eDeWz00zF1UhI?=
 =?us-ascii?Q?jXY/Yowvb7s7wq2tdGGBf+FVKDSisr7LDZ0XB/wTJE73pJKowxkbUZkuMf3T?=
 =?us-ascii?Q?jfFe/BLGC2f+UqVxLjp46XtbRDKJaP+d0374AJESOoM/hbCUptpl6R1/pb1y?=
 =?us-ascii?Q?SNzIkKeVspUpad1plLBPvNqVanANJVglPhcojsO/DpZq2rvzFl31I6wljHPS?=
 =?us-ascii?Q?8rpvnsuIfHgzJQT+Tx8E5jNuTJzudYRWUUBg1kZdsvnEH3Tnh1Zea5AlU6OX?=
 =?us-ascii?Q?pJJf720Wa2giWj/8tZaal01GAKOAxsQnJTK9tuJ1JQze/F6YQWbwrk8sFf+4?=
 =?us-ascii?Q?BCmYLSvHwze/iglQT3/9W7lVeG4c3cGNBFDzaAo00GxW2YJKYOBgzNwAykXu?=
 =?us-ascii?Q?FGIauqBrQ5Fpmc5Zz8cM/T/RO3WElYOfoAma0Hkd0OGoEjbNFsc8ILMLZmCS?=
 =?us-ascii?Q?gbNL32aks1XRpfJFhGoyW1Q40Arb36cX8TJTuK4E4UnyyzVKe3e32seuy8EM?=
 =?us-ascii?Q?S5mdwy/VwjcfnF73GhvzpkFtA5C3dMfOzj1eMcNvtnF7oUt/Gex1nRnwj02G?=
 =?us-ascii?Q?vzlN8JV4aOUeFAl1B8H62w4brb8JIrOa4WdQHSXJHqpvHWn9cJogTu4jplUN?=
 =?us-ascii?Q?LynGCfG1r+UYaeqzGDnx876OzLeEkS2H+85jzpcjq5i3Mc47S8sQ+avYbwH5?=
 =?us-ascii?Q?8UmrB0vZQtOeyG9t9bVsUdWyLFFCf7f+zDz0BUO3ahx2nNPhMo2XGSDOdSeq?=
 =?us-ascii?Q?M7ZIoii4ZrLsJ/EQk9jvrO6SLjQub95fPdEowJoyzQD28Xh7k9Wb+LVE6qsz?=
 =?us-ascii?Q?ibadFPZNIXSdazT5vjl3pU+wQFci1muYgy8unf8j0K1HTmOk0TO+jwGJjd2r?=
 =?us-ascii?Q?P3lK9DdqPUESy+6iTGhxwFvUniHdtl4Wv+myxgOGEeuH893j9jwrRPM6YBwL?=
 =?us-ascii?Q?ZyicQv8a5xWYiVKX5/zAA2YaL9x5JTJJ9Cev6f3XvZ88iCg/4BOjgCfgmYBF?=
 =?us-ascii?Q?UuVHXZytiaukp7NGCinWazUZ/Y0pJx3PFVQX2ioxy63L4WvqgpAGQ9DfmmL4?=
 =?us-ascii?Q?IjmFYl+Ne7ICWK3fbFvq1Ukl5hFhcR3QozlzQMKWsuCEElGWGnGHpN5rUtUB?=
 =?us-ascii?Q?v7L6JIwBSYmvTab0vl1nHr15gYLmzr/OR/hlk/r2d3zQC3QhNJxq4asodPcb?=
 =?us-ascii?Q?PHIUqzY3pCKxR2+gtWezqcZ8ASiz8H0Aoa+P4dHp8DoYJqfrWgfTaNGW9Z6a?=
 =?us-ascii?Q?qWNBNKRa3AbP/adAL/K/CSNpAsGufKnSoXc+BH1tJGyaHgaXvCJVMX1jpHJh?=
 =?us-ascii?Q?QY93VwF+IZf5Qa0aq0NjHBqlPnbtooJKWmGtov3/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2f9e3a-4395-47e9-cceb-08da7e5d9dbc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:37.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRALqE02PAp4dAtZeY6Rin+EZbnjurv7d0e1RusawecHu2HMyDaRTMImFgB0ruOse3uElmWbMNYmgQWgVYF64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use i.MX93 specific clk gate API

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 0d5c11bb3659..73d30a2e64b0 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -146,6 +146,7 @@ static const struct imx93_clk_ccgr {
 	char *parent_name;
 	u32 off;
 	unsigned long flags;
+	u32 *shared_count;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -299,10 +300,9 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx_clk_hw_gate4_flags(ccgr->name,
-							 ccgr->parent_name,
-							 base + ccgr->off, 0,
-							 ccgr->flags);
+		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
+						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+						 ccgr->shared_count);
 	}
 
 	imx_check_clk_hws(clks, IMX93_CLK_END);
-- 
2.37.1

