Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896A6571455
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiGLIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiGLIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:28 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20083.outbound.protection.outlook.com [40.107.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647DA23BC;
        Tue, 12 Jul 2022 01:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNX2F/ZjnwP4QBYxbfcCDALHRHDFiI+eVje8X6cSIPYlPSH9EX6QXFANiFG2eLHMvZ/i1/FcB1GHjXCKQKY7CgRkco4axzQOz2Li/s0pxC24T5GYBHxR+XDez7OwATUZHVSt19RTBkEksMpyrKi+S0YRbRk4XUx5P1e4q+Hg2YGYCOwWnQVR1V0kjUTlm4CRV3/7e7RV6LOQHaf/SbBziyVMy8fGFZ/Rd/AUsRG+LEov5P82t8/BlX51yHc7TNL0pcI6aQe8scSHgArB58fusFnfPmZJqV3ONAFz4nUkr/YYEeZeZGNCOc9wOnqllWxadjPw3TtDB/AWR7h9Kv630w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=Bm0L3ITDvgk63a3hD20UxMa4uROU6ueAs0tACS6qN2Rk3fHNHGcKaqHZS+6JQF/7X1cPkV3aHQTwBSZ03TFqpsUYPC5TszLrvucOukvSahB0Lx8kqsfZHeon8jDCrtfdxwjVXd3TVkbREuH+VBAQbiwOk06iFg/B9KrjLRRdE1pwL0eB5u9aTDmnEjnYmFPU+J8U0phrQ9NHPUgoDc56pgkZCpglvYNMz85XRV5YjsHJ3b+izg+vxmRbfWXXYogNobmlKkwvE3Pk87vWjMWMmOFxihNQUlL9sMUn9JoJxsitDV+OEFyal1DkUarM5rK7/II5+GDclXy3t91+ZldCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=Ufhq0cV9VgbJkOPYI5VsoeicOuNqYv/AM8TGJrRVWmd7Rnu9WnqYVZJTl7MEtKE/iP+pk2mcduleex2qKRB/PCy5uupY8+3qi6wN2qvWlds9aV/CSC20WhcvHguWE/ojv0m07kU0FYuVFgiHJ7QYWNk6CIcz/rnKzTWISfWDEtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/6] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Date:   Tue, 12 Jul 2022 16:21:43 +0800
