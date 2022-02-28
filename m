Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929454C62CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiB1GKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiB1GKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:10:39 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D260A83;
        Sun, 27 Feb 2022 22:10:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wade5dCm56z/wIPgaq2xn5YTCWDTIeEz7FQj/z4zuZFKvwdGs24yL+v5FMtd9faQnmwc4FMkYyXhvfwKiAs4VuF83BjPCjFtxSfwb1r9bURevHTAyZf/8ySDez/iBAr0AfnawdC78nkEi8zSrxYitUd+GSGbjaYhg6Ly5BN4k0oUEE8EOIWwP8peoCnQ8xpbNJV8IPZE4YBNhjAbru4Raz7ZBiizYrXGwx3fNlbzimF21zwLgXil25/oEP3m7xQ+gxhZ1zRB1r8MiYKw0FrdCGLJh+MDEm5+qjXEtzYibvlb8gcBZFSPJstg86N+uMHxjJJPL0I3HUN4yhrCfMHBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwyKQ66TLNSGpD+d3Lw1oIHZeTZz8D4S7/yI85RgJ7E=;
 b=HeN6WYjpt8LeryrPJ2lZTcuiQfGw4Z2uC/GIqA3AZcoRcie8yMNUtqdI1JoP6byjxMC5cUx0hJWVu08znhoh3uA5YKsuG/Zj79N6IIqjxl1faMaQLU+e6kKEMPDnwb9PHm1vOdAX1Oz6sFPYZGUzp+n3tYkgB6qP+H+339gnSZgd8OURpzzikRS/Jh9cygt/jmJmq1U4ckbXTKY6ws5l/cdfX6VBFkqUQBSYddXMMVPvJ0mLqN+OD+oy/KpiWmdpLCNG5R830zt6pY/Z0ClZ2iXAnBG3740GSVz5nQyB67t+b26wEGbRcZj5i6Vk42KCLI3cioh0tD5pBQTe7uva/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwyKQ66TLNSGpD+d3Lw1oIHZeTZz8D4S7/yI85RgJ7E=;
 b=LLQu5sh9+AiiPLZLOd9JIgOzqPpb2NVfHMeX/0F7crxJWS49g6sKdMwjvlvq7w6fjYQNdHH4w1pHw732pI+hx2G6jxdRqCeH+fIJ77QUniDZYTWvYCw0o9cD+M3AWs3c6Bf1tDCkDSi4KVvjzdVBYaQxqnRftDKdgIqMuPcNYDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2902.eurprd04.prod.outlook.com (2603:10a6:4:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 06:09:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 06:09:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] clk: imx: add mcore_booted boot paratemter
