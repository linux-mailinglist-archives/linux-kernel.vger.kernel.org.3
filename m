Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEF5A59F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH3DaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiH3DaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:08 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10083.outbound.protection.outlook.com [40.107.1.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4117E1D;
        Mon, 29 Aug 2022 20:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es27spbkpL83CjEW+r9GXY78XTzPjHtit3SCPINrD3Cnia+Qex6YdLei3D8U5IZguSgjm3Rg1g/inCXKhhcwZTXdeFRZ0IaHLIb9AYVynGQR0HxpE02rW/q1sJ/WqB51JEnVy8hj1fy71NdqsnutCCfsKy0MhYTjOg8k2GwEfbF1v35z8WtZ7u7BDHFcbiw/kgZ+tQWfmxkXtjjUUqWzol90JkmkseXJUHiT7nKXilg1fNTJLtYVVYjLxW7xbVgv5LagDN8gJlQxQYD3mtuJon++DszwVQtlmvBMvv5455R+qGN7QMQaJF5gIHNFUjqhH8KbZTNv5cVgBLNeMR9FlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To0iCoePdhNyRQ4yhq5Imlij2QaOigHGTv+yxtG8DKM=;
 b=gIuRKQfX2Ib0irH8RmfIH4ITjg8pqHoQWfROnoeVKHCQSh4i/k1n8QKoFDgmn/D2PpYS5iTU9XELUk5EZJcbNVcRpAVPdbgzKO9I9jH7Db0xk37ETQ1IClcoCDou07bSJqxqVA+UrdwXyHnDLEVTugkabrie450Gtu1CRgUfFrcfkmmFawZO6W1yOSmjGeGrs/6qwuZc9NXQKomIcn4TFuzICY4azhss9VpJwDClb+LwjHza7LaX1ku3MCaQGPkhwDVKkT3wtDGqJhqYYrjwEtunqT6E/NiHvTQ/UMMM/etOl6hYT5KzLMoRL6uLFYlbUySgyMTL3JYraTtHwMXqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To0iCoePdhNyRQ4yhq5Imlij2QaOigHGTv+yxtG8DKM=;
 b=cLl5EIFJaKm+a9kd3lJNldBsd/wgia0O+BOao7qmHl9pU04n+TkXn0bQijhFQ1tm4G0eiiqWnk9U9vLEctNZwwJQLmxgpB3MkgVfiwgQqEG0q7Ln7eInNHHpARYAKBXleycM0NppEM6JAkKnf0MKNjsS4lgRHPtyVK9klQNa5XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/8] clk: imx93: new gate API and composite update
