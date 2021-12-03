Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F546707C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbhLCDJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:09:12 -0500
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:20961
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243182AbhLCDJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:09:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL67xTAv8kPqvhrYs6JRLhUnU78uakWFIMN1Ge1Z7KY34dh9A504yPQJMhsnPcZudu8AiGuietcMMJeqQeAamEqUtMLeYA+l9WpnavqAUuXAxdIFMwFj+nsnp7DlXaHkJYXRfiNPZl3Fa0KaKCuMSPPogCnuubCq7pRr21GHNCvetZnQeNwkQpfqWq3TxieqrNURnO8jusoPanD9nfMCs2LnCLVVV5yst/XTjZ2rkw4eLlFz5JxKkGrrrMVpUiKf/4f6OyGAewQKTBj2iNO73nKkR1423iVO5CgSzGFlO3fZLrTRM7Aw2mSI9ksrFhiCNUXSppanow6nQOutGmkTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CbAg5jnbT4+gmK6KZOfM9gNsFSgrNZqbKqaBTrRSf0=;
 b=bUa40imPahUvTYz2ppf5EAa/0t8ydRGkU2suEDKobooV+dddoNSGPobWup985Q4OcctDznxVH0EwWgwuK2MVy24Mi6scqWy2QoezFtiSTalNAV6m6ben8oZShmI2tlzZulUWe8zGyMHGSNtHZ3Plggc1CZS+q9m0WthIIxzr6cbU9M0bZX2z+oM43JLjhjk7HBBGX8fzvrjXLIdBI/7mS7Uep9S/Ju9/5fH8XW4EVJZFM2fikbqE40Lz1TvGc8BTygn56GIH6RbxFuU9xTHdsmm04xt/68BiQdSDJRRp/2ROLFabtqVAZ5P8YWchSbaQgYmNFIBXeFJTrewDDQ1mwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CbAg5jnbT4+gmK6KZOfM9gNsFSgrNZqbKqaBTrRSf0=;
 b=YjkpQx5W1SoLTUOq7NLQNOavf7+STKZULgzueza6V92NoJb6eb0gTiNKMefJfa4ghInYTdSdDctqvDPrzp8rm8YOkxIX7BfusIbnoAMGbGtk/waJlw2ygNfepJNapCGQ0DHE3ZZDWtR/dy+98FVcEO9BaX0l/y+KJd6YIKck1GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4216.eurprd04.prod.outlook.com (2603:10a6:209:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:05:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%5]) with mapi id 15.20.4755.017; Fri, 3 Dec 2021
 03:05:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: add timeout for wait_event_interruptible in .shutdown()
