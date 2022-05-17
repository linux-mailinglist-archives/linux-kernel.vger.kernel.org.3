Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC25299C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiEQGs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiEQGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7745501;
        Mon, 16 May 2022 23:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDfZ5MUfE9x2Q8Pmz7k1Ri6ObJAsxv03sSYpL5T3TIF/uHYzaRuW2owkYkJNsuGpoSWTyNQhoxZ2hVsl2VpGcszCKZ8dBtd/paH9Fc5lmv9Uqdos2yXJXCiPgKU9Gdru1THzHqDILe1bDDeB2RyBmeMZF78phb4fkOqPyXXkQNdmEqx7YdwNUyvgKh6NqSJ2AIlrUWBBqJUbG/Cut2cuGRYKcdcZSazQcAGZj66ajmMpT9U0dPf0bXRKAVeUxk+rFwx9pbWC3igWyvZ0QHKiCsUPqsEcSVu2paI4ihg9KY4VtrpFNFoDMIl/RTlGMD4OLIYfQZ1IyKmKil+lHgAYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxcF2hjHTnS4H6LCIJ38mZBtW0CJeJTzz6kD1KSz+5s=;
 b=JVp1xEulQaxEfQ4bXWnodH7KvYM4XiuiVSykuTxlekZdFajfaAMuEg0IrBoj5vSCTaZ0aKPzOOqSsgiQZj3gx2MwABLhD6qC4MGClpaK6CU8au0eVit49gtGKZWeHyPnsXlzuy2q6ivNgRsBSPNoUZ6PDFc9LP8oXjy6MYcGBnE/2KLzW1d12hAWcz5+A7hpb6Zq05FLDwdr/lB/i5Q5QGfC1nsGc7bHPqf1/16sjoVcMzyeU6des2A9t5NR1PcJu62+1zZIneaCd6je/3mqy1vCa8inaWCdIc1ikUVJbYkQOsaKC1rulaBp4e1Ve8SeahLhGO8CdwkX03HvOd5yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxcF2hjHTnS4H6LCIJ38mZBtW0CJeJTzz6kD1KSz+5s=;
 b=fwvvZJ+Z0scsaNthRFQ1yNMksFe5wPKcMunZ3M8S2CfMSEGBXECnq5iinEnE2XLBTF3VPCkrd5WUJE5XXTon83nK7DAzueoCuyGMqm4saZYAS0MAUcBhSIIASrYxHZu1514qA2/TM3vSUEJkqj78KIwApIFCgFQhWGQJ8wnepnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3157.eurprd04.prod.outlook.com (2603:10a6:6:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 06:48:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:48:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/6] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Tue, 17 May 2022 14:49:34 +0800