Message-Id: <20220712082146.1192215-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0dbff9-9d82-42d2-b68d-08da63df5f03
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtKgP4L/h4i0800AmUEsJjH0L4bkDUcds5CtFfquCDsTHnK0dDzUficYcP6mw+2ZH2Wridw8X9kc5wMA/YUZdOC/nVv/ifGCGrDKfSRKwQkXHz7dl94PEEfnoFDvmo5XvPKYwXzWiLpF/ex5Ke37uc/Ll4M7JjuS4+fafbUpEtynE/Ke5GAfvAUkLjQGnKpqo+El+uoVXzwL8aNx6Isk3o4/74Vw2kvFOr77yVmlezOn2jOnwHwDQj95zRKIE44nUO9aZjvgmDG1yd8c0yLyNpopeO3ZLtXNShDZlOKw/HjHa8AWRUyp0JwaLDrJKkroI8VbmUgeaGkmSIJL/qsHt9w+OvW06uz+OMwCH2kVcV5EFBKgqZkeKYojglBJW2+YEWqLoUUyWJFJElHudxNkJIuYh6NfPYOXlVCRf3d6bfXgHPkO2YqDvGBSzh6r9Ls5Z5rXazQ0JwLfxiR2+zcpUfCKy0KMfRVNwPKZLPuESnvzWcx2831WugDy4sD166aGikJd7/12JVUd/6Y913BU/FZyHhB0VDTXPTVss9Ca6XtaTEJQkcEdcg+hAkI+2FExH7Ke5va31u9wNeKvg1gnWiaeh/ntr8Lm3twx229SvuzjqlgRanSx4mMPQskGVRMOeIVezg7yTkppXZIoCTtol+DCWURFNKptvOXaQjVCq/H2MgjUJjQYBT4VFhqHH00ZOZBVuaNeqGCMf2qwvgzOpKePV0p6K8xdIFQjMutsm/SWnd8bqccszIyEd/tl66yTcy1NHP6YBBfHGB8CK1W/cxxB3Ag0e+/zT/Qf+u/PXgwL/aB5+eJgKg72UEbjBIsu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1u+XfKUP+8o7m5FfsAHFoEzoTByNIAD3m/8cwfCnNrsIc4yGFPrDkoNkixJu?=
 =?us-ascii?Q?ENp6W7A4R7uAGr2lk8Pt7Oo5+TvuIRAcyZkO8QyTTJVYV6wk4Zwc+gj+xRNk?=
 =?us-ascii?Q?0UaT/j1geZbjhougqVg4gt5TkcOLBtC7e0sw6xyF7BpwAPiJ9p85Yi5H/7fw?=
 =?us-ascii?Q?tGO2Y3d8qj205BTJLF9Y6eVoR8GiZK7jOnUU5zi1KfscRgrmcjfvyPtOfQdB?=
 =?us-ascii?Q?LZdQz9Efcjwri1eNwp+d3b96C9rlf2ma9yEhDo7i4YAlWM9hwlv4+gWrhg64?=
 =?us-ascii?Q?SwtvPJq+I1p87uRai47Eqew6omH7EAzgjv1uhs6k3vUqcySUzWzgvZVp6X46?=
 =?us-ascii?Q?Uzi3upg+S/Gap7rxpWltUbLAySQgJK39gqXdL8oO4V5lQdKe56BXO0xanl4Y?=
 =?us-ascii?Q?R64RL3g6qHC8VvexNPgsx/xtxevO9LLfCQ5hS/iV01HKxYWNTw3xtlf03/2F?=
 =?us-ascii?Q?GIW04S0iDMr8UOxNZWIaBizI53FT8y9Y2VhCzVZmdgpaoRsXK5ICJ9D6kOWV?=
 =?us-ascii?Q?X0ePqhoA87InvU/CBpOhjirUHFpqJ4mufH1eSbuZZDRvqs5u6795weWkQ/SJ?=
 =?us-ascii?Q?I9BGnclh8QN3wqtxEe3LkA/RWBcl2mOW8EamIYHFXepZ5c5JHL+8cGDdlSh4?=
 =?us-ascii?Q?B8O/Y1e5qjNF5kWxh1A0fhs7hTDP01W+43e7Z8DqaaxNv3qcqfUB3saq4Prk?=
 =?us-ascii?Q?haqgaOJ1zas30Dg8foeK8Fr6qttcQon6yjNkQPaKOUz9gVTwjSFMWAi4aCLv?=
 =?us-ascii?Q?k1907wrV1vFIwsugO9eJ09qZYCrHMHVRaedyM4IVgp3GwCcj9zwY5oV8Cm3B?=
 =?us-ascii?Q?sBl99Qbaue1/0X0iG8JBKPs0uuzgThEoi7SMFllkMQzpPpaCmX71QaiDx+CN?=
 =?us-ascii?Q?CyaE7/JOWNzfF4i7VSGVKvJcFUu3A9b5ESKdQuaImjm1CakfDBZKGoCiu1hE?=
 =?us-ascii?Q?dOfW82TTHFT2+5vrCdhP7fMMJ5vUdAf6OhcsekRw+F9bMTvOFrBXW2sM6u1l?=
 =?us-ascii?Q?ibSWRJKIDfZ8vefzo9AYEZApusrnFABFWczuV0m8VYgQp8K9c7GB3JjliV75?=
 =?us-ascii?Q?EzEJW7iFugrgl02k/nFa8p3qELzGiC61ObObFdIXwrPgpGZZfO3D/QxF5BI3?=
 =?us-ascii?Q?VaAwkEC/1WmiRfYzS/bxDTgajt9Q03pFiEB+zZroYJbFoJO//cQEUN0LZu/8?=
 =?us-ascii?Q?rCHZ+QkWkhWiAd46rEkviATRil3GKB23narvsAL70fefd5sb9dyIE5s8NlVU?=
 =?us-ascii?Q?erTXAGTSJ+9SICZdalrxK42KjYpTJNcurr8ZnY00fXZQnzGtBxnw28zFgoOv?=
 =?us-ascii?Q?y4UoNUgGW4CsvORtQx2+hEulaWEWuk9fzi5vCyzPZ6tYUMfPDIadXeJfllWJ?=
 =?us-ascii?Q?9yodGaVv8LJQ9MI+duPc7x8FzTIYrHasbTnfsETustmGuWii9inapRs13eoQ?=
 =?us-ascii?Q?RRPr+1p0XgD8IRi/vfe3QXm+XaPqvYsbaBGlU7geAxr7J5oXRwfo08oDf318?=
 =?us-ascii?Q?8Ij+EIrcMWfZLRvn5RNh7wIlKQA1bi90YCWJwUHFjdIIrz+3kMXpt7YfFgjl?=
 =?us-ascii?Q?sgMe7iQ5yj3hBsyznIz8+HKY0HjpVlcoNLaat3/I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0dbff9-9d82-42d2-b68d-08da63df5f03
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:25.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKN8p3Y0MvqyJoSr3+04dgbxScFPnIjxL+I2/JkcysQQQThvQai+vByUSDzT2Xl6YE+kK36fnQtHZWWmEMdW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP HDMI supports HDCP and HRV, so add them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 6f983adcb47c..527d45d12a54 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		break;
 	default:
 		break;
 	}
@@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
 		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) | BIT(24));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		break;
 	default:
 		break;
 	}
@@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.num_clks = 2,
 		.gpc_name = "hdmi-tx-phy",
 	},
+	[IMX8MP_HDMIBLK_PD_HRV] = {
+		.name = "hdmiblk-hrv",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hrv",
+		.path_names = (const char *[]){"hrv"},
+		.num_paths = 1,
+	},
+	[IMX8MP_HDMIBLK_PD_HDCP] = {
+		.name = "hdmiblk-hdcp",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hdcp",
+		.path_names = (const char *[]){"hdcp"},
+		.num_paths = 1,
+	},
 };
 
 static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
-- 
2.25.1

