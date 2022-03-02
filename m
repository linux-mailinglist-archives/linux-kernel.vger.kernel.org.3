Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE34C9B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiCBCYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiCBCYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:42 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82032A8ECA;
        Tue,  1 Mar 2022 18:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebxRGvmwsF1glTPBgXQ/QEZoAuu7e2FWYhppnr6m+fqcBZiR/RJ1JdGNSvl6YM3T5KCVCocUtJGxWElFk9W0YAkBafOL7gzoLUyN6oeFwWtuRmjEdPL0kdm8K6pvB26c16Mtzm1C5ajS4y3vAQld3hBnp46OnrISsSfUBgPwBntlZVTSZEjOnvoj3cGoXfpmwrtQ1jhQIe2nL/SxX6YxlHuBGrIjKbnkX8kT188RVsa4EwXmp8V6cuIodBaqgis/7PwUNzH8WEkpeBpQqjc2OyTY3XxW4HaGKtuDxO8t9Q/oa1eShkI+hAHo5z+8PW/fcOHF3Aex+V1huQJybgGdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=KYs7RFfyk633JnYS49mBcFNiGnEJdCQBdrSH10/Y86Po88uPpLGzpDjBOFoQlBP8IZxDtBX/zka1wZJLuXQTEL013KycXkoNyOAgbLwHIz3IqX3bAg4By9/pZE0JjVrCmIlwlKojaq0BwEdIucGrVV6wBrlF2WQZBel2Dr89SgJ17BHVJJrLAiDM9e8UppqAf1pVENvBnlbl2k7/CSpBVXmgsH6R39kC3C2b33SkOgDfWOcW9pBLl9HXme7WiyeksUwBjlCYlrFUqlexgFKbbXsmPkVHndE35RtmCv5RLFtyRZvEc6Rfm3zGhXI5ZwgE7GQN2awrtw2hts3c78rZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=Tl+8+sroXfoZxzovEczKQldO8xeU40ZnMn3HB69sDYWTcpfeWz47hdum4+F5GLqXnJ8ZyBxq9nDbBLquWHhznwV4e3vTXu7feO6lC0jxcGVNWubir1/enLfLefMGkVKSpx6qPdnC8NQDDHYSJuUBliyGexJIfnzDvYXWq+brRU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/5] mailbox: imx: support dual interrupts
