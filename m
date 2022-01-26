Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48649C1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiAZDLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:11:17 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:13102
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237007AbiAZDLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:11:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtSpZQTxeHfiUzCJ9BS5mv8vNMPoZHpCQ35jVQd4OUIl9VqU+tvVD3GhCb/Wmwh4FK1E5ekAenZIKYigFoJ6JqvMpZ/pBGgeCdWwA+Mhh2vgeRIYqZUVGFGEFilhmC8G34Vrd/bRkq7qc9UBG6KRDYzoelmwF6IyAGD2pogsUfAGyK8osyOwzWpdTXiPzEUKuc8lKmQkvz1jGYXMoggRbs19EU6y2r9mKEOeudTGP44G5TLYqjFbluBEYnEoVC1JAPEgYtn1Z0PSAI+QOFkEbySjarBLMlGC9J5bYBUSD7JIVP1JH+RSTp2E9Yy9OP7hYm7exu189AVtlVjS9mRC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=deoqKJ9PlnCsWO+NeawyqYQ+8IRFr0kEl10ZN02WUjzqV3dKxXwOpEGAynPA3HZp012nPdtNuO8TUOf7nf9gJqR0TNVuETM4nU+6kUg+PdveMs0p5h0EDBI4Q3oW+t1ICVfugcQp9ol9JnMtddrL3jePa4kAD4JZej+lxwRufcgVj70MBYLVfno467T7cvdtMaSDPPxfUtcun7WqUiMnsMwYgtpTAXYrBPb1g3PkjPS3ISQiheKH15BZx7m+SSTqJKE8vtfkPW18tKuJ3qD9W5uHUFAXgJIgT4640+RdBx3nuQSqDgT/2bj4YGe43uOWGxKCC7FEL4nwJyu8hl7Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=RZHnkbLQWs86O+sYYHTXu5MGws9uVUUZe894admf8x2OV6wlIIYj7sc3/BOfmhAWLQfDI247pUdnKJhESc+cYZCtwFBLu/dg+rte2PLHYTGUsGpSNC+IpXsMqxwgyJQ6BQCD9o5NkKg9++jYPlt0+pN6z+imVl+5PCVXnZ6EqgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5248.eurprd04.prod.outlook.com (2603:10a6:803:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:10:56 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:10:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15.1 12/13] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Wed, 26 Jan 2022 11:09:31 +0800
Message-Id: <d9444b239c69714808e27d4c9df3bc9a741caed4.1643165765.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643165764.git.ming.qian@nxp.com>
References: <cover.1643165764.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9503e504-77fd-4ee9-531b-08d9e07977be
X-MS-TrafficTypeDiagnostic: VI1PR04MB5248:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5248C95893BB53E4EBD8DB52E7209@VI1PR04MB5248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDz80kqD82LJov7CbJaQe8tzwMuJbxZZ0VHsrClbN9XGjbd+R1l/mxcLJS1cGm2zQ/I+odi2P5pLv6V51Dw9byD5oWF2Q8fuD1ltBIQxF9tIi42mB7rwOTl08Hdp7QJ9dlhICe9Yah5p0c168mBUrbOIRuV+L22NTwX6Vu7OWNEC+sQaWQ2lKxg+YVFkXmrpzE5VP53PTaWHK8jksrTV3VnxOSiZUt6rkltJCxiOB1PcCg2RJJaWo+ZGGEVWXYMVjkLoPjDJtks1ndver+/FdHW7+wem6/ykxVzjNCjE0qvsCcLr43R1VSs18EoQWP5jv38WWoq6nO7m2R6Bl6ao5rl3Idzgfgp9vsM/S6Xv1YgozDWuWC+l47dEMJx73+QdaQOptaBAiTS5DQIUfGmsiypnzeAkSWl8lwEses7lIfy8dCkaDdXlDkgPf6XfJGGSLJwBiIt57r5BFxX0DICI2J/AbOWpN2Xjvp7yXEGsfEV1wd13bJdHwFXncio1HnSsJ02CW2buX58JJqm6cbZXvawBIxBZjla5ckEZz/IExCln4THAtVDoFux7RTqNt3SZm9CYxYNxJ3U+NwronL2iWWAL/LPV/zcDayH6mGBN8Y5FbkCrAYSCr8UtYYB3A9Ugy4zBBY1WVeUdMcycs6NXD5vHU+O7pq+FztGtT54707ZHYFz+e8aHAX8sr+3CN8R5im2CWm2M2YZBTVj12iOWSXdIMUSAWEt1ZB1OvCtv5YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2616005)(186003)(26005)(38100700002)(66946007)(8676002)(66476007)(7416002)(4744005)(2906002)(8936002)(66556008)(5660300002)(44832011)(36756003)(4326008)(86362001)(52116002)(6506007)(6512007)(6666004)(316002)(508600001)(6486002)(32563001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmzrLsyf95Zr9i8ECkQULcg/T8mkvuHWE03fcI5JLv7hIkV9k7JNVF3KA/Cn?=
 =?us-ascii?Q?mvgblGQBe2g97HTW45lv5U1N1qBZN4eh394p4crsk1sYNOfJlqBL9iZmioNU?=
 =?us-ascii?Q?j80jEHsPUCgQ/ASD3cDQuIukkc/pwisCXqwXuKSaNtwvCeKqQmIwu3B0zxkN?=
 =?us-ascii?Q?jS8jHHmVehP7bviKN9Y0qAOd/VwVCiQImN1CEeJKNvEs22tm0hSH39SpjCsa?=
 =?us-ascii?Q?0rV3UokULx5wZI5Ym0O9As0AWEdJl9plrUDnzFIqHEqKnrXj33oXh6C2O2mt?=
 =?us-ascii?Q?z7IV0vHxKCfzObnEuFKEGbs1cWvsxnlcQDE8gr3qknRQCZ8AIzvXsnF7NIJR?=
 =?us-ascii?Q?goCIwGuPzDQWWk3g0dPB4WEX0OwbE8n0ASD8uzUkD/1nh8XOqwuFNsZv7mmt?=
 =?us-ascii?Q?WHlpFltVuSbuUXv7nvuVoyszUegFULGmPolJf7TGLzkY4vFz8pw9E9cM9dMP?=
 =?us-ascii?Q?PtrgWbPZMOkeN+Wam+ZbWnWfkuJ+ig2VrJ3C/8jV6BHTG5XEivslvqnjMDFn?=
 =?us-ascii?Q?vD/89dz8Yfr8Rso/pxInfbgO+8sgXpGRiXTsgooSOtZSpsfeCzrUYwCMpN9B?=
 =?us-ascii?Q?w233FhQqHWco3tyb9kQnh+aYiMS6++ulBomU8IZNxVnm5hhn9C+mcNC5xxE2?=
 =?us-ascii?Q?72e03sEWVOB9dQKHmJ19BQUgw1aiooFjNYVcBggKSEJXloXUyaTIgxFG5NUZ?=
 =?us-ascii?Q?TRbH/ewZxjH8PQnWSsKno4GP6ozt3jE2G/g1xHY+e1m2YGbSYwEpgWi4kK+Z?=
 =?us-ascii?Q?XzCrX5qtTBYTuuu1kTGO1z1JUTr4EbRzEhyNrnfNe9LAJWbEON925wu5sYK2?=
 =?us-ascii?Q?Nn0qcnkkc7UbcT6bmOI9pvswRSIkzloQCdRcWw4mKXGVlX8fX3ANdhMO0SDb?=
 =?us-ascii?Q?L3F2s83Q0huZlsqyAzTjpHixcnf7E/Oj9Pa8s57ZbZBetxa9UcsSDvOW8AHJ?=
 =?us-ascii?Q?XtTciAwDRiwLvLqGVhgtCLsld1MmWdi6Z2Jk9X0gHAP5e02CwpOmiz2e+0vi?=
 =?us-ascii?Q?9ZxeTHAgqeQk5a7Y0F6Fnx0irF2u8kL/8LsGMbTh7nUhtkC5z0Ohotvl95RL?=
 =?us-ascii?Q?QmR2ZhaPFmFuG2trptxQp40NhGQUI6CtYDBu1lQmfQvJ/N+WYh8NJmrr7nPe?=
 =?us-ascii?Q?YRPRoqHkPUMBWveh8ElwyuLCd4WbVVLQnREqjB5UKwgFYEN0s1mPwrPwdnnt?=
 =?us-ascii?Q?FOzthr24zy3qFihE70id5m4Nf3T1AVfIBEyxrp7FkfgHdK7wjFT+PA+JoFuU?=
 =?us-ascii?Q?kxAFWW/y6Wvav0SHjao1SG0+a8Gq9+yHbZuQ6lOJfPKh9Xf+l/kgKXP5BeoH?=
 =?us-ascii?Q?oivvlsw/dxemkBYzA8LmPnVSuqZtuJjC3lDmPurbgPjVhR3qOysV+OKSAxCG?=
 =?us-ascii?Q?g+kcvK2RZtDMVlQPEllA27ac5Eoaz9ft7B81Z0awBSSwvyVLhB35sGR8hmZ1?=
 =?us-ascii?Q?9s6pULqcRRZ1XlHw99gLpxoQtZLLW1pM+wtbFM52dPN+RGTWgEovLJUuOlpD?=
 =?us-ascii?Q?i/xgTA3Eh3JdItw3OnA15T2O9XynPhFqfFvkpMA0imX4UoDxjIfWkPelz1lb?=
 =?us-ascii?Q?FPpNWcGhWsrMo58f6zuOFgkTrfBS4HFrD0eXgRKSIARZzWecaFkFMcRZhBXp?=
 =?us-ascii?Q?xnmwpkHUFZ/sLSQH3X4DlHc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9503e504-77fd-4ee9-531b-08d9e07977be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:10:55.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1JPESm40REl7wRRjcKQu13uBTafy9THHo0B8jtyWlI0Ooi6BQv4Cy5Xv/3QXFgHLUdKTfJltdwRAIzxCfQtKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the vpu core depends on the mu resources.
if they're missed, the vpu can't work.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index ff6569c4a53b..af3d057e6421 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -155,6 +155,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
 	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
+	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
+	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
+	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
+	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
-- 
2.33.0

