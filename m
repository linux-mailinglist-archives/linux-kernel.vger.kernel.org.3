Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAE483BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiADG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:11 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:59213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231887AbiADG1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:27:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+HAuzBN6dPiSN167kCTLg8EdUK/XvoAuCgCbMneiVd5leAYr+L/3t3+uNe4L5m8MtcUnEgEJa781VPDWSRkNSQaTffwLhAwym7sKng8CqJL40WXfOtenqLU25lX0V7oMcJlfDSTSCDkEYHLi/jg9TjCzFdh/VzDzpNTJD0kw66kraoSgzw9G2QYnL4WXzScsUL6tG1F2LTB+KKk7CNIqZAcmzW2jmaXSeFdPo2Iw7rxXMhihMQUVU52RMmJB2UhqIPJGouUSK1cipOgZKKOM2Wop7LoScOG22MmL07BEsZrF5lhsfAS0CufUachsRKCbZWDCm2hYe2E0JkwEAdwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg/OCcxNaoocwDdj4AOuguz4GswmvjiYlHuUq4dtwq8=;
 b=jKGi6iEAlBVicZNiBB9H+4hy+SXx3LhumlxNFma40+mzM7CPS83XSLeWnlxLwWq7kEOjoMNBA5j2Mm4czGXceKRls6+x9Sc6n7xbb0mbh19uD/6ujhIj/z1Y9Wt18/gp0BygMu+YhUksQEoC7BpsQH6i1bEhxLUkqnyPJCcBInLirpKsDmkBtJEXNl2Ryy2ooqhsCUSpXopQNw9QB68WcwHdgskwxzIYl2YxSKfK6zhd52jo8Kpx+E4S+C/9yKIM6yp/5Raj/ssVD/WCqEXKdjD4uO1RMW1PweworyJQpQdUVLfd7LLonRJTK2buuwaDGOEvrhsVVj8xfYARu1sDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg/OCcxNaoocwDdj4AOuguz4GswmvjiYlHuUq4dtwq8=;
 b=OF9Sgx8srMDgkbenPb4lts7auIMeBK6xeb/GYL7UskjdkDGlacac42XBePcC7HiBHD7AOSRRVEEa+aqHS4rvBJSdTtC7nUCY/Klc2H3MD09x/ByDu4mTbxk/EaEZRU0CmXz3RFwSupWkDyed1cdwWxFYxLgdkK0QgSphs3wiy6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:26:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:26:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/7] mailbox: imx: enlarge timeout while reading/writing messages to SCFW
