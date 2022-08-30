Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14D5A5A00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH3Dar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiH3Da3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:29 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10082.outbound.protection.outlook.com [40.107.1.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF06B162;
        Mon, 29 Aug 2022 20:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNzA9HmRY4YvFBCulrXaPMTP/X5lKCp+QRCoq7KFvm7UKVoxXYAFrZVwU2Hc22F6IUZ6ysy0cnzK32lEEZ+itiISVw0Gp3MI6bJmNLR0xmgBBg52p1LrUjLuOSQVvaKulzXzo9rW9XnNKv+6FrM/4sz5q6PfXIsBrfsItWKEP54/qy1nQ+Q8yztbvhkbaset8PenrPbBx0l4ZgZzDmlgrD0UVAkUz1VwNN3gK1Y3JGrjgT1UoeB7OUvl9TPgtWeDxL2+/a8J4eWCnhgWxxvdr848Z/ddtErcQOV2NsahamZXeri/It86Ttr/VGJVGuv0wCq6C3+/oo1XpqBWo6oN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32kGsytcm/KC6GjyETlExBYBe79w549bCZaIkKOiPE8=;
 b=KlNHFud7nUNYFjtoDTIlhM1IKvBaZdJckr020qnt5CweCLChT87KVtcyzwNBIffziV8zk+8VYIUvPbNfhyQ4u8DOmRcubP/zGN15L0clQc7HhIR2/0HDVe6G6eZ0onL5UF/rbVC7zdmjjW/rESFZOj/JSfxljNzPNYyG8S9U7b9IHYjiS25V8cif7GIzHnosvglFvPBLlMQZ0IMGo94qbTiP+HASohaCdf4i6DoGTgpHX/Fws0CmOmtXx/FTzeilDnGN699PxnlcDCBYigqTH7kFzNMC0mDBYWxS8Wc68iqnf/Tn/Ooo6PcntjCutbM5nKfv8W4rvmLlpL67iZTt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32kGsytcm/KC6GjyETlExBYBe79w549bCZaIkKOiPE8=;
 b=A9F6Nd+0IbjUBUma8p5CYjagbxdT9z4vz7xCAp3YQampLnnV849jZMSNqKKI3ZQjlAN5zCAefO5QuTdyrgN8PeAO0O5nMbZngvbtdZOfasLfZranEjlULs3kllS2JWv/lscWoOp5YaTH/HQFjEK2XbqZ6G86HHQ07L+A/rO76DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 4/8] clk: imx: clk-composite-93: check white_list
