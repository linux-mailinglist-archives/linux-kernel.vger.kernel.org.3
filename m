Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808874AD18F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347458AbiBHGcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347350AbiBHGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:32:04 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2DC03FECB;
        Mon,  7 Feb 2022 22:32:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx0Pt1oxLHiamOaUj1WWD9umpszNhODlflP/e+CUEq78DR5krfIoMmgEJ5yHmB1hqyGdBu4Qy0L701ajr+rcGDakFskWZhTmN4sAdGp7iTuzlS3BulqGp4v8+JV89O/FL96UmEy4OY+VoWJaKOu67yk6L7AMjp06Kzfv9LAH615aukjw2EyZOjoesYpDtalIE1UVdFjfTSfCjwsHbLWeLKAaMwALLhS71DbjvSjgjoG1yKLD81tzgSedHl7wd7fqk2Lc+1xCa7WpWJAICtgt+hTOz5wvJruRc8lQxJHcDM4bHqyEQIdMYJ/gTcdxYC7Qm+cSOUFEM9+izLfdn72MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uce4ANOtJLoWPHIOaiPYx1g/vbR+6ecUDhkgMIUvl5o=;
 b=VUSYQpaNNc6E2hfDxfo6xIA1+SKzVmo639cqTTmXT4DR/4atocGj67YtSIYLGDt7AknPL3FYvydUDi+wjDfGkv4GYaLXrg04/QAO6LNzgg0lQQYo5M5mRoulsMQvNhvHpHOO9ZUFfOPjnMBggVKm1409nnN9ubxIEotR3CV1DeM3YnSnJ6T4eeF1/sbdW7Ly9okxGnz1bSnBV57Qnoor/E3BHdREciHnUqv5+3Xry90MOv03hJW+biqiygFjTL7MxFqRdUxHS7RBEqaTHLMyoF0aKI4aNyWfIQFNBWFldF9WNGFz1Y2hNt3Mj9Temnpl8yd6bG3hSPOwPPHtg4AkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uce4ANOtJLoWPHIOaiPYx1g/vbR+6ecUDhkgMIUvl5o=;
 b=QGuUcQu3UOUijzNwsTI9XPdjxbuhTwbR16QTmUsLoY/oik3cxSEKk9sfZoS8iK0d6ALNulbM64ZVskfTH2Ev+cRmX3uaKS7hvptaAH9znSxqo2lBM5rxRKbvmmZKOMjc6mwwO5O5hI2RbZ6LCAEO0LJSKZZcDw65UYLBhajZpGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB3531.eurprd04.prod.outlook.com (2603:10a6:7:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 06:32:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:32:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] mailbox: imx: support i.MX93 S401 MU
