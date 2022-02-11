Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B84B1E20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiBKGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiBKGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:04:27 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D145F7B;
        Thu, 10 Feb 2022 22:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq8XyGwHylQylT888/KkVXmKuaAPK1OkwvIS05a4FQ8ulKphu7E16Urkzb+hD0btZ/8XfI0UPPbDBJVvtZOJunLz20hMvUdljObCDinI/HEECmA1s2PKfps9W617MAQQEuYW85h7g95BC9/iWYMhECrFjX9HM4BqVjixlOWGegUypesSpKRCO9wtZGE00C94W5bAKJijqxSnmWwIbSgDFyvdKHWldknkBJX0odE4yHsU8mtx/BSAOCoNhCKElQIswXTHzZOZ9A9Th3RhEDYgKseT9FOg6yQSIXkpocclS1YGa/gMS8grDNg/80r9rrHjkxLOlDQ1ybrfwRZomURBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNIJ9qv76KlLikoKWko6iZofhx7xuZFE4MKoenL63Yw=;
 b=FJzQEQUZkSqX/UQ2Cp6CPOdHoHKRSTu+4QnRDKq7myKXdNAqo6WF9N8rCZxdbFIY8ZgmNw1ylQCg8hXWlcZ/Zvhlo3KxmoBrYYQ/cxur6FN1QyN7ogLGEOv+HkoTSQ5R1B530uZ/ePyH4sIa9E9M22IjScUuk5BGOO8X2NVlvLNNMFBpYeabmrC4M7cc6gPCmgyDnlZk/Mu8U07UOUwo7tum3T22pFZNf+omor4zbFCfKo5hp+axI2ED4Ep4jzxyutGRgrQudIAgmvr5pfo0uPfWqJPTJnxRP+zGVjyCQTdsXp87GaxBaWxXR6dPxSeZsJkyPtqPr52/sINNYhU4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNIJ9qv76KlLikoKWko6iZofhx7xuZFE4MKoenL63Yw=;
 b=TBmh1ceztVpomybH/QPXgIMA5iYvt7lFx8L/wAu5diTSZEcKMGxBr799D/MnKRkB+mQGCCRpiDoxtWCkluvdYnAZrRcGVXUuiNQeJ3mNH3B3jI7Gk+DIcfQaDuv+PUM0KOhd1pMQXUnAi7a36AtzR6uNsD/PF5g+hwlOJxxA0m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:04:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:04:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/5] mailbox: imx: support i.MX93 S401 MU
