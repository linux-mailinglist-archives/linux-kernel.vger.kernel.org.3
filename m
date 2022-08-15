Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17120592777
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiHOB3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiHOB3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAD312D02;
        Sun, 14 Aug 2022 18:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4FN29glu90XUpDJSq4Z6D3gFFd3YmNpyWFZgzcQEZn0k3XglQ0uEvG7vosLLuBmnWuAWyhKfVRobs0fY26A+F8EwlIo/TrnVHzRJ+NUDOOD0xwJjpe9P7EO7MDnEDy52CddLTvUWwS/kvRaTVyXFtSwfh5aJuMuLrE1KA8iWqe6IUXV5P0ui1q5KontznuI0HOWWHwUVLB1Opxlbovmh8C19QfFZ6DnjNwzZR2myiwY0LyVHj0S4Ot7HwTOapGUUfKl7tvtV1lMygUvc57sL4zvL1czXx6NCStBeEDV+wD67flyjrylILh+niNqURbbdsidbxTI+ij+JtTBAlxLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiHQlsVmLFX2wMtKVIZwLzTMDI9/OtrbRaTc3n/Nn+A=;
 b=Rl/2w+mAfPVvKMFmyGKTlgnjbisNkz0V2dPLHKQhCE6fy1oxWwzApeuRUVylPPlYwY91U+1tdVv7WX0SmCZRPNwCvps2rrxTx6ODM5yGdqKpXbnDe1cf4NzkWw7sBE4fTT8knTcyFKB0VF0DCypDZda351UWcM9+GPKazgRv9dsYwnjgMbyva9oGsag9hzn8fjYmYlcwHpR6H6RYnw/Jl3+Jruy6q5MTa3ssQGrcY7ppgzzdQI6Sg+splbEep6I4oPU+evvam8EdanhmqjvSbdJh+lyifyqgEa5mQOxYEJ5sW2moaA4PoDD4Jgw9gzYHSg3veUtAtu4NhDilALYYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiHQlsVmLFX2wMtKVIZwLzTMDI9/OtrbRaTc3n/Nn+A=;
 b=hqCCe9YN84jCEbLrusvgMko7xaMOi2hgRbyUTcFuFOA7z6N16ipv9KVo1K754aKTwhz5UwOYrUSCe+nmp5AvTWGxo+F384auwVqAqybS/sm+Urd6zm/a2DyHARb1/vyCMjyPnTVmhpo55DMjUU1Kz5pZXW1os55vm8mvQt9+eFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 4/8] clk: imx: clk-composite-93: check white_list