Message-Id: <20220517064937.4033441-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0600903-6e21-41c4-95ec-08da37d131b3
X-MS-TrafficTypeDiagnostic: DB6PR04MB3157:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3157A8FB02769C42E82A8691C9CE9@DB6PR04MB3157.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOtwQ+HxN8ujWc82x6BIoS/qvR8SNnjZgDdBu8yLy3Aa7KHnVitvATuV2gjC1yFlaaXItkUxwt6rVdWgzXd+xYHdyh8cDvmvyddBTYoeMpgijCUEmMYYxGHTLHsKPGj2L43wdsGnBS6CMplrirmR/s0noTp72hw85otuWEii27NKwlBfSptjDtCXMNqGZ1xUZHvmF3LRR3JZcgRLJiGPAv0ecQV3MTQTjfR/04uJjX41RdRw7YJNaJY3Oga+O8axIIL6f69cnZJrALE81M3W2LaHD2TMt1eAuQceNUzo3rhIzbWXnZ5iQzGzmV/bSBeJCqCQnHQJGAxL86hX3mXVatuHRAnm9NjWodY8C9njCYtJJCTcIAo44qkkm1yXRW5AgUA42roiFk0W4itM5Ogy2obtJwE0E+cDs7SPlks+8ME8vSxut2va2PzEggjdsBJANfmVAQVznOZ0ftEc19CUXo3JvyVpZ8bY0k3d9l5vUBxHLISNWbPLFmCZkJH0QCMP6o9txsMHmfBhnVd+MP4rvkpxYMUpLmO025fQ2PlNgBRCveouWM/2etpE5EdcP9rI7c8PPZH8g0DD27m+94eeLBZhCvDldGAwC/YU/ofLR4V7SXNrI9qOGADxATGeO/p4ITvSuk83rWuPhCiflcFqlIT6zIss3cpxnYFjjRZAC5aQoWtM7JCAbB2Ny5e2Tf315muywUGkvlpg/7DiwuTznKWVRn5qBuDYsBlVqLlsV3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(66946007)(66476007)(6666004)(52116002)(1076003)(6486002)(2616005)(186003)(7416002)(38100700002)(66556008)(2906002)(8936002)(921005)(508600001)(38350700002)(316002)(26005)(6512007)(6506007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B+9SaT/vyLv1N+egPn02TreDa1cwd7g0xitrI93s415IZvMF76TzbmeY9zFj?=
 =?us-ascii?Q?o1gVnHRbURf1vWketWML705Rg4++os7tuDuaGS2YCJx48PeMRDH48qBxRUaD?=
 =?us-ascii?Q?zRR/wgNm8q1YKVoUnNr3qzfqND7QAPDe6uR5XoB7UagfxrXFeyXAfiwy3YaS?=
 =?us-ascii?Q?GjM9YnZGrpOtkR/YFzlK8FVKkF8e3Qtm7ZXTX8J7PeCkYlm247PQB4Db7SRQ?=
 =?us-ascii?Q?2CThYA4xIreehy02WZ3A/BDfmw4pNYhHdSV/uSRdKfP7ZEvzdU2ZgjjKyfFO?=
 =?us-ascii?Q?8A9rbRVKt+dcDwLtfd27mijUlia6glG6Ofia8a15W2RujYOzTTEIfOA09n05?=
 =?us-ascii?Q?n3SlHr72lUtxOH9SgmxA2sDz7XYJ/yGB9eKKzZZQ5KwC6LLRXqcvyhZ4Lm6D?=
 =?us-ascii?Q?dcML4qTLrDB0QTY0KOZucb0NjcAar8WSGUW18r0JT+l6k0DOx0x5tc0yIoEy?=
 =?us-ascii?Q?6hqMn1605i5Ye2eoBPT6UfzSJYVlWljHxXtjwxqR5VxI4ht3RknGQoc1B1Y/?=
 =?us-ascii?Q?fDiD34J69Yw+y655QvUeR+rvckjD5Eo/ZOMCdCTIXk7JjmfdsuUCWl7YHWi5?=
 =?us-ascii?Q?C2iObz+CvDe6Yq5lS96vVcM3v4IN4xgdftBQ/GhPzT/07T02tSdkr/iUI8G0?=
 =?us-ascii?Q?wHPJasiPELiDcPgw/CPmp4TqMysxxIsfc+6Wz9AHQDVUvrORGd2aUxJN3JUl?=
 =?us-ascii?Q?4kKDcqzVfp7fjO3mludf9TCFAl/URhbRSB5SLaqB6Ou1uMZ4BekpV830TsXP?=
 =?us-ascii?Q?0149vCpRHNNSg5tSbpU4/n+5KvI/LTFeqOvpBqcivaz4f41yiL8Aj3JMM1OG?=
 =?us-ascii?Q?uOCqiwZPKZ/k5rRcmgIdnduG2cptocJ2vS8HgP+AGMi0se8zk9Hg52HGVi+8?=
 =?us-ascii?Q?N48arZB8gBXN6fZojxRqa8fnqW4ArzzHUg2Mi1B8rN6J8ch1NmVBaZsMVIPR?=
 =?us-ascii?Q?cYZmjRmtlSvjjGYYbmJN2bzV3mc8uxSnB9lvoXmhLR+o4hG1UCrYl/Kr4I8L?=
 =?us-ascii?Q?htNc84NTubFSHVfV6xxMmOKrkCy/yTQGViq4hroq/2O50lf3mDX98H2vjRpK?=
 =?us-ascii?Q?8USVVqFrZCFb2OxI4l+5vkIymf4AOmNlhyegdJu1aCKYrPtAB9ZgaSWe8LHX?=
 =?us-ascii?Q?xRU8f1tdIRAH1S9I5Te4dPDx9iMhRFgHjCAAdXggixB1/Ei8VQu8gfBBXQ/O?=
 =?us-ascii?Q?XjEIsV4npSTKp8gPU8OsSXPtFlC+m/rpq4bfanQiOsn07DEAkiAJZE0zMU7K?=
 =?us-ascii?Q?2pqmOz4R4nAmxGZneCM+L1g+XsrkdYkIfzefFc0hkwOI3n5YmJrSjfCfkScb?=
 =?us-ascii?Q?CwUWl4U5H/liymy6PoFvIHX4r0qjbmQdsTuhQPRjOysZxAT3aJNTdcbs674w?=
 =?us-ascii?Q?PdTjQRwnRAw+nOFcb21L8fIb05AriYeGqYF9fC2Jkc/29qF7/l1XEjVRxzwl?=
 =?us-ascii?Q?Zn2VTmSqn7HLMbDEjgKi56e6Pd5N0fxWiz/OmsgoLIvFFX0JmS2L+XAN/bwZ?=
 =?us-ascii?Q?qLfp18iBIDqBG6QhluIh4OqmCrvUFIfRLeXGTWQbquGydJNeSJhiKob7O3rT?=
 =?us-ascii?Q?DA9qu229cNRCDb22aSSCgWxuUTXGixxpw6+zkh2jorYwwOXsSryoD6JdfP3s?=
 =?us-ascii?Q?CTXP/edtrwKAUCjC6O14fZbtJkiQZ5V2k5KhJZL4heZ4eo1CtDoHchGlv7Wj?=
 =?us-ascii?Q?MfRzrEN+2NXJGm50oPHp2no0JyJz7F2Fxgd5RAD19Umh4H5EO8F/W4uWFRA1?=
 =?us-ascii?Q?OhSSBmLuuw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0600903-6e21-41c4-95ec-08da37d131b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:48:04.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DF73OjL+1P89kIX7hqTA7UlCx9Ys6+PbF6YKbdPh1pYw1FZVFb1DqC26fcZkp9ELuXplgWY3xb4lbh9aUfdzEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3157
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
could only do IPC with M4, it could not start, stop, update image.

We disable recovery reboot when M4 is managed by SCFW, because
remoteproc core still not support M4 auto-recovery without loading
image.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 4a3352821b1d..2e751fc90760 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
@@ -59,6 +60,8 @@
 #define IMX_SIP_RPROC_STARTED		0x01
 #define IMX_SIP_RPROC_STOP		0x02
 
+#define	IMX_SC_IRQ_GROUP_REBOOTED	5
+
 /**
  * struct imx_rproc_mem - slim internal memory structure
  * @cpu_addr: MPU virtual address of the memory region
@@ -89,6 +92,10 @@ struct imx_rproc {
 	struct work_struct		rproc_work;
 	struct workqueue_struct		*workqueue;
 	void __iomem			*rsc_table;
+	struct imx_sc_ipc		*ipc_handle;
+	struct notifier_block		rproc_nb;
+	u32				rproc_pt;	/* partition id */
+	u32				rsrc_id;	/* resource id */
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -117,6 +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
 	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
+	{ 0x08000000, 0x08000000, 0x10000000, 0 },
+	/* TCML/U */
+	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+	/* OCRAM(Low 96KB) */
+	{ 0x21000000, 0x00100000, 0x00018000, 0 },
+	/* OCRAM */
+	{ 0x21100000, 0x00100000, 0x00040000, 0 },
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	/* ITCM   */
@@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
+	.att		= imx_rproc_att_imx8qxp,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
+	.method		= IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.att		= imx_rproc_att_imx8ulp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
@@ -683,6 +708,22 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 	mbox_free_channel(priv->rx_ch);
 }
 
