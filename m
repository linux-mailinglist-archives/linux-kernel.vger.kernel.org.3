Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF11579448
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiGSHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiGSHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:03 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10060.outbound.protection.outlook.com [40.107.1.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221B33E0B;
        Tue, 19 Jul 2022 00:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA8H6E9APuzm76t4qkv9hfM9EYNHXniDJKFwKAcDG8w8HAfvIwpQBVoh+gfE4o6f1doBAB3uRaVRr1rkjABJAbnD2DxKaHsGf+fs2yO2b0uMS/J9M7ka5Dv/Zqb7fbGjPWNbMpPE8vlFc3RlEmUAuAMTfQez/SIIsH2Cw7Wzwn0kS89IUH4bTBLxXfv4FOrx0oQLpp2AoXNaVGSqgnzKUhawUX2uMNu5PL+qO7aJv5woD0LdfTn3QGfwKD42ydmSgeslelmikvG2AMbZfjxPatJJpen4QXmTMb8OjoSOhPQm4konvPhc28/pJBOCpenminFYU9VEEFgyIK+Ti/7a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEvGDtRtUUaVLnF0enYGBbOlqxgnL/kZQbvzFeodQ/w=;
 b=htCcK25nozjZi9P9tuZyGE7V3+xASh0s9rQgOH8IJhxBLZQQGlSfZwxONP4RXcb++WqFeEzPxXgrTfl2NyhbD85exZRMm/NLx0w1QcuWpxgswwvCzE9lzk1WvCqt0lIbPdwx60mJ8ZWNC5jPXlf/BlLw9zPuH9So76YxCzQzyAKHK5ijCux2kEYqT1sc2mqoUP9AZJw6urXuFuWqnsBCLdFSSJZcdLBUQ5h0dOlsFQcUnUE8nsn9m+DIbSxU/1hr0AZpHLlPmWcay9PYZUBkms+t4jjrl7bfB1CkDW2OgtKE6gc7yje/A36BQ2MU1PchRycQCdjUCrmqrl5tEPpJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEvGDtRtUUaVLnF0enYGBbOlqxgnL/kZQbvzFeodQ/w=;
 b=YO0zeJuEx6qemiw0WuxV9gFnT1V7qC0m4/QGoh3l17K/OIg+W65iLTnAwWO1xMLkSDlljjL79JkALC8XcR2+5BYBXamZX9Vy+DF2W/03sNkbW30Hri0Lm50v8wAA6HwGZEhSEteAKtk8sQ4yOcjeuUrEA6IGMVdmF1iflW4huok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:33:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:33:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Tue, 19 Jul 2022 15:35:35 +0800
Message-Id: <20220719073541.197788-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7230e0b6-3442-42b5-b42e-08da69590b3d
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhj3iHecmoM6Ju6lKyICd4QYhzv4r5/Gue63Npu1RHwML7WqpredSRReA3lioaKgI7hil58f3Dc2ANAE+0uORxlmHLNvGYm0ZTSZizlNF5DCcuF4oF1S040PPgBWxoLHJzqU5TDSysoblyJOKdmC22BTuP0TZwgMVJcYqeWnwg3iUPYY4L1fNvBAVKQuVnJPNKARLWnRf2jRq6uMzb4zBnYbi845uvCaXOP/r4ao02EcaIG0XzeE0d6itoT4DmzINdQUPp32QH20CWPWEtC6YcmaiG4rnhh6ltML+qgyLFSce1T2gyq4waVZIu6AYQxK35vJxCUWizVkBQvw/Jr5XD2Gw3E7iWSD7krc5sflqnSWYrOj9JfUe3kEpPOwMENUVym7hKrRAlTFbt/5JGM7h6/Q07FMFHjS4muHdP/ojgeb+inhGpbY1I16wCP/J/KJmlrx7Y4DLQ11lyN1hiph+p2cOcIvKl8IKWLC2PHiD5tuZ5z5em9H8zJN9al8l2dz9BbaLimzQu6iX59sNDn2jEjqgZP0Ww2usp1gCwQRPOYn44A6ndIAz0+ACcU+NVDQrqu7/f4in9pTHNCuTfV9f44L8GsI+njCjlqjbYdOaLFDXeNbnWg+1iik5PS3hb427Y9V4ZUwDgPcWjy0DqvdazD0fXg07eUXVV7ppGzkNc2JbLuDV2N9YxYesqkgSn6p0BYfQQdUAcxi99xLVr6T94cgQbWJZr5nAaArCa1T7AixCYTzwgMoBuMDyIFPkJZKA8jdBhbQ8ZPS8VGZu0B03AbEFCFi9ZC+jSTagr8CuNe3pOoOoIPk5Z6Eo/upBFjzPhtXCfd7NZnGNG7Iu8gfbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(38350700002)(38100700002)(316002)(66556008)(66946007)(8676002)(4326008)(66476007)(186003)(26005)(2906002)(41300700001)(6666004)(478600001)(6512007)(83380400001)(7416002)(2616005)(8936002)(966005)(5660300002)(6486002)(86362001)(52116002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ayf62OZMLQA5ng7MbTIrjMD5UzQP7VIHzYNQzUAakgWHSXANy6c3k9DPYbBl?=
 =?us-ascii?Q?CtjnoDQgbMHckw3llzbtugQep/5sNGtmkCaFdk7oafnIsbX40rnEHsA67gHF?=
 =?us-ascii?Q?zxMhvoO2z6JUBbUrCm/Uq9EECOCUnpI7iwwieHJQMe3F8bOB8G2X+/2po7Cn?=
 =?us-ascii?Q?do+tba7MK9Yp4eh9tKeIhWjN1FtskgmEPkgHy5HJUDfa7FVPtdcjMCYg8Y7y?=
 =?us-ascii?Q?IOai8Wh+30nGa3e2HPEs3dxioPDVnddacu1yf5QaW4yTfACzCFGMVS+Gz+TV?=
 =?us-ascii?Q?iUytTu32mSJZhPou8X53N/dNzqqRo6PWF5zrtnn4YgcYb4NS0fB86KOb/QTA?=
 =?us-ascii?Q?h1Is2Q8/P9etmalH+K5AhynBAVdmJffs+GpGhYt4sK862g7LTP+kPBQCZ++7?=
 =?us-ascii?Q?bqffbhYKDBpF3p5aeu5qdC8VKrblzYVueK11v/+2HPTQrO8Nrqp+Q37RBB2i?=
 =?us-ascii?Q?5uxW4LxAqbeKzmy9cPTKIKK4toUCvUh5bJ8kvsqXDqyUl6081GWS5DuYLc4o?=
 =?us-ascii?Q?kwQngtf6Dv+y+B4dHiuWKgPF3lAdWCfr8UpME/mgIM9uRKKa4zcrgnbWarBr?=
 =?us-ascii?Q?zeHFOpBocWg13ewVEZTmMkM1VWq6FVfshi+mUqonjdLca/xvdkywkYUhoOEF?=
 =?us-ascii?Q?SDpas7z+S1gehsutPx6S24pivRRCPjwJFuQbX+d5t6+Hftn/kcCRu0bsXj//?=
 =?us-ascii?Q?vlnyu0N9KxyVyN8So/Sgt+ZratSgW+kWuBXEl98IUoDaY3CIDsrDrVi/AOxv?=
 =?us-ascii?Q?d55yMe3r067FX6z2M3MkjA2t1iI68+rM5ly/5jwlKkhLDRYLc7bDKF4oxP9B?=
 =?us-ascii?Q?Vp2U1b93JWvJon2Mc6MiUoBZxrw3ITrYoXzJFQxV98y+qO69z7Cq5HdwxenN?=
 =?us-ascii?Q?B54tcuHlPjj6Nq31nUHNl4fKGl8c+P7ulAANrZCfRfnbmBY5rGVgAWoWS72O?=
 =?us-ascii?Q?XYg67tEZYhU/i3poZcb2VYrZw4WlJtR+dU/p28GS4U97VKV9s5tccZFQfvh1?=
 =?us-ascii?Q?TDuEl9HTdasG13/Pb2EAVYg4fx4c55ekRt/SttffD94t1w5ydiUGwsLfBkK1?=
 =?us-ascii?Q?ANZSNkjlygU1QdQ5ElWxPcG4Z9Qv2hZfeADiAATcEoa4gt9MGlQ9iCX7pwTz?=
 =?us-ascii?Q?qz/x8o6Z2pUJ02qwkwm3EocME4JPVM5CyU2f0Luc3ppEqDxxhp4RdCPdmqu2?=
 =?us-ascii?Q?QgboQidrhXVJRUHQQbLzTbFbACLNd+LnfuTdSE0AxYlninxQoOCJakhtLkbp?=
 =?us-ascii?Q?2bFFrUldsT/T15eKl40YLIOkc232RaPeBbEWAouY2RPE2nmGewBK+QTvBNmh?=
 =?us-ascii?Q?uBxGOM/pT3f/bgTEEQVn7VNEDHfQ6hHGjquuj2Pl6BJyrylCcRBb98YOAxAz?=
 =?us-ascii?Q?XM4LdvrMIbP351Y7a4Mu+kIc6rLN5i2x/HRdjM3lk7NnSWVBd8GXKNYiQT5E?=
 =?us-ascii?Q?EX6uNF4UlFOLIN84y7N07hlsYYvdGNxpA47GSUkp78W/5FtRJDp0+MJ8NWQf?=
 =?us-ascii?Q?dUbxVBCtGbZR9l8bPI1mxilsNIKfWBH6ferlMimJ5TtlsLzprDL4H6C/7QPQ?=
 =?us-ascii?Q?KjTMtRAKDLtiVnZctE1nMSBHcZwUbf33MAiK/1UU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7230e0b6-3442-42b5-b42e-08da69590b3d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:33:59.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdJWmkkGqYVKQscIyISnTPRac4n/4Pkcg8ruY3S/KQfQ0nHHi5GoUMGd6WGnWNWCbZ5MOtWzsIdY5GlG0Ws+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7779
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Per Rob's comments to patch 1:
  Drop the ref to power-domain.yaml
  Describe each item of reg
 Per Randy's comment, drop duplicated support in Kconfig
 Per kernel test robot, use `void __iomem *` instead `void * __iomem`
 not default select PM_GENERIC_DOMAINS for SOC_IMX9
 
V5:
 Update bindings for SRC, remove the slices node
   Although there are several mix-slices, mem-slices, but actually
   they should work together, so I use one node to group a mix/mem with
   dual reg entries.
 Add SRC driver to include a driver to populate subnodes of SRC node
 Restructure SRC-PD driver, because slices node dropped.
 Drop the patch to export of_clk_bulk_get_all, which is not needed.

 https://lore.kernel.org/all/20220711062452.3575032-1-peng.fan@oss.nxp.com/

V4:
 Correct including fsl,imx93-power.h, not imx93-power.h in driver

V3:
  Move src yaml to power directory.
  Update slice name to slices

V2:
  yaml fix

This patchset is to support i.MX93 SRC and mediamix blk ctrl.
SRC functions as power domain provider as i.MX8M GPC.
mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
software view.

Export of_clk_bulk_get_all for driver usage.

Add bindings and dts node

Peng Fan (6):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 +++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  96 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  37 ++
 drivers/soc/imx/Kconfig                       |   8 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 333 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 163 +++++++++
 drivers/soc/imx/imx93-src.c                   |  32 ++
 include/dt-bindings/power/fsl,imx93-power.h   |  15 +
 9 files changed, 765 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.25.1

