Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C29483BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiADG1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:17 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:27960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233069AbiADG1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:27:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7vQq2Zd2wSOY/RxP44xTCki67418QiW4FBiqrQ25LDPada58LO/9L5enVx9ActnFF3cZIMsy0idBhmMfRR7QikD0U0fLL2gx3EupwEVdY+Xby0lXviZkerticgH4ZZ76i+en6o36htb2h9vzq4qQJGopTWrNl3npIQTdF0pZ6ybxbliDa/Gw6pOqPABIsC5FaoFAry4d+6fD0ILLhZaiW6NzO6EeBwap38cN65pH9jfXevpGOf6eKImgjNdDLlJVmwr9CLXFzz9PqpGu9zA8siv+bwMYB+AnJkGnnaH1TzoXkoh0x4SM3JE12EgzbiR85PjnazxZuMpwiedzRlUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw1XJ5G2fl+mQyNxmKzK4TrCcufip7xBVXDwzb8QBAk=;
 b=fDgvdnY/aaQpeP6WNMPWt9dC2C4HbiTZstj19aTamIluFX9YHgi2LWzesXu8mn8ezIbz3IWcKA9e+XYv94sXTB0lk1aXtMdRinLxKJU3fVaHg0uAYyDLZ5kw94oKkGbRvjRbAMihJKabTBtfbEvXTvI3s1q91i3oXvw7hFtlLxeYlMEir1ZKgnJMq/5UG4G1xekS+uPypkwmO9sKCVej5xbyDv1vFLVcaYAuGBZ3rLR61ypE8BrQU39yxdUWFHjiSPTCJWjwb43m1KEUqBHPz8pNvmXdg+0aSGzvnnFlEVxcSEP+SVx3HDDbgs+76PfKWl9VX4DicH8HNyFDAGi4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw1XJ5G2fl+mQyNxmKzK4TrCcufip7xBVXDwzb8QBAk=;
 b=SJzOUkTKMuuqOXIUEBkDA3TFGieRIrlQlNZ/BUePHBtyCjr5BEi4+ejXmxFY7DRcAUfNptsX003ArSo/A131eYsIRqKb7fQ9WXvZLYAoT0bMUQ77ROdIkFCaHpz0zjkBho3sAT2+5ohYyeue0/lE5U+kf9p5nlaaQqqNFA1t6LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 06:27:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:27:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] mailbox: imx: add i.MX8 SECO MU support
