Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57659F090
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiHXBJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHXBJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:09:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881ED883C7;
        Tue, 23 Aug 2022 18:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgZYsNGTmQHxO4JpcQvGwoaj+hhAxkpFHacB3JJbgEiIALpeA/pXCcCVzj65X3awZGaT/uXpBa7IDjINs//L6hmKI1QcxQx/OR/X3McUEKyF7PlL9hDj5BMsRhPfdWcrzIRIVpbPISUArEYg0tmvbRr5eVIu0YPQaEl6jKVp1LqCnOkkOO6Ld9ZtRt/ITuAiHIwaG2gLYNwLMF2vp8Qp86SK5yUJNnB9CklgTXl9K5+gw8Fskw+Ci8RFYKD9Wr7WzPp5UCuBCpCorOO2gtcmcgJu7KuLy0oUhTIfhrZKyVUmU+5ZdPagbomGbP5Ru71OYYVGJS35ocNKOdDas6SuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By1HjPEIvs3mgUq2ZvvggQGfUi8iRmZM767HTom8FzA=;
 b=SQYzrNEwZyOlu6TTprg4SNrXOkUohH0ZAHimWT2vJtWJRoWgeTK+uHXWGjYgVFFvPZyNtLDGyybqkGhe28An7oPpe4+b6AgyIHhwLOgIBnA/mtQeqtlv9H0U1BgMy9PzUtIeYPNmR3P2obztomE+GQBt4N956FG+2PXJX2WzCnm7ZaLXT7fMuPY/IdEv9m4v9ulmfOV3C/9ALAWjNowimqDYjIrkNu4bt7jCXuGQw0dSDzqOZrLH90vtgVqbUN4fqxOQIQH5rcGFzKbV63nVzmPECuh6QIIvoMLuYOgXavVU9A1rLBbVpm+bv9Z4i7y6MdIoAJYBa1GFbzYGJPqfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By1HjPEIvs3mgUq2ZvvggQGfUi8iRmZM767HTom8FzA=;
 b=h8jQ8NR6MUJzNczCfB94AJ9l4s+7LCXQs6jX3LytUZqRYgcfZMfyEsdwdwOZ6PzWtrgYRVXsGOV8iPU5HwD8bI+ngPnUdk7y0lsn/QMsuPPMeeCoNcdzQXhkP2TcuniQYHiSNhxmm2poPaB9GyWWLUzRmEScBRja+QDoiCYhlgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:09:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:09:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/6] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Wed, 24 Aug 2022 09:10:21 +0800
