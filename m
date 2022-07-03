Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB856461B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiGCJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiGCJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0F6334;
        Sun,  3 Jul 2022 02:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHWi9lcp0AQRgbVkG3h8dzkJmkNQyoivZSFqHy7tv0btdppbIr22K3o7SSnUYKjRSTvSeYmmAFN15a1CIxCxjm6dRuqJdmVVtE8yUnoAvQPY4DyhYd68Qvte6AStss4UBJqxSuNKfXajC1CUgdISo7XBhsFanydKojiJWfaJuOirBdvjqGZ35wYvFYvY0YckW1hSAzvfHoRIJgw64M5hx+T7QrhgzaBgTImeANKs+SNr/khc6N1IIuw8KGoF0zYXSTSDb9tO/x9d56WdaqbIPckwFI/LukZqTVh/g7ljzTfWE6M4eNMiNBI5WbdQfeUHvP71UiSJnWNyIz1Lrx9+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7zWxVl+ajC+nufyK0nZGCkct+el+e9BjSrDO+rcqYk=;
 b=gaZ9+mwXLdG4ghb4F9Hi/RWVWBUIVxjGJWNqTVwX4i8NbAEm1IxgsxyvHjokKaowbwVc1m3Eh7aeaX1ZL2YSVB+5o4saDO3L4r0tySFeS0+WX0itwj+OchTLckh05A8j7BmbU94AyKwJB3pZ4RRzcjtFm+fuIiN0ZGaI722POO7hvjAJzMskUH2ewKr6PHyuZnweRlEGclzKT4qdVXp1E440MmxAehuPNyWReAI35Y7CUGzr8k7z/KBqeXKpG9YnqOlee0B8gEGiKjWxM+n5FJVHF7fqECsh9sNqH6ngsICQEIiguaweYBiRQ2ZZJKucCsAohpvyGQeIcqruR4glZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7zWxVl+ajC+nufyK0nZGCkct+el+e9BjSrDO+rcqYk=;
 b=VaC6+IT5Rj5+tTY5FEImp9dkL8pGkik7vX8V64dLUMJMxhND4Cl3PoOPqWPlYk89AiB6u2B1lpJYzC7z/ATudKDfaES8Xkvqf9x7qobazjiEvnB4xebPRNt1SIPSpZcZ9KPIh08PSQFCg4aHcNe2zec8NnZmlvLMI0DIGaOwXxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:09:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:09:58 +0000
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
Subject: [PATCH V3 00/10] interconnect: support i.MX8MP
Date:   Sun,  3 Jul 2022 17:11:22 +0800
Message-Id: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52f60769-a894-4e69-8bd3-08da5cd3cd91
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWu6NVye1h7o9RgFJQhrwHgLarygUHFPnchnv/7X2Xwl3OR87iLTUuWO9xJ0gQj1K3gUVyPG6mTePDRuJw/VHEWP7fW7x1E9G6VM8YkwWV67R0QQrVgrQhFGyCqH1Rl4wK0pvRVz/WqqvX4UgSrMNTSbjHWdXJV47PBGal7wWiuqsYZc3IWTJdLXI649gu47kUZMAgitcsZI9GPxWW+dCa6T20iUOxeroWLoeRcQaoUNUXdCWap42T3brkXYx1PohJ9ZRbiiZeOiKYxrU9hSXT96Juzesw/t4oPcU/Qu8jYK1NUlHdN5jXE3A9g42PB7AZo2f0qpbEo5kroR9aqOzc0KOYoSJAV2jo9aMWJNKqlos4JailvWwTOh6E3VRy/VLwzbjITZU4+SySDgGyQAQuLv9K7bcxRHtahcyt2jrU58aE72Am7eXyUgGFtM71hC840qQ2zSSXFDsgRZmTkGWMDZnro/giBsCYfjiulOMrhqgwjG97rhTHIrAmjYQSsNpZTBpmyfmwbMWoMhEw+XtbvGo3z39eJtcbASKUXyyWzksUUR4eSZwbPat0J3jrQZ3qh7spRt1OCZ3t7eX90IX36vXW5Jk39a6GLkgkQLDF7dFQtVSqCckN313MtxX3IIktxBy6jRjZd+VhOC/SRsSzL62+SFoK/3yKmyNFQOS2YcH7f/6//mXs3HA681/6l8JWTFKoujddIqlKnmGUfpzGMyw5lnv7uOhlRWz4ttG0gy5U77NH2qojsog9IAUbeTX/LCGPSU2vABO4cgqpLhqkq9A78Nlte1t/H3CsFvR+UDqjaLp48Rg8U2OqViVGJKq/5uRJV5dIO6IbFZ735gLpA8N/mGuE7fBer+lPezqaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(966005)(478600001)(8936002)(6666004)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0fksOMu5D81uqYjEHbsNhWAzbR0vX7SW8LQhpf6T9pOGO3ki7+dSIKSUPpS?=
 =?us-ascii?Q?9Xs4Sfq/LbtkbLitvzKYwnPTYUX6t6QDh4SeJM9Vdesj1/1R44Tk0FvP83mX?=
 =?us-ascii?Q?SD9OOzRbaIeReQUeeUwVoRvLt3ifFU9DilornWF9A1s9/qnVqCJ8awwJr3QP?=
 =?us-ascii?Q?Kckh1F6iTkzMSra4P73U4b+7LKG/+e0NFyHVXPWy4CEq2eRv+nvd1LmvGMxu?=
 =?us-ascii?Q?XvbO4adZOVlOTKTmtxgsJ7AWWvEKBgBdW+VcW2rOm6r0WR5xLFHZoNRvkuut?=
 =?us-ascii?Q?ft2PzehKqnt4vOKds5rNKY1Fh6lbaXF/FreRn8Lfg0fJQTdacAMtxgyecr6L?=
 =?us-ascii?Q?OrcvZSnt9tsetPWFXkXFvHkUut+lyS3urCOFxTXLmnzBP3BuzUOSiTey9/XN?=
 =?us-ascii?Q?QA4HOFq96F/sJ9TCbkGfetUaZPmWF4QPcUfDz+lfS37aWqZB/edmsehV4w86?=
 =?us-ascii?Q?3lQZrpI1Mcqv6D0eDnjYTY/TIS6Ac9y16S/K7zwO5OYYEj+bM20K1yxPLmJ8?=
 =?us-ascii?Q?J9OSQwMnuUEMIEX8u1qUMsX05L/KFHtQnDX1Tl7arVfIOrRQDiJO0cfO9xzh?=
 =?us-ascii?Q?R4TlP0QjW0reSQI5zQr3tHEeGLLiUQNycmbm9g0W3UZQ4QivWmM7cmxi9mpP?=
 =?us-ascii?Q?+6bjZ84epTgGaNb+GNkdd8T1f85rxbw1v+WHqkXHTetojofaMxuAO9+XbHKT?=
 =?us-ascii?Q?+FxDnKOg/9PpTym8RpcdfN0swXrRGCRxEhcXP9i0xgeYquRJfVJqphIS+iOh?=
 =?us-ascii?Q?gKqfZU3M7iFQHkxbKBqrNOjjwrbniq20QImWVH8xwXPCySQ6GAYkYFLEjMX+?=
 =?us-ascii?Q?o255VlbX2gxXD5yjNFEEpmPxOnDn3BRiyUkGv/oPBVI/i2ukE34yTLBAbFPf?=
 =?us-ascii?Q?5zTqxVkFmrb+pW4R45D2u/HW/MjPXAeOIiYN3PbuHw4cKv8sepHj/W++jRiT?=
 =?us-ascii?Q?/4pt+0EjhgIw9VblcWwLimFH9JuGE5FDa976zTz4iEGIiUwpD8EyCbI+7zIO?=
 =?us-ascii?Q?95BEEREffByslaVqeOH81D5v9R3PSV/rwd/1NRgZr8HHpZQV7U7ndxFXy5CV?=
 =?us-ascii?Q?6BExxDuOl7AGY5X5OaSg5Ef6b+ugOvCm4L4W5wPfGcIoR5A8m+9lTimKS9+1?=
 =?us-ascii?Q?GXGbKd9Wu0g0qso7NEMQhna+65rlQip7XRKcEmsa8vsM2SPlauLUYtfcFyme?=
 =?us-ascii?Q?3ralULdy90Wp8LzJF+zYuKklEj9nQ6WMfbMz06eWYSMvDTDdUbg4e+XMW1k+?=
 =?us-ascii?Q?CXQFC7jTwAGywV4FeTkVAopRrNnmaT7/j16UQR35oGgKrbJFbAFWzuqgHjB3?=
 =?us-ascii?Q?He8qV/l3V9O9ZNsHGW1j5Ulefg3kfOwMo4iGc1P9k8NEHyHcaSa2DNiIxcWF?=
 =?us-ascii?Q?PuyNRo4+yyyozbW3NmYZG6bWahBzvVME0LdnIGV+Cz2kKXZbqI5W8LK4kDkE?=
 =?us-ascii?Q?GqIdk91IZXNCPpaVf8my+KnQSUVNHQR7UhvelCj69u+5nCJHZi/YsvIkdmgj?=
 =?us-ascii?Q?9NwXq7mw5dL7gLNf5Ea/SKWcuXUKbdoQbbNy1vsavQZUzEb5ToKNgYGCVtdm?=
 =?us-ascii?Q?P+Rcegm5lkHhjrAoLCZUKtAkcOt4SPvMje55+m6D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f60769-a894-4e69-8bd3-08da5cd3cd91
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:09:58.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jeek5Gp+in7QiiX2EvfiCB0LZU02WOGK/LWTt46O7DCf4Q3FtMvglAbt850Me6VUfB+TdA8bhdMKKDGS6AaBA==
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

