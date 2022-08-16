Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61A5953BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiHPH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiHPH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:27:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45220387F07;
        Mon, 15 Aug 2022 21:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgIGOngJzYBwME1zH03m/Ccdg9S7XJXgHuU3gq5YI4sjQ5Aoo/N9/Es2NcoYvfkFOK0g+AkSxbO8zsLO4b1KzvpvBp69+8s9SsX+XhiBPmnaAvQWmrGniBg9YUIb4qw4+tB5mk0DOjjPdxfwij/FHII5qVAICQM8EJ+hcDIdfpaRpvwvA9wDXl25mULEp+9704vwvfLG+0wuD1GOL9VouZrfNGmTl/nc3sUTZLR1Y5sNB1y5+HpmY/8++tUueqXjJ6Rfai9En2JtTm2PmBe49jbIYuUndD1SZaZqsMBU2ZAGiz6nHmMtAdUC6ATxsZp8KQAeHp9BLUsAbv4H7c5yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGKj1rwSAlQl0PrpC19gH6L7Yx2EKBBTDjPaskBxWto=;
 b=Ft4nu5qhZklJC3C9jtPg/mpYibiqmp264QhTaWpzuz3Xm2dh6LTTJJRmr/kmrf7eGdUOEmWr/n6bIhZydZLbfFK3cSm6vW8zdaSsffoA5E9SVidvgSiuWn36dCYvZnzXE+kZTPyp8y3YD2EIh22+/4aEeGuiRwon8HbgRfGd5sFVJr+ef/nh+ErH3cwXZhSY+G7+7YzQUyBHvL439MPifEmPv8hIHWfKEH/CV8a5BMmNPB5i8nbNx2pEwuladxwZmXwcUXQ1n0J9YlNcnejW6eQMWNwQXFD6gTWlwaH9EPTPPrP97B2WCKOVa+OT85PJc0Bi3UX2mHWykARyAfm9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGKj1rwSAlQl0PrpC19gH6L7Yx2EKBBTDjPaskBxWto=;
 b=Z1wB1MPuPxgg/r3w91C85RbIN87DZILEfM//TIaaK/Sy01xyeYi5XO4e12YE45t+XmLSkclznYWWD4s1GgKKCejbu/JrKuTLUyaKYSBQB1Qkf5GZI+vfDP5B2H1eudIy4UdMxm4ialKlDgi7DhWK//S2tJTvUZBSGZaGMIt3vfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:28 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:28 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Date:   Tue, 16 Aug 2022 12:36:40 +0800
