Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAC57E1BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiGVM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiGVM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4513A8961;
        Fri, 22 Jul 2022 05:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLnfiyZ2P2AZnwmiUktIv7uuAdPcmUkNNnz2jRv+lN7d1ywYO5IOos8OV1eqMXoc/FBzUsAl8LJbB95aHEr1BcS8AxTpu4XCOy7PJZtMbck0TAUMSBy+ZwWcaRxkZ7FszvNkwMvPh1FMp1oq7RoJX0q6rccZcvw2o5nL8hzwx2qpwLo5YdZ5jcAuY5TClVWZwZ4T/E2K5JcfoLDCsyMPzO12/ki8d64GHOvYf8PoXw5uldJAGPqRzMeqw1SCIJBUxidA+YG6U75IMc0d2uZ5GjTRgKDHyPqB6f1fv2Z9EqKBiV5tFHIIa+ItiypkcT0qaiGGP6fVIB81pa00UJIKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=EdQGXaDRhBDc/kQaMkSzEhFnfxI5TRQl7ljgGBLwQCi/NBUoYn5K5M5v7FnBvyGhjvh4rdNKBjKmtU7LS8TCHPY1q8cMz+XJ8dIV4jKyLJ1fRrmrifrKMgPPI+QYTv+2MO5f/lAY8Rv9qvlT9B/Lv4uHSTfCUhkQMPb9Lawb8WEld2+b8bsMYr5xe1Ez44KeOhIvtbvk7jzxyVmV8pQm35PYUc58jxvfWSZvithB6VEmQ282T3mKExCyJoEjABwMqdXRMRSxvSPAkEe1RgyHDBE8iMe/aYrpAA8HPcp8dbxyG3YQgxQkrMl5XxFIYUc/y0b2q4Omhl1LQgEfxFDpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=YerYeIRQLRauGt62huGIuq4drU9IkPr41NyEGNJvGXCfcmyemdixr65DmXe+IvHT60EHLS9piggds+AeFb4utltcicGb5iPNDpB+qcVWPWbCHTamFrL/v9u2APU7quHgg2yHXuSk62pBpNc6KwpRUjPb1H8pXVfUpGtjBezlt8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3565.eurprd04.prod.outlook.com (2603:10a6:803:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:56:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:23 +0000
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
Subject: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Date:   Fri, 22 Jul 2022 20:57:27 +0800
Message-Id: <20220722125730.3428017-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 944ec217-a118-48ba-b641-08da6be194dd
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3565:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNpSMQ7lmACtxhUZNNQmwaByFFjYSKbP4osyU+YvXSQ7W7MYJ+3/WfNHUwuxZU8qQp1Feavy9s4/Tv4jPDJH3VMiUtwCTEMrMM5WTZi1AIgPCjoXokrczR00Ueo97aRE9jIPb0ru7JrSZ/sJe3lE9+9rjrVoJj+JdIT1ytlOkRuej4iuvcLP43sB7hjOUghsj8tJvi5nXXnStrWZisQK8Bf2AT31w6zz4goORqHfJ0saQrW6QsphQlDvoge5ngSZpb+LDEgNeQjJZVJN87IwW4WDnxR8jf1SoS2lwA4EXI1ptkIkd1DC4xERcDasiilK3EENUirccwa2JhvByI2sHRrYJBi6YHAzZsWkwpMv02XTD7Jw7Qv+QM2S1fyMIWqMNMCY61L942d6x1yJ5FNlIEXIjHEvmDZAlHOymBXTFayaZEDRS7d6LsfQvD+YpyMM4DigzfxvhRBgdWeNEMCVT04jZPMQ1LnCmZwF2hxPjL4pJqAeLaaF0nrS+Fpgo3dj4wWylHNR/vELk4+blmo2YSln5KFdfmueiaRBNyVY37GjoqXm3oWaz7pcS44l0b6ucor874dQE0GF3l7b5OrCXiocshCTtc3Qqasn953Alwsscm01YMenH7WNG6hsvQXj66r9gdP1LPCL0vfL5B91WSBcZFkmqxnv5v8V3KJII3HVoqELDMEyt/V5q1cao3jtNttd63z2C9EXvr8yJhAXWieSiqa6QfXJJ955piSDqAWF0MjdyU/Bih0WhTr0smHB8ZqZEXYRkMw4AeZmVUm36NW19pwFKJRumd8hyrczmRN36G2d4rsw29GBF46QxLyD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(186003)(1076003)(26005)(86362001)(38100700002)(6506007)(6512007)(52116002)(316002)(41300700001)(66476007)(66946007)(2906002)(38350700002)(4326008)(7416002)(478600001)(5660300002)(8936002)(66556008)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCS8wt/t6+EclXbzXcOMQWY4KJHsejuC4hSemG+NyqII30wDKMhchWIR3QsL?=
 =?us-ascii?Q?L9vveUwthlqxJKyfJyv6l12pO4QCY0PkT1PbKi4/VoE2ftYQQT33u6ZP7bC6?=
 =?us-ascii?Q?CgPFR7ZFN8qORVfaaC5it+mM5ZGgcny0Rxp+Ik/0oiHvb7qY/If85sHTPv/W?=
 =?us-ascii?Q?ITaHFRvLJM+TO3Q8og0L0yq5xA/LMcp/3ZHuoIIdunWLLUQL79zFjoPCnokV?=
 =?us-ascii?Q?/LvXKlcphqVN03XNXyMe4a96qeiDYGKO92lYfl2FOkL4Lc7U8YCXdAxtLceI?=
 =?us-ascii?Q?h7OM7LN/BpMv0GtbvVdBk2riAieSLdmCo55dNpAbzLvgwYDbhabt8YIUwgDA?=
 =?us-ascii?Q?Pwq8dQSO8wxbsdd39o71VyrlPJjsU+uU8jtC55y/fwh4Xpui5tc3ipWw4yMh?=
 =?us-ascii?Q?eCWASQi8F3tBxqQBAhzw6IWvKJF94v1AYokINNmWkkkUZZk4XYNh6sS2N/32?=
 =?us-ascii?Q?73VW8a5KSXotj2ALs/H7hYCuslB21Pu+DU16I5teZKrbA8DSsMaMBplWQSXw?=
 =?us-ascii?Q?LSDGyo08YcfcWYdFYn8YIkYSpfEJ+ZTd4DDRPAYQFDHLhgzObvHCfPld3afa?=
 =?us-ascii?Q?KF0b1xk8M8X1cvX9+cqeb+0FCWRrQw/8gux1RwlYFbFrIvfExDgPKlokIx10?=
 =?us-ascii?Q?m33UJUKTO9EfjL078R5o8A3FH6tHRqa+VAIwIEdkhWkl0+5T+AgZ1zRgQ1kW?=
 =?us-ascii?Q?pxtjQoL3RUKUbhfn/eM+Y6XvxWNyG07Hi6QNuvvkOQ3STcdpUAEDS0w0mEff?=
 =?us-ascii?Q?+qwP0mcqA8Jbvg7aLbJnOZhPkQkf+ZRuhEzOhJbYJpwztFhrhXK6wqm6/JW1?=
 =?us-ascii?Q?leppnWuoGZZWm46zEXw4k+tQBXVGBAxl1pMKundRiE9sXLdl+Q7IcvuRP77/?=
 =?us-ascii?Q?C+abgjDRG21RTbVAJMtjVwhOOGUvwE7LLzYLhiR6E2J6U1fH0PRTZXRhmlkW?=
 =?us-ascii?Q?4mZQkwC2Jxaco0y7eijctC+PxtWvgaJ3vtnsoaLFluiMNoNfG42yrROpgPzU?=
 =?us-ascii?Q?uLxtAUVRWc3Q0qyNlve58Dzi+qxMZWBjTUkEi3f4TNVrN4i7I1xgjni3+a3W?=
 =?us-ascii?Q?H67cP0ogMAOuR7Ycb7UXhxRpLuHzx3Kd024qUBS3clxmMB+1/PcXZRbZnmvc?=
 =?us-ascii?Q?aDhT8z8qMNyWcpnt1+3ccXFCjZB3e5JTCVLXtItNzG8pxdKjWAcSQKyOYEJ9?=
 =?us-ascii?Q?10DjsEyjMQGEUW/sLGBolsjnqfo8NnHStvXiVRb1eVdVUMJWXvdiUHOxy9gu?=
 =?us-ascii?Q?es3FRBBvMUgpTBDTUVEigeg9FWFwMZ6P9ReytP+sCI9YpewqvSwz4CDWbPWY?=
 =?us-ascii?Q?bbwQkGSFrdxqVeNLTc7sxkPqcLEHhkOUstjviG8MCQYBVzfXiwtAgrcPeENR?=
 =?us-ascii?Q?h+xCA9AON1EhCBFPiPhuuNWdiSi59iWk3VJQ71+oEfNwR3kWpBi0pFZQX6CN?=
 =?us-ascii?Q?sOqz6blQ8/KCxbfkRW5W9XXt1YCqkiPjbhjqHqoK0HxPEyXrzHjKE/jLNk5G?=
 =?us-ascii?Q?1Mbia9D3tPNKKNou+UC8dYEarFkr5Vny+KPuQU4E04mI4Njgj5nu0BWTtrIU?=
 =?us-ascii?Q?NjTp/nhCYhA41e5HxkLRpugCrugi7i58S85OR1Rw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944ec217-a118-48ba-b641-08da6be194dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:23.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alf6msfY0q0WoHsJrBTB9Y3t3Xk7xFSL41Xyx+djy1igzTKmDjoN9pbfI5VrkqiBpRkzgLvhSv266xGFpl1xtA==
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

