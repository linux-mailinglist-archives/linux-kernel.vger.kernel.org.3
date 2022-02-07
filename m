Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45764AB336
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbiBGBxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBGBxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:35 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29CC043184;
        Sun,  6 Feb 2022 17:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4fChgLK5TjuhA0omlK8K8bA44/x/k+51sAPLX4z/TjBrt6wVY5nf9zKaYh3UNEhz4wiBM2NioztKKZkwLfF1u3k3uViWJ8AU8Tjh4YywqB8w3BGqiIGZfuwgT08+f8DLQ9Lw8q7WsVN5tS5GHse6GCOsopT48QgEuwYvLdfy8VtDCzLVpdYMzZzR4y0azgEgdtB9pKX8vWXzGTq1zCUxJ3pfwVdG4utO70hkXaHfYr2Z9faHVhpvA7d/E0gnGfkCsY6ZMw83gLvEibuhNMryMGuR2p6Es//FhQmXW9UV2+1eXBgNxrW1W9Buklg2eO/0Xl8BBEjgEV7gNZTYL2TOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSpTTy5SnN9P+Pidv5lx41LPoGtkIBAQFMwe1b+9bBE=;
 b=kM6OX/kruBuDDT6N1Z1XQzuFOuxI3mUJ5pDjvXalvMRHWz/isELKca/Zh90w5GT1xND5JNTVfvqc54P3kDFo4ReepqDagg27YiK5tyrYStTU4Exw+HuvZZkDJS6jLu5p8nCDORVqHUNTIlnD63K+tGnqC9ASJ5mo2j/1tzhlWjpXM/URTpkETYCVwLrko2uD6SwQfVJb3PUlxXwMPF8JJXxjDDTidGv+8+I4IWbFUD5FfhVWSpZbNYC7i+nbsnFvJouQ6s3PkppjGiv/SjQxl8o08BZSKqBIsFV3QK9E82/b8QFsuIt9S/fACnIAZnJ6ZkWkU9zGQ7QKPQ3Z7quzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSpTTy5SnN9P+Pidv5lx41LPoGtkIBAQFMwe1b+9bBE=;
 b=mg757dlp4dImFkiXUra6PRbk1P2x3IXUxL3LBcFo4ilnNkRgSDWMipM048k54ASPcnpgjpoW7sl8aH5qmoEqW+CJK88FH9bzyOdrawMXwmbZI3QH65MACyMB5JcrS8Pi4f2S8k7kJg5eA9hN6LfE+fXSYY6eIJn4TloErBplP8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] mailbox: imx: fix wakeup failure from freeze mode
