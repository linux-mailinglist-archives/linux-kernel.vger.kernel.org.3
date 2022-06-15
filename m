Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7954C014
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiFODTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346028AbiFODTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:19:06 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64EA41FB2;
        Tue, 14 Jun 2022 20:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYVZ0OW5QX8HX5IL28LaorLBjlJbA+qeiLIxCPh9EeMR91MHzPDLwuKun8XnyTUr8waOxba5eJceK/Pg8Qpz82IU1+ELIjoM29w31nQ+CI1rIaopuBNm9FyrRI2GCVe64TqYDwqCbohO4vfQEfRlv3zljDAhC0ue56+F4WEli9Yyq1Qwcvb0mkSs4Kph/sWHkgNG2LeTxXq2QHenOo0KTjdk2c48WpFiGGJTZc1rItr7zH9BgwR5DNdYFF4NoXApT7dkUezTO1RNPMAaIK+ZrTgHODC5zPUdty0H8D82L8dYTTAxYtIcRZS9D3a+ay8by+UPUG/CmMX43OuH+Tdowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0IpTk/M9x9y+dkIkTlOXng6HIZ30c3khL3gsS0KOdQ=;
 b=F2h91QFZJhr4RAorvrwb1JL+1dbN42G7LaNDSQuCeq27Hgxolyk24ZTFqcAaf42s3ekqE6yCfC8A44xxFvvfch6nXalQmrMtKrG0HGbrjkkH3A11Ymy9LZckIG4wgRD9bbfvwFjjqD8qOk28oEHrE5sUth1Vw689pchvaKxAxBxwZl90jcrtd15Pyl5Ix1zvTWGRXt6mgTuBG1ioIuzKFgmLiBhuSGa7+Djc0PJkuERqChnx/QF9m8kKyCgyrNBTyu8BYGnIqHtp1+5Y2gyg5Vs3fngBTVzncAsT2hgL9T6anYqR0RsPi17wf/aHdm62+6fZZXY0Omf3Bp8gk9ybRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0IpTk/M9x9y+dkIkTlOXng6HIZ30c3khL3gsS0KOdQ=;
 b=WD8IVFVhHqZjwK/g6Ti2Qg7B8e3H9UtY60V2UUS2D6y+GAUUkw6tKz1Umf/9b7bbUeQlr6/3nqfwMzoqUaoRQOQx25+cUjGXZC8Isr/b90tFvVg0z/DjyZXYnbAswYPro9/Ixtbuq8S444KEQwST7fQPRVKXOww/l7C77ae5joQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 03:19:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Wed, 15 Jun 2022
 03:19:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/2] remoteproc: support self recovery