Date:   Tue, 30 Aug 2022 11:31:29 +0800
Message-Id: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52179ea8-ea91-492f-0114-08da8a37ec96
X-MS-TrafficTypeDiagnostic: AS1PR04MB9359:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bUGytGvqS306HleV2NijDvQb68jKDaC4HM3MnAqWUeQlYDF3DHNlcvT8InuCrr/bAs0uykIB6huf02GOcfthqA+Angw2OTcRof/Rd+5nAgYZmvLrsOJEsCuCEnMxCruLC5jUYLcQrjCaNYjkaYy7KeZ5tgLr8gR8k+i+SMtUIH6IQ4QncM/dJx3mppWaEydv8mocnew3McXAriy3Phyh11vx33ODgThQJwZVkyiIccVLOVhz+2BYeRUvGVDBTaRoeYs0l+VLBLCEozRNwLuNUJuCS666zqtyYU61GKFdB7FqnaXFqhNERYA8bIibRJ34cm1thVPTHOrhp4Xv2kMS44/UjJ1X3l1/pP3cfBcrMdB7lHNLuXlySKro42GzarQkC99dG05IjCCA6rXTToTXGqIwiRnp/PhYnqna0mYSXjE3lDxf91yCh4MT2xJG6YZ/OtO5jYOkXCgG5EDM53c8Y20d+h66sg5EHW3d9sEBHOECKqlbB7qtWKc7m6BGM1HVkiBn1HVUKmST+x/A8++A+GomX6nBuKbPPyFY7/O9T9bWOYeCq90q6JPfYlHLPWYUbZ8pYph9d6Vlc53iA2epWxeLL64RDRDKMgf1Aep6b28vrU9oNhez9LmvhVrTiHTcSDaXkDEjSnhKfEUQ/M8UpahSdD4eZlQlzesjgE65LO/RxxFU5KFBk4NtbITngru85JBwoi278aT9Lbhn0BCqqhA/lQ9z2BSHjpSGL1VXSOQfCCNzD8CM4X8EjzRIaZBKh1NqS5o2Zj/b43LpL251Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(4326008)(66946007)(66556008)(38350700002)(38100700002)(86362001)(83380400001)(186003)(41300700001)(1076003)(7416002)(478600001)(6506007)(26005)(6666004)(6512007)(66476007)(2616005)(2906002)(316002)(52116002)(5660300002)(6486002)(15650500001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQZyYRJY9ZiaGfxtMUhk3tM3DJa4ubjqn0O0NkbQJuYyaWHwvGmyZURJoiBh?=
 =?us-ascii?Q?iPB6+53O0nt2B7Inkv05VQS+7MHKE2U7ALekfdPI38YCvo7Ep64Sqv7V3kWl?=
 =?us-ascii?Q?366lvvmWEPpApgYNv5V3GUat5v49GapJGmcWZnNhzYNpsFwL38q1Bvsc7kkB?=
 =?us-ascii?Q?FmuJpXOeEv5UVukbsSd/c2ANaETmt+nUaax0OC2A6eEvgklVEkpeoXm5CxC9?=
 =?us-ascii?Q?W1axnh77vGYnH2ESs3z1ULp8vnbI1qWtrW5lZyYReW5+y+NvIcnzsKZgRyf8?=
 =?us-ascii?Q?jGWN0y54l0cfX0qHeqFZyZqAJqw6H9TQYCGU58GkWT5CgsF3FfsndJq8j+dT?=
 =?us-ascii?Q?XWEr0GOgwL4Oeph7mLRzoXq5Ryz5iAKx3d5Szkcm/4rjNQnpBbLubW3PqFNR?=
 =?us-ascii?Q?ae+vbcVcyMeETemIkGHMVqNWKAHbW0BRz2h1uQiIzTBgBlehhUI60yfkhn3b?=
 =?us-ascii?Q?hsIqZMgQS+mzjmDZq2Sbv+Az44kiJIkWaD76kL1o2wR+Qi09kz6juZYAuPgp?=
 =?us-ascii?Q?pkzpO2WJ2JuvqNY1Fi/1cQKQlr3QRzR6il8RQoPU9SoBXISJ6gGh4b/4/5Hc?=
 =?us-ascii?Q?LZJq+5KBhwlLVJBNruzNCQ3HC9colHhOu8k/cvxtK3vTPpQk/6A35UTguj9n?=
 =?us-ascii?Q?arBlYobXCmr6UEhWda1QclYeyAcj5k7VYfEsTxWn+0IHGn8X1OVanE/b/tdI?=
 =?us-ascii?Q?6c6n4oJR7Zuo2E2PJBCWhaeWPmHgyt5vlPl6qZFdcgD8x80fNRiQB+U5Z/hR?=
 =?us-ascii?Q?IzkUwxe/+Bn5GYZ6Dpk99ZHPkBWeugWlEDqE/d/qm7JL9UiMRy8zPULwM6//?=
 =?us-ascii?Q?xoQKaSseRzaTlgHuesTxMWsVDMfoJOOWvE5KTr6KArgxSAOFUgoLusqWIZ7l?=
 =?us-ascii?Q?gXFJmq9nVuJgrTwVwDRBjSyxhqQ7oopp0BonT6zm3dO1PHLjJgtFa9uG8w3e?=
 =?us-ascii?Q?qqxsIBLf6bRC5c8VGWNrPFVKzT7bEX3eGk/UCJ3pZUouSX/vuwWzobYBxexl?=
 =?us-ascii?Q?XU9aj633FyzfRzmeyqQvcXezH4mLcllxWmdaBU4tkI+p0gW/njadvJwL/knv?=
 =?us-ascii?Q?3FQ36rlH8GXUByO1rwJ9SBuZOg/XekjEIjVTYyRldozaqt/cM88zJSZp4gxI?=
 =?us-ascii?Q?gj9Np1+JyRf6hEUtEO9k7Z+B0hFry4dpKHgS13K7+ggnncml3mh2CrJlLAOd?=
 =?us-ascii?Q?RVsJIO9PqRW9GwmQY8afRpGF3ZzhMFwim8bVjc7sQUgq157aAjhJC8dr4G/H?=
 =?us-ascii?Q?pRzzmiu5Cj+klmXRYt36DiEYuQIkJHzM6tZHShSbQkrD+X6zxywQxJnwnAzg?=
 =?us-ascii?Q?8Nk3AcxD4fpAw6sgdEnjeAMInuKvFROv3vxBQY7L9jiEKhYKD04+KtWObDzB?=
 =?us-ascii?Q?Dm1VCXSl4FEgUI3Hg7K6ZHB425Q8KhrG03PTDgxldKwdNxDRMP9eaVbQtW5+?=
 =?us-ascii?Q?yXFV3sbOgE8mUB7d3iqRzOh6zz1G954xkurG9xjY0qflwR8HwqmNQ95KHSSJ?=
 =?us-ascii?Q?mpRGjSIdTAyA5u8LtuFUwFrHabXiGVVx0iFfZA8oZDaYZIVh9HVUEuzmVG0Q?=
 =?us-ascii?Q?BNKS3qt7hig/34D6JeTS50bpd0c28xM0TyfaeV5N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52179ea8-ea91-492f-0114-08da8a37ec96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:02.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hSq8ilaM0Bn5tmEDxxfaV51Vw5tcM/569g71lXbdjZ2Xsv4YdBmb2/IK6BSNPP3Ody50H4UzpOtsuet/fq2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
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
 Add R-b
 Drop of_match_ptr in patch 2, so I drop Abel's R-b in this patch.

V2:
 Add A-b from Rob
 Add a new patch 2 reported by intel test robot
 Use Abel's new address for sending mail

The current clk driver use gate API as i.MX8M*, the gate2 API use 0x3 as
val/mask, however i.MX93 LPCG DIRECT use BIT0 as on/off gate. So clk
disable unused actually not gate off the LPCG clocks.
And i.MX93 has AUTHEN feature, so add a new API to support i.MX93 clk gate.

i.MX93 CCM ROOT has slice busy check bit when updating register value, add
check. CCM ROOT also has AUTHEN whitelist, so add DID check.

Besides the gate/composite update, add MU[X] and SAI IPG clk in this
patchset

This patchset has got reviewed in NXP internal, so I keep R-b tag here.
For those that have some change compared with downstream, R-b tag dropped.

Peng Fan (8):
  dt-bindings: clock: imx93-clock: add more MU/SAI clocks
  clk: imx93: drop of_match_ptr
  clk: imx: clk-composite-93: check slice busy
  clk: imx: clk-composite-93: check white_list
  clk: imx: add i.MX93 clk gate
  clk: imx93: switch to use new clk gate API
  clk: imx93: add MU1/2 clock
  clk: imx93: add SAI IPG clk

 drivers/clk/imx/Makefile                |   2 +-
 drivers/clk/imx/clk-composite-93.c      | 171 +++++++++++++++++++-
 drivers/clk/imx/clk-gate-93.c           | 199 ++++++++++++++++++++++++
 drivers/clk/imx/clk-imx93.c             |  32 ++--
 drivers/clk/imx/clk.h                   |   9 +-
 include/dt-bindings/clock/imx93-clock.h |   9 +-
 6 files changed, 402 insertions(+), 20 deletions(-)
 create mode 100644 drivers/clk/imx/clk-gate-93.c

-- 
2.37.1

