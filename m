Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBAC5631DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiGAKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiGAKqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:46:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB817BD26;
        Fri,  1 Jul 2022 03:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRfz1+odHIiW155O8xKFpb/BZ7yydnjhIq0xKxgb3DX2xC7XzxH75g6cauW4IEyLfB9k42Z8ApE2Zkb8geu59f9Rdxc36ijqjwVlfsgXZvtkarD8k2zfrY1QceKEJfCTvV85sR+FpmlbruTu9yPBrKfWL4XGxBFdCQyXwoT+8l7RYJCYNSXtMZ9yPlFYyOKt4ACXcVAFeeOwhnDAKUN2U7qejBNJnZqhp38dmctEhsnXW+lsJlM+ZwRuGcwLxCBW5hgotYrqSTo5CI8Tl5TFSohoA3NB/QmTRZE7DduenpJxKBoZJzCx7MUmocX3mz0y5iZ71VaEo6RohRDTpYwjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L0/Bds7zEIw0DEvvUF/ZAUPes1W6xbaVPzlAFJJ27w=;
 b=RVcHPhaIGSIKeH5H1KwgYPfttoxSr0Z0ndO/VdW8P1qW8hFeW8w4yIdIz/AIZXIfQ74hhIOROUlSrIEHZ90MNsu7TQFXIlhKnPwOldNvR4qpeYKBqaSBj/U318DLVsCpoQeWZ5APOUryfPSoZdCh/zD67JLSjfOJUJbXNQLY5fINR2Skcqg+IeMDXD9hfz53NSN2pZBPDh+9hy7J9ZtqCELzYalpWh1oU+USz0f7s/EnOpUoa57S6kwI9JbbqskXojsyQLRFZ0kzddHGxx02W/f8oXb/9FTaLSG6Bt2hDO445rHvSp0uEbfW6O+tEOpwH0CTnIFIObciRLg8UqAXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L0/Bds7zEIw0DEvvUF/ZAUPes1W6xbaVPzlAFJJ27w=;
 b=Toimns/UQ2uEdmBpAfRJWAEf2lNMlKIv04sV7PjGYXJLa84/73ZwNOyYW7mPLLg1ya2WLwbLsVJtnMBf7lV+szqHxXDe2oT2FjeqaPjNNMt0KU1CNKnRmQwbjtlg4Jg3aZAvpA1Dy3C3nvxP5amztCRzqe0t4N5D5U5exqCk/8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:45:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:45:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/6] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Fri,  1 Jul 2022 18:47:23 +0800
