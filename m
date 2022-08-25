Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142985A0B98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiHYId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiHYId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:28 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938ACA6C13;
        Thu, 25 Aug 2022 01:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6a3lMv+34TAqTqUnQkcZaA6px6hRhDhHImEHqDez8t//eKbnTxluLwlWsyN849DwNvj1VzApg0pgYJrIl+z9yeWFk5PPV2U6uR63G9g2UfKYL4qJc3zd5N8Moe22zM2DSYMzoQNg/YiiK/UE+Gjvdz0Ne6Gol8c3mkoLD23voeasJrAHqkuigKXuQ9pG9uksU/e0drckdrzdoeqKWtFoFj3uKqmb3eEaC2uODTdG8AahsGkVo3istya5taoHzOYZe5VvtAxUOOV+m+7Kd0vOTqgfaQyov1L+4cRM1a5erg142z4JGoEohw2u6zfqAyjblcIdv7A0k3C4eKSWXvY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QklsSL7Q/a1bjgg5pmMLTYcBv4jx4AqzDyYnHrZv47k=;
 b=BZPX1vszgbtRtUPHJMJDBrPbgjmT/UpNGyXxlILCha+IDsi858GiekfQdL0m1cZ3D66vp0u4aNPNrnyW/NEev/p9ABC/qMpkad3F5EI8RZNOlONvfurIUMoZkSbkgjcOnIRTylnhiIzRMrM+gzgLP5/ilbNJ/9DYu4IGBCJVrH8bvSMdIRXMJfv7PTV7dR0u7gMyY3VgdKejAfbSyKCD8t/KcFmB5DQUidhitwDv+OxUHCQLrgdL7vL0NFU622HV77AJROaQ/SuGs5+lo4SIj9tfHvZRX094jLzG9uyvXXgjgLML3FnJgfcrxcTUxKcucnggzKJ/YakgjW0lH8RQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QklsSL7Q/a1bjgg5pmMLTYcBv4jx4AqzDyYnHrZv47k=;
 b=FCoxUuSGCoyE9LxHwKSfTzM3Cw5wjOkdmU6gzIiXQfpld4ESlVbIAg+U/DsYF9oSXh3yvtb3MdnrKndAKgug6O0WBWcNYZwH9sATFMMdaIQ+mLxVHW5udX/DpCmeKn4cxovACJHWwnzSMTVi/Rj6u1Pi3dg6AWGkZgPQcv429Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:33:19 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:33:19 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] watchdog: imx93: add watchdog timer on imx93
