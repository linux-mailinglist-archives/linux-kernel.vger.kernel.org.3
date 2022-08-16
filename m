Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32B6595379
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiHPHJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiHPHJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:09:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D238A98F;
        Mon, 15 Aug 2022 21:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZoCCQJ7yiIdc4SzaWQ8+lraF51DmkbNfv2qwoca5ZtIEP5HXRJZvLmzhjEndDfNyCrgZNISMxGYWcIJQONDZij+G05Ffyad8MFtElIaVY2U8FPFSBbLIAMr6wCwSiJhbbKKmGlPLUBXO9LFDlwsaHNqK5dqY3C0b6Oi5jGeSh3MB/SOYvGX8Eo1d7lbUANN4prNCbn3Ztk34pKNmOiRFCxwFNd/weFsm+DRz6J6bhhyy64M9HmhDU8UtY8hDsXHNYHlCMS81SqELT7MCBG+QO2hYv+igCv6jc3DroNHok7LwX2My57MPfHCmR2NRiM2mMGJkp+qfIJvx5fbhiv9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bwa+IDV+1k34kBc/2efKKAgqy3sBdoQjBKkNiHtb3k=;
 b=BDr0Rr5wU4xoD/z7ABs4NMaXkY+gCo4oYzh/SOG0MahD+qjycwj3N+TYC041gfxnzbUk7TXHWurR563n6p011B0X/MI+1Ce3VBavyz0o1CT16A9+s7F+iD4ihwTWvQvCVR0o1FyYEx7zM1V53kBTo1o3ilwEX8wgx7KWRe8QMAOGUTqWx3/utdxiM530L0e1ZYB5LFuFTu1IcDNRBvTjtAqsskxOcHWjzycSNYMKCyrqZPrV1nX8DBYHOeHrsGxaqBkTYVEtSXqxAPkd3PjReOAFMVvxXIwQkSjiCmy2GOiklBe6xnB9Ttf4KzKY8qP/mFfKUKZg5DPLsxTr1vtzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bwa+IDV+1k34kBc/2efKKAgqy3sBdoQjBKkNiHtb3k=;
 b=W5htE8H3x3p8dHE9CoguMSbIELk3EXfkiMMQusJlTfvbhXurmo0LU7GfOBOC4n3dd6pu/5hcI04ouAwt9oXJcAn1aK8x8ThHeBAjDwE5HL0Kn4AXn+rFTudhCRBoIWXG0yKoC1kftScXBiXy+2YO7GSKUSSDV+xWFIcnbaAAypA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:43 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:43 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] watchdog: imx93: add watchdog timer on imx93
