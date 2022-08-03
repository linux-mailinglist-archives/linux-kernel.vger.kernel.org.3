Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B928E588560
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiHCBXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiHCBW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744C564C4;
        Tue,  2 Aug 2022 18:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpzkLUcB70QH07K562qll24diYPi163aaeYTfZZgLLhGsu4c9Lnbhi+6Xr2PrY8/0N6dhRuKssLcAYIRBqzpgnFJvFkdJCSqQRbu2OKTJbNv1ZPxvvg+KsvpVdm+04J1nh3uru1uw/mMQtb8wiFUWIh/lvMcdpITKZtGob6sb6HbW0Ok3cJzNn7tOrebYr1gfQkJ/Nx/DdN/T5KRqz/cf6fyPGLYgFXylD425u+41XMkpIG6CSqZpDyUxV1Z6Jut0pe+04DvBhf1ZhIMz+mtY1z3XeZrgrPtFzLn8hDkBHWhvRsoMYsXvFJU/AXXbwALDHaMVCrK4B8k2EtmSQ0DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTA1xZE5g6eK6lR/E0NIVumBT9olJ5kQ9LGNSe3P7Fk=;
 b=FrGNAndK4DW4oLNVOkqFhPcJjz2ptknmaeShS44QsI4M6gnMJpycc3zuqkaAsQ6nvJyfskPQcydMk7N/uSD5omV92VJENh2rOcMt+e35A/xebJqP7HOtLYbSLtL8lXqXICEZ36u0lyXxN05WQAm6KfodpnkTH9bJtSRTbiL1USITuuFTFf12pi6RjhRC05p1gsJvVXLN6DCLpDky7h8LZkQ2QL8xomRiQU4/d0sQHWcm2657RpCbW/F3cG9Si/mvbp4KV+ehsqGiQjkD8MlAWZyQI0A++uQkCBzAV1X27w4QYGwVQRxr18XRDiNHJuJ63KFWykX/U38vvJWnu7Dgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTA1xZE5g6eK6lR/E0NIVumBT9olJ5kQ9LGNSe3P7Fk=;
 b=KXqxnrVRXJqB8CSLYEDGW2ji6NKX8okpKweIf04BSdWdZMoTGcHPNAoQlH43Kgsamr2rVDdRnqS8p4Gx9Psdx78NIukcJuhlu08tpb20U8WKr9g+F8rxj4ZFoKeSdpSsbJKgqL7NawN+Eq4Gs7uZo8fBGJC1Xy6wLONAx88r4/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:22:53 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 01:22:53 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/3] drivers: bus: simple-pm-bus: Use clocks
