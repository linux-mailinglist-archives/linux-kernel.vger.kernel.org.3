Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7280D4C9B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiCBCYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbiCBCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:45 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130055.outbound.protection.outlook.com [40.107.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67AA66E7;
        Tue,  1 Mar 2022 18:24:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3A7oDBedD48KpVPTX+WOPQNVu91gKsvqfO+eB8XpF3coY6viOR0ZnpwKetFEM8PtN37rTKRlmPsXKaOxzUrlQRpAieCLZ2JoLSHb+DOowtNPxyIfD1IuyGUjWac398ydQv3vqh78tVgz1h1IO+Kj0n+nVhtmYMLnlqBYBwPmIO9bw6b5Lck2E1xhFlQqyIeMyYMzSmj1lTbwRQ4TRGnIJN5Za501dGhuhJmf6H2q0WXmAqhVbELCeoc9WwzD9TErbWP/5jI1QzJ74R5H1DMvmY/WnHlTxoiTYLqRgq65kg1ngd88KdgJ1zQg9p4iGTTBtxeqmVVO6ZIKVfdlaCSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=HdCUiM6Qm3Wjn4BWQy5jWZJ1lEuCD8xZpZqxgiVco8n4DGD0RfDjTOf/8AcvWVxwG2z8ne7GczjRqGIPbX3EqBxciYm6H178XL6P5b34d97FZogI/sNU5DbEENo8qob1bKAvIGzMjhplI9shV5quJrP3pTfXwvoOiLlhkJIIjpetyFeafxrjK0ntww68VrLBI5yx02CAIunCph2l5r89gz+U9x+NQgvtchv6WbeADuEbjFm70rj3h2t1hNSOoJtWNmAzruUw0MsNricV+/IpXga+DtyE8bRJAEYS0juw8sEyP4yhoVHR2xNBQB4/4xHhDQKck7q7RWz4rfzpQlkPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=Oh1EAGZHUxkvZHIh9oGKtxgn8n9xUlRvFXAExkwmzg/tnPmmS+ISPApU5jsOJjcHVVZ4woqmWC1xFSFDN/VEhIKbujEe7kQhcVXEBPh2TGQjwfBHGxXU5w45Fdo98CE0HZKtFph0VNoF6emx1OcH/wMYbDOOdMjYyeunFAhwn+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 5/5] mailbox: imx: support i.MX93 S401 MU
