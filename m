Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F07537022
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiE2HKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiE2HKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:10:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682193479;
        Sun, 29 May 2022 00:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9tSyszyNGK9SyL77HpBu1eVGusCCyW/j23DH6AtSjiflsqZ1WVtahwU+5UA9dfhgnSxo9WLlvd40olEV0DZIDytbqcKyLWUY5oYvFEFa2m1/gwaFyv8Wp4MprXYlpkZ+mHUNA1xgX1Wd0jjKcppXJTGmGM9FUgP4kpayiE0fQAI13Nh/rJiylolpk9OJN2vZmk3h/xhjaxhEKinOjTJHBcycUOUkfcnJc70j4ytMZ9QcB+U5MIdb7vjHbCO90zeyfQAlIBzOmwGEtsrShvfL4ME9r1GOAVl1bKjqiexvdpbbG1j+uDNl9fG3D3SjaMmrjk2QWaqtsy2n4EArLRczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy+tvKxf9qczXyI89nRzX3G19xsC2ED6/mP8+L/2ssU=;
 b=dFKH64GhFuyN7XyBsYK7JnIjXvZCnEekDoAu/4/jbIkbWxyYeQEelvq2ISRdh2QopLfKFgCr87BFkOwLDKfG97YClnIWsPci3wsaVajZlbLfPmPE+rEF7YR3sDyILCkWcrC0x1N0GR3eHFDch1tboy1epmFrwub9pLuSv8+bCRxk/baKwNQCRdcH65e+MhwLBjfpaiwvnaXC6frQOG28aUxXteUeCiT25qtbpK/ymHgWopJaVVSrgzeKWnceqe26JH/+0P6u2PJ8uX/HYzvb2fZnIF431QNixhE+8tdP6d5rgAlfQO7Q51hsgaZoMDmOsrL4masTei4In8pHWzv/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy+tvKxf9qczXyI89nRzX3G19xsC2ED6/mP8+L/2ssU=;
 b=TXJV5OZc9qjHwUrzFylvPzk/RnPMLRmgNRRBypdNwI3eE2gB+2KjS2OOJKFlK7X6O41dYrTt4JFiSrqGTFKDLXZCrvncOtqzwZmSAo8iRL9uoprVW0/7gRaPajuFcqrwyhW6pwiAj/WgqKqR4S2KuynWKeKmAMkjpSvpjDwjJXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8007.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Sun, 29 May
 2022 07:10:12 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5293.018; Sun, 29 May 2022
 07:10:12 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: clk-fracn-gppll: Return rate in rate table properly in ->recalc_rate()