Message-Id: <20220701104725.557314-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd25db2b-3b43-4b88-31b5-08da5b4ee1db
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjTKUuymbedbUxejOl80ZqlsKZGILPMgSRgV9RkS4o59OA3fb//usrNdZEynnNooiH47+mTWEroMu/gVbxcfPVjLDxQ+NMLz7eyZeYP3EJrLsqMClhunK7u+1At7cWqyFdxeR0mO8OcfxoCU2CDl2N6Z/tTIvcph8Ibw47Vk6us7GL63Canj0EQQ8Co16FKZ/z+ZB+Zrku34ug76YUO2f/vHJLp4z3DjEoOVYlYS2SqonhoJVObMhuspmhoQwEFWKffFl7PBR8teLclQQi2nfaZkPGDgbm+HM527bOgfTZn2aMjU8tjYlB+wUxW0bqJwAyoOqsf4U8WXX/j4sjMmyJJG6NuU+iI3hAS/uB7yAvhxbnRP7aIXJYHU7P07Nc77eBbogOboSjSVxEODXO94KIphocJgqiJG/wVnw2Fdf18GPUyKMh8mOxcE+GEr+x17ILI64dLRpIV8Vdo+i/MJ+gmo3jrgwDkueWXA3yfkl/0s+qzFsr87/VN1esX1ljzr5XAyj9z1ZCzsx0sZAgpFhwYStE6dnibXCK3PdDHFtskVInvu8UfB6b9TJmD5mcaSzdSUaFHQ/f67aRYn0JA9WYpn1q2kK1PdTBe5kgweqKzzCKjKKG8MycpJsfZgb1/bl9VAMCWlzUM3js74u9GjHWhfKebAGcpm9daEpqdF5IaYxxwQdOuVh952kH7lmCFMIRUKyZsxdRkGUH3ufTOeO6O6nyPD2uDTuEn2refSvH5FcWTshBX7tW8EA6FD9phtI44w+v0XdtDCKI80b+qH/fO4/AnlJtkfmFjHmtu3cf7M3MCCIv9rPNMvLWHR0UY2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(7416002)(6486002)(38100700002)(38350700002)(66556008)(26005)(52116002)(6512007)(1076003)(6506007)(8936002)(86362001)(6666004)(83380400001)(2616005)(2906002)(186003)(41300700001)(5660300002)(4326008)(8676002)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5we+Qkz0NLNXqg5ivkczbv3GkvNgU4cdeg23O3K+uiJCN3497dfM/olw+1yT?=
 =?us-ascii?Q?Y5I03+e05UY3LWOO9eT86AA5D7RM/f7v4WbqnOvfZ5m7W77HdDQg6QWtCGFS?=
 =?us-ascii?Q?jHz9oVnHpPCEtmCGmiQsfRWTh2yHAS+XMDx8LyEAQ9OZSSFhzp6357LIAeXP?=
 =?us-ascii?Q?rUV+AuBfPjFLXo3pQRVf/WYthdqb+5B2AruBPsl2LAKOrg6HHw3E1iWEDwSb?=
 =?us-ascii?Q?iRSBlbS+nifzLfogoXKobwp+Bj861DpgtYcv1ZY+US8BQFZo5SYcekCp1mnl?=
 =?us-ascii?Q?2dw2r8sZup+Yp2KpNzIIMqw59SRJRf/62jBJLITbus5pVY99Z2vZDgM2IPnR?=
 =?us-ascii?Q?sCETpr/rawg4gfjFEt80rE7A7HpHO9mEKwfMP6NDxgMQ8E3eMnl4WyWAwGsU?=
 =?us-ascii?Q?V9Rkm04gBuAPzl/xSJOyPoW+c2wwSlkbxmxEHi2HT71HP5qHrUERfDkmEY8g?=
 =?us-ascii?Q?hEun5YxadAOzpqR65gGV3iBId68N29ZQVc3kRFusLgh674FjPwxIUCj/fsI0?=
 =?us-ascii?Q?Ek57nloaTYhnIKwwIFhhzkCKKz47j3pZWwgFRPTbJM6LFW/Pt9zvBmR5Nx8n?=
 =?us-ascii?Q?JwK9T/CmXqH41U8FxXPIXfZBpDahp/4xvryMG0HUhiRcv0Q2fzrmJk8MtUmV?=
 =?us-ascii?Q?8o5OGQ+KknwtlUTVqJfoy0w/f1Iy+gVxntS08nBGxHy8Xhu6ZDNkMoGLlcUS?=
 =?us-ascii?Q?k0O25AgmAKJ43Npbf6r7e0OQaB/sOdNFbtMIXuqVcXRjaw1nb6td0Er79VC9?=
 =?us-ascii?Q?/hwsJqexUCoMYA4aWjAEAVDnDlSjdlhs1tFSjZem0230ctjAiyBMSmLaGmGv?=
 =?us-ascii?Q?ANMDwMmcFD1ee3o9Q3IrU4q+T/khqZO9lPlI7H/+cpjqDfruWEQ2p19BlETy?=
 =?us-ascii?Q?j9rdaTfctQ3EKcDcbc00K4wh9lDMHfGHULakGwQ2BtMqqvn6/yv73rG+xIrT?=
 =?us-ascii?Q?FQ8sBnxGLU1KUkH20tDqBgM6GAuHJL07ocbSzWzToi0I+3sm1AVa9T1BR9sq?=
 =?us-ascii?Q?tNjdarkKJLaZhSbU4RpndeuHNr59xhg4p74tGDI8NKWCr3SiUxhpuZJPUU1t?=
 =?us-ascii?Q?cI8WEKE7dHCmsaWTtwl4C+egYYj3rIGrjYkLu6YYdDKLG2ZZifio2kUdbzoV?=
 =?us-ascii?Q?7LKj69lSk5bWLLQrY6MUDjrJ6HgqsqEmaRKEcVzmEKpa3kHbT591NnYKcgQF?=
 =?us-ascii?Q?qA5Xpa2/uwwU6iuovNeO3tEsseXOCKQ9DMVGKrELor7xdedh32HtiGON6sdE?=
 =?us-ascii?Q?mtjO10eBffgNV/ld/VaHhOtYiz4/S/pGudWbpUW+kpaCUFTOxIKrpIwbl8lJ?=
 =?us-ascii?Q?dN3iOyA6ZFar4KQZvE1oTW9jkhhBjTrazH51InjMVMwyIvFuQ3b4s7+BXwck?=
 =?us-ascii?Q?zY4GrNcBLksilnlT5h+3eyG40yzlayGVXmxCOBxlBgCPDv4eAbOx57nPngjy?=
 =?us-ascii?Q?GLmRF2CFJp16lU3oNp1CwVYTB4Yp5msP5T3rHSFEJTvD1HhOCzE5vlS04+N0?=
 =?us-ascii?Q?vMeBd7S/OHxfHBAYv6FMY+obYavwucR9behWtXLojrEXr+WyYY3I1nfT+LdG?=
 =?us-ascii?Q?T4wtvyJZavRaDAfH473kKBTuwAxmJzurCGfBIQEx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd25db2b-3b43-4b88-31b5-08da5b4ee1db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:45:58.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 236/4nGM5XEEoSgfr8UIBJP9D4cqMVEnB1/sOCxfOr6mvLpBzcZjEXjPevRLLmjmz+riJtzqrt1A3FZdFk8MCA==
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

