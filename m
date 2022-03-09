Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4EB4D2CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiCIKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiCIKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:13 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84C1704C4;
        Wed,  9 Mar 2022 02:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILL4fcJ1IoJpTxQja/b+7qupFa/zghsAh+1i5zr44Zc4SqjeLzZSH+dGNRE1Mrmy97QtBSSMufjlgxGskFkKzcsuRA3WVBggTxjlzg5wVHD1XDN6GbSEKmkAqf+IVtAQTxXffH5wGUz+ev/oyJMxnVZC/u0zbp+q8+txW6oni5WY80MekbMPoY3U7O/7mQu6Ibs2pRf8whk0K1U4L43GdqksZrlxwnQ4JelmuzcvhLvxhUiSQiNMnJ3UTGA0IarAs7uPUcE5aVvjKJi6IDWFxEBqZ9k/S+d8e5JQNKdaPVzLmlW0aNE5ZxUfztT3RdgVhmXNayPSnmw81rklC/m6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJAGx5SBUq00e+Wrn3MtydbVyLTuaNb+zTTfhFl4m8s=;
 b=kgHMiG4WkPbKMlVQzgTC0Ua1zNHSMt7IW2cmhiMI3RkFgIa5VKACxU++irc9pQPbfe5oW3ILEoUNISQ6oIor6EoUp8To8+x3VhVcA6m/umXsoiErfQTvNvzyJT3wsgMoKnOrvZhAkoUDZZdoIk5ZarvSh+DFeOZA+I/vcKnlfeOhv2d54Sp3WRn3VsiVPwCXkwm63/n0bH6NNkggQn5KsRcGImwvyoH+/dGGrbwvIAR99M5MMfrRcPHiVSi5KBOfB3UYy/ceMkLnSZTAG+T72MAWteJtUagGLQrnemZ9gdjn7Rxb/dWd+1/70kFzjfDRICzfMl4+vTaGUWCfLcLAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJAGx5SBUq00e+Wrn3MtydbVyLTuaNb+zTTfhFl4m8s=;
 b=hEilpFBZ2gdZHcTs3argfVWvzyutk3qQUJLI6eMLe7L5vI+B2mi6hF3pCpviuwWngozEgCtaXN76F2iE43Sghxcl9ztBzOkad/bsdzqbwQAR6tUuZ323QzILB2Uoxz72u77SRCpOq3euuGOW/DW8cyU60TFd1AxpCtGsklGR32I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7363.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:02:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:02:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 4/5] mailbox: imx: support dual interrupts