Date:   Tue,  8 Feb 2022 14:30:46 +0800
Message-Id: <20220208063046.2265537-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d78d206-c2a4-4b3c-0dde-08d9eaccb696
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3531:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3531AF428669DFB18711E4E4C92D9@HE1PR0402MB3531.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tClWTJQvWqtlDHteeJaynX+v9kgo3bhP7n+a8dO+gICC7hkZMpLJMCPw/2mnv2EH/zg2Aegt7BskOZdnFBqoU8vGmzjwp00f9ZDIdPq11tvjw2c/h9kaNnhMUTAXYDSI6xVXEid4CZc/oOODbEBqsyNCObihAy/w9Q1/DEQeCpLvb6yBeerxeZ14a5VPAN0xtZ7GyLPAi71fcJe4P9Gp0pM94ezdhK1EvRCyRwb3EI/cDFwqhrcWTea0ihHF0bnHSxpT6xd1L1iR+Qu6Xq7UknW51Z3exQghiUjMNQZmaeJvDqz/ZucvAT8zhYCvPFxDtm/ukeAuToH+cGIwdwpiq+B617QOXvKQLKV7syMOVwx5UJHc7tzwR8k40l2JEhgOtmPSfLUa8LzMKuYaQO8pf9jJcZHKIzXn73yXGdUQzYBmE3AeMjOYRwJ6WNx63Nk5XxNxBk3gR9BrQPMxU7PlSGRYenRPq1OQOtGNd4g75gKMg+6c4qZsuF2EP3qbNpyIDfN9Cos28g8+APhJKVTX2/RjjAHL+96CjNf3BD7CtTpwvxwdQ2eIMyEIUCOqxSp+r6syxtG68AKxijTuYX322sMcgUcEllsdGEOiA/Q3gXmANgESjL4kDKsADbqICxOPBsHjRWKITK6hN0q6HPiz3PcsduSuGG/Fl1VsOSSHuc8C7j/7De0qPvfmeTaaHTuTVih4gqoUkU3xPaIt0v7MDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2906002)(8676002)(186003)(86362001)(15650500001)(4326008)(8936002)(508600001)(1076003)(38350700002)(7416002)(38100700002)(2616005)(6506007)(6512007)(6666004)(6486002)(83380400001)(316002)(52116002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jp7K/Rw+w6QUhBn6/7D/h0D9r6LV9W/ehEAsTD03fGUGbD3JYIA0qX1o2KWO?=
 =?us-ascii?Q?1fUqPXS8TQQfsu097I4HKeFD0SpNEuQHlkruxonVY9Q/Rbp/6JiS1KBcaU1K?=
 =?us-ascii?Q?sZKR/pIwBYUrgPJqHN+mZCUKCMQVYHuB1ydXhltHEJSAJm7J4S8W2wHBb96B?=
 =?us-ascii?Q?oWvF3Ky9cTn6S7M1cwSwpMQTb+Q7/zqt2b3lqhEFE2DMK0YkxnZf80vTgahd?=
 =?us-ascii?Q?+XQWru9Qzi+2j0KRUk3k21zTZGjpXB/3KPZqwh91vpajqsCilDscamkzfrp4?=
 =?us-ascii?Q?76UOaJlYoyImF8Ra8L+EzyAJ/bCi34km6iDq42TegMF+SzL9pImAqBeuZ/pD?=
 =?us-ascii?Q?WheNT56kC3hqsh/MRosJbKV4bLBAghc/0w6EAH1ATs3Doad77ueUC71oz6Sm?=
 =?us-ascii?Q?HwOrOkxVt13qEIV1Lb07jTU3469SDw6jliObza7eYnjeBBQmM1yI7l2QA9xf?=
 =?us-ascii?Q?24C3TwP/SLqO0VAYpJsfv8XBcxBIaKdkI2te3TnSdjUX8kFwnE6mIXUQaROr?=
 =?us-ascii?Q?0Emp28zeAXHYow4nvIuaDVwortbE/f8NDM8lEoMHvqIOnLmvM4uKaOWa6z6/?=
 =?us-ascii?Q?DZc+d2yOZceJjJpftJA/iqGy7s85Xqhir5IRKs+0/+SezU0uVqQSDJU1vscm?=
 =?us-ascii?Q?Cb7S94gpHrTQdauc7Wa3hRChE97ane1DTySFsVHyk+PK3iCnWycU0c88vi6d?=
 =?us-ascii?Q?S7MOD6BL4FIYjuJ8Y0dqNTRwA7o2qCYM3M6qfRTZgo+UVh3+/tem1wdM4K8R?=
 =?us-ascii?Q?XIlwbjIAnqviNQT3K6Pii8OEKgnb6Y6cy5n55WsVqD31kmVl+sP6EFbv9fu+?=
 =?us-ascii?Q?W9omoCcm8XBdp+ctVv/Rz57AzZHeVZ/KvNZdUK26l2Wi6Zh36EJZ/lhz1ivT?=
 =?us-ascii?Q?bTLvZ6qRRA80rT/kFycsizWbsdoYmY2CmXXEH1j34J4pwJn+yhDXsUbi9Fch?=
 =?us-ascii?Q?5G1yls3N5Um/jufyVHsQznOl7SPldD6EbiUCw2sWlPMQHKvVehm2Wd/CPteE?=
 =?us-ascii?Q?RbquwKBECTgVjlVp84/c6jn4Yt8aCtuqxlu4ShjwtqjK6R05NQ7rTHYfCoyr?=
 =?us-ascii?Q?Fe4EAMaBprGMsjfwtyd2q4BDPIxBfEqaMAp+I8oqTa25yLMUr4on+5XdZwQS?=
 =?us-ascii?Q?sVKdwoTVjuueHfZSa7YhJAg44Mk0b+iAjZpHwKUymPdLdytpD1oo7jYQXeS0?=
 =?us-ascii?Q?0qkw+AMPLw0Dbnnet5wOyTtXHnA00YEHzzTpUHeA3M8KBSJ9BL4nw4OulHG+?=
 =?us-ascii?Q?FDdddAqcOhCZowutKNV86YKaBUhO5loRrWRZYuLWCUu6ijsJb0jQdalSd9Xg?=
 =?us-ascii?Q?xvlgE99RiV8CKSI8Q9sJAvC5+vgcl9qro9j+dMQSPIsTbnOTcRAvm9JQ7mip?=
 =?us-ascii?Q?4h73PHwh7jwUzp9MhmTKd2z8K5vblL4dswWcbz5bupkzpBfd8nR54U71DGhe?=
 =?us-ascii?Q?+O4jGtKSids29pj/uLX7iDY3iROTkG+LByxWbsIYEPJ8lTLgd8/QHxyuGaYC?=
 =?us-ascii?Q?BH2EzeahLK1UfVZcDArNvPk7EpLB1qoT1ep/dzsdWpuVVxkWAK1qVmIAj0EK?=
 =?us-ascii?Q?cIYvOfml1YrtmklARdRshQnYhAil71JaCOPUlA1OL9Otts9ohzzEmQZURokz?=
 =?us-ascii?Q?4gxRRDScuLT3IY7y4hgB2d8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d78d206-c2a4-4b3c-0dde-08d9eaccb696
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:32:00.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsGmnvnGKt8FeenEdbVPARJFniKGxh2tdsBi9E1tq3TWSrOGwNIYxvsZMIanyBfybduxE/ehUiSp8JnT3GUj0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3531
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 S401 MU support two interrupts: tx empty and rx full.

 - Introduce a new flag IMX_MU_V2_IRQ for the dual interrupt case
 - Add i.MX93 S401 MU cfg
 - Update author and Copyright

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 49 ++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 03699843a6fd..094dc84291fc 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
 #include <linux/clk.h>
@@ -28,6 +29,7 @@
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
 
+/* Please not change TX & RX */
 enum imx_mu_chan_type {
 	IMX_MU_TYPE_TX,		/* Tx */
 	IMX_MU_TYPE_RX,		/* Rx */
@@ -92,6 +94,7 @@ enum imx_mu_type {
 	IMX_MU_V1,
 	IMX_MU_V2 = BIT(1),
 	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
 };
 
 struct imx_mu_dcfg {
@@ -536,7 +539,8 @@ static int imx_mu_startup(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
-	unsigned long irq_flag = IRQF_SHARED;
+	unsigned long irq_flag = 0;
+	int irq;
 	int ret;
 
 	pm_runtime_get_sync(priv->dev);
@@ -551,11 +555,16 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	if (!priv->dev->pm_domain)
 		irq_flag |= IRQF_NO_SUSPEND;
 
-	ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
-			  cp->irq_desc, chan);
+	if (priv->dcfg->type & IMX_MU_V2_IRQ) {
+		irq = priv->irq[cp->type];
+	} else {
+		irq = priv->irq[0];
+		irq_flag |= IRQF_SHARED;
+	}
+
+	ret = request_irq(irq, imx_mu_isr, irq_flag, cp->irq_desc, chan);
 	if (ret) {
-		dev_err(priv->dev,
-			"Unable to acquire IRQ %d\n", priv->irq[0]);
+		dev_err(priv->dev, "Unable to acquire IRQ %d\n", irq);
 		return ret;
 	}
 
@@ -762,14 +771,23 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->irq[0] = platform_get_irq(pdev, 0);
-	if (priv->irq[0] < 0)
-		return priv->irq[0];
-
 	dcfg = of_device_get_match_data(dev);
 	if (!dcfg)
 		return -EINVAL;
 	priv->dcfg = dcfg;
+	if (priv->dcfg->type & IMX_MU_V2_IRQ) {
+		priv->irq[IMX_MU_TYPE_TX] = platform_get_irq_byname(pdev, "txirq");
+		if (priv->irq[IMX_MU_TYPE_TX] < 0)
+			return priv->irq[IMX_MU_TYPE_TX];
+		priv->irq[IMX_MU_TYPE_RX] = platform_get_irq_byname(pdev, "rxirq");
+		if (priv->irq[IMX_MU_TYPE_RX] < 0)
+			return priv->irq[IMX_MU_TYPE_RX];
+	} else {
+		priv->irq[0] = platform_get_irq(pdev, 0);
+		if (priv->irq[0] < 0)
+			return priv->irq[0];
+
+	}
 
 	if (priv->dcfg->type & IMX_MU_V2_S4)
 		size = sizeof(struct imx_s4_rpc_msg_max);
@@ -890,6 +908,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
@@ -917,6 +946,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
@@ -1001,5 +1031,6 @@ static struct platform_driver imx_mu_driver = {
 module_platform_driver(imx_mu_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
 MODULE_DESCRIPTION("Message Unit driver for i.MX");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

