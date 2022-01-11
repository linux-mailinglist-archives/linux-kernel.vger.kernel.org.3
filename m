Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E611A48A677
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbiAKDgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:39 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:29569
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347607AbiAKDfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:35:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WALHYcnSXLKTUwX0gUCo66n+3wIlTtFCwU/BIScVF5ryVZyHqetwvvlJAoS8b9eHq60N44EQBtlH31bY6WhwbG+XxUy8Rz46sfnW3z5wTG9qN6wVM6GYRSCGeYEwxDYG07NDdLtY0d1OnYtrJczwsWlRClOB96O6LltpX6lNXSIJId4ZGfhkHnT+oz9tbkJQdeKXmA6Y8SjwHeVYfJjoq05zt/HbvWzB6ua0/sFGcipdwcz1tS1OhDNxKTNlTqoPJWMjGjvKU0ncccrNXDckgZGO0mW0AW24lGEyvXdzuiOY4uCS1GmzTio4xajbIr1+Ck/azg4/skvmJOX4cpOGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcOpTz48qs4ernRSxlYVrzhzIYFfpYyZfkUK2xz7+g4=;
 b=Nn8K1acy9ik1vHUkiovMsvtWOnE/fG4SRewnwqHJMyayXD+hvyV+kdjZvSca39p3JPYeqG40uxKKUk9qdidfoGMPMrAVWJqcv9Bgxs9fzOqN7GB/F4hos99d1SndJP6O6NxeoY735t1MA4QUObojzNHkD+NjVB2L0Lquw2k0pvcPXBOaiCnJ//G5ptYU7N9Goz4oak/IT5KzYb9gCoNKi99sY1TlG5TO0GIfaDluO2y4qm903h+ovRl67ceAqLzOMmnvTClFY4DuNdYKCSspDiXwMe9AXHnVZrnpSBd9EIRaUrWkd6zzXHRBAP8RwniKUbKYalLEgLsP8pR5Bn3Ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcOpTz48qs4ernRSxlYVrzhzIYFfpYyZfkUK2xz7+g4=;
 b=QqTwP3aoAolfErLoKVVc+WNZQsT7g2MhM31u02SY8DIhOTRmMQDHvr7lQFToC/6liEH2RExRUXHWx8gEqXnl53EBQ65XFyY5fycyznQpwl2NEQ+h6SGERWE+pqO7ldEuC1VLFI2sH+OTQXwkgZJtqwMVNKPp7oMdu8CijRt0M2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 03:35:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:35:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 9/9] remoteproc: imx_rproc: request mbox channel later
