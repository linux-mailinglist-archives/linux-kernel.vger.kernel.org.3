Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9F564622
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiGCJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGCJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939A36356;
        Sun,  3 Jul 2022 02:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfOriI0oDpNxkUsTvvl1ez1GTGfqM3ajyfwraS17IbcOaZhwlShfS9BDrBQHG4aXWAsBAEVw3RgSv+JSsVUVfvSi4o+KePeU+CqnCG9P0t/68lDxSw7z0Xpy3+SmATT7P153nZJuYjHzDVfVHIaiyTT/t4jn5rrDqj/BMlH1UTWj+NkwJLSi0BVAqyt6oSMnzRGNY16hfWV5JLi3eG824M4fZZ6q4wznLB2KqI6M9ZgasCz+tOZF2yLiJc5+ZpUkWTk2Gvm5sPQBLT/LZOhEBjK8NuxWMzk2VPqs8Ht9LSQr5BFQhvAZRLrDxhnQbifDbdZh1L1o9I0Apg8Ch1ceWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnFrfn5UnzLFl40Nkg7G8mYn2FZ/F9QeYrn/MkSMNeA=;
 b=KGYkA5W9diOKjfGBe1p5VuxxuoKAU5OElxpZunzg3Pps3M+agvnTzWJeKQD6cqmXLPpJ8hTT2YJ62VDbvhNwtIE0+ORPGBo1zpR/3KW96ogCsiFUSfJnqa11AyYsXGde4koQGmUqi9DlNoQS1J7zSLsadDamjNrPB6bpDxvf2YSuMfHMn3ERVRtiKk2f8mna40TJRhHJyj7r7A9fwIJQy4RemsZAhw3IsLYCKnGhetV4e9J+9gaboMKVZB413K+ryP36UgMrsGc0mHQaEypiwQ2r8DPiNg3NQRbvorE8ee0xcPNsYsnyrMAqfpmyuujIaV3Z4KRdDdTLVK8a/lDvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnFrfn5UnzLFl40Nkg7G8mYn2FZ/F9QeYrn/MkSMNeA=;
 b=DH3KXzEhXP+Uzjz6qZ4yNikK+KtuSy5YuKRAsX/bA3JhpEooeiiknKdcpPbfku6wj1ffkQq17eFVzk3+zgreRvnNR6wP6gjeehIWtIzlTHIprEA92RZXjTSKhmYSH6e+CoJatW3JqrRcif3Mqhe50jfi5SqH9ojsowHOWPVDisc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 04/10] interconnect: imx: fix max_node_id
