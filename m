Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9861B59B8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiHVGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVGCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:02:07 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2DB1F624;
        Sun, 21 Aug 2022 23:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whdgn5CG25N0VQ4CUcxYuJyCq9iE/0Mfg8GF8PJlk8ewxjrhf77OSOJ/cl9PmYE+lvcO6f0fLowrZ+jMwwwjTODf0psdMRMcofO9ohYnSRr5LpWknxR8DT0Y9XEQlnIehSWhzr+Jcx/HP5oymhTINDs3Kegl62G86PmKB5TLw47mh4MsmF6kAY08yDKsittkas/hP8f7ZLbME8bvLikoGRdRTpSfaUv0g6JR2KiCux8naO8bN36v90Fo80g56XSeOEOGjs4Hf+Wc8hr4ruEOmlBrJTBLn8bNebHyjC12MLv3BrHWqTIQSd6aBif4QTFUT7MkeFzEOznIZ8SBnpVPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAxYOfz3sZc+r6ojdxKXSBJrhK0IXn6bj0q+c+eoq+I=;
 b=nNABbCiEb0cttG/H2Uh06ht+hPInjwHX6hHzpn/NTZqoVGeML6ZImInA84k/FC7wMLs1PjGa47i7Ew5Sccz+BD1KSE8vEzj8nmJf2Xs3XFsHgP5Z+cjfZ7lmrguC+0iDsWCP+S4KM0TY1ZAabJfYJZ9qNiJLJJL0uzdPIOzfhliHBtdbggUScr9RzE0ePohmtiTxz4rc8uDvEzuGE8p2yftxvt++DAbD3bsrSOzdnDqwcerfiQR6LISdO71wXkqKuqVnSDHnJFCfCtMAU+jkWq7BaZ8m8M3T9louPObuQs8D3fbIyOaPnDA9Ha0Vdc/Q08B4g08oewAmc+BCCNpfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAxYOfz3sZc+r6ojdxKXSBJrhK0IXn6bj0q+c+eoq+I=;
 b=XTZOzy33Lbz2JOvmKsRPhXSiBNroI+NI6Ymx9jE7WoD2Tpt8ohOYEul1+E3EajkMeskBVQhVXX042Czp/vJlrmZIcxIlnemca1QVjLPg6gUubCIOX8Em26DyWXqB0Aa/cxUqflvYY+H55UPIaMrocA/2ud6ybR6ifNdwQED4+P0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB7PR04MB4604.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:02:03 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Mon, 22 Aug 2022
 06:02:03 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH RESEND v4 1/2] drivers: bus: simple-pm-bus: Use clocks
