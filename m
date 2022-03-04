Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CE4CD78D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiCDPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCDPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:20:17 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006DF1C2F7B;
        Fri,  4 Mar 2022 07:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk2L+3xpGsbbyMgH/N1jLikZrvwGw1oR/2XB59oEAI3TmbF5ELRP17JArgNoKzXhotDtePKYsk5vIlBoOcmt0FxVUlJiuH/TF1Y/01P2o1OCyUO7K1UW9nBa8Vxe46T3WSsTV6g8OBSa8SJaj7z6xA3XoQgPDfTI5UHBc7lKCiEENMZ3CG/fYzThNBVaM5jvmsPSWTnQoAvA9thv+5rxUhYiMpYkXErpjO6Z8n3Z7kqFtJR88/6uW3feDz/4BKOuAG7kElqQTEO9gdO6OVg+u8v6R9lmGB23W2SYEZ1EU2Zdg51ftZprbYqstDa0mb/+PltBiR9vrDpRo7xnsLECjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggs2OgmlzVfMuKzHdhiUmE67p42UV0skt88COVDX/fc=;
 b=U3YdGtlji/4uBCPprYDe7DOXNkz6wlf9C9TwWXt+fRmojHIaDMQfb6y9Rzym0RqkHegGIEFIY9VDdScvn4b1roYzAswNWsWdaMoU7NJukJjk6QVjTGOOUoD49rZgeS9JlzGBjt1q+T4Wm7GSbA7z/lMyQaauA0e7z3LNqCTTOyqfRKnMPVTSbQTYchPb94nPbWZLJ4W6e73Vpw9LFg/Bw09dep3qsbm07sCArpVYlg8yxJ1ZdeLj5dZxOBliyV22D6jD4TfBaxySSJzlHki5rW9/DEjmOWpNgscrN7lFRTtbcefHzRCBWML6lG1HXpnMn4har/FcTbz2+ToymYe91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggs2OgmlzVfMuKzHdhiUmE67p42UV0skt88COVDX/fc=;
 b=EhdXKQGKyd3+f7M7d74Ulsywd/GONYwA202Wj2q1i3BVsi9pCRDifvMsg2wSpu18xyUQrRx4TfWE497RDc4C37GUhke50W8O/ygt9vxQUwB+bKpme0I/sjs9P1LRSRzOh4Q3PxTa5KfVdrO/6+bMF5mC+FYsEJX2jzOP9ld2kPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 15:19:26 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 15:19:26 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v5.18
