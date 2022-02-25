Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD84C3FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiBYIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiBYIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:16:18 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C481D0D71;
        Fri, 25 Feb 2022 00:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+148Wy+c1AEzt5jPR7Ocl7uWikzcLrfVw244AbwJDL7SGRfoK2O4VtYxny3y8nuzwGW2yx+30TGZsoook2/ah2y3bU7qcqyXHe/oOLHirlGX76flxyiHivEFGCokY6k0nD++min6XM6/Hk+5VJaR26dt+SkyfkazTx/6KfrpjBdOogXr6wLl2VfbKevNVbMxIcljmXTN+KNf8bbr75giptX7qzSsE2LMGB6Mjqg5k5W2q0P6lHbNPy8sLBXjsCHYjXpsU3Ie3jc0/767KCg5z7h1Gf5+b2v+Jk5+QsjXG7N1UXjeH2RUeA6wUNuWpWljSl/O2YBc9mKzY+Gzzo1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sg07iE60N7FBPyRPJYVX6rMvEpI/ECpzMxdAykHc2M=;
 b=B5L+mH2kK12ywaFsui8PbQ+csUhemLJ+xj1GMNldD9q41FkSVRFrJUFNfPBwKDRvUStsdEV/YM0ftZ3BPSar8GeMrdznir6cg3hJ2JkLtqWY+W6MXs3BHq0VOZ2EbSW9fh6CT9DSECQ1bQQbrpb8lLddYbW+WFMCfFmZ1es3oSRrnoIrydRKKJ3hPCsXwbtwbNfg0Vs9y+uIBCcI63ZebezzGzB2VG48BhRiCJe9Qvn1Okk9edqcT9q4NVS9RYAl6SxH2NJJ6MLnJ+vSiXtUCLL1G1/rCCNi3CnnOJEXrFRGLvE34UO+ZJT1E3Xxc6l43dLdB+SBuAwGiqMDI31uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Sg07iE60N7FBPyRPJYVX6rMvEpI/ECpzMxdAykHc2M=;
 b=XJL3GZ9xGK3IjRMJTyXLUlRCnB0p68i8Q/RiABAMRdGpBcrFcCfMt3sg+HC0nCfbwSaZeTA9OiiU4WwrnClESV1SES63GNXLVm00CPClYJbkXqDTxI5tWQPGxEHgxCkswkQ5yy8l1P68GB6hxLcgMRhxetkWEXMaLjLnGpIsmcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5419.eurprd04.prod.outlook.com (2603:10a6:10:88::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:15:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:15:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] clk: imx8m: remote sys pll1/2 clk gates
