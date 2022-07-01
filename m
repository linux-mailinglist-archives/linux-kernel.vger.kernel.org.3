Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A905631CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiGAKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiGAKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:45:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF57BD01;
        Fri,  1 Jul 2022 03:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTMcci2SvgXMBOK8/rwwgUVh/w9I94/3gnTPJsYNVRM5V1g4I5wxx/pj2zLAP3sWmjQQWkbD0rjzSFgaS9Ak+kKNO8yjmhffGgkMPm/uSFmXxFdfyazDscCIJSDxj3fVBeQuha3MDcDtOY7oih2mVd1SWjBWM8wdux7vJ8ENth3mTzvDVqyNC0FvCaoU2FPeCtXQthH6nnZcQDAkJvJ3hNuAH7JS9rcIUeMjoljyBV0+4nEXrOUJaxf98Z0uOnEUXbY8MskIO7QEbum4FYeb7CW56e91a7kFJMKjGQAFBFjQ9lsYsPaVzW8OkRTYfKF+luA0ezi5GWSU/yYZQkn6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnXgE9KyzusAYxkS1U5R/pbM/b8oI8CUuzm9Cqr1SJ4=;
 b=Z5O+cVMcvUYrGNM7BDO2h7pqlx3v9T5p/mkl/liJjyvf2eMpfk5703In/u6c78zsp232llVjxud1bNQiYcBbd0n58MvF794mHOlbp8q1nc3+wwkvwCfWKJQ4C1F3uCHUS72j+NH1MTWvyqtgVpb2YDtg4iWs6uVSrbRaYHSMekr4NfNH6KsJ/qPwLfSRGsiZ9duTF+xJgRbKd0SSe3ZYvFLJh7jgTIzEm/Rp7ij6aZypJCnhWIKsWyAOYr/QHIOKKF62J1UZYWzLU388AotuV/nTrWVJWNfvrTDDSm7o1J6JyCgnp14PWziQMe/7a9uIln9Je0DHzi8OMzGk0M+qjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnXgE9KyzusAYxkS1U5R/pbM/b8oI8CUuzm9Cqr1SJ4=;
 b=eWKV0tj/6omGM69brT4KY/GQHKtvtGQsUWD7BQTLrsZR9lmAGVvExSEfHd6bg6cPqP8GCGPQYeNuC0btDauc/tvrUtT8YF3S33/PQQhovtgTN+Qc8Y3v5CeTMFsyIkF3m067hSB+iKW9LZ9GNFyuXSzimZPRKUZTKVdOA/wp+z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:45:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:45:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/6] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Fri,  1 Jul 2022 18:47:22 +0800
