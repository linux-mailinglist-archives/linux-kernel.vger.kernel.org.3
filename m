Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27F4D2C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiCIJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiCIJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:36 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42C16EA9C;
        Wed,  9 Mar 2022 01:41:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrKuMMiugslMsWr1q4djxS+95WmQfTCzEC+p0kgkic1e5mLfyCztfA7xYgSdH3eFc6GPaTNcj4gZmfIs5Eitzxk7mBKIbkOFnHih9tlVlJbQ/Dk2ZgYtI8ay6+gNsBgA+xxEaADq144/JWWEhV7nu4eAL7o31/rATuJU081Jwn9BpqD8jSG6l3QG5nfZ0neW1fNkMDtZkENhJx21XBAbCPtMtC7ZYIKfmPOgr5K/Imj6TmZ6L6dfQJnvqhwkGesxL6mM72pz2HfFdTUMaOnFC7Fa4UMieXUU3v6OYJ5razvIZEmNoTYuYIN8+2eV3iRp5PUWcogUL6z2oSejzt3K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk6NvhCtTfcK9hE2AklyLKrOsOTcAU/RjqDgv2rFzSc=;
 b=IxsbTrafE4FdA2RiHUtktKdq+u3NvtUF/iJOz4hoU3WPyNCNNH+Qnv1ZaZN9SnZZfeSNdSdGT9fynDb4taOZ7gnDCyaamDxKmWa4oMzGNX1zj6fnrpckJVGJbPdHSnN/PVPEDDnR/cnUhwE/KmZm3hV1YiO6yadSnUi/Mjl1yh5S711TIJI93E7pApxEMzetXnf8vD+Yo26AGz94AjPEd7bk9VoiQ9zik7OVTnbY38rURG6USfpinxxtqcPUfUSXgxTvi6wo6yIgdJ6rSOc12W6gUZm+QUOauTTZcPPt2V57Fnwl4mtfD7GL/taK3Esn2e4yjjAiM9HRGuAOtqr2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk6NvhCtTfcK9hE2AklyLKrOsOTcAU/RjqDgv2rFzSc=;
 b=eFMm0SAzd9jupZy82FxJ6NwUWgInm1TnHL6/lYuv/A40qlBUIuyCRyRpaShxstimLhUBH2TL6NpvfKXpCNznbhJSeTdunSAR9V2ENLhtxC6TMHc6o2tdiGKaDTAJYYHmM1mabkfQxubVN0tu7srmAAgBKfTdIveHIGALvP/5qcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] remoteproc: imx_rproc: request mbox channel later
