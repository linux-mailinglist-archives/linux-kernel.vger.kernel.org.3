Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2E4B65DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiBOITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:19:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiBOITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:19:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4B9BBA6;
        Tue, 15 Feb 2022 00:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W32TaweXsrK/PNZAHRvg4/Ztqej+4dtvtp87RwCdTcxv5srYipLSitbdjPqXEiywSc5WmU5NWr/diZ9VqMRrRqkIWiIKo7TnbA+WTSdKr2TE5jV8Oydh2kvsGi+HKAd1qbUOoN+Qfk+KRbdvC/dpEexfAB9X6IKnqSSvdG+XdjAX7U/oruEsvd9Aqph0MxwgVr6ukGtYCNZ+Sag84iA8YmL9J1wwp6+jgWLx5vYXkNtsiJCIvmd/81GUHMQBleXP+3UgHBuBXo6u2j6PTvAR9FgriTtKeh/iK04NqI04lF6NvjFsQAREj0GA6mM1OlqMuHJOepFFqRKR2TShL2N/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqEYxxbmgL6d/15shkUdClWZ6Ukta8bqk8F1VbqFQuQ=;
 b=CEv/tETfJkYaOXRAjlQgDTeJDSohV7VT3NQJKOVgZa0iGb1hqYJRNxzDBRuVD2IcCumeIhZTnsNyLH6yZ6dwsmeQnxlG7p3qzD+Au9O7nIlpe5Qvwtb7DPPlr3rVxOV3ppn98bSbbDqxOR8xfLAdHTi3TrlGsFvzgJIyss5rFhumIXCSKRVW/Ow+uBYqesHbExp6YC61sS3gEc2s/hz9LNjcDdzeI+qF6Rw0gHu0pa8aXfwiTpuGPQQPL/FadjZPznlStPW0c70XXkrgMwES5u4OyuyskcMkNYbgUNvtG9adaHDK5AYKeFI4vOPIeP0OsMx9M/cOeuBk0oR6O4/8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqEYxxbmgL6d/15shkUdClWZ6Ukta8bqk8F1VbqFQuQ=;
 b=Haf7/JpbTBvYhi/zRg0lvW0fnuSn5gaWs9V3SbFkByaOs2riTB2FRz55DayDXfdFY2z+rUoEBLOqTt3/m7gscqEI9xZivzUR0gYvACRJ9+/Zy5c7g1Aar+7xuOJao4sti2DyTJxf4weoQyZbtq5vNoShBCQ2VLk0F0aFrdFTCSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5540.eurprd04.prod.outlook.com (2603:10a6:208:11e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 08:19:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:19:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] imx: add i.MX93 clk bindings and driver
