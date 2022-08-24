Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611EB59F09B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiHXBJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiHXBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:09:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6848A6FB;
        Tue, 23 Aug 2022 18:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2M4Vf4jgmHGd5QLNRujyimbD9SlGnD908omnQnF/8pKaUdlnstlkFbeDf91LHZVcuzm731Aa2YoUPry05IJC2Q6iO9eoGI+ipTSWAHJ4E1NOJ/M0fZSfkPVgqlveGTcFJE2pLTlPXWLOniUGB4R0IArmWOCfmqMOslAvaA2N1jr2CAwXCMHI11qRWgvjxixUkKsAWnSwYzWoofILCAtYUL0kJrTRrqonhbbd9qcV/lb/gO9mAYdLUTJZ2jeL1SkvXXSODujjbySIJ3Gi5vmWF25mYe/46CzEkMf8isNF+rgtG7jBojz6ltJW8gSwcsiaYtg3nOzCC7VRbFdZjKmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbowT/KX1lAN42MBJtwjvOdXo3KDkHqk28b7ZdsaAl4=;
 b=FSq3FUaISJyA7yx2STit8YZ/SVFiYDcJ7ysntsjx14yck9OpMEFBBTMLlKByhq5zATXnjrvnTp8WJ/8PueSDYHZo3k+19wjup7Iv2K7d35UDeg3tuLuG5HpdA42PVYuojvYIAjcHkZByN1b2ryBTFBAUeUAjhbQT3MehxuZ0bu+D9CotU3AjCeUNFBD6pZXwb3j5mDvSbU/ShO/TczhsQHDwC/4XekqjoDQp0Dr38b2t/ZgCYcE5kI8gIrLYIeJP8ln5cA1nR3B+Fljq01ng/Zh/jILlz/KImJ+EWvAeOhxx52yv/otPedaYux5Y2u2oeI8KeMy3vtqXA2/i6Gz03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbowT/KX1lAN42MBJtwjvOdXo3KDkHqk28b7ZdsaAl4=;
 b=BDylb6GzCmveuNJIFwYIB/mvr5AtL2VM0Er9jOml0whr0euDBtYlzPsusdW3Z7ROOQGkRPnmdZ80sJZafrFISTYFftDAZr2gKyWNLeskX+3Hec0949nbOpdOsl6/ODH7mGiuqGVG1wSbPRpFG+1f3nUVvnEJLC2w0EPL2YVuPoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:09:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:09:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 6/6] remoteproc: imx_rproc: request mbox channel later