Date:   Fri, 11 Feb 2022 14:03:01 +0800
Message-Id: <20220211060301.1852772-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe38d663-d493-4858-7a3e-08d9ed24554e
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71135AC55843F7264009A0F6C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0gfo33ThxCZ9jsjHl7xLg4i7M4zIl85mSkAoVkwhcKahN3yE8gDZGB0cjiI8EyKhfD4X657xo+a/yuxU1d0S42bAo24QMu96aQKI3uNiEF9BIZWgZddTCnjj5B7i1AT1h2033J/YUPjqixpLNzHgeE0ignLlnTz3biJ6VMDMZw1wzCIfDivEg/y2MgVqrWw7MMDk8QeWE5aMZqLJZXltWdWZsi/QimaTuUA+VZUPuB1OxidtB8bqvlmLQqQXmDLvitDFAImmWv7Pr8mN3O8recLt42UYdnjsz4bkPGeygxnAjFn0dUmw/ZD4P8ejzE//nK0j4twZQNDsJ/pIGLi3IHWxFaCCdFFqZmfyKigPlEAU50lQv+LNK/+uTB9xbh2t4DPc0/zUyzK9y18kFrfw9dm6+NrqMgosUjW7IRSESyodCjQdEicyKzm1gkU2TW9s4vmT3BxNc4YJHakodZwgLXYVIo72+Xtg4D38nFEF/m5M/YOKoijNa3WHPZRPqS+UVpApajIdddhRgDCxwmJ4/gX1cG8p9fVdGQqLUV9/pJROsaROefvvAoZDn2eryvojgVLNLMqXWfOLl8ESLWIH061LgxhIJav74Q9rBYcQzywBLJF4ew3DxcG71Br8jS1fljuCDUrfLFGsus3n5Mw2RMxoa1InqdXZ1KNrqUTtTTWO+Va4degW+k5QQvNax8qSL/LT4+LBzwDiP6yNxOWew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(6666004)(83380400001)(15650500001)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oW3eAfLTYFq3xcSTfEm9GAVluobDKBFSRSJm31S9Nh903HhS+fcHm3ka7oKu?=
 =?us-ascii?Q?d9Y1c8/eGrYPg6Uprt1rGSpzCL91OHMlNuOfTvY4XdKjVIzezVnG/317hJWZ?=
 =?us-ascii?Q?IJ+sxNuOmvsemQlf1leo2h0QdGgMB8pkxMaA+wjTqmLJwUC8FxSqkFCrhmC+?=
 =?us-ascii?Q?JjfRtbgrcRUAcONx1LVDbp28aC2SMQ3tPhEEkV3mCZZG/M2Natd3micUSD6m?=
 =?us-ascii?Q?YLfce/26FP8D/VYizr+S//Ky662zJ1vuaRk/3B9jRODATwuWThxNjz6Py3SG?=
 =?us-ascii?Q?+hoKFpLoC7bYJN+aXB+bzFZqutC9XrpzYeJvDCmbN+FCxk9LXfw5YGXsyn/k?=
 =?us-ascii?Q?rUIU25iQAKGAHE0N7DdqzGkTaJQ+nkS7L3xLorVBrODJViJPjI7xf4VbfQiA?=
 =?us-ascii?Q?HKX+aO1Wc1lKuYEHkc0ci3HjGSBeRv9HWEL0W9qx13JAYYP4Zbzd1Ovs2cH5?=
 =?us-ascii?Q?cZYQIhgWol1oMgwU8C/aPg2+5rF85gV33WWH+RhOTLolmD/jBvP43RBXk1cB?=
 =?us-ascii?Q?PYXFLUO19/zOtE5jzojlW7zlmDD9fCRDXikiT2veeqT3KnfnLCXtHhVrNjmD?=
 =?us-ascii?Q?/4YJ+H4uHMSOHGxrJYo8fZK09Ff8UefBAczKBAyTtjv8AZcAbTHBQnUNCK5y?=
 =?us-ascii?Q?onFn15YU8hKHJlTOU+GiQNbg2WQYt9l5OCwIqWkK1civCB0gcvDETocRbRdA?=
 =?us-ascii?Q?wfNAQ6NDq2TIJRWs7CbesKFBACkv1aRzt0YgU4GHFY7BM905bRe/1QE0PPUA?=
 =?us-ascii?Q?bUuKHCn0qOsY4cKMgMkcqaJ7FeSTlvBaWyN81l1cN9PezaJlIGogczqhbVqe?=
 =?us-ascii?Q?2n7qDcIjG9hfAeKgtDGQEeoi9axIQSQcWLtcCAG9PyMm2Q7j5XgtbwVj2C6+?=
 =?us-ascii?Q?Ei7QZ7F02c81lq0ZqMyWR3whTRnI6jDbXjzVoS1pGHeo028H7kashIJV6LBN?=
 =?us-ascii?Q?ukiyfpAj+KhVA5XMJ++jGAGs7hcPlYUzG4AoEKMAFzTeV42wrgCskeuu0NVf?=
 =?us-ascii?Q?CKCmH3ZSg1/gYCGbDnEI7qk19ldVmWBcXpRcb8vytTpGuA3TKM+vUAUoivFk?=
 =?us-ascii?Q?I2TxEZXPDm4biDQBWggbLJq0L+qnZuITJnSyrf4yczMN9bRz5Yx07FGqceGj?=
 =?us-ascii?Q?9zeHppp5lOxcZflCA56tUtlTMXPzTVn6XIly7qfuMVZ3Ym8TjLrtx38VYwv6?=
 =?us-ascii?Q?0t5s/FkuCWjow5tvmCnmKKnJkQJho+uDIT7P5BYggGMiP42XAOVxNqxdtgH6?=
 =?us-ascii?Q?PohBj/u5If042dMCAr0vFAgxma+Ni5exjtAdsB17DdOVNZ8ynE63sIYsKXNe?=
 =?us-ascii?Q?kCowZ9t6k2vdBBBT6t4e3qeCZzd2WPKCxxDrtizcKG+F9RQr1DpB+CDB5FQ3?=
 =?us-ascii?Q?ST/vlgjxpXo8XJnkvAcg6GpIM6ySwVjMhkYG8fqKT0S8lYLuMThTtnh6nib+?=
 =?us-ascii?Q?rwiLqpWvGHVen1LZtuTSX95baXbfdGFOF+Va9nMsTAbGaepSbw9XZ0CT/RLX?=
 =?us-ascii?Q?0rX2XHcLpyWeAF89lU6DQyh0Ld+hOoEZbQPSJCEfNrvVqjnjFMRJiV6wpywD?=
 =?us-ascii?Q?krLHuXi+4Rrh+HodWM4SyhlJBhqrUXdtflB9ipFBzvWKauW2ApZ9ryeAykVk?=
 =?us-ascii?Q?aL28kxs9uF7yyRj+vY8YGZY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38d663-d493-4858-7a3e-08d9ed24554e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:04:15.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 355iK2uyFqYpPk1QPKiFKTMvwYZyEJgz9MAE97/qDCZfu1yL1oMEW5IyXRbh3X29ITRBqoP7I0Yk0nwUvdGONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 S401 MU cfg

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 12617628599c..094dc84291fc 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -908,6 +908,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
@@ -935,6 +946,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
-- 
2.25.1