Date:   Fri, 25 Feb 2022 16:17:30 +0800
Message-Id: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf5d2f9-d4f8-436b-08eb-08d9f83703c4
X-MS-TrafficTypeDiagnostic: DB7PR04MB5419:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5419C89EEC2C4842902E2322C93E9@DB7PR04MB5419.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMkRaNHdH3TUfTRluueEgpxuA+SG1obFM1DkfspQOhHnJOFGk9aQtWJMtnNQsCOoaEkFTBrdY3YkjllF/eQzVby39xt/UmEnL+eN0twzwwUahD8IFbGkYz6J1Kxi55HCyXFOyyCndff16ZDlY7k4uojVmPSRkxd+S7qviOX/8u1oQFhQEiSYsQIssxvYlCjucEAsjHONIZMMrWNMrA8mdBPC7QrXy/EkhX93bdNynZQHK/yNL5fwp+bbOxTIqGEwplQMVRnfPdhy58ogLJ9IFBoBT5EOp05l58qhhgT5qJEMEEe4vugDD8a31c5Xl00lfNJjcowPZRg4J7Cf7RhIZLxCPudpNKNlEjJqfQha9RkFpRiVzgnTLuDnTGDdMYr34yGQkoT+R/daDz+N0qh8Wvuwx6Xx3uRy6Xwf6MXAwzxjnQXFGQrHSYiCxDDWrfTRIWQ5QnlRcwStWJRZVJLylJkqz9eZI4G9i2b5lbsI/K9WJpf4Y3zVQrNVeY68tEEkulWx5KYu1cizNXNLINlCyDhFCDj2WPqjEmXbz/hwECU0X+nvFu/vyMr71wI73uVqQfpB3fFbXZ82qFgm3Bt5HUVszsMXNtbZ+C+CM2a2eX90hRApxrMyR84RcyhMb7DFFWBqqiBpyp7QBbMkHv0ha3zEMvQnSRFWma7vfrLJwcHEOs4C68mv9ou8NxMb6Dzw+p5QgJBcHR1ihGTK6/XHVCS1LMFdxp5L3EbvER593qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(1076003)(6666004)(7416002)(26005)(83380400001)(5660300002)(186003)(4744005)(8676002)(6486002)(4326008)(66946007)(66556008)(66476007)(38100700002)(38350700002)(508600001)(2616005)(316002)(6512007)(2906002)(8936002)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fYarlWr/4hPtnyrywySMEEPRvbWQWZOh2kPHOkAA7cIxXn/rAsp8jeAf3k2o?=
 =?us-ascii?Q?SCTWioHz8WwOWXhTBss0LW2TuNzne51HaaiM07AJyDNfkfQGrneOI6cT7wov?=
 =?us-ascii?Q?PAjaOA+zKQri0tcaoNmLQiUugGmpCGqGthHnvDcz+v2kOXK9OeXtfoHY8zrC?=
 =?us-ascii?Q?p08WdJpXSAR3eJAIjGfdGg1CQTrzfsFRwEJFKYwOCB8SAqggF+gQJ7BhsWcN?=
 =?us-ascii?Q?l1Fj1W6vlms/7XtbfxgwdsS2Dm+km2TNM8l1PrnHE3QvVUPrcJsGTYeIqT8Z?=
 =?us-ascii?Q?MQPrU8XT386yVAMsuFx9+CbllaIQxzHrCn0vg8jIi/8mlB8c59SLhEmFG2Rs?=
 =?us-ascii?Q?LPcmCWokHEKu2L48BQ+qNzUOFgGRNSWxGaNOpaeqnLyPFxm9UU9Jil8kK3nz?=
 =?us-ascii?Q?PnTt5YohAurwDEoKrc4LdK/pLBTnR3H775lUYJ7JbkzX6x3bWzsfyGAwVBSa?=
 =?us-ascii?Q?UbNUXS+waqvd+u1jN2wTcEHK4vNJDbxAgdljGmB5d5tXvS0k9t5dcpTr8Qca?=
 =?us-ascii?Q?bJJZgmskUz7tt4R0idnzKs1ejK/fsBjVIZnQRoFJYQNhez7UT20SFhfuhXOR?=
 =?us-ascii?Q?gW8DVPk2usJlS5InqiXN2lViweWTedmJ41Vwzi/nMYd3Zvmp/bVVAXkGXNCU?=
 =?us-ascii?Q?WB3YGyMo/wexgvxYRS5xvi+12tpOZkXYvjPatV2efPtiuYj0ruCH8Sp8YcKd?=
 =?us-ascii?Q?v6MySvwUACFLrucaFY4eV/xqJixx31IGLkbCmt0Vhhdvylj2l+Z8wWRy8jSD?=
 =?us-ascii?Q?1S1s07gJO3VIJuE4Gb66ZOFmQHrZwRTrTN+1sPZ8oeXsc7s2C37QDjv8T3Pw?=
 =?us-ascii?Q?t6KbbAMvmwn1KxJgncupI0KXl+geSaIttiIiFQ8B8+r0Wag0x5RqJY5hC5Gy?=
 =?us-ascii?Q?cNYVKbOqUJpa0icjoaUPSDZjx4gVluIxm8NAIHk7p/Y2v9ZMwQEWwuiljEEx?=
 =?us-ascii?Q?BgsGp0ghho8qJi76B4nqst+7xCkyNviXtAdd5UM1JkSE5oM8HUvy4zyiuv4N?=
 =?us-ascii?Q?JEP5JxDJkddEtEZ/WRotI2XpPicBFLs9SeoG3jL6/qZweL7P3iVKssfJRwn4?=
 =?us-ascii?Q?LicZenECLVY3By5w3Qd9h+zalo2EIT2MXhnqLyhVEQOSAShbihpxy80e6R2S?=
 =?us-ascii?Q?oriBaHHzdmGywgo3918+cY4H5RIEfcamFEFBkZfaELKP7C76YXDNRdEJzLXJ?=
 =?us-ascii?Q?CIFDx0sTy20rA5GB9jfB9MewFz/AibSdd5uR9kQbhDPT87FjBGHlvVYq/ty7?=
 =?us-ascii?Q?ji8di8Dg+Nrwx7Q0qFZ4XgrFCdunFmr2WoUYFNAywAcEoHC97sJ7VfynS0CM?=
 =?us-ascii?Q?fC32CIO3T6JJaIIwDHFXSVL0rdnQrbmqy5FFVuJa0Vg4r4m/43mA23eYX4UH?=
 =?us-ascii?Q?zdcRiLQvkYDonlwwFgPdC59pZctDubX0oQcKD/H6ua71p9egIksLRTs03uGV?=
 =?us-ascii?Q?CDg9EkY8nvSnx++m0KLn/yWs0GxQ7IId0R1GULNBKrNs0837Zbt0aHQyHI3J?=
 =?us-ascii?Q?M5STjB6mdnbwwD3vw6/SgGc6xEjsY3heFgFF+NUR9kRAAkCYz4/y7pEQn46r?=
 =?us-ascii?Q?C1wZOwaQiARrxFlw/s/PYWloAR4QPYXZjjN/fBSY+51le8kcW+XmtylO8mh+?=
 =?us-ascii?Q?XMHIkc76B4mhoQz41VPNZSg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf5d2f9-d4f8-436b-08eb-08d9f83703c4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:15:42.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWgAvfNO/aHWQAU1UiB7YdYGhEdtMfKvB9MNjFGDYODcmNQMPicJT2TsAeAkjZx0R58h37pHC/pu2I4vmMG/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same to commit c586f53ae159c6c("clk: imx8mq: remove SYS PLL 1/2 clock gates"),
This patchset is to remove the pll gate, but still keep the pll out gate
following NXP vendor tree.

Peng Fan (3):
  clk: imx8mm: remove SYS PLL 1/2 clock gates
  clk: imx8mn: remove SYS PLL 1/2 clock gates
  clk: imx8mp: remove SYS PLL 1/2 clock gates

 drivers/clk/imx/clk-imx8mm.c | 49 ++++++++++++-----------------------
 drivers/clk/imx/clk-imx8mn.c | 50 ++++++++++++------------------------
 drivers/clk/imx/clk-imx8mp.c | 48 ++++++++++++----------------------
 3 files changed, 48 insertions(+), 99 deletions(-)

-- 
2.25.1