Date:   Tue,  4 Jan 2022 14:25:44 +0800
Message-Id: <20220104062547.2103016-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 678a06a1-c2a9-40f4-149d-08d9cf4b35fc
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9298C57D248FFC5882DB5156C94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLYHlrlMvJaMSKqg5OkzNWGh7ShnmFRneq0iTwMWMamoVYXIiolw0QcZPGsfkOStIzTx7WTSb2XUkXNfZAK0rewbETu2G0CfVDTYmtCoXybkNbyF8dlnAHOTUtFTbX4L6U2Zmf755Pj0YUrDmkq1uMNnCwoEjnIWtYEWPvjlksoDcwRv5/BFrr+m7CdJfU7W70ONkDspsv1wvtXhizM96pN8EozHx/PofvlJKckKU7EQ/G2PQE4N3pXhquKHCc3apPwjlVZKF/X4AP6Ykas9v9Opbk/pf3un/ldasjNaENuVWGCNOJXgOICmM5M5tuziUvgP5bFXJIT7hF53/6bo1kbOfR6z5MA21j+fg0SCTqDJgmRi9f1B5j83yTF/V9gYB/ObqgyjMKKbOHiHdH768yrhzNwEUQrkvJz1occSnkV9VpdJEhJOU1fgEwNl6oYC5P0LE6u8F0gOk6LYyfi1NhtdEedJhZmzfYMszAfz4v91WaqgYK1jyEp6QhArafl4WdBnLtlrENrm3YJtOIBE3nj0L+bX61ABzcyc3SiI9pgTESe/UNDW8nDVUZpiEaWDjterQ5gHn4YKNgpT4609Hmb8UbOrKvbuUbnnE3YEquqKtRo/6lnH4HBHLbSuufifIpdgtwLzHveXOVfoAe0K2eBO8dpVDjl/1JzjOS/zj7Yjm+uJbCtMC3+eqiztgKQCNBnG7U2Lv8836I9jl8u+X4XnXE0s5wNzbiFO8lbJOBzWQ8IC/7NFqA0GcR4o4pddkQ0EhCK1hdifQZWOQxlHtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(2906002)(52116002)(316002)(2616005)(8936002)(54906003)(86362001)(161623001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzXfxhe0xRMHnjzz/jDU8PrkA/bxpFygG2+5deEnC/S4K6USqafXMN7njomE?=
 =?us-ascii?Q?lGULtI+AGtK+sDvXE0PeMQ/OqIIqDa06E9gHXt22SbChCot2UxHXW2hsQzfS?=
 =?us-ascii?Q?z1Ew1TZGAPASL26Mx9BO1RAMfjXB+Sp42M1znp3F51oWNr1kn34MLLca2nYm?=
 =?us-ascii?Q?UGYjtUeRh4KAQzKTsSoGmX/m9elca1HZfyqLFep3HipHf/I84SVtNC8J/Ypm?=
 =?us-ascii?Q?6st5VFA2/O3j6a8pFUTzGU1CkX51eRClOePL5PY6M8dDVg8PyPL0p6QepGeC?=
 =?us-ascii?Q?MEiKfi/8JUAny3l3v+N0YLYx6nLn6T9cf03hyZEcqMGq42cOZ8K4BOSL1uF5?=
 =?us-ascii?Q?tUDwxJfI/JvlDx2TKN3YWr8amzy0ft1XXdau728XPmJ4aZNQUniHMmZqF04U?=
 =?us-ascii?Q?qVGZWk8l76wGKaTYxoP6aT2LPvXsItyyzOyeF5A2gIHoOYTZs6Jq5Njz8lHv?=
 =?us-ascii?Q?Yyoza+oE/2DL8ahvszb9qcVJl6C4MUoFk7StOsiImdJwkXavxequBaYHjzx8?=
 =?us-ascii?Q?emUlr6IpoAXOGHWdG59wTSP7SNFTbU7NSnL/Ih84QxMfUWhSWIs2Co8yxpW/?=
 =?us-ascii?Q?o7z1yqIRXYJiMoJp0FjYS8zQV70eUEnnPpIeqWUmpMnBfZTOZlHBLS6y/vG4?=
 =?us-ascii?Q?PjGIOM0z1BAQTmtamd8U4fd5UfBYGlkrLHL7XGY96sk62UUKMaI8j8fXsXEm?=
 =?us-ascii?Q?ieHXy1H94dfAE80PUebX1TjtE2vrEYXI+2P3H/1JUNGJqxLYJfJ6ftY6dtr/?=
 =?us-ascii?Q?077nyaPZjONT7LXKiFuvJsa8UOn2WJe3b0mCZ73HC8qduvALfGrHkTdRl2JH?=
 =?us-ascii?Q?kipdAPG9FBNddDFHz62jceSRB7uFDOxJyAZQiSy19LFSn+8N5luWKblkq023?=
 =?us-ascii?Q?w8dhqLpQHPubMqeh3rhXIRgw5AGJLP3Qf5pcMrTVhGSxrX3BS5/7EOoOlks1?=
 =?us-ascii?Q?r5IrXh3iUG6hNnPx7bXpKUU1JEUp0KoLs/WTtr6RKlFRGlfsvlQ5BO6V6bo8?=
 =?us-ascii?Q?+ZUZNGs+NJkykjODuwJVtvVq97+cHeLC31Tjl2ZqHF2PP9cI4SAIEPskljGB?=
 =?us-ascii?Q?n5On0KW6fdWexsYZ57t5tcORyU/ETmhIcnj0K08N9t8y3jDBitCoVI18fT+b?=
 =?us-ascii?Q?8r7AH3qDfNjCEDYIRGHbdcwjpEDUPUhO4YZWvAEG5cckixkKecwZchQlUdOY?=
 =?us-ascii?Q?olXYYA/djyfWM/vMsFPpvvYfHTBUXUA6iwPNdoP0+THgy3fBlFzEolQyXJM3?=
 =?us-ascii?Q?bg/eGOCNqoC7ZLm3+Ne0JfX//rQJqfeKejfAfLkvi9bvkaT78tAvQK2k2tRu?=
 =?us-ascii?Q?db7WnQRHk110/mOFB8sNhoi+LH9TfENzSQ7xDukoQ1msrBHqnXlT+BCHbwGa?=
 =?us-ascii?Q?ObWVdlLj4GcEf7SDjhQ9xTLP4kxvlTti9lyR2yeBqRZ9d3s7Jwav7WyNFlck?=
 =?us-ascii?Q?NNREfwl1CBi2c30NW4F3jwE/6VdCY3TvhjnqrkF1YBsIE1MYafm4ktjIFQxK?=
 =?us-ascii?Q?9S3BvddcEjFvz18Zza1qsLS6RjhGMdobV0MNt4pkRunGnIkQ0iiNz/x28odD?=
 =?us-ascii?Q?+6Jhnq8eK4i+nhRkN4gDQ/X/VB3qaa+ZNUoG6tLv3yv2NfjbCJb1CM232GqA?=
 =?us-ascii?Q?bOLE37Vlb4VhjQ+76ORSHSw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678a06a1-c2a9-40f4-149d-08d9cf4b35fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:26:58.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbIa12kzgP5CNG2Il92wTAZIkjcJTP64jOLiB3dH3cfzfwlDiqt6kjkaQ2VzrTNBBQ4Wjl2xrunQspRCTdL3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>

Mailbox driver needs to wait and read all the words in response to a
SCFW API call, else the protocol gets messed up and results in kernel hang.
When the responses are longer than 3 words its possible that SCFW will
take some time to fill up the rest of the words in the MU, a timeout of
100us is arbritrary and too short. While waiting for Linux to consume the
first 3 words of the response SCFW can be busy doing other stuff and hence
Linux needs to wait for the rest of the words.
Similar restriction applies when writing messages that are longer than
3 words.
This patch increases the timeout to 5secs while waiting for response
or writing long messages to SCFW.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 1f44ee11054d..e8a212d0da2f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -218,7 +218,7 @@ static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR],
 						 xsr,
 						 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % num_tr),
-						 0, 100);
+						 0, 5 * USEC_PER_SEC);
 			if (ret) {
 				dev_err(priv->dev, "Send data index: %d timeout\n", i);
 				return ret;
@@ -263,7 +263,8 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
 	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0, 100);
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0,
+					 5 * USEC_PER_SEC);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
-- 
2.25.1