Date:   Tue,  4 Jan 2022 14:25:47 +0800
Message-Id: <20220104062547.2103016-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa0ed490-04e9-4d7f-dcd5-08d9cf4b3cff
X-MS-TrafficTypeDiagnostic: DU2PR04MB8919:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8919BF6C47228224FE63CCBBC94A9@DU2PR04MB8919.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PLvBRsWHWT9K4Wtzrtv10DrFrkSzpduCs2TnDmVsCCfAc12Xh7mswBEIpteI1B1UGjSLSE/eBa6sTr3ZoD12NI4ZPfcHLs6QSLGIG4ZPzFZPZBSzTWC47a3ikb9hvqBoYrGmUObxSvnaAqfa+SpMut0blXgHYNm6sta9xpAknew+/H/836o9RWErOBYMf2mAmXS/mf+Vy4gVwFM8J/19vQRHST/OKthMHDEtwR4m0cZZT+kdOWUrIoIkobSvmqu5POyT1idRcBwDbFhJw0DCPD55wN4tK5zRSeoMNdrD2rWaDE44N6dytcZIsxCzIWZ7J+TYLgKNvW0OH3McVnUmaHc8V3V3YeIp4NJXR7We1wbgl9w8qQ4C/NyFj4ZlzivlZELGPDyOo5pX1TU6e7FwKi46YdXg/WbB7o174DRFdqD+7u/jZgBxjdi9HKbWApBumzB8Qufr1GzSzae39B+5YJX5YmN2e8NW4czXQZMqEI4Cjr0fp6JWbu/xkjjW4a8YMJcr3bpoLwD4PfoVudNV1m09pEdQIXkDvrV0KAsM4obGbZIzIQx2UW2J1dW+r2o+06EkvUiQLc1kU1LCwG2AasT0Y1rvq0qTHmsoWfB5ddra6LW2RRQE6lqjKb28TON3lSCKo9nVSRn9Tp5XAg+pccG+fCIM1484yPW8AiMHH059UPqoeymK8OxvOXNNGAIUI8MEXkjMfRuJRrCPhyDQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(15650500001)(86362001)(66556008)(6666004)(66476007)(54906003)(83380400001)(66946007)(5660300002)(26005)(186003)(52116002)(8936002)(316002)(38100700002)(4326008)(38350700002)(2906002)(6512007)(508600001)(6506007)(1076003)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sC26mCVF1gvweUJERnLPa4v01e1UDBkRI7QENEwUWbJmLWsT7uCyOWdhOvp+?=
 =?us-ascii?Q?cEmpkx097Uz1fSxIk8Op/LOWhu5Q11fOOJD629I8nWIZP68hJ4M9bpumu6vo?=
 =?us-ascii?Q?+tBpNfp7e0Z/+LW7SE36V6W/rqhLnPSajDHt+Ym2lDyqmHGGTAUIOjXkgxV2?=
 =?us-ascii?Q?BJYanfoeb0XSwxrsXzzMdsx/EIf3Hgw8HVd5Ht4NyimElF87aKpETZXhpuvW?=
 =?us-ascii?Q?zjJ+jNeThIsn+NiC0/xevn5//Ec4vbNclOW/0LdsTZoB4xKzdoNYdsMtkyLQ?=
 =?us-ascii?Q?5s7MyJ+3LKl4CokwuUyvStFPJ9ROBPKG66ETeELccOuje1rPeG11vCIUWowN?=
 =?us-ascii?Q?09rEsbP8K1wIQO/+1QAekbFiZUx3BhxJqkWEb23NQH5qeC+ilLkv7DuaGaiL?=
 =?us-ascii?Q?ae82Zm6DLlOY+46dbVyAZq5xh0waLM1Bo94eYXKAPvTfKxee077Ct1YKQfgD?=
 =?us-ascii?Q?TXBiih8xKyTgsus1ZP6/7TcipKEGMkdHFcYZqCx2u+/aW59Y8nE3/zdvHA6T?=
 =?us-ascii?Q?/kOJdERNSVQ2aASuFw44mZkg3m/jqSeyC91REGe7mgKVypnNsy4Gq2YGaxCW?=
 =?us-ascii?Q?kf7H4drWZxqfjtzhi/JZ2fe9erzKWgGzv5K50jfC530GiEHxqR8USP3S7rCG?=
 =?us-ascii?Q?BIIocFjPji/fSM72BvauoLNJ2Acn2B9O20/lKfI8+f5v06Bp1rkQ+pbjMchT?=
 =?us-ascii?Q?eQ2mPxUSKtzHmJFBgJTEb9fay56L5G8eT0QTFYU5Km7vGYgaJrV1ZkHstpJZ?=
 =?us-ascii?Q?DZ7Ke4HSaP+eMJS80zyIIpjXLaopG+QrqHbAon3FCcPKqvlGgoi7BwXBOEzO?=
 =?us-ascii?Q?IQczaAeBhnJB/RtQUYiOvhycrJqaXm2EG7tLNagZcbFZGdlP0kyFOjZ0k2o4?=
 =?us-ascii?Q?QaHgC1lPuHGqTSz07zufZwVUzfeMFguKU3BN7VVXArL74zfPIFpyH3mw746P?=
 =?us-ascii?Q?1mzeiQ0xTpB4xVi1VvCts7Jet4tIbou+s8+0wR+U3wPdwktVXLFETe8M1xqG?=
 =?us-ascii?Q?wvslDK1n0TlZwHEPPpjBrpj2rKAHrI6QXmOBul2alSBSw+avKGrjHHIYoueF?=
 =?us-ascii?Q?e7mSuYDvMVLBl/qLSAAPZcHEfJt4Q9BZV9tVR7cJRvCEijFz0h3OcSMO63FV?=
 =?us-ascii?Q?ooPj5hDlAGU3QEx4wQxSbnxjN5arU0RJ9HOO8BTEF5auQ8w8s9UGDNv+/iMB?=
 =?us-ascii?Q?5/OMnk1cmNC5pqwrrIkBqycIeFzpJ1+UCJ84/EKVelVJ4/h/CGpBLygOREa0?=
 =?us-ascii?Q?mEfVW+txFcgdhvGXRpFaatlYMfoert8scTiKnpjzD/N+CbfyH9o3TmZZx75E?=
 =?us-ascii?Q?yIZS0+Tn5SEY6nSf8i+jV4jYThm5YZ4RW0f1l0GMBU1eIQQf9RJMy932JHbO?=
 =?us-ascii?Q?IU36PnwfGnicdQzYU9NFhbH8+x4+KXh0hmtuuSI3f+nV+NZUwNf+IUuyDYFC?=
 =?us-ascii?Q?IRWqs5T4b1Dmi9xFzt2FYKVM8k/8A15YE6JM6aJTBdeyQfFtCXYta5hk83s3?=
 =?us-ascii?Q?7tAjBaVcbh8bsnlpU8xMp6LTF7obQjlXPlrJuCqf3LCWnM4T1PVpwBHkFD8k?=
 =?us-ascii?Q?0srunDfRUmtgxmHrAD6Q2UVKOsH4D+MrAwU3yEmlBhqONWN0skQfvGVWjpRG?=
 =?us-ascii?Q?d5EerP68eOZGewrdKRnd9TE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0ed490-04e9-4d7f-dcd5-08d9cf4b3cff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:27:10.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQso2Vik3vlFz4Wrxau5G1V+8DZJU+EyDoXbo/0Y2vz1TtJ3ZBLkFHjoiIHY9HDplTccjy083aHhBsOcYQDEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