Message-Id: <20220816043643.26569-5-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b148172b-d1ba-4701-44c3-08da7f4129da
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSFAk7x5Z74+JMUG0Fqp1N1z8mcK/smbt5OCrsC+vpKV1CwS/It9l5BcfNOERN7jM+PplmR/AFt3PPJ/LqH5A1pSC2ltKNVSTCtT5av3VwCPi2kde3GeVjb1Nox1fkEDRqUEzO+0Ub3uHJdlgChqRAjlDRRJjkdQwoQnhB0/tnBWLaQs0Qxpe1WADC3EK83S3IOmgw9O+WLerLzMZtaAG0YVCUS21twZvzwYf3vg5ZiO/iwl7kw3s1claJmSXm+9m8MtOVjIOwH+54VN9Ska4GNgcgInG1ORkwrm+01pTiUkZdLPKcz2wDAiRBvgtZ06AcJMETAcQThcH4xT+DY6CVuSKXbPydo/Y4rO7oGnbQLKUs796nnyG1pSpr9nouvdVeiViyhV7yBMc3Vm24Cm3bOaeYQK37csS4onRqeKqbJ+GFIP38+ibx7WY800NwVNfWzWOeikib9QAbcHXoiPDbN4X/yudOW5//A4o1Om7ofYYXZuMbvkvuJOG9Bu1adcaPtd4P/q4nXca/J1u9v1aJbON/x4mgr3A77Fs1HOC+u4hPjvgqwJcJFEatxFtrrJzyMXODOeApHT4HXlaJm1KInVBUxTrHsQovH8HsGNAjvcCj06tgaDCIdXXDrA+tKaJV0kBhqDsV20lXU4MaWoxK3p/1sA60CCK6QYEonS8MYYJU0SDDiwDsxfv/eNT4R78E8PDL5PaNM+7OVfpq9RqMzAxcaRP3qfiorIIqSacGa8hzXHSC+gnqjHAZXfEbpirs6+jgwLUMOv5ezw6piGAC7huHY+oqqasPBTVC4hjHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztpp4C0Dm1GahN3Jf/56MGBx6oCqkJA9/i9rl3yV8fgM9c8p3ck+B0q/Yopr?=
 =?us-ascii?Q?LeRkT2/wQjtInh7+g1V2tebwEAlayQKDT0SThSnQ3yrCbzkE9UHYIhhbb8aj?=
 =?us-ascii?Q?Df48n6dMqAojvAwKFXtGUK6122cu1/XwIg11Ftl1Nr/1zOQghKSscyrAtXHh?=
 =?us-ascii?Q?aIUkKm15QJ8ERwdsCSdwuYx73b8qQ6lCvL7RynnvJeA1xZLKCaQD8qFl+Txd?=
 =?us-ascii?Q?2h3Q2qDYyp5lCtnXKwZEczsShq7l7BCBU9V34MhG9ouJ0TrrC6ghgfNQsJt3?=
 =?us-ascii?Q?E1awd0E93XapJJS/JU3eUumQqxlm2atDXc6m72IR4TTJWMZ69XPHNl143JMW?=
 =?us-ascii?Q?WK0Jda1/HR46q3FyM2SH9s/nLXS5+eJrmHn25KBBZtpaz0q6sgt3VKFOM58I?=
 =?us-ascii?Q?c8Oniic7BD07Jkrle/xM5xzNPAZbLRknZ3xFnjQqldXtq/k0Q6vUFX5xizvB?=
 =?us-ascii?Q?OCcT+RrCIEpRt8NNvF97jqAeA/68cp4xHw5d113Ep6zQPI2QiKLaK2vYl9Fn?=
 =?us-ascii?Q?9EtDtVWWuVtpjI6gynQJsrvmAGxb37C4iaP+alAUWaz9Te+YXrrYQTzN/OwD?=
 =?us-ascii?Q?MQrmhbdipNcCjf32psy49KE/ehm6EGFQXhdAJXcqWdf6BAVwCD++mQC0kKv+?=
 =?us-ascii?Q?bZF+4el7y6fKJKYsXsxG6hfu4ENiO+9iXdgNC+s4p8TQE0GBfzIAHXAZDQaE?=
 =?us-ascii?Q?Z1ioHdhqLWFVvVpxneNSblf0Fd2cSPq/il4Itll+LaSeX6zIgba+pNvCyn7m?=
 =?us-ascii?Q?JxLO/xbTPaN9S+vqBvl2vWrEODV2RIpJuxm/JcUC8olv24yR9j5JdQNECo+9?=
 =?us-ascii?Q?cZGc3TZNXX9Jerl8BlMP1zhw9gcyjP1FigxkkyINObmftc9rrxpGzSpeZkqS?=
 =?us-ascii?Q?pQyXn96ID6HXVXPHyS7dr7Lk6lT2D/a7lRyyytD7s/Wfd790RDesWAAVga1g?=
 =?us-ascii?Q?/bde60XEHDS9zJMitPSXPJEaIBuiY+4gZplvGQPNdXAbL8/mj+ND8QfyihYW?=
 =?us-ascii?Q?duNgWigGwNSyPKaBbW0ROidoA7QhWpyuzsbj3WNTfGraZlx4n6B6gdw1vGvi?=
 =?us-ascii?Q?QSXYtfmkjq00yKq8TtR60uvpwg7t/5GAHpwAQcicYrn63PR8W59SVq37IZki?=
 =?us-ascii?Q?Fx+CAXXLydH3EfAeeRSuVaec8X9S7O2kO0TxLnZ0KQCA0uDbXP2yu3rKnW6y?=
 =?us-ascii?Q?qYKeIdsad2tGGfAGxNK6UwzVABJeaNGEALsM9AKkK6yoTpuJVhvKxrqfHY4Q?=
 =?us-ascii?Q?A9wIfCYcv67GmT2z9zvIh2VN90vJXW0gdUtS90xRIQBQBvMMXbS53f/maZOd?=
 =?us-ascii?Q?LbueaQnoVeXCCb++Bhs8r3/rdJgKQpCLUyn2cEUQKH2Njd+d7MoTSqmLskCF?=
 =?us-ascii?Q?YmEjWmPBWak/s7o4m87reIR/UwrBwOkTSlRvQvQ3/f3kzYtKycSdr3o74T5C?=
 =?us-ascii?Q?CpZW8zvdGw2KQn1ma7/F7b6hlcQKoD3xuJPArwaH78Nb5PUu/t0zuI/SYQzD?=
 =?us-ascii?Q?S67N4cw+rwwyiJi+qrBS6JOozMFEP27XCJtuSa4D2a+DSzf9mk6Wz0ydZR6c?=
 =?us-ascii?Q?1Ic1gVQomgzzXRBFvfkzdcPLqZLHVW17MYtWYBTn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b148172b-d1ba-4701-44c3-08da7f4129da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:27.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8EZulMkZ3KAg1COZiki9IUsqbKyoFNF8uI2z7gZuk21YI8/XFrfLBrCvDdzgT9ib7LZ2a/RRAUGdwFoAyj27A==
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

From: Ye Li <ye.li@nxp.com>

According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
about 3400us and 6700us respectively. So current 20us timeout is
not enough. When reconfiguring is on-going, unlock and configure CS
will lead to unknown result.

Increase the wait timeout value to 10ms and check the return value
of RCS wait to fix the issue

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index a0f6b8cea78f..12715c248688 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -39,7 +39,7 @@
 #define DEFAULT_TIMEOUT	60
 #define MAX_TIMEOUT	128
 #define WDOG_CLOCK_RATE	1000
-#define WDOG_WAIT_TIMEOUT	20
+#define WDOG_WAIT_TIMEOUT	10000
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
@@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
 		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
 	else
 		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
-	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
 
 enable_out:
 	local_irq_enable();
@@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
 	if (ret)
 		goto timeout_out;
 	writel(val, wdt->base + WDOG_TOVAL);
-	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	if (ret)
+		goto timeout_out;
 
 	wdog->timeout = timeout;
 
-- 
2.17.1

