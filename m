Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451EA59276A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiHOB3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiHOB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909F12617;
        Sun, 14 Aug 2022 18:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQgVqpxHwmHtlLoAH4mLwPaP2UR6rMr9o6jDa2O4jf+4cGKt4cRaR/2PUmt+sWfCl7mtRo5OPywrkjxLIDxpoeUJnb40WH3AdaHsHQ7C9WswAWAtiziSoSuwfNST3LixgmI2jYPbj6whYrN2XoQEuhkmi8D0S20ROk4AbyRCXLp3qMl12pcr/FoNZabv711cksZL3cMN5O0fCKpUKF9Y65wHzZWIRIWEjvW5s8VMVN/E9xYBlvLJmudVWxrwJGAcFvP+dg1e2ibTlYBLlin+nb01wHFWKiUe4hDmYqbDz9Hj5ScYfWXEsnEe+p6dkMiGhXmgIfQ/uFhegtHj077gPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fbkCPY48gjX9bfzyXdW1+soePARet+MnjPtI0RElGc=;
 b=ad1wfWr0BAJVnoveFb/noCFb3Q5CdlXaOxDSdIVQYcN6+OO7hzmB+P1pGXCRHmQUp/Ak6w8Tc2llwvr4/+kQLma3PQeTIGN3hM+7we6frnnVkl01Ee4rdf0nhB9SzZn88JaQpwJ3AyCSX7hTjQ4NjLUb5LVG3XFiOal63wb16u+aZe1lS3peqh016gBJoouwa3MItHDTKS0KIN7H/5EvSja51KvqUxG3scRXlNOavOyvuWoKKZJXgDs/gP0ITnr2XniHMEcmUJmQT9qJgrnjku1/pHN0ytZ0hoiQBd9S6H79B+nTbr22sC7ZNUXbxPpVJmlkiWA87NfRtn+j94DrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fbkCPY48gjX9bfzyXdW1+soePARet+MnjPtI0RElGc=;
 b=BZz5vlwvHi4CL8OtS/elMUE9QVQKeMx9MIzs8qJKhWDsIVbJamNu0t33q2NW/LC0Z8x29CWpMGaaNmxIDf7sQHHDkWMRt/BsLyhFhr6YVPn0/OalF9Uv3a0JPmL1HLI5EHw45Mw+i7sqlWLstt24nsUco0bhwYykPXh/P5kbHiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/8] clk: imx93: new gate API and composite update
