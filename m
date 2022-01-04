Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D094483BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiADG1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:14 -0500
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:45956
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231902AbiADG1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fByJPm0nYwBkRWwdk6ctnohZRT/sEoL0P3yNPSv1LPbOwJMmJzek3VygQ4w7YjwiUO89x2Cjlts8auQOKzfimesYj/eQ91Rgxwvn1UjnrRxFY8fn8GBY/ovibXG+eFQCtX/f9+TF4VT+p/XRQ2cLA7mEnd1jZ23bon8puPCiYPLUtaaMdCzYh2yYZqjpbXnPh0WVArfU+uayzBALj/Pq66Zk8oFblKXTOceJPjmaSiOBMvIw7N5Q7IJ3HA18G91RtSfY2jb92+uBPg84rck9KpVibIHsfYufqsWE0RhGvrLRJAp708BiSDHi5y5mU5nHs9NiJW/hiQQjaB0LoqcQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFNA2XJTkGUyiDzEnihnEA543V1RH34QQbDFK2H3Sw4=;
 b=QtVsjepm0oCI32J13tVoMk+yyJeZLUyBNtn/wzJrIURVS9ohejqmNRde8pXvcj/Egn2/U/wTsaP55QiQW5V651mp+H5QUe8TZaKdxfPu98fiktBqiGVOSIofsk1lRYyk8b5wNpEk95JKY6cF9x4uJTeuRQQTg2vm1ACoR0GrUoqJl40n8HFRJYs/V+45gEDyGJNm8p+rRB0bammz0L11L7jBrUmZaQLb+Yo1AOPmGHozwpp4SHuKl4mArzfQbfcQPPZDqZGg3w/eUg1G9Wj0MuA8WIVSjFXtpvQvhl4ptNOnsECAddoXfjcD0e+JEUsC5hK0wHMRLv+NFFJH/cmOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNA2XJTkGUyiDzEnihnEA543V1RH34QQbDFK2H3Sw4=;
 b=A3Dq1KhPb3BocQuuFFf0N6VVxQycetz0QhbPSjFqa2mo0DlG7Yhpul+0wmk+T0/iuB5KknO81SnaA7Ir2Gm5nOvKrIYo8iI7em2HlftTwajgOXiiHe6nW29dRM/3zdqxjo83Peqi4Qfiuw6B+7bHvJKkiuHrLGEbGkvM79t3eYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:27:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:27:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] mailbox: imx: introduce rxdb callback