Message-Id: <20220701104725.557314-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701104725.557314-1-peng.fan@oss.nxp.com>
References: <20220701104725.557314-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f77de5-9a43-4881-0e14-08da5b4edf83
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVyus8ecMysFvbrcyPUhjp8vug5iWbH26ivyKy49nZoEb1lZVIMfjQkfrzGhtaxmPbchWUrSpWuy4FhGo6aI4MPsYac2/ecGYTSZYdl3DEatNh62NjIebU9AwXGcswPWb3aMSr68QoE/rDua6/Ld0sXlf3oHs0E4MUCPRvUWlILATUT4HQe21qKhAh1nkWUeZaOAAfEqLmYr2ye0cFTiBFHPSlp8iw3EyQPSVfTjfk6l/8y8CEpYaOfsYze/rePiL7CrSI1tm2fDMaECIIHBgK4TP6XzcJS5dZzl2shRYgqhWOP5vFONKcjiURzmyypMOwOFp1/zKUgKCgmIlYzen9dRLaqJelCMOmGtnWqLHII0VaZkjMDeXn+aiSmy3hQZhiKUxIa2pVb8HFUJ56qCX6N5JJPeaaMPr2UuJrzhvUWZpwORX7G9a4eteBAU0vfNjnqMoWpNDvF0ZjkGC4nms6b4mIWWI6eG6Tbp5vNl61+95TrvxZESVQd9ijd2vDKHDyyiiox1jNUiN0i9Lbj8+8rRH+9F0hO9C1uu6x/Tr1JO6PA7FCLHeGBOYR8EP+6kuW5NMa0dzrHFICRkv1TgPLmiibyJx0agOMgy9VbxUS1QCiLH/sREUm+PZisuLnBE1TGASF7xbTfKHWe8GTujAWG3bX1QQHjoqRpoa+5I7VSjQUTY4v1XpdCccaXOJRZqbrh7zN85/5dgDKYXvihnLEt7sbybRrrbr+7bKahUIuw9HhwcMEKkYTvbNjwH3iKiYnhPKOFZSyTFD0Yu5Xk877xcJ3B2QBgvn54z1x8ruLzRcDzGhb9BZJQk0VO7f0dr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(7416002)(6486002)(38100700002)(38350700002)(66556008)(26005)(52116002)(6512007)(1076003)(6506007)(8936002)(86362001)(6666004)(83380400001)(2616005)(2906002)(186003)(41300700001)(5660300002)(4326008)(8676002)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lsn1asuOzynjL2Bq2V70tCtQo9/XK1CDNR/p0rOiWHgjXX2Ursa7RrjvY+1T?=
 =?us-ascii?Q?/z0PwKjcOXp5ZqLBILeRTB174nCjx5GgKlNj3AZ/bFiTTqf6nfy/RgjHHpN9?=
 =?us-ascii?Q?QWpUA+F0rzEwv5B8RwTeUFg++EzMY+GRH7QOwpcNtSccd3Pj4A9mOM4i1q6l?=
 =?us-ascii?Q?YGyetR76Wo7WZ8KvghoJva8d811zlcOhp59EQDBkLn3dqoX0mDwDoJMkUmm8?=
 =?us-ascii?Q?Hb48GmSPae/xsB5kKjm6tEFb3pQjN4tFneuNaPfkUR6/Xshf8KoE9jFU6TQ0?=
 =?us-ascii?Q?KzRAJtkMovRsu+xrbZlVuPvJIXerajPS88KlZ8ss7VOzTbXO6BLBj7XVYVFC?=
 =?us-ascii?Q?+9vLNXLXPXJY0uhfHnHLnQm6X1VeRWx7DDBvwB2PHmpdK082ftHyKyY16Utv?=
 =?us-ascii?Q?RWL7UIKvgsKsUrZ8dMH2CDC7dcDuC19DuDL+T/pRHaO+UAxfYcXk3EywUqpg?=
 =?us-ascii?Q?8Lanxfk0SuP2huHMGlm4zMyRsxXL/j5K4BM+TtGb68bDEgfbYsLWFIZRVYYi?=
 =?us-ascii?Q?3SrLgig1li3ZcckjYZiENE3tD3z9dUrP/GfrPY0SahjiBlrCOFRoe+VLZvyu?=
 =?us-ascii?Q?P9Ewuqec4qkJ6wC+VPTKWJtADr3s7NFt9Ol9ivSv76sZHe1su5wq/oca4Yv8?=
 =?us-ascii?Q?v9owywD2b308LH9MxFzuQOl+MKCJ4sX8K77+Ya4AZvyxy+pTt9Gjn7gukFxZ?=
 =?us-ascii?Q?TuNwq1POikryyvaWU8l+JE4zZuAUZ09npq5tAOEkuIyxfOkkKzZG9xtvr3W1?=
 =?us-ascii?Q?hUyurG5iaBmZV3WZ5VAOYeCYWqgKdhTHQzV9rbN/GzWiz+0NK4ae0m6DJ07g?=
 =?us-ascii?Q?U9Kb6Wiz1aXJvcT06X038vn20FmTlaaH7K4A19QFKvOvFqDhDrRviwcCNur7?=
 =?us-ascii?Q?+pW7KadCOjPVXp+9I5GkZt+7kmCyWHV6NEhZA+Xx+WiHLhTOZRo+pLOka3OO?=
 =?us-ascii?Q?XZMICWhWDkp0810m89jGH2hwQNxr4cKYp90YjRe2mlN3/vpE8GVOR1HFSl4G?=
 =?us-ascii?Q?HEAsYMRtjExd4pXQRXNjKDZJdemBvX3W7TD4wkebjA8Ea4A/DTf0IZbL9HnA?=
 =?us-ascii?Q?1ZsEx9pyxDy3GkJXpzNieGqF6toZ+LtNQKWmee6MyMfD1YIKBNcN5sVC4yaM?=
 =?us-ascii?Q?UtLKNk86p2wVgoweyu76YFVUUfMHkyEsfEVK1XgkrvbAuY48Kefc9Jjrep4g?=
 =?us-ascii?Q?v9DL1ZqmP6Wb3/lUaBa1kNh0PNMwc43JQrm1CIYyaL02AzCT8DHyYSxlUIF6?=
 =?us-ascii?Q?fWquaClc2iVdECubGVWpn5szySNxi1bE2vd0vgrIrTk31S4YQCk5Owk73RxE?=
 =?us-ascii?Q?aaSFZv5bOUKKsKaM8NrLq7k2DZ1XZHVPHgi0aAhERjZkpbgd/K+pwb+u/vWJ?=
 =?us-ascii?Q?ft9k1pkR0nMQ0iY12T4ZylZYLVUFuXVoRT2sioZfDpdu2qcBdrCMcPIGg606?=
 =?us-ascii?Q?k7G2YdG92zMAU1SDyDzNbpBGNJvkH+qhOQEyMae6cqSgNiglh5XLftrO98sP?=
 =?us-ascii?Q?xuC1VpybXYWlvN0g7DYuzJ0BOsPGmN6WpbZVaRujnKUxeejDqwANTgEfoI/T?=
 =?us-ascii?Q?2B2iCKCqKnLkew+pKmJiE6b+KJRlh1n7mG3kx7MF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f77de5-9a43-4881-0e14-08da5b4edf83
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:45:54.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USM83StVBZmFZqKKKV6KJiHxhYVrl8KjroOlRCWhLXTqkfbQPKNlYtI2klx9QZfP0KsTXoSesQ9HBY+s8QrTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
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
index 38383e7de3c1..1ce692a72946 100644
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
@@ -684,6 +709,37 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
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
@@ -693,6 +749,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -703,6 +760,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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
@@ -807,7 +909,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	ret = imx_rproc_clk_enable(priv);
 	if (ret)
-		goto err_put_mbox;
+		goto err_put_scu;
 
 	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
 
@@ -824,6 +926,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
+err_put_scu:
+	imx_rproc_put_scu(rproc);
 err_put_mbox:
 	imx_rproc_free_mbox(rproc);
 err_put_wkq:
@@ -841,6 +945,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
+	imx_rproc_put_scu(rproc);
 	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
@@ -856,6 +961,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.25.1