V3:
 - Drop patch "interconnect: imx: set of_node for interconnect provider"
 - Driver License Update
 - Correct devm_of_iomap return value check and minor update per ICC
 maintainer and Lucas's comments
 - Include devfreq patch
 - Include device tree patch to include NoC node

V2:
 Per dt maintainer: drop syscon, move binding file fsl,imx8mp.h out from driver
 Per ICC maintainer, add kernel doc and add static inline for an API in header file
 Rename max_node_id to num_nodes
 Describe more on the registers.

This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC initial
value after power up is invalid, need set a valid value after related
power domain up.

This patchset also includes two patch[1,2] during my development to enable
the ICC feature for i.MX8MP.

I not include ddrc DVFS in this patchset, ths patchset is only to
support NoC value mode/priority/ext_control being set to a valid value
that suggested by i.MX Chip Design Team. The value is same as NXP
downstream one inside Arm Trusted Firmware:
https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx8mp/gpc.c?h=lf_v2.4#n97

A repo created here: https://github.com/MrVan/linux/tree/imx8mp-interconnect

Peng Fan (10):
  dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
  dt-bindings: interconnect: add fsl,imx8mp.h
  interconnect: add device managed bulk API
  interconnect: imx: fix max_node_id
  interconnect: imx: set src node
  interconnect: imx: introduce imx_icc_provider
  interconnect: imx: configure NoC mode/prioriry/ext_control
  interconnect: imx: Add platform driver for imx8mp
  PM / devfreq: imx: Register i.MX8MP interconnect device
  arm64: dts: imx8mp: add NoC node

 .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  22 ++
 drivers/devfreq/imx-bus.c                     |   1 +
 drivers/interconnect/bulk.c                   |  42 +++
 drivers/interconnect/imx/Kconfig              |   4 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx.c                |  84 ++++--
 drivers/interconnect/imx/imx.h                |  49 +++-
 drivers/interconnect/imx/imx8mm.c             |   2 +-
 drivers/interconnect/imx/imx8mn.c             |   2 +-
 drivers/interconnect/imx/imx8mp.c             | 259 ++++++++++++++++++
 drivers/interconnect/imx/imx8mq.c             |   2 +-
 include/dt-bindings/interconnect/fsl,imx8mp.h |  59 ++++
 include/linux/interconnect.h                  |   7 +
 14 files changed, 518 insertions(+), 23 deletions(-)
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h

-- 
2.25.1

