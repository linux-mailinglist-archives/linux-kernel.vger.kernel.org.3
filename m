Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348B47FACC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhL0Htg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:36 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:15936
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235522AbhL0Ht1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRxt7GiKSRtB1Eysvd7fH4OMQb+SArS1208OTqgbKCTa6CHlWPD4O7Cn83Ka5Tkw6OIXE0mTv3mzE9t6XQyAVn3rAMxmFXds7dRQk2uu56IzrXvWlz7F6zsq3EMTEEXipXnSeI3Yh9oA3FpXebrF8AezGTlWznMF5KmSYSBQNb8375oR2TN8Bjvq98OQBpvpbCTT4UF3cV3Shr0fxgLFDsLfzkr5LvEspfYWVg/o/6R0FBNbngweiAJzneWWrWuvsZGBhtJEAQbJk4QMUKmjcoilpflt2UPsLjIYiCf6KtpqPnu94qFxWXim+riLDjbN31KvsDdVYephxOurrOpf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpZnMG1+kfLkBaskDPFF6YKFFgEPWAI0+c/nVqSd9EE=;
 b=Zgz69NjXPDU3Z8sjpSzCHldutm17r2yNUY0bCMlkUIUG32ztP8MgQ3Sn16Ig6cr97A1GN44zsPp0EdUZEW4EIvLAcQY7BF2nRR1uOGQL/+l5vCBOkHkWsfjvfpvvmpDZFctRkDT6gzXZ0eQr+KnhD7sAhJED5C3VlMQgCQ6ZgiexvRmZE9/lbbms+N882G5GOf+Rmsbal0Fyio7HxBTHdfkvUI93UAx6Q01FW9GpjbGgHxAy86MrrcgNMpFJ6iJGHg2eDkLL7qSp/fdJjz35Zlu3JHX0IT1Z6xo+ah03aouB6cf5JJOKEapMgAF0yLHzwDsHksLgC2rcLByb1u2X3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpZnMG1+kfLkBaskDPFF6YKFFgEPWAI0+c/nVqSd9EE=;
 b=R3atoN8nbymawLqIbJXHcYKLO9jNjZ+tEJbT3dcKs32LKKzWuLZZKWzrc/Zlfm1QNKRlFaQtG1ZZQ68Glf5KXC7T4jPq2Aw5Go+31bfHIjNLrWIFketjkjtPdXFlZItetH5FCO+DkfmFG4JeWopgwlT382S5os2PF783e6u1Ko8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:26 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:26 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/8] i3c: master: svc: add support for slave to stop returning data