Date:   Wed, 24 Aug 2022 09:10:23 +0800
Message-Id: <20220824011023.1493050-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8b5100-f773-470d-c989-08da856d426b
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJGkkSQjY5/5dE03z9xTXotQYlMOgX7FwdTXQ+SrYabUjoqZE3NIUGxpXNsrC2S6/TRRvKI9XGqtoSDX3iXpK88SBFYCQOeA4xc1TG/3EgiSVHtfW9Jr7vs979JvUnJJmIKfI1fF/jeaeCOvXNtK43mhufHErCCsHJAvwZ3IV7d/3VnWI2lc2j8WJipOh+L4ePtkmNq/jMTMRKJwuoH8bbzZhACaqWQvWnvK7E8trL9KhSHfF4p6ZltbzENM8uvzNvdMLb8uT8qYJQ9F4Hc2qMQE2ClAYDjhDR709OXOu4ISU+Zp6cPEdHBEsz7IN94NKVmsoH/8+amfIS3sgMuIpn+PoyyaVRAaeLm44MLsq9y2a/Cn4xpPdY+XlkU/o3xakaepgZRSRsjb4RkWB8pzxBMwmOl6wP+vDW104rNrr6RhCjqzCbBQu88vN9NvFczF49PU3z29g6JpVoGBr9WRrwqdLd8h3vZ4bLUShJwSoOUXm5HEwR3KQuMAIBOv+dg+KOpw/emDd646TtTwcyPt/ZYnNxbr6BmVgoQhmIqP5S2lahOVUOfuPCZJEb7W3O/OCRhCF94qkQh8bMHYJrZHvJ/ndQYYlKuNU9uvcLFRcD7TFPU/+bKMLw5FXgC274uEM3rmN/aqjtwDAyTojzPvgfyOtvoLhw0a2goJH9jcEIxtc8AJqEDj3ELfkEPDpsZIoWqR2qB2AaOHyKZ/jBw7cHA6OXne7ysAVveEPC1MUDFthetNAHAgkzn/xScGpc4+nP2JfJjzgcGiLoGrJ4gmvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6z9Hgn8hEqCPxqjEzkE+w5RW0fY/bXJc2fmc6g5MXOYEBRckxZDo6ROoo/vi?=
 =?us-ascii?Q?RBgB7FVKKYVV65Ljbffp13t3zMhkka7zvVWboXl4adAKJQBpzhSRELNSJ/FA?=
 =?us-ascii?Q?pU+j+wMxXjZxLpyRVkdHg3yxWwi0stoSdLaU0GyWvHYtDRRxuIxS/IkhqhuA?=
 =?us-ascii?Q?UR78tHAoFqtrUYYgZx2kUgwXn3gllbnsjUjkpDHL2D9q0mMC+Qe6xAE0OsYy?=
 =?us-ascii?Q?mngrHKBoR/X+v0JfXRk/YnBnfNAXGo5+DnUpAk+XMC/4lz7OVeNv+xsKj+B+?=
 =?us-ascii?Q?SwEVBppH07w65cD60/C1M3TZxzl5Ahgr2iFus74V7WQV79Bm99n4rz2t/pLX?=
 =?us-ascii?Q?dIwjCAx5/A5t3ONev/BrSYtBq5nxO8VhBygf41rKparLgCUKkf0F2Sezl7X3?=
 =?us-ascii?Q?6p/iAdK29LZfkiPgDgCNrq6MoydATyAzWOy0HSkl9XQErBq30CXyvwAxXCje?=
 =?us-ascii?Q?da4RLHUTk0sAvl1mjIB2D4lL1gkyMuuvr2snytXDwLaK2jahLHounTtZ0ThU?=
 =?us-ascii?Q?glWrIBAE8x5t7F2k2HWgVgz+xuWxUun5l0JRCM95DEp4fgeggHFX38d+J0gl?=
 =?us-ascii?Q?k0HdrLMnszRM2lgI8YHr7V+MyKsNbOd6VJzyTJlPRMo06FXfx2Io7rp66kN9?=
 =?us-ascii?Q?1+t+3cmyK2QX2XRMfMqf9LbZzip8R6Ae3jDvjjJKbla6XkuLWNTtSkJEfLfd?=
 =?us-ascii?Q?bjCdSLLzj6/r25XVQp1px2SEEAY0L+BAEbxS5c/dqIT4A/NuAwbzzG6ncbrC?=
 =?us-ascii?Q?gVlig/u9TPLUWKoin8KNtAoWN+EKH/NrTIhLcbIMsx8e/+PGAFz1qkqv/qZW?=
 =?us-ascii?Q?d53HQRBkr0KPqJwyVbfiaIMKntyWi44w+AVt3sp0uuHbrsKc6itkgrFAyJlD?=
 =?us-ascii?Q?CEE6LKLJax9adD+1mOyMGVwsYBgC3ycxfSMqOwt0z6CAAgt7RhHRstRbt7LS?=
 =?us-ascii?Q?Hh7YknOlZ7LRVPg0n4vGcBztBnDmwl28BOGiPisQRAzenKOCj1F1jYJxEiPT?=
 =?us-ascii?Q?Yqtxo3H0RgJ8qDP04EIbs8cvWmswocuU5ZuJWRSioaWUt4zYSBITc7vz1plN?=
 =?us-ascii?Q?uUAYg8qWpNjpYsn65r1dBA6PxLKETJs/10RXX9eH9iKuTwo7fzeaOommuDxG?=
 =?us-ascii?Q?Hw2P4Y2vnkYaxZAVp9d5gGSnGqFlz6c0rHoazsfJEuRnriYBiCgid5YDTacF?=
 =?us-ascii?Q?2WlWz7YvCScuJaTZRHiGlLSK8zN/OnfVMsgXMtCrWssx6HsQvhsmAJff5AsB?=
 =?us-ascii?Q?8miCU1J0vskuWj9jN+WNNS1gADhUpY+eQ2Ph0GgQfIdaDY0w2CUY1jFQYio3?=
 =?us-ascii?Q?7qGpnT+6LH0GGeBwf5JotHdSZ3XDdemkw1MyFMfeqA48ByAKLSZ0bT3wthZE?=
 =?us-ascii?Q?6yDNjQL3nKW65WzxKUet80KgeFGi5aeLvE+NrwUh6/fEVZWD7CEj0xucC4Nt?=
 =?us-ascii?Q?0QT8UsUpQCVbaYjBypkwFcXZXPoBWcnt+H5NwwHQRYf/A2+axfA3q/4UEu9O?=
 =?us-ascii?Q?G1TcpyXzHLDk6bFiSobxPVYSKT3Nr/nRV41BFBb9NcQKkY2lPvSZkdZB5gbT?=
 =?us-ascii?Q?7vUV+M/ROqYQu6zx1o0Py1B54uFaX13b8hf6dalJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b5100-f773-470d-c989-08da856d426b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:09:14.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWUVwj082n8Vs46Mo1Hz7PEct2bePa+Fp+3DgjiXc3PJRfoT1oFuLxSk3MLW2jNK2Sqbna6TnHtoT76Xg+0Nlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is possible that when remote processor crash, the communication