Date:   Tue, 11 Jan 2022 11:33:33 +0800
Message-Id: <20220111033333.403448-12-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc85190-b2cc-4ef6-492f-08d9d4b35e07
X-MS-TrafficTypeDiagnostic: DU2PR04MB8520:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8520A78F195C4354C3701D10C9519@DU2PR04MB8520.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGB569+gI8q33VWCCRgoeLUjSolEgra4OLfFWCcWdFw57FSGbkbMXNAmWAfGTti5NfSNtYuoRD3+VOVr3KLYs3tbXVwVMf1YJoJsRQqjFizUc1WdJJiFsvQ8rHbREZyRHKBmIucqD/3GnErfqGMJGR45Wql1uc0iDc73ieLKxGzSBKKL8I9tF9cWUfEy9Ofvx4qeymC2+PmsxkUuoZZypjkCWl/6cjoeF/fqbIAC4MXAqSbVE7ggZv/UmRPHkUDfythMjLhEtrHweJX50KzlD1FnM+PLRBeXQFUPpzB8+L6Tdnpy+KFiRAUJ6rn8bwTFaJOY/fha+uWRdwxE5/p+TqBrKnEXJup6MTtwnXmRah3V2aWsT6AwhlXyQmEcoMGDkpu2AyDI3ltGn7cENfpYthIExt0Lf6MJ7Ya2PeBxraAzkhocHYVOg5l9YrKo3G7Gznc3I/ITNn55ZktfPfHvNowwaJFejD6Bew/IHRpmXaoIwGaP2wJj966Nf10yV4HyfPnbbB3R2yWgDyCnZaAhCKQoHvZ1uGzLHhXEBv+6YuroHJbCzSpmKX4Ji8g/BL79RQ0GiQ91H7Uc9VJcPNreqevQuM6niODv2Au/M42lSxzvcVSHGSOqlVmrAIFjc8H1ce6nHGlSP4xfWzbSEf85usLv97ccW/LR0up7H8l/UCYTzMNRLLj5vEf9gP8+nQrJOneBjOyFYd3Dh9Zoi3FBnBg3UeywPSJFjxFwrBDoGBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2616005)(6666004)(4326008)(186003)(26005)(6486002)(2906002)(86362001)(921005)(6506007)(83380400001)(508600001)(38350700002)(52116002)(38100700002)(6512007)(66946007)(5660300002)(8676002)(1076003)(66476007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XygafadAjwhsHB2aDu9KdVO82NtF9CLVJen6UdvtOT2qYma6Z/bQkpuuw9iH?=
 =?us-ascii?Q?nozgph6DFNIPyZLbBts73u9934DKM7jPg3Sgb4LBc8Sa9LhCd9xLrFms0iBD?=
 =?us-ascii?Q?EmMaHmb+WgRor1KO+55LCtprALjJx/hJqFPOorKnVgv/QsQJJniuYgAgfetw?=
 =?us-ascii?Q?4n2uDKV6yfFxmywWVk0A02b82sarRd5GcCHoGOFlzjVYNovlrdnlzAjsdVap?=
 =?us-ascii?Q?Js+MNRh9wOSM73/sQLrpmY7TjYaHP4GdBaj3SmHMT6MZkL9mhrLpuCoI4MMB?=
 =?us-ascii?Q?O4GVFn+d2Fhdq7RHSOSpFvQ1ZVht5VXsHxAOXKMvhuS5rVJzp2cJN0QqT2h2?=
 =?us-ascii?Q?MAenT95zYe1QIfn3bkf3T+8qNbf7dYktv2PIUEZW1G5nvdBsFJid9lzdPq0Z?=
 =?us-ascii?Q?UkVUiRudQ15SKZPrCoDeMJVIvHHarhQDumKt/8mmeZkgUiAx7PRMw2zhiGdh?=
 =?us-ascii?Q?Caubo68SKbeU20iuGXXsZ7zjI3jnT0ILaN3OHNKtyqa9S/LJf6PdJzPtECOI?=
 =?us-ascii?Q?CkfaCBy79LtZRfvqwLIA6Khfb67/8HFaCnNq7Kvx4MmoGsC6jZQ8+0u8mPRe?=
 =?us-ascii?Q?drhmbAxF8K3gTmMlb03giGyGlPluVrKPrm6uk3xYGadn9bO8hwIkm8WXdEPP?=
 =?us-ascii?Q?oICKnSUdniJLrS7JpFFLB5ICF+PvWxXGdjkVkpaokjVTqKMFg8rascQyAeEU?=
 =?us-ascii?Q?titWkXuFRuQgMVWLsSUMMbLFpCoRk/UKTTBYtgJJoRDPoOFQ9UcUASnJqRBN?=
 =?us-ascii?Q?z1t6uJM7CQudDAeKSo+t5jWGY1Z6oOUzc4vNsQ1/qW50rYhTUcwsBKif5y0a?=
 =?us-ascii?Q?t2vtIQ4jm20+m3NuMGTWulph2oV4ChpIIeVeuuz0IAKzKx+PSwKoX6yefcNh?=
 =?us-ascii?Q?C8i9ygrk4sfG3VvDMva8HmAhWkFWWZsF4IREtHsKPlBsGVYodDtupEpHAKnC?=
 =?us-ascii?Q?fXBG/CSxdiArl3suMlf1BAGc3WnpYjzVZhgC8aWXR3c8Muf5Fyxi45pvaDfT?=
 =?us-ascii?Q?BldtLwxHVMCvRo95y8mFlHXpd4EHZmmj35ScLbfmrZ0om75E56UnNKzhq5fT?=
 =?us-ascii?Q?q48b68OVLmVE4SkX7/ENNFlrTDx33BMxX/j0gXFfQdMoZvJtG5uBnBy/jJ5V?=
 =?us-ascii?Q?fECBx1YyDzz727VVsFwHYCEAoRjIuUCswbDSF+4hvoXBah7Biz3DrDk1Or6N?=
 =?us-ascii?Q?xFYw9bufldFZMXDFwsYGWjOMidXpaEGgR58bXNOsmK0QBndDZYZB5+bi2vbu?=
 =?us-ascii?Q?7a1hnnQM8wHCjVfLfslF80gddD1ooGqzlilWnJr/YP4wE880plfo+gY1eIbu?=
 =?us-ascii?Q?ZNK80SWi64kYUOuLuNvm6xxqhTo21cxmOsbv+Z/c0E9UP5aUiagSnFqJIrO6?=
 =?us-ascii?Q?kmcBpx6Qk2Fszi/z+Ftn/+CG4nCcz/GqiPbj1W1lihPx1tkOg7QJSoVIySbs?=
 =?us-ascii?Q?XEFlwEDh2YiYyjYhKv5Aj9CA9WZjFFLZ3lxeRfk+jh1Xrzn5h8ij1sXT2u1i?=
 =?us-ascii?Q?KEzVh5ihcDuX1794fiTyaHkbfI2Tp8lnMofRKWEQD84OXXIb+l+94X2whO84?=
 =?us-ascii?Q?I+BSyLypDodO4EtwZWebxEedMluHWVWDtclpgRs2Zd9yVOkU1ttR53z1PD8E?=
 =?us-ascii?Q?B4NYxuV0BsoK7QLxFIm2A2g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc85190-b2cc-4ef6-492f-08d9d4b35e07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:35:09.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7igex22r33aNPKkNpUafYraCEbLIGfKvDCxbff/9aDa8jNk87yHG+8p4b6IYO/BM45ehbTyiQv4mUIdA2B7OeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is possible that when remote processor crash, the communication
channel will be broken with garbage value in mailbox, such as
when Linux is issuing a message through mailbox, remote processor
crashes, we need free & rebuild the mailbox channels to make sure
no garbage value in mailbox channels.

So move the request/free to start/stop for managing remote procesosr in
Linux, move to attach/detach for remote processor is out of control of
Linux.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7bc274fbce9f..079be82a334c 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -83,6 +83,9 @@ struct imx_rproc_mem {
 #define ATT_CORE_MASK   0xffff
 #define ATT_CORE(I)     BIT((I))
 
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
+static void imx_rproc_free_mbox(struct rproc *rproc);
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -323,6 +326,10 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct arm_smccc_res res;
 	int ret;
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret)
+		return ret;
+
 	switch (dcfg->method) {
 	case IMX_RPROC_MMIO:
 		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
@@ -379,6 +386,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -558,11 +567,12 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 static int imx_rproc_detach(struct rproc *rproc)
 {
+	imx_rproc_free_mbox(rproc);
 	return 0;
 }
 
@@ -716,6 +726,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct mbox_client *cl;
 	int ret;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -750,6 +763,8 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 
 	mbox_free_channel(priv->tx_ch);
 	mbox_free_channel(priv->rx_ch);
+	priv->tx_ch = NULL;
+	priv->rx_ch = NULL;
 }
 
 static int imx_rproc_partition_notify(struct notifier_block *nb,
@@ -985,23 +1000,19 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
-	ret = imx_rproc_xtr_mbox_init(rproc);
-	if (ret)
-		goto err_put_wkq;
-
 	ret = imx_rproc_addr_init(priv, pdev);
 	if (ret) {
 		dev_err(dev, "failed on imx_rproc_addr_init\n");
-		goto err_put_mbox;
+		goto err_put_wkq;
 	}
 
 	ret = imx_rproc_detect_mode(priv);
 	if (ret)
-		goto err_put_mbox;
+		goto err_put_wkq;
 
 	ret = imx_rproc_clk_enable(priv);
 	if (ret)
-		goto err_put_mbox;
+		goto err_put_wkq;
 
 	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
 
@@ -1018,8 +1029,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
-err_put_mbox:
-	imx_rproc_free_mbox(rproc);
 err_put_wkq:
 	destroy_workqueue(priv->workqueue);
 err_put_rproc:
@@ -1035,7 +1044,6 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
-	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
 
-- 
2.25.1

