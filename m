Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435D85A5A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiH3DbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiH3Dam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BD726BE;
        Mon, 29 Aug 2022 20:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrg1L6JXwC7+VGMai5UzYvhrBR6Pl9QkVC7J5Q0tx/X/JzSGY80UHFU7L+6hzWV8N/6jszL+P569Q2kgAqbMLXR3hYTEgbhrr9/DZWW17mHcsB++lbhJJw8Jry3/mfnaSo0wN1GwpoTxxBqkNuTdnUKtMqmAYQb8jwDTSgEN0KToDSNEOy0HlfrHB04pCRsmTuImbLNhInTjEn/RVqMckpIxfdS+XG0rdayKBUFY3O9CL2ZkuELxQAYAv8Jh4z8brJfletHb+QmOFWwpaUOB4ba+tHehT1XeJ6UbsA6/n3uSP0ZBA1X4Hjg01Chji6agR8fjA3ndVxpGjWJRFexNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoW97lFWAKaE4WbJWeV6ib5dhCOBI0EeRDaSSEzFOhc=;
 b=NXEGDLIDXQ4JGsToolKryZnwDWnIletGqZDqFC6tMKwB67/nJdqGj+2W0/i4jRpbyDT+vB/Yom8bzOB3jTqDwz2mVu6Y288LTnHs9ElR1iFcx9QesO4N71u9Eokyi0bVIyQd/p6TagJPOBeSTjnekMu7C5Kogi2yOtctb7nismGkD63bCe1rWvDILkGWcJSQiGzDRcMMUysTI2LFje08itk4tKbnF2wfMUCtiFS3boRfrwlbXR5Ki64vJPfV9zSU9Bvs8D8nPqnSA2WiKrInUs+xsP9i6I0WmWaYRUDtdW/3Zz/aHeomOxE6vwUSAyUPSsiYY7gctJE//UY2lS8RSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoW97lFWAKaE4WbJWeV6ib5dhCOBI0EeRDaSSEzFOhc=;
 b=fPJ+wlkXCPOclqV+xy7SoiI33KMwQt7OTzJVgwqVyd/BIqvqBBYOfQRtE2i+PrUdk0ZBBZaxYRa8EeE/eGcBOR1PLueFgyQ74Z+zDNwvsMfbjkduhAdair1ZHgPJDZD/yI+qF/ZGb99hqvmRPgNF7pPm09jst2zref1qvh+33oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 6/8] clk: imx93: switch to use new clk gate API
