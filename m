Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35E64C6139
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiB1Cj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiB1CjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:24 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA362606F2;
        Sun, 27 Feb 2022 18:38:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC/4B14NTJrmyYN4Dqs8jleDc3oOKLWBSIcZoKm04OQnEa6lurD/KVCbXg2MP/dhWoTkUFAPkQsr7yw5O+FmiUVDz3CzFYbVDFGil3gc2zEior3VwVtKtA/sBdh6Xwln9usiGDdOhqVuM82+yxMBxdo/9v8RvSMOx9el3874ng0I8KuRINd1bibCDHtVvb12Xufv0ScgGaA+ucigjWljJ6/zySuOmK6VlEuP7Uoms8jiNW56iGesKGHI3/oDmgaB6BM/++u/49QttxFPM2Y0fxo2kESh6zlBygXxdpHS87UG78x3X/D3gI94rdG5CRu3AktDTGxdC8KuyvcOwp1eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=XRwFsU9O/dZX8rP8E/weQPasGPiQxXAEGtwPghiy9crx5bqUd/W8rLAvT5aDgu9t60020L4ohYdXH//3g+g9O7fPz9ZtGClqYllhIhJzSyu+8YaDr0LtInHGIOUWhiCzJkrVF+S2jHMGlxThRtbDBpO1OKCwBWhqXTysDY0hWmo3ez3A1o6WQhy5Fv1VMNZlT3MrLZ9oTfokhXvUFqcLXritf5GxToNiAmy2stVkcrO1Yx+5A7W7OszIej+zSzN+FLmg6BEJUCSPhL4jA6ooYRHSpPGpyCnb/3pb2Vbsut5/FADExHVOFpf3z6JtCZsZX48Qb2OcqLmYBv/pJdxpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=bvAWv0WdptdRyCI1EBwk+f3k5zfVAGOxACj1JqMihScQWbqqzFha6PgzzbrbjVcZvbr/BYNM0t6oiNe1jEf2DwrDyf7Yc5sRL6mQf9INDZpmzy0Yztu5o7DjBJwMk+YAlO3DGf8lY9ge+LPLiX9m2tF50x9b9HYZEZpq+NzT1yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/5] mailbox: imx: support dual interrupts
