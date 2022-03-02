Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73B4C9B21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiCBCYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCBCYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:21 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7E9284F;
        Tue,  1 Mar 2022 18:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b656Z1EyyJOANXOuT4KBhco8j1eneHJP5jEq2RLAF0dFuXQKMCqKefXWFVrvNl26y8mUmc4+HLPU2UtegQ3ZWRfaEF3OudFVQkl3NTUDP2pIdq3zeJfRop2iIFYiZve5I1cMzNaS0xs934m73hsOcixkVky/KwIQnZDnTJB9hQFRNd6xBOrslIuYyEQfXzeRvQjzc9t8YsVsiMjGTPlghOo19W0VfhTSIlWSDzAeRpGSsSPn/s6rXeOZ3DPS9eVVTnQtvmPSep67bQz736gI0YaNWxtam2lpbuumm3+1xTeRiesGEKYpLsiVUXkHJkZywfE3hOHMY3css0sjZeHkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptZv9CQZ/ktqqvIGg0immGCgJx0m8TB7GtFGAwfQnb8=;
 b=FMujB4KdtadKmju0K2fang3HOLxPeZIy1sK+f+3idlelSvTK/GinIW3DxZ+Dt2+JErVZG/xc6BBRdm5UvQy8YhB5O5FnSvw/6ajunEYfyyuFE70WJvmIKog6YRDkIJGSRfmIhQevCmLH82G2ndROgflfumPhY797LChhd/jrrOl7TeBuoP9sJogQrocjf7bGj7fLrnlM3oBvUK2c5O/6lRHkdjHhHEcVMbaHiAf5Hlpml9W2s19J0Jy5Bzn3JgLxVgzM4b4wZv3mdWDN//IdmfLv2x41s1punaLL1YcYgNowbaNPyayhNqadobTYE6UN/X6WzeGhE61BjcRGMeShJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptZv9CQZ/ktqqvIGg0immGCgJx0m8TB7GtFGAwfQnb8=;
 b=eKcRdmFTxScT4uhOIGfqf6Ifd3/DyXBFrcx/GVtU6Sl8Z8LpYUbFl3fApL/YXsuwVsel1jsEIQto7P/nC2SyV6+nMhiB+cw2afzCbcYCE8ORAhLMLkb1MPXsH9dusphHZGzcbDD657TsBWTx8o9+EPV4gist07y1dBc0uDweiFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/5] mailbox: imx: support i.MX93
