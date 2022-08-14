Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC56F591EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiHNHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHNHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:42:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FF1F2EA;
        Sun, 14 Aug 2022 00:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd3hT+mFwsAdDwMwJmWYqVkxImaBsrH+43Ec9PF+rCZa09/n7tyWPPfR4EwTaKWItDRSE3tV83ehkOhhTArGyWKrmFt6RbjMh9XADh224/ij46fAd0RMCppz4UaNmVq9TABcrpxHIEeQCAARreB3TWuorIsprONXu6NpegiqIYxdDVUbUMsjuRHEeWiaZIErpFif/oglfva3pCK6A/vQFDieELhSlUj1yOFCFapi1KtDl2VUDzzc6PquvcbWNmRkLjZfZivxW2lWPvgWiD2uBuYl+dc6RHSyRuknmiCNXEkLZgtsMrlUnl9EzlHvSi43O4dlH9SrdmWFkZhI1LbN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAxYOfz3sZc+r6ojdxKXSBJrhK0IXn6bj0q+c+eoq+I=;
 b=BC2TSYiODoOC+9JiEVuRYu0IC45LOCakXiUVdjnsGojUFNnn3BV+dS19UZrzGqIZ5TIxlSsWkOFrrix+eN5udmwuzOJJmigNGcPJHR1kO3zEOW2Y9/CPCAT/LkiU/JfSya3UVW5uDjTJvJsE2znhxBeANWW1VTDY8Sx/4y3IOPjNf8jZp6nOrxVTVa3DcrT8Jqpv8RrK5kTejwmZR9O/DNuy8xAyMLLEEfDtevyWLoCP2rxtRQ49LwBkZLOR/htaLRunKUWUwZYXstjHsnIkGkQXHPSaRbLhO7+mm+HyqMfOXSDjuY+PYPQzLLLDFHnfBLm57H9rgeNR5TGonmRCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAxYOfz3sZc+r6ojdxKXSBJrhK0IXn6bj0q+c+eoq+I=;
 b=kE4OOZf9qPZWb+uRD/PEzA+4BximkAIGI1165TXenNpluhid0DtwSUYLNXmH7jZLxyuyfFGSUQ/G/yTM+mpIRWByVFPYBEe3y3qq0iIjU6MnvSavTeUgCxvNzQ9L5xKES9imf6k/9+cIUpF+R8732BKWz7CRY5QxCsF3y+uZIBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 07:42:09 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 07:42:09 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v4 1/2] drivers: bus: simple-pm-bus: Use clocks
