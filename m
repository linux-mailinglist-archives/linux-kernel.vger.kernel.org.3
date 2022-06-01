Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72853A0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiFAJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351156AbiFAJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:41:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022595AEFF;
        Wed,  1 Jun 2022 02:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEYK/XF7i3gnC4L64nur/4FFO/KAcXxuLkeLyfL6XDPC+GBGUoPVmtqGSvSXXDalVOdsUKJ032kxjNHaq883b+njFlokwj02ylHUxvM2sXBY4qojuiIsTGzNlhNHJbq+T2MJcKzHJd2qqPc5MOAJGUJNVXQmBDU0WqMzFHLdmt5UkqU6F7aaQj8TJYgEOIDeG2UKsgdmtgpk3M4zGCwrCGdkUrLkUXIW3LAVqeDq54QfRxXdm03Me5s+sDl18MRriphTR0UP3KU9XlfH+8TtWhfMcXVctM0L0ti+1uKJVN/06Znq6J3v09kTsUPMai6MS1rqf4ymN1MjbIggSUvA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9V9sK69njSkGe+bsKqGpTFzDqe5r+arZoyeFwMQEKg=;
 b=ALkyw0YVtb9F9/QMlZlMPjfnmyBOmZTNoGm9SyPWMdL4pn2BVnF8KPOB4nAN0GHwFLaUUW9OsNpXLAOPXtF3pS+XefCYI2y6rNHjHEWDimy4nxw6ihUpaHij8W1Z8ZgVgvr3fuJCWjji+N1MLfLjVVk9sG2dj1m7p+ItDfndeSlJQm7j/baQlNDYzKcNd85qXw9JFxfzlTB0dUo4jVcZdvHPEToN61FvXCtp41XK6+eN149PlwGid3nKWDM8YEy/zZihsCKdDzYvmNVb5PwsHwqGLBWCQ7SNp7tWzG5cqcXqE6EPdVkIW5iVNnXDCJ+42/HnrjQfYVryjD1c1JT9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9V9sK69njSkGe+bsKqGpTFzDqe5r+arZoyeFwMQEKg=;
 b=jiOA/3OMpyTQOUxpRAcAeGr+wkP+z0bVbxcRUWDLQ0HKiWUm9EGSNXsmbHoKZq43igezZc+mn+3SUA8Q3eWO2YIZMf4t5jast9xyOphLpEwr1CyNCbcfilyT4J/hLrJdm6laHzd1JstN7IAgyXZCHblJTng/pPWVrSlYTvKwc98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2441.eurprd04.prod.outlook.com (2603:10a6:3:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 09:40:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/8] interconnect: imx: configure NoC mode/prioriry/ext_control