Date:   Wed,  9 Mar 2022 18:03:44 +0800
Message-Id: <20220309100345.2633862-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
References: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cdd6ab-7f09-48dd-f5a3-08da01b3e174
X-MS-TrafficTypeDiagnostic: AM8PR04MB7363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7363851DB9F1BC1BFEFB654CC90A9@AM8PR04MB7363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGkn+mhFi6DhXHZgB/u7G93Owtc3qHrjA0GkIOVhl27iI03MY/QEUEOJ+2m7V9GbQKKWggMSSFb3INpoaoxgBm2xS64iIhCc+HqWAKl2yAOmMOHprB6l20dceeFhiP8F8Pca/w2y+Xtv3eIDzeHD3ctKkWQGu4ZfvkHChF47mrwronu3YBwJ++pt7+GYPBMs5mmRIB+d67rLVuINYOUC2Oj9bvmWIgDARf3q01z6VwngtMoE+aHkVQ+Z9BxPccbXSddOmhFT1inrhcXC02vsf61kJSRzohHQN1l6eNEcUu9oj9w+Yv2IuaeBuRdhRVp1kkzu93CFVF6nwP/SqPR680hUz6qszPqovna7sJv74UjiOOzSZC8RXknz+cFOG5Ro/GcVsGJQOES7y8aiLuu6XvAVf/ugxse/pY35xEk9HILGQAb/Tj2gLV7bV++qGucBdBhlI/lkX3HdWISuihgKIY4lTUIcegYWjsjuR64wi68dRZtm/epJk4FnIbUIhnd1rTHzVp4TQT+b9FQ7J4bEgF4CsyHjflFlgY/x0mFh90REFqKVFs0sdR3u+BxhqiLPn/iJcRD03gjHyol4jxSNCOXQohS01ZCR1am2x8TyjqXST4Q/sOUBFs/lw/PfusJVmmko4drmVUDs1/HWYdqiFjIpFuB9jhxS50LzsY9q35JBViTABxXvswoIC5aWi4z7/2DkUKhJfquXlh240gJWVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6486002)(66476007)(66556008)(1076003)(6506007)(8936002)(5660300002)(83380400001)(498600001)(6666004)(7416002)(15650500001)(26005)(86362001)(2906002)(186003)(38100700002)(38350700002)(4326008)(2616005)(52116002)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nlru/JG3pMJUV4gpRUr+5DkwW+74VjF8qeJalO/MO2ZZO7Vex+B2C2T/Pfzs?=
 =?us-ascii?Q?HVRXeoAPYz1TWubKlWyX1r2ZBjsg6idMzQhIXJ3jRNytHEoeuqrnMlGd6Vi9?=
 =?us-ascii?Q?GV7l98X9io7ogwGVUBlX5iz9dlGupi5R5bms6byYqxRkhO54yRbW6hPXYsXp?=
 =?us-ascii?Q?ug3zv1Dk82roC9qCIpNLqNCQ0clBJjO1v+3UEbQ07hLyPD8Ne6Vl1o1WY1U8?=
 =?us-ascii?Q?yE8f2WGyYzNpG7Wx70sSFam6aiI7q0YVlXmJkaifadld/ievrjL1XouFX5Pq?=
 =?us-ascii?Q?djdUc0SXCItJLERn2zN6QDT4aonDvTFOpTH965DF9J8bpQUFlMd65Yzy/L8z?=
 =?us-ascii?Q?Emfiwg8SMXrb4unvPDRv4/l2J7+acp2A+Rsx3l+G3QNc9syrnVHJDVFm5Wp+?=
 =?us-ascii?Q?MybdkXMz+JrKTIS5COCQ5ZMkEvldwOw1r1b/iQMdSAal37G1Lzk9R9QdSgJT?=
 =?us-ascii?Q?jiMTJK/3B1TxJrVbvK0WtzLKvTeqO9AKJyCJXLMDK+yf+W1u8X+HK1PcSWUZ?=
 =?us-ascii?Q?hg2zUQ7tne1Dy+kt18hus1KEILVh74ENx+6KbwaYydGxbDMJjvFhukLljCiG?=
 =?us-ascii?Q?ilYlSPXrzuL7A4zBuQ0swkjDS/+PLnLFkK2wELxFZBIG67dLncSBdyU4TIja?=
 =?us-ascii?Q?Qj+FClN6KMms1IAGCZs0TU0lP3V6/LCi4M9gFzZsoWZzPRs4hgJTaM9r4+1w?=
 =?us-ascii?Q?R/eqK0qFSh6i9oN5yZzzu0t8s97Sk8j9V2N8fDu8J07RPR7xD8djwV3TryCK?=
 =?us-ascii?Q?GXNimA9FlCWU2uNNgzBLSSHloA3T2pLwZCZU79uCdFF8FH8/n538kd3uBAxL?=
 =?us-ascii?Q?XkIjfo/+sjwUGAfvaOiP+kyBGBG+XVnnUL1Hmyv1ALZqjRat8vf1M5WpE8PZ?=
 =?us-ascii?Q?C+5D9GmyYuaqlBuEol9VLcc77TpZvwX1U3o9B4obaOGcBRv6pFLYxsMZMNrQ?=
 =?us-ascii?Q?LvOvLw+SyP6PPhOA4JD9L0vFd67QZJjSP4Mu0ZW3RVHO1mqhSZP9/mlms5fo?=
 =?us-ascii?Q?uHwFPB7pUEBulRu7PRJL7dEC2lxs3+VfSylOfikODqSTb8nRVFiXNeLfGNUe?=
 =?us-ascii?Q?ARygtQr6a3+tn5YGjat1FayBqdcBVGAmdfT41IwJBSOFKYoc3g/aETLe3lb/?=
 =?us-ascii?Q?NZUWFewl3bgwAVQfsd3QKtEGd/Ha65ers13O79MRXZgK9WsuXZ3HJXurq+dQ?=
 =?us-ascii?Q?pdix1GTTxjdBOwuGEIDhVAcr9EIdQ4Uq6U7HHX+SiITga/7DPn7NJ5UJ884Z?=
 =?us-ascii?Q?Vi7X63WMjpnRs419xYitx5dodEGyNrJ1D5ValI/XLAGodFtVBKRO0T8ja5ip?=
 =?us-ascii?Q?ozoEunRvvv2cQdef0/LNkjMlbELVCz+t/bX/LBQXRaGtohfITf3lhoOX81F7?=
 =?us-ascii?Q?cJkCZj9uE2TRD3oL9W6YaqePaPlcfHaVVVLmNNvq3Rl5iWPizfLCEe9LZKmW?=
 =?us-ascii?Q?c2/ywQJey80rMzkKxDJoU73HZAN1gIeuE7JIXEfxHKny7yP4p/cp3qMq/gar?=
 =?us-ascii?Q?+UW7sDd1hS6PYRuJvHHh9mO7+f8UyB80/5FyTsurmOn3oUNP1F4BSczLJMdt?=
 =?us-ascii?Q?mOE91y4vt2CXQTz0IyR9gYmFAsg8ykqXxBGyN4aHeLJ3ngmgElxhx8OrnuYI?=
 =?us-ascii?Q?+PkXTqGIG1vjTFhfSiA3kxw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cdd6ab-7f09-48dd-f5a3-08da01b3e174
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:02:12.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaEU2I02mY4EJXl0skzTZfGzOvsfVU31ulpU1J8GY/j0kRZUFLLrEqum2w389guH5WeuuD9cadDWwcpwQeqApA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7363
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
 - Update Copyright

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 45 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 03699843a6fd..24977d66bfb9 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
 #include <linux/clk.h>