Message-Id: <20220824011023.1493050-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17968ff7-d061-40be-c012-08da856d3d5e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPTgP7h2d3M06HMaTx56u1TmNMkdd1FvHngbwJ1GCJugkpraNZ//cc3AT6d/wfUjf5pUuIDmdfcP/cLfh+seVvkPAK+JQrKYKbpc49BYCcgwA5CB7C0n0RB8I8KclDIWWf3XqvI+nH/XLgH2KhdX0kSCHQLgmT+xBL8nunXrg2zNgL2/dFMROzn1xoBLH1lkxKl3qQXCCTWpwZQB+dAtdJMgBXaara3a2QcvuWgo1d/B56mGs+qjhrF4tvIRy/ez5CXxhu6hOhMExJiv/5r4acnBprgjOAX2Zl0OCWnW//6oeGhNw10nHj2GPQzQeSNmY58pZ+OKqCkN5Q8rBIuPKz+og0YPm+UNaAA8K9kLc1to5LHjrdm4n6OY5bATFcmIM4YqpZApcWHupzB7DZKXSrvBmsiV6gvE9kKTC9zXh8PoDtHKiVA5K7yQKceMagPSMfW5pyzfAG7PsIBjCRFLPRRPDwaRN+xemWjQzVcAAhCkYJZiEi9ubj+C4smzFpmhRFvizAluLgOkhFtxJNIrtRy/PGFy96M65qcySmDPp6XlKYXnFbVQoujq9IKyk1aYRp9ocbVjbvpOqkX9v6I8eXB9B1u0Vn29R2wqhF1N7I3t8qu/3A/9LT7rIZhely2KN0TQ/6gB5re3HOMmQEP+/q7dpcFeiJ8ZZ4nkSa8XwiQZtAZyCKH8OH1SZAQ3LouRDIb38e0+QHKbBbQ+5D230ZKtccDQwDeiBbnBazRwvvw/1m3/jaXqll13/Zp1upOKdpnf+IyVQyXJKkClZn3oSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qE0Gr/aRsSWUDLUmyFx6v6b7HVnU3up3wGchfF5YRgedWS0QzzPUgvEuFwXY?=
 =?us-ascii?Q?NZZ5PfbNu9nCslkerzF6JHliUcuR9ltOiatasl24XAsNuKReSVvFjTb38Nxs?=
 =?us-ascii?Q?tjhQ27Ky3kq4R5N5e6nCXfpBwvdrTGsq8s9G0rC0KssEjC3mXgEBfNYbAk88?=
 =?us-ascii?Q?A/lGHXG1GFLFKr8Vl/+BcX4yk3vzirlGanujFbqUWH+zPh9Qne+u61YPNG5u?=
 =?us-ascii?Q?6/ThG7Ht5x6fFynJ489Jwc23JdxDKD4Dvgnagi3Oxzvbe4QcTBZoAA2NAL+z?=
 =?us-ascii?Q?ePqSqrD+dRCIPGcoOl1FlgEzlDxkxi1zxLQ19rGRyO/ow2GhBIPAO9OU0Pcy?=
 =?us-ascii?Q?HK90LotQCzpmPI7zzxx/f+fGgrx1KKvnTKXgZDwANbhzoe2/2wYpiHXv8rKt?=
 =?us-ascii?Q?S2+9W8o1ALruhU4vc7oR/fU658prsvJ3mfkgafZ2Bb5BlmPvobzd0KtXn1AT?=
 =?us-ascii?Q?grLX6ogR7+AL4XnXkAWk9t81htA6U1g3Kb4Eic4pLLXPPSQZthNCjynRhhn0?=
 =?us-ascii?Q?NXLZsgTRTQ71afQiZeud0HjmKIVxieM/ZzKIZtk44dl5kGP7wAKxtNoskEtZ?=
 =?us-ascii?Q?rrZ4bVs91Ze9OsCbi5PqE0d8HDXvrGT2CRamfhZtAq18xjMslvkCYmJ2WT4F?=
 =?us-ascii?Q?sGX0AFKjMsq6imacnoPyWtSY/x1OpoDV0zSjv0WAZmpDrsB3vlpxJ1GWVSzo?=
 =?us-ascii?Q?DlrtnKM09Y1VfQcCN5OlPN6X8LJRH67mbDbWxwC7qCKkaPFIP2NrsII01c/3?=
 =?us-ascii?Q?qEc/zqnFoen6oWtyY/hiz7ehR2NHUIcU8Pg5DscGmAX0eEYA04tYagtgfdqA?=
 =?us-ascii?Q?GWy6gNJQfXBCYchrMNMF/FfWYU98pCHR5V9euWdmtuxEfj9mJn51W4Sms6tH?=
 =?us-ascii?Q?naIYwHLxS9G5WyEHkBWt3XHOif5gzxGDOLgYzo7MsNIjJug9c2qI4Pc6C26I?=
 =?us-ascii?Q?rv/5q27BJ4AzqTk22qC5dzlFHAFb+06ep1/SerdZ9RV1G8PYSQXn5wShr8eo?=
 =?us-ascii?Q?sOKii2Hsnvql93+VaGa9IJX6hWIyS9VPA5Lryhx7J0IYtN1ix1w/6q5ga92Z?=
 =?us-ascii?Q?FTAgq2X+09mOplaNDSRlHB9aXMot2z73tyhgz9xBzgfGu3yMdd3SXCZnhen0?=
 =?us-ascii?Q?2ZZlIyImWeFk1iE2u7063QZTlvzG4pQTdAfcj0veiy+b04yq6T5M8QQInTgp?=
 =?us-ascii?Q?SzsZoAmLrz5spi+hY+Ppjr4GqZDWHXCpyPfHC7Yqn7GykcU4QUT+drl7PApH?=
 =?us-ascii?Q?qmjJAD1ODtEBCutM9aPbS6JYBqSPkitMniGhmZ+CBI4GrQPRj8AxPfLQDUiD?=
 =?us-ascii?Q?qBld3JOUjC7+CrNd8QYLUWh4FtKvAJjlro4B20p5Fi4Rcq0AQLzqvz4xatZS?=
 =?us-ascii?Q?5GtM3ODYA/F2/bTRlehFGUbj5y2qvPcgUol/CFUGswloTSruViRJ7G7hNYql?=
 =?us-ascii?Q?SjWbOykJI82lbtEHNyDWeMVMHis7JY+7ntgdIkNoihid9O3YROcqVFpXNfOJ?=
 =?us-ascii?Q?mIlWZFmuiHpriIs3yBq4dqU5kbSWaUdg9Je/dYiwfT5z+KNLGi1v1eKdcgv4?=
 =?us-ascii?Q?8RpBhmct7sXuKZK5LaNfAjTQwkl4lP7O37DDkQFR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17968ff7-d061-40be-c012-08da856d3d5e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:09:05.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv05Ep7iUeV+Y5Glul0+3orK5SDba0dLhBPhzwzoCeBn2E2TpRpK6hl3kxz7c6p6W/RdCkfVF9Kw0BlAHEbCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When M4 is in the same hardware partition with Cortex-A, it
