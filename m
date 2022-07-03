Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACA56463F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiGCJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiGCJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23491634D;
        Sun,  3 Jul 2022 02:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chdV0Q9lvYCo2msOvk19GDi2VtgQFGLDF/Ln8a3zyv+v5lnEkU0iq+3Drm36unH47vE6Xh7jWF4qp9Nw42dmmANa7Uig+Ux7kGMfT6MO33oA1NaH9gWqZ86zJlfmQ9CCc7PTgP/kztHQf7Ya27Y4Luciu3VfB1ESDbFJBtCT6Dv29vcwxdCuRYsugjO2rTuPUDIRRiAbYIY3EwQEJMYaj9vo+S1JKA5FbGY2H5c30B4w31v/eVOjnBXo4wr0SdKwYiQb5f33LXZqv0DY0sTyJlXMbMiUIo+s99IQ9xR2lCT2WHW2E4OWlyehVzry84uCQX67mxRjwwA0VmIETYk7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RPQx7XiEA8FN7PW7zZOmxIIr8DrxLww91jmgm8yzEE=;
 b=A9DjywCc9Z3rpwQEDlfaQXVcI3hO3LwatkVYAijy8X3raEVne3eAEkuwrSJy7Wl0VyuSYDtV+uepG6B/7w4mh9IqxNUKrIrzNX4LEZEsUUvSYcOxRIyEZRAK6W7Yi3Uubtj/X4kbX8VeORfrUaD8VJCYNNNg6iPAEmyzIp2Cc+ecITBhEnCAHYJYSALsArX/LrbNH/S/hQXvfdDOtPJuUgY7AlaHRPWnSLRaTqti46QEI91VNU5Jzg8vphPUa1UFope4DWwETKXnG7W4vk7aT61K/phlXNfk9tKyjY1IvcRxuGigcuZ4SiuIG8lLZ8hhWNUwBrepjRUVbaQ7tZgn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RPQx7XiEA8FN7PW7zZOmxIIr8DrxLww91jmgm8yzEE=;
 b=UhJU0YtbcS0vkbtnppylDz6/aRuGkUUV7ehmyNM0v6CZowMy29tKDPmRMiL24Zz1bfcSmPS50qNmKxM6yl9kgv9Dj8ESQOcNt3GE7P9XPi5HcshKTHP7IW2Fs83HUzuS1DkVpXFQOawIiXHb0SwdbuxhNjCvRdDNbP9YpbKAJt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