Date:   Wed,  2 Mar 2022 10:25:17 +0800
Message-Id: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7399b10-158e-4db7-1ae5-08d9fbf3a6ef
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4144160851337BA6F8A993A4C9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQC6gIfJQGCRYR8fLPGzPucScq3h7AP0PPxTmYxuKDFzQ88Au4u6ZRSGsk9xFiuDic9Gb6PuPUxdUReBCyi4fTQAixXqzX7qnqBQo6yk0UOPgCcJz4ZNmrVc7M5BRcEeZ7FaF9MvP70jyPvNvbVfPU/nN15POkQGcRpEmcK+KecZM3V6N617zemdYM6leRPb03hvvizQt1TMPEs5+EBQHcNsyi3IP3bi0i9qPFWi02+lRKD55k/T2GK7k+ZPRytyOvJjeiaH3dcN0HccuNN4/fKRDV55lSIXPBM7Hzolr9iDpwXWo70A05zS7N5Hdtg25z6u50K5B991H1EBaUF4DOypYLxMV4wBK2YJ82oXtQntF7cj38KXj40TT6U+ZitW2kVcPE7BGPpcHtWSQ1CfpybhzNzxZ15MW9Qr++WBpjkM8ydxXBEH1hgFZBkf+ezSr0JMOa/RBmt7b/RuKjLy0PqiWaMqfJJ8FbcJhbX2xy+CJ3TosG2awpAbr2UjPcW/U9j5eAOCi3BVmD/X1ec8t3vLvBIx3cDJGIeOvgAmZLUpMqKObYW7xW3WgInfVXmSzHWwd7h6dhPamLTzdaJOWLPz57Rw9G1Q27OHPY8GxcEpuCukvE2qijX1XjAvAIsGIAM33Wyr0MqRIWo0NDtSp8zSnWdtUQazUmJlavl/Puu1ZozrPtuEtuibt4npj/I1tiE0spLScAExOhtd1kVZ64sNeRoSz3BF+zsKlvnM/f5DvawAta5v71hpv8xHEajWgorSBzErrTgdb8JDx1I8+7NwJUN8/vZzPZ/J5jvL9lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(15650500001)(8936002)(7416002)(66946007)(66476007)(66556008)(4326008)(8676002)(966005)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nO6TrmoKhllg+5rCT0PyaNNx6rqrObvyephAb1p3eBrYK4j4XrGPaXJOFUTn?=
 =?us-ascii?Q?uOGB+KE0x0Miq/VcTnyhGBT4QhE8Ez755byR9pv0rhyrCdNQLbk0SVwrx9sZ?=
 =?us-ascii?Q?E1IFPVzp+MJMyqfjiKdcAUvtTjxD0qmCC/1eL9JPh1Nn9dp8ucISrPpA6i6c?=
 =?us-ascii?Q?gkS9jvfjVRMt2YFKvs7FBvmlTgJkaXSp906DQBN/XrDWoRw/BYipVBTdCg9P?=
 =?us-ascii?Q?kVaCkEKvYbhjcdsGRb7Y6+f7+LTWzHPKu7R83Mx+F+eWdZjsczh7X7pGC8WD?=
 =?us-ascii?Q?u5pLeWPjRAbD8/7bYGVRrsQllQOLEcLLABh2mD77NFCGW+heXvXVl9KVhAkE?=
 =?us-ascii?Q?dzOMlLBwJOopXUdRtpdr7yf4AhSP/nBpo/pJLeiyYryDXsujIbQeVLsCAJIM?=
 =?us-ascii?Q?BwxwGWU1H7DzpXCliYshNaMEFOpnki8gghlIFVdQDVzGL6SdsV1/cb783Tmn?=
 =?us-ascii?Q?7VsawesgK6+6p8MFQp2wSB1zOEZjEPZH0sneWfS6ca4KohBi/v7L1NrbaX1s?=
 =?us-ascii?Q?K1k4wTk5sAXswwJs+mjJbD8BjyFWYk2qoNt/Qa3EE5ygR5hd5TRSDY2QbIQl?=
 =?us-ascii?Q?xWvvjtQJdzi8UGCaUasY+erzh5GDhQjuJfYXgKy524O9UuXx0i/AzFPfIYoy?=
 =?us-ascii?Q?508ysuiq6Bbfl20LaLFDvjncp8CttLmiBaPhDxm7R+hVdOGduSgZYSBu+Ecr?=
 =?us-ascii?Q?ndR/R9KSNZZThA3s2MqmzXFeptHh/GGQme9dPYkIZYs8zQ00MZcjb3lIzrwJ?=
 =?us-ascii?Q?FenjhJfxOfj4uDb3anE/fRGubGtbfL4Iu367B3nrXOAyn+jqCo3h14QVG62f?=
 =?us-ascii?Q?zy1QjaQHH2dJ8KYyK3KcA8r52jo5Tb+bwxmFJ/ANfnph+9UA998YMJe75fA9?=
 =?us-ascii?Q?aMdENJYXm4Ji74E7JlxlIw11meYgtSfDRE8dT1KZ6m/empJ6e/x1J2qJIVb/?=
 =?us-ascii?Q?GFFi2JHxdmzPemkPUSrMnrNe0bVjoe0Py9pTyJhBzF/tY3ssTzz6/prddMk8?=
 =?us-ascii?Q?fWQ9NfCdML9nEWLIo59kCdbi/IJx6GZn3rgFIT1mV2psAE6+5OXl6n4aBA2u?=
 =?us-ascii?Q?wVxNMjy82e5G9Whal0iAQ62AOM9VWcKjgXqIcppBDMtAZbdX/6KSMwU4DjMq?=
 =?us-ascii?Q?/9JpUJffanT92QmS/2Vzi+3i4zhrvdGUyc550WHjf2KZ39aVnp0KdXSYOJKm?=
 =?us-ascii?Q?lzg8nTcaQuHAKKKovYHXeOH2JqdqFvGWB5Y/42ZLlwd3X6q91L1auiWjpyZ/?=
 =?us-ascii?Q?COPSvCk8l7zavI7fxT6H4HDB3WpY4LEdfMc7K8EYSRsYnvHWROB+BUV972iD?=
 =?us-ascii?Q?5TtVgK6IFAiW6414tPM4YNeDXEnJbpk0Kh4GVE8r1a5kas3K5+bKO8E5cV1h?=
 =?us-ascii?Q?Nz6TSdV9z3rwtrTlg7JpOo2MZ/88KNALDVSZfjabRyWqkZ0Ep+ORWO57elgJ?=
 =?us-ascii?Q?iEXZyAgrK9UGiHeb50aanLBrOALF7V8U78F5zGFHBF7sJ2y85t9PuNG9uA4M?=
 =?us-ascii?Q?L2VPjzR+B8OWXXYjCTt/DVme/4WSNo16JgZszh8qMf/8db9hVuqxyProc6x8?=
 =?us-ascii?Q?63xtv+Vk5u1IcwgH7EVRFJQmPebMvfI3oPYr5NR9CuVgUTDcLJO3wj5smZFZ?=
 =?us-ascii?Q?Hqo7pwD5oJoVUTn8RTkd1OA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7399b10-158e-4db7-1ae5-08d9fbf3a6ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:34.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnjQZhJpGkILPgJVfPmF4XZzP2QW02d5PRchyJDlCydEgQhPNNC9WH20Urt5ZAMH+Yr4zgfy4P0Vo2ivNq/72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Follow Rob's suggestion for patch 2/5 and add his R-b

V5:
 Per Rob's comments to patch 2/5, add minItems/maxItems for interrupts,
 Use minItems for imx93-mu-s4 interrupts

V4:
 Add A-b for 1/5
 Address Rob's comments in 2/5, passed dt_binding_check and dtbs_check
 Use tx/rx instead txirq/rxirq in 4/5

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

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 34 +++++++++++-
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.25.1

