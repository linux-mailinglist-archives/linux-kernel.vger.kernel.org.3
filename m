Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E157E1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiGVM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiGVM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C08389A67;
        Fri, 22 Jul 2022 05:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brm2RfJeaUnQZBbdS69WwbF2TyYWAGx1yAa9kgrng1bRw5SCqCq6Xlq3EtLL3C2RVjDVPG+EonlCTy3mxFBsdIghMe6uhrDxYS4DA8gHZyjZTGnrFt+jcQLdjYMhBlIOeNpki+cu/jL9bd+4f/Kc1Da+8gHEx2ZYK4F4VHu4eOAxQi4qbn178QuFeHo+fVW5SeVC3o/rop1BpJhWZe03fJG5bE3OYBBkmx/gJuAnfR1+cfoG3jkyVu8G47HweuvXFUjDKaPD5dAA8kHyYEwKAWHOEgQMeSxjwE0dv6hQv7KjCdEEdfRLs6wOLJBdmr7clQFH8gP2nF25wNjySbahJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=Tr9BBwhBUGPug11M2I22PSQyDL1uS2egi5xyvgDPBD9fkY9WvrYIMO78gIbentmv5flfJF048gv2xaI41s8CkKyE6a80wGP7QvNN3P4l/bWL0hf1TaWtRRqaAPXK2E2B+DnZTxVHXbmWKdIZZGjz0P1uebAXhMmS+FljByyNdBzyQgIb9EmD7yrA1u/5SCmzT0AOYKg9GrlBSVgHoej5ohxXUVhVxKj0WF+5OkjKrXEIY3e/tT92jSpO++9BAcyPYHJHG73dDfr6umsCbSx/fi53Lz4Joup0xoObAUfJkkX2fHCm4C/Kh1PUJqmBLHlOopIP1YjOUXc8GZ2fUGK5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM365LBdpNUJ4DBMcCB1kcUJvlq3cWNvwwLGwAFk7l8=;
 b=O6duJ16aO3KCVMiOaDnbkdhTel677u+0hL3Kw3oe2Rd86Pe8Bk0bdBCARa3Z5XsamGIJpKno6U8GHC26JweRsWBo7Ue1JrbRqH5+PfSnZbIVTN9C19Xq0xpDGCUG5O4MUxZvqYpmYi49zhn0noq7F1yWQt9aFWN6XXDA5EvZ2Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3565.eurprd04.prod.outlook.com (2603:10a6:803:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:56:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:29 +0000
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
Subject: [PATCH V4 6/8] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Date:   Fri, 22 Jul 2022 20:57:28 +0800
Message-Id: <20220722125730.3428017-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f3981c-8f96-42b6-a4bd-08da6be19822
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3565:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQJyVjFbdAmYm+wVaQqb0OZVtznwiwq07TsW5oYgcNUc+OpNqPB9mAQvpVnHbf2u9CREROZkr8V88t4treQMeL1pEYkOkuLlqj7sQmUM2JCp7DOy8OpuCkMyTtca92wgGXPwV71QoUa+PLmvWswwmzgzoGr3FcqTsB9qqbNjGS1wuRDRdsDbJBF9GFTywThJgZzCudhbcv19p9Y6tA223yJlVbxC3WbQQg3jpUj41D/wcZFUMpVGD+ZWGrQsZ2PVmIAwUSnI8MnGdAUtn5LfH4honehQgVxwdmo+Fn1GawV0U7n0lmschiOVH7iLadBKfrSt53CYaf6+rqXJWauqRxV2oSbbBEF2y2IkYLoRH777pp6ajjZlnxwxp9qxHGlVcjfdOrD3+9Rt64dTpfFuHrX7AdZrtyW+SCPkUa/aaLXoBQax/EglbdrCn9CTdnK22DXWbbID6ngZl2JlCJoE1gBOMTMVaosF9jHtDDDD/hIOVJOQBEjaGHIhu/5MLSrGxTzDBcgpjl3NfsNzar/DPwkX35hoCSXWy0Drb5mYZEQMdVyZQSxB3iBXuXj1Ooma7e2NzuNhibkKlcq59OoyLukEtDPf0n9DVwuQdILninX8VcqIPX2es/A/D3RYmOhnhKRw0TYQaxoJhOie71OvvXFOzNm4R5rQNuDIdKUcWf4TKcmtkQM/5wNnrGDfqUJbDOqcYphRNLMjxclvkxDJ3Q4raV3JL2NTzzCWaPhhhDbO2tK9x7a0NY/QbQgNIuRUGjUa3JkGxWoz/ZWnFy8sPzzrVaquga+RpwBFI8aRT1JGwoyVKr0c8cTirmuOx1bSOP9VM45zUOfkOxWtoh9Bww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(186003)(1076003)(26005)(86362001)(38100700002)(6506007)(6512007)(52116002)(83380400001)(316002)(41300700001)(66476007)(66946007)(2906002)(38350700002)(4326008)(7416002)(478600001)(5660300002)(8936002)(66556008)(8676002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0e5aQbb7SYn/jUj8bmZR9ppd/v/7P9Bu/xYzvqin2fEm3moIvUcfCVMqUDt?=
 =?us-ascii?Q?ayomn68w6iu52hZ6v9eHW/MIFfgHN2oBV8HwiP5jciIHHSXI62+8//37QCw1?=
 =?us-ascii?Q?QaiN5LtO5G62j/sEPfR4GMUpYTw4OkRxS9D4BoaC2pOyuDg5tY1/1H/W06Uw?=
 =?us-ascii?Q?Jyqb1EkUb/+sBuFVoWm3GJY2r/uGwonrRBjNihRlTNv0w1OWZSmUx34SqK5w?=
 =?us-ascii?Q?Dz6/manVl+4XZY/o1FgBqtSmOOcLBBIciSxnChSHxWOctkjstOkuipiBuQnF?=
 =?us-ascii?Q?0Z8yqfkTS+87/Cjx0/aym0Vkp0WmQLn+wyryUEsllWSxXnKeHqRkK/zqiOdy?=
 =?us-ascii?Q?v7j7S7ws8nyKIga8zao61z9tfCADZuJZnUqPU7LsYowE7xSTJzKlkyzRA4YB?=
 =?us-ascii?Q?+dc3PvIjW/E6ltBlgfeo63B+eKjNTK7jwG6oKr5TSCmk2L0nAqhzK2XDpkW3?=
 =?us-ascii?Q?W7hfyr3bm+GCvj4CWCpN1vu30UIc0VEqPALxuGAVEq64FNv/Ro+/Kp9imr7Y?=
 =?us-ascii?Q?Aac7Hn0v/mTAfPvhFLjyMW7hEKJSS71HqBMC69CH5XG++wvKp0AhCGw8fKST?=
 =?us-ascii?Q?MENKUeZfM2j8FVdyjsXMPVjWJ4/HeYXyl3NrqRPM5qlV2E/5MaOPZTJnRFOM?=
 =?us-ascii?Q?MkFhSqIV0+B0TDZ72XKmeJT/LugOlf7B6cX2yf9tHUjD2RjMw+mfAgKAN7my?=
 =?us-ascii?Q?OBHNrjPodOcTcq2/1tArDxI9VPun45C/eMg0EYEpQyZpyYzNdznRxrRO0dAu?=
 =?us-ascii?Q?lRt6Fjl5mLgbttgB3ZYdrslYT/OzrDbyN0A6wYSMbsXC320+hIqis4NTdWav?=
 =?us-ascii?Q?wdUW4A2In7vZBKwHsSwQaeM8HGHyPv+vw9AG7kKtwZVb8GUfHsssYFQUvgDB?=
 =?us-ascii?Q?FCWdSZpR8agaLqqVZ1O7OFwbWf1ZVLh7+FURr/n+xF9LGiIz8vNAZIEBojUw?=
 =?us-ascii?Q?Ux/VNjd/CdjL8/XNlB305ZsrPbzimOKd4SfnYc76Fcl/dO7HWTWvA3TnmMb5?=
 =?us-ascii?Q?301rtQxuynYPdMvOTuis45443bJKeKTXF1Dnyiwxvf142KdrorPNs83O47Dc?=
 =?us-ascii?Q?SNF0qCyF1NsbWgEa2A/B98jqXkoovXGwvb83e/HNM08V6KQ19EcAK67nSn24?=
 =?us-ascii?Q?JF8Wn6CHqSc0dDEIFOBveJjH0KvaMwNf4dZTDE3QgHTWRB8EUV4v1GqxErZ+?=
 =?us-ascii?Q?99CeK2spAPCpe8PO+Kq49No+G7DDRy57H6JVdTOSY7KLrFvfQ9aiR1ReRAX2?=
 =?us-ascii?Q?Y/sD5GueRFvEgcwS4TbZQv15oTjk379xLzl0JMFvIA/Jk4AiOnP+g4VK+Oj6?=
 =?us-ascii?Q?Kzy/V9x+KqyV/QzmYfCyp99nSotDZdWlbZPodNqa83mR6WBd2sfvLFMiwJkk?=
 =?us-ascii?Q?Gy8diAZE8gm6JVzXYUiBOym71KB3r36uC4yLEWMEsW5SbVJIJ28L2WEPg4F7?=
 =?us-ascii?Q?yxyY6DVy29O5Ygh19MwKv80ZNvUE2ZN6l9RlCHrUWkYEAGB1BdZwPmVaBzPP?=
 =?us-ascii?Q?nqhibxcli9Oj850p3/7hBNMc/+/ct7c1+ApucU+FC+BcwSWBET4M9pvfUSjx?=
 =?us-ascii?Q?+BMeRFFxnqFKDkNB/Y6Q1vRn8uC1tN285ekLWnB0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f3981c-8f96-42b6-a4bd-08da6be19822
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:29.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh/RCGdqKQgY2b4mAbX3Tqd9EKdBvWt2jX3Wmaxu2CFv7TFgPa1xHULwQNhflZmp3/S5EWVkyieG0zcR0HUnPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3565
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