Date:   Tue,  4 Jan 2022 14:25:46 +0800
Message-Id: <20220104062547.2103016-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1f0501-c959-4472-bf66-08d9cf4b3a98
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB929813A9DEB6F69BAD161D38C94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4MSIBvj309a5XUMN1lWgHC18/lhYL8EcLfKASdZwu8RdOsRUvRIyECvKLU1N/49/tVkRBEqoAZrMrpnjSo0tE7XgKJmO2sN3uZ02z/fYcoyAUv3C9N8mo6N2YmpW1DAZqhrbHib5dOJ78sY+lrvYGwCQDjNrPJpLwkSXdkYgeZbZ7w+Yf1iBkPm9ThjkIfgw4DVygPyp6MWkeCNX10xdPG0r0yIv9c/GYUuvmVMwXp795H7FeUYslm/mgtXnCWSAEjHK6kHd6ltlck/s7MwFpTIoPSbQZTBtDQmC58NwyeO1DQAs7/sS1Ullava6OCIwU0LBbmI1TId5E4RC0QlqeJrrZry6lnpaK9JQZdntVDI9eWqLdORRNr/sKj3mzqWOXcKWivK5N8to1au0fTTk7is9zX+JS8dHzjbYJMTiBhKHSoIAp8CIZBn/CrmbWMdMSeZnLCfu57bP2HbZuM3gTjtvXZV1Je90ReSSev7pexzRiVqCusgbXKbT3eCOQJVa9zF3lVCb02nmtP8YaxclxA28ItuwF3PYnscs6ZNnCeTLYE2obK75UfhSs9Vvrp0EdtzZMpxG6edqUZXNU8Wn9Ft4QnymR43g0UY4tc63lcMhj8yXoeuLTi2BK4AhUBKqAfy5Bty2Aayk4sUd1sXjDN/Enjd5rZR94Irnx34xOFn9vU2SF2ywXK29Ze6y6y7/R1n9nfr8rf4HRbwok/uow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(2906002)(52116002)(316002)(2616005)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DfRFfiaLgc1v15cogli3SrgntEGdSZlOCJo82Mr+3ou2afjvqG1FGAGK6adl?=
 =?us-ascii?Q?Nn9k2ySR0X46JddKVFmWK/+oekX8kXnbxmq2nZmo3IJZTqH9XBzGKm8CEKtn?=
 =?us-ascii?Q?1cTeJCpePnKl9Rmk1zQJC0gUXU9K7sut1GZwYQU4vhzOqUz65IZ2xmfXv2I2?=
 =?us-ascii?Q?RX4A5qqIb2NWmgK564wGvCeHkiOFSVgt0SRvy0N77nJNyaw2BedRRPMhQgMk?=
 =?us-ascii?Q?iP0KkHAFSyZcUWQrKhJc2Bn9BFNL6pus18HLXKxzAgKwdQWaIvoF9Syi1D7N?=
 =?us-ascii?Q?+ImOqELe49iJm+jYPGODwrhAXKpU0i16NkVuGAuYVmrmv+U+HaeOQzbI8uQo?=
 =?us-ascii?Q?C4AZgr5TaoLmTorXgw2qB4ZeF1ZuU5jorH/prEjbqk5X1NEuH1qxTIXM9hzV?=
 =?us-ascii?Q?J18LkuKoggDxJxQdzvP06Qaaj+7TnFKU7AGCFrFPSBeHzckBY2hE8HocDZqU?=
 =?us-ascii?Q?x/rHCGqKW5jL1yioxIzwbchYkCQf2r19zcXmAvPE0CNGfxWjbtzFOWoFzQ7H?=
 =?us-ascii?Q?G2gzx/iJSaT7cFvH08P3eDt9LjJEAYzf5PEorH/HNWkBwHum9YCKfIUkCC6T?=
 =?us-ascii?Q?NsZ/IMGHZoqcGVsfGoPcqweULl38ryi7/83XJQ41BYCI2ejJsVu1ezAxHCHJ?=
 =?us-ascii?Q?+gB98uaWfyREEJpVj5FMjzp8ty28rKBuYzvhB1+nus0dJ0WdyoZKpjHg+K4c?=
 =?us-ascii?Q?IQZmbjd75nEGSrh0MCYCWChbAigeXfheAlIV9c3cAX7WJQIVrfKHKdiJJ3rO?=
 =?us-ascii?Q?po1UraVh+58IxaUKD8wzUT70PMRSUPex4BfE67HlucJuICScDmJIYgjWhnfw?=
 =?us-ascii?Q?wg5olZLy8QdJ4TJ2sAvLzUeXqZy6K5W0cbQDfURgI8VLlTAa56+db9jCQ7h1?=
 =?us-ascii?Q?Zl0SwcAf0MzFwM+nXoVJ65pOG9Iu9JOk11/tevTqhQX4JhFRH89qkzSZG4QJ?=
 =?us-ascii?Q?mINJBa6Y8IXQ0Lmd6A2EKb1voHhSzQS/jcsCXO/CQ0o5agK7UqtcT0mpOihv?=
 =?us-ascii?Q?xiNnslov1Lsi0Qu90gRDRjjMxd1mcVXrVJvySSgQdQ74imKRpbooGke/dx9z?=
 =?us-ascii?Q?Cc3wcimx9kiAEWqflRjB7EDERVtgFDjscW7tv9CdaTQKrcV9CtOmYb36j+Pe?=
 =?us-ascii?Q?gBn0LwPC+2qzcc36ROQrDyM48aRY4V6Q/hsWSojFGUkN/PcQsnhOY4q6YpD9?=
 =?us-ascii?Q?lL0SsWVxeA2877H4RGiPrFNhHTSqpD2qSMJWFdWKabxEm7xWXSwT3F0WMDlW?=
 =?us-ascii?Q?h3SByPFG+7tEgxjVYku4xbNMv00UfA9ucDyldrh21XSiFAl6OToRFYv5nHEP?=
 =?us-ascii?Q?YYaQoqZk/yeZUrwY89WY1KKQNipIQc6E/zmOUUPxHhM2NfE8P/1jCMkVN39/?=
 =?us-ascii?Q?Z6Q1YuUCG/keKvOM3TjxuOg0DnpfdP4T7lTsrqE69j3p+pR2Xazgfp6v9UYy?=
 =?us-ascii?Q?26pmVowS+zJLO7+JTUDxM+UwonSpt2p3h7HlqbDRSH0FTmZwa6OoGWx8Qkkj?=
 =?us-ascii?Q?y2+ol17yNBz/SC1C6Drf8C/vo6Fi1l8BPaB3L6UTuxjRq0c9KKen7lQ3IFzb?=
 =?us-ascii?Q?u0GsS/8x4AiQHUqwJwEhMQgFjsP6HA5UYQhOpEybtxyovy8tSiLLV0YKwU4v?=
 =?us-ascii?Q?0gDiRQ44Odh4HCMoJIUPJKM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1f0501-c959-4472-bf66-08d9cf4b3a98
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:27:06.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUL2QFGhiLOcYf79opBNu93exuaiKdIkDh9xIUF7lpWVmLU5XGVfDO8bUdf+rTPyAWvqKwoPngLagzpMH3DSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add a rxdb callback to prepare for i.MX8 SECO MU rxdb which has a
different logic.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e8a212d0da2f..a727eee49563 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -93,6 +93,7 @@ enum imx_mu_type {
 struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	void (*init)(struct imx_mu_priv *priv);
 	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
@@ -179,6 +180,16 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 	return 0;
 }
 
+static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
+			       struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
+		     priv->dcfg->xSR[IMX_MU_GSR]);
+	mbox_chan_received_data(cp->chan, NULL);
+
+	return 0;
+}
+
 static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
 	u32 *arg = data;
@@ -329,9 +340,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		priv->dcfg->rx(priv, cp);
 	} else if ((val == IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx)) &&
 		   (cp->type == IMX_MU_TYPE_RXDB)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
-			     priv->dcfg->xSR[IMX_MU_GSR]);
-		mbox_chan_received_data(chan, NULL);
+		priv->dcfg->rxdb(priv, cp);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
 		return IRQ_NONE;
@@ -639,6 +648,7 @@ static int imx_mu_remove(struct platform_device *pdev)
 static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
@@ -649,6 +659,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x20,
 	.xRR	= 0x40,
@@ -659,7 +670,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
+	.rxdb	= imx_mu_generic_rxdb,
 	.type	= IMX_MU_V2,
 	.xTR	= 0x200,
 	.xRR	= 0x280,
@@ -682,6 +695,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
 	.init	= imx_mu_init_specific,
+	.rxdb	= imx_mu_generic_rxdb,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-- 
2.25.1