Date:   Fri,  3 Dec 2021 11:04:41 +0800
Message-Id: <20211203030441.22873-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 03:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbb7921-fa4c-40ea-3f1a-08d9b609ccaa
X-MS-TrafficTypeDiagnostic: AM6PR04MB4216:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4216FBE6D392C5E0C669874F926A9@AM6PR04MB4216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VguP/2koK/DQX/Y1Y8gLVbgt5YzHqOJdZpPJnzcEFmbLaEpZCF1YAK4MwsvporjdDE4arpQpB3/N6WAxWF/S40Z5E8SKM2ff/pfuAzsT66Akqow7dqlCbQiSGtTDR8vN4DwlQNJfHcDl3yXp9Kfpxf4qnI/sC8blNR4mRt96XDs77tcV1e/NBkskbiqM9rZlcwdqcxeqpi1V1D9/mPuwtf9cYG2RRT5NlC/cpjcVuY5LazKUEqKx6XBq5LerG5K8ttbet86Gue1kHnpE7cxxgSGFZJMsyukvBxRQwr2XljBBm6nfqK0qACx4jqfKs9Wx5JoaJwHdjoEsn8W1fWLdO9crYVwMaxJ8fY13+nNKV7cgBV2g7o5j1Ko2ho+Q5SX4L/oDGTQ+M2Ahf718IrcpdN++hQ22jjZ5O0lqc01kEEiAqoxxyf/VpGc4PenaXA2ap/9EiPLU+4iZAKX6+S2QaGEeKGk+v3Zshhrb/KalCh51iMnaY65aodhsqV1AgKqKbD8GCw9fFFsqpdFC4mrkT8HMd3CYuUb/UX1FZj/kE7T7KRbA0iONPe4nP45kDVpw5wwFSUmp65rp3rIlVKR64bscbkBYr85ILzUWAe9hFy9nfkJRykOdR2WIp9SRrr4rNcx6OeFpvIPrrp3yLjW4WEnTH6j2DxaR3q9hD9istpT/B9wbr0oukG1DNp5D9zU+mKJvn+SxQ2B5GVQ2DxdzAQR1PMlS7a3rOSHlVc8VwII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(4326008)(66476007)(316002)(44832011)(86362001)(508600001)(2906002)(2616005)(6512007)(5660300002)(36756003)(26005)(186003)(66946007)(8676002)(8936002)(1076003)(38350700002)(83380400001)(956004)(38100700002)(6486002)(52116002)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?snQSsV392vm1QJjXcrM4zZz7FYzzjldCZmDBHIAvTQEPJlYxGk4/y6UJ0kKa?=
 =?us-ascii?Q?4CNyVKPeAngoaX+VQ1nL5cmfWXeH989E9LEqDguz1/VZw+azv8K2Oj7xGRO2?=
 =?us-ascii?Q?9rEbuxxQ0NUWoIWaSNvJBqI8/A4hTD7eYAdjF+HfAb960RJZxDsY7umVSrDu?=
 =?us-ascii?Q?t6oDYFszqIOPYC0guujxv9qOr6l23aawcPy2kAKlXVzAcI5+c0rbH7zweYWM?=
 =?us-ascii?Q?t/r/PwJVtSm3qnNjzRRrGbsPGTzCR86yPwS0q33fPdqrK957h6Ia9/FqQ6mr?=
 =?us-ascii?Q?T2HcmaMy9ZVV+HMlzIrPDemOj5LBlXn1EpM2AmzErogWoO+uPxD65dYvfkvs?=
 =?us-ascii?Q?47B1xOh9DlR6gRhrh+ogcprFwZyxTTTTlbh4H/rq1aBlg4wMDCiyfKy/dOrP?=
 =?us-ascii?Q?Q251MX0YXDb9c8wXNtPP32J/9yfgCBCsbFuzfwNmQGkEIIKMHihlm9CbU4c1?=
 =?us-ascii?Q?AJmsHnE+yIRLTX457NlGJv7xXKGIJqh2XJonE3Aq/36XR98K71mh2dSDr4NO?=
 =?us-ascii?Q?X+qqGxxjPsdyQDX2nktIv2VqxGX+ZyGKM7ZdlpLbt0dwYMoBceXgd91zQYFR?=
 =?us-ascii?Q?y7DHr2PkWkMaWCN4CZIk8imI1wMtlvgdzVRmUADR5xXzTiOI85xBKpiX3IrE?=
 =?us-ascii?Q?Txgs8GbRh0GgTnRi6wZjqHpE+Q3Rg/PzaxgPgOxLpJcpLmOxaCwgXBKSSxIT?=
 =?us-ascii?Q?3AxpXfkvn5S12r5duPLu8/CHLOCNejxSpw27U7yZXWjZ+hG6S7txwBeRkb0F?=
 =?us-ascii?Q?ztGJsf+XGqKRTu/FzW0iT9g0V7nnupq3NRPRD3BthTX6rCNpqMfEX8MurLjK?=
 =?us-ascii?Q?aEopXWKNY/SMRqJaDADp995N9CLD/WKJDu4k77KrWaU7wjfYe504GFXqKF9K?=
 =?us-ascii?Q?XwQI7cCTbrKgjciWfaNQ3l5VqupQrTfd+Z0kGtJffYKLPV5pHR8CD2iEJt3L?=
 =?us-ascii?Q?CeSzrZHI2GUSKkbLIdxnTXV0C8x85kgarsZGCZRxj8d55tabJjnddEGCJtgp?=
 =?us-ascii?Q?qdVtz279GtGV1WDI1wzEkmF2ke+CIGYverkYiSxm6OxaRTvqkE0pwfqarXTg?=
 =?us-ascii?Q?7lr8y6mgLfYWNO6KI4g/PWINhStmcA6dZjKlVC3GnLdMOUPhiXEzWJDA5i1h?=
 =?us-ascii?Q?puaXLrQEVfnmlo1Usdoo/IXtl4IK5cyDWDRfOlVlm9b7oGIYgp5QB4mHGtww?=
 =?us-ascii?Q?cvyGK7QU0xWmPSPZeSGT4qsiXRM1KApMjIBCeZFzLdRdFsOJWcWitSUoMBj3?=
 =?us-ascii?Q?ndOY8k/IAiDwIQs08+HQ1agiopEgZXw5f79wHD65181kTJnTJu3UIY4p02Oa?=
 =?us-ascii?Q?9QFiuK+pM+JCMFbWy1SVQdCo2kauHLFgYqVJzCvviQBsM/XEbb3/FqZjXw6N?=
 =?us-ascii?Q?u+sw4ydjvrEif3X3Sh5FKTAfSTe1UaAiRyRq1q89gdvPiJkwbXrwT+VvHlDY?=
 =?us-ascii?Q?12zNVewu712YGuwn6BuA8cRowCdLYza67iTGNOtjH/KgZAtsJV2zjiGqoF3x?=
 =?us-ascii?Q?qE681iFvDnM49Zr7suRosvvd7QgcBneCsmJhfWYKowF6/ovxI48oHMxTVH7Q?=
 =?us-ascii?Q?oNBfZc8sFe79K1rl48m9vM4kNvXmbHNz6gFgskQngXSJ/0i4RWOp9u4qwjCL?=
 =?us-ascii?Q?KIADzm9ZvhEkmhfgQXzxC+w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbb7921-fa4c-40ea-3f1a-08d9b609ccaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:05:45.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkaRVqG9lfKIJRl9oD30p8gRI/0kIufsU6+wDgqMek/agH/Niv7GXkryCKXWaSeudvYVMX4sd0H6HFlpnLzdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use wait_event_interruptible in lpuart_dma_shutdown isn't a reasonable
behavior, since it may cause the system hang here if the condition
!sport->dma_tx_in_progress never to be true in some corner case, such as
when enable the flow control, the dma tx request may never be completed
due to the peer's CTS setting when run .shutdown().

So here change to use wait_event_interruptible_timeout instead of
wait_event_interruptible, the tx dma will be forcibly terminated if the
tx dma request cannot be completed within 300ms.
Considering the worst tx dma case is to have a 4K bytes tx buffer, which
would require about 300ms to complete when the baudrate is 115200.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
changes in V2
1. Increase the timeout to 300ms, need to consider the worst tx dma case.
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ac5112def40d..3affe52a364d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1793,8 +1793,8 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 	}
 
 	if (sport->lpuart_dma_tx_use) {
-		if (wait_event_interruptible(sport->dma_wait,
-			!sport->dma_tx_in_progress) != false) {
+		if (wait_event_interruptible_timeout(sport->dma_wait,
+			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <= 0) {
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-- 
2.17.1