Date:   Sun,  3 Jul 2022 17:14:44 +0800
Message-Id: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c00d8523-301f-4158-8d6a-08da5cd43f25
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gd8yRj6IJW2IwQBWf9p5frEzUnVe1OuzoJhY2FFm/UZ9FnWM0ehnkro/LX0CKYKi7/QzElt8OfeuRrXoli4Hl7X1vf6xzcTaED/808Hqtfwm1UBxs38SR+PR71yL8mNaY6h5RZVDcFByt+QbGKfWlYA24ZfYb+F2Inu5ox+8Gdmt7jR/GNMqnb/8LOB+4SYk/XPFIGjn0h5pL2l9sOrfWqOZTtlPwOFneDzXOPSnal+Rlj5+nqwgK8iUIyqM8M52KLVuD4NHx6PVZqVQTMPQgV29BidpeoR/wF9PYTwrneoHryrUR1Cf6QJhuyK/QXM8aakb4yrqLloJlyKOGzXmzrZRLyKjVy9mFGITUKbe4zLAoT309d26Z4JIAHXeUZ1xTvSoF9n5jf1KE5g9cp+dvvW+mjH+x+/PjUsE2UC95dn9BUvU2DyJgmE04dODYYjNfZ3FQTJ3aC4/WDXcxvy1EFJXA9bjMBm8ij4EuHlBLNAi9JDmjv/UxNPDsbZRljK8IYepruFdtv6A4si57sEgTnjcHYSO+9CWmZ4d9alQLWQGsSEJGLsFfJfVgaKn81NnImcb5Euv6h+PD+dINl+BV8EBzn99gEmJSy6vm8CJ+iJaFFhpioMMO2QUx5NSEkdLkU9HI1+KyI514zfQ1Uo9fe9c6ulpjI1wiYrrqIT8Mb4Iwki5VjB8VPmYqj6g4ckGmVR/Ev0To55Doxh4AQNujPjX12105IlwcNz/m1ILq2Y3Lmdn8ypuc4jog5D3q2nv29ADylOeN5J7MA2/u73SgUxIeFhf4L03HxqqfWxpI92NKNKd+chW/ntvlCVckoRX0m2yb+Nx4Qh7oNuSGwwvi+06GSne6NOf4+YFd6ZCzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(966005)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFF3RAFdpbM0QncelTmx5n8I+BkKHuVdPIsIprMG7f6lv44bCP8fG0RyZTNA?=
 =?us-ascii?Q?tWqVVkCtx/00CZuczWgPvMbLMfkyAgjP4jpjL8xFxaTrCtdNVdwDjIpeEt1M?=
 =?us-ascii?Q?Oj0+I738B65Hukwt5rzm6sYebSMadiLpFEX2R80lPBDvysFwC8CkaPgaZ73X?=
 =?us-ascii?Q?bxAFqyBbI+MThFDZ2mIOxN74R3VXafX3ZJk7r8y11WHjyNCnvjBcvCKfXboA?=
 =?us-ascii?Q?TCF/sAiXBl8sHp4byFglhvhj2XAI1OQpriwsbmeCnyzRoCqO/hsyd1YHa1Rd?=
 =?us-ascii?Q?cY70t174hsc9mpYcPP8q9KpZh4jpmmzt2/h7tBpJF2gzlM5B5QV0l5IDPqW0?=
 =?us-ascii?Q?P1t+xIeevwfqR57950Dis7XnlKsR1yH+V3ZyihGQwzOHLAdhoEC2zB54agpY?=
 =?us-ascii?Q?S1/XXO/HOV+TGQtbGCGjh66plLrlGHgL3OwLszyn2S4SvqZm9+xcSBayDjYi?=
 =?us-ascii?Q?eradBG/6IA5yPFklItl5sEXRkTJAkzqQV11AfSw1KoegNW59QUxtetfAzMg8?=
 =?us-ascii?Q?BlwPKEyEcYcLiDi6KRPW9lJRETbbhpljSVJ6wlXGETkuaPxDvAz5jj0jB1Bq?=
 =?us-ascii?Q?3JbngABGoq+7XbPSZngx2Jn2pX+GLsm9LIO1QDt+mhKzh/fCdwME1oujxYXT?=
 =?us-ascii?Q?+qYukJbpSLWl5fEElVeCshjHxHHMGephS24I12z4D0dP30abnp6AIJEno/3v?=
 =?us-ascii?Q?mwvPTfjrVRX27pRyJgegGTxG9PWNLEVhqFMktCeLQKhQSR4Mg2eDYLlm4Jha?=
 =?us-ascii?Q?fbibMVsE6vaCU1vGEdMIy2N+5WztsIZCtYG+VUMiswW7pW6AoaQPMJt0OJxK?=
 =?us-ascii?Q?GL4QFf+X1AkkG+JXM2L3Vzj/tOsr+Md+UtAs24IfdIr4sdctiGFcMLGPiboX?=
 =?us-ascii?Q?V4tqLUyjoLB74aD3Yp+1aRHuk1GcDeFcHzEoXvNUzBIn75N1PGePTIx/obDF?=
 =?us-ascii?Q?bvWmkKkSUveurtGOedqLho81+W9KDrJcKlyEhd7/hoyahn7Vvj/fB9aoHuHZ?=
 =?us-ascii?Q?qnn5OGYJ4JO02Rw5w86w3iVOWi0Bc1MoYFXUBId8T7xl8Z34NjSWetDlT5QC?=
 =?us-ascii?Q?OJaTESv3E7UoMz9bHk/BPeBSRKGCflTSmk5THZOkBfEIRHF+4LDjgkQWlNWz?=
 =?us-ascii?Q?iIjnrpKhCzWOiTDfxfWihl4Zzzeln/dG9yrmVbl077HZ4ILq+rwhywsaBGTm?=
 =?us-ascii?Q?PE/z3kTPCNZPPJxePlS5AGFJPtJPiHC9bQAOdbCwn/rD6q9Y/dqgauVflq28?=
 =?us-ascii?Q?rBq+ZRY/hmisAlLDn8+HZHZQa0yB9mq6uJbGSmt3Zivzd709YM8HLo5uBXf8?=
 =?us-ascii?Q?HIIwdc1yyfJkaAN1yiV1NQz+tDyZLYsxi8pO6beyJ6+iB9i97zo+vIubDI0f?=
 =?us-ascii?Q?gD+jZKnS8oPvO3h8PeXGDdZ9rCA507nxLyoyjML4SqSeKdU+aIVnzw5fxG78?=
 =?us-ascii?Q?cZkVOZXKfhup1+J/c3+zIzf0TUQXmnzJg1f2/zNirXTIlbTCmx8oWCemopNe?=
 =?us-ascii?Q?q4RVaCmquq/Xp0Ioj3bYcSSB/6GGU7ADKRB6on5sVmvavI2RVZhQdTxiclS8?=
 =?us-ascii?Q?tysBYnSGApjqPXS68qxs4YZK910xbf20PGp+YYrY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00d8523-301f-4158-8d6a-08da5cd43f25
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:09.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFz6iQ1ivn8VXW3xs1bcSWh+PHcBN5m0AjjAxHcd/98LHp4pbtbB90pFFbcRwmu72zpFl5v30PUgHQ63EvhKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
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
 Move adding NoC node patch to i.MX8MP ICC driver patchset
 Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.

V2:
 Use a low bandwidth value instead INT_MAX
 Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
 Add A-b tag from DT maintainer

i.MX8MP NoC settings is invalid after related power domain up. So
need to set valid values after power domain up.

This patchset is to bind interconnect for each entry in blk ctrl.

This patchset is not include DVFS DDRC feature.

A repo created here: https://github.com/MrVan/linux/tree/imx8mp-interconnect

Peng Fan (7):
  dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
    ctrl
  soc: imx: add icc paths for i.MX8MP media blk ctrl
  soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
  arm64: dts: imx8mp: add interconnects for media blk ctrl
  arm64: dts: imx8mp: add interconnect for hsio blk ctrl

 .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
 .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 17 ++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
 6 files changed, 124 insertions(+)

-- 
2.25.1

