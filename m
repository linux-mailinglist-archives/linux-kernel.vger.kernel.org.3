Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BE4AB340
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348407AbiBGByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348257AbiBGBx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629CDC0401E1;
        Sun,  6 Feb 2022 17:53:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQDlzp9N93BL2PrnH/ih1JquqlYDhvB0NO3eG3FBmjkmMrj7/4/tv38kOxihmuD+nxuP7K5zSCwx5Kx2YyVCVcVt1FWQKx71tfBApmbnv8ofq1gZsSzq7cCofzc7ejbEsKEOlRSRZBcO/LYlO9g6+ErbUkaM1riopUr2oxBnrw6LIzciRPgysTVmR+jOn88PBBIq52v5YuSUcpj/tSA2G95kuPmbABFhXEhs7EfO2oUb2RPrPVbSFPFuvCT27WQ7NIQzdLT3Oc99H5Vbn3KBIQ2lftTWFUXF1gmHdhyq4VqszRdxdjDKvHHYXAPkKHoyc1dKrN/cmop+BUpQkGXDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyepUu0NxG2JjUQwtj2TBBTs6iEw3DAYCsM6kKJSGvk=;
 b=hxIgcoCXKwx0s7KQQMmD8GggrztwxhzwbaCVnma/3tMlCQMQ8CAXCee98u+dTmgWnFr6p30DrVEZRyG0XI2dHeOt6S2VlTxsCSZU/NoVRMqMumKNAEsDw6YZ/NtEfdgqx/j9z3yo3cW8fSNVTGE7jfL93Af7teMNe5yJdlnlMx85Va27xOsuNKyMReG+8B0SSQWiLkULN6GxyvgNbddxNqdP4cpkDRohACDrRhtuqTLEtTQUn//GfDFX9cpumu7Nh1QCSiQwv46kfcT6/on3esPK/iBxXHGgAXr/v4PPiFAhqiaUlzvaUuD0c+mP/FHCmfykRP+I8s01+qArQVijYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyepUu0NxG2JjUQwtj2TBBTs6iEw3DAYCsM6kKJSGvk=;
 b=FClHOfopT1Pv2zyxr6GoISXWhG+3zeiJsXEn0o/ffY6+DbyUj4aIVX18eggw63UF6CGnGpim349pgz8rKCjpQF4G/a6XYACe2dclFKcCCkIa2H2UtocQCOxhfo1VKGX0XOvGLNFaD4JKqstGClOKjoP/KnGW75h+KH8GW0X21Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] mailbox: imx: add i.MX8 SECO MU support