Date:   Mon, 27 Dec 2021 15:45:25 +0800
Message-Id: <20211227074529.1660398-5-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e0fb193-c588-4ef2-4843-08d9c90d677f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5629550B5CD546515123C8B9F3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1XB1mArbp+hXugD3ix8zPuBzhm8/NZ6sPFbNdTr0tKKeSsFOwUIj0OQNFRiosYZMkFtvcUOdnmmeBUzIp+QJPRgyEifqW9uqhW81OLriW3XdmReVC/GGKy3Y8R98OczWMKqZCJTxAUfZWVFdnsHaK6h9FPGlsECQuedsM2muZS4Yg087ZbEYDRCBOw/c3Dgfk6szDfBD181vbA5vuxxOSsjQ1yix6UP4LWZbw8YjCXnMzuOGMrRjii+8Xk+z5e0mZ/MfRgzbB5FNa9JyiMzEQFGzQZQwuSkeXGF79jE0XPeBF7/MqaZFJwHNlmHIym1jUGaGKVh4z6JQQPGsUrvKhk/AhmMdJx9+FXShs24KGgjPv0jsSpwdjIzeM1DtpJqFEVM3LjTohPt+sOXVbAghO0e80HIVjpzYzQx3qu1gLXT/1j1pML6TQvd7+38BPGf6FjZ2jcZc+GffOHVzI3LUQC1cNAgPElenzD6ABH8vc/5bAPtKLiHOtfW1vJLPUKP0xmia1ijtGxwnPxHyvQPQ1fi/0JoFgS5Eqd5y/7lHZSFDwqNpj80NpGjX76TD+n7qC+TLce2qosb08r5AlXmN6eUHmvPeox2AfmVp4SRpyHqJMCNeKmSSyVq5jpQOPYTjr3kvAS6bHZZOnCoKlJvseOcX5W6Rg0+AiYUZeDJgcU073QVebn1soP3k112Z9DPXc3YP/ZU9QRI4hsGZ21YDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(83380400001)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?asDUq18vKbWQHDHg1UEZkdEXuSsa0dyF1B7QyL28Bpg2gzdp8tpeOS+18YU6?=
 =?us-ascii?Q?PahZJ3nrxePPn9lrREFYxdHeI0bR2zQrFl8rR3gyjkMGdw7dxlUjb9RVpxE3?=
 =?us-ascii?Q?Ekk8tyaPkw6OIDixnyGSNzDRpokBLRJJmb3sDU8CR1bcUTbKk9J3t63Z2hVl?=
 =?us-ascii?Q?ZO8NcozvJ+cWTyD8UcrCfYw28tKTOF+2v+gl17aW6ukmmiaTL8vtck7pUwZo?=
 =?us-ascii?Q?JUkDXWrKok3r6Ogi58hs9fovrRhGcj3B4w2bHbh3NycKGbP8NlezWyPwTFvG?=
 =?us-ascii?Q?+2MvZRSM7cQgaFcLOMVrnfL2Hbi/NLBYXhxxILnXOlf8Gqqmsr5ENvYuL5ch?=
 =?us-ascii?Q?gfNKd1gU4XQc9vgSgiUxd9kSn0ijvt8XIQKJSAF0McrogA/HM0cb2UdsvEDP?=
 =?us-ascii?Q?KjiVCb7ZUQP5MMMaF3WAYKwr/KfUUn4PtaO+oTNHQmuxeWXsnoFvIVxt0QJg?=
 =?us-ascii?Q?Tfm69/e6M9CUBh918KbWQbdq491nVIOoatvFB7sVtF26hkt/Mr3SiNn9tKtq?=
 =?us-ascii?Q?CYtfjW1pvylgnhMRdeXiDHyndu68QKDhVdpH1Vx3RyUMPR3ChyLQ8nfsUs0s?=
 =?us-ascii?Q?bwDR1LpZtJShLZFh/93tI7YU9sojgi1LrrsutsbU77O8GwL4Hfzid7RSxQaG?=
 =?us-ascii?Q?J5I9QARkUvUFnVpG1LjWXO71KS0m3bPQySRGIpffytKGsCT//Lyt2mD/vNxX?=
 =?us-ascii?Q?fewuDPLfni1TEhWXgGPgdPjH4Vi3UkMTI/iCBhnsgTfY2CYmOh0rqfSsEMug?=
 =?us-ascii?Q?XKc8w5mCgvNE/DL9Oujs+8xBa9ADiTb7uOIq1W4YnhRJGsA0e2LIiSciZ1Vx?=
 =?us-ascii?Q?+Dnd1mf4aNkPyw+yN8MbXhBd+Q8/BaeqjUlmyRGdFtbvEAFsONpoUP1YY0oQ?=
 =?us-ascii?Q?Yw77uWd7u9rU0qJt20niDA3fodfy53zWZKtx+JmRsYdpRn7EhvS6lOadhtRV?=
 =?us-ascii?Q?VtokrJXTxi6XEbW85eWKvpJGWA7sHKnAUmS8IdNtTEvq54QnibTaWiwVEXPi?=
 =?us-ascii?Q?8iv5lpt8hDJH/KTQWPwzjGCQDyOxW7u6ZiCSPTITb7tdZot8z5Vx0cHLsy/L?=
 =?us-ascii?Q?jag1RLGHNwBFt2uVQrruP2aXYk08SQNHGDKOFPyAnBuapZZ3FGwvili5eca7?=
 =?us-ascii?Q?egb8GPOvt2Z+qS89MhfK6QVRBT/PDzg5MORx9ivUmB6DDCZBLhtvNmXcctxo?=
 =?us-ascii?Q?OO+QOnFKc5zOkJ18F9UASd2dpZ3+CEKybVMr4Rr3tW1wxcVPHp3TXeZ2D1jw?=
 =?us-ascii?Q?0+mNqF36JMyqJQ5oRPqlnkCQAb0nzXpYvRl5VyAYU05j9XKhKvk6UpWS+u2D?=
 =?us-ascii?Q?+0jmbvA9m1dWQHGI+f/hndwDh4oe8XPJpSigcJXAHXaFFjNHD5tWQneNMmkD?=
 =?us-ascii?Q?yybqdBjruHY0pT1b3FDCeU1jA1oebC3eQNKbpKD9Hq+lsEGVPx+sB3Ey6pvG?=
 =?us-ascii?Q?mLD3TNQb5gr5I6AU/O1guKppgoIAFFEujLHQcKpBoAn0TCOcJmXBWz704eYo?=
 =?us-ascii?Q?EfZfmo5Tmgzu14SkbMHkuUlq4+8CUDqgR8thdWOksETy3wY+lFazRKFjRRsR?=
 =?us-ascii?Q?gtHBLs/aPoQxDH3oOvEh7LMX3vl3nHgAHVIJUsj6psPoUv1qbghni7AnfTgm?=
 =?us-ascii?Q?G6+6HH3YemJ1sfg/yAsim3c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0fb193-c588-4ef2-4843-08d9c90d677f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:25.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlO+nxzhefd2iqU+/1U1xQWg2WmO7gCQtPAnfwfgcQBNOXY63sbCL3DtkIpK0+I1uV2V7TCHPdb9nco27Pl2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i3c controller reads data from slave device, slave device can stop
