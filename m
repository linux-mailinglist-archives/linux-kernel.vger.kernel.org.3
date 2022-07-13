Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A618572E43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiGMGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiGMGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC53D7A43;
        Tue, 12 Jul 2022 23:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCBuw6+xttfo3VU3u5hy7K8StfdC6nThcu/7TFMznfKBgrRVbrdv4F4bpCGTk8oPmF2iUdseiqUFPMGGg4LqZj0tsH5M9nvDbyuwfY8xkU+e2CVmB5gmTxMI0bMUleN8hx92MopxwXRUg4vLJya7Bxix95ArCNRz7XzxKwutS5+bgnb3nfYlbWxbs1ZM8GFCtx6u2SQwbn2dVgZyxmz7Atj2lzMkJGtW+dcibs78FfBTXrBUh03eq2lZHZxPWXWOESru4B1tXyPfriI9Ek0JoajxkAyYbscbd2ALwoGgc50NFqQAcbbMuX3RN3QvrTFmkp28uv8KcjDBEc8y9XIJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=eMF77AsVv1qpfKqEHbRlE8htxRMPQa8VpApWUDZCA+mkOowtvPs3X1FCy/G/fTYkdTvsyJ2BNCCr0Ge0r72x/quAx46vM31oMIxEyHm5tDwlx+8byRy4RKLOyN9aXdONnWMwJP7qLOxFci9/oF8/mXxB4uBJuetPCzu2YO5D+uclWFgECZ8U71smcRMRXnA2r6zmMVSLd8tmO/iUWFCFFPXE7KtgwmMFcpj16N1UOH8iFihq0CWMRQ/L3uBOMkQZHdd6baFsDxX+Rizg6ynz15RvJwvAcOJNF75dwfykcX6UboNMG62/w3ksUcY/lW/Zndm3jzQzBzbl+qOESmz4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=Zg3XI2+IApBXmOzBcJKqqPbLnnSC6O3ulzp+FDjcTf6rELCIJs6F1H9y2RiLs0OVDJHDCERC6t/9VXce5hlN97bKziFOeBFvOl0qweuYIPiO0XOJV7/LlaB0a664FcGXkNfR2gSPVX/HkaBPLSyey6D/PH1LU/FQvypYYHZCIyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:35:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:39 +0000
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
Subject: [PATCH V2 4/6] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Date:   Wed, 13 Jul 2022 14:36:51 +0800
Message-Id: <20220713063653.2584488-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a6aea66-e567-4366-df23-08da6499e6ae
X-MS-TrafficTypeDiagnostic: DBBPR04MB6026:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYFAYmLO+donrHLwrBzJ6o8N+Z6rT2Urycmf1C9ump3QgYDJ7+bpzaeiYvfqIFKPHdkiX5EMDsVZm90Z4aOPAM9wHNhwoYP9F2g3khuXFdtq6/LiOFJ31IGW51uPBYTDZh8BsS9x9feJr2/foI8tgptRcm9f5GqNYsR/ecKmi0o1BuGCPzrHiZXD5eh3Gihzn5QV8JM9YcmuAZgJZj1tdq8HOTBwdjMap5/ZtrZnZEZEtmOnKY6bVz11wc5F6rwUZDA8M71IIM8lLRreP43G6wZITTXPcMTm/w8VKXEDVWE8ydqYN/D7mNs+v3ZWrov+SR/xUXgfBRJb16aunaoDXcejy/mj7kFFyglVFRJHklvF9hkMelKp1J4XYD+uE+UQgeKWRG+Mmb3YhffwP/Awqreq6M8P9ISo6EvB8c09ydAMx1Tvkb/eMZW2fay2qlBub/kBZTN3GAVCa664oMlfoCHizseQ7oafLfwwKsoJAHZR6KrNQJ9xRdKdu50hotf9xG+KztndtwWa4205cRX0SrbjC9jixa9y+qIC9jUkmalKWJ2At+kLLbiaTbIyCwGicI7ovibVT2BOc3CjzHgmuw73kbI1Vduys2nqra6UDEdc4A7t8hhGN/rgMOJuf9xTEKRwvIS41MQCRYyoF5JbNFgDoduiu5cDtEU+PQvjqTbM7KTCD30h/+teyjWsDxr/YNzbiCo72JXyfRzuepF+7KMoTi86YCeoMUwJpZsp8WLoZnCPstUbCE8Mk5oeHpxgHOAYcVhVN1HHub6kyw042dBYEEnEjaCGQuDIQcwfOttSyCQyBZExn2xepIiI0w83oTAXK0p40evEM9Tp+5OsLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(6486002)(2906002)(83380400001)(186003)(6506007)(1076003)(41300700001)(38350700002)(4326008)(8936002)(86362001)(52116002)(8676002)(66476007)(66556008)(26005)(6512007)(66946007)(316002)(478600001)(5660300002)(7416002)(2616005)(6666004)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uK4uKzlJ4g5ZPijeiqKkM35Sii1HGbEImNSVUWbfA3h5bUloRAfh4GZDVeDv?=
 =?us-ascii?Q?tKU2AyjFZknsKGnz147xroQeU3MWrb5G5EJiK3tlm3lVOZNjv3B6xYrZaWWQ?=
 =?us-ascii?Q?i0ILdxP4pJBq1YbbYlCiYTOv8VOvvYZG54tYa1r7sAJC6EqJeQIXE9aEA3NQ?=
 =?us-ascii?Q?/WCKCuAE72ZWsY9wCK0Z5GcZOJY6inwgKVte5aU9pWc7oY2roDbZsthsklu4?=
 =?us-ascii?Q?QUBIx8W8XXy3MJjoYg6P94I9mFw1LNFnoWmRd+0ZYcKDmcmT+B+16HMTAxC0?=
 =?us-ascii?Q?rG9sc1LMrRrDBxWT0KjTzvAbef5Do7a4801n/MaKapX/DiV1Eu3iKpvpGlrn?=
 =?us-ascii?Q?g0ldNW2U5yuTvzhB1ljhbvKbLHY/FSEqzpnY+sn2xxOPxFE/6eirc7VF34OV?=
 =?us-ascii?Q?1/0ESPolt0326RWW0ocp8JXi0ZPt+0GGzQwpNZnxYqKzwZSRkyIb6gVz8+0A?=
 =?us-ascii?Q?JHM3hfQMqyWTs+oV76JQ1yMAgFVW1IAZ7pnuO1Va8wn3HuMoNxR5RkRIsVvB?=
 =?us-ascii?Q?V0ZmRZCWdVktbTQljCsyM3iQRNWKOoBkS/ZkL/f8ZZMv0/3feC5vYujyKQc0?=
 =?us-ascii?Q?NEoa8/lMVFwdo6cTt3V+zrNA+5qd2moQUZgIWhpRJLRu5y9+c+yCen6DN19E?=
 =?us-ascii?Q?rDvptyHv0fkj1RsiWINuwTbul+23Ok/cYuQXfWlBvHFhdL8TL7AxGIsX4sE7?=
 =?us-ascii?Q?96MqR2kT8jzLc915Nss7JQEora5dFhVOOP08FPB155apF1CHBVkqoOMhjsAg?=
 =?us-ascii?Q?5Ipsb0n0iIrFSP5w7f4SLcrDc8XisFb0nJJRMJLtCCQ6Pt8JtOC9uFkXiqRX?=
 =?us-ascii?Q?XuJD37v1kEJP+avCT6NFu68T+MueR31m0zzVrAgCpxaJnIWPZ4V3ByIgy692?=
 =?us-ascii?Q?lQN1XBtUrFRy3I1ibflbVVcM0re09W9R1Kw9YVRb1QuWQxOyIPMJOS020ria?=
 =?us-ascii?Q?OWRzDfU+qfFklKZ6obR6oxqvtaCwXrx1eDwUUGELdmm/jd/KdT6f7BqYm9o1?=
 =?us-ascii?Q?0E97+l7uJ7Pd7Oei0Ab4rtX9ePVQD6uGMaOwkqnj96jUUN/i8OSrMNZWi8bB?=
 =?us-ascii?Q?BqhLU3RJUMNKcCte3QlgzscVLLNyk4rvEwV7mLwVr0+gfQlqf9VD7MHTDQ35?=
 =?us-ascii?Q?NlO9F12TIMTnBrxvsC7lhr4vPkqegLLndhV9euXe7Jjb59DD6BVGaPjDM6md?=
 =?us-ascii?Q?rxDpValrAN3fFKh21mErRV4xXBajC1CX5MCLZUZLB8x5MMAsm/gdA86HlYZu?=
 =?us-ascii?Q?e9FzDFmudHzjvHW40n0INj/9mJ6XjN81SWYh9hmw+1TE2KoNMj9KL1lXpAkG?=
 =?us-ascii?Q?tOJslsylLc/hSMGoAQAokX6zlqx2c/RlGGr05s8kNRJXf1H1cbzgcrbnGhjO?=
 =?us-ascii?Q?F7a/qWbr5uenh9KtMlEbmHJC7Pwcc7YoQUtEXwGO5FsEqNx0Phvn8tdCUtII?=
 =?us-ascii?Q?Tn4k/LkGbdnRM2srlRomfYnphEOe4rlZJtgMDRhPyHzXLOyKS5+6kpc92tkB?=
 =?us-ascii?Q?y4LgfxE6tZJEFrP4Csd3a4l4uO49xbN3vCf4VLjtx5J4+XJSgK1GaI88YpQl?=
 =?us-ascii?Q?kUkq+051LvLs4Qatjs8F6ACt99yXWYW/l+8G8H8o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6aea66-e567-4366-df23-08da6499e6ae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:39.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPmX/Zch6yg0lO9L0lxUcXqAR76910xpni7gLx7+myPrQkH+4J1iSJz9tZKkmGRQsPa79/jwH59J6OmEpjEzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
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

