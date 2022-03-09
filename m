Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439894D2C52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiCIJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiCIJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:20 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50057.outbound.protection.outlook.com [40.107.5.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09555106CBA;
        Wed,  9 Mar 2022 01:41:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcboNrHUzvlcFrjV/wyMfr/eJA8pqw65But39ckDOpfMP4ycyJxXHRR8Fx4PYZg7sft2yCXiqi1meXaiD4z+SndxNWwqS8r0ARJwELIJLrArQ05sd6u5hIWHCN7w9Z0UbemERK6PFoLCDXURrNmMm+yEFeqE93lDgpgQNOGzXqnfCmHcGPwHnO0C4dnx35+h9HXyRpdMEDzf/9hNITdWRif5qgh16nYWURfJ4JMddibJGvriYpl/T1NJfLRcjTxim2gNvK4wlHMiAeTKurHLUoeq5fje9bwqr/te5qp5BqQcldnaILcRH2rg6DVrhvCocv563s9wBMYd8yeMpQbyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyn2MQTRJ/FpUg8C3Fh7SyAQ5PK1OzhBx3P6+6I92uM=;
 b=ZbbV7Tt6SSp8WWsKEvqGozTTclRGxcPy7zMiQttwWwmh5FtvJTJo4vwpZJdzZL2hryQpq5fcm/5oZEphujXCC1WfS1Ahv6fX1bmCkhPxz4c0T08NslbKaYVFVQI77aj2NeAsA3/krU3j2LvStlL29AVrBMl5sVBLlfADt1tzTibfzbFNvk/CEHhQBiqL/IxRZ3Mdirl+ugU2hc/W4cNTyImk7vKC/CMoBzMrGFV+8uNd4np6NXz9ajcbjqirV0l2G0v5TQb1YmbatoDvuZSDGgHXYQySpf6B68g2d3wAlr9K6rKMcBIjDsCMGCsTYE2oaJ4HyLjETGFpQe9EkxUsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyn2MQTRJ/FpUg8C3Fh7SyAQ5PK1OzhBx3P6+6I92uM=;
 b=lboNj8fShqvO6p4fkXfKBcx8jAbJfyRQQTyLVGOffbzZRmIz968990fHV25McW/Wf2LFJMGo/0O+3zDYmECuMik9VQ0AANDW9grIJ7yrfsQIhMHh93b/fAhAR1uVF/xHPDKjyHbV9JGAubBTMmojx749ocwtpuCOY1/nRgepxKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Wed,  9 Mar 2022 18:21:15 +0800
Message-Id: <20220309102118.8131-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309102118.8131-1-peng.fan@oss.nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cef5e2c-4a0f-4a5f-d0d9-08da01b0f5a6
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB6043E44CD02F6871F6420A63C90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KjuWW5z5PlW0OLA5mJS2ltq2iMMEh3eV9GcipYdiDsrOAdhWWEKKs9l5K+dnJ0OtheKMgkTiwck1qDcLtjqJm8VevpD9wgXHPNhRRVaz+u+XZVcrc4p6y7kCA9v2Ki+MZy3IGHn6fqxFOALvCRDYVapIKjJTfVw6T1i0DnBNFNuaExDr+FDnCpE0c7nTaJcb9vsQX7aUKOG2NlnF9qTkGk0+Z/05HxU0//y+CVaNnDsoQpWMFs8lk9CKsiw3HdjFF9coLKjRTgjIpJCeszu+Smii9cSkoyuxyvIMyAtWiBnU+8NalIPz6K2lC89I4x41FYUUj7JD70F7+gb6S1nFZMDEIijECXxaYCupsbEJhU9W9CurJHAhMOxSiFMI+buF00zQK6LATixVIqXrqQ8wuQ4EVQccWHZmeU2U67MCdSFb6YvWyzX89wRPkAeUAyKYkINWhkPK7xeOfze3gt4PmMYFChLML6LUbToylJF+HgzBWP33m87x8mm9jIo7a72qhgq8AkRNCtL7TU8SQuZmz3jZ//v0fOpR15AaIpaM4wImLDIlejRxqrUzoglJBxKETWiOsSnFi49UpXA/830IOHTUVi00EZe3uJh6K7I+cCflMiC+Nt5Dha7+IMKKTyF6e8LNa/xxo9DKLEsHRmuTNKkqdxXh3TwgcSsGh5PS/0QT38KvOhNgTVyMhLEHYA4NB99ZzJQdG1IFHwaX3JNzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsKjtG2qgu7o5NIRzsPXASAibifLYB3ZkDZ1yMr9MKkki8aqafsBYB7gM2vE?=
 =?us-ascii?Q?d4X4n805VqYeOUxtTL4M4fftPI6waHXeer2DHgDbvUq149m+81ZkCq72qVAD?=
 =?us-ascii?Q?eOu9exTJzuWzSK4FVs7vO0RIV4VdBc16DhKSUBFAtqOz4fMlEK3j8cWXZlp5?=
 =?us-ascii?Q?qUKnxmR8ADHJtGkrSUix1cUB80nEYNJsYC1RTZ7e/NfrdSQKCoNk5XOZBxGL?=
 =?us-ascii?Q?grhxXN+4xcjr1InxhcZW7d8CxsthU1W86JGUTTyeuBYMX8N4w/id5LJzLuUe?=
 =?us-ascii?Q?+KS4wDKPkNTDCLdZy4Ev8PmcpX6rlAl+3TGEuiskrlEWoZO/FYCj5MgnvzKg?=
 =?us-ascii?Q?EnDpPf21OhYm91kJq4+qjyYUcSDMqr1r6aKpEF2E9mPwkJXbEZcg2VS8vAOH?=
 =?us-ascii?Q?100tNLwlcJ+prdKbUG2RqcQSBW7NUB+FqieZgz62E4VQdduyFVYlsMm8Kmr9?=
 =?us-ascii?Q?GvXh2AiDBsWlkj38vOEp5Dn+AriHpT+6CKjBW7+idKSGHihfJz3He0quS4r3?=
 =?us-ascii?Q?yuhgelzoszMscYmLZnvCfygbIhoL/Ig/VixGifyu3hyhAa8y/VvgPkheKdaJ?=
 =?us-ascii?Q?8e7lefpz7+NthfkgkDwW6dLN1lYpkra/Qrm9CnN+66L2kXTb4UZ16gq/4Eug?=
 =?us-ascii?Q?Gn457L6F13kFPeN8V1Br/BthkjdVKC+fWlt55Of9rrWEbhwbXm7jdH+cCYAZ?=
 =?us-ascii?Q?fDjTHktpI69OsEey+CctowGnGPk1KG0kVhQhnrR1c3IBv1b2MUjyOUsYN4Zr?=
 =?us-ascii?Q?tBxJKKUUXx5pRdNhFB3R76BZi1QBnmguisJq6OAZfLusfrJBSxir/nhv6jWc?=
 =?us-ascii?Q?HT1TZ7beYChSQbhhx3AAix83s4L3fFWWZZLAXlpZznxTYpRlGLik67nxIfXd?=
 =?us-ascii?Q?9SGrJd9JJNLTYFgqiBj/zQJi0XHoHDfRRKn+lhKCMa1oDFUXq9nYR2O7RMkY?=
 =?us-ascii?Q?cu/pq8g34y4du6zixf/bQBbVL4svMjn09hSl5QlzguIIFfgZHBjAQ8R6figc?=
 =?us-ascii?Q?xAJK2xkJXyln+YRp8VGGsUINZ6GO3RfXc2VVY1jSkJYhp1/FVMcp96AWDyLH?=
 =?us-ascii?Q?r8OsU/R/OMwhHf4IBtefdfUGzNbokGi/0Kn1cPn7qs7w5v60PuhW52XVEvOf?=
 =?us-ascii?Q?empOkhaqeDIevhQKA7zTl9WTYNZZpeCH9prCuxHnWCdzrl0E6wrW3nnWRwFn?=
 =?us-ascii?Q?gM2vmlK8cwLHRqh/OvhWgJR3wuj1hcH2muoH7+q1zz3po47LNiy8plEKV5ur?=
 =?us-ascii?Q?TmP+TbutgSWqBsJkbL/Bw1eITuPqf5gLZbaeMyQOXGdteJvspdrvmpUXP0+s?=
 =?us-ascii?Q?9o90ubz58ef2ollwiKXQ92h+xcBIRzk4TuGq4XWKUeWE7c/UL87Advw5/hiM?=
 =?us-ascii?Q?3qALyAnaxke+hPDO8/lJlisrfNaltJck7fUGy2w6p1UzpsrZJ8Gh9m1xYGAg?=
 =?us-ascii?Q?rGfyoEzETdM96Vb1B+igL8WuF4J/62F27xIiYf8bylfk8mqjtMaysWVfgkQX?=
 =?us-ascii?Q?fcLgudhzMSNl/no0SqAmbRaLxYmdCOk6sXQpkh1OTRewMfqepLejDJWQxaEf?=
 =?us-ascii?Q?7bsgjLZ8zfYSVLq1o7jNDG1s5D3Z4QMZZb19b6zQIVOGs+lAzW7kb8+7zBxG?=
 =?us-ascii?Q?RaNTojRzxZGaZD55/gcbYlE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef5e2c-4a0f-4a5f-d0d9-08da01b0f5a6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:17.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNwHvmDmK80+jMKLqlcpqAPceucypdwFsjv5/0jDfkt/QpSKOcR1wx+IyF8Iz7FIvoc4PAKp1+diqvryDVOxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
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

When M4 crash reboot, it could notify Linux, so Linux could prepare to
reattach to M4 after M4 recovery.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 99 ++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index f2bfc9077c19..6ed53c660c18 100644
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
@@ -89,6 +92,23 @@ struct imx_rproc {
 	struct work_struct		rproc_work;
 	struct workqueue_struct		*workqueue;
 	void __iomem			*rsc_table;
+	struct imx_sc_ipc		*ipc_handle;
+	struct notifier_block		proc_nb;
+	u32				rproc_pt;	/* partition id */
+	u32				rsrc;		/* resource id */
+};
+
+static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML/U */
+	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+	/* OCRAM(Low 96KB) */
+	{ 0x21000000, 0x00100000, 0x00018000, 0},
+	/* OCRAM */
+	{ 0x21100000, 0x00100000, 0x00040000, 0},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
@@ -235,6 +255,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.method		= IMX_RPROC_NONE,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
+	.att		= imx_rproc_att_imx8qxp,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
+	.method		= IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx7ulp = {
 	.att		= imx_rproc_att_imx7ulp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7ulp),
@@ -490,6 +516,15 @@ static int imx_rproc_attach(struct rproc *rproc)
 	return 0;
 }
 
