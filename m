Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4563C53A0DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbiFAJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351184AbiFAJkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCF5C875;
        Wed,  1 Jun 2022 02:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQYj69wcpbUpZ6kpFPoTJqZ2Y+bNWcRAB3W50ZHw0PfZix4wEDEwxB4TJqBoeb+6ajkNKcmZ7Z6h4QXL0v2snGnlGbhKT5Nla1CHOSEOWR09Eh6FnqqFGTobhyYFUb7im8MNNLxggpy8Li8ExqAvXpNLVMEvXRBrznj+sUiUbu7n9cdObz0UnGhy+QloVteufuRU/6Rc95lN8vnb9qFEYITAg9O/7UAqPE01tnXlPfKQ36ksZSNOdlY4uh+P1ldbZ5GfugVFQna4iRU/xNgdIvxxB9F8/5AwtUuDlfE0/UrVPPaJ2fdEcSyi3By40xAstt7v0AfxCGMlWKe+X8tO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q72xNWvfqSkewLvGIXJPVQuhc71UEbJZKfgVlzPvqk=;
 b=j3pFdk07fGS9Ka/xupPZcvhSKEzOOwXUULlBy8G5boMjF6XXNTf0cTTzLXOgdKduaR2rzJ9yxtTzayXN1RdRIwaHNpxdrICMlLr0mIbEkxLuEi3OWY+fU1kRnlVrtiR+ipST7EjJv0jBOgI+Qk365MOHBqBuzq7x385xM0P+InaMUuqNF8N5fHXfJV3BoNQAB43/sM353LNrUbILz5vUWTxOqE6KQCsAsUkLShatTto77cgdv2kWvuocq/x9b+thcMqz0Bxupp0GOFTsbsAs5C9980guw5iCk8RG7LvhB/IbXzCrh7JzU3qyFaHMCcBWU5SqyKXQiTQNIr01KfF4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q72xNWvfqSkewLvGIXJPVQuhc71UEbJZKfgVlzPvqk=;
 b=TF6QATUZ2bYIbwA2NkROs2Yu1WvrW1BypTAJHMOhzt/O24SJGn28ITwFFgPWVe8A48Dq6zLdy2i7jNbxc4OCr72NbZrzIzXr6BF0iQ4CKp1ewBc1MUJ3vUcepZc191hPytvMi/ezt6Ync43vWt+mi505rjaC0Yxdjx1GE/ecF6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/8] interconnect: imx: fix max_node_id