Date:   Tue, 30 Aug 2022 11:31:33 +0800
Message-Id: <20220830033137.4149542-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 258f988c-b62a-42d7-f1fd-08da8a37f7dd
X-MS-TrafficTypeDiagnostic: AS1PR04MB9359:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGpyyhEbvc2SfHnZ1oe5c0k9bdLz8Fao7WgjINzbp8I2znV/Jj9BBs/PiJFpZzdi0nsOv0aUPpmZ9L6RA/BNoSoeKt1kFYs2vJ+uF+6l9YbHGMLVbz1HrIV/p/eegBNiy6bKJ87eji0J+HMu0HzJVy+PGzk32lYzeZgrcRZLZsXPs1ETwkVzCjedI3cRUr3u3CpAXjGgLP32gDvEUiTb0vaZUah3bMsMQZW8Zgs7U+Tq1lyLiKoSBEsKzef/3t7DK3gv/y8d8BsZ8ZjKUlcL6WN5w5zZCpn8LfdoIJS8pGk39nx36ARPP+EIki7kBhsuQf9SwS1zd93IyPjDBm1fRkA+YXVww5nsDn4IO6wGoZWwS5EnjyjWK2wC/5Pt6qPNSasPeAOWng2XS9y64LQ0KZe2iGjD3DqWmzJBpbJke5519Ofs4wGG7Ts+sDLH1pYfX68ew8TnuxXxREzeukpX1aSljF6sCEbRN1vULu7ZNKTtkB49CUSeD0rNI072LHs2WRFSJ+Xa6Z+W4YirAQ7f4CJH0in5xwZK12n1zFvEHJ8pa5VbCH1qr4eN1yjJ0147ELAzMvfXEO6Asfr9LFYEazZTm1u9S8r0kdMJ6mAnIqxzRpeKKUfkuC99heczdeSLMbWtvtay81H8AgaTeKdlrhrzbojP/N/e3QuR/hkcBzsTWuG7Wn/Xkyi5NdNtjhwGH9tSb6XnZT5fefdXkXloPR2UTUrVMj+gSKUhPIDfUc6U4z35I6z8pLsVpSxKUyry83d4E6Ivk5SjgttePVsX9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(4326008)(66946007)(66556008)(38350700002)(38100700002)(86362001)(83380400001)(186003)(41300700001)(1076003)(7416002)(478600001)(6506007)(26005)(6666004)(6512007)(66476007)(2616005)(2906002)(54906003)(316002)(52116002)(5660300002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TC1GiNjftjI9Oi8XlbEoLjQWCNGtU+9kH//Dn0hRsQ3aQA9WsseLccwhIKWM?=
 =?us-ascii?Q?af0F131tTaU6qDrsgQ7Kf+hz22gXl012o9yjtmoSGKzQpN27ByqS9r6Z/BRJ?=
 =?us-ascii?Q?tTsigkqNCRTJVKaiQkS2RqET9uRL9fk24NLZWflOMkHe3PkAAogncK6bg9T2?=
 =?us-ascii?Q?74nlamOG4I8FeeL0k01VxStBsvTbV8YF8tBWV9emyoqHqLkCyp3pjZo267xO?=
 =?us-ascii?Q?Vz5HjXrUgmZxXgNYVm0Ek55K82O5TLvZ5kfWspX/LbgZTfTBkUw+66wIQnWr?=
 =?us-ascii?Q?lnLYa89VDNBtIEWC2e51P0MqTb/LjuzdQOKErwXuXa7Zy9D30FXvzlJ6F899?=
 =?us-ascii?Q?LQrcAyHnoMAPqMN698GWan4dTOzC9tkQ4N0fT7RZDx/zo3h3Tp2SWl9SLsFF?=
 =?us-ascii?Q?P5f7RNzAF6SAPvIQoARlr+xH1vgUFbAo67UtaIbZyBWXYiLzlq1U5L9979uk?=
 =?us-ascii?Q?FUcAwC1j7rycIlQagh7fbpqLOrPR45kM2c1iTPeAa9R4nCsQ/RGKLXdGFs4V?=
 =?us-ascii?Q?vMiw1cYgqbTASGsyPPprys/SJ8w2k7OO9HP30NAsFP3KbUNY395VY6V+yg1X?=
 =?us-ascii?Q?rl9QBxqVLd+otkBoOZhPF/YOI6y2fDOsc7/+z7Nh02PZkyuYWwSRzawrniht?=
 =?us-ascii?Q?Aqk7AIpSKXTl8/0Iq8EJJCDy0vzb52gOVqzcei87XpgpZswJIQhwxHFYWafz?=
 =?us-ascii?Q?GRRBdkBgl83jKur0m3Mz/B0/gvWCn20DRhdGFOXYoieo3lSyelqRhnZvyDRf?=
 =?us-ascii?Q?L6mde4yayfltVg6d/6+OdPYkxuNoZ5UzmoWESuHAfsCiSEpAd0YdIesxgyu8?=
 =?us-ascii?Q?eJGEb4fwi3lwUcVjwmFg0TaKPl45mHsWBgXDKGjnNzdS4T3+T0HxH9SKVfwM?=
 =?us-ascii?Q?yRVjDGrjX5Ddvd3u6vZfUrYrCMuDy8pAFTItlzcCEKt9JQpinmSuGkqlpBhu?=
 =?us-ascii?Q?5eu2KqWULmGuEqdpT1MnJT3+d6zxDIVv1+JZICoXJKESycw2McGLWbX5o37p?=
 =?us-ascii?Q?eaXmVn8ng6zY97XYEVpMrBtO76S2T/RfBHfh0f3V5YmGrOdOelAdyTQUvcrh?=
 =?us-ascii?Q?A8tPlLLoaVbl2uZPJQh6gDs/TIFOJvZSifVZ2/MTxrxc+45JUu+/skL8hewA?=
 =?us-ascii?Q?Z+QM+v12VWC8p/Gr6e7mQ+jOUj8Xuz3XW1SL4CuCcfV65WviNSTarbawa6gF?=
 =?us-ascii?Q?JfRBFIMWXzpGU9/r89uH3fW0t0BLEc3O0mSX+IRRJkvJ2cyNsp+CPoUwIKBX?=
 =?us-ascii?Q?RvOM5MXBrkIKWjoSA64hAy3Dm80J8b/Zam+3Ivq/0v1ZhEm17nEAtGy/QXpH?=
 =?us-ascii?Q?2FTTKcpKZTjlh5lNSAT4+95/NT/MKSh+MDVD3nboaUmx2ykNo02W6BTlYa6p?=
 =?us-ascii?Q?lAYK2vQ23Zhwlp2Ey0gQbtG3yDflL3rB5jOfiEw4G7fBkuze4VVgu6bTb8lA?=
 =?us-ascii?Q?vMEbOcl1icCmmDAMXhccKDk6JOHYZWtf5VBD0yqKFOuiGVkn5l0qTStmL7ry?=
 =?us-ascii?Q?VnqkZdpQ6kgPw0cESI0FIcveHjlYje3Enz9LjeJFFKDPXxVRORUmlKwK/pnP?=
 =?us-ascii?Q?XLXxraMQxhrg9y1LTqfo/8zMC7fU733wDOeM9P+h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258f988c-b62a-42d7-f1fd-08da8a37f7dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:21.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mcpkApQUKTov55Fe0MewFuDaxSHOTVy3EZz1U9lxqe+wpqCr53xsZuGy7SivEl0iBk26R8Jnj05lFbjZcYgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The CCM ROOT AUTHEN register WHITE_LIST indicate:
Each bit in this field represent for one domain. Bit16~Bit31 represent
for DOMAIN0~DOMAIN15 respectively. Only corresponding bit of the domains
is set to 1 can change the registers of this Clock Root.

i.MX93 DID is 3, so if BIT(3 + WHITE_LIST_SHIFT) is 0, the clk should be
set to read only. To make the imx93_clk_composite_flags be reusable,
add a new parameter named did(domain id);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-composite-93.c | 8 ++++++--
 drivers/clk/imx/clk-imx93.c        | 2 +-
 drivers/clk/imx/clk.h              | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 19f4037e6cca..74a66b0203e4 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -28,6 +28,8 @@
 #define TZ_NS_SHIFT	9
 #define TZ_NS_MASK	BIT(9)
 
+#define WHITE_LIST_SHIFT	16
+
 static int imx93_clk_composite_wait_ready(struct clk_hw *hw, void __iomem *reg)
 {
 	int ret;
@@ -180,7 +182,7 @@ static const struct clk_ops imx93_clk_composite_mux_ops = {
 };
 
 struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
-					 int num_parents, void __iomem *reg,
+					 int num_parents, void __iomem *reg, u32 domain_id,
 					 unsigned long flags)
 {
 	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
@@ -189,6 +191,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 	struct clk_gate *gate = NULL;
 	struct clk_mux *mux = NULL;
 	bool clk_ro = false;
+	u32 authen;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -211,7 +214,8 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 	div->lock = &imx_ccm_lock;
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
-	if (!(readl(reg + AUTHEN_OFFSET) & TZ_NS_MASK))
+	authen = readl(reg + AUTHEN_OFFSET);
+	if (!(authen & TZ_NS_MASK) || !(authen & BIT(WHITE_LIST_SHIFT + domain_id)))
 		clk_ro = true;
 
 	if (clk_ro) {
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index dcc41d178238..6d9cbe26b2fb 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -293,7 +293,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 		root = &root_array[i];
 		clks[root->clk] = imx93_clk_composite_flags(root->name,
 							    parent_names[root->sel],
-							    4, base + root->off,
+							    4, base + root->off, 3,
 							    root->flags);
 	}
 
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5061a06468df..396a5ea75083 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -445,9 +445,10 @@ struct clk_hw *imx93_clk_composite_flags(const char *name,
 					 const char * const *parent_names,
 					 int num_parents,
 					 void __iomem *reg,
+					 u32 domain_id,
 					 unsigned long flags);
-#define imx93_clk_composite(name, parent_names, num_parents, reg) \
-	imx93_clk_composite_flags(name, parent_names, num_parents, reg, \
+#define imx93_clk_composite(name, parent_names, num_parents, reg, domain_id) \
+	imx93_clk_composite_flags(name, parent_names, num_parents, reg, domain_id \
 				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
-- 
2.37.1

