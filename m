Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13D95299D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiEQGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiEQGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0A45783;
        Mon, 16 May 2022 23:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMv8CQzmvQE50dbPMIJWfOwMcklV0+ARoD+H78VssR3kWRvYgmNMTwnGA70SteBKllxunIf0QdxneKJ8KoJOoQj/JtIfDEzQ63j1+QA+/d1B+YhutWHk1q3aNr7ulxaVC5CcqhlbeBDbICX9obt/j5PhPD95gxGtDLUYJS1e2wtZJi1bALbxMWjP7zHbyzssgz5qgFZNaeyIXPj0P/SQz2ajlkkzXC89yMARxiKT48jqrR8Ruv4BOsQDNmhsJmqYcoWN2+f6rihDBhnYg5ERg6WnyLsztelng4l0BDXGIWWbsn1RknoC6zaJYt2EZ3k10lOR8fhmWYtht2Psc0uipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzIIga4SKH3PAi57EQES3x6WD/56ITSVis1y1OOLy80=;
 b=VJgNUpQvPmAufI0+MF5s9qLzJMAD+w6/MnV5Ev3aE+voINW2rUBhFNbUWhgrx4s28f40fECNHx4u3RdtahhccBuSFrY/sJ+dFkvrsiAnB0sbUiJaNw+uo/n/wrLQQ5cy+9B9lo3Pe9IbgtSmC85AFoGW6Q2uMGC5Revr8tSRn8q6a6vlQHVdN1Oy8kP7k6b4vldd93kS3EHsU9qgHSWx3UrX08aHV5XHnkO2e/g+VeBzHniQsFccliLuZ7lnvJ/FzGc1F+t3O3YmfUdij+aULu8XVTsEE904xqaa/zt8yYpIMXM3gCDLZ+pEz7o3J/0fjgCe9xPNNde7jTi0/6PKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzIIga4SKH3PAi57EQES3x6WD/56ITSVis1y1OOLy80=;
 b=mxKYkVoCJtWMMGL98+Wu58eIRINt5Iybj72/LoZGosMuAe3PfRmbJkhwqMPV/eJKPonuZbJPaZod6QYpJ3El4XheA6ovLyZsuvd0OFpws6nYDLWitJ9GQT/6P2NRkFGYidKfwm/7Jli41ZnodP6acO9KkcvEmpajCQSdOx7o01I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3157.eurprd04.prod.outlook.com (2603:10a6:6:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 06:48:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:48:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/6] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Tue, 17 May 2022 14:49:35 +0800
