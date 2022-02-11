Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675754B1E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiBKGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiBKGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:04:16 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E65F5589;
        Thu, 10 Feb 2022 22:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtG9xenn/z1fvVKz0qFK2vfTJ9RpLr6y+w1+xkBpwmpsKlWIohMq8F2Ga25y12vDjoFUbL7KbuUE1UCLuYcVvcanyjZw+exRyZkqvjGyusIOyqVpV9lJCVWwdJBNQkCTSfI99BC6tHQfj+lyzcZcD0OLtJPa31YHHAA7QHU/Ya7IZDhbBnDOXoqsgTIKABzmZLRsWxQcylKihoFU+K2ovSO6QRYSJ9VzPDxDSWukvlJojGN3w+upMFO02/rSlEkMnsyepLHIzzGtIVr8ua9GPliVHr+6S7spWxJSpUK12YtmxWZjRV8VG/aSpt3M9xt2Ikxrgxcadw1QyDDpWqYN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pthLIQAGcmKCE9d9/edep0EszlPdR9Mb4QTULyCHlI=;
 b=FeUnr+1s1egB8zqYl8KSTVP+HIspWVoK1+uUVDmPcMaS/x1LVQioHkfsQpShfoTY+xewl4aEJa661/gK/nfpUdpclFFKP+Vh9UJfQ6dnr22njJ9BzZmIxQ/yxyY0ixjzuPI2ku6/k+vMeuwoLODAY3OYaWN12T16zN3cA/Nj4KuCIJ4mf1tW2dkptZEPVS1cY8cwFWq/qkEpO8gARdGk5b1ycIShP0jSduc7A1yLMAjASJEYYkRR4cHpFnbomq2ezVVU1O+1vbni44N1eGpEWa2AwNZQoDMRaVQXw7a6Fk6zZR4crfXmSyB+42UKK/dEMivGkfOwl5Ormf9PO7eROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pthLIQAGcmKCE9d9/edep0EszlPdR9Mb4QTULyCHlI=;
 b=bO9M1ycbk0qEjcYspvCUoL79Dlvtmmd5j4QlF9dniIdFKH8eiRLW6XWvtQ1AJkvB2ymJjmNeBV4TrL5eKanbrMFbD3eOFIb4XtMKisG3xJJgd6GsiAGxyCY605QOq99wt6hrq8VWVTSXY9f8qBPlEcaEeiu/rJmV/QrimpV6vhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:04:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:04:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/5] mailbox: imx: support dual interrupts