+/* Only support detach when doing attach recovery */
+static int imx_rproc_detach(struct rproc *rproc)
+{
+	if (rproc->state != RPROC_CRASHED)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -505,6 +540,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
+	.detach		= imx_rproc_detach,
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.kick		= imx_rproc_kick,
@@ -651,6 +687,22 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 	mbox_free_channel(priv->rx_ch);
 }
 
+static int imx_rproc_partition_notify(struct notifier_block *nb,
+				      unsigned long event, void *group)
+{
+	struct imx_rproc *priv = container_of(nb, struct imx_rproc, proc_nb);
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
@@ -660,6 +712,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -670,6 +723,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		if (res.a0)
 			priv->rproc->state = RPROC_DETACHED;
 		return 0;
+	case IMX_RPROC_SCU_API:
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(dev->of_node, "rsrc-id", &priv->rsrc);
+		if (ret) {
+			dev_err(dev, "no rsrc-id\n");
+			return ret;
+		}
+
+		/*
+		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
+		 * and Linux could only do IPC with Mcore and nothing else.
+		 */
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc))
+			return 0;
+
+		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_RECOVERY);
+		priv->rproc->state = RPROC_DETACHED;
+
+		/* Get partition id and enable irq in SCFW */
+		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc, &pt);
+		if (ret) {
+			dev_err(dev, "not able to get resource owner\n");
+			return ret;
+		}
+
+		priv->rproc_pt = pt;
+		priv->proc_nb.notifier_call = imx_rproc_partition_notify;
+
+		ret = imx_scu_irq_register_notifier(&priv->proc_nb);
+		if (ret) {
+			dev_warn(dev, "register scu notifier failed.\n");
+			return ret;
+		}
+
+		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
+					       BIT(priv->rproc_pt), true);
+		if (ret) {
+			imx_scu_irq_unregister_notifier(&priv->proc_nb);
+			dev_warn(dev, "Enable irq failed.\n");
+			return ret;
+		}
+
+		return 0;
 	default:
 		break;
 	}
@@ -823,6 +921,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{},
 };
-- 
2.30.0