Date:   Tue, 15 Feb 2022 16:18:31 +0800
Message-Id: <20220215081835.790311-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 166854de-fff3-485a-99d4-08d9f05be3d3
X-MS-TrafficTypeDiagnostic: AM0PR04MB5540:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB554065F5BF3358E25B116FB1C9349@AM0PR04MB5540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUaTJb4EE2FbgMSZs4Nxj17jBlMghpyMS/5hJN94XsA93tl5yLwa93szxFX+OH2441XAw5O1wf4odEDuTDL7oQntLljprZr9sxG16Kvre3YsxcKy5MSsueQHjJIV44Yt3ddNYBfGmzSP7oulK6DmGmoYuPaq5XI/UxoSQrF6dw8VIWEcsAkWeMr/ecvm7fSubkxoN9F7PSTNImtrUwFdDMzQuuA7w1z4ZkyZ8JNnzHM4awTCpbcDpSW56w6QMQALaGxG7qLjGaNA7E/TAkaSg48DXTy3ugpNm1if/7kTAKGo3zMep/+zbzPT3kpkSI1tXBzjxtgGES5asWtsLoWCjIL59I11iL/C19Z4Z9F8z6Y9eFK9E6yXfb7l8HdDPH22zgUgQKta38TeFLLTF0zOmiSCW2HOpbTbNNE12c7fM1aIc/Pnd6rcwVs7SqZbU9GHIAqqv9S2yD1q+4pO/dnacIzVufd1ivASUWGCtygDsfpsGhVSpr2DA5vRXsc6muGBa9sDev1goEh+XeC5RW7ZkWxqkifnXNFKXeMi+bB3FAj5DkfFfb+ZKKbmGTeBhQI9kZykHiP/xVTg3kfeaMUx4tnt4V+XEZ5F1rWtetihIYvTqdU0YXF4j6SC4GTp0/MsvirMGYOKBFCNInYgmqfSFHAMDqG1DoxGH8C9E/c6v8L/POX8LwqZkT2wY+il34cufztY7ptwMyjFSdFKcX4OIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6486002)(508600001)(2906002)(4744005)(6512007)(7416002)(316002)(1076003)(66556008)(52116002)(8676002)(6506007)(4326008)(8936002)(26005)(66476007)(38100700002)(86362001)(83380400001)(66946007)(38350700002)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2CtbpcWCO1x5rf3fZ2Sg/qquYFtUfWYPBjFTSjh37h2vP16uED0c3IRNSXM?=
 =?us-ascii?Q?UDEeJjuGZRfvQKSAnNFcdJir0kadBH5Ls42EDJPhShdO0JT17gB1ymL+Q9Hs?=
 =?us-ascii?Q?5xYL8oLFWqAlCpm3r95dXXGyylj9ToV+PksZVat8OBhCfYfoDf91VgdpDqW5?=
 =?us-ascii?Q?kIy5fo5HMiA8hxG7qAPokPS1DuByD4Ql7qQdSM1c/I1CapI6qNIKPej7y0hw?=
 =?us-ascii?Q?WuW1V7E7XNjSfzXYYgMreNvXmNf96gGxh7L+bjVHGWooHFUFt4+VsRw8glFJ?=
 =?us-ascii?Q?dcpfb5lAreW9qSE3AujTtT5TvaQUpQ/Sv1e50Bb+chOyQDaIE8KOkNDt5aqH?=
 =?us-ascii?Q?YGHc4nuXOBBvg15cUcXrePxkq+WZfFRPfNacr+xwGr4q+jRJ56xzWCfuGS+h?=
 =?us-ascii?Q?MnqD317WirwxRF97rnSvV+Ml/ro7e6eX/RxOGw0jm1eqntPwgsXhk/xjf2wX?=
 =?us-ascii?Q?4/CvYmYwOmMxiQB+X0KcAa8nFuGtdxWrXZwYf1gCCyEWy3ScHg9nvLr83HK2?=
 =?us-ascii?Q?poWadSUAovwTFGEt4l8hbvRKt7O+nF5hshbQS7ceFh5b4S4+liVdQ5b4EZr4?=
 =?us-ascii?Q?fTUcxgVHNUsvkiInEG2agnK1ndny9CujXmMF8r889I21AtJPxXf6SyQrWHa4?=
 =?us-ascii?Q?w4rsQItXa37xWrt0y0j8CxmRNjJ20LzpFUGCrY8A14k4Mayc1T+/LRDWfqvs?=
 =?us-ascii?Q?rJNp/7/s+QQ67HmlzXAm3DEOLNsWtVVpAoAtTYyCZrKgUlWChDkTXToFdkOx?=
 =?us-ascii?Q?XYcxnTJamnFZwFt4wGXxAxAr0HmDE31g64eEM6G99vcJMsoMuCvfQNaep7Si?=
 =?us-ascii?Q?rKtz7CTGGAsv7fK76ZDBPuAdgcTX82hEsVznHX/vPuseDitmtrBouQBrBMWg?=
 =?us-ascii?Q?iTZXNF6nUTv/SM5yKqxrmMxzSCcABPMxY0TKFb/67gfY/6JeuGFt/Rvkegg3?=
 =?us-ascii?Q?vCvx2Q294ihgZs/Ta+Hyu8PGCfxH8qhlp3OKP0T1ZCxI0W8NCs3gs0Ku6dMc?=
 =?us-ascii?Q?wLqKK9LQgpZAt/nHqXcGyJ0eY7LhAY1IxGCMeuWjrV0hOxsCr7yyUUHrWxzr?=
 =?us-ascii?Q?zeYvyrktZY2KpqBhbnfaI/NoK43byE3SyTYWRIe1hIKV8Fhtz6o4jZplPNjJ?=
 =?us-ascii?Q?d6VTGTo1De0Lf3rmzRaKDrHFs3mRJLXeqEBVyDRYclYbB7EYA6H7FnJY62+X?=
 =?us-ascii?Q?rKFc2kytj+T+zbmrOlnVe/p/RHUmenSWXhCx2TDC5expTYLN7V7eXVPmitRQ?=
 =?us-ascii?Q?KEVN1hlVwP/i8Bxan3N5p7rVG76OdaZE0q2Gl2UisczLp7J7YMnXOb0Y7BVh?=
 =?us-ascii?Q?o393G2cG+ukxzErUUWEQztEsx13NjrgJRqCaa38imJ/8xsESGsio7IIpb0ti?=
 =?us-ascii?Q?YM9Sf8BE9YHkLGQwkWP2DtqTJ1hsJd76KNh+MRZ2ee4niGa+a/cgeVyL83fs?=
 =?us-ascii?Q?o81c9BYZ6ZiZSx6VqxutMjMvsd4ZYRURgO6KtKVG9ONbCZozA6tgY+etx6TY?=
 =?us-ascii?Q?2id33B2WJQ5DXN9Q4rbxKZ0r/pcHmRrG/88MDHqeGNKpBOcPrLjSFUWGHyUd?=
 =?us-ascii?Q?QkdsbHzJYjMIGd1brMtQPm1SULA4vFI4mcI3pBZL+cLHGVj2ikaqCcx2lWi3?=
 =?us-ascii?Q?dvdtfcxMYNqO3HzwFAcvpxs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166854de-fff3-485a-99d4-08d9f05be3d3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:19:30.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKRsm134/PAhfl9FP7Psj8VEARvDZu+1rKOmF3SdG7bVdp0d0Tq1NBU3rUJLXKk3HWx0xiHbYDR4SkkqJNcpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5540
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 clk bindings and clk driver

Peng Fan (4):
  dt-bindings: clock: Add imx93 clock support
  clk: imx: add i.MX93 composite clk
  clk: imx: support fracn gppll
  clk: imx: add i.MX93 clk

 .../bindings/clock/imx93-clock.yaml           |  63 ++++
 drivers/clk/imx/Kconfig                       |   6 +
 drivers/clk/imx/Makefile                      |   4 +
 drivers/clk/imx/clk-composite-93.c            |  93 +++++
 drivers/clk/imx/clk-fracn-gppll.c             | 327 +++++++++++++++++
 drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 200 +++++++++++
 8 files changed, 1061 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

