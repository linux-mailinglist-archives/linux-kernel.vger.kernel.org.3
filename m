Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CC4B1E16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiBKGEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiBKGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:59 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827C5F41;
        Thu, 10 Feb 2022 22:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8OMp8/1uAOvhhUuvdvQNVzC6hDqm0nkyGfDDxGYlz8o/KHhhTLxo+KXNQQP3IHAZZOshkQ147HliYkvXvZyg0zkShsHSga1ZyF+Vlm1UzXXLt3uGRhEhPtHDrkDgf+swDyvLAZP/I1/b97AqppSq2WH4ygICjzHNC33H6VBKHTmkZUUfbfIRiFcyglOsIjsS6X4qb4Z+fvOVFioKaNB3/1PnJc18oY7oJi9Bur1i1SLJ978U0wBh/dZuhg720B3uF7EVEHrdOzo+sF8NnbcE1LMH9Ls+N49ghEwI9ucvILu0orOxqKQWJ3lpq0lBXRVkW3S/9OMGFzMByiP9YrJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeRy9BadU4UQFEB6z8Ea1yVUomY81ufMaOc/Z0lK1n0=;
 b=hNj4CQ+ttea92KnNpm6aCKoEwweWvnlVpHLl6VIkGQuEh0xgKY1bVuooUP+wUqXgtd+TKBWS4gNEeSkwUL+CIjiDzCIH32w2EroT/Y/UBCgIBAVpcn/wPc9rA/d+KPG0ax112pcMlfoasOUC7MNb6P7Oprw+T84trlALTovsKpdmS/X+1arIUkWrpjoKMnV4OOggGSzrrAASxVY12womTWbG35TIZ4RDvS27aiWMqt69gF1MWYsjaK+WfWC84V4XHVu40h82p/LloAfgf0OtHhvSLM8k2vXDR7Rdp3tti/D6CuFiHt5f85DlSL1+6UQIivJ+MJC7z5ynbe0zNDTq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeRy9BadU4UQFEB6z8Ea1yVUomY81ufMaOc/Z0lK1n0=;
 b=jhBMPNUWAa4uCMoCMEUcBFBNQ/5OUtVd8CpMCER+ENNQBsLij1iFs4lz670klB4iGMW4sSuMZSd4Npt9/5sIvcIVWMhfsFZhFPCMBbC5wx4jsh9YS4BFvIxqDmVMRp44UCJ1siOg5Jjm+uFYZwsUmiZBDwEMTlfWHv3mGgxBnL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:03:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:03:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/5] mailbox: imx: support i.MX93