Date:   Mon,  7 Feb 2022 09:52:11 +0800
Message-Id: <20220207015211.394297-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ca713d-20a3-439d-c3da-08d9e9dcb024
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB249372BE9331B04BE09F869EC92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1/DzJUupUzuqLimBHs1oNtyq1gP349wnYWP9Q25y4vQI1UClWrnzXnZ4IqfCGocNtGa/BqUPH4Gq25B1/r7qFCMdKiHg2d2i6mxibmwLhvG/3PjzpzKAS39Lf358s6bvQ/hjQPZS0bxASxEzhgHrQfRUT107JNjGotHyNUZZyMY0XOn48r0JurhqDtN8ni3dcTs7C7JCZI6fwtIr7DG5Bvmfq/qTE1T3mDTe9sCMKznDIaHgWdk+im/yGwDLHSA3d7HhA1aTKScfhjBkpQeUct9hXD04/QwPsIIzIDaohk2dfucqQC4yUfVheCIE6Lm+ZJ+iVBEGGU2UJ6mgiYQuq/VoTCsGGSSu2DK0YKt+KHtLY+SCj7l/DmIhppZhaHey/SQtbMAxv7EVf16zWO5VQrRykx7E5HVu1gdo610gVY7tBMKh6S6nGXNR3Mv9iC0hzHs7S+hxnvPl4TxVkopePVTi9+P9BGSvlWzfM/z4Oy+OAx1praydNe73WMuVp6kHzXz7tcBJTWNuzG2T6cGZJO0KvFYmqsJDlI2HRszL14ZhQVibqieYc7oNRoZ/HKHP88AotQEBKAZM9632gGwRsQHIbAd5n2NGRsfT90xmFuQXZC1NXHAPiKz7SKQ+/4AfvxVweNwP+QU5AeEGgUFMzbLNDdMwBlPxPKzMT9rn8sRPzFJjLCAFRd7Pru7lFsFRceuEh2dhwiN1A3WvUKjXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(54906003)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZEOhnb2qMxlhiQOhoRwmGe38zS48l52yyJnlFH6Huy5jCzS4K887OOXfL7d?=
 =?us-ascii?Q?I8jcRBjKGsGIyh18ruheELQv7afzPw5aQjyCusqMY6EXh45GecgwCvvZ3iU6?=
 =?us-ascii?Q?rQ7XxvUoS+t1y/SnZXmADC00UtHSdoUQoCbIqK9pm9qp6b4ZTqz35Fw1k6xV?=
 =?us-ascii?Q?U22FekxJMUx9Y4I2t5zfAprLHhsG1ZcxtNx2P65vy93W+fKKkP7ztkmXZqbO?=
 =?us-ascii?Q?O/C2QDU1HencrwBySdKYZNVZD3xC2aAVyCIh+FD/6j0IZFEKdSsZ/LEL0s5X?=
 =?us-ascii?Q?FpsFRwAqqzaTx+RLi70VP2TkJo+N93aPiIwXMLi7YZseke4ACpM1xE6ADyYn?=
 =?us-ascii?Q?xDlMqcgMoUk/AjkJJ+6HBfQ870dt5M5ReJy+stsPWateM70vZTnKglO+kaz6?=
 =?us-ascii?Q?RMyRkTZxvf0EtlrS0U2zNhLCk4aVYVs1odsJ2C/aalbxT5kcmVuNv5va6kQi?=
 =?us-ascii?Q?HGS7VQaztUZJ0DIhNcJDAaYI5StEMbjJxmM/jSLg5OZeEtT+Y+vhlF7wEF9+?=
 =?us-ascii?Q?tOoJGHPZA6mt15ANha3Fi3pbBDWeFeXWSAsMA/96YMouc3jwhCBhvlTERTvF?=
 =?us-ascii?Q?FNkp30XtD1xBB1a3zv5QaCLRYW8jh6eibAmSZHVNn/TiIrKPCmBi2YJAZWAg?=
 =?us-ascii?Q?5GWA8DtkC7tEZ4pdiTzfMQPuE5m8L0CByERP8UFpIqKggMXn7Z0fD6sJ7IdE?=
 =?us-ascii?Q?CHgFSpTy9CYHVtk/UAZ5VZOQn5ZGtm/ZsHCpFWbBgmTwVMktt27Y5tFAbQPl?=
 =?us-ascii?Q?pXvmcxnOzlr4IKkV/IEK4iT66rQqz9hi6Uo/aCx+OTgHLugqObXiKot+FwRw?=
 =?us-ascii?Q?mz1T0OD2CEbL9gEuGXjw8sD5BJMedsSgle4zuPZV0zO6jLYHEpgdlX2FOj53?=
 =?us-ascii?Q?AEkYdmapjXNXyl6DuFv28qC+KHsMyzG6K7MPgqkmlzp2/X6jtwilIP2sABbe?=
 =?us-ascii?Q?jKYR04GXxKUPEWyzzmkAlvQYhQLfP8NFnYCzQBmflBqZ/izUmTgVDm5b60Z3?=
 =?us-ascii?Q?6nKQ59ibX91MEOJRctjiFNbuoilN02X7AyMiDG+Kxgd87vlQe6wEFx9TLFVo?=
 =?us-ascii?Q?mr59622Adg02tQj7RJ1xx9WnRhy8HjywXXQjZXbAMV/8YlKgPlG+PpAeiyZT?=
 =?us-ascii?Q?eQD26Nkc7d/VT4bo5+PmsBQWy/+133Ef+yldKavtvU3fopd0JVqanlVB5d96?=
 =?us-ascii?Q?TW7hygE+UVQKF+R9jVcWAF7ywrN0N55OLcTZE3PBCdC6VAdgO24sHG4tr++Z?=
 =?us-ascii?Q?8dabi5HH9CXFK9bBBp8Q7i7MPPzaaeHwWtGILRzrLkDbCu+t8XAfoJ/IOdwk?=
 =?us-ascii?Q?t2K1qQN1v0tGbmpUG52CZnhFdQ3eqgeG48xbkbjf8EtQncwROeqolA4VqOHa?=
 =?us-ascii?Q?MhgeIAJk/egNpw2TplEWrS65K9VU6XCx5ZSwEii1GKM9exjOFp5EQ47NQHNn?=
 =?us-ascii?Q?a5E71eaTQCBFTwEsNxYqud6ZqfiY6vYrH5aoTGJAC/DtI5pVSpvfLsQPMUIV?=
 =?us-ascii?Q?9wQM170Psj/qa0BSRKeiiGR0P9aKe7D8tQf7icXdrwF/ZG5PrUDjhJkyAoK8?=
 =?us-ascii?Q?/dgCPmoBKpJUdfUBRCVuk4QAtgfgzopzs3y73+EfnmKYQH1kNbYqFTgH/zqt?=
 =?us-ascii?Q?4vvlN/gBbfuBxsSPy+s0G/Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca713d-20a3-439d-c3da-08d9e9dcb024
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:51.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FasGpMNupv6LrsCre1jUDi4o1/i77N7xILFf12erHHICBiJJfWWmg5gedMw8fW52GErihR5S2jlLdGIXjr6N0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 399e12671bad..cd011ca5707e 100644
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

