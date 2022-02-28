Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC38D4C62CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiB1GKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiB1GKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:10:44 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EE6007E;
        Sun, 27 Feb 2022 22:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2zGzutq3t9RdJMeUE+rqHE20o3kmdED9OqxZF/9AiBUNta6MdBzqpG44yVbhdiVECeyS4H8eZ7xPKFFW9RaW5+k7u87cfDy0atpK3riVRinC6RqLEQEbVOmD2123xlirFOEzQ7bnxd6Mw788wZvk5z0czyqR2FUoCSAuqRciKkgvCUEbAqE5kSG3CGhp1yg+kjV41Y8x5rG0rQ/y+1a40y3WOkEyXIH7NPXpP87yaBAU8bzqHRhhhIzYr8zDDFOb16LiHPKiQiV/mQ8fp0v4LsC10YCFZS9TBppEdO1LoCHq6Me2fevmdvNNigOtl8wZOvn2Mk5a2KVgxkBRpsEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhXno/c4QzPBpAYvEf5vof4xdAAowndZ5zT5fGuee/w=;
 b=Wt/XTgyhC1tALYCiOzVBIebEXLWT4tlfKxHy9wR4rzl9abc2wL/8W9oBwjUJ1hcRqIglZS3kUqVdiBoDqE69oIWI+Zrh1HS56a7rJSkFHF+Zrhz4QflbTVG/T+acwpZjd88AHAuyJEDgzf2bkULTqWjrRqespHHri+LzPfcomERE0TEnGnwL1j9BoyMUWY5OPgRIgW7sjlwy66L8qBwAEMAL7cvbK7LqJB35fOcwq4/pnRfdS8LS4YPVVExXwaRTnzj8S4k78ZIVzBXRhVNRVCJjjcD8vx+2QoGi8FDB1oxjsYu35OswTN3/zVdrAxFl9cd6eafvJDuzjShPLP3LFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhXno/c4QzPBpAYvEf5vof4xdAAowndZ5zT5fGuee/w=;
 b=OcJThCKUtRtGcD6mmWmLWkYuEzAHBVj1vOkh9LhYFmqEEYd6tvPn6ia8vveMk13xYxtX4rE/MCbQ6rvJEbhZQBf/qOJs6GMpL52b9UoJLgWg3uODBGncVtjWTLrGvj2qLShinpG/cl60zJIWyfSzO078qttw+Ln/MDcRX9JuHeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2902.eurprd04.prod.outlook.com (2603:10a6:4:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 06:10:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 06:10:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx8m: check mcore_booted before register clk
Date:   Mon, 28 Feb 2022 14:11:50 +0800
Message-Id: <20220228061150.3006113-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228061150.3006113-1-peng.fan@oss.nxp.com>
References: <20220228061150.3006113-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa2242f-62a8-4a17-bb6f-08d9fa80f4b4
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2902:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2902290A9CCFDAB71F466392C9019@DB6PR0402MB2902.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSTIrn2q6fEA9ok3JY4NuANX8lKnqywuOwjWLzHs3Z48Rpk0M3ASfiz9YiLGDAlOFOUxU2SX+GrPABpcP7rz5eI/DsucK7hiWHboBwX10bFDFDJwHVp91i7J2agE/4E8QT/9s6Lv5/RMVWt0fbdPwibv6sO8fKjCBrOf9Xre5ApI5P7PW0G/CV0EVZwOk4xqsuzz6YkILDQAf1PrN/2/IunKyGvrD8RGZS4ixsyy6TVLCbNci/mnp66AoPNjlImdM5BhoXvZ3mqry3RNnrnhEQCKKIsmrMuwn3NDFQnZwvB1yG9GwjxIguFzuDOeN04x8cn/03+pJPmuOdeg8qkPWGoQu9bwMUupBGm1YfUPLfL3+Xuwa4YKLkLSbltFFS+A0MW8BMKqVIWkNMvMPxQhNbQjriCR27FHFOsorCgUjstv1TDLmcOFTfUWGHP2QePTRWZK+lGZvmQ5500PqEmVjqCXokBXQbA17tKtGfz4UT35Nk+fTHJ+SRxUvDWsM/RGwksOvICH+pNntwZiR8rSbKAYS5Zh9/fPGQid2Q14TbIX7Ne6/fM0Qw8cK9qP1DUiMzxI05cGAZTWJa+zT4+wEJ+YkK+eOdMsSo/o6hr5Xtd5+8su8SZsyqqDuEeDQ7tPoltdoz23Z3GGoWS5Sd1nQSRIcw5CyReTsmtq5Fq4udnD9fVsZvprw4gg3s3mn8kJevxTyBRKaBB6BnBtFsm7Wj47DgBz8SorUv1o0EILlUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2616005)(508600001)(86362001)(83380400001)(8676002)(4326008)(52116002)(6666004)(6506007)(6486002)(5660300002)(186003)(6512007)(8936002)(316002)(38100700002)(38350700002)(1076003)(26005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wO+Y23Hw6RglHx2tVquX2dgBHnNJ49KHX6LrnGoyeFac0DlBrR7Kesb34Ccj?=
 =?us-ascii?Q?pT60+QElL4xkWjKiCOSfLptw5kFnNvnBRkKdcN2QD4F/pMshww/xuIF05OuP?=
 =?us-ascii?Q?DogQitIq5nKsCPMQgIObAf894womahSpX77ikF0NiO4BrhIGS+JwbFRtUYoJ?=
 =?us-ascii?Q?WarzZ8FKHhknwyELb+dm9LE76w7k2NNH32Y0yRZK0aG9m/DoIOWNcwrPiPmV?=
 =?us-ascii?Q?a/cVKnYFZohXQ+zdosdS/EQpJw110IteLY1FFexoJYNty2ymHubTGss9Blg+?=
 =?us-ascii?Q?sM933C/DZ7OohK6hyTZwrTpr8vbvCn3hfXk2N6JzA7B5Br3UnlgZykPH+pyB?=
 =?us-ascii?Q?nYnf/2RntfXOwl+ZByngSjJVmWmx0z8NrfdIajkyM2+IjzpXObK6nrfqfs0o?=
 =?us-ascii?Q?eZgaZ9wr7AJ+SAOQ92YwNfH6GHH187+j+d0WDBmdBWErX+uO0FZVNhtmpjWO?=
 =?us-ascii?Q?XzK/2c4vhsXFX2Za6qeuMhAm9xBtKh7pLJm2PsnelH8n7UbroCq0JVuN7pZm?=
 =?us-ascii?Q?MxfCqn1o9+0f4jvlio8DDrg8qDlgDFa/lafGsyL2b1Z9cwmpAcsreSqBOfeq?=
 =?us-ascii?Q?d/xgFuO1O5qc0V28SE44rZs2txqfLLL1+Q4AwL8cN+sJFJBOmqHOZBqxJjdf?=
 =?us-ascii?Q?hNN86fZkZSqC+PSWMHEo3JPBponhkuvsreDjn0KIE6vst5wtRtjSqCZztRYA?=
 =?us-ascii?Q?8aWi/52vYCwZhpwi5kMR45GxxzibIPOytgt7iwAR+otgn7pV5m15oIsj3iZQ?=
 =?us-ascii?Q?v3QFqv+Lur6zGXtqrqJpRVZMUcmY6eNJx8CAcsJ32H+2mIooBxYu78rHyo9p?=
 =?us-ascii?Q?CUC4kfQnDrXRBqHilR9Jd/sEs+bFz9ACvKXH0KWSjfJLDPMoxzwM7Fmr5Lj8?=
 =?us-ascii?Q?g3B7I08UGqo9vXHOly8WjodqM944uy/3q1hRfRhJTDhEuWN6oMFhGkGEqtiR?=
 =?us-ascii?Q?EIPLk/UQ6ua1MFIF26DoaMBBHybGLRBtkxRhU+Fwt3S8GNDDHgU8+PC1Hfnh?=
 =?us-ascii?Q?yalTFNAQYe27sj9wN7EWmtdhLmgVIeKDEc8g85CqotIVUV/xPoJYclX+pLjT?=
 =?us-ascii?Q?UOSTXqjgpT6ToL6wA1sf7QCIU47rLRoL+/zRElcjkhkAy7qcDWt+dIi8Ea1C?=
 =?us-ascii?Q?cQ00NegylsCL5+bGDCOdzlGsb0nUi8XxdLQXbLq3Hl0hRoejLixZ6cGJE+nc?=
 =?us-ascii?Q?6d9r6Qgy+PJnEPUurE6i1RUCfxGJfjmg50IQPfmhb20kE7OcMyI5mXpt3tYT?=
 =?us-ascii?Q?l6rO3x1KFlc1BBYq1ByRKr7h7A24EojpE665CwdUotCgkFywW9SW8CQrnnmR?=
 =?us-ascii?Q?mbED9unv06tIL9cBJpcTZSmzpRzZkcRY6sue/KahNxilnu+Lm1jX4OF9r7gO?=
 =?us-ascii?Q?sy8pYYmwYqUXYyFJBj7ClEt0+E0+UDFVGkmMoKiJrAACXUEDvnVQ0ptMJnux?=
 =?us-ascii?Q?2HkA9WjknwcEm+qMbo2nKbZ8M16sV+LRa2MXtXpCGnv89/g8hoFqRoc97Thk?=
 =?us-ascii?Q?2qBKjPxGQZ502Wqm7LLReVS44GgfVztsQd3R+PlrYvPw+1lnpaT/061aBo0K?=
 =?us-ascii?Q?YqXZtUal2aT9k1/BMYT2PVd1ENZNklWAhxGUIe45AcPv3RxPAboWB3/U18JP?=
 =?us-ascii?Q?FrRyXINWKf3JXk7gOjuGThA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa2242f-62a8-4a17-bb6f-08d9fa80f4b4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:10:01.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1XxZ0Ji70706yhpPqgUJ88HeasRQrHp4oZQ/iJ96Z0Psp36z+R4VXPPjLuKRZUjJFhT95ti1Tzwx4ClkKqz8g==
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

If mcore_booted is true, ignore the clk root gate registration and
this will simplify AMP clock management and avoid system hang unexpectly
especially Linux shutdown clk used by mcore.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 If this method is acceptable, we could also use mcore_booted to choose
 to register the pll gate in clk-imx8mm/n/p driver

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