Date:   Mon, 28 Feb 2022 14:11:49 +0800
Message-Id: <20220228061150.3006113-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93db6b19-7ee9-40e0-6843-08d9fa80f222
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2902:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB290282B1E4C74916D9D89682C9019@DB6PR0402MB2902.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRVLMSYAhie0KKBa/941llCLgadDgmQ5UyEEZ3eicW/lfPO5Kl3/Gz4dsfUgJ1uQCvhlLaQKvJC/rfsHWKbIMsXOXO/jwA4JnLY2uXvMoPGxsOu0/JynZjWzjA46ysQJC2touUMnG/m10SB0gF3HOQ0CEcktf5WmEnmS1ojSOgcd89jac8F1JVmp8qTTeb4XNJei2hVyz04Q5pVta8D/H6R0OCxwX4v8fbZJKFtOi0C7K+sJzS4ddKoAIlkgE4QpNwbvxgm3+4OKllYTydartl7EORs7QS6mKuLrq1Thkq/qK4Imx/xQbrcA4FYH4L3HqB0Nje0BGUoEPD0fJ7KZ7AiUPhHGAxsBiQ0dbVtzoFHY+yMsXiIGg4S4RE1j8UkJTD3LK3netYnIpk9fzfo5ETFvIoEpAuRrKHA2l3JPezQtyZbIlCS2Rgr20iDTS6DCgYqApvGtX+RLwOmoYB9ST9LnNk6b9hTu6twYaHGEVwWtBehaeQYkWBubCTYCb/MB8y5dfc07ihd6aOY9viNbhVst3pGPrI0O5qQj9cjVFVnMDRpR3j97LwcZlKw3PnThu6b9scFotUTUTaG+BXRfua4I8KXJkqYY7Edn/t5C79cL2VdZgzoFC2lb69PdvwALPisO/qDMpmwySxkHbKWvy2ow20ZIgvF947SlL8Hcn8968TArg/cTn0he5FTUgKUPlVmpp0ZcVgfYGQLOFPAidQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2616005)(508600001)(86362001)(83380400001)(8676002)(4326008)(52116002)(6666004)(6506007)(6486002)(5660300002)(186003)(6512007)(8936002)(316002)(38100700002)(38350700002)(1076003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQaiAUi9jSS4rnHuren6Vfb6l29ek2s2biA1FOiFVlP4BQJFIfZMy+8m6pJU?=
 =?us-ascii?Q?ZAsRwdBx26zeXWxxPvxV32J2kFusVJTcz313cbpa2MgZh8GmWkklcyKoU4nk?=
 =?us-ascii?Q?pAwODSZj8owwiyu9YZcgOa6x6GGWUmHy/1j4c3bMrzVw5jn2UWQZGiIr4UDe?=
 =?us-ascii?Q?hbFWxpFGd9zNlsw4KS6+ehEbt5edXFpB+1az2wQTl/biv3RyShpClMwjCu66?=
 =?us-ascii?Q?6u1pYPb/pTT5eNoyIWdceRNdiLYDYKbgE/cVUPWnRG7+PmuH4qip7tRD6IvF?=
 =?us-ascii?Q?3qFCPskpHd47ZoqdnJ+qudRIUodYVfFZkVVwXGDYedSi6HJ+qNMxtj9x7oe4?=
 =?us-ascii?Q?2E3FOQZZWxXjrq+6i54CzpzVeuqaYWHTcvnHdgTjV61GvX5VJp2bxCSq2yMf?=
 =?us-ascii?Q?UftdstHcH0rla9/HiCfpqpjLyRlsZwnXTc4naHAqK8gIhBdgVUpkcadbOM1R?=
 =?us-ascii?Q?rmJiisVFyu8Yf5YY9Sf3eYMp2DAKSHl2mhY+7TKIDRkXCag5xV904fhJHmZ0?=
 =?us-ascii?Q?vKoMDRZXh7fFosOD+chMGii839dNX4BhFFX0eF4dNgGE1I/P0d0OR08Gj2EV?=
 =?us-ascii?Q?r2RdHlJDH2sBGb2604GpaFaJ2/c8VDjuX8Bm1jvpuQCYSNjLazIiOXMRT4f4?=
 =?us-ascii?Q?ZT1t8KBPqeorysSceiWIxN+gZlzPwD2+dsegk+VfKLWnC74wW24D/HRXF42z?=
 =?us-ascii?Q?3HDGnJk2E2AhgzMJHHms1BfEXQg9FUlnE8eFp+rOn+GySf46ExnI+LdpALWY?=
 =?us-ascii?Q?KrW0CbvACgavNpcUudK8hnZE2kl9gcKUecPrv3aBzHAPw6Co+T7bMnCca4hi?=
 =?us-ascii?Q?qIVY1TFhwfQ2bqaZC1g6p1gM0G58/wU2xCu0k/DdGgXBsIYLjit0MDxVGZq7?=
 =?us-ascii?Q?4xipugOxnEkpkcbD8aGo5DqIBWjHmD5SxkjzH2EJ9mLg2bxYDBjOZwWnJgV+?=
 =?us-ascii?Q?0j24Oox6wJC6J7nBkUYv0y8egWYGl8XIGyU55utPRYg/qv8ARNwTd0tEFtG6?=
 =?us-ascii?Q?F8TJ72PviFSQh6SJsTi5m3RX6LtXhys0vd6EZ3Y5bi6cK5T0vVobOPXMUw3d?=
 =?us-ascii?Q?7MjdVyeKYnrhNZhbVwFEcNboInhgh4t7upmGCyJvvpYwNM3Vi7KNyvZfw5UK?=
 =?us-ascii?Q?mSrSRVAnWmf/mP7BZh7bhFwi7yrvFLXfkJtTMH+6Lj8jX0vFkKu5jGAz/1KI?=
 =?us-ascii?Q?95TUae3zjzFxdMlh9EEpYmFl3u9P6criy3DCzjx/hxVO7wBmaO3Q0EHiMnPp?=
 =?us-ascii?Q?zsoofoquv7kRPeWUMfNkvw2YqqzD9On4TPOu7VY63jr9AZ5Zv/lj76Bjuo9M?=
 =?us-ascii?Q?mX6kV61A0amqVbwR1W4KqVc8a1SSJP81GF43+yyW+UY5atnj7MIUJfT+DRJ3?=
 =?us-ascii?Q?orOsQol+mcYNFNxw09wl1BXQgZNWoYUZU6eyqJs34yrcKmwKH8BakgwDAm4j?=
 =?us-ascii?Q?tebah2QUETP65e8T8UHDyKSFzVU0dmIEpNH0Gv19KxmKtN+iziDFJsIOs1Oz?=
 =?us-ascii?Q?/k6je2IsHQAqJHFufseZ1BCkpvtwjsBq04snya9htI1pBpIvli94SJB9rHvM?=
 =?us-ascii?Q?U1Lc0mOfHv96JWpMcCrmKLV7ILKbIyEWeNXQjdfGpChYgCYiZ+m48wgBkxTq?=
 =?us-ascii?Q?XIzioGqOocIwG0PZrujo3Go=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db6b19-7ee9-40e0-6843-08d9fa80f222
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:09:57.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcMz+/ne985REKwKDwWN8iYwRoOge2VIBtc6ePwBWK4HPkGsAq3BaHC6ONigtgjQkNVi8AVnNi7ioLqnrD42mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2902
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mcore_booted boot parameter which could simplify AMP clock
management. To i.MX8M, there is CCM(clock control Module) to generate
clock root clock, anatop(analog PLL module) to generate PLL, and CCGR
(clock gating) to gate clocks to peripherals. As below:
  anatop->ccm->ccgr->peripheral

Linux handles the clock management and the auxiliary core is under
control of Linux. Although there is per hardware domain control for CCGR
and CCM, auxiliary core normally only use CCGR hardware domain control
to avoid linux gate off the clk to peripherals and leave CCM ana anatop
to Linux.

Per NXP hardware design, because CCGR already support gate to
peripherals, and clk root gate power leakage is negligible. So
when in AMP case, we could not register the clk root gate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 9 +++++++++
 drivers/clk/imx/clk.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 7cc669934253..5d3ac59b382b 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -146,6 +146,15 @@ void imx_cscmr1_fixup(u32 *val)
 	return;
 }
 
+bool mcore_booted;
+
+static int __init setup_mcore_booted(char *booted)
+{
+	mcore_booted = true;
+	return 1;
+}
+__setup("mcore_booted", setup_mcore_booted);
+
 #ifndef MODULE
 
 static bool imx_keep_uart_clocks;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a7cbbcd1a3f4..5061a06468df 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 
 extern spinlock_t imx_ccm_lock;
+extern bool mcore_booted;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
-- 
2.25.1

