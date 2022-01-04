Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887D5483BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiADG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:26:50 -0500
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:43654
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231815AbiADG0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:26:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZxlGUdy2NRPVuoOG04FD6pP7mI3nlTj4mFBN0ZTnzCk+wNCUOkR/bs7FwpjHFBuO5Q0NlvyiuIBGPGk0tVmSbL+7BaFluu7kr+3GdqUZJxX+/HEZyeFdTEAbWCqD4apVyFjd9hS+9JupdUuyVv5vLAZiPicg31m0RLt0xuIQ0mR0uo9kWqdysg3GyyRC3Pos0lTaG5MsB8Wjx1AQIEhUV7Dc/WHmBMAFXsnQtHchQaQYmku6tDIFD8uvcJ9GYFwuL3afokogSKSgmNlkd9+IgY/EfxCK5YlnA9aEKCE+WXf0waVD3qYGXgn36BTTl46FfOmQlkcM4DKowfvoHXH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9qlODz1lfj4cTVQki+abJeLkrvgkJvsTPS+qi3ng2g=;
 b=Lafww7tIU3yj50Ueq5FnCPpoTa5of2AOuIG5e3cRW58juRDHD3rMg87RkxqpxBc6w7hiOSC/vBI7bJWwk1XWLbUVjBWPv3m4pddUhzK4pTeQXj7iXI8usShCsvC/CvtFOomR4UDtaCuSU7yshGT/yII9oL8Qf3yZ3z1L34ATbSeuJaMd8+6kxzYuLvQeFBlBGTp/qWalRZ/rNCXDj3tJUPbwkaKKXXZfhStEC8nWEJyxIfq589gQwQitrIqKROZmT1uru+znMguFG+9oZBA3za0uruw7Sn0iWNGeqndqUibVSw97Hmfjo6MHJfZcdWoZdE16HXjVgyP21JiRj2zH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9qlODz1lfj4cTVQki+abJeLkrvgkJvsTPS+qi3ng2g=;
 b=YSzjT0JMnlBQ8WZsP4yHBPlzh30qIUyMFkDaYrCiYbgRt7eAQl8Kzi4hAIXCSWZUF+mL+SFL1VFkyUN7bAE/hFJQ78xe4Oa3WyeDSxaZgcY3pK358/zwSJt+4kTcZA5uaPb+w+4OQV2yfNPcDCK1QV+dx6kkUmf4iQO913/Xit8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:26:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:26:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] mailbox: imx: fix wakeup failure from freeze mode