@@ -28,11 +29,12 @@
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
 
+/* Please not change TX & RX */
 enum imx_mu_chan_type {
-	IMX_MU_TYPE_TX,		/* Tx */
-	IMX_MU_TYPE_RX,		/* Rx */
-	IMX_MU_TYPE_TXDB,	/* Tx doorbell */
-	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
+	IMX_MU_TYPE_TX		= 0, /* Tx */
+	IMX_MU_TYPE_RX		= 1, /* Rx */
+	IMX_MU_TYPE_TXDB	= 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB	= 3, /* Rx doorbell */
 };
 
 enum imx_mu_xcr {
@@ -92,6 +94,7 @@ enum imx_mu_type {
 	IMX_MU_V1,
 	IMX_MU_V2 = BIT(1),
 	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
 };
 
 struct imx_mu_dcfg {
@@ -536,7 +539,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
-	unsigned long irq_flag = IRQF_SHARED;
+	unsigned long irq_flag = 0;
 	int ret;
 
 	pm_runtime_get_sync(priv->dev);
@@ -551,11 +554,12 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	if (!priv->dev->pm_domain)
 		irq_flag |= IRQF_NO_SUSPEND;
 
-	ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
-			  cp->irq_desc, chan);
+	if (!(priv->dcfg->type & IMX_MU_V2_IRQ))
+		irq_flag |= IRQF_SHARED;
+
+	ret = request_irq(priv->irq[cp->type], imx_mu_isr, irq_flag, cp->irq_desc, chan);
 	if (ret) {
-		dev_err(priv->dev,
-			"Unable to acquire IRQ %d\n", priv->irq[0]);
+		dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq[cp->type]);
 		return ret;
 	}
 
@@ -598,7 +602,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 		break;
 	}
 
-	free_irq(priv->irq[0], chan);
+	free_irq(priv->irq[cp->type], chan);
 	pm_runtime_put_sync(priv->dev);
 }
 
@@ -749,7 +753,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct imx_mu_priv *priv;
 	const struct imx_mu_dcfg *dcfg;
-	int ret;
+	int i, ret;
 	u32 size;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -762,14 +766,25 @@ static int imx_mu_probe(struct platform_device *pdev)
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
+		priv->irq[IMX_MU_TYPE_TX] = platform_get_irq_byname(pdev, "tx");
+		if (priv->irq[IMX_MU_TYPE_TX] < 0)
+			return priv->irq[IMX_MU_TYPE_TX];
+		priv->irq[IMX_MU_TYPE_RX] = platform_get_irq_byname(pdev, "rx");
+		if (priv->irq[IMX_MU_TYPE_RX] < 0)
+			return priv->irq[IMX_MU_TYPE_RX];
+	} else {
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < IMX_MU_CHANS; i++)
+			priv->irq[i] = ret;
+	}
 
 	if (priv->dcfg->type & IMX_MU_V2_S4)
 		size = sizeof(struct imx_s4_rpc_msg_max);
-- 
2.25.1