Date:   Fri, 11 Feb 2022 14:02:56 +0800
Message-Id: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82d9dfa-5d8b-4434-25b9-08d9ed244808
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7113F81D2DC5D94B4AD7BB05C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnRwfFxjAAZq/yuA98KZZzQq3uYNKz89BNiLkISOjhFSJ/P6RX89LpzKShoj0uXFrhB1zEb+Cr7Sa6Ui7ptvrREJ+63fWsAqzAVHz1qTWdb+316olL5jzyrKz1lUr6cOdxZnc/y9g0QRIJEN7yHzucC4hUVu0SXTxQssw/aEo66Zsa1OEnlAk9vTx/CU4ogRymIq9Z3n8ARtJCtfRoS5DSaRmkh0NEiy7DUsjC9qrfRPiDfqXvQEvBDS+ubT/g6R9WRy0tiGFRia4aKDGQXL56yX0PbVZpiM4bMkCSKsf5+WZnNEf7rJr9GTXufrKGhuqt6vN+uBURmiTDU1OcfhSYfukcEUvi6LPD8PczTuI5Lta1Kk1LbexZsXip1QCP73GBOYaPSZog4dJS1r3g4bAV3k6IqXufRNWgp+KOJNduUMQEWKzrLAH2t9hpPUJDIIFdU6vg9wAynkaEM3AwLntL3dAVMByCscszgtMTZ8fHyA3GA02/YTrXQlK/WHVGT/Zv9O3gsYB8gUsyz6jNdPLxFsW5kH46IJwJ0WlXfLKnVV21DTYW9wdFk//k65ahqhV/vV6BOKFwFouMnu2r6ln03JidFlHgOmuaW5le7/BQJdnlGiKRP4sDklywvM1jVqcmDIaySBHLN6BKEEhwOmQjVNVm8myk7uvROjpkUaMw2Tel2PDbfBdKzroP+LfWSxjLOJNCU32rJrU9iB8ZZn8W89eGNUNxUUEpTy8gPWmm9OOU9JNRkMslgKQ/vJIxQxo0c4PIYCWSN+WWFAnh8e1DhLQy9zCUuox+60UhVOEi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(966005)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(83380400001)(15650500001)(5660300002)(52116002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXzw1qj3fsscJ8Zru2BcCGyE83nrsvl1RjG3PME6OeGj7XPRsOlAYgMn1kjq?=
 =?us-ascii?Q?yUEMOMwU2aB0Q7BCl/MSB05Y91qDz6cHo5y1TvL9BYCTWBaRQ223exDFaKDz?=
 =?us-ascii?Q?dpDjEnbX5M5vmf8OIgkgNE/1Lr+z8oncF2rgZOdxPc+qpOtWYlFY4Ut+JRn/?=
 =?us-ascii?Q?mrE30dGvbh8+DVKmLugMN4rsFJUpY8wa8lBLJi8Ln3gEkYcrfZksUzz9IvIS?=
 =?us-ascii?Q?3KNudQb7WGz0CsezSoPVg3fAdPJSFWTcvGlMKRe1cxDTAFrZy3hoRv29nj4V?=
 =?us-ascii?Q?/jl4jkLCNqVHMsYVrR6+RoofacgzIqtCbuKE9eXv4I2KDHYQYoYFWhrXTUpW?=
 =?us-ascii?Q?UngjrEKM+gyfenjMkDbwlgGTXnSH9lBjw3xHSm3znwnSmzkQvr3ZECftDvaj?=
 =?us-ascii?Q?jYgnMv+BtBG1olG/nbiWH43FodNzxsS9qtIk9mShbct9O5Qde0dMkc0xm6LH?=
 =?us-ascii?Q?2Qq895cSfHIAkkgH9Exg0V0kH/PROvdDGpnmgfx09odnJUTfaXy+TjAxoDw7?=
 =?us-ascii?Q?qCSWzXhZrqnpnwfcI8o2m4XdtRwn9pRGDPSp6Q7dLpl68BGeGrEqasnbDLg0?=
 =?us-ascii?Q?MaA/R8zXjCkxZ6MXFepQLYZnFGOQ8t9OlmWOcoCkotmycYrsy2qsZwdFe5Xg?=
 =?us-ascii?Q?Un+Kbahtk4nWDTSLwOp67x7JnGPoOMqf/JSZ9fm3dVKzaaJPG847gpuFSYLU?=
 =?us-ascii?Q?PuLtQJRVmi8htgLOVSQZH/qrPn57L5Cnl+BfbiWbGPmX0Ndp9hokglHbHHgN?=
 =?us-ascii?Q?FQTTQao2pPZk1JJG9iG7v6UhNc572NpGmuKXzmQEKdP+YyFVecf9Qzd7THqL?=
 =?us-ascii?Q?R5cVO2/5ILWihf8lJTRuYmlGfoHRIHdl2qghHFCmzSZF+cavnp6OdRjvJ7Pv?=
 =?us-ascii?Q?VQlDZBTPmyG+tm4OiBb35sdWz5Xw1IODgvEI+tGaLPf9o//BFi6jVPIPnLdP?=
 =?us-ascii?Q?MCumCVrdVShMQq6shE8GCH7colpuMMyISOPcPCBy+u+xBApAcZzafXwaoCBB?=
 =?us-ascii?Q?ARk/mXTuI7HMlKtWnTrbtWTQv7vc6D3H84psQvIfB05s7LK5r3SDhOAJPu+2?=
 =?us-ascii?Q?x5iTiw8iHGy9yG0fjkdyaHwFtfsnh8zxcQrt8cbjq1BWt/4QooRdzw3YOIJZ?=
 =?us-ascii?Q?sO8dEYsJD7vvnBNVEUbGvO+EWbE+eXdcAVfheZrLvg4V7vwRUB1efIPMLMW7?=
 =?us-ascii?Q?8Bn2cdM1A/6i9oGHyskqL1ZjK7ZPUad+gNDZYHIkJGhiWSlN1cYtgTg2y9fj?=
 =?us-ascii?Q?hBIabmIuCqI+UMiMvg+0RyHddK+Wx+7sxoPnb1kLjYI+0jPxSB7C0+JMIQjW?=
 =?us-ascii?Q?fykFdcvsnksr/cvyu/mrTXq4SdYn9qSs0wZt+RQ2YquRpGvQznzgz59cWH5C?=
 =?us-ascii?Q?/J+NOTvwmImN5t/zqF2eKxpox05/zWR1CdlKA0auNI3OSiI4M8Gnt9TgB2YX?=
 =?us-ascii?Q?OjszyyR+THx7xDqiAC1yVvT74GZXo4C1NH3w0j90R1sAoJlO6QxbgCXcWwbQ?=
 =?us-ascii?Q?5OWoY7/ZYH5+3m2bromGsrmFNlJ03X6dXHzIvDaFo+cB2W3vIK/PLCpjGSSs?=
 =?us-ascii?Q?YaHW/is6xyw5G0w5+nYvaSHMyjvPBP6K40BUSEd6Dp3u2/XSXjDe8y7+xtph?=
 =?us-ascii?Q?KV9hNIrWJ23AgPpdDwLXerg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82d9dfa-5d8b-4434-25b9-08d9ed244808
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:03:54.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nig6AhG6Oxt6wGsyz64qf+HMVvwSrIrnw1wDO448KTTs3N7nU/Mp5ABEHSpBz4MSK6gg61c3Nf3LMSHst4jOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
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
 Add R-b for 1/5 2/5
 Split V2 patch 4/4 into two patch 4/5, patch 5/5

V2:
 Fix dt bindings in patch 1/4 2/4
 Squash author/copyright patch into patch 4/4

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

Peng Fan (5):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support dual interrupts
  mailbox: imx: support i.MX93 S401 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 24 +++++++++
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.25.1

