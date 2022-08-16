Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259F59537C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiHPHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiHPHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:09:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112F388E11;
        Mon, 15 Aug 2022 21:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6RjiUr50TrAunoquwR3lNAH1o/UPVlZojuxRetRbVaDWFXyqXp8Ha/9zqQytFa85zG4LDpjypnprtBgrYOnebWNa7XvwS8hjGX508HXfhw+pMnIuEanxqjLVsXJ3QBfkWA8y9NyHNU82UCNPPznWjHqXoPYia4wQkKqEOZV/l60YDhb5YGcnLNYixHnnjcWTEBcoDsGwBT3jZ8lJuX6a/FQUB3UxtK/Z4u4zrXSuWGysMktQGwShJ3kDlsRBxCp4c/SfC65Qh5i5mBA8ZNSFueiJ/MerlWyzvhrpxI7/pAMMIFd8EGlOGBhiIp/0ZZUKqQSjXq3e5Ln/+uJFyJhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN7RZu25ghqhBP/V91DHU17DP4GGuZaqlXLciTMYaKY=;
 b=F4BRMIh/o0+QsKDtf9cOLtg++GbrEdQ2ZVKhfn9MZhEZdKT3yDRTUGVIJrbs2axz9TKXa4rqVYbNd1LBCE6vV1K4N+qrVqUuIvDYa/JJdwYXwZyr0l+3V7U4snT3wZhGImfHC/Z0BiUddBL2+LNfe3ts0Yv1Us8ME46oDT7hQdImmQ5O3ksGkRQsLYmxbgs4lSs6g5uaWigIobfZ+AhdErLsRN6gQtVGq3ILekR2F62OM7ja5cdtQkCp6JpfqxECkR9aoTw7bT+Mv5Caistr/RTmVa/jvX/3EpNorgSVZGequjyf6QnWMv3jd6EkdUKOFkoKHsnA/2MLJoWr7pV7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN7RZu25ghqhBP/V91DHU17DP4GGuZaqlXLciTMYaKY=;
 b=N2dRfH51Qo7VTQm8J9QpcYq3nuyBMQdRTvGngBhVT1MeStF9L/NwhjJ+K7Q2zVLDiHRUUCmdY079P+1qjm6jztq0tcZNTkGkplyoZxkSqoTU8EGnzliY5jx1eT8CKI4rJP/lUNJMA6VvtwOMH55HYo8XQeRZW59T9zsU+wUiAKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:39 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:39 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] watchdog: imx7ulp_wdt: init wdog when it was active