Date:   Mon, 15 Aug 2022 09:30:31 +0800
Message-Id: <20220815013039.474970-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ccf9711-4c4f-4edb-e28f-08da7e5d8ac1
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfK/znyNNE4CfHbjanelu55Td9TcSYXrpN2At/O+uklTziC1MNjT5azO6iFDxk/ThjQefFE/F53sQ1cKLDRY4cwtaFn3mHvTjXrcU2lesQ9sASjZ1tUKn/eOvKMf2Z5TDN4FzGjrHEuEu7/S6r87z0K/tOyTEmDmtTBexhZ1jP+iS4W8x8eVq/2lp6tn9FiF38wtGrm/Enqj1JEL2OaSntfQySch+jYfD/3ybvDJix+oKz37ccv3xgbLDnpm+9bNRC4Yoi4q7UoaSj3b7vAWik3C0elYrahgWvuGVi4CNJKUUV96iima7PPnKKEPbE2oTgKPgTyQf53PbBFFau+UNGNtqfs2imqahPdgEgZN99Q3+JiOzy609c+PxMXo+L7ow7CWu6yUBOgEzq4Pq3pJGlXpiTu3pxT5cGQzFLBEns6X19nO2amQf3QlVE26lzYx7eMDojeW8o9cHCdSJz8kk8L+ZmjBnnbDUwrXquzYWwl4UfgT6dbwQ9Ru5OLn1FyMhyvtYpVfSHkwhVTZKdJNcZLyAkIIqAOtE6dN0G2UcUMp2b3DfPaaB5dgD8tq9WziHEMY8wSWPCBE9o+0hanR8vTWdv6MQOeOQQkdkgt1w3llDZYHKowGk/r4DC/eu2fKK5SVqwqFzfZyRKQTq117csCMEZIYIsVzLKPFgLAClQn5USQMAXmf9yD+JzSgm9CgKuaF/6v/hWEkm026rBWkbuvOOZzhspmy45gjsjDpmjyrqHcAsFZNLotpSDEI8UumFDY4vxm1/38opCyVRGk3BgJdtnixKl3GVYJib6a7alA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6666004)(6486002)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(15650500001)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?juzFw+jXyJQzrMUVzNCHdn2vfIEYtPzooyNJNM2DemkEjWZWAw3PmbI2q4lj?=
 =?us-ascii?Q?6a0bq+pKyMVdAO05n6TS/ecF8u7zcOeE9M6OrWIZUumLMjgjDbejMEoV1HB0?=
 =?us-ascii?Q?4vmDfj7UA1TVNgjONM+aOegoA7OSbMiizeJzQJKPd7u6RWiu+HTTZ0dhxb+U?=
 =?us-ascii?Q?1pkKaSX5rXAsP1hMzxndP99nhaCbJrKz8T7t11BVTPwRYvZkRVvRlymSvc1T?=
 =?us-ascii?Q?lDV3/k3zjDkxIgV5xmpQxF58YNwHiTg5Qxc5RlWurIun60unfQFBr/niYllh?=
 =?us-ascii?Q?seg/F2nyz7QEhytbVj0BLB7njKIXllx1EVkgUDC2q3bQK3iBcm7jdZq8vPaw?=
 =?us-ascii?Q?rDrK7L71RMTOY3Br4jHedUN/GmAn94fIzu8p1ydexBca60ZJYU6/bZVbF6Ij?=
 =?us-ascii?Q?kjC0AWW9daFkdNgYDU6FqlbSBFJLxpTqN+mCQ86N53/XWtg4x8OvieQ+WpGM?=
 =?us-ascii?Q?CLXRrQDiMe2OH8TruuH59+4JKqQqdNaCYASOrjih4d0+mM04QF+gQ8EJkf+R?=
 =?us-ascii?Q?4nbDBsizjRXlBScdazNeVhkx0/9Sty/euPKjgXa+QBPCo+2ydZo9D3bU12Su?=
 =?us-ascii?Q?rqAhZlj9M7JZcGb0ce6CawkyEYQrZV7iMZN55XICW0l8tmH1FyD1KLSKBz/h?=
 =?us-ascii?Q?RfjmIBxHhHtQM9yOTgbCHVJ2tJMPxWAlVtZkKNRwKw/sIZjXZtf2RjSZcRHX?=
 =?us-ascii?Q?qHnFHN/TjkMBBdocH0TdonVvp9AMICbaivUrI4Ax0fVzZPoeuex86vpJ8Dx6?=
 =?us-ascii?Q?+Au9v44tzzxhJY4JIfv8ws0fIA9uIJ8lGMCiv03+Agrl2ONWLvUWH7RmjtQJ?=
 =?us-ascii?Q?CSwftOljR6N6UnUQRN0Uu+9K4nO06T6GqF0GfCi4Cpf83Q0f8mm4JJ/GazrO?=
 =?us-ascii?Q?W38SspRHGD2jKUquml/ZsOzCgiyVCMH0oYg+swooKRkucX+c+N1XXeJMeLs7?=
 =?us-ascii?Q?R5Ueux6LjrU6DHg3ScFRHJC1ra15pl1BD20K6tWero0y8hUFmuKU7awrt3CB?=
 =?us-ascii?Q?/F4sOzmHi2kK1bDeJvPHW8H7f9/sVS+be2zJaX9qeTazdEbvwTIPxz3ACCJl?=
 =?us-ascii?Q?vxP9S6RMxzHpMzU86+AJZh4ph9M+UkZLGLeFXOxxPHzefGynArZ90eanXojp?=
 =?us-ascii?Q?xOsyHjSaNCV1qOmwTT6G8qN35H/bWPiYLtn9vce4n4u5dzp1yPQYj9qn/8wx?=
 =?us-ascii?Q?CoOtmMkNs1trA35i1fAsrtrkU2mBgr5G0hOVFHEuKKX0NR+Na5rmRvhGmMnP?=
 =?us-ascii?Q?e1qPJz+2SHfrIzzo3hSt7m95m/VBhDlAXZoo1nbpxBcwhSw5A3kH4GYX3G2N?=
 =?us-ascii?Q?xubR2HM7KruADULjPy7HSlUWqlOM4O/9Td6HN65lB0Jp8naSJTUMxp4obPZH?=
 =?us-ascii?Q?oxvc8cncO6Cd26/OdvrNh47S47aG7NNAS4NEcvjK17c2MNNxp3F9FeB1My2Q?=
 =?us-ascii?Q?A6abINDW/WEciy7P9qQz4TJ0fIFlS9g7mMxohfeKuayZESJcxqdOQ6qW8OAE?=
 =?us-ascii?Q?ofDyCROn++Dwkv9bzvpQFvP8EnxTCrnlJMlCLFipL5oWrKJL8E74nQkSYjOJ?=
 =?us-ascii?Q?s2219LXH01jKNZIPtf0WTotFX9zm8OoDB4oRrvRD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccf9711-4c4f-4edb-e28f-08da7e5d8ac1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:05.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7aR0ZQu6wdjcLicWh+vIVQ4s4oaZa5V3NrSEsolu2/OCjNZ0xJeggsxuX+N2LWN73IIa+rDALlUgC5htojE0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
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
  clk: imx93: guard imx93_clk_of_match with CONFIG_OF
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
 6 files changed, 403 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/imx/clk-gate-93.c

-- 
2.37.1