i.MX8/8X SECO firmware IPC is an implementation of passing messages.
But current imx-mailbox driver only support one word  message,
i.MX8/8X linux side firmware has to request four TX, four RX and a
TXDB to support IPC to SECO firmware. This is low efficent and
more interrupts triggered compared with one TX and one RX.

To make SECO MU work,
  - parse the size of msg.
  - Only enable TR0/RR0 interrupt for transmit/receive message.
  - For TX/RX, only support one TX channel and one RX channel
  - For RX, support receive msg of any size, limited by hardcoded value
    of 30.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 213 +++++++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index a727eee49563..d70f730ff47e 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
@@ -24,6 +25,9 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
+#define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
+#define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
+
 enum imx_mu_chan_type {
 	IMX_MU_TYPE_TX,		/* Tx */
 	IMX_MU_TYPE_RX,		/* Rx */
@@ -48,7 +52,7 @@ enum imx_mu_xsr {
 
 struct imx_sc_rpc_msg_max {
 	struct imx_sc_rpc_msg hdr;
-	u32 data[7];
+	u32 data[30];
 };
 
 struct imx_s4_rpc_msg_max {
@@ -131,6 +135,55 @@ static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
 	return ioread32(priv->base + offs);
 }
 
+static int imx_mu_tx_waiting_write(struct imx_mu_priv *priv, u32 val, u32 idx)
+{
+	u64 timeout_time = get_jiffies_64() + IMX_MU_SECO_TX_TOUT;
+	u32 status;
+	u32 can_write;
+
+	dev_dbg(priv->dev, "Trying to write %.8x to idx %d\n", val, idx);
+
+	do {
+		status = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_TSR]);
+		can_write = status & IMX_MU_xSR_TEn(priv->dcfg->type, idx % 4);
+	} while (!can_write && time_is_after_jiffies64(timeout_time));
+
+	if (!can_write) {
+		dev_err(priv->dev, "timeout trying to write %.8x at %d(%.8x)\n",
+			val, idx, status);
+		return -ETIME;
+	}
+
+	imx_mu_write(priv, val, priv->dcfg->xTR + (idx % 4) * 4);
+
+	return 0;
+}
+
+static int imx_mu_rx_waiting_read(struct imx_mu_priv *priv, u32 *val, u32 idx)
+{
+	u64 timeout_time = get_jiffies_64() + IMX_MU_SECO_RX_TOUT;
+	u32 status;
+	u32 can_read;
+
+	dev_dbg(priv->dev, "Trying to read from idx %d\n", idx);
+
+	do {
+		status = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_RSR]);
+		can_read = status & IMX_MU_xSR_RFn(priv->dcfg->type, idx % 4);
+	} while (!can_read && time_is_after_jiffies64(timeout_time));
+
+	if (!can_read) {
+		dev_err(priv->dev, "timeout trying to read idx %d (%.8x)\n",
+			idx, status);
+		return -ETIME;
+	}
+
+	*val = imx_mu_read(priv, priv->dcfg->xRR + (idx % 4) * 4);
+	dev_dbg(priv->dev, "Read %.8x\n", *val);
+
+	return 0;
+}
+
 static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, enum imx_mu_xcr type, u32 set, u32 clr)
 {
 	unsigned long flags;
@@ -289,6 +342,125 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 	return 0;
 }
 