When M4 is in the same hardware partition with Cortex-A, it
could be start/stop by Linux.

Added power domain to make sure M4 could run, it requires several power
domains to work. Make clk always optional for i.MX8QXP, because
SCFW handles it when power up M4 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 1ce692a72946..0cecb7f422b4 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/workqueue.h>
@@ -79,6 +80,8 @@ struct imx_rproc_mem {
 #define ATT_OWN		BIT(1)
 #define ATT_IOMEM	BIT(2)
 
+static int imx_rproc_detach_pd(struct rproc *rproc);
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -96,6 +99,10 @@ struct imx_rproc {
 	struct notifier_block		rproc_nb;
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc_id;	/* resource id */
+	u32				entry;		/* cpu start address */
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -335,6 +342,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -364,6 +374,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -717,8 +730,8 @@ static void imx_rproc_put_scu(struct rproc *rproc)
 	if (dcfg->method != IMX_RPROC_SCU_API)
 		return;
 
-	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-		return;
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return imx_rproc_detach_pd(rproc);
 
 	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
 	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
@@ -740,6 +753,69 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
+	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+						  "#power-domain-cells");
+	if (priv->num_pd <= 1)
+		return 0;
+
+	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
+	if (!priv->pd_dev)
+		return -ENOMEM;
+
+	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
+					       GFP_KERNEL);
+
+	if (!priv->pd_dev_link)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(priv->pd_dev[i])) {
+			ret = PTR_ERR(priv->pd_dev[i]);
+			goto detach_pd;
+		}
+
+		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
+						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (!priv->pd_dev_link[i]) {
+			dev_pm_domain_detach(priv->pd_dev[i], false);
+			ret = -EINVAL;
+			goto detach_pd;
+		}
+	}
+
+	return 0;
+
+detach_pd:
+	while (--i >= 0) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return ret;
+}
+
+static int imx_rproc_detach_pd(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	int i;
+
+	if (priv->num_pd <= 1)
+		return 0;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -774,8 +850,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
 		 */
-		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-			return 0;
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
+			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
+				return -EINVAL;
+
+			return imx_rproc_attach_pd(priv);
+		}
 
 		priv->rproc->state = RPROC_DETACHED;
 		priv->rproc->recovery_disabled = true;
-- 
2.25.1

