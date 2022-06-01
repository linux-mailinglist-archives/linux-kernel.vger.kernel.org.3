Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EE53A0DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351300AbiFAJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351239AbiFAJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989DB5F27A;
        Wed,  1 Jun 2022 02:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwrNYEKlxzpWCeyqNkWneLUF9x/ZhsKKVrpZ4ghzB5/OIfk7y+Gvw2Pbw82V3cA+HSjYh+DSx4Z8nES7tVei071kSzia8w8pq/6PyDjmCgFHXpw3GNknKuA3g2pNSqit8565c4DU/Nw627rLUnh/WmJhnpunA/GgF30vG+o7V/9370oyvHbFFRy6OopHyjEF6RBeH3Lwfjhj2+0k4UdS0SXLUo7EdrXSSCcm+90Gk4+jupD7oEJiPYCGxKifUBtsASmsAIScnqRPfOB+XRi88DhnM9XXqgMslmDiUf/g1feKAwAc2fk+ISEEo6tDOYkLq/R4QKuuHe1YmebvbNVwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AvRAFscH+weMPoKrvYVn+rh4jCHsUAc0e68jwJ5m1M=;
 b=UZVs5P0avJ/AjChuUWg2BOEsBqD1XyixIoz9gu0kiy+LCKDF8p+AdkXbP/+/uGS58Gdodmv31tCs+pXXVW3nOwWBBIp4kbiEwQ+be2wvJBr1kS7Dm7MtjLxxv1LJfMnj+TqYMDdX0E1OlQEvkcpiOkzhurrRlbOxnB7WXElnXUyQqZoSyyEvrzLxBkTp6g4g22FTuJuBYnyAnrHOTphJoDo2e5vETWUqhiRZt0bxlg0SrRshOBuvA7asgeI4F82myx/NpxSHlX9uwviSssWGYiHm5ovqcTPyyoc9r0sb9czyGfZJTiFMup42fciHSSLr2L499wZPzq0zNzeS3JXOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AvRAFscH+weMPoKrvYVn+rh4jCHsUAc0e68jwJ5m1M=;
 b=TzSzkYQX6Dp9BlabNTKpGxVKjK34s7Kez7+Wr/gQ2zj3dkTQ90WPjzFGsOamnZtJ4tAJ75hIYz0va9DV2lov/VArADeHsWdcl6135X9nxzFmSRv9c7uoy6Cy4f92QlKnT8eXPsMxKmpyrgyGZV3dsbi4ugsRAHlS2u4MQLNOkZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:44 +0000
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
Subject: [PATCH 5/8] interconnect: imx: introduce imx_icc_provider
Date:   Wed,  1 Jun 2022 17:41:53 +0800
Message-Id: <20220601094156.3388454-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90afbc5b-3cea-4b61-58bf-08da43b2cc97
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB64987A8DAC8D70DC40A3D82BC9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChOBhrL/UCwnMxqVFn+GHlH9x9yx2C45W/7fki2ZXjZXKBkjBQCyhAvnmvpJjhgvzfoo/jh0ACvHf3ynqgyzAt10SlC318J0sI/Lm6rYqh4gU+MijRteU26bI90czV/ZDTQmj9nR8PIGYH7Ym77U6R7yxWX62P6HdB+DBSljAfHqpSu3EDkI+bF8Zb8jO/JSojBTsAys4k9HbtaRj4c/jxRHsz81W+jtNJ8TTeNQaAkawEkgZUg7K1SOaLSXwBLt7H/hOkNsl7GfdrZG11xq0H06PtCqFudLm+yRAl3UpLKJt50dYd175NzK9dE4lprF71DpPZGpMHdvei/yW2vpsNQMrUVJcRtkwo9/eSV0CFgNCbSoIlEuYLzSVtgkNzb5RHeJtNB4f8WcoXwW0i/SSVKLxMmteZWTy4O0Ep7/XiM2lRDMrjk7lYj4FI0dTCJVwn5DUhG6tp0FYY3g3XU0B8vi03RcD0i+JRX4cKZxYYV+0KI8xx0GZBxuR1cPk0/139vU5IL7p8zQ2E/Llgm20QByMzcqVzURiDzmoVa9T1X8dK6xy2D6ZUIv6yR5CqZnzz8j7KmTWu2uZJfyeNRHrLrrrhKIv5WdCqVGDS3cqN1T9af9Sl1Vwba3GnJ1aFytWBpyCwlg+AHCpN8oOrLceHfjjJCsMKlp882GnSsTgc1jmZpWCgFXCV0ZVBSRkjPavMMa+q/sEiOTaqw1hU8mAT8yeA0wfHnFO2EhrUrHjN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(1076003)(7416002)(86362001)(26005)(186003)(38100700002)(38350700002)(6512007)(8676002)(83380400001)(8936002)(4326008)(66556008)(5660300002)(66946007)(66476007)(921005)(52116002)(6666004)(316002)(6486002)(2906002)(508600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcglEW+mzdF1Fr26gLxrEJP1GXYFYqPI/BtfKRFJ7mFinaE7p0kJcp4nv1Wv?=
 =?us-ascii?Q?PIh4YywMAI+EmNUHrSoWlXnpKSgHYG5k34KMbhTGU5vTwR5e71r+cThPhyqz?=
 =?us-ascii?Q?vlnRnELt0tXgANprwFs+bFhqgXihv3VKZF3ljfXeVde6TEHMCxXdeNl9VDED?=
 =?us-ascii?Q?BdM8mhHGT5Q0EsRViojLmJHgZoq3iQ3YRUryBBICAg5uYv1XsAO9VSrb6JTO?=
 =?us-ascii?Q?hIw524pjgW42QqUZWndAouGJ4Qi08HSDKyly2lfwcijKGujxsiDctN7cjmfx?=
 =?us-ascii?Q?VtiBEQDWiQSYFFEqRAHVwvRowlBUdXM8lxTAQsVLvokCU12XqRSVRyKWPpP5?=
 =?us-ascii?Q?Tmw1dVMCc+ug6HGoj75rStjrFhL1hHhM37IYLfdGoXOvLTHHJqbUBzet6Lsz?=
 =?us-ascii?Q?RJnjiT/AlOi3w9sNvY7HB1RGxn0IuLEW9iZmII6c2za1L55LzUsf8gPH8wlt?=
 =?us-ascii?Q?ahw+HSF04tdW7s1lD9nzm428yYzbg7O5Vi9e466j4uWrILR69RqVLmB00knV?=
 =?us-ascii?Q?0MK465q7nsYIssdj5/tPtTAyHdUq3y97ZAYJ/xLTAv7gRrTNbDReLmtMnKxF?=
 =?us-ascii?Q?YLiyuvQX3rNZL1OBtD+ucB+ir+Fz6BJl0GHyCfNz3eRDRXYwLiQnI7RGGl0m?=
 =?us-ascii?Q?DmEAdbvRH6P9YH1BjSfooKs4YZz/AS2Jwv2Fz+HDMlXxsv/qh5SA/IkH8RRg?=
 =?us-ascii?Q?ffDgwjdx1hBNzXSTA6HbOC1W/8/ExcEZsI/pG5E0eNVoyTqTl+5Ap+uOUqeK?=
 =?us-ascii?Q?BR2MoIun4FwcRuPPXS2qjTtYYV76hsvou7XRlRCNZgVQFU6N4P6Xak7KXEdb?=
 =?us-ascii?Q?nlAD6MjX97dgyXC5I6s1DDou2WZvLDMNyetvxEZ4UwPMIoE+z7yF1aVUyO9s?=
 =?us-ascii?Q?coA77FJBhR0yP39L/VMEsq/pcRXRg1OSUH96rn568DUGfqRmFVtb9aull6SG?=
 =?us-ascii?Q?NRNzAZ/XEZ+Xr1eOtM31fRJKheMADIBtcXkwbDyK6iH1gtbm89gpWGZLbH+T?=
 =?us-ascii?Q?GuzzlIgiDoJ18xHsdOYCmk4KJLIyGucXZ6mCH4s1bday/VI+jqAX1UEHS20V?=
 =?us-ascii?Q?VDNGc8ucINh6/qaGSBp9NoeXJU3OJCtrGPuv+PzVKMH5owmDswfOLC6zADjo?=
 =?us-ascii?Q?m5JVmbLO/xf/p4P6HJJQRSootEnM6rjUIoE7kbroU5aeq6u6rFs9eu6H43A2?=
 =?us-ascii?Q?Fjehfz6GhOY+Yjkia6bry9NJJw87WwAhtvmVtv6z0eNtZirOIM2wTLvVu3M9?=
 =?us-ascii?Q?83n/LXkSNijWgGyYlWN/ltJOeIMN0wjEKB8U+zO7ZkUZtGgmWlZyKlRY50N1?=
 =?us-ascii?Q?K/Z/9xPcI9Ry+k33Obl2Ri2opJHgALzkjFxy+4rbJ51ttKrJ7zwHlToIUe/1?=
 =?us-ascii?Q?crDMlAuXRZW44bljYn2jYlpHB6d6+Rmt7pWvgI9UYhBrDjiJKVJqc9R5zZCF?=
 =?us-ascii?Q?RVnyZliFIkD5FbfosTKKrOq2EQF2rACc43OvWxG4EvWtnNMEmxoxSfbQsp9q?=
 =?us-ascii?Q?9sZiuCYpmF+TU5YbfWXwIutUeLKuCFkpV3kg5WHHrecYwNtCQHwTzoQDbOs3?=
 =?us-ascii?Q?m1rVi7BQrz0OCU/5cxzfkt4utie5+2wN+WdghhvnCjXwjVOg1grweJQyeQ/V?=
 =?us-ascii?Q?/R7OGwwA5PNymcPLUi/ESKyZfaODDVzVSDISPBHHbuttJcG9BeNohTbYCF58?=
 =?us-ascii?Q?NTp7cxM9zzYGpXkEnGZXg5SrPik0fwNCa75NNEkBoj/JoD6TJDOSU07PCEaH?=
 =?us-ascii?Q?g9fa8t/4fg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90afbc5b-3cea-4b61-58bf-08da43b2cc97
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:44.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUoPlTzuIGAIEiG/EJenmkwsIO4Hsk/xSQ4lqneMHUDcm30ayr/O7xODRFrnNHGoZXJgv32MiosWVSqps3VOpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_icc_provider as a wrapper of icc_provider to
add i.MX specific information.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 24 ++++++++++++++----------
 drivers/interconnect/imx/imx.h |  6 ++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 1ba906822b7e..f381697fb23e 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -134,9 +134,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 				      DEV_PM_QOS_MIN_FREQUENCY, 0);
 }
 
