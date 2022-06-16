Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5354DBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359529AbiFPHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359525AbiFPHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474001118;
        Thu, 16 Jun 2022 00:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYS2Ah5aFEakQFOpAjJzM6P2K9RvP6AaNOgTeLDIM1PMJj88jFfr+cnxiKmYkomJ6wAQkkvIw4tz6jDS0RvkXX8KR2ppLCcvd3XoC8Jt6VS9SBojNXfvlw0JjJLtDkbWXqdETelTBq+W2CsatFjLt+89sZpu8IvrTCEqElgmwtKFdoj3YxS7e8WQIN5qn6tIXoGVvkX+wvrdiSiuzXQ6o4RB9bQa5rRRZ+2k/ZBsgSnayxvZsuV34uChIJ+nbMvAGS9JwCSPgDjCFTXkcoNFsq0lMPiQEGUNF/MN3B/EiFheuhlNggNS0kBkdu5zU/pXwjiv7wwOlFtVEvxogTMxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyuhG0Ti1frXKqnfihyxiVrF8r9wwXPcljbsvOjHiVU=;
 b=P7+vdiM0WfWmbSiiIVCgZ68nb9eZFFHyvEky6q1/bk5vckA5fPSCVguBmHufe55bREFr2yPcj+lkfiIeehmsaDB5XmLfT83fPFdr/p1fqgzpe4n1pv0sd0DBnvYcaidf7RNpiCI1wn51y3+kakt3xWlUlIEHU9F4GodroVgdwnOpuXDNsckFJogCoty3VKOBfDBDcnVCm5L5fuBd5v2wiqq6YerER4m+3/he1cbN/eMAMlok//t1OogLtE9+W/NqYJWBNUd863slTEr5fqIUJYp2Pyr1f7eCppQw4FUiiQKR6FX3tm4aY07UDQN66QtFM9K17fHgc0jeYaD5wwwMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyuhG0Ti1frXKqnfihyxiVrF8r9wwXPcljbsvOjHiVU=;
 b=hXIiy22T6seYVSPUgsz/75RyCb/ngvbavXFWirKqjR18LkXZYGSGSFh6O/tE5W4GO+mSvUeKqdxZASrZI7BfbZxqinOr7u1OJYFm3woO3DxUGeSnB16c4NVLXXdM28uHVLI69tfYiVaGFS8vl80bxiOv+Z+xG6lXdkLNkOWPgiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:32:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:31 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 8/9] interconnect: imx: configure NoC mode/prioriry/ext_control