Date:   Mon, 28 Feb 2022 10:40:12 +0800
Message-Id: <20220228024013.2866386-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95aabe1e-f5eb-4950-aad9-08d9fa636e38
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8720D82C8A44A7125B34A90DC9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0hrAjIrXMJLr91TZ5/CutjdMB6JlUZjnnrcKSRkGUCw7UWQ1jEO8jwgbQMoqbLm0QT6pmuZ/8TN89iJ+OHREwk/NsK5HFzhcgjZpnSf0dpX7nyA7CUd9nk/2XFP3dnheiXkDEDmp4zOk+uneJ4I+H6TqfrT/Vll5GL7HkWCvXF4DwryZ7hW56/WYWXlYA3QWfUx7CYbhywaY7Ifyzxo29e07D3dAlAF8dwySXQcRCNyHCth+g/FwVs1kyMzdsrtjZllVDXXbs29W4sblzWgyL23MzPmxmajf2IRa+HGiJUGmqTDp3znRKEWWh+/6SWmu4o0CyDxJON68UvpT3C+oZSY5UxPr3OmvB0H4Yqy9t/OmE0MANfvej1l0gD3vuS1R8SAV8RskaYvIqHX5TCJHMQ+dLQd2FSBwDahsntKPlWssbaoQSQ54fEK0sgzBtyJhC376PSgVaf8DjD1vPWNv0CWtjv6e2OOuBGtBPPDQrISqy8LZo0CYtUyRG74FfNc7yXZfBSw71qKrca5Jvyu18vKFUv7DnxLkg1Pn6v2YsEAS6yIiOuV6t1looF9ld6OQwFOlwZCgXmPdN2YsxhAg7l83IVqshp9OzxILEJb7CRrWWtg1sZqvBuQYUDnxfZ1bb0hzRJEXJnXeIBpelYMOtuDqOkNpbQlD6JFqfwAohorCGZWAF/dTfF+ZMkkRlclhVO4NDM01zYYXFUntCugJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(15650500001)(38350700002)(38100700002)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qj8ypmXN/v37hZwM5+yJhJXKfMzYWMhczOkjOSZ5Z4h+qrPM6p3QWWknbmsu?=
 =?us-ascii?Q?D4E/fCpTmoub8Jp3CmOUWVrUj2bIlZuGLwIdQ3hMIz58fEuYJ9mk0JiTHCtE?=
 =?us-ascii?Q?WI2Se29wKeeyY695fgf9wnSk+VScPXFxFGMowX/Q/Hcfn6zFhkF/5b6ZG1k5?=
 =?us-ascii?Q?0jZ89xz1mBku90P0Eif1DViAJPoGmPpzL/ZU3bZ1ZbfBHCsM0rxLZnLnwSbK?=
 =?us-ascii?Q?qDK+mPskxZdFflDieWq1U+lb2QxiBhU0OMMLDN425dMwWpSeLotK+pW6z2CQ?=
 =?us-ascii?Q?uMnJsMlc5T8Yzg5+1Sz5g79Nhc/2TjsmuTResyM7Wl73FsCxk6HCI+TXVmVz?=
 =?us-ascii?Q?wk87UKaJ49pOVEpJg1vL5gp/qaypZCiUnzZpMVFxPdJE7vGortr0/S3fKCBn?=
 =?us-ascii?Q?vwGNFGhHGO8Iq5G6KDms8yUoVbnxdvkMnwEftbtd1xqhHtdFTMbAsz69kkRR?=
 =?us-ascii?Q?GCBvRt1kaGCJ8QPIoBrU0zn6jbGe6A05wsEKfLu83hsUw3BqmzHkT8VKn6M9?=
 =?us-ascii?Q?Yuu0ppvYQYoWFi13yyfl8n+jVVpUhRHHC/8ZYcJ04zXgLDXpGtgVx8pNEOuy?=
 =?us-ascii?Q?vvPLif9SWglaoTZ67LYBtWWnkX+1BIjAF3hChWsseoeA5kA5a5+GrCzTfwfy?=
 =?us-ascii?Q?uvENxFbnswoAo8mgkNzf+UnvNCl1KoZLrFeOowLtuQ7o9wi1U9QH8x+AX557?=
 =?us-ascii?Q?odRVi6Qoh2N5ukahlTUimxuVTeO77b8/YKRshaK8oObp2rxhfASDEZAIei87?=
 =?us-ascii?Q?uLqQMm/LBrtLtJMmsis1MbP65hhtPRpQs28e7tDI/rMxQMXEmasCbKrXwbMq?=
 =?us-ascii?Q?Shg1Ld1slxkO2vbcmQs5/ymWFX+ek5QKJIpqyKC54Ehe+wdaGKHpon8UnJjS?=
 =?us-ascii?Q?rlLJMjDdKRx7SSgwm/yvQeirxlp8dsK4klSxiiT5g9hI19dHtDO9ArzGCt7i?=
 =?us-ascii?Q?UApCavNq5No5YlCPdh8RuTGKMfXRBdk14txChHUNtg2zxMBU0oqH1c+/y0sF?=
 =?us-ascii?Q?My7mgbz7KPG73HltV5v9hDVAK5O9XHVXeDP6GtLMnk31lSGAs4PLZoc/mIYX?=
 =?us-ascii?Q?NUBQHFmeOzr0wtXKZBw4Bd+oholbIyIVWjjV4flxY0Wcw0iN12U1v9ApKYYv?=
 =?us-ascii?Q?v14pICFuQHS2Kzxju+ieoIAtNr2F1yCWl0N+Lro3q/Silt32yVQup6SSHZHA?=
 =?us-ascii?Q?iX2Tv5j4pKxjlDcK8QLWOfb26IcGfNp0oQnWaMlhZ2k9rL5cWJ3RwGpZGKtg?=
 =?us-ascii?Q?MI1e8IpE5MyqRvpj89WO4tkiDfAsVcwuQn+vQkXmHxKhCxd6MoIJWDq0tghG?=
 =?us-ascii?Q?+2XAMqTaIThy1KaYLK+mghaMOQRiClCjOFvhbjnFDurwnQod4/LR6OU5LkVm?=
 =?us-ascii?Q?+9+m4wCQhCHPvu6sZx2+YeKdbooUTS+ao1vupvK5iL8OGRO5aSCEQcj8Q5ql?=
 =?us-ascii?Q?X36FIrnvYiC3lYvFv9CwW+kM6/20QQhNaCuwmd+j+0pTOkqoe2UGyGE2zGU9?=
 =?us-ascii?Q?Okp8+sEFZPBpG0A+L1FxhLkNOh8eO+3KXH/ittl7YeEUp0eA+irrBH8cgfQp?=
 =?us-ascii?Q?QoZgxnmn769TQw+hRB62IEb/8Z9JPxF9kb1jM5bCQ9XOHJO6eAjZuYoiD17E?=
 =?us-ascii?Q?5es62yoXrAP57k6qiTuthvE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95aabe1e-f5eb-4950-aad9-08d9fa636e38
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:40.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06+10GHyPWJUAeVxZ+3D+6T7ijtM5p+l8x7PqHisc5uD/ySS5g3DoUk9/diL7dV32LWdCasF+Vq8NCB/rS5BlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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