Date:   Tue,  4 Jan 2022 14:25:41 +0800
Message-Id: <20220104062547.2103016-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9dc9615-074e-4d67-3fa9-08d9cf4b2e7e
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB92983E18C7BB8D0848294D2EC94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byAQhybATdggY791b9AxJ8IzBUrGIr/Cv05pR88wCc9fiVnPiqp11S66mpv72G/7i/8pOAuzuQdGV+vk8KilOk7fDwn31TcNGXSmwgjgyVRtZLJn2Sig22BTPJ18A8PddKYRhFKLnBLgrX2x0Ve6IjCuK3SreZffZyFvmG4YR2jPCtWozwdwyva1am3FCeeF4gYObyUE/BIeovV67rLDxtrdgGP55m1U12ttgfQdSFt2i/lbkJJdtdzJmJ1b3PShHveGlqoGTpmaQDNIDRwfby3Bnakyt4r1uUsnRclt5UeR98daT1iDuEPk54xby3LlMUittiXKDDxM77SIbbzfNMlNuy0cemcDH7bVbx6OTTYFI7reNL5TGgqvyAI+V8GjqyZfT4ySMiuvfIRzyqH6fzQbgDGQxyMxDvQhE8Ql9tHTKfwLLPnRgqf5wz3hVR9FWcSQuv6hrnu7AFQ4vTXRQ947MYUuMdYBkZTd8wwpRpDEnFWmzCF1ryaczqAdPgEKxyX8dG5f0+tCfLaOQVLqHCQyvsQ5LZ9I+TQWP9Gj+rwhLX5wPrvnIGYDc1exSH5Pj+LRFll4hkVn+rlQBshxQu7Y7cQBTKcbNRfZr8mFWLIs+uRvJZD6OMx8f9E87Fte0emHTEH1Ze3TxJHi1NS40KevskdQO91rY+0cQjEOXp3PrV2Eng05JjleXkpvmErSYF1WWBDIwHicW4iryRcS9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(2906002)(52116002)(316002)(2616005)(8936002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+V05xjG7yMNGfAG0/sFmd6qmsOoFibOw8OAhk2/8tElIh6j5Ej6EMFh+UiN?=
 =?us-ascii?Q?i4l0+nhdgOyJ2D9JBKZnr45CYKswouVwXQkfGYjfcBoSEapQ4sO7xdTPNK/Y?=
 =?us-ascii?Q?aLdFTcdB40iJQ3ZMPxagWeMM3LP+EPT7l7Zbjvs0LudNASTGCSfSUFRVPbtn?=
 =?us-ascii?Q?K8riKig0Hfcf9iHjiOSNzZPZjqt0Ue15Xv2pbllvDBCkTvLxM+OjB5D9MBuM?=
 =?us-ascii?Q?s1RRvqB4WREfZhiLVOKVvHpmYxH68KwSCL6xy5pGXvQHxlSWG5928rNGpp4w?=
 =?us-ascii?Q?77dU88gvSysQWm+6Mui0W/WOTjTk4epXzSFeR7nLr2DO7PMAorJaeFk2QRbt?=
 =?us-ascii?Q?hYhu0LH2t1XJET2DoYQuXyKsc/EUDSMqYH4YGgD0zeZFdTR1XZb9Lys+kRu1?=
 =?us-ascii?Q?T8Kx2GEJKWmyat2h2CZBqYytHmPFiWsnn7VAgc/UWdmLn4aM4d7IkK+maZL3?=
 =?us-ascii?Q?T+wBFMTk2wimw0pfWZyMvR/rPdzRyducXnDP0jch9pF5lG+W0eI802QG3+je?=
 =?us-ascii?Q?WL4poI6gWc3T2R/2QKw24NEX7qeRHhX3KuD6ijoHE28Y+f2ODez1CqTqtEzc?=
 =?us-ascii?Q?/jB65xL8t9rV6nLDpudoGJFNeyEoqK9WfhZwWuZV/fvT+BL27Kvj0Vu07ukk?=
 =?us-ascii?Q?mQFZINFLKGZKruyp5BcGJ5VHHC6S7/gY0MEzOw6tS/uxJv+w4S9p4LE9CHV2?=
 =?us-ascii?Q?/O1K/X5aAAMUuwtuLvo62tnDyZmAjMUGIh+OEOZeneYI5Ms7F/yuFcffyJhJ?=
 =?us-ascii?Q?VB/Bbfdi4C25l3IOwT5D0P6EIrB9PIlbo0ZMRu2vEPvwDSSd0iQE8JFOkFGa?=
 =?us-ascii?Q?HDu//0vOA+i1R4CAILjvabRpUrp1vIDmreQXWBeF5uRToD+DCjh9ke+ZKGDR?=
 =?us-ascii?Q?J0VRyvC9kpYDbLe4XvlNG46U/cKcHcBYzlf9w/6YGOOVPTz1IxbCnEwve9OF?=
 =?us-ascii?Q?nnpHu/WFLFXlqt9EyFQoO0mBlktlD6UmCkYsPFgdsnwes9WWBcw+6WdJTSCB?=
 =?us-ascii?Q?QA9s4IrqHGaeP1U7LhlX87bwaUXL80chN6qOBIlUQlBZGTHK5ciXtcc3Cmrt?=
 =?us-ascii?Q?rnDp7kN6pWRwE+o3Kh0ldAKNiaU/5bUq1wRtJv+zx6lfdA14PRIM+lpkwHWT?=
 =?us-ascii?Q?8MED5oNYQIwl6VTM5Z26hDsevYP3hnSQpxnsF82FGhpcqHXcfSejPNQse4XJ?=
 =?us-ascii?Q?BsXL3cG9mgL3QrcQbRpFTS/y5B6EXr4LXLHHt8oBK2921/UUYlHjYK0l222w?=
 =?us-ascii?Q?2/bj51uyxl0NSptwl/SPjv6rNX9ReIQOiNI/v6uuXBx0u1TQ7gQVEx352qpA?=
 =?us-ascii?Q?1i97aVyt+yItOW3pjNV6SVv6vaB9Jvyh7Ow7g16UCi7sQzlN+yFsLHFgpXoU?=
 =?us-ascii?Q?FRI0L80QADHx0+EYvDPZqQEz1HraLunlurbx128GH0O4PBF4cc7L0e5m0hPh?=
 =?us-ascii?Q?VN88RyVlxas1mev/AypZkibOO77jsJxnHgKxJ0WcNfG17Hfnq+ugZo23OdEI?=
 =?us-ascii?Q?sNVXNdRevoAMstcY4g81XBKwIBuv6rHaUGs/Z6PFoCVojsYfWTUgWVbAhatS?=
 =?us-ascii?Q?6RYZiOT/Iz5Vn9qzQxQC7eHVh9VhDe4ReLyPQKMrCvY+hQbQiTOyNgWRoX85?=
 =?us-ascii?Q?ThvACPJNZRke+ZmFcVJUfVY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dc9615-074e-4d67-3fa9-08d9cf4b2e7e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:26:46.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzmOTyE2HXiw7C5SPVC8a6kMKkxIo9vtkWCHONxg3CYmay37vbdVMRJFIY2Gd/4QS5+btTw3hy/uNv3dVZEBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Since IRQF_NO_SUSPEND used for imx mailbox driver, that means this irq
can't be used for wakeup source so that can't wakeup from freeze mode.
Add pm_system_wakeup() to wakeup from freeze mode.

Fixes: b7b2796b9b31e("mailbox: imx: ONLY IPC MU needs IRQF_NO_SUSPEND flag")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index ffe36a6bef9e..b3a2772f0aa1 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 #include <linux/slab.h>
 
 #define IMX_MU_CHANS		16
@@ -76,6 +77,7 @@ struct imx_mu_priv {
 	const struct imx_mu_dcfg	*dcfg;
 	struct clk		*clk;
 	int			irq;
+	bool			suspend;
 
 	u32 xcr[4];
 
@@ -334,6 +336,9 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		return IRQ_NONE;
 	}
 
+	if (priv->suspend)
+		pm_system_wakeup();
+
 	return IRQ_HANDLED;
 }
 
@@ -702,6 +707,8 @@ static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 			priv->xcr[i] = imx_mu_read(priv, priv->dcfg->xCR[i]);
 	}
 
+	priv->suspend = true;
+
 	return 0;
 }
 
@@ -723,6 +730,8 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
 	}
 
+	priv->suspend = false;
+
 	return 0;
 }
 
-- 
2.25.1