Date:   Fri,  4 Mar 2022 17:17:43 +0200
Message-Id: <20220304151743.2731552-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0137.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::30) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f8b4cae-fc58-4e1f-3d02-08d9fdf25e89
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2758:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27587D0422FD7B9171CE1FB3F6059@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrkx6/3KAY5SexwPDLRnor3hUmf/Y6e8pTFLNvYxasH89/hy1qbe7MKubeu+vhoCWZX3taOW4876sp/lXsII5kcvAi7YLBYSRj2rRVbLJLpfVOI0THfQCsAkaEPN3I49l0h7MOUXZFIMmCCvTG8RA2P86MaDxKMlzbcjZppIRVxC4iU///VVBRK5aOhcxPJ2vQZ3ZIyFBQCCfKPlzh7nPVwJX+PtEGvCQnNc9gwkFL4IMkuPSqaYYIPwnyPV8UX+Ijxg3ncBr13MJ8jTDZJXo/Bl0+QgS+rNVGnRRc1mJ37pxYwfmV/w52AwVG1yGz5MpiIQ2lLbP0MRS7Pc/eBU0phSQA67ajbWbDOdaQKEuieNwQDiRZ89J95Kjv0RiuKIiDEapmcARuwi2keFRLNIg5wEJZfM6Ci3r7/HIqZkf8BNwCqLVHt0zYJIsp7zDPwnOhsiGPLVLsTSDUly0oLouPCN8KAFevE2JcAs6X9+m1+WZAMzo71Zxg7yzJCpz188FXAZ8hsSB7VhFLHYDL8HVlsLV8PJ/29LVCxdUh1hDYgVCnW0EMJeQorfqo+AupmfueY9rAv5WwNh7JStFk7nbQh9vCqnSkN3Or3LJGGn4dUqqDbogrZbgI5B34M6RjVGBhYGpwR8s6a7b+n5a+x6CwRxM0Cu/bz5wRdccssuV1htO2Or3ins2gdMLYNgIEnmaBpIB0lAaLZCS/vyG8Me6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(316002)(110136005)(1076003)(6506007)(6486002)(54906003)(83380400001)(86362001)(6512007)(508600001)(2616005)(8936002)(52116002)(44832011)(5660300002)(2906002)(66476007)(26005)(66946007)(66556008)(38350700002)(186003)(36756003)(38100700002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTSJR5AaElf6nvE2gKfUV3yz8tnmCM4UnxKZWcTnkmzVlCEyHIm9qfO921gr?=
 =?us-ascii?Q?7ebWvzSjRX/9WofU6U5E4sib0eFroReIOb1DnBa12JejTcZttgrOnSdFVXZy?=
 =?us-ascii?Q?J3+NipZ3pSGhXNO/PGe74r3wWRPjybN9cI3oiQss3AF3sI+Y1YUp7VJGjd4I?=
 =?us-ascii?Q?fqLjeWrOZNa4ZZmah4F9QDh9c2QoAE7DlDvOpfMsDzV/euC0lDFc1zaRSUgn?=
 =?us-ascii?Q?lSElfbnvTWIFP3pOhBP8RTGRln+SlAbfI5gfwe8ypHo7b+3L21DPHRKVjFjB?=
 =?us-ascii?Q?j3uHw8sR1bTJ2Uyqt4lrH6iZ9hrCT+ms06VYpat73tycx6W+rUhYQuFGRQD+?=
 =?us-ascii?Q?R88A984+hX8wu5+8pycgVq4+G6C6YLoC2ELAPyu44uDbWyM4bOlZLzGBZnba?=
 =?us-ascii?Q?1JN/L4CdTngfZVfXHR5O+K6d0vSwG6RPgkymEfLzaLknTaJguFV0DyJh7dIf?=
 =?us-ascii?Q?qdUlUbtf27neaw3X4qAqjJWOGZhCkODpU0vDMaW8zDXVIAXz9wSrnb7I+L1A?=
 =?us-ascii?Q?mawodawQFrDiWlZF5JzSrXbtDioZLbODUmtWkWIOkRH6/B7l5a2EdnJhfW03?=
 =?us-ascii?Q?H0zXA+otvKxrP8lFiseYLNmL4g7oa35H44hCCs8DF5al2IkWWhzFK7kLebQu?=
 =?us-ascii?Q?P2XaRpjX1rK0oqbmol74FXTSLfYFX6d5HKnQ/ItZuM79HVDT5dlaZCPrAoTG?=
 =?us-ascii?Q?PmU3lgHektlnQre/KgrRV7lJjanDIS8JJeDRutY4PzAsWZAU5JfX+T10j7IB?=
 =?us-ascii?Q?BayW++onHlszLCsPDYYHoNMc7i0YPnaXJL/n8CcvKUrykVC+fXqvH3NqbGye?=
 =?us-ascii?Q?n7Pd4Kp7fw//3gdXto+8XUG7QX9GXtJe8qyOcxHKmAaH1B3yvncvxxp384cd?=
 =?us-ascii?Q?e4CAaMmKZIaweUASdPjMICV+ora0OY/sC5p3Jyt+o6tn+imQMbBVvHutfEzu?=
 =?us-ascii?Q?reGrjFfJWWWAvF7IsJk+igxn7l5LBYNICw8pFnOOCAzjaN2IAnMC/yODwDXH?=
 =?us-ascii?Q?ZcBiJ0Hf6ihW30WNmhyQTdpMRLshl0EwXAHx7hC5As1qIPADnM4gWdz6dPDI?=
 =?us-ascii?Q?1/MBv0TaX7n0tY2VtGSZtwYdydXxpT2ydHwbPtFhXJmXAdsLNfE2y0DCEgow?=
 =?us-ascii?Q?eTwbSvd0dafm0YwFTYHwtsRDCA/lYiriuVvR/pUXtRcY1iAsmG6x6Eu29vFR?=
 =?us-ascii?Q?NnZqpQhaJ9xkdnaNRTK3l1VzlY1nrl7Qq7O4wU5b/SLH+rVKopAKy9/yEeBO?=
 =?us-ascii?Q?GsLC8XCDgx+VkE0oWkhr/u77tUVNzOQtqF74ZLEw76oUKjfFtlmi2PNczwZI?=
 =?us-ascii?Q?mScNYCHdEY/b9+oOhudAgGOBb9pFcBvGlrgih/2f1EbJ1RF2+SSlYv0I0qtp?=
 =?us-ascii?Q?H33xyb09uFBpZFnCU/mZOBnfLi5e72QYix6U8fToTHAZ1Ng0hkCUU9vK5b3N?=
 =?us-ascii?Q?TZLocX3KRnf67jYlqdh2RCyHQa5IYC0/jJNkiz3XT5lLF8hK5SWAmnr4QXpi?=
 =?us-ascii?Q?a364Z9wuk3kHaSk+dEgCBKeKXPXv9lC/7yRTYuogyHeQdDQFxALIlYSwR995?=
 =?us-ascii?Q?K233N6nGHcN3jJtr+MNybzP1mUEtj+hGfVYDaDZ58xwYCOwxJtHfwardYbC0?=
 =?us-ascii?Q?7nKahoX0avkcr/BSx/9VAEE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8b4cae-fc58-4e1f-3d02-08d9fdf25e89
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 15:19:26.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erhcIJLGQaPN3bvBI6RmvdmTIiFw60Fo9oL0IneOl/KpBqlJuon0yW+eK+76R7OUE1hkG9jBtnaeUFuGpNXNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.18