Date:   Sun,  3 Jul 2022 17:11:26 +0800
Message-Id: <20220703091132.1412063-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1db7bb-4b57-425c-7d86-08da5cd3deca
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVcUtebjwJbbHwP7dxDk7mh4x8X5c/b1IAF3zTno/bp4ciexkPpHHSjmOTyTEbQzFgaA+M8yVUJoyI035WP3MtCHRUjPpCC7azdNoDFUQX/tygiVECHgH23zw6Sj8QIK/jrvz5ELMutiJ0Op4WCw0lsxhVyRZug1wzfkEqf8Hl3jxHvx0dYqbvSjR8osfOsbMVaup+Tr5Ao3q6EmALtr4oo8EZSQTfqZvbMH4hKao6z8ScTYnTQA4B5eKJjVs8slGjLVLsNI4lFSLIMmEVELqtULUldiSy5zeAHlp6n1trQt27/b5sheGPjMr809RGhY5l/u78Gv4mCzyq5lJLCetvpiJM19oPLege4EQoGJ+oyHVc/iOVsSJoSLCfbG39Zm/d/NRqSna8Oo0J/Q5dBSXKJyUZC9/diDffG/A2rdbqnWDCS8M1Udq2NpX/gQPI1xgue2NO2QrNshQjM8nhZ5zHtboOYRog+8pY+lesdkpGMsaLlZ5VOLSJyP5anK/tKzwRpHxBj5C6EV5GdB75beUiJb/SuPRZL/3Tk6oTmOAmRaDDOluu9OLLguk1sILhrxaXsu0Gk5LccOIZdT+GsHn4zOWvdqz9zaUCl7gbKNC0KmOcykGN2CNsXZea4/JKPLNPDgvhpGHsHjlmUGpyvt5q2Amgc5LOKdndqLIPnDLmM+e/IUOOCi/lhdLq2ygYyzXI6nIV9jBE1KsRGTHCpPZFtDDYwxvJEPJjmNN9xVfnP3b4paSryk7+x1EXOyrtNk1F9SWzazaBBJYpF8THfObhK5RI8/MDAuekkArB4cGNNfDqy/XeKuyCqzRX63/gDWR2Q5FucsqTrLo7OwTGRnwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ymVHW+P+uZPSqE+Lb8tbYczr2V0J53UBPzABhCb1GimliEXUWmrIKXfzjjR?=
 =?us-ascii?Q?2N/7doxIuFyFTfx3iOIban8zE6EcLfzLeCw867hkkZPx3QJsjJBN1t19y/vM?=
 =?us-ascii?Q?cjFyndBbCbnM8nVhCUh9c2UunVp/m0z7Q5Uk5zABrKgus8RMIbduXhDpw4Zf?=
 =?us-ascii?Q?Pw2VlNjIFqxrZ0pM/YBa2DuGQ2RpXdakcsTM2HisPqWbE393oydVOdlES3N5?=
 =?us-ascii?Q?4hDuIFFwSI6gC1UnYFgpItRFJ6Q9ap/mmcBiJM9m7MR1+GWVyr8Ndq5tjcT2?=
 =?us-ascii?Q?qv+mC/ZYKZb9Y88F0tK7allfvc/7U4nlxfb6L0Q4D25ElUkAD+k8xyrcSTXP?=
 =?us-ascii?Q?VUeSVv77rB4Zr9lfecyYAuJp96Ps0iV4AofxY0Pvm9roywyeplE23l8xtABj?=
 =?us-ascii?Q?OubUoSz3SIS/i/H/90LgZsNIH5jlAhlyBCZQFnEaEvpgYlHGaf3fzX2uXI2s?=
 =?us-ascii?Q?myzqES1SZBQTghTlxqmiDMqVllg926FrWDgONpqW9p0lI3WTAJyX10+w/20j?=
 =?us-ascii?Q?roF9TOawuk7S52A45+FKV32AF5jrEggWNjiB1Mql2HfmMb0FglNLUso1fB3L?=
 =?us-ascii?Q?JglWxS5TnwGMMCjMvaxtM+L7nXxeri23LwUgXCD++SPXGh+rNLgPYssCYwVy?=
 =?us-ascii?Q?TyJWheGMXeX7lAkjo21XfLqVLv8r1uzWfFYW/FFD4M0qynoh3A1ImwcGB6xC?=
 =?us-ascii?Q?1+NuKBf8Rmbi3rT9YLMnrs1lAhm3qBJQCLyeI5KuDfkygygHpMWe+I4z8HLU?=
 =?us-ascii?Q?TWLbHhgauDg0SWmLRlchKOuh5aIqzJMA7WEmWN+gok+TnxB1r4Qe3MAR8mO+?=
 =?us-ascii?Q?5tV+TieEFOfl+7S0XDAjSW4Bj0sQT/pfVibB83CXAdCYqBj3hxW02S+m5VYP?=
 =?us-ascii?Q?rVQuyb6baJL2AjG/aTojHZfrs/cBQadTQ7WyIUi6wWCWrekeKapqxEZk1Lr6?=
 =?us-ascii?Q?Qe54zaxzVaU4rngMCw/WrAUjzSsE8SywEmbXzTxqQ61NqX8hwLCxETIzoYWH?=
 =?us-ascii?Q?DbFb2h3/hcRkFiDd79lf+FVcaU0UvDZNnohhAttTLnQvYpsvDZMPfuBvRhjb?=
 =?us-ascii?Q?plf25mX5mkznzgDomCLeZVRRDTXIwBI+JzeQ4Nl6MDMYHZOsov4o8O0rNp9O?=
 =?us-ascii?Q?Hc1pKcu0TUoJJoFK4AG6FYv9cbB/ZyKBvux9ZRu2RWTqkLaynPOj6a0RhbDv?=
 =?us-ascii?Q?tYrcaALZNSbzIEY4Jz1cN67YmSQbBiLWQxQ1/oaWKIl2ninsiKxH/1dj6acY?=
 =?us-ascii?Q?rZz+fAouA0vMULjCiGha7rr9BEpGlFYloOJpW6+AlpYHpbSqGLJq55Fdx552?=
 =?us-ascii?Q?ho1vL4zRiP5vL/xmSVDpQpYcInSEEPKtsu2qzIoy7y7+LqJRCrIyTxzQuoRA?=
 =?us-ascii?Q?R0vdOX/b9HluRhGoLb8huTg4Y41ks5XlQOTu+EZ48moVDRMbg6sV+MxvqwMQ?=
 =?us-ascii?Q?HciEieCPS2uKPEc+WjzTFkupvBqeBBzb0xIkYY3PqoV+aCd9gR+rVdpzg6db?=
 =?us-ascii?Q?79Rcv5aiOKJZr75DcTud1IoFK47HQg3I3taZG1WGkeZCGZt8hdrYmrcgtiWk?=
 =?us-ascii?Q?3LPctRO8yUeKI0Sqh2X2m77jmFyImoHW5QD3q8xT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1db7bb-4b57-425c-7d86-08da5cd3deca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:27.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpOyMvmDcUMtT6BtT2TX9j68PM/I0rW89BsTZGUJUPo3crL1VGJIwykJ30aCYrcCeV1+eCdM98oTnquV2Q9tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

max_node_id not equal to the ARRAY_SIZE of node array, need increase 1,
otherwise xlate will fail for the last entry. And rename max_node_id
to num_nodes to reflect the reality.

Fixes: f0d8048525d7d("interconnect: Add imx core driver")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 249ca25d1d55..4406ec45fa90 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -234,16 +234,16 @@ int imx_icc_register(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	int max_node_id;
+	int num_nodes;
 	int ret;
 
 	/* icc_onecell_data is indexed by node_id, unlike nodes param */
-	max_node_id = get_max_node_id(nodes, nodes_count);
-	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
+	num_nodes = get_max_node_id(nodes, nodes_count) + 1;
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	data->num_nodes = max_node_id;
+	data->num_nodes = num_nodes;
 
 	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
 	if (!provider)
-- 
2.25.1

