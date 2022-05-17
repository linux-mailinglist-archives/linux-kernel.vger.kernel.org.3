Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935375299D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiEQGsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiEQGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164146B08;
        Mon, 16 May 2022 23:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw4Onc0YGP0g2dAOIWEQjysuH+5k9ZKxpddmfOzdcDvMc21gp3drXTv1DgJZx1SQRNXsGLuC1ys1FPrVUPYOKJDRILSVqiB48sbDkVIbw7iSR7/i0HkCIJ3vwg6VqYBThXuDrWDd/We9m7zv+TDTMryuMbBtcLyz4/Qc2Ue3XOxKktVtqGn2bPllZVNTpHlFJnjOgeIf48ePWdQHORJ7F+zuoHHBoPA69nGbF0CsuSiDq6yps89DupQjVDnNxP6MmTyR2U8iYNZ2ZzO0uDZJEettiZbXD2gdcCeawrDM6RSfayLG5vGBPuQuFWzFqYbicGGbUGdOLRkCaYu7mDO3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVUlkDzaLXjx+FjJJi1SM8LUxfuSsRJdEY4yS/AYgI0=;
 b=CgqTQbUUmzRNdywtwKhZIx1zpZ9D5g3KuRcqld5X8iMK/AEqGWfvGoTOUbxoMRY8HBzDNJl3nSB8GMSI5GJnJCw7zbL3YUuJxDjpbkkU0r0npKuFD20/6Oh1xxhj41xA3yAIoYkprfM6lAQUZtGttKl54iG/jMxlKpqjh5sc9JKI3EuYOyoqIW6qy7HABqXPZ5W8a9QBQEAllSg2G+Ubk00qoers4uMZlryckU0jnqiGZTFZFkgArbL2TjYzB/4UtUyFbgVBS25Y8rCtvfsbO7u4zaop6UpEXvQFvkcUuZvT+kyNqra6GrKp8yZLQ1cNg3N56YfB7QBsiH74yg6Lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVUlkDzaLXjx+FjJJi1SM8LUxfuSsRJdEY4yS/AYgI0=;
 b=BhEEhKNyjlwkj6RqKbx7GprhoZRwyu9mcliBZsEunCSEmViDi7jLLQL0gxDW1egn0PaKlFpvdANs3X9S3F/qr0YtakjIlwR/W1gFYeV04Itwg8Ydb6VsXIAwO9F9GvlfuWfC3CavVF8l6JmUUFh3mxylXBb/5KsgsHZ8UAPF0LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2697.eurprd04.prod.outlook.com (2603:10a6:3:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 06:48:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:48:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/6] remoteproc: imx_rproc: request mbox channel later
