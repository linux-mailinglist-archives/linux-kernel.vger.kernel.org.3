Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D205897A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiHDGKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbiHDGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:10:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3A61115;
        Wed,  3 Aug 2022 23:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me2k1ch32RZaKOLNJveWl8CKKfC8oTyk79KDZESirGWB7SuKCN8RQ01VbZ5ta2XuudXqlmrwdJWXsbRitcaLPZvzHaX7XROIMoBSDtDFh0ZsCn8n2/10ZsNoV06XZXv9pry2x/8BXehhs6beIzhwGb9yEVHtn2KXds6tz5mBmFdPQvTMtzlUl94YeKvB+qLjOPNxqPJJscdr3elwvY8nPfQgA4TF+b1phixpsYah1dVB9czJskz3kksmNzbPGkGxJ4/vshw6LSDLfoOMIBpUjUPW38jTkotJ0a6jyMJQu6mxGi+B/eRRwziDVqzakgniJIswBi6Azpa8wRndOvH3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cXqdukLYvoD3PoaWKWqCpzRfL7yL/1jbZuERYXh5bw=;
 b=gycatOg+MLkzk8V0n/5ehXA9/K1WV6MrFDWlbg8bVDTIkgaMizWw3SF9EjD2SlsZ8bBJ7CADb0KnrobUFlSoDvNGUmodylta5uFk2TdlfixMJXz9PRH4IMWbX37caSsYfsGasJyX2wx92I+gNBb4olKV8f74TB78vBYlhPMA0+ECNu7uSlPW9LqJEt619OQfJtWTyIFUlgphsH9Xpq6QNLM9XU78HiL95zDXsldJRUV3mSl1hCRuQux2WdFPYqmh2VM8LclCktaPvu/eiPYakC+9D2Z66RdRFtHSFMrfUXJfsDvLJvnRqLI4NZBvlz/hhhPmU9xBgy8IKtlTfGkRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cXqdukLYvoD3PoaWKWqCpzRfL7yL/1jbZuERYXh5bw=;
 b=Y8/PgO7QxOaa/9ReK8soO2OiZTJVcmLUnQbn6EKHGWkERZoXq8jdhPC6GTrW8CZ3zx2t7aevxEYuOQAS7KgJAOjVsBHUozKKSdOd3NPK3hRr2h523VxM2qzyQ1LW51TxDG1bTJ89D8fLfH42M8X7I0Khi0f24UjcLQCQMpgDWgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 06:10:07 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 06:10:07 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v3 2/3] drivers: bus: simple-pm-bus: Use clocks
