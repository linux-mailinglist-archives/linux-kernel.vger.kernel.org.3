Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85A464E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbhLAMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:54:55 -0500
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:55424
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349401AbhLAMyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:54:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6CtsNVKqNZmfSV280KUmxsUjFKOl39DDUYSDn7zqfiX1uod7Q51QkwsKnltoILtwHYAYPA9sXqtOtaQI9TW544r7M0i5n0/1jat1b64uOZj987AaemoneJZXRnqKNVd7c+Qt7vpVuv9L4SGxMuKN+me346iBU1YVsyy97doXHip1WHXkRrKNcdzlJxvOJmRBWdCnZMf8VFkHSorMeEUytpANxqTOOm2CWxdTKFK38k9EhWP8FQHiszzadAUDC4n0OSJxhGyvbf99EHDS17o5yyoQ0kn3vSuHh2TvvV0bP8pL/QSyIv4h8ETB5usq1ZGmQr15f6CR+ZflPbnnRaOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIXQePCdzVSmbotsQ1KbVk7vsVNVe2oxUByRig3VlBs=;
 b=GnenrZe1KJkY7aQpRuqLHYnXXxq2MOcyiWII+Nz+6Oxg2V4Eb9CD00+g03agZ1IbrFSWvZSxqkPcEbP4cgvwDvNMtFUNn5vpADGrtxSyTSti86g7KtfFxjFKGCvZXU80RlqegFN5IbYLPxZjwc89hHcKdunGD0DgRwO6YW5SZr0JJ/LCoatr4/6IBzH7UEGZ5yYif3S6fiPlV0/E3HjkMYnPUrh22BIq+LseJq5fWAMvLG9IjcFsLNo5tw+mLVH3iIZZOYDwmdo1bnCacWX8yQ8xaUSjN9G3BOvnT/F3+Br6WaZkyl+0qi8CUaAphPo20BY2cDoESp0yHk6z6wJpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIXQePCdzVSmbotsQ1KbVk7vsVNVe2oxUByRig3VlBs=;
 b=Tjp6qNxivBUeihMaDoj+Owv/pNqEWcemqatQvurC986pAm8y3SQC0r8Fo5C7ud8lsLQXXp9jj0Fg1NHcozami4bj5JREUjgkg0BJ2GitkSpPqSX+stCwphz0qVhdN9O0nSADBADMpuRdBRj4WHd0BEFfkxQCD0qlswdAwrXsPwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 12:51:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4713.027; Wed, 1 Dec 2021
 12:51:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable with __ro_after_init