Date:   Wed,  2 Mar 2022 10:25:21 +0800
Message-Id: <20220302022522.1789588-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3289c2c9-6b4b-47d5-56ec-08d9fbf3b243
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4144875321FAB42540D17725C9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq6FGzM/cZ1otXk77iOSEfzsB0ktk9y4Nuo4dRsfGbBr0Qm9fkKGJSLkDol8QYxWK3OE+mAmF6lYEy56OVXJwF2yOoeRYpZgzP1wfE/FHubpGlQatq6tEIxckwzutGGRpYQx2inLvW0NqcEuGtmo3Hg7WKYbh/5FdB3Lom0nJ2rfod40Ek9ylcS9H8f32V5DllZIvJdH8Aku8Yxj6l9JBZ+6jcVHMiqgJp+6ixvjzRKH81joBFPELxaTbtvmQuRSHdqA7SDc1CLDWq9dTtdpEZA6mE6edLRZfDt6Xs6PnlDRyLssDK9n7pMsc1rRqmdjValz9aJsV1o7MvZ/PsqEPQS0jMuA26WtnUu5JIQ0HMJvBeKb9HHepriRSKGNvkZhVMauCKcNYUeKzO1Ci6SBeSUJi5KGekquaKOfwTRfiwbV+ic1tqA62kuV6nI0kpcVC1c4yPl7sHjRpa1F7OaiYMgCa/nLHMu6JyBts3iKz7OrYag1fKJG1Zd36a3oZbfp2GbHKC1h7WYENLa3AOfJSetT9jruL+lLxrx1fEtGBgeGv02hie+joBZDQuG6/jxqpNTyaXPREB/rpBRfUluEKbGm/DgYh/pohUd2MlgpOeNZnmTEKulgGI0ceiX/NRf+TumzscAPjN4tnDE8AHiGhMJtdC/3QJJyGqIdL6qJ0ogSopmfgjVRIVnZL024xWlq8vKYhT4jgLourfkL5Hc3RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(15650500001)(8936002)(7416002)(66946007)(66476007)(66556008)(4326008)(8676002)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8sGSsf022LFS+jMWYbfZYz+D+y5sYJ1KcsXG4L/46sbe0ZiWexQf/Cxud089?=
 =?us-ascii?Q?koImDI0sUDcDZvJyEPvnOWDIeUbINEblIEMXFECaEU0LisiEhTJs9eyMXf41?=
 =?us-ascii?Q?1wm+smOFarqZ+o0BGXvz9Hq7E/VlDk7OeDG31yuwBL2SMDW4+rUuOZY4kFnF?=
 =?us-ascii?Q?zDGtNsyZ7nxBvFmby3lbW3+Ytn6yg647K+FvFgByZkVj0eu6IKtzU3uX+3tL?=
 =?us-ascii?Q?aIkS89Bp4SK2B1V2fcianKThr4Jrt1IRO+XtoIms/QJGiLritHJfSEW5BOTC?=
 =?us-ascii?Q?+aoxFwMUfBhgEQk8ha69Sg1Oc1jvCYrPXk+r+nwuPFqnkb/yRb+Jos8xNqfr?=
 =?us-ascii?Q?nKEelQdBWRuCS5ttK2ZGiW3enrRliaPQuQ2BWwni8Y/zVBivqxbOF/pSmtX/?=
 =?us-ascii?Q?KVGzu1Hsebj4NgpxMYTvWWYK0Cs4KSu4aTcM2xIUODaWNbU7nISXaQow865l?=
 =?us-ascii?Q?OwufPHgwcKsbsTc3w5bc2N+inkn3ewhj0oagBYgRyJgpb04A2cOs0mHQohRz?=
 =?us-ascii?Q?DrsrnOwQ+O5O7znAWaUvoIWwZDLd88KUjGB8wIhvTbYHsaXgtGcArA7DlTzn?=
 =?us-ascii?Q?6W/SUkYxnyJlTdCDBFdB+g+a4VWGEkzWnr/0SsBgriatn3Q+bHYOheX6T7oC?=
 =?us-ascii?Q?JglhuoYvGmzEpu+ZSQzl5Isv2OtwUFkIzvd2oNkBNI1GWkP6KzVZeNjzs0Nk?=
 =?us-ascii?Q?AwSG0jEFoncMq+zqFzecjQpfb1nWNjWYLLVfxVD2xULZDykw74YAOcs6KG53?=
 =?us-ascii?Q?VkUkbumddeaLqe6wVBMmHZCAiQTolaNKVy1iKImmDBH6u3yRMCvoJLzKG6Cb?=
 =?us-ascii?Q?OqO6uz90NDGypWA4hw8Fno5egTqRhwNxqJgEf1E5BBEGbcGRxrFCS7m/x5L3?=
 =?us-ascii?Q?j0GpwbEh1lSylZZTdj9iYJM+juvHZeaON/RFT8Gqp9BkuRr0zxGclRkeMEdA?=
 =?us-ascii?Q?hZ2q/W6JantdqH+p0u4uw9vghDoqBTbuSsudapPfut+PJVqCT7dL2eTgIQDE?=
 =?us-ascii?Q?kIU7FbedtBK96IPSOXnUTeEBlruZzU/KJQmwoK64E/pwOu9S21pe8oml5EY6?=
 =?us-ascii?Q?hg9uY9ni1DQLJQPkKlcWgNQIXnu+KYyo1uuhe31HTBMt/qarvNAelhpSjuao?=
 =?us-ascii?Q?fALllgc5IkNDZBx0un82WxuU0v1Yr3BeYCIxf87eQ4G1rrdZE/uQRcsSRqZM?=
 =?us-ascii?Q?PN5gepizMIz7FoSWBuQqDLhCJwMqZbPls6t2lUAZ5HP96h3QyDEd1MBtH9xY?=
 =?us-ascii?Q?sDWs9oCpPUsnzNXNzF98DHWmE5Fh6z/yckxmszES8CEFKk3e7+4+FRcJ8eSw?=
 =?us-ascii?Q?P5Mm6dnd5q0olBV+cu0aPkE559neqNEj8sNkjFugqqvyBOqJjyyUpM0mVm25?=
 =?us-ascii?Q?AUrHpnZ8X++c4wGhJnqoOngweY9Oki6oPWaOL55wIj/nxDUKetJ5g62xmAiz?=
 =?us-ascii?Q?26sDbR/US2u9baJes7WV8bI8dLhwzeZLh0HCych1r2vki8H/irAmlkJ7qK7i?=
 =?us-ascii?Q?YftuQJQHN1zILgq5+xM98SYGAqmaX3iXE1crBGK28BxZRwMVHOub3Pn64PnW?=
 =?us-ascii?Q?gXphkzOSUuv6zf8MoEb85TYWLDpdGUCO+4l2DB86xa+DarBDpHCwsnVk4pNA?=
 =?us-ascii?Q?oTC0Zuk5o0UTFSf8oWDTzpU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3289c2c9-6b4b-47d5-56ec-08d9fbf3b243
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:53.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UU453oADsFugkgiiVZ7+xRbcGtO/jJ4HerbN2BJWsdFNovao1/hlKrvdV+qWoZ0753ZOFV3DwQls4H43MuCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
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
 - Update author and Copyright

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 37 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 03699843a6fd..4bc59a6cad20 100644
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
+		priv->irq[IMX_MU_TYPE_TX] = platform_get_irq_byname(pdev, "tx");
+		if (priv->irq[IMX_MU_TYPE_TX] < 0)
+			return priv->irq[IMX_MU_TYPE_TX];
+		priv->irq[IMX_MU_TYPE_RX] = platform_get_irq_byname(pdev, "rx");
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
@@ -1001,5 +1019,6 @@ static struct platform_driver imx_mu_driver = {
 module_platform_driver(imx_mu_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
 MODULE_DESCRIPTION("Message Unit driver for i.MX");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