Date:   Tue, 16 Aug 2022 12:36:43 +0800
Message-Id: <20220816043643.26569-8-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4de274ab-0357-4cef-6cbb-08da7f413350
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlAubPDZ8ukH47IiNKMkSi2Cm2I3Ndi0gmRoZdaUcnquRM6YePTXXUfR1CwcRf038Ya6iSQ/RX45nuxKLYqrppqbwWjm7b7zJfbictgJF79tfa3BOWUXmOEEmiEzKAQBJvhHcagBSx1twL+0ieqkplmI5uwoBA3/Q0CdG5bT8Pw5t0wJjcJeolbO0Moqapx6QZU2WsiXesZV8PY+gri7Kym6iHGx8sOmpt0L+38vFwkofnS4EZ1g/XSbhNApp9In3fL9fvmhq6Cm1iaOyjqixLfcmQLIQP+PPuRqIqLOGBirIbq8+cRV4bQMGvwql95uLjLaogfJGmCcYCF1iBnQgGd5nYv956rDWLeBlnNbO5EspYWa3UMqLfNLam//1pWPByGYbr4nwcSLFLXaDa/CAysUCYrO1bMIZH3wqhYeNKSAOzygTZHBvyCBC8io0PcwOQyeLQZXozUHTYdVM4LkHlrpZnzdmp0QUIK+RjV46WUbFmkn/6fW298SY0s92rlM/Q6bKLQ2CxB1RDJJLMj2UP6i7A9CrqzHU7h/08sOBp3ThtIPFTjwfcYnQqzyxjSEmuSHY2JRZdRe6AaR5leLiDOc5aALRI7aNProtgaVT4vzVsiZfzsqnl//0546YhtiwwqFQeYnu8zvZ47Wzq4OIbjXWO4WtgSytpROZs5uJR2qGX2QXdPkK9T1qgQBBZjC0UTKAoAMVUCMAgtHyxPNRi3tGiJSxiTNfRthWwHhX81lwbVYjl/dQ51Iuc54AD6kYQ2nfjbBGyRY7zh4jfxg05RctzGeZ8Nr0uNyHACniNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1WZ8/oFu5ClsEDGmYXW9EpL+xz+lXH1qgzTtE0+mOs9a+y4EKBU+ldwIj6T?=
 =?us-ascii?Q?XkxHuWaQJbP28QY65dfHw6e2LDu9TCRowg4vkRtQOtqrwE+1uIHZaz6PafCh?=
 =?us-ascii?Q?kE2lkt6f/5hJVa329Tnmf1u1E9ydCGBQAJ324HCa1fKFw+wRIOI/1A7FNNsu?=
 =?us-ascii?Q?jwBpIP7dI2VqpDVSS48V5vsENq77uOPtLdrO1QAbGjyrO+cksPqNiqE8gBjX?=
 =?us-ascii?Q?RN46JNYrFheaXI7ngtTepVSK3HTunfj5Ya94vS3XvtxuDmIdo3ufuS+g15tl?=
 =?us-ascii?Q?Q5J7TcXOWexRKiP5dWZQ5jHiBTS/dMscGbFfVToVC2A2uPf1koLv7bTVrN9h?=
 =?us-ascii?Q?xgNJIy2TSKCPNzSgfkqogHRyBkMu4v8mJalM80AWvjAit82BL6ywudx5IQRJ?=
 =?us-ascii?Q?Z6Y/XiDP7xMknbdCCajBoUmEYFB0nOO2Wk42980oyf5T6DsOX5CRF1jtoQgZ?=
 =?us-ascii?Q?reAjGPA9k7wK3PDmR5MbzgQnasAcIMW4GxQhXOK8J8k8d4hNjYi3I2rh9e61?=
 =?us-ascii?Q?KpZlOREsOSynaWYomcuqaFW8NWM3zG/40DLvWH2TO8BuZ52h2JHTjH1nNIQi?=
 =?us-ascii?Q?R5ysLyE+zpddVUJfWAgAkP7tSV6OfqRrXgfr0jjx1R2QM8vtnvrJQPaf+x0l?=
 =?us-ascii?Q?R4Ggaq5AAuHy6IhDA7FZgsh1ynVHzkspjOKydKbktEakH1wYNS/TjVLrnDlR?=
 =?us-ascii?Q?xt7RHkLntR/7oVUg3BN69ZMHbUEsh0WSjDcWzazd6/qS5Q4cZ98/hSooV19g?=
 =?us-ascii?Q?I+yT4+OEGWF574VK+/LskgectqJxHh8i8qQNuFA/bp1peLlqdWVQzFNZPbmb?=
 =?us-ascii?Q?OR8odiCP8eXbSphLvM0CFAbNCaH8vbFYWi7bHqCpjJuJIEzc5Dzb3LuwVAbp?=
 =?us-ascii?Q?PeE7m8pexMdupt+JJC3w+cvXsBtkTtqE6kHIMMyUqVtn4kmPGGYtlWZxfL4r?=
 =?us-ascii?Q?pze5Htr/+OCa9vOWSqHZs68TtqKVdvjw7q8k4v3o/FtZQEk5IMckiTZGyCqX?=
 =?us-ascii?Q?jtnTRN8h309uG6wo4lTUftZvHFlI1VYO0phcTqWyfZDtrRIA95MRPZ1c+nX3?=
 =?us-ascii?Q?TgG4I7pTRPy0iIqnLhPnquVl5eyXa6p4Z1kchq/b1LUhW8ZDRQvjt8NrU4wq?=
 =?us-ascii?Q?SOrg/o8dzfmwMrAyM5qXs7m7/ZJnRbwFKosyFE37MnpuGn3rtSRGL6yjHsuf?=
 =?us-ascii?Q?pGt9RO6OrEMNORVHhRmWP3AbPsibGYdlCqz/1QHSQC0fAy749eNsQCjm+Dyq?=
 =?us-ascii?Q?5412b01N+jvS+MnaQr/3cCyZ4udKNidyh/QaxwS6P8dqCb22DdeW5b6D4UG8?=
 =?us-ascii?Q?lA8Le3MW76b5FoUFWe9/onhOGg6K3A9g/oHxF9n53wUb9ODGJEhz+6LGnlja?=
 =?us-ascii?Q?udsFO4gd7+8MgiL4/koRIJALHawRfZGg/cpRgv9UNjkDW6lTFwJJbfXX1uQX?=
 =?us-ascii?Q?uAFBiOLFjoa5xuRtAvf/NHGtndj2ESU+nk3qK3CHV5aIXQQSsUKJ2VyqOQO6?=
 =?us-ascii?Q?Yt+r1VDHT+V3MmBvUucTz+Nz92h/xS0IYzg48xBG2s4Z2UkWsUzFMULY1uIQ?=
 =?us-ascii?Q?2lJEK+PPyCdIBg9d+iPCNCY2uYA1ilcRZJSTN5Vz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de274ab-0357-4cef-6cbb-08da7f413350
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:43.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYmG6bZed++TSUnF70LDAIU3+FENLk/bMLzDR1ueH8GVPol/WnYqunSJtoUTDA3lVvSVhxRLTyWOzdcup1KlzQ==
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