could be start/stop by Linux.

Added power domain to make sure M4 could run, it requires several power
domains to work. Make clk always optional for i.MX8QXP, because
SCFW handles it when power up M4 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index bcba74e90020..8cc8bcbbd895 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/workqueue.h>
@@ -79,6 +80,8 @@ struct imx_rproc_mem {
 #define ATT_OWN		BIT(1)
 #define ATT_IOMEM	BIT(2)
 
+static int imx_rproc_detach_pd(struct rproc *rproc);
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -96,6 +99,10 @@ struct imx_rproc {
 	struct notifier_block		rproc_nb;
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc_id;	/* resource id */
+	u32				entry;		/* cpu start address */
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -335,6 +342,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -364,6 +374,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -713,8 +726,8 @@ static void imx_rproc_put_scu(struct rproc *rproc)
 	if (dcfg->method != IMX_RPROC_SCU_API)
 		return;
 
-	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-		return;
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return imx_rproc_detach_pd(rproc);
 
 	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
 	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
@@ -736,6 +749,69 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
+	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+						  "#power-domain-cells");
+	if (priv->num_pd <= 1)
+		return 0;
+
+	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
+	if (!priv->pd_dev)
+		return -ENOMEM;
+
+	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
+					       GFP_KERNEL);
+
+	if (!priv->pd_dev_link)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(priv->pd_dev[i])) {
+			ret = PTR_ERR(priv->pd_dev[i]);
+			goto detach_pd;
+		}
+
+		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
+						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (!priv->pd_dev_link[i]) {
+			dev_pm_domain_detach(priv->pd_dev[i], false);
+			ret = -EINVAL;
+			goto detach_pd;
+		}
+	}
+
+	return 0;
+
+detach_pd:
+	while (--i >= 0) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return ret;
+}
+
+static int imx_rproc_detach_pd(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	int i;
+
+	if (priv->num_pd <= 1)
+		return 0;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -770,8 +846,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
 		 */
-		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-			return 0;
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
+			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
+				return -EINVAL;
+
+			return imx_rproc_attach_pd(priv);
+		}
 
 		priv->rproc->state = RPROC_DETACHED;
 		priv->rproc->recovery_disabled = true;
-- 
2.37.1

