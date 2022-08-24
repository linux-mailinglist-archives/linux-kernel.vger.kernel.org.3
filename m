Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5419759F08F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiHXBJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiHXBJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:09:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A527FE4E;
        Tue, 23 Aug 2022 18:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrsftiCsO+hkCdRL433o57X3WvKu6RJyRaviETwz59KAXRDBG46pDcZo4J+Bg59ewTAqXGivn4q18xg2u9sJvx5UsaGWOnJqZM3yruok7BYqvBAS1C0TtfPlPn+2vyYSWOGUO569oUnEtHdSIdBvuFnW4+k5BTF3kCSK4MzGLNMsQBOB8+TobbNWkhJgOopVEpx8/yaN4oFjoJJEZOOde3ZgkuffzlV4gLK+rizYK1Uzp8hXrrfd1EoR1tRIwH2Si55SvB1ir9+dc212gzTM6xXeqyvVw5yl6IYPZ4cb5aIHU333+fCgx5UqKPdt0QfskkGgqbMGYw13p0yhka4vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1BGWAxmr0gKp9yCLcPaa9w24oOq322w9+bA5aNiWWM=;
 b=djSnnv20ISs/ZkVgI+xf7A8xoAPADF3jXcplKUgj6Ip+RJb0T5L3L9DbWkSS4G3RoSh7tGFNcKAfellajabZmkxD7Lxp6WTZ38HRUKwQadqx1wd9LbRMW0LZU1wZj/XpM2uHd336y9bCzymDpdy5AJVgeCy16l3q7nmGd342MRaYM+y7J2Ty+oyQ8OPeQJ/hgb42OcXulCeUofUHLMTMi+3Sw5wl/WT1GxuvfCRNU4X0dwy4JQPgV5BiRi1hHZcg/8DPOEbdzhiR1ewTDOLqfRVGzMTGS1q0Gp/r290zfQ9vu3Y2oheKtTbPnKrCrxmEsM8EzZkbSjWbdba+BjCj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1BGWAxmr0gKp9yCLcPaa9w24oOq322w9+bA5aNiWWM=;
 b=aKm3dONIR5kmObK1vKjlrYx4W66FJrdrvBhfQj3dGIh4wo2xt9KKAPZiyGpQ9SBcSltIeBjj0q7pnGG6qfK2P63YZsNPGwz7zuGro5XKTuUQhJgQtI3PF0vgt3ZSfpXQkc/nW1GrHRuo9KWCTL00lTap9cw6OOx6CO3YUMmJLUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:09:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:09:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Wed, 24 Aug 2022 09:10:20 +0800