From: Alice Guo <alice.guo@nxp.com>

The WDOG clocks are sourced from lpo_clk, and lpo_clk is the fixed
32KHz. TOVAL contains the 16-bit value used to set the timeout period of
the watchdog. When the timeout period exceeds 2 seconds, the value
written to the TOVAL register is larger than 16-bit can represent.
Enabling watchdog prescaler can solve this problem.

Two points need to be aware of:
1. watchdog prescaler enables a fixed 256 pre-scaling of watchdog
counter reference clock
2. reconfiguration takes about 55ms on imx93

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 58508f69d933..4694aa4b8cfb 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
@@ -52,11 +53,17 @@ module_param(nowayout, bool, 0000);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+struct imx_wdt_hw_feature {
+	bool prescaler_enable;
+	u32 wdog_clock_rate;
+};
+
 struct imx7ulp_wdt_device {
 	struct watchdog_device wdd;
 	void __iomem *base;
 	struct clk *clk;
 	bool post_rcs_wait;
+	const struct imx_wdt_hw_feature *hw;
 };
 
 static int imx7ulp_wdt_wait_ulk(void __iomem *base)
@@ -179,7 +186,7 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
 				   unsigned int timeout)
 {
 	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
-	u32 toval = WDOG_CLOCK_RATE * timeout;
+	u32 toval = wdt->hw->wdog_clock_rate * timeout;
 	u32 val;
 	int ret;
 	u32 loop = RETRY_MAX;
@@ -276,6 +283,9 @@ static int imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout
 	int ret;
 	u32 loop = RETRY_MAX;
 
+	if (wdt->hw->prescaler_enable)
+		val |= WDOG_CS_PRES;
+
 	do {
 		ret = _imx7ulp_wdt_init(wdt, timeout, val);
 		toval = readl(wdt->base + WDOG_TOVAL);
@@ -346,7 +356,9 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(wdog);
 	watchdog_stop_on_unregister(wdog);
 	watchdog_set_drvdata(wdog, imx7ulp_wdt);
-	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * WDOG_CLOCK_RATE);
+
+	imx7ulp_wdt->hw = of_device_get_match_data(dev);
+	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * imx7ulp_wdt->hw->wdog_clock_rate);
 	if (ret)
 		return ret;
 
@@ -368,7 +380,7 @@ static int __maybe_unused imx7ulp_wdt_suspend_noirq(struct device *dev)
 static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
 {
 	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
-	u32 timeout = imx7ulp_wdt->wdd.timeout * WDOG_CLOCK_RATE;
+	u32 timeout = imx7ulp_wdt->wdd.timeout * imx7ulp_wdt->hw->wdog_clock_rate;
 	int ret;
 
 	ret = clk_prepare_enable(imx7ulp_wdt->clk);
@@ -389,9 +401,20 @@ static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
 				      imx7ulp_wdt_resume_noirq)
 };
 
+static const struct imx_wdt_hw_feature imx7ulp_wdt_hw = {
+	.prescaler_enable = false,
+	.wdog_clock_rate = 1000,
+};
+
+static const struct imx_wdt_hw_feature imx93_wdt_hw = {
+	.prescaler_enable = true,
+	.wdog_clock_rate = 125,
+};
+
 static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
-	{ .compatible = "fsl,imx8ulp-wdt", },
-	{ .compatible = "fsl,imx7ulp-wdt", },
+	{ .compatible = "fsl,imx8ulp-wdt", .data = &imx7ulp_wdt_hw, },
+	{ .compatible = "fsl,imx7ulp-wdt", .data = &imx7ulp_wdt_hw, },
+	{ .compatible = "fsl,imx93-wdt", .data = &imx93_wdt_hw, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx7ulp_wdt_dt_ids);
-- 
2.17.1

