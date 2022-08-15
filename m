Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB956592829
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHODfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHODfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:35:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C913EBF;
        Sun, 14 Aug 2022 20:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg3ccS5ZaJX2Aub/3ZT5htwHr9Vc9GRs2/ysruuedkww/MSWUywCuXbIlcix7H65WJkUU5OLdMl5RygHLJpzYHa+VJxcTb5jwV075awoChKcVIdFfcHI2s7C7QvNNaecbhNWo92Ej1L0bHSigYMN9Z+WHHJRqR47uZWNdajfLyiH9o1n+yFNtSrEONy8arumuyizQ/L059ZUrcxAZI8H52FxH0J84ynX56jfMIeRJJkDG2hqv8wId7nTGfDQBMXXjjTDeS9fw9woNwlVDAJRaS5MbODZM5+qS2WI+SS/peE1+q1woTDjzaG1CLxMvi5mbntsjAh0108H/sz6lcE09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SShr/A1KzZVZQQJJDM4D7iGB5IZ5mv1RAAD/noK+hY=;
 b=LRspXWoTfCQrbfUyL/uMUgavDVyBDvCnk8kvt0tygBk5FFnZNq7vfI5lKffKH8vpcdwmO49ovS6wYwLvkOVEZdnGa1gUPckRMXdudZ0Ptum9yJ9XR0GYolVmT3oXLeu/lx3kcf1GL4DyzJLkuHv8V6ZsRna/7EcgxA2F16oKIjkJzqfbN0aun9QGDnL8BZoYHAxaqpjswXIpvs2L1YLjVOYx4TBJHTGa7EKXmQ8a/vhmraJk4i5KI1kLrJJHWwIBS+cS90hrSBMNV8xfgwGpja7khU3YM4XwGmFGfb9TRHs8t0h3BG2AIGeN5P7yfH8JLILiVgLM5yPs5NcSSc60aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SShr/A1KzZVZQQJJDM4D7iGB5IZ5mv1RAAD/noK+hY=;
 b=jGieG4r6coH+XwnRxUrWdPsezXv5f+PEb3uUURyezw4ad0sy8hM0NX1oiIoeq5zj0D/own96R5lNFW7PxUyh+mZZaQEDr0ADu/yXfdjiN1CD8HU3vyrcBkmGgUE1iJ3HIuUCtH3aLSlQFvdAB+3bIJohKKry5iXtPyBbe4fB7us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 03:35:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 03:35:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx: support fsl,protected-clocks
