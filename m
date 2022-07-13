Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF8572E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiGMGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiGMGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:20 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10088.outbound.protection.outlook.com [40.107.1.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E65AEF43;
        Tue, 12 Jul 2022 23:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNaA2K3d4b5e7oxCpXdG/h33hZIjSmsKAqv+KdIyUtRJJaLO0ZCUROB9288Q1o2q7bd8j6v5OxIUNGTTMagPD+RQO64gz9Jj18PXns5sESR/WDxjY8zp9rqZZ1wyb7VTFAB8HCxUg+6imLTSSAWakJIubxpWmic6ZyhQgxiXcnTbiuXBszVMF4INJeETArrAPaGG65eaxvSxE8V+2pX6uHSS8PzjoKeNd1B0AnPiZpVAdMsX38shlsBQSdM8yaYpPCLo1FDkWAzj+b6oRtb+RKgICDsUu8Lb0t2qacp3Zg0MGOzBBQ9uC3+CEQhhEf1YNvxWf1B7cFrPa/WjH/lJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+IOgO4cP1AflIYs/hlzZd88PKJvzyh1SG607IqoTgU=;
 b=I2HgVr/oH8hE0oBNFEviZy0JtAKugtGdn0/SZXFmqfgSOBavlWIjyVIWuqX2ws+umh9wzA3g8PM+ordcIVbETVFLJEM8gHqw81Lu6NqbCBHMPG9a7A0TcUpFHzWPWRz0s0fLQBw5HqjaKzlpCjQs4USSc6Hjway5mM/nRsNGoREiazYSxXOgr2pWCLj64Tbk5Kqy4/OoagLXHpa+5pd2yW1M1AFC5ayLbAy0LIuiNbwXKPXDhOiMUjHxE6GlJtWW9FNuRJyL+LOM4VUB20wm+ZkO+q3H6gYxuxi2VJNOgnt6kNNh8X3iqT78kgcbNLii4bpqkfKEgFrtVo0oyKULqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+IOgO4cP1AflIYs/hlzZd88PKJvzyh1SG607IqoTgU=;
 b=gLwK5YuXh+TseGJn39a6ZqOz4to4NabYSxjqqVbNvgRGTl4quP52gDr2C+qJa5uhgJkd4/OXudmItydja8lD768cUj4F6jCa9UnuAWJhoJb0U/vyAXM6gq/r0B0aEFWm1C66kIW3IxC3Zys5bXcKroPcqSgL3VJ222vtFvlGNJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4080.eurprd04.prod.outlook.com (2603:10a6:803:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 06:35:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:15 +0000
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
Subject: [PATCH V2 0/6] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu blk ctrl
Date:   Wed, 13 Jul 2022 14:36:47 +0800
Message-Id: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a334725c-5d79-4d89-22ed-08da6499d840
X-MS-TrafficTypeDiagnostic: VI1PR04MB4080:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrjjX185TqgMUdg3CIAnmoSzFtJsg5ElAzpdk6TnygkdSpqCT9fafbBQc3WvDN0IKHUwn75+g42YO/BJvSk1DGq0Fg2vsOECvyURoCeyQx/yZiDREVPfaGSxaybIEQV9e8+CFqZIb+nHva8n6OYsRlZKUDLJiC9xL3tt2tAHQRmEn0vrkbiZgNAGrDqAhtPY7yi03a7ibR1ES+rxDOeYoWz3NEdG4YPeu8WSn+gZXtH242mPcTSnUxSeq8IQGOmZThYcXPpG80C/Ml5F7357BEFcMTEZLEyAZaP3jr05aaYERJI5VD7zRNVRLygj2dh0ggODBu3REHU2TDXPXhbptto4d7ZVDWFvyoCCKi2qcQyI9llSLpDsMDAfepIxLxKPoqtebyVuYWKjYPQR+fJTOhTU4rt2NhU0MB+nGd5y4IOJFE2kRhrTMrJpTIdDkwT7tzgXGHN3ImrNOW4va83IGu5ZekQuWcK0V2QD8yrF8u4A+uYSuxHpNJrPRXlmq795OcTvNMODDfqAMM4d95IT0AOhj/FeiriQBlXInWZQDC65LeYH0XIdJkp0kZjRRkNZY5FAWVqEw/akrETblKj/0L1ShdtkGKRcrtO3F7r53VK0db1+rVNspsMWvbHS76ie13SxXM3vji7pUN3OvS4BtXYkRonw/WLe2YQ6UOZ/iF9kBqgpTlmj9JzmbCy7wzAFtWTtT6qKjXhtXh+Z/WmmpVQyDaj/4ah9so0RMbTVvTl6hUO4Jvsp9mT8X1OHemQb/rugMtK2+4tOhslfQHZql5iJLGyAp4waUqABL3SxWmkAAEyDhJ5Ak0x1SDrBmiat4pxNFaj4wmgrjFqRfNoKbM5Gyl+oY6DK8GderLDfRy/CQ0BHezTO2+9JYnW+Wt7F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(478600001)(52116002)(6506007)(8676002)(6512007)(6666004)(41300700001)(7416002)(4326008)(26005)(66946007)(66556008)(66476007)(8936002)(2906002)(5660300002)(966005)(6486002)(316002)(38100700002)(86362001)(83380400001)(186003)(1076003)(2616005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAQoEy6jcnH8XEDYJi8vh1EeunsgWrc1IJyxSkDRN84hJ8kdFWZT2Pf2udEn?=
 =?us-ascii?Q?bnL9vJKnB2UA/CY2KrIxH+M9bmR4Qn2Kr3leO2DjpGjBVY/NOR/eEWfW2z3P?=
 =?us-ascii?Q?wp1A12XXmBPQbHliJA54cnVykmVYtmv7S8cyA+0Vf8VVZ2WIv4tkUbzut84m?=
 =?us-ascii?Q?XVtbTo87/AlkeK6SUWHCPqqgFcocOijL5IPyjmV1E3F5bzavHR3vgwIfiOZA?=
 =?us-ascii?Q?loX4b9nil8ZBpWspyv0wd22ObvE4UtJ9OhI+f1EG+MIwVMEC+kzvXLN/e/Xc?=
 =?us-ascii?Q?lDVW/Oo2wKxCQIA//xEgmaONcz6v0QkDr0Rie7QvSKjinctmp7b+XdfVuTFx?=
 =?us-ascii?Q?m9ckOTb18aDUlBkkHbLeojtNljFF3mxgt997d4gvAD16/PPnpPlak6XBQIfp?=
 =?us-ascii?Q?I7uv9CUTAPzf/qSl9W1D+IpsgG9Rccb2s+BtycFHUQBT+C2I2efhnaMLDrrn?=
 =?us-ascii?Q?YFV9NcEftR0e8k64wNEdSPVFZdL1dn1IzKAjqFNrhtfDNG34x7qBBwVuaSOl?=
 =?us-ascii?Q?4BpecPuZ65u99pSwMthi2pixJmLt/Jk/jTx+hPxEszbh4k7AZxRRAF47vuUT?=
 =?us-ascii?Q?HBXurzuHn014RFlI9yzByUZVBZ/hCwjAXdyXBvKpcZb/KS7zm5W7SXJcaVBA?=
 =?us-ascii?Q?XyeEpWjMOZq9UCdLJFDeLX9EFZEXhG2NocL6knFZ1cVGqw2BIgIgCD08GW3N?=
 =?us-ascii?Q?xSJ63VkzgDk9oYC1j2DpvrX0Xijc8lbZ44bTVqxoKbcGaGaxNlSfaKVmKbO4?=
 =?us-ascii?Q?8PdQNwH15c9Fq0CW3kYDJjdQIYXKJltYnIbHXJQTWKrhXDwVsZpVWFRyz41T?=
 =?us-ascii?Q?dN+53e9w0m622I93msaXZuXeLbYhVEEb0QSyoM3/TcyTmQcdgBQyNWbs7Att?=
 =?us-ascii?Q?7w9hWbqdMr3PQvEXWR3MbLjMXvMQgGEK14ez5d4xNITXhmP+mdIK2sPOLwJK?=
 =?us-ascii?Q?P6Yr0yIwLAk02u5qr92NW+Cu3vRavdoH0zWHaQFDUL8JZSM2nQcj08Mfgn34?=
 =?us-ascii?Q?LvNGYTOgwaeiu7/USxpQX6HW/6aYKBwJccJXuI11VBXjfCW5bw2FY66XRU7E?=
 =?us-ascii?Q?QtlfcoSz8sEipgTY2+6lPz2xqpdWI+Z1i330nr49X176BjJSC06reNSLjKk3?=
 =?us-ascii?Q?lbDbsSynIoUQE7pGcDHpYTVQl89Ib++EBByUIpHxhcdoxBfQ3+xtjl9p8AqW?=
 =?us-ascii?Q?ujWghDXGaUwEqd5B7zhQ6KK6O4gcSnEsD9NrNSHeejGjGjAA5UC/EWw0m31W?=
 =?us-ascii?Q?4JlND1V5sI8ATLRcH3qW1gdXee9gfiSTbDR04i9+/zFUJtSgP2O4XyerXnj5?=
 =?us-ascii?Q?ACfdspoNKwGaVroV+SSCsWVzP2DIskFc0BGWJvl5o4ysY1Yrhwv1gcaqc414?=
 =?us-ascii?Q?SBRHM3QsoMlzrrKUILTPhz63YZwx8s3FmLKCJbMX0vTgLwXS0aPnYuezuG6w?=
 =?us-ascii?Q?aKkd8x6dyAeXZjuIDogXgarzFwrUQKw+Ys3h3Ne1v0qcpS7EUKOoT7satkiq?=
 =?us-ascii?Q?Sp3bb56V2qJR9WrcK9uTenaJBj+jLIYB5+BsHP7eetg7CWAC6QEV2BGy5q9d?=
 =?us-ascii?Q?4IOn3qwOTUmfBo/dg8360jsyh+cG6aSKDFfEsE/Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334725c-5d79-4d89-22ed-08da6499d840
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:15.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQTTPFyGohqCEqkylgNoTedAot0kv4g6VPIeOq6EDdQwKDOADX1wMj6iHavtH2IlDf1srI+2nbueExXdx6lDeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4080
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 - Add A-b from DT maintainer for patch 1
 - Per DT maintainer, I added description for items. To
 make it consistent, I also added description to i.MX8MM.
 - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.

This patchset is to add more blk ctrl support for i.MX8MP
 - Add HDMI HDCP/HRV BLK CTRL support
 - Add VPU BLK CTRL support
 - Add PGC VPU node which supplies power domain for VPU BLK
This patchset is based on:
https://lore.kernel.org/all/20220708085632.1918323-1-peng.fan@oss.nxp.com/

repo: https://github.com/MrVan/linux/tree/imx8mp-blk-ctrl

Peng Fan (6):
  dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
  dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
  soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
  soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
  arm64: dts: imx8mp: add vpu pgc nodes
  arm64: dts: imx8mp: add VPU blk ctrl node

 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 93 ++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 45 +++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 43 +++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 30 ++++++
 include/dt-bindings/power/imx8mp-power.h      |  6 ++
 5 files changed, 206 insertions(+), 11 deletions(-)

-- 
2.25.1