Date:   Wed,  9 Mar 2022 18:21:18 +0800
Message-Id: <20220309102118.8131-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309102118.8131-1-peng.fan@oss.nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9391139d-d3ff-451f-a076-08da01b0fd6c
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB60439612F34B29073DE36CFBC90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1ULFNaI35Jtx5+jrMl1Pp8AWFqocEbZMkL8je8WsSuVHC8k/vO4Qbpq/4dux0cyylpNZNRdqls4wcw6DjTrSRkiVdsF5ZH8hjgBitZtn1ADBKo/NzbpDTfEOxIKeJiSk5xpEDI4JqDym+Hx4GDVJFZB0k9onnnZ2C7G7c7RinQxkhQF8cKA9ytudd1kAP6uU/6hoUP38/BsH+OFtHGO52jFHo51q3ZCXkrFXhdVpluFh1bVAJJCVfjzipf1VS66bp/99mXPTQEFj5apx7ZG9c/ZuK3amyOmA1Vx+dGnvaG6aODuNrQQjnUvXTypeYmudQxI1YRTm099J4eKp7pL74JN0hAWCrR2U9kxIQIgTJZVvnEjSm21bu7/BZwNhzjCo32fyrsb6+/6LwKViHIakzweKZcZaCu8pQRo04kn7fzYVg2lsZZwm9jtROcZf3MvEyXow+rkoEiD+iDQz4/DNq5TRAyKiGdqKQ2ghIosici7hZYO1Uxe13xE5OUQ1ODDBoZG94hVHuptlgqeibtTMx/wZFELiAZtpo10KlWp4YEL0aiffkaVqZ6CA1iM6FpqtLTZLhQDJ80KRdMjyeYN83/h/rGGwg24/KA2TrG2NeN4xo5Xz0ZjhpaUXBDOBI2pv/PGqhJVaxZBYuxHXEyzVrBGoGZAtsNVEpYGVbSzoNWmGAhMeq8Hi4xUFnBjlhPsyD6gUu7u9enkNC9Nz+ceEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6666004)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaX2uiU36+6ZdTc9Rg5vRQGU9U1XJ0ehP7fUC2xH9YK+srwYKMzB4pjbYxol?=
 =?us-ascii?Q?POM+pJ5J+Pp5DD+Xz4b2cJL7GqEqKiJLdX3vJ81o8seukpS+e/Q9wcKU2ESD?=
 =?us-ascii?Q?ZrfO7SOTTlVSYhnRoaNJoYtYo0U81SIRMDALrvRMpW8pW6pcJ9BNSIh2gGbA?=
 =?us-ascii?Q?/HmhjrekfUulsk6xzj2Y3P4KSy31+swDDG9ryhhGPUsx6R1XqZxjn2jk9eEA?=
 =?us-ascii?Q?uf0NdIXIFaLnoq1Y9kB2LhSV+IxW/1jF3hUStu5ZfU+DcbbIweDB6/F+bVjy?=
 =?us-ascii?Q?8t0SUodSq1NrvNP5G2UvkP/MH1fexMRHZQC90lPSuCNEpSkyk/ymYkxdjje1?=
 =?us-ascii?Q?Q5nuVKngFvxiQ5bC7H0xfDA1Cb5dqrjK1GNGh32gYJcPqRBKv999rGr4rFzg?=
 =?us-ascii?Q?zCw/UdhUo2UwyDOG/bJwf4vkgGIoNhnU3xWSnTFQoBoTolzQZ2FFhxx+aqEJ?=
 =?us-ascii?Q?JH2XxcrCAzqpVYpu6xlloQ76O2I3I9jdY1oTtol90PJwvGXheUtQyQTDO5GX?=
 =?us-ascii?Q?+LFTPI6hwn34MN4Q33BkXb/n+PZfNofdw5iirfp4Vi1ZPz8uCY3mzNxgeYxH?=
 =?us-ascii?Q?lk/q3VOK84CVHP0LS0ho3KIGotCNxrmDS0aYlsjKpR9gKVsVfRKdNT33JPUM?=
 =?us-ascii?Q?Gq/SNyJzkcfo1vqF8W5ynxPsoGaDE1zBQKorvYQvbfslCBXGioRTBfOvE3Kc?=
 =?us-ascii?Q?iQ+1y8MNbtkSZ3zfUwa5oIEsF3HfXf4i38eIQhKH1GQvH4JBjnuh7lYS4W8J?=
 =?us-ascii?Q?JFePNmOHC1JaBGkraTcYLgTIBnCPP5hYCq0rCv3Qqn7gVSxXIP9LtbLWsNJ9?=
 =?us-ascii?Q?igqFCgVzOlSSBdqmGxoAlZ+roftJutd/EXsP/vSt8DYsEplPOayNVFNRZRVX?=
 =?us-ascii?Q?ym0OJNk7t5ob7fq7lHmRZ+lU5z0KYy6vxfyoVNZnuloBMLmpxXUwb45gFntG?=
 =?us-ascii?Q?PrrZ8mHyQwx13lcB1xrTp+hhlJYGtxU5S2H7hTR4R6PaLKxYD2uSKA5I1VUe?=
 =?us-ascii?Q?mOZT1h3sga6RuOP51Uqy4tGJAdFFEIoYGWlE1AzaANVN1QEzCpXlauBxOdK4?=
 =?us-ascii?Q?2caUUZej3AhBpBw1BHlgFLY4F2KHT5+4hb6csGG8WTa5I8uzql3oRbfBfn2L?=
 =?us-ascii?Q?FsecJMCvAmvEZ5MnVxjjZLlBGNVGhrKU8XHdFqwnb4AKIDzo0SFNAiYQ9Ps3?=
 =?us-ascii?Q?SvTlnBQy+WT3Inj5YMAcMjS0Gy9vQQhMuXcf2yolw37pBbeqCj2MQ1VgveId?=
 =?us-ascii?Q?rpx8uc9CksyTRy+04kZ1DyslL7iHT2xb+/Fsw+UU09JivYHkjtLZnaZu+zeb?=
 =?us-ascii?Q?FCyAuNICXkLjVEFyDOtlMBDNASepOiOW5eaIa1OoaXTVUDQG62JT8KXW7O+3?=
 =?us-ascii?Q?3kkzkF/+m9rGZJ78OcPlmZTVAkdvKLTHY8o18gO6Yf6VuaFafWIsQNzCU2IB?=
 =?us-ascii?Q?QzkQZ9NjwIlstRelyKbeNO9cwuUYmkX81PXitH3mlqckgyQgg2FS7uHnS9N0?=
 =?us-ascii?Q?HXzsid+ipDsyHCFJYO6g81fYgfuXOi1T/118JWKC9H+7L/Tse0Gd0uhYJV6a?=
 =?us-ascii?Q?lGG8LwsxQiyDW44CS0k+tkrvD36thVx/x7Di3EXxe/9OTUMqSayKJ3EVQl1Z?=
 =?us-ascii?Q?nsglQF3fSuB1ygTT4MuOZB8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9391139d-d3ff-451f-a076-08da01b0fd6c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:30.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1tQUSJX6Hb6oJPuYsAK2OJCq/2XCGO8xtHNtEt5qPP5DIdNIWUwn3R7fAU+Ysl2sV0Kevj2lv7EKveuUMxMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/remoteproc/imx_rproc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index adedecf8def6..c03d479f1b09 100644
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
@@ -373,6 +380,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -552,7 +561,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 /* Only support detach when doing attach recovery */
@@ -561,6 +570,8 @@ static int imx_rproc_detach(struct rproc *rproc)
 	if (rproc->state != RPROC_CRASHED)
 		return -ENOTSUPP;
 
+	imx_rproc_free_mbox(rproc);
+
 	return 0;
 }
 
@@ -695,6 +706,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct mbox_client *cl;
 	int ret;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -729,6 +743,8 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 
 	mbox_free_channel(priv->tx_ch);
 	mbox_free_channel(priv->rx_ch);
+	priv->tx_ch = NULL;
+	priv->rx_ch = NULL;
 }
 
 static int imx_rproc_partition_notify(struct notifier_block *nb,
@@ -961,23 +977,19 @@ static int imx_rproc_probe(struct platform_device *pdev)
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
 
@@ -994,8 +1006,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
-err_put_mbox:
-	imx_rproc_free_mbox(rproc);
 err_put_wkq:
 	destroy_workqueue(priv->workqueue);
 err_put_rproc:
@@ -1011,7 +1021,6 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
-	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
 
-- 
2.30.0