for you to fetch changes up to b09c68dc57c9d44071d83bb935b733f53ea2b2b4:

  clk: imx: pll14xx: Support dynamic rates (2022-03-04 17:06:30 +0200)

----------------------------------------------------------------
i.MX clock changes for 5.18

- Add i.MXRT1050 clock driver and bindings
- Add i.MX8DXL clock driver and bindings
- Add i.MX93 clock driver and bindings
- Remove SYS PLL 1/2 clock gates for i.MX8M*
- Remove AUDIO MCLK ROOT from i.MX7D
- Add fracn gppll clock type used by i.MX93
- Add new composite clock for i.MX93
- Add missing media mipi phy ref clock for i.MX8MP
- Fix off by one in imx_lpcg_parse_clks_from_dt
- Rework for the pll14xx

----------------------------------------------------------------
Abel Vesa (2):
      clk: imx7d: Remove audio_mclk_root_clk
      dt-bindings: fsl: scu: add imx8dxl scu clock support

Dan Carpenter (1):
      clk: imx: off by one in imx_lpcg_parse_clks_from_dt()

Giulio Benetti (1):
      dt-bindings: imx: Add clock binding for i.MXRT1050

Jacky Bai (1):
      clk: imx: Add imx8dxl clk driver

Jesse Taube (2):
      dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
      clk: imx: Add initial support for i.MXRT1050 clock driver

Laurent Pinchart (1):
      clk: imx8mp: Add missing IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT clock

Peng Fan (8):
      dt-bindings: clock: Add imx93 clock support
      dt-bindings: clock: add i.MX93 clock definition
      clk: imx: add i.MX93 composite clk
      clk: imx: support fracn gppll
      clk: imx: add i.MX93 clk
      clk: imx8mm: remove SYS PLL 1/2 clock gates
      clk: imx8mn: remove SYS PLL 1/2 clock gates
      clk: imx8mp: remove SYS PLL 1/2 clock gates

Sascha Hauer (8):
      clk: imx: pll14xx: Use register defines consistently
      clk: imx: pll14xx: Drop wrong shifting
      clk: imx: pll14xx: Use FIELD_GET/FIELD_PREP
      clk: imx: pll14xx: consolidate rate calculation
      clk: imx: pll14xx: name variables after usage
      clk: imx: pll14xx: explicitly return lowest rate
      clk: imx: pll14xx: Add pr_fmt
      clk: imx: pll14xx: Support dynamic rates

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   1 +
 .../devicetree/bindings/clock/imx93-clock.yaml     |  62 ++++
 .../devicetree/bindings/clock/imxrt1050-clock.yaml |  67 ++++
 drivers/clk/imx/Kconfig                            |  13 +
 drivers/clk/imx/Makefile                           |   8 +-
 drivers/clk/imx/clk-composite-93.c                 |  93 ++++++
 drivers/clk/imx/clk-fracn-gppll.c                  | 323 +++++++++++++++++++
 drivers/clk/imx/clk-imx7d.c                        |   1 -
 drivers/clk/imx/clk-imx8dxl-rsrc.c                 |  66 ++++
 drivers/clk/imx/clk-imx8mm.c                       |  49 +--
 drivers/clk/imx/clk-imx8mn.c                       |  50 +--
 drivers/clk/imx/clk-imx8mp.c                       |  49 +--
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |   2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   1 +
 drivers/clk/imx/clk-imx93.c                        | 341 +++++++++++++++++++++
 drivers/clk/imx/clk-imxrt1050.c                    | 168 ++++++++++
 drivers/clk/imx/clk-pll14xx.c                      | 287 +++++++++++------
 drivers/clk/imx/clk-scu.h                          |   1 +
 drivers/clk/imx/clk.h                              |  30 ++
 include/dt-bindings/clock/imx93-clock.h            | 201 ++++++++++++
 include/dt-bindings/clock/imxrt1050-clock.h        |  72 +++++
 21 files changed, 1690 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx8dxl-rsrc.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 drivers/clk/imx/clk-imxrt1050.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