Date:   Thu,  4 Aug 2022 14:11:32 +0800
Message-Id: <20220804061133.4110734-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804061133.4110734-1-victor.liu@nxp.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ace029-2bb3-4fea-c75a-08da75dffaa7
X-MS-TrafficTypeDiagnostic: DBBPR04MB7721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQNFc08hLbJd6q4bLCGz1HMCkcGcpveY0TgVykX1Y2uvLpkN1cpKphfSQcZ3gtAve4JtaGDrLyxgidMUo0EWzUv3b5yOpELAb0g66e+Bj1vDBS4gBzPlhJ/rqo40xiAnasnURNrOcxO+U1Kw3MHf8L82SqtO+Ahiv/9fGunO9OH0el0W0hOJnz5bcCEYyiCgy/qAzXANpkl7begxw3trlMC7duRsI3pvU/hfn6MPDFeeJHqbkORH+h26k3qDpma/dVP4eYpu7XcxnMgI2XLYPDjAj+6BrgE74Uup9RuiN/H1YVVY2QbIigM+rHNklSNeh3NgqJsb8KJCJqrhGL2vlibOLpL9trN5tnsFAy9/i4d74NIdl2r4fsQlvxuxz9TI9ficpoggNLsYKDC6E7xXJDRbEMYWaU7AaG3qJfSSieU7HP1YDVtWclFcpvY/yGxmOt+Ur/OROX4cKGQTXtZuah7SeeZ+mBN2CF5ig5zXj3KI09KtMkOi8nwXqMHRYzTDYSPi5Iy7wPb2HPohd3P6I+/7bdBpIdWs05JHnDuoImYgbSwv5R/eRe65aCVvSUOIolA3ueS4LZu458CRkkDksZ6IowdDIHl1btU34Amp2sF1DrYyC2Er2XYlaHLmGrZGERD6x79w46e9NjFtNhksv7WaafBx1jFxxv0H9NCmbWJ+I32+DMEi1Xms8CmE38kwMZtUraeG6ZsidQRoW6o1/774ynVrgCCfzc0HQNTGvOpaCGWx31gA6Oa7ddReZ2dVfvZLr25GLb8i+DCEHPqfI2+bZX19oZw0pEUj3Y0/CS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(52116002)(6506007)(41300700001)(2906002)(6666004)(2616005)(26005)(86362001)(6512007)(1076003)(38100700002)(186003)(83380400001)(38350700002)(36756003)(5660300002)(7416002)(66946007)(6486002)(478600001)(4326008)(66556008)(66476007)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHMcGbyzp/30edO0iwHPvlxdzn7l/cTOEwX9K3IBuF5itPZP3NTGBp3vdP/e?=
 =?us-ascii?Q?JcIIJWWWZUNW4aT1plst08vW4mahKdyFFTrqVSzvX/9jIL5srowV9tjuvVPV?=
 =?us-ascii?Q?CC81w1DeOfx4sG9A+VmeXvs11dZvYPHAAVRUu4S0MWeyrlN4bNgLOPCwb47j?=
 =?us-ascii?Q?m0EAjLh86/XRljnEAcOyCEpJL2stAgvjFWeuuCKkyh1QjlRldZutFwm0yfUY?=
 =?us-ascii?Q?fb5bupVUjEJQhNYgIBHvzpk6qTtQmZA0vQP96cy4xzsxyuBjW5swCFeN8qQg?=
 =?us-ascii?Q?TiRgkHuh3G8gyEe5VgQquHmjsK3VezPMAk/W8XT2yNYAtsZzjGCp2DBB/Q1S?=
 =?us-ascii?Q?u1kieXZUN5/vTE+g3mcAbB4UPHc94RB+WYbhDK93D+b6biy9O1L6G8YFb36z?=
 =?us-ascii?Q?8/HxVBmfbVPykyvzePbPkeY6njJqyoIXKNDE7Zb186gcs094bSFZuQFmrF28?=
 =?us-ascii?Q?L7PsExRifK1NGvALIePEPRxaNWEQyMW3ew4NIC/n/pfd04c++1ezBF0R3hvY?=
 =?us-ascii?Q?QrgdatvbB+VzP/fXmHthD8fbBlLh2jv8IXOrlMpNK6nZHvx+fEA/KjdEv2dW?=
 =?us-ascii?Q?ebfqOSifegIldLfASIja/qjw5jkPXJPlHqqdFHE0T224PzkT7EovGsSBTKuo?=
 =?us-ascii?Q?/uvc9/Bk/lDh6d0zbqxRGoeK7yYecX0h2QF1lIMyvrXbdDe1cjS4P0lYUDnu?=
 =?us-ascii?Q?DcPQ4ZyBG0/jPputQzULA4JdpCgLgXbFe6WKd10L2XWLfTtdVH7mOCWOSr9w?=
 =?us-ascii?Q?8X6Rfj/cG4iwrtnNRWRkHIh1e++XBaqcSo1LJWpSFp8h5Ze32erTrNNKUZmU?=
 =?us-ascii?Q?RMUquKHlMWVELirCssg724Ur2SciQPDpEVzz77OMvNVH0gojury2GZmwUsMl?=
 =?us-ascii?Q?FVeHXrVXqpeVFnLevGoE/Jiw7hf8+TvzHq9wf4z86ZyFf8a9ts5F3Pk86lZv?=
 =?us-ascii?Q?uLY+dQIi4Tzv0g8GWf3hkEayA54s2yRjd7JxAaisyuVuavyElHBt74QoeDPI?=
 =?us-ascii?Q?fYiBAO18f4DNm/wetESZAu2MUNSHk9wOkIL52/vQDWdvP/OIwD1lVWbB9ezV?=
 =?us-ascii?Q?PEuhqwgEuzMVQxNSVY5OM/bjzKH0fbLf6de63o9WYoy8yEW0j+wMH+tR/0u8?=
 =?us-ascii?Q?ozgO0VSAjLXknEdSvWnT7Yd2l3tQP4bdpYaTng7+3moZRhrOGsdqZ7+yEIr0?=
 =?us-ascii?Q?cb1rib33gu75q/9dJ5Zpcr3taNVLro4z4oGNNB1gW5DrYmP9DqgYqG2hS91v?=
 =?us-ascii?Q?DZ/xpmB4CJXrDovZdwppuzEMy76JdZ9kz0lQPRf99GpK0Lk7PjSqgtz5WUst?=
 =?us-ascii?Q?ru02LAAtiXzJPUgXPJf5/e5d5jlvAd0WwkxNTpV+4BdwZbQcdmmvp1gUYkRq?=
 =?us-ascii?Q?10Q/pnCx4eoS4S4T2oI3+L0v6PRmhBp46OKPnrep+P98qcL/A1piB1nEg+ni?=
 =?us-ascii?Q?QTgZuaMBT2hY5D2+t6x0O6gYvs7eRU6lkZ2CMaOqVStsacC3aZCabLI9sCif?=
 =?us-ascii?Q?6joUliBXnLXgW96RLEttajPwNnU/dFJyq2Tub3yeo1C9Y2QLrjy5CPXOPxiv?=
 =?us-ascii?Q?adRsFS+p0Xu5LJTX0W0NCHAdSH4DVG+dehUbk0ut?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ace029-2bb3-4fea-c75a-08da75dffaa7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 06:10:07.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCSetZPYQtKklPFHhDA2nKIagnypxx36XZsxOooa+L2v80MMZuWOQQICzQZA5sGxoh0Mtnxytzk9DjMHSu29aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple Power-Managed bus controller may need functional clock(s)