Date:   Wed,  1 Dec 2021 20:50:29 +0800
Message-Id: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 12:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3034f6e1-91c0-41b4-60da-08d9b4c947b6
X-MS-TrafficTypeDiagnostic: DU2PR04MB9018:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB90180AF41BD1B68D7F561B2DC9689@DU2PR04MB9018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7bophiXuDUETvZja2W2xPOBtdXqi5y7AWIBJiLjVAU8nmket9471uEZIvH0/eEWFDuuf1+yuO7TkFptPXNrM+RG4oYzCVnTul+ox/2JQA7jTZRd51vFgdRNTpqVrhDMdIkhy2EE7Z6hmGE5zaNL1kLyXmG2xVVe3gkfdZvCttC6SByEYGuMhdPon+WSAQWu+laAfGtbv9+vQ8Hotteg1WWhxtD4LviVZal52wn/0JKUNFjDkBJ4PS1jFryGz218nbk8h8zVVsKHdBy1EDM/LOXmaWKDLCOFeA9w7bRyxDkRq4H8M58rO3jTe/9jidIvdDuCpJrbdu2N98S8YCCxUmU5w41Nmnj2WhiMkKoxXMdTUm4872BmMuD5vPf+Oq5nFyoyo0A4175PgagXddChs2/KCualaMpNV1wrzXmPdalXQm2/eQvnp6PUi7vCnMW6Aqglzf45g5vs+Cygqxb+eaNQiIyYyNFQnnA5aOm7ROOlF+7ZAi/tKkLJIlZi2fO9b9ZYXv7cc2rhN29NEUdc32ZSuiqAWYgCYWACBu9UodS1Em5um3lgDJ/PE9sxW0ucUcw8Cq3pNrLTPP4S4o6dIoCaNmTEZHLCckm7UD0dHHUKYvNlIXMGxOaWiear6tGb8es8PMhb0Bh6oOuPzgyM06WWhuwxqY+VcuE6F9QiNM9WKxmYmoOFjbAKDojAwzQCmLvxAJXBjTxYQ6A+gqormg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(26005)(508600001)(38350700002)(316002)(2616005)(38100700002)(2906002)(4326008)(186003)(7416002)(66946007)(86362001)(8676002)(66556008)(6486002)(52116002)(54906003)(1076003)(66476007)(6506007)(6512007)(956004)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSPxJ1jY6fud9D7NeBzaRv8Lpg4/cWUJLHf008KL6JJxkhtdaFrnW5PbZCJb?=
 =?us-ascii?Q?8IEHmsfE5NFf0TB99SkzmGtKlRyB8rvSI+/j1iQAsp+zFXERj9DWO9QEgYJb?=
 =?us-ascii?Q?A7atRLwx6odrGatPCz7rkLNYH08sc1pS9Dx1F/cKAOYwH+8dEMSXbpyQ7PWr?=
 =?us-ascii?Q?ysIXT5qFkcbu9XSQEInkJ89FQyEnr7l36UyPUv8rmePvt2lLyUxr1PjvxqWD?=
 =?us-ascii?Q?LVkLMPABSdFhVQfGYhQq4V1PqodLOLHc8yo7KKOq89+d5yujPiy+S+jp4jok?=
 =?us-ascii?Q?buW0pG7LCE1wkksGoDBNhzSsgyjfzfDo8hOXEYXkHP4R5ehXc9VNQh0xqFyg?=
 =?us-ascii?Q?+LwDNeB4ipiKLv2ss9uqXQiFLrevWogKBkpVRbFy/eALTWDEancrTSnM8dKa?=
 =?us-ascii?Q?EmZjpiPMvF15Ew+ge2NHVsPMDxGM7sFzhnhX9cmPD05x4AaLBUFf5h70in4p?=
 =?us-ascii?Q?ZuPcJkAgK3SjKMyRMg4fnae9YW7zsoqa6Kt3s1ZOP4jyoGXttovghRnB/HZ9?=
 =?us-ascii?Q?zHqgdoQrPypDqjgfTh8/JXyctS9IeuEGtsqxtul5kT2nYhmHx/bknK0xDQFX?=
 =?us-ascii?Q?2l+n1RTkgBT6vCpuaimNksUcrUkupICIfaypfMXy5OxniqWCx/LZcwqd9E23?=
 =?us-ascii?Q?c2u+cpoqyWQ+DWZijQ4lgzz7Q/l5OdEN8JgEeEDhTKouCHCoL4PDe2AkcKQh?=
 =?us-ascii?Q?4eIF83SBXSbfiliuMz7gB+doTPPup6r7OxisP9m7N6rqyIM3Puk8C5q58xVy?=
 =?us-ascii?Q?yAp0tVEvemHX9KrQCCs4cHsFjCAPUoixiB4rrkaO55XkkGuDGckYn1Dj6zmZ?=
 =?us-ascii?Q?Zarr1sSyjeFIMtq/ByNd/yBreWIuLVEmrQRm+DEMR8mGOWNOF3rSWv3jd4QL?=
 =?us-ascii?Q?b3OBki9WUDSRkay/7AaKQmmrchait92LXhULljnDn2Er/Scrd7NgkI1pDGtr?=
 =?us-ascii?Q?vy4cH99lek1lGTw5pcJ0RJmfk/aMQ6zYo9F4wyqgURyV7MVdey9pBpb/CEPW?=
 =?us-ascii?Q?0a2AgGEA//AtDHll+CJ9rt6AX5sdZYYAbrHQM1KF2fqs40keSFBCNNs2K4Nj?=
 =?us-ascii?Q?ve1PrfoL1yPyOC0L9o8tW+Rkma/sJjCVz0B7EmNqvdFLqqG+jmtxMF1gFzfO?=
 =?us-ascii?Q?5YY+G6r8bE1dZz5wcxbRr+SUij1FHIxa/IT5kyHiU8zLKR0EwYaWis1OMCOo?=
 =?us-ascii?Q?xZD18bNoqQMCHBJXiXIDrlyYpq05pdvKRojZ2LWnnL1T4N2tZe+UXGVktzj2?=
 =?us-ascii?Q?ATBbmlmeM7i1s5wxZf4ase8c4en+0qZ5JaxxMWwq7mYeoDIOYdg1fC9XfsTi?=
 =?us-ascii?Q?8TXYbrEsUgQKNs69Kk/3joIo/EzolY69o/sFLIMmKu7u88LZ7HvqtahsXWvY?=
 =?us-ascii?Q?0uvM2HA7eVonsSlZLD1lAw1qaq1FUZIx8XZq5EmIDz1NltyEe+VN1dSNvZJq?=
 =?us-ascii?Q?3KhrD/pY/qTtFZ69TXLinq30XHbjwdzTi1d7OrOx1EBvhw6L1aXi3Y1bQW8P?=
 =?us-ascii?Q?lXE8zeexD5FGBrALp1/Q7HcCYaWFtqflocyD6zgnnedVU5Db2o5/EFQK1klG?=
 =?us-ascii?Q?JM7H/BGiUMFXMyoWHCipGIiITeJ1cha1hsy6Z4oJ/tuzRnYuOpyds/x3nbq4?=
 =?us-ascii?Q?wuTBjSSClN9Z6HEgJdK+r1c=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3034f6e1-91c0-41b4-60da-08d9b4c947b6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 12:51:23.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+InuqxDtmblVUvfS4fGyUDTY7sbua/QdBu6Pul6T3hKYbkY8CokN+I/GsXJ1EBijPYimNO6cfndwQAtm/vo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

sys_ctr_base and cmpcr will not be updated after init, so mark
as __ro_after_init.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 18b90fc56bfc..2b309af11266 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,8 +20,8 @@
 
 #define SYS_CTR_CLK_DIV		0x3
 
-static void __iomem *sys_ctr_base;
-static u32 cmpcr;
+static void __iomem *sys_ctr_base __ro_after_init;
+static u32 cmpcr __ro_after_init;
 
 static void sysctr_timer_enable(bool enable)
 {
-- 
2.25.1