channel will be broken with garbage value in mailbox, such as
when Linux is issuing a message through mailbox, remote processor
crashes, we need free & rebuild the mailbox channels to make sure
no garbage value in mailbox channels.

So move the request/free to start/stop for managing remote procesosr in
Linux, move to attach/detach for remote processor is out of control of
Linux.

Previous, we just request mbox when attach for CM4 boot early before
Linux, but if mbox defer probe, remoteproc core will do resource cleanup
and corrupt resource table for later probe.

So move request mbox ealier and still keep mbox request when attach
for self recovery case, but keep a check when request/free mbox.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9e46fd9bc2d1..62726efa8ff5 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -84,6 +84,8 @@ struct imx_rproc_mem {
 #define ATT_CORE_MASK   0xffff
 #define ATT_CORE(I)     BIT((I))
 
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
+static void imx_rproc_free_mbox(struct rproc *rproc);
 static int imx_rproc_detach_pd(struct rproc *rproc);
 
 struct imx_rproc {
@@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct arm_smccc_res res;
 	int ret;
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret)
+		return ret;
+
 	switch (dcfg->method) {
 	case IMX_RPROC_MMIO:
 		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
@@ -407,6 +413,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -592,7 +600,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
@@ -720,6 +728,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -749,8 +760,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
 
-	mbox_free_channel(priv->tx_ch);
-	mbox_free_channel(priv->rx_ch);
+	if (priv->tx_ch) {
+		mbox_free_channel(priv->tx_ch);
+		priv->tx_ch = NULL;
+	}
+
+	if (priv->rx_ch) {
+		mbox_free_channel(priv->rx_ch);
+		priv->rx_ch = NULL;
+	}
 }
 
 static void imx_rproc_put_scu(struct rproc *rproc)
@@ -777,6 +795,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
 		return 0;
 
+	imx_rproc_free_mbox(priv->rproc);
+
 	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
 
 	pr_info("Partition%d reset!\n", priv->rproc_pt);
-- 
2.37.1