returning data with an ACK after any byte.
Add this support for svc i3c controller. Otherwise, it will timeout
when the slave device ends the read operation early.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V5:
 - remove <%s> in logs
 - add some spaces
 - !SVC_I3C_MSTATUS_STATE(reg) -> SVC_I3C_MSTATUS_STATE_IDLE(reg)
---
 drivers/i3c/master/svc-i3c-master.c | 56 ++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 4e69c691253d..74b38772d692 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -896,27 +896,35 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 static int svc_i3c_master_read(struct svc_i3c_master *master,
 			       u8 *in, unsigned int len)
 {
-	int offset = 0, i, ret;
-	u32 mdctrl;
+	int offset = 0, i;
+	u32 mdctrl, mstatus;
+	bool completed = false;
+	unsigned int count;
+	unsigned long start = jiffies;
 
-	while (offset < len) {
-		unsigned int count;
+	while (!completed) {
+		mstatus = readl(master->regs + SVC_I3C_MSTATUS);
+		if (SVC_I3C_MSTATUS_COMPLETE(mstatus) != 0)
+			completed = true;
 
-		ret = readl_poll_timeout(master->regs + SVC_I3C_MDATACTRL,
-					 mdctrl,
-					 !(mdctrl & SVC_I3C_MDATACTRL_RXEMPTY),
-					 0, 1000);
-		if (ret)
-			return ret;
+		if (time_after(jiffies, start + msecs_to_jiffies(1000))) {
+			dev_dbg(master->dev, "I3C read timeout\n");
+			return -ETIMEDOUT;
+		}
 
+		mdctrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdctrl);
+		if (offset + count > len) {
+			dev_err(master->dev, "I3C receive length too long!\n");
+			return -EINVAL;
+		}
 		for (i = 0; i < count; i++)
 			in[offset + i] = readl(master->regs + SVC_I3C_MRDATAB);
 
 		offset += count;
 	}
 
-	return 0;
+	return offset;
 }
 
 static int svc_i3c_master_write(struct svc_i3c_master *master,
@@ -949,7 +957,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int read_len, bool continued)
+			       unsigned int *read_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -959,7 +967,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(read_len),
+	       SVC_I3C_MCTRL_RDTERM(*read_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -971,17 +979,27 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
 		ret = svc_i3c_master_write(master, out, xfer_len);
-	if (ret)
+	if (ret < 0)
 		goto emit_stop;
 
+	if (rnw)
+		*read_len = ret;
+
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
 	if (ret)
 		goto emit_stop;
 
-	if (!continued)
+	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
+
+	if (!continued) {
 		svc_i3c_master_emit_stop(master);
 
+		/* Wait idle if stop is sent. */
+		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+				   SVC_I3C_MSTATUS_STATE_IDLE(reg), 0, 1000);
+	}
+
 	return 0;
 
 emit_stop:
@@ -1039,12 +1057,15 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	if (!xfer)
 		return;
 
+	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
+
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, cmd->read_len,
+					  cmd->len, &cmd->read_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1173,6 +1194,9 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
 
+	if (cmd->read_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->read_len;
+
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
 
-- 
2.25.1

