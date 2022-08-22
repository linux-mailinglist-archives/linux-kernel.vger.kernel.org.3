Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D159B9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiHVGoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiHVGoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1143286D6;
        Sun, 21 Aug 2022 23:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHx0hcT0adqBp9Yvp4WF1G3Fvh2PE5N8+938hyMy4G+ut7uXAOv5BWco6peWWx9U+t6NllUGYiaQoqOLBVjj419qFqf0R3pZwxqKNHHvX+MCKDHtSgSEDGefzPRVbVGINvZ2IJMyFmFG1CWW0NxiU4oPiG2o74tdsea8ChnJAWkzXqMHs+uEw5zCsNCBYvqHdezt0uVn6KkUPICT+n1gNLlL6YKWMsjVz2ESTerWE0aZYk4WKfgHsIxc/cJvN1Br2o7vFsqsG5YAbChykU0FRHVRdCM9ywTBWhIpmEPHS8nmYp8MEqpBxJY8HATiDETEzF5k5K4MdAJeM7ObBC1wLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ScPuIFG4JYZQprQ4lj1Jr7T5hfsMi70GjzypPU0urg=;
 b=j56e4oD8ZEMSjPBbTpauG7ZSdp6bAzOogGPdS+SqdddZZWfLdYy+uYKzdZzbeTUt5pe5YqzcugD1pRdYsvQQL2i3ebYd4PbmtoQLoKEhplzfFuUaM7t3E/8NTM7roj7CDtqoHh4HMA1AdAmoNSFP7rpNsMTjctuhRSu7Gd7tIjlRyxci1hak3VdtzBlUwW8ZB1NffXPw4lryv5I4mAw59KG3vlkwUQySyjgYRvbAetWENOgLodOdsXxB3HdtML3XmDsg4JjamfCfWzmY7ZlMMvkpZTIaV/1F7RJvU60Q7iIr7JA3hiQ5a8eXDAHm5QoKV1hadDFP5KykU4cFkt034w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ScPuIFG4JYZQprQ4lj1Jr7T5hfsMi70GjzypPU0urg=;
 b=QTG5DfWaW/SSCTwqYLNLRMMWGJaE09Q2Yj0uPRqIyyvMdYIMSnm8Y5eBl0690LcmwBvDMXSk+KWKGooRmk9Vjse6Te0YildXh00V8aXcvnTfyQViaAlyYv+2axlAGWeKKLWAZutolR3XPXWCkqwjqhS8gCW2db4pDXzCtg8B5+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5677.eurprd04.prod.outlook.com (2603:10a6:803:ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 6/8] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Date:   Mon, 22 Aug 2022 14:45:34 +0800