Date:   Mon, 15 Aug 2022 09:30:35 +0800
Message-Id: <20220815013039.474970-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5d5ef6-84c5-4c65-7f42-08da7e5d9784
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I+e/hOqMuKbZC1CwUDRvzkUg+l9JYAa5O4HisstW8e5b6SKG0NsgHhnsEHj2xL4jL/LA4YWBr0sanv6L45+zHFKS35HSS1e2FNaeGJ1bl/udtacGE3+CviirQGeRD8TS7ni7bWMNPA7yqj9jhlZHFdFV52pwDjbeW5fM86S2Tc/vbFWhTJBbwhYxpk/Yo9T2gkAXdQkYbHeGoeCccLZ5pURjToxtTNZDhSn4EBjLg6mrsEROsIS+gFpnBgN6QRkFqTHEKZ/VjqTiCyxBx12BXwGAONhbEPBmYXmRQD6Buh1MAloLVQPOioLngjNrB236FUv1h5TBF6KefHv9vNMLYwkFah3GlGSQjbjcMQ2oPHixb4JpvEeVabOUpNEbGjROrnNqK+gNMbxBmtny/NyMPncZPuRNwga6DhsPZN7FO0pmKbudgB3x8I+xW373H9PC/fHXi6J5uIYLJdDmNP8/KNfFxeENuXfbWrg7qLIIZRHYgcrZFfMihxep28Lkt/qeM9UPb0ieJZECZKP2ob0YQr1/yi+tCmzJYpWBuL+nCl6hjkTx8Yp1d0JQVk8HXoLXIJlqPwLd8gx+lqE3Y3amu07EwRWfKSDtcXfTe98XOY42dvJCnfD2HIe1x6DmYV3gnuEClkZgsBT2BBbVp+Z1dfZLo7e/Pe+gW5nsn3Gi1GSY6aU8OE5zQmKpIU/yLIf7B9WwPSvroZYrWctqBwPf5yzYNlvVmrAwKiVoxN0IMtBcw33UqpDW9Rbb4q3wxTGfm9yLy1RirzfLmhl+u7EQRWJiHzu0ZoPAabEgvNb2ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6666004)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eU90aFyrxpNS4f4uTGrr2HNsLIFSuJne3N0VJJDiEqlG0IisMdh6AAk/t74C?=
 =?us-ascii?Q?agBUWQVMVjkROvKPaj3wohkEfTjoVOVzo1HcT4ZgDI6XhEtYjV9+ztO5IEZU?=
 =?us-ascii?Q?I4Qm5Z0h2ih2e9i8WyqWzuT/Gi2KAfH7wJ8aK+NEnSOgaYTNCdAbqZR2Lbe6?=
 =?us-ascii?Q?g0jfbZxvFULVNJIhXgBq2NhJGSn9s5jyO3iq+MUvwbx0FaO4rvUs+oNDs/jB?=
 =?us-ascii?Q?ynV2wCjS2M+MvFmmoSdX7OwTdQKM95z3MT81qi68fDb6u4IuFl6A9m5GGX7f?=
 =?us-ascii?Q?KVyt8GBnbeZCOCNLV3IML7H49/2oelXSYxlXXB1QqdUhybgwkmikMrGqSrcn?=
 =?us-ascii?Q?LNBgY5PEYkeqDSUgPCzc6KRflUIP0HjzTDDHyJiJo+zpHmZ0W9WOchuW+s3i?=
 =?us-ascii?Q?ApMaond5QVqk54jyyiwHQFdrruQnHc2wKS2YEoJY5DAAQxL9wU1hg7ghIvyQ?=
 =?us-ascii?Q?ISXYukt2pkkOB45X9rhBLsLU/oP50UcK9jXfVNqxu56BGynRtHVGtqiEtQ8r?=
 =?us-ascii?Q?ThYiZQjB6s2iUUV0TxaYXhRHlV8z2eEcMayiEm7RdQ4utG47DnrpW23U1YMd?=
 =?us-ascii?Q?lgvXxuIXPVIadCyW0UFQrjmeRCKRv/ELH5FgfSREpbHVcRudkJhsjIClNWtv?=
 =?us-ascii?Q?Yt+Xc7orIg5MxfSO2MzHqU29PB3caEFEQ1MkQi+pjYEKT3jMAH1LnJOhoKPC?=
 =?us-ascii?Q?51BQBhl1DqL9tApV4bGEmh732uozn6BQyac9nqC6MWN3vcbKvPBdjEPGqXq0?=
 =?us-ascii?Q?APAe1cocYlrfexuLgtTUW0Mc0QDbYT7mIwC1DUbPr2hoHH6mjUnCH65uHSlA?=
 =?us-ascii?Q?v7YY90tm/GyEWpQLJbhC83j4p9Dy4gwI3XoliXy+B4xOHU6FAthFY9LKTuP9?=
 =?us-ascii?Q?p/d8EDOHVboLsKNbxwEa9s/49HlXxzJljN3ibr8S1PHzD/CKmU2EmPaayQsy?=
 =?us-ascii?Q?7ehM/4VsWGPbnVCPO0R5JS/Hzcr9Bh0/EE16y/3+NZrsOCtzq3oV5JG1BZQ1?=
 =?us-ascii?Q?28I2kVUXrRW4mJ7attLjggfTvgCyhFoZZYwBFOV7m937fP9SdbQHsPe172R8?=
 =?us-ascii?Q?k11NmYmR2n6xfijSjk4+h9kEYA0AQ7/ZATqmT4muxSkyEHmaGN6ACfD9aYNc?=
 =?us-ascii?Q?N+v2onn3M4f8CcKJ8g9B8INapX7iRzrPxR/YZpT5bEvFG3T41M2l4/5s9N+1?=
 =?us-ascii?Q?r2evZIXNrL5NpA8jqw9mXv/+T4aE3TBqckY5ZQYWfaHwt+SaMmFtI58f8J3f?=
 =?us-ascii?Q?6v2kpUtA6V2OvycgJN3iAonlIcXoeM186UFy49oHTT4iKd5U8aRhT1fDM45w?=
 =?us-ascii?Q?wQvjDj3JgEZ0zRSmpkLYfGbzzxWs5TdWsjsNrnHU/LL6o8mzBLOepB8SkybF?=
 =?us-ascii?Q?rSI26t+XL+KjDvwJl78j0SHEh3OziRjnG21hMV0kFB+3uRdLAHm9v4wjENQC?=
 =?us-ascii?Q?sUPSn53/GbINxThC9gSRuiNWk739TRxnU+xbQG6y2e9OZ/bKXzqfrZjWMfga?=
 =?us-ascii?Q?h3STlOCWTDIYa95/I5KtDp2JeIX9cQPqw5S26bisd3KH2vltRC3D7UvIcZBl?=
 =?us-ascii?Q?wwEVCB7PCkT8tqv6tehGCTK+bAQezWcXNxmJDSm+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5d5ef6-84c5-4c65-7f42-08da7e5d9784
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:26.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW5EAC7+xtkJaS4q4QBpzdRi+4g7AeIKIL8Jns4PBLvWA0ECXcI4iXXZTIzlm4aJu3AgAQk7sHOemNd8un40iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
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
index 5099048b7916..0d5c11bb3659 100644
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

