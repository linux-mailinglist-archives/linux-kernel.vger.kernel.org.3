Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402984C08A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiBWCgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiBWCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:32:59 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056A5B895;
        Tue, 22 Feb 2022 18:30:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuABM058V2vUxvA3mJV4Yy8pz7RTI0xF/UhoKKu2PBjccTgopSH7CwN0nnvpNKMaYA2LWGPPtELP7OYuVPNCnnbyP8rNQ9rdNpjd7DoixbNQZkfH1HuScfPVimk+BXYjX992jYn/F/qTdAWTmeFxAa4rjgwS+MEURotVLdn95TBFAs/ZKKaBk8iP8GYDH37c8Is6NOhcGCtDOpqWz+9S76DCO+IiTfl+jITCtxpENC9py6htgU0YICi2Ss9LqR993DsIhpdQF+lXzPG/1pcTTV+wvgTR59SSr5tsxX+wgVZaZ3xc1hWpYzTcfzmlPqLJnV6/qZmFtGTzYfLT83pP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=MbjkZNVNzBtyJZ4X1Z/Fz+4ihO0tLo2bcvAoP/VqML8Ty8SSvqxYwIZjz9R1hilNWs7SJ/lRIjYIsLN9oYx9UMSLC4wgr2oTpYBPcWGv8Px0coNNBM8suRzIbcw6SWK6BERwN8g+UMuAlnatCFEfRR+ogSwUU9QgMkgq6zhqPrvBQnKHy8+2o730RPPbQARkPi5P8uUSYEJKmjva4awOqtVFeKTumE8qlo02KbtP4YadsBWp9Aa/1pwSmBvk7TcjHsWqzdVfOE8hu6hLt5a4esKwJYvvjCnxGFPOxNgYpkYF6iepn1kGDuiZqbDbAM5zk+RdCPTRD66IlWuzjIp7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJXfQOo4waySEkJOQJrJTxF+I+Qt4i5xzZfzXwWt0E4=;
 b=iem4Hm8G8ofzXblvSKoGnTiXdKHbv+e0CBwyzZcHeJEWiDtIukRI53yEaLOHSLAqQ2F/w/HgzOBFia+3t2sQR24XCVZ99TH+b+Tufr+Lyxnn1f1KdpvD8n2qzj8uKSNm0fXa1i12kLWB+jbysMVHCY+ubKjlgMLsUmLugqNg8wA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/5] mailbox: imx: support dual interrupts