Date:   Sun, 14 Aug 2022 15:43:37 +0800
Message-Id: <20220814074338.453608-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220814074338.453608-1-victor.liu@nxp.com>
References: <20220814074338.453608-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae50fe96-9fa2-4c8c-d91f-08da7dc87e4c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4016:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un7011cOUPtux8mtFftZ4W/n/rIN9IiRvjhU/tWLJYtlJzwGK25+/kqV7d4GExv1JXQlJZeYy/RBkswggqICB8brz54F1dcccrD0YYmm8IHn0diD31I6UWjaBNaJIA8Jw4/718qamNtgK53up6Hfe8cSWCMMFifVeg85k3WxqG4DVdTJlaGaB+n3a+8M/w1ZhZ3wu+khxqkMrlKj3QSjCubzVZbVI8oXy2hGo3wOc4gmsKXh9zRCgArVJUBAKmtgjqkCphX8BH0RHaco2sXN9uObCapHNsCYJHNCVtI6belchP4POtnD7KBRN164UumdSYe3UDwWvj3eDGnP1inlCcqnr0LXMFohsKNrrVR1LFP3mUbuLURAH/cit6+bskAvPS6fXuriv0dV5JGOOBU7YHfBXOtOC+cfZND0/oP6IrdbMNib7qLNcrqeBsU96fGh6PwiPzJ5Aj4lzrSdVZwEOygCYoD0aI5iEMMkCfV0siMMQseGwi0zW5zGCWbzcRi5yq2LKEd5QeoCI3/voDWsNL2+TryI/ViMcPoahiC1/y2JQlb75MSNC0K+M1VNCMFJlafX+AYXtaeem+qLLnb9EZxbUQFnvIEAb8avslxkZ2XxTzFeQRn7HK+Jqz8uvsurJp/7CXfwioj56AMTxJatmmfT6ol8mTNgTTk5RDW7ghryG0jkrUkGvMRSeNCkXnNJL9U1vjEWNQ4GVI/0SEOaY3yzGlEi/tIg/vqjqjuDnLMat3ET4GGsnDQmIJfy/aJiSGcPm8Tmi5KkYvp7/19msqu7QBJdaU2rW7wJoEWL1VBN5+Hkph1zAdJTlsfh2SOR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(36756003)(86362001)(26005)(6666004)(83380400001)(6506007)(6512007)(2616005)(1076003)(52116002)(186003)(6486002)(38350700002)(4326008)(41300700001)(316002)(478600001)(66946007)(5660300002)(8676002)(66556008)(8936002)(7416002)(38100700002)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nf+pk8mmTczOmjWd02Lzg2brsk5ISgvmELy3xZ3y6WA7g+11ZCd8HMsWYG1Z?=
 =?us-ascii?Q?KaUo9/pS8LNcvixiEtnXX1XfymBEWUdQA0QmsSr9g4gUiHElAsDNZbgE3BnZ?=
 =?us-ascii?Q?qeudj+8sKid6o66LFV6+2XjY88jtXITh/stc7g7760npwHZGhbAov9VaU8CH?=
 =?us-ascii?Q?nJytfyaKqP1PsblJHZcGjZJRsll0Vm50Q8eAhPO7wC2mEArEvKs6rPOtH2tN?=
 =?us-ascii?Q?2KZ3jnRLkwkKQcwzIe5j+Ylx/fmLx3KqWYdQ8JLyRREY+04eHVbm80F69TG7?=
 =?us-ascii?Q?9vn8i/fjyHfEQzorOrhU5kzy8pc3YlHV/777e1N/NYl49re9WlVRohBsjIIQ?=
 =?us-ascii?Q?dxeWf9V59eVZEtLKDW9ZcrzjmdExX3W3aJvGA8w+hWy0Wl+2AXffx1apsWZL?=
 =?us-ascii?Q?bpvSn+MUHLteab4afYTS9mUdb1ny2EpN9Dn/GXAxNMjSUKRGet/r0p582QJT?=
 =?us-ascii?Q?mbOqP8GznG6WaqjHJvvgBncJREoFQeD5MPg7lQ3ahLUaCgG4m0iECPxG8/5c?=
 =?us-ascii?Q?lbvZfSd8+atGcnxYyDxsB0kXNNG8ED5+Y+6r+QPpTRuLcXUSzCPZKNl9xgHy?=
 =?us-ascii?Q?zzBGGMmqwQ5CANduD/3/rzDDDmUPiJeqDiMyoX3vRsIZ9wWtFDk/YA4cBvV5?=
 =?us-ascii?Q?r1BzERzd2aKVzNX5r5uU6Wtz+IEgdYyfrcW1xVKyxI0V0TTvLMnAZchvtZlI?=
 =?us-ascii?Q?qyO79uGuZIVtBAFWeJ/mjdCfsp6zIAbI0tWjK+D8kaxmBTDZTnvFHVpYGBxS?=
 =?us-ascii?Q?un2/2e3RXZA382a+0JR1lmXB+m5X0s72JjOzvMj9RavAsuzaRDQnazf8EUao?=
 =?us-ascii?Q?143YYSPpjWnBxzod77YMFAvz4XNF4oV8Vlw/WAY85KzVrDj2gZgi22k+cDD5?=
 =?us-ascii?Q?u54htZE4PXSTch3U26LSaBP72p3wtOB5WhaILzp0yelqY2B/8ErR9LK99aIW?=
 =?us-ascii?Q?D7vLb66+oReyEjiqGFT4Eu6QwElGfSLjkWFIumBvqLhs/9Elk733YgRsOzY2?=
 =?us-ascii?Q?mGCJd79ruJxILwsYgjEgFJ4LqHuOx8PWwmcGZprr30a6+WD+C602IPbDDxJV?=
 =?us-ascii?Q?WVB4w3ai0fqQFpkUh2qYd5tUzFgZnnfPNmCgzlixvHiTZgAXny62g8+mH7/Z?=
 =?us-ascii?Q?5z+atbcRb1xF24tLd/uSs4BgCx9UQU61jOZsOHVv+kxL7mGvOgVTt//hkqhT?=
 =?us-ascii?Q?+6sZwRIckyWcmhQJp086pCuV5aZWHDvC3JE3vX37D/8HLQxiBZ68C3kuVzNe?=
 =?us-ascii?Q?IAOsUu6evJDCHR2THRZYgvne0vcuxSL98ehCsZl/jZNNt1VKfx/TO7J8/POn?=
 =?us-ascii?Q?p6OKjoghm3znQa4YTH3eIhxLjZ4yxrn8ILsYC0JqkXsiQ9fMb70vUBIlt8a3?=
 =?us-ascii?Q?qHlo428CJi0zLGvSYzX7YozOH1iL+b0G42FSQIDcSBP9uKuUGf4CzHNMQQE+?=
 =?us-ascii?Q?SvArs7cF/iP1cis/igT9bYcDs4PlFzy9J0RypHB0WwN7vVsTQsRm2zrsXdhW?=
 =?us-ascii?Q?pr9fEsQZOnei7Utveqhm7W7X90p3Szwa3hARCXiorNwIb+jkyu2B8SEKphvB?=
 =?us-ascii?Q?+b1goSCMk83qPtyVb16wZs6i8OHRcKp2cIVlj6JS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae50fe96-9fa2-4c8c-d91f-08da7dc87e4c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 07:42:09.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1VbPwK4oLXLo7hHNT9KYPuo3rJJBZI3hFV4h6GMHHCxzasC1CypGsZ8lqD6pSdlHG5+1qpGdm2ZeS9zbn/Vqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  (Geert)
* Add Geert's R-b tag.

v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..d7b043fefde9 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -8,17 +8,24 @@
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
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
+	struct simple_pm_bus *bus;
 
 	/*
 	 * Allow user to use driver_override to bind this driver to a
@@ -44,6 +51,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
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
@@ -67,6 +84,36 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int simple_pm_bus_runtime_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
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
@@ -85,6 +132,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = &simple_pm_bus_pm_ops,
 	},
 };
 
-- 
2.37.1

