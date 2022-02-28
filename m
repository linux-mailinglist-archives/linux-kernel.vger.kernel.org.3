Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6D4C6CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiB1MkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiB1MkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:40:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041744CD52;
        Mon, 28 Feb 2022 04:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9LQmgGr7LFVtUCeDDlCCoQU9BsiRfC5g5uDJuRvhMlwYBfjZZTPsG5Y5Bm/d1WYzSND71WjSrUZMG4DaSjkNFyA3O4xmpsLfkFiWSdxmGQIjiFqOwX1yRwIfC8F+kJ/a4hj7CEhKhudnOxaRrdtwzEetW49GpYKwmgMOQMVEMxUos6YgmaDKXDAwiI9pN/chnYqxoHJAqvJ2XhEsBshoZDSulLPFa0sRe3kDYyYKCSV5lphQ2dVy2g0pI2MLlwgWC6palruQxOpQfpdsd97fRN3S+HKDExF4OOXUHP6TF+7hpyJfID7NjDuS/CmcK8PpC7BHv5L99xksbjlQZciRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5zIo6CIP5qpjNYR6VypQ62DXVIpQWIcdZP0ZpH3V0Y=;
 b=MR44+IMy8gUiWczz8s6N9OUH6QHuO1KRuOtsQhwwcVqGCDlaDhtQM638Hof98UQ9IeIqOsxxvy/KulC067ouKRsZConmR2MJUmWh08kZLZJlTf6msnbYZINrr+Hr6fC/sKSWMQnHnD8CElJBn5biXqktkW+wVV6SLTtTIR9UWD4nym5trUofwgaJNbMZ6ys6UzRIil8sA/uazF4/zi6q4dcY6/sNzNrwHblOKOl3ggCrz/4VYv8RD3z4mQtvT4VzJ6O6r5OE76I0W+YOOzMMeh1ctyuEZmr1qV2HdH6HeUrutV93BuKETyBAD+kpSzfnbqrSkfrxBs7TMbHD2jlzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5zIo6CIP5qpjNYR6VypQ62DXVIpQWIcdZP0ZpH3V0Y=;
 b=X6SZtEdyhNl3TLZtP9NG8R/9pqSnWeFr6grWk3y9BVPXI3+LEV5uJtZTeXy7+MXF39LHeNGJzutaP8w+1xA7G4/WGSGh5k3jroicePao40SYz3M2VfvvxaxnaLWspIhOnLZ7XWyQMpg35G3nU2CubF9SYq2s6y9b+1+afN5+deU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB6384.eurprd04.prod.outlook.com (2603:10a6:803:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 12:39:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 12:39:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register clk
Date:   Mon, 28 Feb 2022 20:41:12 +0800
Message-Id: <20220228124112.3974242-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4083fc75-4b2f-4620-7c2f-08d9fab75936
X-MS-TrafficTypeDiagnostic: VE1PR04MB6384:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6384D13F590F333D67F48180C9019@VE1PR04MB6384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yWiVsHiz+9afNZPQPR92kiFakEM7caKTLgw2hLgZZbeDH4phxnAZz3OavT0uNGms20jEohs3yIXJX7GGPdg/JA6WQkxGtXapICuxnbTtqPQmUPnnozcnBJkOcv0Vgcf1xMMi2NQgYGdHonAYYTVkoWWqOMh7IawekirBqJ1kDbqQxi0KD+yJWwP3B4ikCnYGutK7ep5GUcHsA4G5nF0k3+3Kkat45M1/lELlAord1ltx+6Hbu1vGdsuaPYX8tTXigSb3nN3ElKVwmspBGmZ9DOZ5cBZHpAJMjI2eDp3x36xw9zH0X9UyyiVNv4O6IK39dWQf5Pf0zM8SvGl1W11lkTR56I4v/4S+irBbEminyydfWGRaN9aqKp8FFVXTnGE66sYynSJv7C7DV4nlV3s8XHq9h3jeG5ygewv66uAEdkk55WbEqCd+fc/x8fPbs1/QjGdHGVkCGz+i64Cj00SQt1iAp15km6RxSLUfqi2AHNnh55rr43AtZLpMZcN/m/gHmdOwI2cIbNH6hrot3ZI6h2JUcJDnMq+1unVeT4eULfvH8h3pyuJf/EBZIMIugXd+fDH3BAomGATxL4rAzkwKEYGrXcxbyoNhj+ZNre/DsK5+XrdBoDEKEQIHi6e+yu0M0VJ+r1cAwnZsQUQcLph070YT9adZVWOfHDa3eyt2O0U/DibmVsCB+tQqwgdn8qsDDA3m4CBskPuRIaKk5jIre8ZBCwshcm+pfDZJ7sehVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(2616005)(1076003)(6512007)(83380400001)(186003)(26005)(6506007)(6666004)(508600001)(6486002)(66946007)(316002)(8936002)(4326008)(38100700002)(38350700002)(8676002)(66556008)(66476007)(86362001)(2906002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFi6yQQELMG1eFksMDGeiAx/r57B/9O45ljHMnfsYeu5QWXy04aAzHzjJ22c?=
 =?us-ascii?Q?yJHm29KuxA15vrFIILIts870QLoNFXAhf7TZOs3VoeD1Ls2YyLfZKMkTVpcu?=
 =?us-ascii?Q?dyotIMw56FTn5T1kei6As37k66W2v0Xubgaj0hyU6NK0dyhHxZiv5wQXqMrQ?=
 =?us-ascii?Q?hqAdavWe/BbTvWY/Iwah2/i7n7L437JXAPhqD5OaRvjWbloUZu95v1/jOdzv?=
 =?us-ascii?Q?ohwZSVCykD77MRLBxbvxvxAef2mSGBnrHRV3VKhi+oQztV0+hdlmLiMQp+UK?=
 =?us-ascii?Q?eGkUtR+NZtQ70UrzVDJxkb7u/yzdR/NinMttnqGCNcs7hy6HjmbnHT7MbskW?=
 =?us-ascii?Q?/7C4yZazE3y5eLk53RNpsowUxig0N6Z9Bm6noaA3b99PxYsNPkG6kk9jAcnj?=
 =?us-ascii?Q?Jg4L7oNy2OXMNMzoeIVa0ZT9aZr4HjFO6zKtRAvAT0nEVxvpLgP3GQNSla5J?=
 =?us-ascii?Q?c1IrSmQKugK9+TewKpRPzIhfertA3xuwUPb/vi7HEYXPR3yLVgGtuxQtyLmP?=
 =?us-ascii?Q?vDoI1eyiuTnz8XnC2czVyDZigqL1oUEdDQGcMt6qe2WdoBkJhH19ytAQ1wmj?=
 =?us-ascii?Q?GNs35mXdyejaqZSrZCO+eN8SYu/7u2RuXCHoxdLOIToR8x+fVOhffcgzHpWM?=
 =?us-ascii?Q?4OtPyiFiJ/HG+v2T2TY8ZO1WFiU0NLyQrUWeksjShKrsK1lz+kX5wFCsp86F?=
 =?us-ascii?Q?FwaKH7vOdq9+oS/cOeenVwpdlZSEpIAJ9IbbdMRSEKgI8VGBHrBSDOgyex3Q?=
 =?us-ascii?Q?r/29vMR3TZZLj/mbQr+MMQPArP+09c1su8LwoP3GldjfTR+ttlnRA1rXxW1t?=
 =?us-ascii?Q?fmXz3h3u2tfLJCBqmU5dPUH3Wm2pRCtMQGtSoHqxBx6rZIr7aqrYlfF/mel+?=
 =?us-ascii?Q?zdFtojP1TnsEHihIDm99FrkQCe7ypjZTR8ZA5yLzfbBzcR6g+NuOoDky8yWc?=
 =?us-ascii?Q?N8QjTLPfRqFLnJ7GI7mvKgcZTvEkXUXd/x+x81RobQJlNsFdP0+kDeHCx7w9?=
 =?us-ascii?Q?NrVrpGIM3qwU856pBEQel/jAVyBZR+vpKaz9KDHGPO8dM7lxri8QgbE0NAqq?=
 =?us-ascii?Q?uAqpSm9KsmLIGqytzk8lQDHjCZNEGyKYfpjNEXnxlIGoHKd0ms0poA9zqhbf?=
 =?us-ascii?Q?91AlDgRIccOxQd5Ej0NAkBcLkWwlNtTzs/c0NNHTHQePYjZM7L5zDKOs859a?=
 =?us-ascii?Q?v2x3fNdQqD7EIVANCuDbGKid88nnsRdsvS7iLG2YwUOExAf0XkuPtaVARJC/?=
 =?us-ascii?Q?RFZFCoz+ePVRXJHjXYvI2uEQ2bFlpY+C05uWRnOBwqEBVN4bhKHiIIEchfcl?=
 =?us-ascii?Q?KteSwxhEXZitV0mjyh6z4zSenQpuzJtTFbNLmazwyvTQTt/hiolEPaq5Tovl?=
 =?us-ascii?Q?R7HdZ1uKtgcXVKS8OjW8l0pa3lk/aWtiTd+SejEIFuSgglkwgv7RRVNujcxI?=
 =?us-ascii?Q?NMfLKqdXwODuUvrot53R5obglu2OnuNAXGfZCJUf1j9c7sEXMG1CqFTQgZeh?=
 =?us-ascii?Q?SnPQcE+1fWvjA1pIlyYSOWvpY94iVXqea+FOXY+Lqle3zbzMGToygp9DUw8m?=
 =?us-ascii?Q?DF1oLs6kwbxxZTeNwolzXQ2CB7aOzFGAIwlYYpjQduJj1cybza8/ndfLQVOQ?=
 =?us-ascii?Q?IYdy9HgyQLTGwu65/ePwkFw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083fc75-4b2f-4620-7c2f-08d9fab75936
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:39:23.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN53XMjrHi+o6ZXeN8+DXFsScALyBMWA5L5Okq+m2VuAViGHNQ/kgNhVRVmljsDgSS5ZrZCAV0pcXTJIArmLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6384
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If mcore_booted is true, ignore the clk root gate registration and
this will simplify AMP clock management and avoid system hang unexpectly
especially Linux shutdown clk used by mcore.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/clk/imx/clk-composite-8m.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 2dfd6149e528..b16c2c0ea9f6 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -223,14 +223,19 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	div->lock = &imx_ccm_lock;
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
-	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		goto fail;
-
-	gate_hw = &gate->hw;
-	gate->reg = reg;
-	gate->bit_idx = PCG_CGC_SHIFT;
-	gate->lock = &imx_ccm_lock;
+	/* skip registering the gate ops if M4 is enabled */
+	if (mcore_booted) {
+		gate_hw = NULL;
+	} else {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			goto fail;
+
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = PCG_CGC_SHIFT;
+		gate->lock = &imx_ccm_lock;
+	}
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops, div_hw,
-- 
2.25.1