+static int imx_rproc_partition_notify(struct notifier_block *nb,
+				      unsigned long event, void *group)
+{
+	struct imx_rproc *priv = container_of(nb, struct imx_rproc, rproc_nb);
+
+	/* Ignore other irqs */
+	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
+		return 0;
+
+	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
+
+	pr_info("Partition%d reset!\n", priv->rproc_pt);
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -692,6 +733,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -702,6 +744,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		if (res.a0)
 			priv->rproc->state = RPROC_DETACHED;
 		return 0;
+	case IMX_RPROC_SCU_API:
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(dev->of_node, "fsl,resource-id", &priv->rsrc_id);
+		if (ret) {
+			dev_err(dev, "No fsl,resource-id property\n");
+			return ret;
+		}
+
+		/*
+		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
+		 * and Linux could only do IPC with Mcore and nothing else.
+		 */
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+			return 0;
+
+		priv->rproc->state = RPROC_DETACHED;
+		priv->rproc->recovery_disabled = true;
+
+		/* Get partition id and enable irq in SCFW */
+		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
+		if (ret) {
+			dev_err(dev, "not able to get resource owner\n");
+			return ret;
+		}
+
+		priv->rproc_pt = pt;
+		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
+
+		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
+		if (ret) {
+			dev_warn(dev, "register scu notifier failed.\n");
+			return ret;
+		}
+
+		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
+					       true);
+		if (ret) {
+			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
+			dev_warn(dev, "Enable irq failed.\n");
+			return ret;
+		}
+
+		return 0;
 	default:
 		break;
 	}
@@ -855,6 +942,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.25.1