Date:   Tue, 30 Aug 2022 11:31:35 +0800
Message-Id: <20220830033137.4149542-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43e85a9-d377-4fae-8522-08da8a37fd66
X-MS-TrafficTypeDiagnostic: VI1PR04MB6926:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0aHR8UueABRY+btmoWvfhT7BUtZbIE+2x5RL+zCF10vKIzT4sxXi2bjW/nzvAIQdSBGPpGsqjgwZLdeCia0rNEsPDzO0zJkjjtgnYEID8FXFHJPkhHynKWurJ6kWcv9ISqoB7wtPCdp2CwAgub02SwnbApjqnxnHryTnvHzBsnbmbBlo6+rERlWiEbv+jMjdtg5cQZtWvMYg/vDsMV66IH4nWrvD6KG7grefOyLprwBFHHmoLOfXEh+aFl8tuqrEq7tmTLfF6JUwl+PTa+u6Dy4wTYGzBf5pzOK7w8PD/H0I6BPyDGcd8EFQsDUdV6W1Tpf8Jp5FLr2nFcwHBj7h0V9FxDxTNkWJ5FiqGxsoENOXKXenJcqyMRC4BAZTyGmrJXvT4OA1L6FgpM/4dBZjNdjTl7HS2iqW6YEs/RT1LXfOT5Wv/Xbra/bPP7Afw3+Je8N4EEUFKBNlfLnfy2j/GGO1WDifthuAEmAusKDIlOZ92y5h49ir7IQKHOZTMRG+y8v4ljBvU82pS82uUKfNmP3lermYPLq5gVH9BwLj0iuUv7zLa6UtNFzmeZDFpUJx27t+a+dR2c8B0AfktI2fJjB49wl44LMWhg3kv7SGUddFpuyIGs4La16WfHqN8qjesYDWuKBmpnT6oCUuqlK35CK6/MGD/tRdDlJyJQ+rCPBiRaaLwEYGdSF3oQvqrk3EbZ0OPI+y2oRXfQz/WXa16IRUle2OXN/TOWoPkKlguZyv983jyu+Ikp/ggsBis+yYiEwkabZCWPpd7Y6tFpo1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6512007)(2906002)(38100700002)(6506007)(2616005)(26005)(38350700002)(52116002)(186003)(1076003)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(316002)(6486002)(7416002)(8936002)(54906003)(86362001)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptjl16FXKoP9AYgBzY91AKja/qHDTTx6li3nEe2uahaUUFlohd4TTGJAdOxq?=
 =?us-ascii?Q?+jvfz3NrFKvC+TKd+w9bcqjZxUGAtWcfyHEqyNd6W6MG3Ayg71M3qHn5JFVI?=
 =?us-ascii?Q?uDF6DzBCja3yM5w0fEoMpcMWXtxB2Jxz8HZmS0clVMoSdoRER2DpfFTC+BHC?=
 =?us-ascii?Q?kkLOl8UF8T+KkZR+wdhpVItBYkpTdlzoDKcNV9VoO/5G7G6Hcg55j+YdrqVF?=
 =?us-ascii?Q?3RdM5augR8eTNUjl4sYGg7XmZsXfHRbGkUsFTv9psgYyRLkaUewFLWzKnS8o?=
 =?us-ascii?Q?kZ9J1G1E+WqPo6l//b9pDuLlAEA4NzUYyX8xN6vecjrD9jr3iJXLQh3e/mum?=
 =?us-ascii?Q?OsGjcFdqhN1CUgPuVwS4tmTeL/GouWhVReDWuhOnvAmEtOFahnRKUGaam2Wu?=
 =?us-ascii?Q?KmWy3gjeEt8RU0orIZ/9iQPcSl/CsswgYn6tY4n/0ZZtVvSflVP3fRx94KQu?=
 =?us-ascii?Q?gHowD3wUCZGXrj5Cy2/NOGA4nxPj0v6xu1Lf+oV3VtoaDFk2kqaENiIdEoEQ?=
 =?us-ascii?Q?sWbmCH4+CwJPubzpITaqKwp/DpxCt69cdsOH7ajTm+hgDx4e0CeIBcZDY/zE?=
 =?us-ascii?Q?rP1pBRk3h/XiR3V/n7nY3ECC7qM+23wNuaez/hONV4ID+hWcwjCN3sa11cPb?=
 =?us-ascii?Q?V59SECf5sKV6ZDbnPm5fQTvGPV/wkro0vUjmXXkCYVcvF2rnrS736vtpwOPM?=
 =?us-ascii?Q?fc4ZtZ4eBDZW/Pom6K8sitR9fuHdd6kwyK4pFUh/Y00q9cGLYw0dXihIsCmw?=
 =?us-ascii?Q?blQCLX8J4bJn535AL+UKjDqF0dRaskIzQftwVCy8hclaWHdIIDxnvnfQwApT?=
 =?us-ascii?Q?z8HtPB+q8Vl1qOgCFhnZW0qq5R3HSapF1IcyPQWriQq9VIsI4ptljge21xNQ?=
 =?us-ascii?Q?Zfc6pReExmzpcRD0pZXtDwMwY1rqYwQg5Fot7J8PaMQoMRxGxlgH3fvLySrs?=
 =?us-ascii?Q?R3di5UbawsQ3T01pAUcq+c36tiHpGiT9ti48N/UwvE49gs0wL6P9u4LhTqzs?=
 =?us-ascii?Q?zSWVGjFEC1ghAJNs7DoWsfXVrYlCHDRxk1nQw9BkGpcyb6dXVhayS/7W8oUX?=
 =?us-ascii?Q?ZLBEhojQzMrhYLXZMWmjJhj4yuq/Bq38BzhJc4DTvOTHJ1dodlGnuxPzZAKR?=
 =?us-ascii?Q?EMv/5zfFXSrts33f1/2U3KJPvChb3yjztieA6Zs5MYflcNHe/qg3VivH33MJ?=
 =?us-ascii?Q?4K3eOa/X8/Sf5Zbu9MDzA4EImtfGc9MQ4MQNQbwzLT2yn4w1fGTwh2x/mP2M?=
 =?us-ascii?Q?Tqzc9d8Ptti4a/vWf1qFZy0Pv4Umagr7On1IKrF2sHcZo5bo6jXwHaktSqZ9?=
 =?us-ascii?Q?fpPwO8rqaC8nl5apv1NqOfN4J3OU1WiBalXxlIXz8e0Ny9usmnKh+8aJqKyX?=
 =?us-ascii?Q?n0GNRv9dGSvox2spPmtqpsZs1bvYIooKAra40LA0qV/8sGeqViEr/7RimVNc?=
 =?us-ascii?Q?vyxo8recS/9hRBNYQw3TUQ9ptRime8tdjNITHQsdW/t3Y6N9P7v9+yO3/nOW?=
 =?us-ascii?Q?eOBACprgmGBxQ4+xEtZ4vdA8/5EaI+WvEvRWkskQmtAO7d2woAfnZqda8BlO?=
 =?us-ascii?Q?2NG03LfnJRS6NOS6wMpGxG37kcjO5uoK8GmU4mPy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43e85a9-d377-4fae-8522-08da8a37fd66
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:30.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCW1hg9d0//Xz7FPdn7q2XjzyDexSLRJftfp9RALNjAEZ9Yl75AR7xmM7EQ/NmcTjIIAx2bzPGYHREddo/8ViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use i.MX93 specific clk gate API

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 6d9cbe26b2fb..d9ec4d618f48 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -146,6 +146,7 @@ static const struct imx93_clk_ccgr {
 	char *parent_name;
 	u32 off;
 	unsigned long flags;
+	u32 *shared_count;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -299,10 +300,9 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx_clk_hw_gate4_flags(ccgr->name,
-							 ccgr->parent_name,
-							 base + ccgr->off, 0,
-							 ccgr->flags);
+		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
+						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+						 ccgr->shared_count);
 	}
 
 	imx_check_clk_hws(clks, IMX93_CLK_END);
-- 
2.37.1