Message-Id: <20220822064536.3947512-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf7de84-fd2b-4895-9e9a-08da8409c502
X-MS-TrafficTypeDiagnostic: VI1PR04MB5677:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdtRc+d55f3X55PUWJ5OPev41fAN/lUydtwFnppZc+uiN1fPobsLG/VCmURejkc2lHISlxlo0bb2Z7ild0DllgrGMT87ldqcKh74H1x6dSWNNxWWgj4ldlR3ys5vlvfUjBzX0Q328l0aN768DIXNIJKUSXcWv8Oj/btPaQVoSAt8KzZZohlC1pnUCEoCPVMVURZHyzFHO0cyJarbAN52TLMqS0eoKdzKoTn0XFoEFAPPqeessPTut7sMeOf+RH8PoosC2hpX8nLJuqmJyVudH0/gV1xpQ3j4OVn7tOwVLZFl3Zdndc7fUbzhopoPp0YW8cJTXwjaXM2QMVUOIYfEC4EkszUFhsAnwCIWo1NoQHLJHH39QQFPxDQchyuJwsueFE180Ycv5Y78PsqyRZbtCcwHYremGHLsmVLGDI7BpBZB8ZgriecU3TGQTM4/Ltl1vxvoRm4tRaWYK7+m+Y4DqxHUHw1J2Fj92u5jdv1eUvKOBBcNbRjajyRoQv0Q9TqzOLsnL5ydtd9AZbA9z6gN89YmnIIEWNCKGy2NwUm8Lpi4z4TcswD69ngY74J1AkhDQ9ts6ESytPUr0vBevFcsVc/XNNMzbgrxKCaSoOOjYAfR9O98LP6EL18toz1YQG9DeWuAhzQ0+8TxSOSIRSditeXcG+pu435tzNrGrroJfYU95BptphPBkICTsdz87rb3EIBx36BBNJBQAJyzf4OTik1BPZoA38kXHl8n3NfeRAVavqWNUiem/G4Sg2GCqpoS+pNtsQ4yBWJOsPrZlhSFCIiU38T4jSNrRVHrzoR9PFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(66946007)(66476007)(66556008)(8676002)(4326008)(86362001)(38350700002)(38100700002)(83380400001)(1076003)(186003)(52116002)(6512007)(26005)(6506007)(41300700001)(478600001)(6486002)(7416002)(316002)(2906002)(2616005)(5660300002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrQiiDf20h3VuQ7ZT+rUfMLQTbRQ3rSwWTqpCdrd+QplSSpo0475GNH2iqsb?=
 =?us-ascii?Q?ZUMVerT7k82nWNB6TBatxI+tq9MLKGTejpD92SO4EEgYJkS97P38HoXodr7w?=
 =?us-ascii?Q?yQHysveeIRhmHomj/xOUUEmS3QT9mOYNkQCpZ5kMhGCsMmSc2qjol1b/ChBk?=
 =?us-ascii?Q?ZLfV0M58uB73+WDMCJyt+FgVBH4YTqU+7bV3S5tGgDBwIfAIpMVNFGlIi72T?=
 =?us-ascii?Q?mtEbjUNHRvC6QsufgXVFKi4qaa8OOKDe2kaBYvmFz1XgNhqzRhhjB754K9A6?=
 =?us-ascii?Q?FqWSIYJA0ylQGnNb84ymX6aK36dZmxk6bvqh8BwcQmP9650psGweyeCoGjKA?=
 =?us-ascii?Q?B+Ygj+fsW5wkNgpbzQje0O51e9BPJvcuqz2SmrGvUR67UnIDcMvyjJ2Bj4c2?=
 =?us-ascii?Q?Gkc4+lSXTBX5hjA6VguFxxZo8HhP7fCoCg1828sl6y7mNRGGNkNyMT0u2wJg?=
 =?us-ascii?Q?96NHsEYeuV8sgDEDaqinkQKYvm/zhAxZIBQbmAonKdum6Ntjzg9cK/sVLzog?=
 =?us-ascii?Q?9QJilJ90iiEvnp7YD9zTmdn8ELWVb7wBOKyhpOY8AEJpj7sam8n1alRAF4m1?=
 =?us-ascii?Q?NYiv2Fc/LHvB4AzFbVGYUItHzfDcjB0JXQ7nlh3Go0mKSx2L/19n44n7GuX+?=
 =?us-ascii?Q?xJlYUQYyBI/Gx8EqBGjjsesIMva5gNeSQBdD+m/Rp6YL3pvx74TvEMxo/7Py?=
 =?us-ascii?Q?mFLmSexrATE7eD2YR1xZzrSYveyigLc/Fda1VcauKRTplQO9Hcebfh5uD8IU?=
 =?us-ascii?Q?/UrUHf7d1SMfWgSGZ89etGFxxsy5MaemKg3ALjZcXvCIEon4Pcc4lZYq7Kzy?=
 =?us-ascii?Q?0p5OSWWco2bkaiQkUlDltjBY3kM/WThEGInaDVCbEVAZkPfMTbixDx783JN5?=
 =?us-ascii?Q?lobkVrDRW+kLzAbhAJRznUqBxUbcAJP6hPIPNj0ukeX4v7Znssx2fo52uW9Z?=
 =?us-ascii?Q?mk3m64oOjH6m4bYF0NKAMC4xh/f38Nxq/N0b31QzVtPBX2xs8xKgW6wQp1LH?=
 =?us-ascii?Q?UwEbxaQmp9B9alsD2FLbw3+phacOuQxlDIVQqIHtR7PVSdEeSoEnV3Ssovr4?=
 =?us-ascii?Q?eKJxa3M9x8M/nM+FaHPHKSr1yxLo6Juge9xTTovsCSnz6m/GTz5aVJAM6itW?=
 =?us-ascii?Q?3OIXQ6nHdORpPfqOupBdTiuPiTGteacNmFvv5QHNXtdy6ZERMTkfeKWKM6D6?=
 =?us-ascii?Q?feEcE0NaM0jtTHo/vIWTIMRCwzJPShKAqjcSe4uRQLnneRKNSWVdlxr+hin3?=
 =?us-ascii?Q?xM3erUckhPOqCemLhDqXs7Lqcek5IpLwxKW6hXQ1XukEwU5shbcIJRGZ3G8z?=
 =?us-ascii?Q?CKbf3WHBNARh0IbpwoRr8zirJkP+t44ChG1U0cIBQvwucCUCgrh0Zl5sou64?=
 =?us-ascii?Q?X7fA90amSEZNTUfEXKMnR0LUMTDUNXcxFJw0OHILu91MZnAWQPQHWaGYEUwN?=
 =?us-ascii?Q?VPSrrQb7Q+5YkMNM9a+HvcGZYpviQdVfkWcGmud7l1KugQU41xt8z7QJZ6of?=
 =?us-ascii?Q?WMkcmo+MLNaer2PeN4GQ3rqTw5/yZ8MunHu6QSPzOc7wqCvpgA7EkRsaQ7JP?=
 =?us-ascii?Q?bT4jXE4mlSaXwW8ekJMPXsiKkGFyYGGiR/LNs/gL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf7de84-fd2b-4895-9e9a-08da8409c502
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:32.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVXpD5TyGTc9HrBfx2S9JMe+hBiDKoXJ8sLAHrL6kgThR7tWoWag/F+q9L6HGh406BE+rmihyXnIxy3gKZAF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5677
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP has a VPU blk ctrl module that could supply clk and reset to
VPU, so add support for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 8c23d4cbbf05..94c369234930 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -483,6 +483,46 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
 };
 