Message-Id: <20220824011023.1493050-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae879175-818f-499d-e6a2-08da856d3ad9
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cif2ZIyJB2tE2Nzke7an+fIFFCR/hfPjZ1CU/7GK/3LyFqzX8ebZvTK/B+znylLytC0qIYPhAtjANSpFeByIr5s7VbD+SkojTBgic+CT48ymZOob3FgQFIg+4zP5y70ya1bV9Mozk+sk4dVO7coUM9h5W+t5NPHZZebN0cInZaJjPkcPLfa5nfVbxuiwDC8tz3kOFwoasZjfJhyMLJctNQ9VHiHxMIMzjl5kCu3hGDYqhaBM95TiFB/IKsTxyan1qi5tF0P5aNJjSMDBDfY26/0NKWtFWW3tHnevaGql96rZalOxlHlSizHnSAQxeQ2rEYUgTUwgMqxZ8kFiW5jeY1acAeB39y8WQWX4fumNp07fHZ1tXJT8ih4qSB2gecTAeGx1f2vhwFja36NdhRHftGcNg6fvb/Xios/p5GwKQAgeYVZM7sQewgTfS63XS7ibFe8KCaQbfn8shTS9gXZ9v173GWPHyE7H1MEXZMVr3lio69Yasq0IqOXepdZBlXQ0gbPkFQg0d37SmXQR+c6eR45zH7ZCCzBeDhvycSKqfJtviwl4HoPSv5tE4SAFyXp6lA5vHwQX03Ir/GQf3Lyvr3HCpuqCfYHe4MMCsUTbN/I6PPpB4x3g8FgFvr9YTInDaTTUhr/4u3e+ST4sDbka7i2imOziNWnkYABRlxwPJioOb2nI+cOvtJQrcKolQbYUq+e26QNCgoatGjTHttUauSNHREIfJhYR5FOJj35XKN1+x2EQ0SlBp5T+Iw3b4BgXawN9shVdnSF3u6ksXJ3E2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NctlCF/J/PRdxZatGHgqFoov0czAMrtXCImNnN1Q7CSb8lMrm2apClOg++tz?=
 =?us-ascii?Q?sl+uJMEHb/YwA3Pq7JfBb5DTSaelJ7S/0DsE/Sh9bhDgECZuo17wZRbUKJ2V?=
 =?us-ascii?Q?ri2BvZSSIeKV2pTRY7KB1+OeRCfaaGZfiW+1WEgPZssMOdZe89+XGPiwhKmt?=
 =?us-ascii?Q?mgkKjo9cwGZEpVUNosbO/qDRL3PNP51WC0F3qoZ24hcU9G3A5bHDg0jEBb3w?=
 =?us-ascii?Q?1ywvDxPajTswCDnkbp3kEdxwog3gPuroWF5EOUATKW+LfC9+oBh8Ah1U+0/g?=
 =?us-ascii?Q?dC//arc09W6MMex3TfYmLs/LefYTLoYEZVkWs4OjHX58BnUIjL9ca9j0viGg?=
 =?us-ascii?Q?QTXyBx5/558pTH08q0WQfct//sOB2+clc0n8DJ50RsB52aoSuebJa9vQ4nhp?=
 =?us-ascii?Q?fcKhpumF5j/zhxsm6NYxe5R0XSS2GoycKnBZVKdSqQzn4Iwzs74jS0uob8iv?=
 =?us-ascii?Q?zLjl6ETvKQllNGIh87oLAHhYfhmere6sSTA51BmeHtNSO6CgcEPZhTZCVj7e?=
 =?us-ascii?Q?gTsdOkwMVPISrgj38q27WQ2vB6U+VTTklwspbOdjGj+xqqSnyBGwJBjEex3X?=
 =?us-ascii?Q?gma0FO0KryfhKpeSpTrafyspJXFRdsgYnyglfZBFG9YI66VB6PWYgqsEZZM1?=
 =?us-ascii?Q?BBGmqHw6cpnWRA7ag3NaYgW+LzqFnZOztZCUHASu7CpalaZ8jvdYL5afDheT?=
 =?us-ascii?Q?3LH9oxFGzHbefpcN60iDR+Vw0HetjxaQirgLIaU7NnDPxwnNLc/lhpjQZDw0?=
 =?us-ascii?Q?sY+z5j3FydNW0JKpBB7FWJYGsGJ9W3r/M7as+Pzgs/MQPAupx1aTq6ZKpFgK?=
 =?us-ascii?Q?T+DFgYzN0aRs3rWNwWTmZXdBo7yynIxsnbnTNzlfEyPD4euG2wWjFUKhQ4X/?=
 =?us-ascii?Q?scLsVH3exDcZcZZXhZTppLNnX+tR5PDtI+vbDXV/hOKYwMhldlD/998QDvJ9?=
 =?us-ascii?Q?bMK02nKowtqKKZgjh3DEzJov19qwyxO+LWVSLZLu7fFGJP/nBuaiKhL+Uq3+?=
 =?us-ascii?Q?zgBDuf/C1JsE5Vxtb8YOT3Q+8Fw1zmyLBhDFfOMMjE5+ZyPnZOQ9wQTmpJr2?=
 =?us-ascii?Q?4x/GiUlcHsJYzhgNVjbXvNPYN97YWrm7nQg5+kHr0ZBaqL/PjdMMEQlMSzeG?=
 =?us-ascii?Q?dRpVH0ocqAf79SWVC7+gEE5C/47MTXY24En/sBqmF3NZm/YDFhCkFEqyd6ef?=
 =?us-ascii?Q?DmS4zFA4Xz7ZyAuyq7hN0UAYbjWKFQhDMMjzpP+QIc/a0EQDbKe0Sm2ntkaf?=
 =?us-ascii?Q?KtdHie6iYzgs7mt75mKXpeTTgQb/X5gpptb4I30gB0rvlbCKBwBEJWbqqU7i?=
 =?us-ascii?Q?kKLzAG13AyCgmGlJba58X/b9XyqvXDhOT8FP2tMu6FvGN7gRLSOSf43ADPsa?=
 =?us-ascii?Q?sAp6pmOBhF5+PdBR0hRDM3iL44AV99ZL965VMhdr40DKHO+ghH9bB+Rfi/st?=
 =?us-ascii?Q?MKhWA394fFPPd3g3Tp7aMSXD8bPnvDTUVCXZuOp6Cuw4ehnuZ5ze7gtOuTa8?=
 =?us-ascii?Q?OvIKDCdnkdKT14YCtOfHLRUy3jKCn9tAVs2MEVxDwLz3x1tkNw1sNMu1MxKa?=
 =?us-ascii?Q?Nyy+qrGdGMDIFH4Cq+sl+OCnpIXUJUUTS3O0saHO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae879175-818f-499d-e6a2-08da856d3ad9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:09:01.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFVl82GE3bwufFgopyqaZcZwqtuhkPC+fkqyp6rc6V7fwW6hwS8fyeQPb4cbwumm0PbER5zVYJnzRG62ru+6Lw==
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

When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
could only do IPC with M4, it could not start, stop, update image.

We disable recovery reboot when M4 is managed by SCFW, because
remoteproc core still not support M4 auto-recovery without loading
image.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 108 ++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7cc4fd207e2d..bcba74e90020 100644
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
 
+#define IMX_SC_IRQ_GROUP_REBOOTED	5
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
@@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 	mbox_free_channel(priv->rx_ch);
 }
 
+static void imx_rproc_put_scu(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+
+	if (dcfg->method != IMX_RPROC_SCU_API)
+		return;
+
+	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return;
+
+	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
+	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
+}
+
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
@@ -689,6 +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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
@@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	ret = imx_rproc_clk_enable(priv);
 	if (ret)
-		goto err_put_mbox;
+		goto err_put_scu;
 
 	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
 
@@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
+err_put_scu:
+	imx_rproc_put_scu(rproc);
 err_put_mbox:
 	imx_rproc_free_mbox(rproc);
 err_put_wkq:
@@ -837,6 +941,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
+	imx_rproc_put_scu(rproc);
 	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
@@ -852,6 +957,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.37.1