Date:   Tue, 16 Aug 2022 12:36:42 +0800
Message-Id: <20220816043643.26569-7-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816043643.26569-1-alice.guo@oss.nxp.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf71125-59a0-4349-d45c-08da7f4130a1
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXs/QVch9fuPt/5ciCERqtCgXsIfZWw1KexpDJzu2Ku48u3E8DI8CvXuWXnWfPAJqfbf8UBZK3Wi57oGFhSRx17yEc7T/4qrj3zYvfXGcdR1rGxIWhA5qJPb+hbOj6NpSq4xFyMWv165wa73Oh86lJtX9MrXAX295K7hZfikIiYkepeLGrxAUke5aD2z6lk+pqXrCLl+nGDhlUm/JY1w/1X+fhTqbVtXZPo4+vNDwNgFC3OLP7WC2jpPT9mbUDwdBn1QwEa8ZS8TOM6RlUF856HzjIDINGdYP23NgEJ1Lz3Iu6ZZXCcFBwU5UTm2qcLRfMoXKn2P64pIGtbd+0ceO5Abfu3wRvZ9swTzb/XkWOWnKQXJODpzwwbkPS2PE2Le0OTqfAXjJVVvua38UP3gjRV3ruHXR3lpcAtIyZw0XdvyDEtgSofCXhzqbY9QX2Bmf0A27UsCnIKFD6YUBpORameRqANhYaunPKhUqMC91KcpGRHPqWZrlWOmq7Q6SpkIMqVU+HVRwxOEcJB5CugZbxDSydglSjSIpFyQzHnLiE/lAVuIifKtvO3Y1HuNzTVsOylDhzBfwiiPi8YiUffjgBaHVxWXOf6zie7lIlMXrQ5jPsGbkfNmCWsIstpNhv+7PVBLHos5eBwedTmECafNbi6nCNqcg/kK1GoYmuEZ6nrM2IEp1Cut0gN7Xki4fMV+LSCUYLCfazOrzXwbw8HRbAQHbxD6P71SM5iiXi5hr/15TGoa4gEeCXrU0TolJeJGb5izgsbYnTu8zYc6lQjaGiLHg+o9SbmpShEM6CyZQE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHkSgZj4/9dGGv+8XQHHGPrQbaEl5fzXtw0wYnfFWoS8NRSeg7+X6VMNK0uu?=
 =?us-ascii?Q?m3Tm0pZhvR5jvTIOsXn/qyIGAUA3YjuJEtzVX84k7k8DvXFBdUHTZGmjgFFb?=
 =?us-ascii?Q?oxTr8TvEy1GEHc7SAVJ681A2VCODC+w5GWrhBCWabOo2bzbZzk8SFEDgjTAX?=
 =?us-ascii?Q?uhPI7iJfNrK6fy6I1wDaSoDEE9BsDX/GeMlnuQguX6WKTUqvzxgxXSxzRKhn?=
 =?us-ascii?Q?B6o6x5t9vh8Lg78kQnpvPfkF2TZob2H8IVIhfjfvUlwa8C4hgE2I5M+M4KqS?=
 =?us-ascii?Q?uIRnxIM/ONeJ1UjsC6cw7Ek3E/aMFCYt9z1vW6FuV7o3rK4Q617cqawQ4a3v?=
 =?us-ascii?Q?enp5gtlNRUAFBVnclwePc4OFFf/uKhP13Ek1phO9VjqZ+w0hBvdMg5GPF4lm?=
 =?us-ascii?Q?2gRq0xZAJBbaIRiIcgyrFcxcKl7x+xNhm5mrkEZGXpVIr/wyyl4/2EfN6mTy?=
 =?us-ascii?Q?gBVHupztwbvqT4COAmlobDsMx6h4OCmUYT4FshinTdoPyQAgNkrq6A3N2lV3?=
 =?us-ascii?Q?52Qegj4vMXY2u36ioJtihEuM9kBndkji0yKZTWI1pgUVXMtVw4nrHhc7Pjpc?=
 =?us-ascii?Q?84G+HXmvpiFyXCnKdv/7UGr05hOKUhBD499XyrYFvOgBTirR46UL8U3jMkwU?=
 =?us-ascii?Q?R4BD74/KVSg6yAGAdK7t6mAvHBg59cNea6aziyxA0Ue9jsUIjmtMMsG1O6IG?=
 =?us-ascii?Q?XxgCGVl9us4UlgpERVHzE7A0C1Pdr5nRn72skK0T6O1tJAIxiLyM8SEF5TFc?=
 =?us-ascii?Q?uzkpg3MXpRijx4LY3/wDriGBdXCNEd1ICVmdI7aYFS5cVl54hVsLvLRAP9YG?=
 =?us-ascii?Q?Zy6UMkkT47hjCUIEOJDONlaga0mTFNrqoLbhNlZ0HStbCQ6DnnTDL7NwtH3V?=
 =?us-ascii?Q?sKppYLtq1ORX0LS00xZhQePzVI6q1omx9dAe8pJjgK9m+KtqAAg94S5vhYKy?=
 =?us-ascii?Q?bhwgFt459Rm8J+2YZNBzmRef7E7I2q/EjAV7nJ9riNQr7Duk7BOATSuQNWN9?=
 =?us-ascii?Q?vD+b6w1TzDFVrNA3C1QVMt6toL6a+5Fsg+LO2ZU+I5C2mpXxpt1SWj7aS/PB?=
 =?us-ascii?Q?0g8TvGyxqBx/FRx9/qcQmb4S5iElJAHpHfR3fKeLFGg58QZheCQujfQ9WqsC?=
 =?us-ascii?Q?mykwLOxkYDViIudF7DVA2UdTAMwvN9/ok6S2gVgU6dM1u16110X7WRWsmQya?=
 =?us-ascii?Q?/Ow7L9Fs2nposPqqGVkM1eZv08ZdSsES3KnURTEuXfPvpVAACtzk1acjRnZh?=
 =?us-ascii?Q?8N5yavuylOkl9r9NuZ5Fzn4DY0o+HPS0qasNl9dZOQ3LuUIRGjWCJ3hJ26e1?=
 =?us-ascii?Q?Zo+Uc+WnxAjFBchZ1bkm/yjJ7YW3dNOnQQhFP1PlTH3p/fh16ErlhFZghI4g?=
 =?us-ascii?Q?FIO7wSlhUes6We7mds2EgzuaUvRbhL5srxSGryhtjAfcJK6fwj7Onub2cG7K?=
 =?us-ascii?Q?MKgoBqNKqBRPPH5rUhZSEMjHxYNzTBAVJgJ5mO+tiepG+6j11SjcFz694PxW?=
 =?us-ascii?Q?oLzB8mnTKxiolIHZ1+1m3hGH0044s2kgq7fFs8hOi0RmjyIeD9VFanHD/BLU?=
 =?us-ascii?Q?2BWaqSdTLENIhOpPb3o9CiqVsDw3P2EuETcRHOHG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf71125-59a0-4349-d45c-08da7f4130a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:39.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az8rl9YUM+EnMd/LlqxwgvYVN/o0ZBe5dVbaTtVvZy3Bskqqmq8xNkOYFV5yupQ2DSFF3/ZJi//UbbX0Qs7cvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Liu <jason.hui.liu@nxp.com>

Paired with suspend, we can only init wdog again when it was active
and ping it once to avoid the watchdog timeout after it resumed.

Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Tested-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 51eaaf24bd8f..58508f69d933 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -136,13 +136,6 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
 	return ret;
 }
 
-static bool imx7ulp_wdt_is_enabled(void __iomem *base)
-{
-	u32 val = readl(base + WDOG_CS);
-
-	return val & WDOG_CS_EN;
-}
-
 static int imx7ulp_wdt_ping(struct watchdog_device *wdog)
 {
 	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
@@ -382,11 +375,11 @@ static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (imx7ulp_wdt_is_enabled(imx7ulp_wdt->base))
+	if (watchdog_active(&imx7ulp_wdt->wdd)) {
 		imx7ulp_wdt_init(imx7ulp_wdt, timeout);
-
-	if (watchdog_active(&imx7ulp_wdt->wdd))
 		imx7ulp_wdt_start(&imx7ulp_wdt->wdd);
+		imx7ulp_wdt_ping(&imx7ulp_wdt->wdd);
+	}
 
 	return 0;
 }
-- 
2.17.1