Date:   Thu, 16 Jun 2022 15:33:19 +0800
Message-Id: <20220616073320.2203000-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38ca2e2-a27a-44f1-b694-08da4f6a5f43
X-MS-TrafficTypeDiagnostic: AS8PR04MB8435:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8435E1F777B77CA0227EC4E9C9AC9@AS8PR04MB8435.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icqjnL+I6Y4MFJ2LWZYyyjmjZPx4lLtideOdBs1dk2G6wo60kn4+Q7LGAhbQyqb4vdPXs8KPXpoKmRrhR3wnoivl+klJtBDzdtvAeSbgWmLgqEq7JYdnKQx05CmkO4ay+Mk0s8gy++KinwHNLT0gMLaqNWMpmeQeBKe5xwHrJ6kHcQS0YZE5XY2exs9/ZhdT8mNp4wMevbqCZ8bIxtYLnAIC9F3fvMUnGJYCEv2xk5gDF7Bby4WN78sAKayR0dwa4V1hu9b2wz5BN0klMia4T5svWV8S6k1FAkEoT2cE6707TDAFnCxLU7ELAqbbyDcqEUtjNn3HrlQeUuPq+qqoknjUOXrcbBsNNbvGuCeNp1Cc73Xk6z0XnPSecq3dKp7YmiFADJSnXaOYuuUb6/LFQoY5QQukFM+LlMOzJuOQDYMkOy8awInbPvJSdqRoviM/q1zYUlsAAbYossWsBSTx1A/PrKV8jEeKHvKS5vRyU8+MeF1+sftgdM22rxH8can1rYghYvSPCqLdXV5f/8sla9HkQG0U2rVXBw5cXQHpMfX+cyh/MGFY7ijFkkqKW+CWWKlrAqtU6hH2TiUtKw+ecSiLJgfffidTOR7FI64KmG3sJ3sNQ6I1JDJtNWigPz8ou3U4w1Qx4r6m3+8owJX+icrog5VkyF6cZNrSbg6JJivZhTFhr6UHFiBaJopkAWYO4CH5Ubyc7k+5hVgHFt86Xf8cP1w2Cdpx/S7Ff0h/K2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(316002)(6666004)(6512007)(52116002)(66946007)(66476007)(4326008)(66556008)(8676002)(2616005)(86362001)(83380400001)(6506007)(921005)(5660300002)(7416002)(38350700002)(38100700002)(508600001)(2906002)(6486002)(1076003)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMH+hlqbHrK2/ML65zvwm7wYZHz9OgrLe2kk0jraLhEI+ncsbYDci9hBDswG?=
 =?us-ascii?Q?fnh+rXWXtkAlAKSszNY+frwYwDO2xU3V79oxCD4iEZ9hB8BLKAM8lm+y65nN?=
 =?us-ascii?Q?LjfZjDXXtwWqxlvjsJyqdkPj/QwwtTkyw+SGv2iOlQIIkaKOOdtdxNF+sN+o?=
 =?us-ascii?Q?aSVBvB4R+2IPSxgTaEzxwB7R3elv42Yn4+OiOtElVABcAD/Rbd7bcWBLEajx?=
 =?us-ascii?Q?OUqN3mfIZABBdP804NEhIRxEuS61XkQwVM+YAl+lph5mzRSW+FUzFXofvFxd?=
 =?us-ascii?Q?YB0bNCudpyL1k0OPRyF5g1ZLwT72T7cHwKRZIsEg2PML+5/fXEQZm+jrbc7S?=
 =?us-ascii?Q?LaBNOa0qFgp4OEAXwlcmZ42q2yNYAA+9wakvCSjjT9UXdgMyW4uRH+n6lKYp?=
 =?us-ascii?Q?dE8pBMIELZgg3LUnWpoJ5acV+Jo+Y/GE6eLsKBfMnxSxjwRBRmqGVO2M2exP?=
 =?us-ascii?Q?JWxXdDHO7tQtZkOzMCOL1ns39Dp6nmaUd2al8HMAjps2xDSHpMzJ4+tzULx5?=
 =?us-ascii?Q?NAeVoC1yq38SBC3B3IcMIxCbZMtAnM6DieLYPbyiErlampbLdpVFdsr4pvjI?=
 =?us-ascii?Q?mVfMANhulA2J/VN9b8bDvpqvsdQP+Qc6Mzn2v3rpOzuuvPX+ohhbiqEadjLf?=
 =?us-ascii?Q?hebsLFuwjtTZsHCrRpuBFy0DiBBcErmeC32uQRpeavFXzkCi/jLsLdmkFpWW?=
 =?us-ascii?Q?/MaaqGV3u2fvXchxHdLvew5beuuznlHrcVPXj6VwBOBQIjXnr8xo+6NBuicv?=
 =?us-ascii?Q?L5baAH8nSOEHf/7svrRBSQCKzMmneH2OWBmeZqv4vrixV2zqk7IIM/z+nHIm?=
 =?us-ascii?Q?8J100qUk6dsjmCuRF1olFl9Ga24hNDCHe7BhvfzBZD1oZ1wPVc+Oh1mUpbBm?=
 =?us-ascii?Q?pqPIe7CRRhZvl+wyDX1CX6/odh9xi8dQ21jLa5NdugS5bt8XqPDlgyXa1nb6?=
 =?us-ascii?Q?6mw5fwZnXjZ7P/q6i1fZ4raoQf4ZOjSaqrhHepIDBwLKcxtYBUTzRSumC5At?=
 =?us-ascii?Q?qVa9dMzuP++VPO93Ign1y6sLowFE+nNNLGymMRjEs7xZbYSY0Z0Pu15qicMh?=
 =?us-ascii?Q?hv0iUxO2UsW+dm2J5y5pwlrUC+5jR3PhfuY3qr2Y8bkWjoVgXndC7m9PlEuB?=
 =?us-ascii?Q?aO4o60sC8JqjwWq6aFJ0K5r3Wy1OoM5t5EWhXzVzikVMNAorlY3/wGWL8Nqd?=
 =?us-ascii?Q?hjL2UCqCxEPqiS0ca9lZjsFNVtZHWEPAZ0qjtOKAcd3YBi2Gn70S3vfpkHHy?=
 =?us-ascii?Q?YBCb8iF2vWljwkCRTCbkUgqad6GQCWKV11P/z8vcSSEOm/Dgl9twiXh0R31F?=
 =?us-ascii?Q?2VvVliEcUzWkl+cXTbyWY/f7Wyn8lwOOiW9f8H+Am12Do5YFLxyyQEdE+ZBI?=
 =?us-ascii?Q?QPDCk4TJMENhkxGU1C/c77wpR0qq+znDdEtkuIE+a9ota/ROLYE+GBUVtTPK?=
 =?us-ascii?Q?AQZSm0zoz0pwqKdaHH50Kss1m7B8z0JiwWhVk8t5hLW13HLeGW3rDH29OXv1?=
 =?us-ascii?Q?pf4zuRHaGo/8C4AUKQHqx3IwMjIcE3f4nBYggFIbd2gZ9gFONukOL8Lwitnz?=
 =?us-ascii?Q?YS77CKYLOWrLnVhDK7VGUYz6o91h+060nhxsO6gbbUpRTV0Fo8lU9sfqVRMV?=
 =?us-ascii?Q?fm442EAbO/TKh30yWo4uPhX7LsfD8AIxdR9H/DMI/Ucz2MZOsNJLh4QcFIww?=
 =?us-ascii?Q?prvzLSKZ1E2UqZ2eIkex5i4/vm/AKol9T6gms4zN+aZimSlDLim/XyeotwHy?=
 =?us-ascii?Q?idUaElwnPA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38ca2e2-a27a-44f1-b694-08da4f6a5f43
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:31.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGfT4U6SARCAdUopt6497Ep1S8RRljnJO7xCUKNqon1xzIDQML/K5URzN3Lq4YAB978n6l7Qlor8xRyI5ZFszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
 drivers/interconnect/imx/imx.c    | 43 ++++++++++++++++++++++++++----
 drivers/interconnect/imx/imx.h    | 44 ++++++++++++++++++++++++++++++-
 drivers/interconnect/imx/imx8mm.c |  2 +-
 drivers/interconnect/imx/imx8mn.c |  2 +-
 drivers/interconnect/imx/imx8mq.c |  2 +-
 5 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 78557fe6da2c..bd728caf2b85 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -21,8 +22,10 @@
 /* private icc_node data */
 struct imx_icc_node {
 	const struct imx_icc_node_desc *desc;
+	const struct imx_icc_noc_setting *setting;
 	struct device *qos_dev;
 	struct dev_pm_qos_request qos_req;
+	struct imx_icc_provider *imx_provider;
 };
 
 static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