Date:   Tue, 17 May 2022 14:49:37 +0800
Message-Id: <20220517064937.4033441-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52e33be8-a22d-4c2c-a198-08da37d1395e
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2697:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB26979F3ED87EBFD13BEF3529C9CE9@HE1PR0402MB2697.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXC5nxrB3OG+OKjKj0t0uGFJoPKc2cZnpfJpbz7Dw3PiOH0/eCyOwsPH9zP6cBo1kR5PnOy2IZmlfBx1COtarOI058Wk2QEWkRvW0bPl/tERJcaN7Z7LzKATaAXGnlpQzLTnK2RMPqO/0wVby3xwdZN0mG8rMMVd+2nmtSaNysuj0zERDcXjDULQgns+UxvVwtVRploj8aV0zOblPtE3ZwgOSTVSzAuQSCr/CWGxFmW2WNeR99uHnAC3vTR5962LhzFlMDu02YwcDjOVf6wO5I8B4PoBuAb2VedimC08AU/KhBLJm5MqCUJEBX4xFjFeXdCFN0taZhR/TCFWJato83zgKaVxxtd8pzBfsMSVidy0YS8uAqeRnHDR7npFnC9nYFIchuoLucRovqQXvkKSC7XDHqHy57pNZjs0KLS6m2Wi5WGPV+7FlZN3CqVd67uEMipDDlWGZ3kFYC9OIQl4hfha0q8wa62W0ZG+Bq/mdFk62U0SkcgXixplqaNyZCKSnP/1kypSKPz+e+hk4o954Lx0WE4mV4C79oN73ffVnOQMDHeO9nLcAhh6deLSL2DUKDbdQCmqCF9eW5DWXJjLSkgcMReSwycX2dnQAUtDwae1dsq2TfT0yoYmbOQGC2SL9EJJyF28tURpVaEdGIlRPovbsO1Gs5HIsWMaHXiyH9tEvLWmulVsoxSgZb+idtzrL/0R/xedWh6EUNHA2vcDzCFR7WQb7h/4M4anMYwKrw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(2906002)(6512007)(38100700002)(6666004)(38350700002)(52116002)(316002)(8676002)(4326008)(508600001)(6486002)(26005)(66946007)(921005)(66476007)(1076003)(83380400001)(66556008)(8936002)(2616005)(186003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WMbisVCZ7pyKfphZlJCo1dgGmm7pB00vnm8tzTFMDGHpGyWuycM0ja1VaA6?=
 =?us-ascii?Q?FhKMxCiUAXbrJxK2/PAeOsaiaVHKTf6VbzJ6E0Bz2h4VgWkK7OnK21tSVZk1?=
 =?us-ascii?Q?CSM9P3440knM09NHE0M33ABdNy729I6ZjiZrNoNRBxIQC5CO1EOiyIW+gZh0?=
 =?us-ascii?Q?IRctjBYwl2uB2rAQKLZHgAvDfvVTFXDn2X5PUSoxyH2DhS7GzfJMEsuPZkhp?=
 =?us-ascii?Q?zyJ8IU/aC925JuHUMc0cmQVBXqTQA/craolIZl3qkVmKzWfYsPFj7BLQSglt?=
 =?us-ascii?Q?ZNUjvk7V6KR5gE0MsYrVm8xcceS0VL60KevqCZdddrhzSk0BWrhN/14FIVfz?=
 =?us-ascii?Q?FZH3GeQ5gwHnM9OYJZiI7YAeiSK5vfmQ1AEMDWtmp4TQR4eGX/+EEtwXMP2c?=
 =?us-ascii?Q?5hXQHi5+lMK1YYgjQogPK0/q+EYgVSHfNmKCB908EQb+5dGZc7zgTYquYdIv?=
 =?us-ascii?Q?a2v6ceQ+hZLX2kF5gjJG9Q70BdH2EKULzWR0MRVs8+KGENte5G0t/r/4Dsgf?=
 =?us-ascii?Q?ztJNGYAHMpdOOauC/3dWlzxfGWvip+5hN/2gexGkZFWwhH1kA98URv3WDV92?=
 =?us-ascii?Q?6rHrkxYIBqznE60/pBCrGIrnWgvTU2n+oORXJshcQIt54Plh2BeFQoHKzkLw?=
 =?us-ascii?Q?io+/htVfDVNl0hB/MMXZDrvbMEeGsU0XgfsbZodRLoIaEOs4C5OsZX+zfMB/?=
 =?us-ascii?Q?dwRyYGa+B13B2l0WdmN65ObH+5c5xcgZG5txY1xPBUAKzothKEiSVz4oz5F6?=
 =?us-ascii?Q?ZWdVHh+pIS0rntpW9edVnTvM99g/Gq0mtVsxkuJnIUu5r2BfluEfDHmQ3Tdz?=
 =?us-ascii?Q?81LiF2Sjwhzbqq7z7mZ4LCz78FsDvlDBSfQs0aO+ruVxWSi3EtEc14T6uGZc?=
 =?us-ascii?Q?RP3ykz22+B5hiGq5HYjnPPMRMuge4lATUpgqNefyBtxoXCbp2d6rtq0CRA5G?=
 =?us-ascii?Q?87xzSOknm95CzMuvQ0ZVnnyuUhrzMdEkVIH0rUcygjaO/utsLqCI+QIW0mWC?=
 =?us-ascii?Q?BFpKRM7TL1F/PEKeoDkMGmFqfSgK4rtqulEv+kj47gnATyzPrNkChTyuWXN5?=
 =?us-ascii?Q?cDui0qDTQ74XhId+8/2DtXnYX1UF8/JNec1rt/s0GFTTry5cAvXqKIAVkCpT?=
 =?us-ascii?Q?t5UNU8zuboZ2ioj40MEhlAUtMUnWEADNHJTZahKasuUC6N7T1Qc6EEcg5J5K?=
 =?us-ascii?Q?IVP9XcuOmuKsOnzAXz7r6do1EdamAx8QFs8gvXQGKFpohcM6vesFuIT6iy9K?=
 =?us-ascii?Q?/xiBbGCbNdOwlpq34FoxdnqscCcqGwNWqA9ZwhOZE/7OQIyUNbCi3oG7cQ/Y?=
 =?us-ascii?Q?HRGgKaIC/ZFBxrNhzDHJIzmhWOYFBD5BXedsAxPeQ9JsEu/6+LI8qQVh+uQY?=
 =?us-ascii?Q?iQR2GmzzpntrNwLdk3GWT5AVYsoXTLFhNz3tyxq4WrsZdo+K5LFOC6ft7S7X?=
 =?us-ascii?Q?ZgqB56B0TnSl4AxbIOKRSJL2/3pQr0ZBFNCEok3td7+1KnlOSIdS9eLX741K?=
 =?us-ascii?Q?UhcL7vY/xORYPcL1PC292TR7+nOIe3ZGGXazB4prCjL1Fkr1E1GLeeJkqrhy?=
 =?us-ascii?Q?GokaB5f9cR7woO3Ke8w5+8PgKHDhMNDB7CgFsgbQ3VBWrfSZZRMV16rDdVgo?=
 =?us-ascii?Q?KhFzwb80sovY4iqxk+Ji7G16ylLZWtfHZn/3/SypG0dQSBrX+y2kxuqRz5w6?=
 =?us-ascii?Q?j52aps/K19+S7CbOWdBzXMTmZDaWedeRxQ4wS6yrl5XgdFEAdU+UQSUOI+ur?=
 =?us-ascii?Q?bEZAOsM+Lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e33be8-a22d-4c2c-a198-08da37d1395e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:48:17.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSQDx+p+ZN5ONlpbciB4c79b09lw87CEWI+F2trwYaM/cpzU+94gzDT+CH/c/vOLV3zd/cokP1KqruI4mCp4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2697
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
 drivers/remoteproc/imx_rproc.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8326193c13d6..8fe139624ecc 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -84,6 +84,9 @@ struct imx_rproc_mem {
 #define ATT_CORE_MASK   0xffff
 #define ATT_CORE(I)     BIT((I))
 
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
+static void imx_rproc_free_mbox(struct rproc *rproc);
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -355,6 +358,10 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct arm_smccc_res res;
 	int ret;
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret)
+		return ret;
+
 	switch (dcfg->method) {
 	case IMX_RPROC_MMIO:
 		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
@@ -405,6 +412,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -584,7 +593,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
@@ -712,6 +721,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct mbox_client *cl;
 	int ret;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -744,8 +756,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
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
 
 static int imx_rproc_partition_notify(struct notifier_block *nb,
@@ -757,6 +776,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
 		return 0;
 
+	imx_rproc_free_mbox(priv->rproc);
+
 	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
 
 	pr_info("Partition%d reset!\n", priv->rproc_pt);
@@ -1026,7 +1047,6 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
-	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
 
-- 
2.25.1