Date:   Wed,  1 Jun 2022 17:41:55 +0800
Message-Id: <20220601094156.3388454-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f952906-e616-4436-a216-08da43b2d3e0
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2441:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24414E5DC7FD82B9A3E03866C9DF9@HE1PR0401MB2441.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNIZD06E++jP9X30GCA/grxI0yy8T3QTI5MAIhqPK6GMdxIf21ULjsuM0SHKQ4ZZ/vQcz3/JWa7qttD1I/+1MAeYkjdqHXXp59EUmuT6wP7PHcygC+Jz9p8oge3lGd+Tt/lQxtYO0I8ShCfBjvcabiWK7oqgnAdsh06/TUMCPaGDls8ScIzMxHxu9eGcJQGnoF4TNLILIwCa30RRR2wl7lAuGRwL57OZ1mui5D64S2hNouF0UF3i0fo7zjCwHqNxHZlIHQxeCmD9P9ImkzyEHAwEse99VS2w/yNAZdhy96N0j03O87DWKPP4vKTN3b6G2LriaqLd46U3rnGmsNeDLE6tomXCn3zYqnnPdwAsOSa6xsGAC7xqXaK4SG+edrW2NDcjPY5PVtIM+dUeCpwSmQokQpFD+LC5v+wUAWLJq/aznXTPgMPyNGS/73Toq8t+fQc7ccoXeGXxa5Rxxc/7kYuSu1cfb3/QxWE+L3O8TAaeuHf/mfhLMgj0WljY6zv1KjNu/t9Uqof4Al6z2nHkPaR4Db0qzadE62OvZkhv5ZsxplTr/js3qKFivBygg5kUUosnHz7hg4zJAs61Q/IOAzkUvks1M45b5/njTaHbZeAHgOooH2xYapXmD20cREucPwyoE+XsWv0KEJ6buAvaOvIhdyah9nOXSiXHXPjXEmwc1zO2B+aTff19zSEThzzCg/EQQtuNo6ivjKIvOv+J516g1LXH/hvpogvtRoCBR9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(86362001)(38100700002)(7416002)(38350700002)(316002)(52116002)(1076003)(8936002)(186003)(5660300002)(2616005)(4326008)(8676002)(83380400001)(508600001)(6506007)(6512007)(26005)(921005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VS6ooiRKapHsMFSlwP6EjZ0lZRbg5bfuJTw2L4Non6oGx7DHr3sA8RfGlYvV?=
 =?us-ascii?Q?dqZhka1Nt/6/r0P8quPeQ0jtsxBFcvk5xlKg2d7AaXOyljnqSHJT1BieJCKY?=
 =?us-ascii?Q?tZ2MiD+LyIVIXSK9/eb9enoQYfC8hdSCLp6N37oQc+Dd8wAxrUyVIolnH8+0?=
 =?us-ascii?Q?LJ07VqrfcU3prvYGnw7/9igsHn+eyWzfu5GCSVNcKWmzdJMd71qaW1Ny867x?=
 =?us-ascii?Q?kA7Vr6TttbV97x7cUkmE/EySwW0HxImTSO1Gggrfhd1/4+Nxa50TcQdo7L7O?=
 =?us-ascii?Q?IQ057jSs0p7E4PkojUA9nMdttLbJCXR26b2oRlU4VDqZW0hfF+SjXtkSrklh?=
 =?us-ascii?Q?QZsuLlkm5eM125xv+GrCh9/HqpyNmLS2eN6GYM10RDsOH6CLvwZbIIh7OP0L?=
 =?us-ascii?Q?gIMmHnpWb1ysSUSKwILin0njjGul+/YbZaSkQszciGNkW2cuanzTQyCEKSl1?=
 =?us-ascii?Q?LoN9hQLx50h+4TRTlrzUeaPOr2uVtX/CIKr6K45c1BT9oNKexUrIeOTLso6m?=
 =?us-ascii?Q?GEm9dzfCLsfnYBV2mjQft9r3+ezTnPrPHeT1h2pBfs1tkwk55EOjZpfDhsyq?=
 =?us-ascii?Q?65k4Gk/d+pfr6R4GxhIlsjsnSBu2v6ggo20i7juYPtIS8TwF5VgaTst2BC8L?=
 =?us-ascii?Q?QXlR96C8y3g++VKtGSdx21OdPVbYjcIrcJlmwtodibFXD6Hp1Msq1syQ5WS+?=
 =?us-ascii?Q?o8MQpgWorAVTC/PaTsVT3t4aAtz+bvfxNNIzXYCXFjFw2yQkYFv8x5ODb+t4?=
 =?us-ascii?Q?cL9Z/qMJHCa1IlFoN5DuUBur8+AR8ySGkdnYg7+PVwMa/WMxLJxL3PsVVbyd?=
 =?us-ascii?Q?RFFwVZVNRZiR1o/xWwB/dl4SRgf83isnjXF1fyu9oOONvEiL21BTmIsLpQI1?=
 =?us-ascii?Q?hAO8w/ijikCBgUGgjyG6QMRzc0IahuvE36Xxz1KBJyn6EN2LaN0tTNxKVWF0?=
 =?us-ascii?Q?zXUjwmoFhA+pVmkmH6QqCFSn5iSZPA0YKFlgBZBhqyYSzqJ8czaGweyYNzYG?=
 =?us-ascii?Q?/PbnMtJ/Rkysrj6hxAh7OaJ75g0h+2CKBl+foyJcM4gr2UP7Fz94+jIW8MYH?=
 =?us-ascii?Q?uBGwv5C/a/ITtdkkz3lUSme8wAt3PCybKda52pmNjHi1Lt54Efapsr3SYBKz?=
 =?us-ascii?Q?6THpd9HcdxGwTh+HcFpz3u5OM5tvgPEdIZhQBeJ20/SkpWA5h6ebqTdBHqR9?=
 =?us-ascii?Q?yh2bDRxUk701rRxvDRpssSny4AqSxvSrYBqKqt/soiaVyr0bylnYsT1JBnT6?=
 =?us-ascii?Q?rwZlEDp1RGgQTzzaEssGqgOOM4rD4yHlZBw+7pLXRyCAAADW6acSrLrxnBPs?=
 =?us-ascii?Q?el6GH490N1g1Yvl29Or8XLNC3vdpZFUHoiz0D354BSKnb6z4EhLo3F2r0aag?=
 =?us-ascii?Q?ELASx5P7dnU//wiM1zNnh+LWiGFRU8gs6agv6p/y4jR3bplgZuHKcHVVFIra?=
 =?us-ascii?Q?RpLVWOP25KWGkPcYM+n6Qwy2ELlho0hdBb7PZHogm/BQxKACMLiQ9a2NV9qd?=
 =?us-ascii?Q?F8tdCItGsyLAjrIfO+cJ/8/LuuA5nQ7TCV7+UPVy3AFU+s9+D2US/K684AZm?=
 =?us-ascii?Q?zePx9+rTCMS/sVsmnDM2enom774MwPH3j3qqMFEv3ZaJD/sq4k8+pffrDsgk?=
 =?us-ascii?Q?rn0dpApvICTPscV/ZDV+9evWlLFZB1NsRGy2RFf9ATxWy3xN0WbKxzy+RHai?=
 =?us-ascii?Q?Qk/q/l/VrVnEnHu6ZzLY3IzE37BifvyRIdhFoAP/aLceGO6Nka1NMLqe3Iyr?=
 =?us-ascii?Q?Rjn3Dam1Ng=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f952906-e616-4436-a216-08da43b2d3e0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:56.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u37ftfL664pFc28AghMmijrQBBmVa9HPIDcHUnZtbMWFLesoFUyEL1/xGGz1cLtamiE28nr3i7AASxVAxu4OZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_icc_noc_setting structure to describe a master port setting
Pass imx_icc_noc_setting as a parameter from specific driver
Set priority level, mode, ext control in imx_icc_node_set

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c    | 39 +++++++++++++++++++++++++++----
 drivers/interconnect/imx/imx.h    | 19 ++++++++++++++-
 drivers/interconnect/imx/imx8mm.c |  2 +-
 drivers/interconnect/imx/imx8mn.c |  2 +-
 drivers/interconnect/imx/imx8mq.c |  2 +-
 5 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 08e3a91d2543..bbb6f4b32b66 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -18,11 +19,17 @@
 
 #include "imx.h"
 
+#define NOC_PRIO_REG	0x8
+#define NOC_MODE_REG	0xC
+#define NOC_EXT_CTL_REG	0x18
+
 /* private icc_node data */
 struct imx_icc_node {
 	const struct imx_icc_node_desc *desc;
+	const struct imx_icc_noc_setting *setting;
 	struct device *qos_dev;
 	struct dev_pm_qos_request qos_req;
+	struct imx_icc_provider *imx_provider;
 };
 
 static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
@@ -37,8 +44,16 @@ static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
 	struct imx_icc_node *node_data = node->data;
+	void __iomem *base;
 	u64 freq;
 
+	if (node_data->setting && !node_data->setting->ignore && node->peak_bw) {
+		base = node_data->setting->reg + node_data->imx_provider->noc_base;
+		writel(node_data->setting->prio_level, base + NOC_PRIO_REG);
+		writel(node_data->setting->mode, base + NOC_MODE_REG);
+		writel(node_data->setting->ext_control, base + NOC_EXT_CTL_REG);
+	}
+
 	if (!node_data->qos_dev)
 		return 0;
 
@@ -135,7 +150,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 }
 
 static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