Date:   Mon,  7 Feb 2022 09:52:06 +0800
Message-Id: <20220207015211.394297-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872f5676-7700-414d-1638-08d9e9dca46a
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24933D92B1C70CD32AFD3499C92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noY/jo+IINhjkpKj/AAjexNZUHdQKGaYIYpvcAwJs/WHPf9CusJQ/IWvuzvFs0MtgdBe5gUPOTpFp2yijSyW5HEHbK6piP868aJuQEmpKtG1D2ue8yR7NMH0goL5jiepDvv122cOfUGzUVxL659fmw0mEusSNYM/eBDMeicvm75QiStbegEHYU6rA6jAxBqVLxLLrUcL8O3SBen5ZTIiWmmCxKlo2b5NnRwnrcg6DVtMYELOObNpGu5OonUgxoQA6kBLYT+tBKSYIGIsYPU9Cgq6sQjlpFhbQe7WvsoYdh1Jj8Wz5GU9EI32CEVj18/8HWHlNpn6LEwiIvd1ZeUWYnKcAv8XobXPQi7GL1KFFjUIy4EyhDRrFM8ThGQug8XS+c+EVTFzvHNPsPQa4GtWepaLU/xjYh7FnqxP3/QS6gpqkPTA+HdJDbyt1mq0bThANml8oA/YMEMKmft1EWmrI/To1qAcl8ZjrZC5EKSpO7bxwMD2sdSVNuAvBY4xUt9V68iHNbvht+txNgdlAa+ak1Qd9j3huflNeyCM/mBQCSsLeB/NmS/vCS42uozySlIofj1YhATdxK9Jf7hWWODyuN3EE3HuVV3HGOIDdAv+tXkg6YcYCIVacpfm4PedDcTYsmCNc8KkAM7fKCOuGepSYx0eIfyXJ7RKsbAeskoAE9TTc6Kx2XSy/IqE/OVreHuxo/YuxmHoVOXco9v3V8Y9Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(54906003)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzj8QSN7WmCBqsbQIn9b6p+1SNyuEG+Kr3lxo8JRjefTjTxsQ9Ztxm/+WPLK?=
 =?us-ascii?Q?7PcUNHtGzWO3+yNLshMTGcu/N+bQfjpOslaMXDlfjYDCM0l9D1INsFxbejDt?=
 =?us-ascii?Q?twM+CrGerFEKD2JcMMIRe0wuoqeTrkt02bmebWRx1Mm0Kw/mtj0BXZwIAueU?=
 =?us-ascii?Q?tRn+aKRxWaqpKwi3Xv+r16a4Z/j5811HpNJ0DrpkHY/sRaGF5b3oalhDc2TR?=
 =?us-ascii?Q?mnYXf/AOafoOgtr6RRxaOpqlw5kg5EDBkifci0JkpAnZazG0oJo5UExKq19R?=
 =?us-ascii?Q?P/v8ds0W2PsEb98TYirTMs20grjjM+OPkjvuVt2gDh68aGQagGmJNiepeHFd?=
 =?us-ascii?Q?D+nZo4RiI85p/fgUw8FGFLL2M4dHFGvRupGsFxftbd894s7E2/NNJOB61x84?=
 =?us-ascii?Q?8plXoGgwRaREUHfTl7sPqnSd0isIAmHucn0YEB9pziFMzPA+ryTGZxvGaT4s?=
 =?us-ascii?Q?UWyRDr/iPsmbHEqOV7JWG9OEdGvcI284NZulKfkxsRT5VNH8NxlO/dqfqFKw?=
 =?us-ascii?Q?Bvg5XYBd925+I8/3K+p2Q0R9Wk/dnkHJa1YxA7S4u9huW26oJ/FnrGybkCzD?=
 =?us-ascii?Q?JlE+eF5oM665y+6xFTXs/S31z63xIFvUykWQZOi5XBmfhpgPDkSTjFecFmuq?=
 =?us-ascii?Q?DdokK/J+WIBP07PXbeJlhXZhNTUyfkUQdTSj6CWsuACjNkAnle4btF/qqmzl?=
 =?us-ascii?Q?pKq9dVKactfEzz5hs319NWHgmrqx8w66V+caZeJRYhUYt2UzAv+j6umo2ILP?=
 =?us-ascii?Q?n3RDjMC5LxTODrkTKLtkffDgsFzaG1pJFtWNEoBvNbligH7bC0bP31HzIONl?=
 =?us-ascii?Q?QoTrSxrBR/FLv9DY22Qyig6vlMF6eS0JMeQ+Ked8rGYvq9P4KvkyEyCMP17K?=
 =?us-ascii?Q?5ltDXOVgMt7BuVJx0wrb6FYWMqwcPFQ6DQ6FsUbQ4/Crn8ha2fYy4WqM84dy?=
 =?us-ascii?Q?XiC7OKLCRbVhvUSBGmJ8jCo86OgRbpwNGAm/UElf1IQx8rcgM3/rWzuSOkH8?=
 =?us-ascii?Q?Krp6YF9VQARllPqIZ1YOiTH84L6uCEg3Ehk8nQ1FfGIW4z+N88hX4zlxE8Rf?=
 =?us-ascii?Q?hn6KWkvGCzFCDETMjQn/DKkXvXavxcG6UhzkUosx5PgKVoWG0V3kaMiZ+puz?=
 =?us-ascii?Q?fMW2BMSs8m+1nU4TlU+bWC7inJz2Dy5Hsd/q9QEfCmh/VGEAIgiO7P6zMGJw?=
 =?us-ascii?Q?MPcknyqkXTXGFgu5j/JqOxw6WeevYYXQobItFfRa6rLTAEt4XdkBMzCYecXa?=
 =?us-ascii?Q?BFGeIAiT4BENzDqu5X8EULbeAtY7vu3GJW1kJ/YC/8KOedrWxZO4yxem33Um?=
 =?us-ascii?Q?7T7Bg0+4hcyQN/kMNQ1x+ASk+WX+DZFQzGXCfT+tUsXnb36LsNRjFWoAWDtc?=
 =?us-ascii?Q?IYO4/zMC7hA4vvCoRLBtZd83RdvAU6K+03WDCA8JJTh8SZxA3ZDVjVbu5svQ?=
 =?us-ascii?Q?otgGTol/RmFTcJ0StUw70O9dTeNtEi2llOr8wPgZSvPAjr1flkHqO7HAExSo?=
 =?us-ascii?Q?+amyz+UEnDEYsY6jg7eNevromFRo0h5a2tzkOuny9qhQumFOpEO2edY87L1g?=
 =?us-ascii?Q?7DAkFxXc0I6rpWEAIDpyRrA3E4B1M84CKdQysDjDkvdLQ9bWs2yZl9AemnTm?=
 =?us-ascii?Q?fDnZ+pvulW7Lx6p19rQepZ8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872f5676-7700-414d-1638-08d9e9dca46a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:31.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0zuHncoOYUsLbtDbkjabc6nbDIl2uBt7gmId0qMxA+pBLqOctq+dPRCEwDLInsL/YokH1LwxaQfs2gZS0veVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 544de2db6453..8b1399e5d7bf 100644
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

