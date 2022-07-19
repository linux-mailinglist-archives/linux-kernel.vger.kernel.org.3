Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54735792BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiGSFuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiGSFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BC30F72;
        Mon, 18 Jul 2022 22:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8dcozgmiYUfHFBU5TOeKbXUTYfDSMVLozlP1OaZPv0N9CKMWLy91utYuSsyNkEo6Fla6yrGNrjZlF1uTB1/X3drjIAFkQH8pSqimYt05abJkdvzqbeccGCdWNiWc3TOaQXsxQWNqrYyyfwnoTTT6LRh50w3fNSq1KP78rQLanKyDYNMgzUOPc4Fpwro3WYKWf4HG4JdH4g4nc/YQ1aAYRnO6oiybOE/GbNdR2jG5tNOnlAFcCm20H4a40LT7gMeCd3QJwi3EiLebtDmSCcrSgHmyOhANujE4O/U8ieC3kpkfmfWr1Ig9jU2VYzF0FvxB3gd3lVyJVXdV/ZaeH3MHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=aOUpqfA1F4Gygwrv6I/W3q8J0MAGrq3pb5wEtqdkm1yLHEd/lW3gm2oBAlRbXmBqyMaDoFdj+TIyf9BKHs+Wnx3bR9S/FjA/3eZCv9CRPhO0HwyQYichejcgZFFtNVs0Qtq3wW56kXf9oP5HdfShUPPPuOlat7cm5CW0SimHPWvpDQVjnBL887YCr9GRY2Pcl4Fy764TnbUikZIe9iDz1cgDeiTgkf2YGEKDDjOy7wuzTymGxoCEv5tyj2oGhSwfgUZDxmHt4ysvjFbHgca6njHTOH0NW7x1sD78nmfA+GO53aT/F2ppqfqt0xilBIWgzJzJNMlBGNVZH2rExqmydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=OB9hguuBhBSLgwU7h2K+qHWega6BuiUykVm3KEGfd7Gdixg1YATYAXimGGX0XksQF90tWfwX64aMpr78JlHGGBCrSY7WSpRjUa0l3znGooQsuPept4U6EvIEwG/6WHKnl0p/c41zdOQ+9J3cEPXIfaNMjPYKvoyoNlrJlV04mM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:54 +0000
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
Subject: [PATCH V3 5/7] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Date:   Tue, 19 Jul 2022 13:50:52 +0800
Message-Id: <20220719055054.3855979-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2258dd6-c019-4a4f-654d-08da694a80f0
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FvM3xxMpAFNBkZ8j3EiBXckVCKZJrbaxVppL3ZJeRv9bR3c8NWAcnSekrutiSzC4UHQYE5DrV7CYPKiepeEqozuPwww6yWHUpqMHI91PhbCHTxyjW9MHPh9upfCmEoGq287P/Vm55R5jLGwbkYIjUWOU2C7S1/MZVxUHe+qIBYEVUfBqfN7Rs6AVVNQ5K3kogAf4UCK87aJWIfYbN/YGl4VagENYIk8pRWlNhZH3dvlDW0inByD1q1+Ij74bG85wDwUbIyzteHXhOtgKyMwfC/egcRyLkfIS7cK+6Sghx6LuP2CWJ4GexfilLpuSW3XFJxnH9Qs89hby5Cy16FYAvgxpJ2fASX9qhpRL9J4zWINzwHeyV94e6rQBhARfRMot3fzp2+YfudaL2RTHTS9spesHG/wwKpnqGXLCozAE9kZWpJvMz165TP+INKMrkSyCNWVxaRXGR4dILjMpvH8E2ZMm4W3n88pclZQrSfbMQb5qYwR7Ss8TJt5EUwq/lWoKkcIa1RswVkUng7x4yg5jVOIZDsOKGrx0cPx3BDHmlIAkkOG3zN+nYMf5SFQZCF/a5nY4VDWwk0Som+kfnISmF/Po31EZjI9c7EUVBHiE3ip4oXRokGIyhtg+DASQSrVPGRe6qFBAeRosjVen+WFp7VlnF2QgwNQ/djHM4Okv4G3sPJjqTVTltP5PvZgfvkat6NCn3BoPLNfdK3B8t9ZLqCcR4ouRsP4XHhKjzm0NtohSR6INhls+rZamZZGzUTZgc9DGyIbrhsVOBy8mZTcPq7CM/gb9cycBLL7lceN4SAmKub7aOXN/rSSic4YKtWGneikdNvnYjo6WpmRFWqrrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(2906002)(52116002)(38350700002)(2616005)(83380400001)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rEOu7ImO0fXOCOF61Hyh5GBLbWNA1zTlmtX5y4vRYdex/ria39zNph5Hng3A?=
 =?us-ascii?Q?HWenXDi28OH2RaxT7WW/eFidomvG0+A7F074W++i2JwwNNDBrQsdAsimHjY6?=
 =?us-ascii?Q?YdjH2DXTLhwHdZk0HyX4Ij0lJxuof7iWeJeaJWG7aDmS6vHOjFX9eBmjqpQs?=
 =?us-ascii?Q?xDLH1yWTtWnE1MbPH6xtcrjOirPll/8MqRcs4iDRcPDtnBTKbXyMPMs7St6o?=
 =?us-ascii?Q?ZB9FAS0KDWbtKJH56yUOI0x8vasMQD+TRlAgwfr6FhGw3F/ZF78KW939hiL4?=
 =?us-ascii?Q?3okUSpcfXczx6mXw08IFSESLoXroDdVW7N3LgjRArm749GMzdh6XdPcYXkA0?=
 =?us-ascii?Q?5VbUVc93Q8L5TnhvHgk7+qJfYhvR64oFgHutT7mmxnwI9Nisgbr/TcrvACBP?=
 =?us-ascii?Q?pJQLlYQeMavIPfsFf2KE58qNywAgIe//rJLmItcVgtXh6gFeMM7/LUHauReo?=
 =?us-ascii?Q?L6qQ5kRnzIGoOGx9VgltYYi8X94SQBSaDJNEEu+FX/wz82YahACohdKYFAlZ?=
 =?us-ascii?Q?9S6akF+btoiH3dxsSsSpO63gWpTaBfsUl1GE5l9shBN40FhfPN63MeiJ5sNJ?=
 =?us-ascii?Q?Dh/IoOyIJc24Khr0I0e3IQfqdIgZueD2n9HFaXsTrjip+ynGp3PklcXtwXSM?=
 =?us-ascii?Q?OR1ZtgKShEXki6FKqeDJIojmUalksWuR72dwymMjP2gUZOAVAKvtoyR4xdJz?=
 =?us-ascii?Q?e8Y0WUgdVqvXX/SAeuWedMbjQ7l3E+2SN8sPTclG1Liqy7rX34HNlUBjJ3H6?=
 =?us-ascii?Q?QNQ+RwUWdxW6Bo+x/Qydv4Jx5ip4Nd2PdRQkRahNxp0vhxpDngX2a4DMJ4G4?=
 =?us-ascii?Q?dBPrOxGzMqjmi/8A0dpGgvlSI2b2i+DUNQBVnZHtDAPja6usNWjkPwM6cffm?=
 =?us-ascii?Q?i3PxcuzQNsGhJBEIjiD+JxTUv9JBo+u5ahzqOiZqVLX4GE41Yu40PFXgiQtM?=
 =?us-ascii?Q?phLLrl6gs/NCqcMzO1FacxbvGw4DKeMRZREUlP6MUtLRwzjjp4L6hX6ZngXZ?=
 =?us-ascii?Q?yhVifAAupFh7EBg6WoIJDIaJsttPWQvnT+gRHs4XBRC79ikCIx3XfBnMbyTB?=
 =?us-ascii?Q?z9kh6mb003UizCID/QSsDIcab6OjeWs3rV2KUGTSCIa6affzer+ggsYLEyPB?=
 =?us-ascii?Q?15fMCtBjyNNzd1oBsRd3JHvPgPzMjnr+xYLbCOsknSLaWBFqzbBmaOyg9fw3?=
 =?us-ascii?Q?2vdJw1wyVHc0fpm8kS7/24P23XGhxuXFpZrEAZDD03Mf+OliLhTUNErIiuaP?=
 =?us-ascii?Q?Frd43IXhCkM8FOVpUPf7KzkCr9ZixS8lWFIYJetv6hRF0Xu/4VKfwwC5ZHDz?=
 =?us-ascii?Q?5OMf3LWuHMG+J83GgjmgdQLHHiTWA2QTk+A3HrKWKZJl+ow6MTasoAtc1DOs?=
 =?us-ascii?Q?C5y1H3GsIvwRd5v++DMj6hNc2JWEBJf58yIPKojmSxd9EU9TbcNBMmENCfZm?=
 =?us-ascii?Q?d0CMaThZcP4wsX3bqA5WzQhlNO4oCs6c0jbV29ShjmoPCf5xFx3Bh0QDtoaU?=
 =?us-ascii?Q?ggKATAQa1GVd2sa4JiXCH7Zc6QLBA2WDU0oijUvS9KXZnfKz5HXzHATQXUCJ?=
 =?us-ascii?Q?hC5at7k5CEd3QZPCAWNN/lWZeWEWNxWOYNh/U3gr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2258dd6-c019-4a4f-654d-08da694a80f0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:54.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37l8LsCf1VgLK2hqTTrOJRrvs7I5TkP5ytG3rW3qRsc/g5BM+UdJrxU/Sr8wPfwcVCFivRvx1u61zoSKhxCa2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9b0f81dc292b..871a387c6b41 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -484,6 +484,46 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
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
@@ -827,6 +867,9 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
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
2.25.1