Date:   Wed,  1 Jun 2022 17:41:51 +0800
Message-Id: <20220601094156.3388454-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6fe2b46-854c-4751-c5b6-08da43b2c515
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6498C2C4F466F9144ED3E679C9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8zd1aBTlP+27XokPCBPMcZnAgS3wXbazs4J53N1Xr6x/Uv5DD3a+Kj+EmeKJ9OHK+naMT5peToz5lpum8hkB1JObUUYESlYU5wGyPtiuo957pNT8lUm5/X0BDJR0nJ+yfamuXUNGsmeFK2UdfKcFhxInBJjooilH61MR4UOAXFIkGpIS3C66KCRa0XzdgxnwaNew5SrbsNY2/sxisuhWivcQ5H2Yg0XehVYjmCIubGe6T2mWtIiQi/q18Cso7UU5eTw+JLObhMKFiUcA3mj5aLfwfbR5HXn9mbT9R6A8tmxGB8wkQXRGxSS+/fJnsB2Al+5KowxDN30DYXKwURdPUhdeUvQsNg+ukhkZgNPiYAqsRxe8qA1oASz+FzlqA6qGoe8o1w5Kd1PhGREITE9OGptiIm7+UlYpXT7X45TsH4cjvYwAB0MhlT4aCwnpU1+mfqbrol00WfWeCHMLzFmpMkEQ/GN0Y+Kw5J8G21/06sl6THgPrGPNx6mqEfBxAAqntG4U52zff2N80sZG6c/cip/BQV44ssF+bf0OnyFQ0i5E15ZbWNIIqlf85idfMmgLk4G2gG87ZbS49qmbSW8AvSqA//hxOtT6F2O7y4vkMIrm7L5BdDDiKFQJKlQkW7ofLb7YoDfdIOie9siGQMYsppD67SfRcocF2Y19cgNmYUv8X+Xrmx3LsYpdVVYHJjdxT4SBIMS2IDV7E4cND1kSSY+vbHUe0brj4+W4yxkYjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(52116002)(4744005)(2906002)(6506007)(508600001)(316002)(6666004)(6486002)(1076003)(7416002)(86362001)(26005)(2616005)(8936002)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700002)(38350700002)(186003)(83380400001)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?imv1StNNY4nNdSQBBLSUHqcHUrbqgmtQiE5ycZGmGpbrzoO60qLvHzRH9L5V?=
 =?us-ascii?Q?rXeyn9nV4s+zbp86FwdBwUTIGMrsXlDd5mpkBzLakiBvytS42fhhUoUF/DjG?=
 =?us-ascii?Q?NhVTpRcyVri/2gIJZ6AWERArYs/UJcpPwShsg/h2DdRznPqIezHuj7EYGuiI?=
 =?us-ascii?Q?BJTftVscO5EMXvDCfjG0aXDQX96YGn4OjuB5Ty0jqRVdiF+mVWuZu7KAUbbt?=
 =?us-ascii?Q?hrPcPx08mEnUNh44dLILUpRvRHOrdzPPES53k+0pr/ENvZMPAMP44VWC7KU4?=
 =?us-ascii?Q?17mzau0P6BHDkHbWZAixQotfkY3Fc1DiwzF4cWpxb+tkNmC109++3GIpW1eP?=
 =?us-ascii?Q?auIg6X65vgXL2S9IfK6Dc3tdolv8jxbSiAzV05/Gj9izsKj3acqC3BkhVUtJ?=
 =?us-ascii?Q?jfvr+SJjK7VRnXxzBw3w7pmtC5SCJnHMhnj/GaZXqEJtJvInkukkbyRHpP4s?=
 =?us-ascii?Q?lCXgJG4FlV4ieRwA21DvsQbNNkUaTaoYAUEi04lESoSKITDQycbRssc5GA4e?=
 =?us-ascii?Q?7rQjnZIqMdw1bkZiI/HLZSkgWxbWIV70tipRMl0tvG0wtU0YLjIiMvlqHh6h?=
 =?us-ascii?Q?tGzE0xkPg/735HLvchigEKLiJAj6H0Ccy7tD/l3kGFA12ZxtC3rNQ2sRRfMB?=
 =?us-ascii?Q?Zygl8EhIfKPv64h+1cZtSojink1t+j9OPX2ojP409ETl112JW414WJGYViCg?=
 =?us-ascii?Q?XYJX0KmfgJq3pq/0Ee5DNoc9ZSA3QeSASLKZFkmVMunfUenqgoma98ExTLVj?=
 =?us-ascii?Q?9IMjf0ttarUrFKQHvdv4wOAntj9zr73PAbC2IqtvmdopOFVI2IZ9faIb73Tg?=
 =?us-ascii?Q?uzX9hqGOnyWMP363stBradKJ7N40Uz0aKPdcn39//N446GquxS056ThujqvJ?=
 =?us-ascii?Q?kX7dz4pXifxXN09NBuoshCyZ2kC5a5KPNkuPmo0d1daONMyxhW2ZA6R6fOz1?=
 =?us-ascii?Q?RIoDpFkxxCDaEsNuI9jWumFz3bOutZPTnEuBPn//txrG6RKI2FpxEAZ0x3Jz?=
 =?us-ascii?Q?hRvxSG3Zn7aYvuTq5Xs17v1Bnu0RpRhQ17R9QJTgqABToeunWXofaVfa4CnC?=
 =?us-ascii?Q?9v/yUcSC2dbijj2AFVykotYHo2XfVgwa8e2+cK7JCzJc3wm6sbaYJLi5JXBu?=
 =?us-ascii?Q?GmiALzAgJGLAyP3/MvFPA+raAiRr03y9yE54jpHvI6Ye5YYE2Wba+0cqulHp?=
 =?us-ascii?Q?GDlDa9UWCpPJIHqSoWEbveH2Wy9n0oB+e0oakWed8bikROWDqLFic166KqaD?=
 =?us-ascii?Q?spfuRLMGbA8GaPtv7x/ygzIrpF96ik6H15CWM0Mt/Gxi6x+S+0u5XwI6+uKc?=
 =?us-ascii?Q?g2dnhU2XQAJfTzY0jaUUeEwFmBpel0T6EVXs+dPYxlu8m1/e5QrYt4iwshjk?=
 =?us-ascii?Q?F8/W9YPlL3LjmIs64vS/6zcfJgE75OxuncCjpskK51RGkKyctkWo+A6yutST?=
 =?us-ascii?Q?A15PcXQnVZVNFncq+VDR3+LPulCZfWifdx6m7m4G5/OZm28VtxhoSdvUFkxe?=
 =?us-ascii?Q?KxTNMMAJBoAAeU/Icj2L2FvCpaefDy/eYpRF5OnfK2LDqHx7QrDsFBL9lT/D?=
 =?us-ascii?Q?VUpXg9pUp9Jg5wXuNjHNRNC5GZp5RcuhdGMWrwF1umLLtYh2e7gmOdkz9HlB?=
 =?us-ascii?Q?UTyIBI7L3369TURUNmJAqJJwzVJ1FmGkxLCURyAE8xJhrKwrfqNV4UIwPXWU?=
 =?us-ascii?Q?XrZjEkIYqPZn3dK0o9VxinTtv892YGaUe1Ml+k6ZssODus9wI0a7hJxgQb5i?=
 =?us-ascii?Q?1F4Eikq1xw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fe2b46-854c-4751-c5b6-08da43b2c515
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:31.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRvM3eMuKvMWYVtMbgigG+y+cwy0atV4owHDLVBLh6yCHwlnkqTfxRWeYlUFN6WfxP/7gqMKvM9k0ua3c5/QrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
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
otherwise xlate will fail for the last entry.

Fixes: f0d8048525d7d("interconnect: Add imx core driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 249ca25d1d55..3c074933ed0c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -238,7 +238,7 @@ int imx_icc_register(struct platform_device *pdev,
 	int ret;
 
 	/* icc_onecell_data is indexed by node_id, unlike nodes param */
-	max_node_id = get_max_node_id(nodes, nodes_count);
+	max_node_id = get_max_node_id(nodes, nodes_count) + 1;
 	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.25.1