+static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
+	[IMX8MP_VPUBLK_PD_G1] = {
+		.name = "vpublk-g1",
+		.clk_names = (const char *[]){ "g1", },
+		.num_clks = 1,
+		.gpc_name = "g1",
+		.rst_mask = BIT(1),
+		.clk_mask = BIT(1),
+		.path_names = (const char *[]){"g1"},
+		.num_paths = 1,
+	},
+	[IMX8MP_VPUBLK_PD_G2] = {
+		.name = "vpublk-g2",
+		.clk_names = (const char *[]){ "g2", },
+		.num_clks = 1,
+		.gpc_name = "g2",
+		.rst_mask = BIT(0),
+		.clk_mask = BIT(0),
+		.path_names = (const char *[]){"g2"},
+		.num_paths = 1,
+	},
+	[IMX8MP_VPUBLK_PD_VC8000E] = {
+		.name = "vpublk-vc8000e",
+		.clk_names = (const char *[]){ "vc8000e", },
+		.num_clks = 1,
+		.gpc_name = "vc8000e",
+		.rst_mask = BIT(2),
+		.clk_mask = BIT(2),
+		.path_names = (const char *[]){"vc8000e"},
+		.num_paths = 1,
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
+	.max_reg = 0x18,
+	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.domains = imx8mp_vpu_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
+};
+
 static int imx8mm_disp_power_notifier(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
@@ -826,6 +866,9 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mq-vpu-blk-ctrl",
 		.data = &imx8mq_vpu_blk_ctl_dev_data
+	}, {
+		.compatible = "fsl,imx8mp-vpu-blk-ctrl",
+		.data = &imx8mp_vpu_blk_ctl_dev_data
 	}, {
 		/* Sentinel */
 	}
-- 
2.37.1