Date:   Fri, 11 Feb 2022 14:03:00 +0800
Message-Id: <20220211060301.1852772-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe55ef43-8953-4d95-e4b6-08d9ed2452e6
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7113E6077FABC99A3B3EE746C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKNd5IAZYG1jh6cLyEYJOFUNfyI0rSNRN0BYhGa+wsXCS/3Kd5AZKWphJG4cBb22My2HFtNZMRiQdUJ5cDvjmfqZkdLFkqoMEnpxqty+c8roCJGvv4CJdjigxS6AFpOP7e0oeUP1bA3XzwRqhg2S9wHHmwtUDicUAQELgP5p8y9GsQUhL54fBl1Q3UXurzm+xxgrtSStLlZwAuN+ErJPcYchz+i0AVCJGSCS8cdmrJhGf/QoSEnVlClvJyXatCR7ueYCpSxpriylpWkVG6R5w9l83qVtAHjnQ5ZKrtRhVabu2rPpQBnUZk3U1l9o+Jx0xdMbtvTtIbwR91P5E3//1bEW1HawGobTNpl3eGjNYtfZc6pnbdn3tX1BVk+YTCRrCKDLP2qKxpQpUGHazBh18CHZzuNQf37Tdi3AVcgNj2n7mp+7sTk6eHw2x8NjdaLhJBKO0L9fc+4vRpAGx7nMMLG+SAAOIhjl+gEg293+f8TOUF9MHjWa3p6Oo77X1TsmuIKOtJBItRWCcJftBLS/vy9WCPDryeiCNUdUuQzakw6eaBi+/ceMfwWb2O7EHmwKD2WKv0UgbD3IqNrwz5mvNVqbrfHuIaeH7TNI6JqUIUPlijvHIANhhOXW0lnD/O7OeMRf1V3Os38ze9APr+Ur71CMIQ50/j0RdBNWNsG29wp/unJ8fcm4UHCmMx9wC5kflA6rwQ/DggsCiwtq0DOgrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(6666004)(83380400001)(15650500001)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQ6ELnlxcVhOOKuA5enmnqY4PfaNui45dKmQPcmhEk5RG0oVu/PpFoUS7fWl?=
 =?us-ascii?Q?vkRaP6JlL1xsi6YG6do/HFHRx6DkhuW1iXBL6PBATnMxIo6FYOjF3paSKrx4?=
 =?us-ascii?Q?aifWATeKbvu7CwBJ46uZ0j9jMgfOUTM1aWZy7Szvg0Pw73DQQ5Mg5ftpvZGU?=
 =?us-ascii?Q?UmlXIqlHkXdQV68EH8ag19yHXP1Rns/BSG1gNrQotd+Yu7tYvJKOG3hXqnMt?=
 =?us-ascii?Q?VCcA4z+KyK9yRdzWCSVRhfYjbX/8DBa30lpmHB8kUkySwO5cbi1FSbC/2Vg4?=
 =?us-ascii?Q?7+/9LqtQn9zOAaDmbyPJ4TNMz+SXQ6+WG0jxJ/j5t94xvhARdyLeogbMq68+?=
 =?us-ascii?Q?wPXJCV6d4GuZNFJLDnx13QhXP2/EXXDmNo8CAAs22EVm6RMJvGOfLR0J2Xz3?=
 =?us-ascii?Q?t/YpQxIsPPVaSsB+4a8Ay6XBX3CmJ2f/KW+IslHuae2DLCja7dPU33FiNM0U?=
 =?us-ascii?Q?RfMETpFVBY5eVFpSyts13iD60kihgriErjEw+FJpg8bkyhQWH2D147B3nt13?=
 =?us-ascii?Q?t69nwGeA131TuU512/WM5vzRxhNMXwo/uMXZKCe4ME2lHapQr0RJ3db5E6/7?=
 =?us-ascii?Q?wieMnmvpPFEPqkIXeKY68KdiGhTQ3Iv9QgB9xcFmnans5vIe/oxYCD3fvxH0?=
 =?us-ascii?Q?bW68709N5icAs61yHfZVzkFkJKE0OUiM9dM7td3zF118G/xNWOTZtueIl8fT?=
 =?us-ascii?Q?kK7rUUX27i3RKiaf2B9OnFzDodDuNQklU7bfCq8oZnIxrbSt8K6wdE9whcwM?=
 =?us-ascii?Q?EmR6Zs2QMZDkKX8WCtrWRwGzeGZ7kA+vhjUczHgwnTA5IQAy+Ny01TYseRTr?=
 =?us-ascii?Q?Z0IxqiY55c6HOCNQxxWLNTnYCTuf4AWCOdubGLyQKVw8uSSx6ZNZbGXZmmuK?=
 =?us-ascii?Q?+U2S7bSBt/ws99iTZKclVEPWzYOcePrVUssV20Uoe5hq7BImvCNN3jU90TuT?=
 =?us-ascii?Q?DANhHUStc/9P0rhIQeVTAIuUR3SZEe3M/AMtqFC5Ffv2+zoa3cGD8V4cYUZ8?=
 =?us-ascii?Q?+L6TIcHBF+98P43T6TA8PG1MwQLOZO2v28ipaeuXA/c9TkdHJIVLyQUqo4xi?=
 =?us-ascii?Q?l9gn7pFricik0lynySDZaEymgZd9L0vYyltR2l+WvPqcKLb+kpbhbj6alPvY?=
 =?us-ascii?Q?sTN7HeKq1HVJUbiqzbZ5J1RYU8tqUBMHeJJWm3PwoHK894TNRJurmvdjGAuy?=
 =?us-ascii?Q?UJ0WqCuG1ecm1Wgt6fJPe7PnH8+K3b/V4bHMvYJfvZKglNuhfUoHY9CmAYfB?=
 =?us-ascii?Q?KskzMF4xnkLnaHhA8gr/cO8FR2XCS3ActHRODamzJNz7P0xBx6gCMerXhxqc?=
 =?us-ascii?Q?1M8w2pr59gZLAfeN6lEiM+O1v6DIJ9Jgvj7aPi58TTULWTl/jN7HvTh8P3Ym?=
 =?us-ascii?Q?F8EXrJcUSMv+IHZZB2Hsj2pW2fYM4XSL3/8rwqfYO4ytWfsZ8Y0e4UJ/Jaws?=
 =?us-ascii?Q?ZA0MxGZDxU1iJj1QucG9dTaTb1qP+qtIcFcMXS7ECxo493XNPhKdNQG34i/X?=
 =?us-ascii?Q?4ZAjMf5bccwBX/0GVOlXxf+d0cBwJLzOx1Sp2lVdBtJQJNiB8M4qnxw4piYI?=
 =?us-ascii?Q?6+N/NJiglXAiYw7RLPQwS/s1ne4+nQ7rZ6KMQsSHcecF1uWBT88dZbp6Veqi?=
 =?us-ascii?Q?Ca4jcqc8KGyeiXqDSGYPpkg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe55ef43-8953-4d95-e4b6-08d9ed2452e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:04:11.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jtJj7yfrSa2bCt5kTNRFojTlXHjxBiw8nZCtE4FnQnlxNPDQaBMKp6XaS/pqwybqyoC1QKrUAmKe8v9XFTrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
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
index 03699843a6fd..12617628599c 100644
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
@@ -1001,5 +1019,6 @@ static struct platform_driver imx_mu_driver = {
 module_platform_driver(imx_mu_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
 MODULE_DESCRIPTION("Message Unit driver for i.MX");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