Date:   Wed, 23 Feb 2022 10:31:56 +0800
Message-Id: <20220223023157.3478540-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
References: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 108b243d-29a1-4848-ef7f-08d9f6747362
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7311E57B4DE1F7E33DA6BA84C93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E730Eag9TcGPh0KuVgiUE3xieGydFqsQllm0QZZMySXVYDrg+QbRY0jsdCfz3VweZlnGieyBJPfttqjmCZwX0TsxcoI+k9wCQRMmG3HGc3onIcNgklUMiAfsSk7UiXK+j4Uk1SycTyA9LZIbuuCufeaCzNfzoYQaZ+ePBOS5nACb6JZvAxY5AqQcWwMlGYpRXhgHZhCzP4RZz8egXYybhENSoEJpUNF7isO4SY9RxhvXzovz4DirwuB/P8hhvP3d+Eyqw/l7RlzWkOZMkHcF/zPqy2cErzalC9R1f5jbEA4hm2iiZHnfSXx377IyC+/TKUu8+/Iak4HUPJGHtkvpjWLx2GwWTo35SRRf6xLCns61d5tJaFR7+aCHI9SBsgVqM4i8phCQhotdCpFVtS4W11SzifOlvtEKmL0YYgMIlVDInKapfAmKsiKoHYoQJLVAaVg15jg4vH2lOR/lVYD26YGi1ArAqAipPUU5UvuWAM5axS11xr7Aru2T0QWGdib4BWYSHHjNehlrnRHwPbjxiWmYRMYkmh3a+TR1AV9qjB4PF5TOVABbIc8tJiZB0JGx9RadBZGvDO8LxCVuVhrQmUxoOz7Bhu2vqkKxJ9dn5I+Clz93nqlcI4qsgOFvUFEV7mVN1gqvwxQQ5Ma/zvNvI3uNW9xtKpT0Ddhob94FR/FBV8l6vE5JMfbV/wizc3UfvMSCrpDA9USmibo845xJOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRZZGe4gscekzZiIehEf8i6qDCTwLvOhZ0/U7Xfh68TnnIVgpPY3w5BGC4jV?=
 =?us-ascii?Q?7MmTYtf/rnQKNXB55HzrHWL+F6KZKwRuZmB9J9DyPpeZHW7wV33x7ZOXKWNU?=
 =?us-ascii?Q?1FsW3iKcvvaZHmFZMkDYrNIKvTA2YojsRHdIR7/PdtOygoRM7A5COlB2+vBE?=
 =?us-ascii?Q?sVpQhgZE6FEn96VWMBWtL6Il8ceIjO9xmMqowTvEbtC7nAi8I2J1CSUAsKbU?=
 =?us-ascii?Q?BkBsIxGi9vhyvsIEdIYiJZ2EZiJvWU039dchk0BCuEsfx3fR97cGd7tV5IXF?=
 =?us-ascii?Q?s2t4uugP3FbmDe6/DFUJqh9VKFRrBp/usrimVWTeULWTcQGQvLztMgkNpNxy?=
 =?us-ascii?Q?otlj0ZEKyw07O9LM0Z2268nu2oPnySk3i86AAVvnRYK5aTGHZAeYfJX+cwYz?=
 =?us-ascii?Q?TVOB/Jcg6ArgtKJXWscYTtEADA5C4mY1fqL+CbV1NhbMdMi3pF6IPhdfwG4O?=
 =?us-ascii?Q?UJQsDoQB0ZmMnElUCP51DiKKiXdcI5hb/+t7yFu9gy8lEcNxfuiU3//34k68?=
 =?us-ascii?Q?0kxhyTSgc9xOhMTjr94UDR4RNF/mjqG1O/7QSLz95gVGyALRd0C8wcqFNAG9?=
 =?us-ascii?Q?Ormrv4m5XevVMLPHBeFpYHbxbDXI5n37B9oTEgEQb/3w/M43mQ2TwpUX13gY?=
 =?us-ascii?Q?cd73ktEvuCyNmi/HqiRRSlg+aBksWxR1JHW8OCZyRAm+mdIAUcx4bZ8mAGQB?=
 =?us-ascii?Q?wYTq3cheH9gcIlCE2MhKmbYS4ZK5hCi9Lw3/cOFBy5CH/LuOZh8jSgGJRrOx?=
 =?us-ascii?Q?vZUVpN41gU7IrYDrDI7pE+cd7YNfmU7dFUa1Eab49Ts9nlvV0B7r6fKR0q0Z?=
 =?us-ascii?Q?KTKg6ldriC5njfJJhg+VHthKEv5EF6Ka2hAOoMc9bEht0rp9W8KHkFW9Peoj?=
 =?us-ascii?Q?1HY+I1rJamzvwlnNEwf2hGSZ7OYM63P+d3hvj/NucFy5YRJdREaA+/cdX2PK?=
 =?us-ascii?Q?LDlJgcWWEXQDQ+QsPWT9PT7BePCTrIhkbijVu6HTuK1vJ8BVUWm1PBu0enax?=
 =?us-ascii?Q?cm3sxn6wLormG308UndUZD3m7VXlzxomxbx0pPoNouJSoE3/Nr7r9tgPkIXe?=
 =?us-ascii?Q?U+Eh4nvDt88KLB3U+OYvocuPur0h/Jm89oKjKSwWxWcF6GvgGcd4mF2JTVEC?=
 =?us-ascii?Q?klHdssU5n9Jjm1zBSGqglGFuHdW+10M+o+cHH2GvLvoorPxItP9dhZ0vJAQv?=
 =?us-ascii?Q?8EsiUcIipHHTPuakKHdqeJ6Wj01NsPNPpgYIdOpGt8thkHhyKIGEstQw1SiZ?=
 =?us-ascii?Q?2meCvf4c3kk143uNAJo5XF/86zyLznCcTViSE3pLuxlMphkfcKoxME0UgE46?=
 =?us-ascii?Q?qDPem1pjEDI73pewsl0KjdMb2CrBXBkjTqho5uCYKftxj5i20kwlzbM7Y0nf?=
 =?us-ascii?Q?WbRC08B9Z4np7fzOHVqarKTW1952/VAvrqk5bGWhKSPmT0lre/vMyY1QJlDl?=
 =?us-ascii?Q?d0dNlF8gyUH755kahSqQI6tlfQXAwePrJPj9yyzCSHDZ+gKYmI3o3HBnQIHI?=
 =?us-ascii?Q?7pNRSLZO3sNq7Seyhd0Q0tL4yNDoUcEgq5dwpZhDflrL/X4VMMQ1/9XQuQXy?=
 =?us-ascii?Q?OC2bgfXSfEEcSaOC87gvScBtgsJUFZFfSnOFWvBCUVB3wF/Ize1k1OZ1l3zV?=
 =?us-ascii?Q?Bww7TBlvclcZwo2VjWMTEzc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108b243d-29a1-4848-ef7f-08d9f6747362
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:26.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5x7/k7NEdTl0BJUev3VTy7ZdeFgDL1Txdl1od4KcmYpaiGIyMBfEGJMWB0kRAaWpHaAnwEY+PwhHVigDEnjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7311
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