+static int imx_mu_seco_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp,
+			  void *data)
+{
+	struct imx_sc_rpc_msg_max *msg = data;
+	u32 *arg = data;
+	u32 byte_size;
+	int err;
+	int i;
+
+	dev_dbg(priv->dev, "Sending message\n");
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB:
+		byte_size = msg->hdr.size * sizeof(u32);
+		if (byte_size > sizeof(*msg)) {
+			/*
+			 * The real message size can be different to
+			 * struct imx_sc_rpc_msg_max size
+			 */
+			dev_err(priv->dev,
+				"Exceed max msg size (%zu) on TX, got: %i\n",
+				sizeof(*msg), byte_size);
+			return -EINVAL;
+		}
+
+		print_hex_dump_debug("from client ", DUMP_PREFIX_OFFSET, 4, 4,
+				     data, byte_size, false);
+
+		/* Send first word */
+		dev_dbg(priv->dev, "Sending header\n");
+		imx_mu_write(priv, *arg++, priv->dcfg->xTR);
+
+		/* Send signaling */
+		dev_dbg(priv->dev, "Sending signaling\n");
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR,
+			       IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
+
+		/* Send words to fill the mailbox */
+		for (i = 1; i < 4 && i < msg->hdr.size; i++) {
+			dev_dbg(priv->dev, "Sending word %d\n", i);
+			imx_mu_write(priv, *arg++,
+				     priv->dcfg->xTR + (i % 4) * 4);
+		}
+
+		/* Send rest of message waiting for remote read */
+		for (; i < msg->hdr.size; i++) {
+			dev_dbg(priv->dev, "Sending word %d\n", i);
+			err = imx_mu_tx_waiting_write(priv, *arg++, i);
+			if (err) {
+				dev_err(priv->dev, "Timeout tx %d\n", i);
+				return err;
+			}
+		}
+
+		/* Simulate hack for mbox framework */
+		tasklet_schedule(&cp->txdb_tasklet);
+
+		break;
+	default:
+		dev_warn_ratelimited(priv->dev,
+				     "Send data on wrong channel type: %d\n",
+				     cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_seco_rxdb(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp)
+{
+	struct imx_sc_rpc_msg_max msg;
+	u32 *data = (u32 *)&msg;
+	u32 byte_size;
+	int err = 0;
+	int i;
+
+	dev_dbg(priv->dev, "Receiving message\n");
+
+	/* Read header */
+	dev_dbg(priv->dev, "Receiving header\n");
+	*data++ = imx_mu_read(priv, priv->dcfg->xRR);
+	byte_size = msg.hdr.size * sizeof(u32);
+	if (byte_size > sizeof(msg)) {
+		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",
+			sizeof(msg), byte_size);
+		err = -EINVAL;
+		goto error;
+	}
+
+	/* Read message waiting they are written */
+	for (i = 1; i < msg.hdr.size; i++) {
+		dev_dbg(priv->dev, "Receiving word %d\n", i);
+		err = imx_mu_rx_waiting_read(priv, data++, i);
+		if (err) {
+			dev_err(priv->dev, "Timeout rx %d\n", i);
+			goto error;
+		}
+	}
+
+	/* Clear GIP */
+	imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
+		     priv->dcfg->xSR[IMX_MU_GSR]);
+
+	print_hex_dump_debug("to client ", DUMP_PREFIX_OFFSET, 4, 4,
+			     &msg, byte_size, false);
+
+	/* send data to client */
+	dev_dbg(priv->dev, "Sending message to client\n");
+	mbox_chan_received_data(cp->chan, (void *)&msg);
+
+	goto exit;
+
+error:
+	mbox_chan_received_data(cp->chan, ERR_PTR(err));
+
+exit:
+	return err;
+}
+
 static void imx_mu_txdb_tasklet(unsigned long data)
 {
 	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
@@ -494,6 +666,27 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 	return &mbox->chans[chan];
 }
 
+static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
+					   const struct of_phandle_args *sp)
+{
+	u32 type;
+
+	if (sp->args_count < 1) {
+		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+
+	type = sp->args[0]; /* channel type */
+
+	/* Only supports TXDB and RXDB */
+	if (type == IMX_MU_TYPE_TX || type == IMX_MU_TYPE_RX) {
+		dev_err(mbox->dev, "Invalid type: %d\n", type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return imx_mu_xlate(mbox, sp);
+}
+
 static void imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
@@ -544,6 +737,12 @@ static void imx_mu_init_specific(struct imx_mu_priv *priv)
 		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
 }
 
+static void imx_mu_init_seco(struct imx_mu_priv *priv)
+{
+	imx_mu_init_generic(priv);
+	priv->mbox.of_xlate = imx_mu_seco_xlate;
+}
+
 static int imx_mu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -702,12 +901,24 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.xCR	= {0x24, 0x24, 0x24, 0x24},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
+	.tx	= imx_mu_seco_tx,
+	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_seco_rxdb,
+	.init	= imx_mu_init_seco,
+	.xTR	= 0x0,
+	.xRR	= 0x10,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24},
+};
+
 static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
+	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
-- 
2.25.1