-					 const struct imx_icc_node_desc *node_desc)
+					 const struct imx_icc_node_desc *node_desc,
+					 const struct imx_icc_noc_setting *setting)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
@@ -164,6 +180,8 @@ static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 	node->name = node_desc->name;
 	node->data = node_data;
 	node_data->desc = node_desc;
+	node_data->setting = setting;
+	node_data->imx_provider = imx_provider;
 	icc_node_add(node, provider);
 
 	if (node_desc->adj) {
@@ -187,7 +205,8 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 
 static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
-				  int count)
+				  int count,
+				  const struct imx_icc_noc_setting *settings)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
@@ -199,7 +218,10 @@ static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 		const struct imx_icc_node_desc *node_desc = &descs[i];
 		size_t j;
 
-		node = imx_icc_node_add(imx_provider, node_desc);
+		if (settings)
+			node = imx_icc_node_add(imx_provider, node_desc, &settings[node_desc->id]);
+		else
+			node = imx_icc_node_add(imx_provider, node_desc, NULL);
 		if (IS_ERR(node)) {
 			ret = dev_err_probe(provider->dev, PTR_ERR(node),
 					    "failed to add %s\n", node_desc->name);
@@ -237,7 +259,8 @@ static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
 }
 
 int imx_icc_register(struct platform_device *pdev,
-		     struct imx_icc_node_desc *nodes, int nodes_count)
+		     struct imx_icc_node_desc *nodes, int nodes_count,
+		     struct imx_icc_noc_setting *settings)
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
@@ -267,13 +290,19 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->dev->of_node = dev->parent->of_node;
 	platform_set_drvdata(pdev, imx_provider);
 