Date:   Mon, 15 Aug 2022 11:36:32 +0800
Message-Id: <20220815033632.1687854-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 078589c4-ea7f-4b5f-df94-08da7e6f255e
X-MS-TrafficTypeDiagnostic: DBAPR04MB7480:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Via2pEfetorEPFcrrgJUfgjVnwlp00Ol+7GVfGOFZS0+zvSOsknpRzDR3BQA87ntlhoXfZIrY0gOGn0pxipuKhO42MWjPsVstoZz52emdIzU8XEZ3zg6G9zzJGKeg2JtgA1RHyBn7+msMZQcr7jVP2PBNhsH7ozx4GzGkzWhnwFdTeIhzHrRadvMaX/f+T3tlzC7IYaTh/ppmo2FOV0QfLWau8M6SdNEy0Rh+MXenxIfZaqK3GfUKDettx4bgR1NZH/QrKwFn+xGREd49o7utZpEg+9WNn42vbiE32NayAXJhGxVo/ER3rfHeQnEJsIQCQmPk2qmUQPr17+O+ZzeEsGIiyx5HXxYVuhuT/KvkPvWp4wZO6OdDp64NHEr9aPEYVK+s5SPxmZDvb/gVzP7M5nwWVDEWzFO6jjb5KpBH/MBvvEg57ruDZCwdi/O6lHbnH0NKl5GD+cSY5M+VLNQHgLrjY18v6f2UjG4alDIBDQ0CqvC6lJVSnJojsgb6WS4I0/VxcNfg3zbs34wKvY0A9KansHA0amB8S1WMOtynVBMQ2u/s3SHSGHBRK9pvV9udLlbWcAjaTIoODpB7mnbDkcbZ67XN11XsM3cSY9S/A43ZTXUIgJGE+rB/t4xFBq8fr8QHtB8Nc4VlYfgzj/mpZME/Kb5CgWv6X5+NbAo2QFtxtDjo+G6Gp7cH7IBTDhhxbhbYv3Ge5AhxsDGYtyAbYc6dSiI7T78BEqQfNvTZsDIlGGBYi+Htt6ydH2pkm3ncismVGM4Copt0eVxpsU3RdFgAQLIM6MiZVvIEtNI7eDNZ23AEluefZBo1y8fYNLPq0ID5gcO0rpEBDHaXbLiBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(52116002)(26005)(6666004)(6512007)(6506007)(316002)(86362001)(6486002)(478600001)(186003)(41300700001)(2616005)(921005)(38350700002)(38100700002)(83380400001)(1076003)(8936002)(7416002)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4qwY66YuTQ3M8gy44HU5CjiWpGu/lXVamG5aTWws4FCxsacqCqYOudTDphK?=
 =?us-ascii?Q?q4cV8lvxFbKFUw9swf5VDARmixZTuo9qNCq0c9glLaowlu0vMoEKeD/ajzAt?=
 =?us-ascii?Q?gibgKoEgBpodZhxvslKBkQEQUHFATzuKlH/jmRAk4oDcTKwjY/ww8+iee9Qe?=
 =?us-ascii?Q?rK05uhdHyMA9LHrEZvodn4YtxMyWkoSB3YEwDyF2FK0HtxwUuLdau2mjQyT8?=
 =?us-ascii?Q?EYl5t4PQXu6n4zBncGWMjx+jnB2q6fs3h+g2UsSHZwOcmalQfQdAxhdfhpVY?=
 =?us-ascii?Q?SJo9ElSpfO1/T7UJDUHWvWyza3pbDvquBxRP3R3ZtlJLtBltC9YsV8VP7T6a?=
 =?us-ascii?Q?THG8d8LNoe6TvOCsLw4nRsjUQ9JRZWYG2wARs+jIceOcOBCcIueRO8TtgJfS?=
 =?us-ascii?Q?7RScAvh18BU6enEktD+dM8oyvMWpUUL/ig/jVUD9/a2wLy0Ab/p/6ynsvS1A?=
 =?us-ascii?Q?l/IvEeA/1cl/RgOUkkKKbjKKcpCGrHHGmlqp1JhrSWlr668b37iTx5fuiW9e?=
 =?us-ascii?Q?42ijYSHdosFVuP3BoqAB3VROeDmDaj6JHU34ZgPvGIeGklcrcFOCrK0s5wGp?=
 =?us-ascii?Q?NDSMsI1g2wMpt6aMfFaw0nZaKtlyCmchqz3KfC/knCUw3W8vIsQnRU44vO/m?=
 =?us-ascii?Q?YtWBUAifqc+ktcd1of1MFHDs3/nI5JJgboiLI+cQtPwSRV9Djdjaz/aT/Aj/?=
 =?us-ascii?Q?cYRS2wJEYC8p3BI+Rl2rEymVOvQGbkW69/5iq+IkS7Nekre0J51OlaNWRGlx?=
 =?us-ascii?Q?71BCMJcm9duTAIU9s57ty1vAwref/k1vaCClM5DXrqMpHXk0EePeGev3gMmB?=
 =?us-ascii?Q?VvvE2FTV0KQr4UF2QJZbj9LeYHsK2FCGZJfieK9yZvgkQsnrlamLs2asB0Ax?=
 =?us-ascii?Q?fMI/z9QZ9Flmk4mCQOH5lX89Z4ZU5y41WstMsGJctOgk2p1k6vr0ITgfxsI8?=
 =?us-ascii?Q?DRgSjbYzVYMFVUZruj/uEoOUwc8frMzeFzR0q4h10Qg5XUHGvF+ZhztA+D3H?=
 =?us-ascii?Q?KNPdanbavWXn3qmgZufmWcj6LB7N5YzpzFMsbqOZIEkmnVf1tvmtgtlZDV2p?=
 =?us-ascii?Q?aB6Put3LJQqb+iIY5zXChKCDCHqNz2RmeB0WMxHRGPnK/u9F+STMcbF3WRZf?=
 =?us-ascii?Q?F/qFrNbDCzMgX/33LiUswcxxRfDgm3VxFyQh6L0iCF7++dianmFfzQqOuLkY?=
 =?us-ascii?Q?oYdMRbrbZPB6AiDa8396zqazqsO4b8Ln1lT9qp35YBa00gLBCDqkJQ45APGh?=
 =?us-ascii?Q?yiP7KtSjGiPIp5Ml/I8z/NJY4VQwaN5Tsz4Y0vrtA60kyCE4SOTigfhJOWPw?=
 =?us-ascii?Q?W30hEOUiHPrujjNWTy+yUbC9X8YdA6sZnpt6yn0gSapWJwV5ECuw0kb/tI62?=
 =?us-ascii?Q?NS2WbUImJsEEwcK7HdLK+jzPfkpDNIeSy5x6axPw0wW0Ui31dA8aBRi8bm8i?=
 =?us-ascii?Q?C0OjqiLmG5OIFQAJFQbujYkPvvrZAeFivqfhIcLZSVQgnQkLEM+YixYlEDEL?=
 =?us-ascii?Q?LHR8SNWkdj6uNULSXP9zRIRYaROKLB10frWwlL7TDkPNZDbYr13R82w6VIO0?=
 =?us-ascii?Q?RzLxb+Nid6j04JPMHWfeW/4F4e7AGNXWuEhhvPLd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078589c4-ea7f-4b5f-df94-08da7e6f255e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 03:35:06.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py4IPEsWy1hRoAHSN4Q3bfSBJgX6KKHyPufpEs0JlXpT5otzdehXjkAgHOnI4sf9U4Uv2H47dJyBTWUOkQX4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For the clocks listed in fsl,protected-clocks, enable them to avoid
