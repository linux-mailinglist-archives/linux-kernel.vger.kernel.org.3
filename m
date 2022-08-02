Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA3587794
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiHBHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiHBHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:12:06 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5732DBA;
        Tue,  2 Aug 2022 00:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbXwR/DdNNKHl7EvCMZvezrCULpGmGSIxkX5ELjdkitc8OLwLdjoPl0G4/dCgpf6PZnWnzp+tZtaq8F5/U7kOUnoCcLbUbawJzYy5GVW2dYKvtmZ03gbLDRfqYjIfqkqm992MxupBe4MBFu0YozH/zn2CRb7xZSYaLXDIPpmBFgmKiTuV4ZlauStFF4tOsmbAFAcHWojVOj1r/fSh8wCFnCWF1zb80rEZzB7IeOrwAnD2haCHZkaN9vrJ3/4HrNaKWcL1Q/1XWXJvHWupjIzPqntk5ArMpUhfc/vySg0eP+pOQwpXLPIauUcsVLQuFI4pR3ovikxmkMA2sckbxyTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bq/ryw6zaIOWVE2cUXPpRAAnffO8RtEUMLB9CPysng=;
 b=gGvxs+kmuv5TcHteyAGiRSyEgs5gYzfkFwRnm9+ynTG8e+g3Akh11or6LG2/Zrz7kU0NeqhpTMyfP3nCxXlzCCwUACuql6lc6oXIuINr9azavvGUu7D3PzoS1lT6uKUgEVaj4M3UYcXhe6m7wzO1Q+5hWr/o4AN0+VEKcpXsgeunxcZ+Ay6u0PzlofEeeivkgu74toS1rEJ05ZbfsY1WPqfJ0Zr0DE5lrVHk98wwQpPyjTXUK+uO/j/gJmgA4/6meNFrdoF6Shphkm+oc/60R5m9bQCEgnEdikce0oZyK3xaACjUIM7kgvQOOA2F4b3UgGfkCUK72Gs7QYhvES3iFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bq/ryw6zaIOWVE2cUXPpRAAnffO8RtEUMLB9CPysng=;
 b=iygrZULolTbDb3MGjdPq8tm6pTwYUAf54hEJqm5Pk20wKpMLbTioQubJzYKMwdCsa8+Q2iaG5W890tVdOxRDNKXtTzPearsBDj0Jb59EtcCnA5XdO5B7LnxO2yZEzy5Cuau7ZTGtms56WV5Mgjqghjc6boNR0r1RdtzGuuR1J9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4719.eurprd04.prod.outlook.com (2603:10a6:803:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 07:12:00 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:12:00 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
Subject: [PATCH 2/3] drivers: bus: simple-pm-bus: Use clocks
Date:   Tue,  2 Aug 2022 15:13:09 +0800
Message-Id: <20220802071310.2650864-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802071310.2650864-1-victor.liu@nxp.com>
References: <20220802071310.2650864-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcd8d95b-9b41-49f4-0e71-08da74564b35
X-MS-TrafficTypeDiagnostic: VI1PR04MB4719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dm2pFGYNzC9qSVHUxrKpZt/3p0OtoVEKuWUFL7U82ILte209IFnFeN5/YQIhBG66VwloeuZQ4NBLY1DudYaog0rwy8EsSFsLmdRg9Vai23/PkAEWETUWdmJVx+9pKMn1hcc2BDPEDrRaURKLfaODgB6eMLthQZ0br2uVHrnSVZ5KGUP8HzckHiDxd090QjByahy7hSuzpcCPWEmnM7YW8KnwmTCuxhsAg5t4Sw/8Jakd+qzKuy4HGwwr5SSeMZHFK9L1sdUCfCZHIZKM3bcRoO9lhRD34EYLEuXG0lU7xaKd79WZ+BTPRdi1hvdPqDViGXjMjY+uumy25un57OUy8twgAu2S2pWOqKfW2ezpyn4zUOxvcgAziZHffBmYt1rwBa+T8ArllsMS1AYZGQ1n5PSh5xyOhDsTdpGrolTfZBWJkRJq5Ksh61DnK4ubmBQ4bv/Nhemj58JO24xbCppVm2oNK1yBLj7WF8YmfoCjEuEOg/9P00Hn4MJ5ezM3wcxUuX1iZ7wq/7pN+6hnngsg/PUKxTwacxfD6edrerCOgUS5oG9wRGwVh/GrjX05NKxOMYs3NseKfpbm/fZ1hvDZP4lQ+W19BzgqLuXridJW0OWQxBzkBGEfroNusWHwhu6Pl/PUndwrOB/RWo7YGBeDcTiCxWBdq1DolmKbANUaIO6+6XbL1WlK4Lg22Kre0UO4fvqaf37SLu+CNfyLF081a8OixzvPYDsUtQr0sKbN9rHtIZOz5iOCakPFD0tjsz+4SyFmbhSKqN3r9pHww3JuD4bRFilG7MrLonrTf1L5ZiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(2616005)(66476007)(6512007)(8676002)(66556008)(4326008)(5660300002)(1076003)(6506007)(6486002)(7416002)(86362001)(66946007)(478600001)(36756003)(52116002)(186003)(38350700002)(83380400001)(316002)(38100700002)(26005)(2906002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDbmvSlTN199mp+sxsjb6vUg+CfxIC+bKS8cuO0Ilc/XVuk26mZ7GLJaqkP0?=
 =?us-ascii?Q?NrAgHOqEEtcMA0f0gz9rcydCzfn+oyLH8Vk7kdhrmo4zAuJbpFDmChAxH2jY?=
 =?us-ascii?Q?VrvrTytEiIwjFYITDQZQX30zAZ/FUz8uGjLKbOsK2vEKQWVpVxvoawmkDwfR?=
 =?us-ascii?Q?9+e+kyQcWdW5GTUSv4fDw/pHv2ML79uscLkMF8ljoQCRcF2fLFSRxB4Jma2z?=
 =?us-ascii?Q?9XPw6H5FNY8gGZ9HDx5WytezX3d15xVmlbNiviaISNdnHHLNpYQX7CgM4xql?=
 =?us-ascii?Q?HQwZxhwLsKOIhIurUp4Lsh+Chk2cBGIsWsOkXxZ0yVwLEvy7i7ENuoXbU/wz?=
 =?us-ascii?Q?/T3FuhdhFz56TY8R0RYuHeQxeSugY346W47Ac74S46QzUuoN9Oow+ID5KEEt?=
 =?us-ascii?Q?8+BGocLbfgrZkuwrYvxZke+lnBSSE9GbmwRMEwMNWJBwVmSU152j5+RHSNuj?=
 =?us-ascii?Q?v4+CRzpx/JRIAVAQzOblTG0jWC4S3X6fYnkJDUJn/2w4DUXZP/n5GuFXApW8?=
 =?us-ascii?Q?nSsE0ZE/GSqNNwDjWrEqKKzjo8RqgcxPF1JvdFZ1tfPYXuuP/OQYTtO6acv7?=
 =?us-ascii?Q?dXamwcKSkYN3KUo2RPJF1oeTSV5Gzrw8/4vNjF+4PnEIRC/rxOT5cYVCXQXF?=
 =?us-ascii?Q?LbFdPIymz3Rp7F+/htg2FBHjMxpeEsfaLH3cjSSRL9PLu3kO880G9rdkoaXF?=
 =?us-ascii?Q?aQYoJkYZ1Ts7mF/pTWKHN0Hm96wOcbMWTywuL1dql4jdXLamEIYRU8m5EUkG?=
 =?us-ascii?Q?G4zO3RPbOJe2qlPQulJxdMbm4qIXKcnYcv7wq+PcPEcPfmucIzur13ZhA1ZC?=
 =?us-ascii?Q?4oJ8y61ZTQHJgHqindnJZYc0gsEo6dqdD2qelRqPxmHpgfLDXikv+Pt7co2t?=
 =?us-ascii?Q?Q1VHkGQ7JFsHjXEdn4fpIaU5dd++hufUjmc/1xwBCGh9Vyjx2WhdlvCWBUF1?=
 =?us-ascii?Q?ZXCRThGsVeiCScu8TaQFYuQ6xz8KyU4bJyoH0QJX5W/uvBaXOHTmDHU+d5V4?=
 =?us-ascii?Q?1SQJvN1JD0ppiDQcn3L4mAbQaZrOipKVnqfd7lamX2aWT3RwQpqlahgRCYER?=
 =?us-ascii?Q?Ae+qBXKonMQmoFjVr4AcdZy0P+b1gQrpQUIAEBevuDKEaD3xbS54LmrTcW8s?=
 =?us-ascii?Q?Vp/jUUFMMz9LjfuPF25wzBIgaQSwQWZdsysYx0nHV5GiDTYdC9oup0MxtJ04?=
 =?us-ascii?Q?EPFHg7bZAGdDhX7nHGbJLmr6holDvUfonmDpRz2gCB4ffHWx3kHtL7cWSLTE?=
 =?us-ascii?Q?B34yJqyuRQhBP/n5w/660XidXP99naSbshUJ+Si1PMHhhArG+PZoYhxLOwMu?=
 =?us-ascii?Q?MbJyIj422lIJWB2vbg61rVAhwuUhuumpoesub0sWzGLZcl56Fs3AWyDe6JRU?=
 =?us-ascii?Q?6X6KOC6XX4ED7ixu15WIz8sk86e8ZRqWy7WBv+uqCEfR0sHNzsX9FmgEmRZ7?=
 =?us-ascii?Q?Kbst8Q0fzi0HfaFVBXVtN+Zk8BkXFPOuHQXDu4j39Q7pb0MwwfdWpB3lfOuk?=
 =?us-ascii?Q?a3t6iONvXPrrAqOFx7DOLTN/cOzQ56ffXdofH3hPK+xGLHNOHQT+zAh7D/lQ?=
 =?us-ascii?Q?iXDbOYQhYaDLod/Ab4FoEjnHggGGX2SuJbv3p3Hp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd8d95b-9b41-49f4-0e71-08da74564b35
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:12:00.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2aMsrcZimZvgfC7mwOn8vJjwtmN3DVsAppagL55g+fR014JyDKve0i1TvBzQtgwvNbnCUOKoKlujXv+wrm0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4719
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