Date:   Wed,  3 Aug 2022 09:24:20 +0800
Message-Id: <20220803012421.3410226-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803012421.3410226-1-victor.liu@nxp.com>
References: <20220803012421.3410226-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edae6ed7-a895-4698-48f4-08da74eeafeb
X-MS-TrafficTypeDiagnostic: DB8PR04MB6891:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lC+3pU5WN4cYE5CNpSe/FaDXEu8PIyZM67g+Vu5IMbYTjnuedv4TD+cOwqFzci0QtGKZilu07n5HLd4hcUyTY2VyeSI1aAFtiOro2gLzz2/bxDTSmmmJez+pBqJiFqfyRlNB5aE9CE3Li/bA/EpsURWefWE03YXedZiJ3pbqRPL++IkaCzIZCbiWj5TFQSDl+B3oZ+QEOUZRc17iPbEFQnetwQt6bxo4Cf7WBT94JJIgE729zsRp3Cr7ltWapJp20ikvBCACAqRcts2g8RhKGtwPySnc/BA4GZb4UmT5c3D7cegc7HlPsx7msJqUYBS22MnuKGOOsHlHoGTj4clH21MF+E0VezGrqwcvdmN7Y8REeFU2jEHhwsWcMK5lPf6GyOPrww/AuRQ4qWcMIKG9rg6K5Ryk1oayiipkxMVGU+8UMjwYhwbftnxuU+ePAW/rEP6m1r/2KQLZG3qS9Y8dZ8HFwg04VbeSivSRL9KEDToU15dQV51bYdKw+ZfwEnpRAuQPFWVbyQlI9Nd9YHiekcJhoL4vzltAbGIp07043eQGIkUOih8Nxb4gnmBBY6eYE6XG+XJrBXaDvvtvK4rnoFBSZgER3bB9tH0Sft21GobVKWe5t1FLzNjAAFrAloYwO8gY32tGAru5Hcjyi+XsPaByOLwQd8dwTy4ldkQofdF/Bz9O7Cba3w030q4lwswDNI6WBgBZYvbFmKBzf2hIgKGgyEbCNhR0UXiBfv39FrbQe0q4/D+WuI+UrymJyMO/aKfuk21UkZodwkNi5UhA1oK2f+6JJhWoXGBsYxCAFf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(316002)(86362001)(5660300002)(7416002)(8936002)(66556008)(8676002)(66946007)(66476007)(4326008)(26005)(6512007)(1076003)(83380400001)(2616005)(186003)(52116002)(478600001)(6486002)(6666004)(38100700002)(38350700002)(6506007)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQwb6S2gNDPKVfWm1/UpYcgSlkalwWsIE39fjlHIyBE5MasHWCEl5IEzv0Ps?=
 =?us-ascii?Q?zgRmA1XUbOtff3FA0N56gUI76+JQw1OdWrmhktLe7V+MTt2C5PrTiKF2EemS?=
 =?us-ascii?Q?SNHP0ghMJ2aQI3UsWMeM4bVYsEtSnuzo9kGQgUI7XtZp3kEZC86Sv7E/Uoxn?=
 =?us-ascii?Q?obtPE7JiFKIBL7bLSHwTsr9NajmxEN05dkVs07hnT0vOieXCowyiQoBKaEqO?=
 =?us-ascii?Q?mAL7bTC+7bMBbapaJc9OJv7qrW/BMtAqcKMhe0j+xt+5kr6tuXINP4c7a3St?=
 =?us-ascii?Q?mRWS/qk+ptH6D9Kbg1/vs3hu4MhjBeqWDEtfxVg3vDOTTOHO04lR9vZzlB0e?=
 =?us-ascii?Q?Hvg1K8Z7eWSoFkkFxauPiDyQNcCs+BqVzDsbcahmauJJy1wv8C4rSvGOXLRd?=
 =?us-ascii?Q?8p5N8zFhgQE5y99PzRygsFCTizrJNNa8EPepf1T/fDGLa9c30bctu7Y//EdN?=
 =?us-ascii?Q?Ga91VyUgDGE68oCIHsTXlwC9BCCY8uDAq9YZnyi57Wq07FqWhUuX91mkIB3R?=
 =?us-ascii?Q?tTdEFgo+XYaB0hLvWoIOyrb/Vp4px8+tfNYkQbGItLMMroTCyn7MgE+0NeOm?=
 =?us-ascii?Q?n7NzYM5PAToEj7iPQh7bzGUdXwskU9QNS7DSLKr5QNCXMqZl5ko12A0jQBRD?=
 =?us-ascii?Q?dnL7XG0yjJYJCmO89ftdUJD7S2irfWT9xu4/l6Hi7XJumnmOpHAPPO3RNxDL?=
 =?us-ascii?Q?HQlVRtjcYujxEOFQ3RLdsjbAjZif2J3D7tbc9d0+32eOq2c1q3huzie8qRj9?=
 =?us-ascii?Q?lm2KGr0oRguLICTXlo86n1Jx+XxxXTMptG351S9/oxiWVBksQl31nsovjtEz?=
 =?us-ascii?Q?/peJDS+UXHYJa8eyaOTsvbcr6nuUnBCe1vFYfyl1Aet4pwaCv4QxuUuCXVdC?=
 =?us-ascii?Q?wgvtzhwA1BqJxtmBQ1b25Tyq0DCR/98ZO194Msl8XVwy1/4Jl36KEaDhb5eo?=
 =?us-ascii?Q?Yt9HUjdtFd+yisOHMVoWin5ZMeqnarC0mlQ2RTdhiCPYgSVxcHd5r700QQiC?=
 =?us-ascii?Q?oskHty2lAHzSanbPd4AeLur5zX6bk560T1+d7S6C38Ge+RkeNO+dqyjnElEM?=
 =?us-ascii?Q?Qm7R7PzcYaaVwJT5RYE99i3LT31zpuKlGp6OOBpJXMfIgOaaBlrRTBkLtRf7?=
 =?us-ascii?Q?fl8wHShJRCt/lcgHIKBhwu+TYKgcGcLrVgiFiNXm2MRQOi7zYSnwx9fNqn90?=
 =?us-ascii?Q?Lcj3L+zmAlaAjkqiO90WzPaEAFF9FQyfOWsEXCzro3WBWBQ3AlzCbSVGOvIx?=
 =?us-ascii?Q?qhKPXk/MunpSH+8tb7YrpaCFgZL+qQ++YO/AqrUOFusr2KXDSzkU8QDb/NI4?=
 =?us-ascii?Q?jbu/NdbnIob0vwP9xFiCjdHSiYbLqs350IST4CqtzRhp0ReHDRoNqLv12KWb?=
 =?us-ascii?Q?/ohiBHqj+E4nwO7PN9EiSBxVBkYQcAo2jgo5188rQKjbV9R7+3gOmW20VXRg?=
 =?us-ascii?Q?BH75ts3i2Z2MnGMEe07fZY+Z19dvwNp2xH5fXcyN2Ux3Ac6Oee25ZiET5KN2?=
 =?us-ascii?Q?+DmB+xa04bCeCOfkuKqvWFAi1BwdKKAOSKrAh0LHXBQvEJ7WRi11W84r8JOQ?=
 =?us-ascii?Q?97Cd9ASnqgdae/SBO0rLyOpY0Z8JRP2VrJ7/6lW5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae6ed7-a895-4698-48f4-08da74eeafeb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:22:53.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7r8OEj080jAoYwzZO8mMRK0YCAyfz8GvmZaT3rG1v5wtdF5Gi6bK2hrYrKldAHLOZWb9QN6h5rRrPq4qMYUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
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
v1->v2:
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