Date:   Thu, 25 Aug 2022 16:32:56 +0800
Message-Id: <20220825083256.14565-8-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825083256.14565-1-alice.guo@oss.nxp.com>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9b47b1-f15c-4331-21cc-08da8674768d
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRj5g0uYW1I7KAYimzjp+lxSQt19GRRky5Aq5i0UXP+nZeBR755twcnVGHA8lQgXnHV0WK+J1Ty4MF71H0mi186C3FlW/Gdec3gjqnEWtFzr8pS3kvpYT6+TMOZUUaVqkUEs1VDTUOiFikZAsU7Umr+RVNc3Wr+C5i9XVT6Is1Qs6NjyyBkxV6HKPb+Jd9OqAtb1ORUv6Ua2iyXb+iFAc9ef36Sby4PXTR3SSEjShng4VLBjSP1WHiFRxSe0rlbJvAbE0Hp8D/4ixnWr40p7mDariDnpWcnlACZMoxchLNzjkniggjU2LBFFgRqg272RVQbvqCPI77zWvJRxZyuA0q0M5MPOCKUemibdC63pTJDWFhP0zbSSlBvzGxVCHjnSjzO7lAW02d8VM/B06NSY5EemMZPou9ZnvaIAgUWpbVucjhynRvYrIJjnCGGU3ZiGKXhaWxfUkN3EtuPSQ15UdmY8slwB8iqDYnqqvB6YgykBJMMUNBrF1BceTejPXnbrlnzjY07+J79Sm8Q5+R0B6Xp2Sen+1WK3TobzTwwwOFiOMhfauB8giWI/dmJ0dzwr5hQYxO7YSi8LNHOly+nO8E2MXkxOvtmwR6bmqYTxtwd9N5O9U/ssfdAvPc/WaksALOB7RNM4N/fwOTq6hibKU1WH+DMbKWEIrYfDZV6LTgy9TtfU87n2iGtr+6NUd05OuoUkwS9V7oeFp1a2+Xt9+fh4LDhegtx+SgxFdWTrPvrsKI0h9KWhvLivQ+2Uy1VEJ+h8TR0NaATP8fPKQvre9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjYAKLRaBOWB1TzhANf6IrpXrtQl2/6+/6KY7XzHH87RKN6bpDfZ4DtkOfqh?=
 =?us-ascii?Q?uVrbADr87B/DhCeDIJqof0pPhIr7hkN7JgmETTk5n7NVTlLinIzvmTIqVaF+?=
 =?us-ascii?Q?713QKs/bc40dCZ6MIOkC1InXtIfy5Cqe2hNvRpMeMAg0mB7VfYYPRb+p6bDs?=
 =?us-ascii?Q?CG4nyOdY6JNOA2Fhn8eQtF07yNjBsp2jgqVQ8Wm6a0b5wikBFIey4O4faDjA?=
 =?us-ascii?Q?5bXzwtj6fP7HgZvabWJASFjgJ7DDw0vaelSubgigZl7wajki+kdH9lBasZ+M?=
 =?us-ascii?Q?ToEQDC4Bbyp/6vZlQaIkfh8eu3c1eBoM6+Ee6KkiE87RgXSAy/ZYtctdMXCT?=
 =?us-ascii?Q?UNPW+7/xyHAjCJUMtEoG+Jg3jU1eLQydE9WRdBAwPU9HUIztLV4/ArmKVeAH?=
 =?us-ascii?Q?xmkHChOuQr15LrKS+NVxrcc9c3iUtn8nSRZ0TSAzccITDLaE9pHc8KmE7uGq?=
 =?us-ascii?Q?n76Io7cB9xfnUnqJkbN4xBMrfGhU4wYdgJDXcsGvlTUkF+HBwh2dcpGIOKSM?=
 =?us-ascii?Q?oA8ZLSju6sJAZCtIxsxveAJdRoVFZdKdL7r9jCJglVvF3AGZ1g6rHWK1+Hrn?=
 =?us-ascii?Q?DFkh2ZmsI3FDlFVEsBz0rv6pL1eppsbjAyK8QuP+A9ppHiX0YyjV1GlfEugm?=
 =?us-ascii?Q?hfUZJgaxd8N7P3VIBrZhYCUYsExzl19c1dXn6SGqblb0gQ1nBsBNSV9Pg6rs?=
 =?us-ascii?Q?Q3KdbrBUeVcYyIqCkPXUluGLEVjtB2im1clrLdgDS4ggaa/DT2+8ZTqZ6rcN?=
 =?us-ascii?Q?/p79Fgb274g5Htpvc7wE71O8yAxQ2E+j0aH0ZlpjC+cGsjhyIULhZRCG7bxr?=
 =?us-ascii?Q?R7ZxMHE+qC09qOXUI1Pi18CA9muDTkdM3YDquWVFuz2hKwqS4MV74vQLvi6H?=
 =?us-ascii?Q?0MniCiDxV51V1KJ3QvqrFuNtjql7kp/WHtsmFLdXm3Z5aFHuZS+2CURRw1tO?=
 =?us-ascii?Q?11QbqPBRXpyw3UKMtR+RJeAmyuUm3o/GoeUU8WKz13tmRn/lEiBUOZnKlQzw?=
 =?us-ascii?Q?gt78zETwqZ7DZbdUwDsFymvwvbv1PG0LUrFf7MK9KGtDfthYJ3iwJ6A+hkpC?=
 =?us-ascii?Q?84hKHSnwTRK5+BXcJ6cENps7MVlqrwzLyEnsFs5dIE9+o3M8Vt53F+cI/643?=
 =?us-ascii?Q?+X6S3EE4x2BtBjAEkp9PomCpm8NThJo38jrO9FzprpTN4YTIs3LBkO6Yd25Q?=
 =?us-ascii?Q?quPuJef/tI15GphutfOIR4u2ziDUPNXsCVYql6ejrQjXXzsmT4SNfQLZk3CU?=
 =?us-ascii?Q?9lXSRVjDBzy3riBKXxkGX5ukYenwpQiDlgy16ZQP3Ej6y7pWM2oxY81MSh2H?=
 =?us-ascii?Q?UwqvsD4jIQ7kGhA71VwR/WqAc8OuniLfiAAkIl0mSxFVezOAx5PXzrSe027X?=
 =?us-ascii?Q?XrdcQttDV5YcL5mFGM221QYF1espTTj3umvie2BKErJ8LzXoH5pE+cnki1yV?=
 =?us-ascii?Q?T2qFFdZUTYMCW0rUpuunXpRtG0NP+2ydS3HuQ7FriRACb9XgfEF2w3KtBtzZ?=
 =?us-ascii?Q?giZR7Ye9/Urcty0nAC79ZQkb2B/fn3JbYLYFOMMnPdeitGH8RZT7P1Q+gIC3?=
 =?us-ascii?Q?bHphgFBkA7xrn0iUL5IesWOEV0i3Md1NxnQhnbsg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9b47b1-f15c-4331-21cc-08da8674768d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:33:19.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpKNS1Ka8ywxzME9UqKXavvybaZwRmt4h4BYhRKq+vs8OS/A80eVXtPc5SsnUeqax1e/6HEHmEWhP9RP99+5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes for v2:
 - none

 drivers/watchdog/imx7ulp_wdt.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index dee02c2a52c9..2897902090b3 100644
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