Date:   Mon, 22 Aug 2022 14:03:22 +0800
Message-Id: <20220822060323.3481384-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822060323.3481384-1-victor.liu@nxp.com>
References: <20220822060323.3481384-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abfe2cd4-7d7b-49e5-250b-08da8403d5d9
X-MS-TrafficTypeDiagnostic: DB7PR04MB4604:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWxkYL5N/2rQvjN3dXwsbfF2CrxTe3nrjujZS1G8It+OafXHGv69b1d5jpV/nb5j2uazzzwMJbJ9okkWlaytxzE0rLJqmZd5swiY/H9Q6UACLfUempxo+U1dRQ09u2QlSPJVsrVxqy9/PRcfmBnuAS6fz0qeJT1zhMhCXH9Y0TbdJ6eYeBCfAe/nbZcLlOwCQdqu/uGI/kfpmXl+ZuvVJOvagUZUwRR4Vx32vWFkIijy+8WxX1N8RUtifOxFBIsQMOHIfF2n1Gq/GXMecp7VSmHIDHxrwRzHbQHDTpeJo7Iv4Sfyzpz3Wc3yJiosUnkyMqfyp7ss16MyIGLCRMFV/0LqHQ2YRpD2EGH0UlnzSCGSoxNcYZ/i7sQGR2HKq0tp9lp7iCETPkgjQupa04gXA/V60VFybTussBZFqXwOQIDgZariqFjAbWRvEVwx8eKhulTqdXNZ681KINZiCRSyzr2nUMur0Yx7aPQJJKHnKJ97u9u4jogNgXLh2l7LK8JX/iCtVZbrDcuP4Pbq3lzlqueC9u1v3dsv/6sZt6kyLfpQdKa8L8VE7M0XRJ46EmLcOSBXQ0CWmqVd9hNkcvA68zKySBrJzrF9jsFjn+y5DvfsCRTnbescdWk2LrGh1nQA7sn1eVbWVf/ug7c7axTD6zQIega4TbAn+5uhdsuPW9ZkH9EbQthfSLaEPqH4f78QpQN40SZXdIvDqo7kHLFdGOgy0Ao+pPvAijAb2OhPIljlwmTfDR/vHlAwV2OMJFjMLWDtt5hMxIZPpOp68mXbfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(86362001)(83380400001)(38100700002)(38350700002)(316002)(8936002)(66556008)(5660300002)(7416002)(66946007)(66476007)(8676002)(2906002)(4326008)(1076003)(2616005)(186003)(41300700001)(478600001)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iKIOIiWACpzUG09mPPXQQ3UyD7RXidpIDhTCOt/nSwYI9DbXoo+QcEf63Lvc?=
 =?us-ascii?Q?4DT9LN3Dgy7PI0XdhBcny50cg9ngoZqRclMKcbSer/KQja3RDpE9z71eR8UV?=
 =?us-ascii?Q?vgbmNgmnDXy2j3dIPQaAEL9ZhfqwWS63Fq77/bPftmHddv8+rW1+iiBlLROH?=
 =?us-ascii?Q?KNBo+PNBwRedKWWYLdu0X0hVhE63CTYISZs2Bl5l97kZ2Ljf0RPOY5ebaLR6?=
 =?us-ascii?Q?mdz/1LQGUsnIv9nWIqDX0xlzHq4INyPIId0TgS2XqCQELTWaYdbEhRAlo+Mg?=
 =?us-ascii?Q?p/xJTDVTlp2vZLbdsBpqg4gdJXl3hlcVOplthwx4mGNj63bzCeDuL3Ey1T8G?=
 =?us-ascii?Q?D5cizS6CoWLmWYpwKD+ZUPvQy7OaJAv0UNYfGjUl8ryFJNxNjkQKDvv3QC2U?=
 =?us-ascii?Q?493IgtUYGTLigGDNWC1bRN1ILMIlCXSOMnNg9mgOwvIZQ5Xs+2fCEcfdvOLD?=
 =?us-ascii?Q?HvP0gzD2vr/0rCEnlckd+3aFHNqKY9rgA4QRa/1FmZZgRczTUnqSlt7ShZ6b?=
 =?us-ascii?Q?eKmH3LuD7l+5rizj8P3I0Ayw9jYre+fK+BnDzQXfpRZsvlFdV6E5buHi58g9?=
 =?us-ascii?Q?dEiLgytA9oQvbzgQl+VWnwf9Vk2C1YUE0FZl46bVLLxM/tfMyqqVDYfCjZzv?=
 =?us-ascii?Q?v2AYsk3/ELQ7peyEnXbLmAILwWCNFD8a3SJOm8cICJWqWMa9Z3Cx/T6+2/yS?=
 =?us-ascii?Q?2c6fNqnKv6KjyxxfbbtckvHJ81FWXC+SfgeMTUCMA4iMyHQgw7Q2a6yLwO0T?=
 =?us-ascii?Q?CeqmojjL+32HwOQ/hiDkkJIh3xpYFRE2F5P2mYsKNvkna5P144nniZ8uRffa?=
 =?us-ascii?Q?p4mCyUl8qoyUDqkpC7vQsWaAY+rhoF3d8Kp26KYilT8LL7ovGodeDN1TlxuL?=
 =?us-ascii?Q?H8U3FZ6upPvhW9glBKm4fJ8+wBTmLbk25x3X0cxG4WluG5Xw2nSqOXMRWmM7?=
 =?us-ascii?Q?gY3Ps1dVtqnGJjKBqE2cKGigHtRNXTJDEO9pbO2+HI9fqs61YCn3dV2o1Y+x?=
 =?us-ascii?Q?t/lKhDyslPE88kqzec+C/xWzyUzoNJL9xGURHLLObidnNYaRzBLuKvZIYZdf?=
 =?us-ascii?Q?mSPi3pD8TGSFZnn38fVPhMoRtMARv2O8428urn7q2NjEqFjG7VLtdCHaAaDf?=
 =?us-ascii?Q?QNO7IntDHB0QS/Rtzobft00M3CD2a+MJoirmzYRs5YzO8uGff2Lwa786+2x/?=
 =?us-ascii?Q?IBbJelGDQEZJBxzJUiFP719eDIGPWKYWzuciUWSMJTDUVh8MiBG/pyWChQeP?=
 =?us-ascii?Q?t/vUQhmXjlwJxP4cGg5IoIHoXyfAiCSI/TZ4XXbeiCUvCc0qo/2sw9vpdlUM?=
 =?us-ascii?Q?dvVXK38gKO8KZe0fT4BmcBjrYO1HBIp9NKREqEz1ruPSoKAc2kBX9LZwxk18?=
 =?us-ascii?Q?4xinBEBfHgNPR8u4bAoiRUHTyu09yJ6NMb4Vai7vt0dlXVqL1Eoo6N1+efNn?=
 =?us-ascii?Q?bCjZMjDcg2vJwiZU42DMii6OwUTuOBR3OPDCmB0GhLO4kZ8UkfzH+zyhXiqy?=
 =?us-ascii?Q?+1i53Jsw4JUcEXHy3KlQLmHujebxicL8H46JUXTfbo/RLV/V+uFbDo94YTbK?=
 =?us-ascii?Q?JV4i6MEnfw4aWLDi+M6ZZQmWyS9W7nNCkfhenqmi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe2cd4-7d7b-49e5-250b-08da8403d5d9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:02:03.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7QIRSFBRNG+TMWo3Glhy2l2oSbpy7TIoNB7210tRGryuUmyIqoyFoibtkKUDLz9fmS9MEVbkI3nGmkh8mNrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

