Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12665ADDF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiIFD1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiIFD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:26:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC14B0CD;
        Mon,  5 Sep 2022 20:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7zHKpPYcsQPHOyolYiK0jE40KJnG5gOt7QnXk5iAN8SVC6Z1bXnqqGjehn1bXbTyA1ZyTw7gLRFjIw1bEapfsDBJmoimVWxUUuWHYU0RxhP8AiADfoMiOp3X22b/x3dNVfJFJyYdHfc1vgIuUCWYsTorPaBAj6Ryq0rxISaCrs3eJdS8KpFoyH6c/HewDpHjHI2DQzFiTJH3WJAuicjZlsK2akJbMrCq0Tt/UuOpo8obQREHvd/V1RnK+cuTu1fA+WdDge2NZLehUc8yZt1roGi/HHQxbXQ3W/+IdDWYHP2kf0zprBHO/i1fBmlIfGyOb3tiwlqeThwu9ymtfqUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzYhXHN9IyzNWzV1o49KCelokyHeV29nBZe91oXiO/k=;
 b=UbThSxZ4P2Zj1eJXsddN+5HzKFWRqISU5y9jk1gpWBE2xpA2TYz1oxDiM62gmf26fE0/+bW+DUk74G64UY+y2efkL5Kazk/R+dahotr+klWWuTfuVCKRgIdiQzlJq4U/RWwycbzYCbX5+5ZHH7hDnJpwQ3Eppnaj47iHX8C502bpb4IW2FDUDIdcyF0OHmUiCIz2L8HcYLxjwDvwEYuPUPz3/lLWoq8Mz4esgzn/LPrwiLvw2LT1p9WHNluiPaAdqCMK36bUQMoDkPPcAC1DNhh+c9c3IsHN9dH6gqNSCsldZAZc9KLEhfLHXrOmp/g9Raq/qVH795veM9qyakD1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzYhXHN9IyzNWzV1o49KCelokyHeV29nBZe91oXiO/k=;
 b=FcjSv1ch+H46E3BMZtyCYdFvCJFh3pKkNtkyiGNCkRk5N90LZum+TRbmd4TDFcC4PJfx3wBX/QWkhrKF2sPMRPZIIn/rZC/NxsGH+DpvfjEtkhq/UxXmxOtjw5l55+1YEC4D6Yj1Ns45ze92WEvpznugzqs2F4I7lLvpaS8nkUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:26:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:26:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V9 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Tue,  6 Sep 2022 11:28:11 +0800