Date:   Wed, 15 Jun 2022 11:20:46 +0800
Message-Id: <20220615032048.465486-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 050fef71-e832-49a2-01fb-08da4e7dcb05
X-MS-TrafficTypeDiagnostic: AS8PR04MB8817:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB88179CF730EC855BA9DBA0DAC9AD9@AS8PR04MB8817.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2IVtnRuUVgBKrmETidhO0vw0E/yhBIkwEpb6IKCEiZzgdURzvAzWIbYVBcts3fuWSz4d75KGnz8HVcgFmTW1PLNjDln72OHbC/jFPxCQ7xPzeT26r2XbN7DRBvvObwK6r9OSRn6lNSe7bA35NJHrKhxCf7+/u/m9giNelnEN8zomUcpg32SasKEKC9bjwYQdGW4qWgo4JNM25+HONLkoI/ryE9rBY4n8DtMLrHQ/21QP63SMHw6BUnDl+UDEcsrJ1CQWq7RKlaYsXJXm/vsm6DH42u3PiqmPcIHkfKpeZ2KBUIrooCJhwlgHGfI1yxaHuPmeK6YeusqCQ70RjFV+tGOARizGmKY5B8GztQtALwQxtBikay9nPMfPK4PUhmkn3NQ49WQbDAgB7u3ilW1CM88Na77E5x9j/lJ1sB2x31KdkF8LO+QdytXTiDFtd15uwkt/e7NNIKIs3e43YoLWU5cBEjkaFw7anaakvllp9H7L/ExMZjD3SvC8un5+AIZjS2rqY9S/IOns+yh9PM/2p/g/jn0gq06KCGxikyBV4QunlCj4ZQxJRXryJBrYEdVmNZHmQ8rLJ4syTgPPpa6nVYWzI/gOJg3f89Go/L1cVYKHzmw4hjZxHi6CpcJcgPiYJAEQEMyOUjoerQo0UjsXqwQWt8Zxz1k7NSnIykj5y4Mo4JBPvTS9HsdD4tY2eT8Z7rxlbpqbKCPpMBJ+yVsW+/DYqZXQgo7OkEdSqvHXfgfsov/JSfxpC32zwvd1Ot8EL840TvOBcPMhyPc/zkITIv50dsDU+DzcO2vtMj1NTCtbmLOrPnryHUzL7hG5QegtShQ1Gvpgz0RVNyAw9mc8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(6666004)(86362001)(52116002)(6506007)(6512007)(38350700002)(26005)(6486002)(966005)(508600001)(8936002)(5660300002)(83380400001)(2616005)(1076003)(186003)(316002)(66476007)(4326008)(8676002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ytR65SN8qOdr0vZjXS/APXUVyf9Bokl2PGiU0ZafQa8445h4KhjxqyXO1aI?=
 =?us-ascii?Q?R36Q1tRs90O0d9H+GG0vND8nsSaSQSPnaPfWnNZfKTidGnTxfxdW+rcY/Oir?=
 =?us-ascii?Q?z5BVqYGSHO1XEKAzMMvjfvaotMu7DOgXeSAm1VW8VkeQAwRvMEaB8Y4uEM1O?=
 =?us-ascii?Q?WAzhAXJtCqJ31OT7PcZnL7O02c71iCSPHuWjOPHYWG4b5TwacpELlxxTyYT5?=
 =?us-ascii?Q?2zL8bEa2tZjtdLoVlCP6afuRrWzuKtyf+5WcNBZ03f7NE7iopa8JTLg2NSYN?=
 =?us-ascii?Q?EiP0VTx/HkDkt23ZASiHwpzf4HU0qPVT9RvP9zODbgM728fsfzAvjBPAdpHi?=
 =?us-ascii?Q?stcika7nXh4PkqOL4x8BOWVAxdBsFL8PTJLazqeq2UQTEiX8f9RIHIPgogJo?=
 =?us-ascii?Q?tD8VzkCaD97UYTuiVe8lNeQ6ySkkoXQDrCDhLs6J77BNPs70aEzIQJjES1/I?=
 =?us-ascii?Q?X5+dPZWrISjmfRupfTeveoLvktu9xYoOw+zZo7Ee86sw2NrOifLOklFiJs3U?=
 =?us-ascii?Q?PRYTbUc3HYngjaw+KE/C1y7vZgIUnwfmQrnDC+ITHXaTlSmREAUFcSAmdBQW?=
 =?us-ascii?Q?nkoHTBgDaqyRY20zHPVelsYa6xob6GttfK9dloARfRS8sK/8+MO5Pb8pHJGj?=
 =?us-ascii?Q?qJXss3Bfw47jZNgfiSa7qPzTLPpV0c2sppgaKeawTXJEzgcLNCYpRw8CIFtN?=
 =?us-ascii?Q?7zWr/TcYw4KgSmYlXxrdmIoQAFRAz05CbVn7bF8J5cvOoimFYeGPj8HB5kYp?=
 =?us-ascii?Q?ANrmEygfU9ZL/UFc55jkX4HoJ6SF7OGAwmPmmoywrxhQpi7tZpBI/ds9uob4?=
 =?us-ascii?Q?bmPDfexMtopg+BBxxKHt8k41sPGeXdJL94S2VRFzcLYq0rjW/0xllC74pNfW?=
 =?us-ascii?Q?54g3r7TekkZr8Ia10Yk9r8xRVf7f43xwP+pS0v8qCtC0kVfgt6LooShJIKwZ?=
 =?us-ascii?Q?UBVdSRtni0xgNPOUnEMbnybk8zE5rNHr5FtWe3pfSmXgta0cFkpFetQa11yT?=
 =?us-ascii?Q?sR76PBX/a68zmUaAUwFTjxrOlxDOkrdpm2J8sVkikAm+yzeko43ivGmPH5hV?=
 =?us-ascii?Q?TCh7k+tfBaTglY8Iqv4KpJgtc2FV7tufRD8FQ+4xwNvhRW6k5QFlsVyB3CPo?=
 =?us-ascii?Q?xvsI64hqhwBWkAJb5XOD5XoVrv57wxGpyCKZ0D86+9s4o91h3lAv2TElFJwa?=
 =?us-ascii?Q?H4w6bmmSkbziSmGtk7J+CCjU4g9HSv454uMddF9G6Snlt3b932GA4GRMpWgs?=
 =?us-ascii?Q?sFxWM87qBWS5ojx1v8LzkNRWe5KDHdyGonpN05gxlcuRHFzQiH2tJXaI/M2X?=
 =?us-ascii?Q?Q/nD/XdxcfkmHlfbY/zich8kHyqxi4KW07I9SkIYMgQcnRrnH4KrJd7+AfX9?=
 =?us-ascii?Q?KN6/OKFur2dI+gomY7NlyvtxjmreJmM/172NuK8dYxUF+6K4RVVj+j1Jown+?=
 =?us-ascii?Q?St5FrCnKdnvB8EGx5gYByt4eoGiVTcea8JhrGUJkl/S+dj2/MivdOYLA+1/7?=
 =?us-ascii?Q?b+Xpowcfjtbs4T+exVkH8hxbFv1ejRs8hbfC+5wKkwmNPudBmc5qhfQw8wEE?=
 =?us-ascii?Q?butl9UE/FqeSHiQnQ5WHMAtBGUy6kMt7sFhyshUCaehoMbDSp+lwxMAHqJnB?=
 =?us-ascii?Q?INgT1CSEhEVbK5QUlot1c3wJdJdtyH2yjU1cgnZPdU9Ed4OUJ+2ublW6lZZo?=
 =?us-ascii?Q?seaf4oGaDhL3Bm9VvwhVTueiPxOggpWvxr9mggSHogj55wPQ7STI2mKSgBV4?=
 =?us-ascii?Q?X5U+Hv3a3A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050fef71-e832-49a2-01fb-08da4e7dcb05
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:19:01.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmYKzCQ3dsn+9sb/v4uWw466Bhb/JSDRvRaH2RP2Ue+1jbOH3o9YKtdWyky2bhbfuZ7i/qZaBpRPEMrYu+RNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
 Add kerneldoc for rproc features
 Change rproc_set_feature to return int type and add a max feature check
 Use __rproc_detach and __rproc_attach when do attach recovery

V4:
  Based on Bjorn's comments on V2-2
  Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
 Keep rproc_features still in remoteproc.h, because we use
 RPROC_MAX_FEATURES to declare bitmap.
  Update commit log for patch 2/2, and add comments

  https://patchwork.kernel.org/project/linux-remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/
 
V3:
 Resend the wrong labeled patchset
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311

 Write a cover-letter
 To i.MX8QM/QXP, they have a M4 core self-recovery capability without
 Linux loading firmware. The self recovery is done by
 SCU(System Control Unit). Current remoteproc framework only support Linux
 help recovery remote processor(stop, loading firmware, start). This
 patchset is support remote processor self recovery(attach recovery).

 In order to avoid introducing a new variable(bool support_self_recovery),
 patch 1 introduce a new function, rproc_has_feature to make code easy to
 extend, cleaner, such as we could move "bool has_iommu" to
 rproc_has_feature(rproc, RPROC_FEAT_IOMMU).

 Patch 2 is introduce a new function rproc_attach_recovery for
 self recovery, the original logic move to rproc_firmware_recovery meaning
 needs linux to help recovery.

 V2-version 2:
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Introduce rproc_has_feature

 V2-version 1:
 https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364

Peng Fan (2):
  remoteproc: introduce rproc features
  remoteproc: support attach recovery after rproc crash

 drivers/remoteproc/remoteproc_core.c     | 64 +++++++++++++++++-------
 drivers/remoteproc/remoteproc_internal.h | 15 ++++++
 include/linux/remoteproc.h               | 15 ++++++
 3 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.25.1