+	if (settings) {
+		imx_provider->noc_base = devm_of_iomap(dev, provider->dev->of_node, 0, NULL);
+		if (!imx_provider->noc_base)
+			return PTR_ERR(imx_provider->noc_base);
+	}
+
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
 		return ret;
 	}
 
-	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
+	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count, settings);
 	if (ret)
 		goto provider_del;
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 0ad2c654c222..5fd650e61186 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -44,6 +44,22 @@ struct imx_icc_node_desc {
 	const struct imx_icc_node_adj_desc *adj;
 };
 
+/*
+ * struct imx_icc_noc_setting - Describe an interconnect node setting
+ * @ignore: indicate whether need apply this setting
+ * @reg: register offset inside the NoC
+ * @prio_level: priority level
+ * @mode: functional mode
+ * @ext_control: external input control
+ */
+struct imx_icc_noc_setting {
+	bool ignore;
+	u32 reg;
+	u32 prio_level;
+	u32 mode;
+	u32 ext_control;
+};
+
 #define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
 	{								\
 		.id = _id,						\
@@ -61,7 +77,8 @@ struct imx_icc_node_desc {
 
 int imx_icc_register(struct platform_device *pdev,
 		     struct imx_icc_node_desc *nodes,
-		     int nodes_count);
+		     int nodes_count,
+		     struct imx_icc_noc_setting *noc_settings);
 int imx_icc_unregister(struct platform_device *pdev);
 
 #endif /* __DRIVERS_INTERCONNECT_IMX_H */
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index 1083490bb391..ae797412db96 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -83,7 +83,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mm_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mm_icc_remove(struct platform_device *pdev)
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index ad97e55fd4e5..1ce94c5bdd8c 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -72,7 +72,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mn_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mn_icc_remove(struct platform_device *pdev)
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index d7768d3c6d8a..7f00a0511c6e 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -82,7 +82,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mq_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mq_icc_remove(struct platform_device *pdev)
-- 
2.25.1