Message-Id: <20220517064937.4033441-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36a491fc-be6f-45e7-cec2-08da37d13437
X-MS-TrafficTypeDiagnostic: DB6PR04MB3157:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3157FCDB7B6DC2FF6436E851C9CE9@DB6PR04MB3157.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gL0bJycpoEVmmZljhE/n8vDHi/Gdbl033ElNd7sxl8Pl6ACJX+KD+B1/qrFnBp6t3TE+u7K76eFp39KejlF3XB4WoMwrAEXw60BACCPl3tp8Rgl3PG4JVV0bZQaloDpizid/i7qMiAVnt0IROU3GZag1NblDqisBAI6YpyQ6PdlR2e/LzTFFp5Pkrg0c3mCTOsZeyyQ1vxr5k81wjDnXZTeTr8dqkDuaIRx/54JMDjsjK6RMerq6luIdrvt+32Ij1tqqJdjSMnKDd1kH7hFiPsEEtKp8qRWWGXXFXuKaEWH9vCqpbQM3BesDXqUBzvQyjU1KsDAxYkYKu8BTVZFXEitkzL8oBPAo11k2w4C7RJtVOwj9Ko81gtjRhq+avG3j7O/dm6SZDVpQt2tMQz+xeIZP9KKGyw4Hjd+Nx8kOGvxj+0dVk99gTwq0iLnpeU3O/08Fa6DjvkN29N57Z9h5wjwShX1BZ8/uH1G4Yl6KhFwSU1uXqHXDH/ZUxhzze2obdKwEWAF5T6Iqim8kpVyH14R4VcWNdd64HSmWYFUsHP2eAD0eDi0uBmdFSZePVByoZ+owNrqnXtovjmA+KDAwFnaldaw+2yDtB9fay3Kpf4FGhNy5HqYwrY/yQxX8bUkP2Ds4ogEghxftn1RLCXfR1XBDfnzbg85BqP1oLuHZnLhQ5TC1lMAa1p4eVR5Ob1mEgTxIhK1nULLc69ScJbj2qdC1UzoDb293fUjcNeXiaFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(66946007)(66476007)(6666004)(52116002)(1076003)(6486002)(2616005)(186003)(7416002)(38100700002)(66556008)(2906002)(8936002)(921005)(508600001)(38350700002)(316002)(26005)(6512007)(6506007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5UEF2fy1rfoydAejEQZh2rbua3H1a6WQPawAax247Fbbiq1K7zZFKWGlRLOp?=
 =?us-ascii?Q?4oLioZaM6bjtkRBM6HGdy9IaI+bwjhryDWYlpMHMdyyHjTB34rrpSq3fcOaU?=
 =?us-ascii?Q?8cD35teLr+jOR/DqNniWOYQMUt7z+FfaF6xtClF6TnaoMhMVm1q53a0Vmj+8?=
 =?us-ascii?Q?TVXxU3H8WCjG7cFdUvh2q3/wWvvBTefAXgmA4PJpcwKWoH/QiuvhWUYdp+rs?=
 =?us-ascii?Q?VpAxir/5/WSSnYn7J4VKAYBBU9rCGQPpLqhhEKYfXLbltj1wQ+rn8UD/8p5t?=
 =?us-ascii?Q?O9zLSj6eW2ORFknleyhFrF5Gu8jOERxa3uckvssE4Fsso/kP26JnzMcmjMdj?=
 =?us-ascii?Q?+l8coZyX5VMi0jOafIpEbzGHnxCqkPj7WqrYBWy/iFnfHz0MwTaNfoI8wAhR?=
 =?us-ascii?Q?5LO3YhuZBsBrruQzJgUf70fW4h/1FlQPgAO6OQ/PoFzTxNtvFmCjglL+uXRx?=
 =?us-ascii?Q?7ptiygZCNauSTl4/Hhv7keoPuB6HgULqAa4Nzany0Yn3MvhtLr6M9DL1CyTK?=
 =?us-ascii?Q?aY43pt04lfvf12g5XFNdnTQC4Wy/1lOgJ17kdL8My5ug0LxujytC8EmIFIMJ?=
 =?us-ascii?Q?2DJLOTAUfln6x1uQvmQDstXFvxqrAOZ7Sj3MjBmbgj2ss2cjCV9gN8/kBbBf?=
 =?us-ascii?Q?Juh8vcZTE0gnsNgmVDjUVCduuX9OyCWmRfur4C4/tzehbW7iwkwL6Ph+VRdx?=
 =?us-ascii?Q?o5OOvBqIWC0f390qPLl4MVu5fcIsGRaAHDBHZl/jfve1c3uEdlvIYrhTa8TI?=
 =?us-ascii?Q?ipY+TZ49MRVHb5nIem06WMDZ9oh7cWCMRwyjqzPEmnqK+xB5QamnL76BiGWY?=
 =?us-ascii?Q?iaXp5Vov2hF1Bfhf3smBDzWBGVgFLR7BdoY5Cky36vzcA5cGBhpUoCPd9zGk?=
 =?us-ascii?Q?4Xg1eGv4at6gp+SgKcphvTo4MKygA+A3b0Ib6I91rDzMF5ZOyLdkRWxbfnNq?=
 =?us-ascii?Q?jCyLtj9mqqIHQkDCiP0SFiF+4qb7ti1nucttdBCHp23BWoS1Ucf5v2gt4prP?=
 =?us-ascii?Q?F9xLLPIKNBSxEg2lBRfNbMQ37Wi4wSMBuiQ0apBW/4iQhpbcigjsqNmMsYrI?=
 =?us-ascii?Q?zcHfGBVVyqmG2Mdt3mWq5Xcd45cUl9LQvyN1IHEHg1AVoltUoVAm6KgkD7kt?=
 =?us-ascii?Q?2wITnPtuUBAFiq6dkIcxxJq3AAspUHMIVsONdQaWITIYu8sQpTBIU4PE78kM?=
 =?us-ascii?Q?nq8Tx7FEDac53U4RiUkPHtltdFgcpfhfq6BFq81TNAMf/xKxnMUxxmUzY36e?=
 =?us-ascii?Q?IJ9CKwLK38BQFCBtI01FRPrzsTfHvR+cU3y554vBMbZMkb95XeIp5HaCs7o2?=
 =?us-ascii?Q?5+KQNT0lJo75g1RckhgJBuqyslIp/lTFPQN1iZYu3JDHTfShDqU9EUjkBryw?=
 =?us-ascii?Q?Kb1GcxogBui2U4r8INLVTB2pcwiBhgOIEnIl7R5hMTJQBng8ylyMfpCzDP7Z?=
 =?us-ascii?Q?aZf/VVNaaugMQ6MIfL8ON5bs818e/afKC5x15W4pVWlBr/N9CGeb7VwjX3b2?=
 =?us-ascii?Q?TF/1Aiy8Qdy+CHU5UQxyDvVEo/8gfg8+gv7xR+lvKnGSs+AyCZLlhV3/13mX?=
 =?us-ascii?Q?6wrPcTVR3n6GcP9ka+onnAxTqsSN3KEPz+2xdJXGZDZc6zN1xUqmXXhiiMT7?=
 =?us-ascii?Q?BBRY2NS6w3XRepwEWePvHPG3UdOXkpoKxopsesazUZf8mhmXD/MscO7YXXfV?=
 =?us-ascii?Q?KOzxevAZ0ZUg6q07gGiMsmL13SVPuiXmehSsHRxLRbFQc7aRiEJvzCZLV+Cs?=
 =?us-ascii?Q?cKTK27EIuA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a491fc-be6f-45e7-cec2-08da37d13437
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:48:09.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww1N84zVXRaGyIL1WX6cdI4zch4izf4kGqckSf9xFGd9biQlCevhnJymYB/0qKtz39rGhWX7x/ef9hmD17x5wg==
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

When M4 is in the same hardware partition with Cortex-A, it
could be start/stop by Linux.

Added power domain to make sure M4 could run, it requires several power
domains to work. Make clk always optional for i.MX8QXP, because
SCFW handles it when power up M4 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 2e751fc90760..49cce9dd55c7 100644
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
@@ -96,6 +97,10 @@ struct imx_rproc {
 	struct notifier_block		rproc_nb;
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc_id;	/* resource id */
+	u32				entry;		/* cpu start address */
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -335,6 +340,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -364,6 +372,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -724,6 +735,56 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
+	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+						  "#power-domain-cells");
+	if (priv->num_pd < 0)
+		return priv->num_pd;
+
+	if (!priv->num_pd)
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
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -758,8 +819,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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