Date:   Wed,  2 Mar 2022 10:25:22 +0800
Message-Id: <20220302022522.1789588-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d0ed08-af37-493e-6ddc-08d9fbf3b4f4
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4144B699298EE8653762AB65C9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZM427pzODfI03lZXmg/LcY4mRP8tXARNa/dlnPqqklbKn9z+xEPPYQhfWm8fBGt4czLIzmBhoZ7TA3Rzw7TKcZyFVanWEUqzwECmFoAXDpHDO8zuNXiLNiTet9+fSOkBaMZb4vWw2BdEDLCzdcah/BUu8xuZpZm6+PWv/hKXaJFkznOZGnjlb2eKDa44+qulKu9RzuC/1zILDTYrGgyWgqDtkF055FvMic5ahHjdjaKjFmHRoIoAEBmQ68jtjRPCVXj6s+ZKvhC/ioHITQYE2SKKFT+C3dfgP15TToeTiQa1aKjKmTaP2RmpVcuGOjtYJnyHfBt4p71hJo7QX7mNdtsW7ChUbRh8/INdSRCQMzpYbumC1xRrCahAYdQgmUCg0F9H7Cn1RdDdmRp4KjUBMHIJm27UzJEb8VCd/Hr0mKp5bBjdGCXrpzeuxbw5plBXaMrNxCkk/qvBqSjvEdl9IaU01Yej57NBGUg/DJuBxAVn2v2HY94v0K6LTIzIar8xHo3V472G5JFWPvqop5utGrD/UPynxp+MYHop7pQxr/XkTTcpOYWV6h7Q5WIn7bimTw6v0mASf5MTUyEentAetzH+ylrYC2929pnjcjWXKJH8Vl1QMFNHhUmjzJM1z+CmlwGssusSONJ8/YD/XBKI3JGntdGVC19e82z+WmaBm/PIs3C4vmRBQk9BLK2Rbq4KuWD/ebC81kDvfl3esIRr8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(15650500001)(8936002)(7416002)(66946007)(66476007)(66556008)(4326008)(8676002)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j7WyFZG0GBo26ZWXZ8Z2IlweR1Hk7EXYzgR7teZ14nXHlF4/fuXN8JR1y+Yi?=
 =?us-ascii?Q?Z6V+OvY8uUtVP5tMtGq+AH48wEKJz4YUtZLEgDLYGZrNPk5xiHiJioVFE1im?=
 =?us-ascii?Q?cO4ZOLj8bFzWcSdHnxAWLaGqi1HX0rgHAB7houhh9jRH2LvOdrA7jieUSnHY?=
 =?us-ascii?Q?FCAia9DuqpK7LQV+qVPA48Vo7bL+R7KQEk2LlNd3gG1Sj/DSfEMrsz/kUBzb?=
 =?us-ascii?Q?RFRYeE/k5C4350ohs1/JV1PUr2+WVyWiZxQP/dmBoyXiqtXf3V5SW582mFI1?=
 =?us-ascii?Q?L28h77bRsVnN9bVnQjaPwtD+ZVbIUN4NdvHkaK9KmSrU1CiNGS//9yIsFO02?=
 =?us-ascii?Q?PV0T9ILtYQlRPWRRWLB3SzGHBMDeLoHcnZ2LP0mWYwhT5FzCbvYkreAo39sk?=
 =?us-ascii?Q?Ad/AnGo1t10z6cx2eXn/SKO8djDdL8QNe9iC8zvapKVcSzdv6nv1bhVv7dpx?=
 =?us-ascii?Q?d3VrItdkoOqDCHBA4eJf3SaXMuKL/wT8amfUSOymd7LVGuxGZs45875lgwZc?=
 =?us-ascii?Q?Jj4JjerCr4B8qZGzlnsXAk2U+v6Rmc0Evk0YWLWaqv8AHckCCUO4ybv6zS5w?=
 =?us-ascii?Q?+lNwOYLIKVecpFuovCfvuqIxxT+s27Y+hGTCvj0cIs9hH752sz/cazPidk2t?=
 =?us-ascii?Q?lQ5fXv/aM29Q7DS6Ka6MsJzCCXkKPSANguzKeUb0/A05FbzAsMCX9Box1ZOP?=
 =?us-ascii?Q?uQV28x6enQlhMW33wE214UJhWwUnuJQhvwgGr3/71HVSOeM6+Dc+KZmw0o3S?=
 =?us-ascii?Q?RSmL8mS+LGxt5PbxTmvO+3XtMqmI0KcgwTvnwDxaap0wWsdYFc9MBfXs6Vk0?=
 =?us-ascii?Q?v/85QzwDI35qQI/CU/pgh5azkOX7Nj5Y/ZLZHRE2iodT+yguORFL1L5nqlEG?=
 =?us-ascii?Q?LYdkRdCRIY4hx7txfGv/VNIc6JLrcjroiJQDWOFXnr194YqUNmEM+a4gKZcl?=
 =?us-ascii?Q?qpsWUUpK26jZU49sxamq2xMSDzdr3ul54pyndCll0ByyGE0phn/vt+Fp6uUD?=
 =?us-ascii?Q?6ybTlTQ4ZpYARL4BFlWYFKOQzerZkwSYdqI7UgWsGxFEm+dzFqw7S90q8/q8?=
 =?us-ascii?Q?HhTPc/IO2qgLTfV36V2Nw5LYmu+RCCDjn7aBjxkrf8cYEn0fwBJTPUcis6sL?=
 =?us-ascii?Q?zG7KVtsLvMkA8HKJgBpAkuNAE52jBaEmYkWyxtZY8qZxIOthWwMR5gLLErU/?=
 =?us-ascii?Q?eFoAmEpwWq3Bnllvk+rIxdk5G2FmIAvtsp0d9A8QVvBNoQKlcWEECRap2GH4?=
 =?us-ascii?Q?X/gx7wKyuGtSXO1SfBrQFa6s40PjKB/rNxZwPRcAYT4/474PTftWwrDySEaD?=
 =?us-ascii?Q?/Lg6X7hbYlesVa2aRqdbSuZdi72FBreEiWeFuyFu4VlU1DkhKWGKzPgNfG1V?=
 =?us-ascii?Q?/dtRqbEfDp4uZhDQ5TUJVi6pGG7lJeD2obvkEjEHC8/JXlO1P/EZPXtuCdLS?=
 =?us-ascii?Q?yoLAGyTu5dnqwX1XbkziusbPsbQApg09XuMIXA5viNVyAwT714aaBKQv7v0z?=
 =?us-ascii?Q?5/b9JtckVm0Nd84wHO/1ANnQlFtugUDHJHtPJ2AgO59uIsb5ORAIDCtk9vAP?=
 =?us-ascii?Q?xJdVfnk7uQAt1omSYfJ8uHQOTyacSlVskPb5qYiGXG8wt0brAjRf5Ll3uvJ5?=
 =?us-ascii?Q?nJZ0/B3zchIvZ5BUlNlF1Ps=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d0ed08-af37-493e-6ddc-08d9fbf3b4f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:58.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTVM0SWW2r6r9OXDE8uWxAsSu89zf0fzDX54huZya3Lk81zQJvHnJ0QXk78NL16UYnlQCeMgcIPu/xTRg7LyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
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
index 4bc59a6cad20..dcbf554aa96a 100644
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