@@ -37,8 +40,24 @@ static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
 	struct imx_icc_node *node_data = node->data;
+	void __iomem *base;
+	u32 prio;
 	u64 freq;
 
+	if (node_data->setting && !node_data->setting->ignore && node->peak_bw) {
+		base = node_data->setting->reg + node_data->imx_provider->noc_base;
+		if (node_data->setting->mode == IMX_NOC_MODE_FIXED) {
+			prio = node_data->setting->prio_level;
+			prio = PRIORITY_COMP_MARK | (prio << 8) | prio;
+			writel(prio, base + IMX_NOC_PRIO_REG);
+			writel(node_data->setting->mode, base + IMX_NOC_MODE_REG);
+			writel(node_data->setting->ext_control, base + IMX_NOC_EXT_CTL_REG);
+		} else {
+			dev_info(dev, "mode: %d not supported\n", node_data->setting->mode);
+			return -ENOTSUPP;
+		}
+	}
+
 	if (!node_data->qos_dev)
 		return 0;
 
@@ -135,7 +154,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 }
 
 static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
-					 const struct imx_icc_node_desc *node_desc)
+					 const struct imx_icc_node_desc *node_desc,
+					 const struct imx_icc_noc_setting *setting)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
@@ -164,6 +184,8 @@ static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 	node->name = node_desc->name;
 	node->data = node_data;
 	node_data->desc = node_desc;
+	node_data->setting = setting;
+	node_data->imx_provider = imx_provider;
 	icc_node_add(node, provider);
 
 	if (node_desc->adj) {
@@ -187,7 +209,8 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 
 static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
-				  int count)
+				  int count,
+				  const struct imx_icc_noc_setting *settings)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
@@ -199,7 +222,10 @@ static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
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
@@ -237,7 +263,8 @@ static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
 }
 
 int imx_icc_register(struct platform_device *pdev,
-		     struct imx_icc_node_desc *nodes, int nodes_count)
+		     struct imx_icc_node_desc *nodes, int nodes_count,
+		     struct imx_icc_noc_setting *settings)
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
@@ -267,13 +294,19 @@ int imx_icc_register(struct platform_device *pdev,
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
index 0ad2c654c222..1da87cfe27da 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -15,6 +15,31 @@
 
 #define IMX_ICC_MAX_LINKS	4
 
+/*
+ * High throughput priority level in Regulator mode
+ * Read Priority in Fixed/Limiter mode
+ */
+#define PRIORITY0_SHIFT	0
+/*
+ * Low throughput priority level in Regulator mode
+ * Write Priority in Fixed/Limiter mode
+ */
+#define PRIORITY1_SHIFT	8
+#define PRIORITY_MASK		0x7
+
+#define PRIORITY_COMP_MARK	BIT(31)	/* Must set */
+
+#define IMX_NOC_MODE_FIXED	0
+#define IMX_NOC_MODE_LIMITER	1
+#define IMX_NOC_MODE_BYPASS	2
+#define IMX_NOC_MODE_REGULATOR	3
+
+#define IMX_NOC_PRIO_REG	0x8
+#define IMX_NOC_MODE_REG	0xC
+#define IMX_NOC_BANDWIDTH_REG	0x10
+#define IMX_NOC_SATURATION	0x14
+#define IMX_NOC_EXT_CTL_REG	0x18
+
 struct imx_icc_provider {
 	void __iomem *noc_base;
 	struct icc_provider provider;
@@ -44,6 +69,22 @@ struct imx_icc_node_desc {
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
@@ -61,7 +102,8 @@ struct imx_icc_node_desc {
 
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