to be enabled before child devices connected to the bus can be
accessed.  Get the clock(s) as a bulk and enable/disable the
clock(s) when the bus is being power managed.

One example is that Freescale i.MX8qxp pixel link MSI bus controller
needs MSI clock and AHB clock to be enabled before accessing child
devices.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index ff5f8ca5c024..876a906724b3 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -8,11 +8,17 @@
  * for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+struct simple_pm_bus {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
 static const struct of_device_id simple_pm_bus_child_matches[] = {
 	{ .compatible = "simple-mfd", },
 	{}
@@ -24,6 +30,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
+	struct simple_pm_bus *bus;
 
 	/*
 	 * Allow user to use driver_override to bind this driver to a
@@ -49,6 +56,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 
+	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
+	if (bus->num_clks < 0)
+		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(&pdev->dev, bus);
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
@@ -72,6 +89,42 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int simple_pm_bus_runtime_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	if (!bus)
+		return 0;
+
+	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
+
+	return 0;
+}
+
+static int simple_pm_bus_runtime_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+	int ret;
+
+	if (!bus)
+		return 0;
+
+	ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops simple_pm_bus_pm_ops = {
+	SET_RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend,
+			   simple_pm_bus_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+};
+
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
 
 static const struct of_device_id simple_pm_bus_of_match[] = {
@@ -90,6 +143,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = &simple_pm_bus_pm_ops,
 	},
 };
 
-- 
2.25.1