Date:   Sun, 29 May 2022 15:11:56 +0800
Message-Id: <20220529071156.2511568-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c57ebe8-7d26-4c31-621d-08da41424619
X-MS-TrafficTypeDiagnostic: AS8PR04MB8007:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8007C087D55F4D52DC5F2D3298DA9@AS8PR04MB8007.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jff0eAJGBQf+RhIFb8XbIgbztpFmELI/c5PNbogIlPVbkN87t24JnJm6B9AL0Mv9HAn6neN37QsvI4kI7ZfZM2bTQ7Ib92XlJObc1MhtxasKlgeffY3kJpyrCUCjGSbSvLwl68pFzc3zmIANhUXQZLIzlBBURzaipzMZ1mNa5UhpiDJ/FCjvJXSmhcDkzvf80KZfEZjd3578q10tvI1I7+MF3OoUgFZBcEsblHqtK6XsrKqbpPCufyyWG/Lbl7F1Zt6Ri+njr+orio2WYO/1Fw33XV82CWyKIzqkeEvDdlRlCEuOzMcCYTyYhBsrxgkCYE0tZh2p/0y5WBvuF9PqsHWeVgPwX6vOV0z2wiPfCQDqrSiTYehf0AduXDtvK71Pn+/jgyVudqbLHuSNNQbZWmDXKI6F29wxoAvmikOkNKo77r7LlnPm6OXxmGCZUd8BoE+p4bMkJ3Gt3gUItFIqaY1pQzeShPvdVJ1pVyMxPE4Z7kICD3lb2zLZwye/SiCqab0rda9w188tcf0jsEAeG/d77Y9aSvxMJJ6fG+ez4KTbUeSqLqzqD/cUY1U4XQYCpbZx+czuN2p11+8jSFsIvNXrtHkroNhCWxcNisdxN7NGFR0RabmzqIYOvxBiaGL2teCSPkLWBHo7Yw3C1fnXdPsgH4sY7Wd8JRngo8qm4swVDIKpg1lWrVmYBYatUyMzy6ccCJbmVa6ZSIAE9/pTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(8936002)(1076003)(36756003)(6506007)(54906003)(186003)(38100700002)(2906002)(66946007)(26005)(508600001)(4326008)(8676002)(316002)(38350700002)(6512007)(6486002)(83380400001)(5660300002)(6666004)(2616005)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7wS9IHuBW/qZ4mousPz/8mEyQtmA0tjIguRO70FdQSrZRp9HgVAZ/HPt98t?=
 =?us-ascii?Q?c8qcJGvVTj0GbkK9Q7MhdWrxb7+HmHZzS5RyIVLEc3hJxGpc0uIHayAG794l?=
 =?us-ascii?Q?wOiz07uo/ZQO8CxnEywNil/ajpOCzxA7Fl1usishnVoz7XiDfr2alA+sGm7r?=
 =?us-ascii?Q?PkgNxT7TaFqAH3pDHab4BnEdZTTfM0mr2WI1VVZgaRj34sIG65T/CVlRgRaV?=
 =?us-ascii?Q?xTMqqO/fI/k5T293Cw6ijZ9qc4SE9bGLBE3EBgKH8dmyDJubylJfJwvQJBtj?=
 =?us-ascii?Q?d+n85G3peTxEsz0DGIy9i0ktItvJ2ZlfswZ1PbDKG37F9v9r/YZRoiNQeIfI?=
 =?us-ascii?Q?0Hih1HemMiaUCMXzN1SEZ0Atjmv/my3M/terwrZsjiwCIputFYlQRAcf5iZu?=
 =?us-ascii?Q?+uXJzBbqsBvz3aWL2lADoro5+ATo+bhpCMuAbkhEiFHVJpiVh4Yrx4JZ2FjF?=
 =?us-ascii?Q?V3Bp5U3aQmPwnij7KLE1L5F3v8L7emC2UC+tfxtMjm5QGPAvW50A7RWmOGCr?=
 =?us-ascii?Q?V4UuaAiZM3dlnyXiikranbl6N7hiiFBqwj+DbYYvTwmBIofr167ScOXHiEr3?=
 =?us-ascii?Q?CkR5ys11xx9QuiNBtxdqYNgvYVihetInpJXIWTUfuE/0lECzR/Xc7FPnIYNW?=
 =?us-ascii?Q?DhovxGJFzw/bAsBvRfqL/hYIUdxbG3eQyQ2uBIHb/dM5aLSxO7JHDs8OpSaJ?=
 =?us-ascii?Q?j38oDkuT1OZxmvouwV043BlugEkadLS7TO73blCm85dVPbBH3WRL06z8gN4i?=
 =?us-ascii?Q?zxfDHmIGWcZv9FQcE8C43T1155N8LUjAbIoxk8NSWrHKdkfg/+Rp/HdPDfan?=
 =?us-ascii?Q?y0EZIngdRLREwEj3biMvfaOe5RBSTYg4MhZYZv3ZAGJmryDBqr1P+y4PRjzR?=
 =?us-ascii?Q?0eUYUc+2qO7oxrAYI4LKj4xJcHrnAEHsDuEc7lwf3+BkW2bqE7//YUbIjKZV?=
 =?us-ascii?Q?xfSnaBMd+elPWNPiWZJVOnUPVaMv5q4y08fEafFscDlD2RXXtimPXbyTz3/E?=
 =?us-ascii?Q?chwf1f+UV90BbZQI7d2bIu5XpPbG0d9Z0oPcMbuSWGqQwUf0TNh8QqzqV/jC?=
 =?us-ascii?Q?8YXS2xZP7LZXt4lutLRfZtpiEYKmzgEtfFy5RYy80lfnfN8q7B2DZzwHHMyz?=
 =?us-ascii?Q?EFORrOzs/eBn7vthmLBcE/KqQbwV7AtkNyhGrKNULEueV9eOk3vEV9aSzNEe?=
 =?us-ascii?Q?42gt+xuviP9mLzAOtToXQlm9Om6lBcK5LZ2xHvtoJ9azuCbc6WmTFZEiRkw9?=
 =?us-ascii?Q?mubSPkfD4Z+rIxpHkyHfk9TM1u8FfRolzEtN+hYcer05Krj82c1kFXNfiAes?=
 =?us-ascii?Q?Pq7gugaGyYax7ciWfXS4Lh2zCejXRZr6xOvmdc09h3BfLaq3IEsy716N9oQY?=
 =?us-ascii?Q?IugFshAPYnPRAjM9iTnfYNgAgMC+MlrkWzQeEjtZSg1mMFrBimaLw9SUEArh?=
 =?us-ascii?Q?I8dEuBOWcFgOvOeF3ks+oJA0aCqIJegBriCopWYpbWA5rE5shSAh97YUTCZB?=
 =?us-ascii?Q?RcHoyzvyq3RLe7AC/zsjylU6iCZAG4PT23bnDmqP1o0oj/N05ZtG+vIrfGeX?=
 =?us-ascii?Q?009q1wAqTsgQxGsmhliCFRgnG8Chdc14NJWIfDUUkuRLH1uK8RkiEl8wcMuq?=
 =?us-ascii?Q?QCyXVMjqkZw8Es7gU1owhB7D/eQ43xJ9wZywb2lfppqzxlmyZvxTWbp5Hl1l?=
 =?us-ascii?Q?KHrqdgcuf43t9RgFnXAjXZkxVF5TdcDQjzNeU00rf8d/bcTW8JZ8BCRX1550?=
 =?us-ascii?Q?48hxhJg7pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c57ebe8-7d26-4c31-621d-08da41424619
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 07:10:12.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZZJp1r/UcmOh9okxtlRa60VCJTMBqSVSircsAH488t2vS9ePSAIH32zKQ/HpGe7thP1RoSVWFzzLoVAb2WItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLL parameters in rate table should be directly compared with
those read from PLL registers instead of the cooked ones.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Cc: Abel Vesa <abel.vesa@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 71c102d950ab..762b07dd5a6d 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -131,18 +131,7 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
 	mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
 
 	rdiv = FIELD_GET(PLL_RDIV_MASK, pll_div);
-	rdiv = rdiv + 1;
 	odiv = FIELD_GET(PLL_ODIV_MASK, pll_div);
-	switch (odiv) {
-	case 0:
-		odiv = 2;
-		break;
-	case 1:
-		odiv = 3;
-		break;
-	default:
-		break;
-	}
 
 	/*
 	 * Sometimes, the recalculated rate has deviation due to
@@ -160,6 +149,19 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
 	if (rate)
 		return (unsigned long)rate;
 
+	rdiv = rdiv + 1;
+
+	switch (odiv) {
+	case 0:
+		odiv = 2;
+		break;
+	case 1:
+		odiv = 3;
+		break;
+	default:
+		break;
+	}
+
 	/* Fvco = Fref * (MFI + MFN / MFD) */
 	fvco = fvco * mfi * mfd + fvco * mfn;
 	do_div(fvco, mfd * rdiv * odiv);
-- 
2.25.1