Linux disable them. This will benifit root Linux and inmate cell run
on top of Jailhouse hypervisor, and benifit AMP case.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c |  2 ++
 drivers/clk/imx/clk-imx8mn.c |  2 ++
 drivers/clk/imx/clk-imx8mp.c |  2 ++
 drivers/clk/imx/clk-imx8mq.c |  2 ++
 drivers/clk/imx/clk.c        | 21 +++++++++++++++++++++
 drivers/clk/imx/clk.h        |  2 ++
 6 files changed, 31 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b6d275855b36..24ddb1620bce 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -611,6 +611,8 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index d37c45b676ab..57c486317d28 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -604,6 +604,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 652ae58c2735..a95862cc04a4 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -713,6 +713,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 882dcad4817d..2868e2390667 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -603,6 +603,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 5582f18dd632..307da8bd5243 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -2,6 +2,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -214,4 +215,24 @@ static int __init imx_clk_disable_uart(void)
 late_initcall_sync(imx_clk_disable_uart);
 #endif
 
+int imx_clk_protect(struct device *dev, struct clk_hw * const clks[])
+{
+	struct device_node *np = dev->of_node;
+	struct property *prop;
+	const __be32 *p;
+	u32 i;
+	int ret;
+
+	of_property_for_each_u32(np, "fsl,protected-clocks", prop, p, i) {
+		ret = clk_prepare_enable(clks[i]->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable %s\n", clk_hw_get_name(clks[i]));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_clk_protect);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index dd49f90110e8..3f8099190b99 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -22,6 +22,8 @@ void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
 void imx_unregister_clocks(struct clk *clks[], unsigned int count);
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
 
+int imx_clk_protect(struct device *dev, struct clk_hw * const clks[]);
+
 extern void imx_cscmr1_fixup(u32 *val);
 
 enum imx_pllv1_type {
-- 
2.37.1