Message-Id: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d67b8ad-79ee-4fae-33f6-08da8fb79df5
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHEx/coKDMf6wHsBKehDdDSUM0oAYR0ABtr1UKAzDAfJN18S0rO3zU/oCcI1Z5hRxKqAHjnEPEWnS4p878PGXzIFggHAxzSaq9cCcRmy1zm+pgdIsy6iYAlxTYyJAqV+Ryi0puoFOd2UTpdBtVZ7RSvV/o4xYaSccVJVMg+HkXXonqcrvpWZU0+xDJ7sQCV5I2iI5WTqohJjCENHR+rruwbe9b5zk58tguijXF0lWTvWbZDfITagCB9KP8cCvyljCWNF5ggmgNHQVXc7l6s6fU9Q+FPSut/0vLYyVkyvOPmn2Y0r9kk3YKkeqBnAXVfaG+WCei037+gdolvidFc8RvxUyPML4GkI+W9OBeDeq9ZtPvMAftX20SMEuAtsXhehebJ7ZdIwvMy0BJUACniAG5Ogz0GJt03DnEruc63kKl8ZAMk78tE3p4ceb7p4OQ5Tgu2zr257IbKPDfAdGLzyE3zoWgR6e/AAXOoz8zHXy3ode0/UgVClfDxyCbSIK7ix5mVgK4q7sdxwoyLraK9InTc+3k+Pu0smT/wZg84H4cOzfL29mMDjO8genS7TFtaULpdXlXc6otKZQprrjRrLMhvqfFw9IMWnwutq8nwPjexbvGEn5jMnaS/B+w5Q3OA1QRnaDEL8ZSF+dFS2eUt094zkyksKPhj2ovdj5eQNJfPHNTJpWEvuxWv+3pqZ6b8CSY9j/mwcj9LRxPp8MmuUtY6x5bYhLCxWvKgpeoz+p7AU8tPLF6M8Om8SguAI1cLH0iemLqoMxqAtusZEZPjw0FlOfvxSVjxLx6gPlJlQXTrwn4soAuMT7DFpzIJGkEXYehfJMdcmuXT2rLCeQjZb4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(966005)(6512007)(6506007)(6666004)(52116002)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jV6UTElK/8qImIXUbn3/Ve6e0sMW8JSJJk6bwwjhIdWMnrw7N+b8vllzQmKa?=
 =?us-ascii?Q?K8Zw/LuicbBpLQqj/geX2e0JHEZUpvqNWX+Yy3531guG48ELFpqYXFLShJo3?=
 =?us-ascii?Q?uOTP7+NG4SolRsW9JqTIH2Bp9gQ7nuxxXysbTZDVXkAMY5sWCKZI7fYWGVm+?=
 =?us-ascii?Q?3BCR80o79LoSPZXq6b0wVB/bYQYKxtfHdCD882vuwoUz33Gmay+J/1b+dt99?=
 =?us-ascii?Q?rUcy0h20OXT5KPuhT9pgRV3veCLZb6qYWzZaoNAbzagLUaK6UsP40hQZ+G2l?=
 =?us-ascii?Q?H836gkUZFGoEcxVxnnJZvWIhc2V7IF4J2CcWCUiGVPIRaxlfDD9YuUqmu3Rh?=
 =?us-ascii?Q?qZIg5S3eX7h6UEjTbzilU/YGgotVMZv/K8wF50K5r/MXq3X+tcgVBu0TLlQd?=
 =?us-ascii?Q?BihbSvZNWfpbGYZUfTxdPJJNx0ElfjH0U8x9NkcccwfCEiIFRPJFMarUIq3L?=
 =?us-ascii?Q?HOQHhjRiyDrI4oA8DXy4AFL358Dl84r1hKXynSDDtTUWM8G91q+hNAbzu3Xu?=
 =?us-ascii?Q?SbLLGDkpVINaMurMCukAXBnCBfZ5MEI1myj8iPanrUsCOl+Dt4iODHW46zKD?=
 =?us-ascii?Q?+TsnanEoc9p8QjV2DA1+/8S5Ae9Rjx5uA4Wqt+LjDcjneXlFgELWDETSAwvq?=
 =?us-ascii?Q?8RFCRdO5ZyhXgJh3cXahJxuJV2Iw9qpjA8m38FaYze88ktnEUNdlLgUFFveG?=
 =?us-ascii?Q?zXdYF3iA2KsFPyrIqzM8UQxnqZ4mC100B7nKyfTJ30ndeL0kTDmC5mVhMiV9?=
 =?us-ascii?Q?o4emyeo+tQknJmeJT04pljgadEg38s6u4NoDJGVO1pWt0ynhZW7S+vAB0tyW?=
 =?us-ascii?Q?0QUjXh8ALc3zteChzGz+tobD+h26fKwqvunALuhT7XlkbHW4xo1yg0d3GiMY?=
 =?us-ascii?Q?xnP9/CqYSrp8VOHQmOBxe5EvmsRxxbWdt4S+OHFLVegQJtb3fMpRMGxzOjqK?=
 =?us-ascii?Q?z99nj2zcqhwzJrnNqWv9NMOP/tESAcakLwbjdg5l0ktkLRcXEL8FlQVKof88?=
 =?us-ascii?Q?ZvkChRkX/zjO54xHDrZMchaHvtxuLvGoYusMnYhAGT8MlfKY3xXXSA+jR1YN?=
 =?us-ascii?Q?BQZlIPav0v6czi6DJxL3dk579ATow9TXIxrFGy2PynGw4Ga73j3GzrLIfsaR?=
 =?us-ascii?Q?Hz7otwT1sdaBERwtnNX7JBpy0X5Iol1WGz4jtv8OGWnI5Pfqc46JGueRBlfI?=
 =?us-ascii?Q?BJ7XvDnwFphq7++BAbVYfNhSBME4yiaJOHQeba9rP5pBrp37xd03XA4fRyxs?=
 =?us-ascii?Q?TPkgA0Ww4NizmAZ9Ei2Vfw+hxQzhwXpYyLLcyOLMw9kZQAqqOPZk0q/ymTW3?=
 =?us-ascii?Q?5XwObJNBZxvN1cXLIocSJUlLlpdNNch3ZYTa6sgnhVq5lRJewfXCAftSFo8I?=
 =?us-ascii?Q?RJD5IqSwwSBATS5MUm2sNzMTGjj3lLL+6R8bpD5DFa9asBtVD/5dPjEEZQEk?=
 =?us-ascii?Q?h8uS/6VY3iA6d7uEnModu71kxHO7UL+AJvZfmISLGECfYp0fhH+fggU8LqHC?=
 =?us-ascii?Q?pfa+NQCWV7GMB6cHvSfi0OYpo4j39rSOO7MIbbN9DCaPc/D7W2k8W3HEYKxI?=
 =?us-ascii?Q?w2oUorkS1LlKQj8k5YqmYQE8OL5RZBpbv43JVP9X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d67b8ad-79ee-4fae-33f6-08da8fb79df5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:26:42.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsxChuRpslff+XmfnXADA2oHgS046hIp/FbC4QishNX/T6t0JGS7Eqx+dlYTHVfMngQLR/uxMexONPIbsVZahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V9:
 Per Shawn's comments in patch 3:
  License still keep GPL per ./Documentation/process/license-rules.rst
  Sort header in patch 3
  Update of_device_id variable to be driver specific

 Per Shawn's comments in patch 4:
   Drop: Reported-by: kernel test robot
   imx93-blk-ctrl.o in a separate line in Makefile
   Move reg_access_table from imx93_blk_ctrl_domain_data to imx93_blk_ctrl_data
   Drop 'const struct imx93_blk_ctrl_domain_data *bus', and add related fields in imx93_blk_ctrl_data 
   Use genpd_xlate_onecell
   Drop extra uneccesary domain allocation in probe
   Align indent
   License still keep GPL per ./Documentation/process/license-rules.rst

 Shawn:
  patch 5, 6 may conflict with [1], because both patchsets are based on linux-next/master.
  If this patchset goes fast, I could rebase [1].
  If [1] goes fast, I could rebase patch 5, 6 in this patchset. But if the binding or driver is
  good, I hope you could pick binding/driver first, I rebase patch 5,6 in a separate patch later.

  [1] https://lore.kernel.org/all/20220905055915.3878000-1-peng.fan@oss.nxp.com/

V8:
 Fix error reported by kernel test robot

V7:
 Added R-b for dt-bindings
 Addressed Shawn's comments for patch 3, 4
 Included NoC default settings in patch in patch 4
 Use regmap access table to restrict the access to blk-ctrl register in patch 4
 Update node name in patch 5, 6

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

Add bindings and dts node

Peng Fan (6):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 ++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  96 ++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  45 ++
 drivers/soc/imx/Kconfig                       |   8 +
 drivers/soc/imx/Makefile                      |   2 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 436 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 164 +++++++
 drivers/soc/imx/imx93-src.c                   |  33 ++
 include/dt-bindings/power/fsl,imx93-power.h   |  15 +
 9 files changed, 879 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.37.1