-static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
+static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 					 const struct imx_icc_node_desc *node_desc)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
 	struct imx_icc_node *node_data;
 	struct icc_node *node;
@@ -184,10 +185,11 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 		imx_icc_node_destroy(node);
 }
 
-static int imx_icc_register_nodes(struct icc_provider *provider,
+static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
 				  int count)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
 	int ret;
 	int i;
@@ -197,7 +199,7 @@ static int imx_icc_register_nodes(struct icc_provider *provider,
 		const struct imx_icc_node_desc *node_desc = &descs[i];
 		size_t j;
 
-		node = imx_icc_node_add(provider, node_desc);
+		node = imx_icc_node_add(imx_provider, node_desc);
 		if (IS_ERR(node)) {
 			ret = dev_err_probe(provider->dev, PTR_ERR(node),
 					    "failed to add %s\n", node_desc->name);
@@ -239,6 +241,7 @@ int imx_icc_register(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
+	struct imx_icc_provider *imx_provider;
 	struct icc_provider *provider;
 	int max_node_id;
 	int ret;
@@ -251,16 +254,17 @@ int imx_icc_register(struct platform_device *pdev,
 		return -ENOMEM;
 	data->num_nodes = max_node_id;
 
-	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
-	if (!provider)
+	imx_provider = devm_kzalloc(dev, sizeof(*imx_provider), GFP_KERNEL);
+	if (!imx_provider)
 		return -ENOMEM;
+	provider = &imx_provider->provider;
 	provider->set = imx_icc_set;
 	provider->get_bw = imx_icc_get_bw;
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev->parent;
-	platform_set_drvdata(pdev, provider);
+	platform_set_drvdata(pdev, imx_provider);
 
 	ret = icc_provider_add(provider);
 	if (ret) {
@@ -268,7 +272,7 @@ int imx_icc_register(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
+	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
 	if (ret)
 		goto provider_del;
 
@@ -282,11 +286,11 @@ EXPORT_SYMBOL_GPL(imx_icc_register);
 
 int imx_icc_unregister(struct platform_device *pdev)
 {
-	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct imx_icc_provider *imx_provider = platform_get_drvdata(pdev);
 
-	imx_icc_unregister_nodes(provider);
+	imx_icc_unregister_nodes(&imx_provider->provider);
 
-	return icc_provider_del(provider);
+	return icc_provider_del(&imx_provider->provider);
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 75da51076c68..0ad2c654c222 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -10,10 +10,16 @@
 #ifndef __DRIVERS_INTERCONNECT_IMX_H
 #define __DRIVERS_INTERCONNECT_IMX_H
 
+#include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 
 #define IMX_ICC_MAX_LINKS	4
 
+struct imx_icc_provider {
+	void __iomem *noc_base;
+	struct icc_provider provider;
+};
+
 /*
  * struct imx_icc_node_adj - Describe a dynamic adjustable node
  */
-- 
2.25.1

