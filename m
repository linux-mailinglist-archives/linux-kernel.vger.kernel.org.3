Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18EF56303D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiGAJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGAJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:35:21 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30084.outbound.protection.outlook.com [40.107.3.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7174798;
        Fri,  1 Jul 2022 02:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKuktQCel1MNrGB+1Jhn1cnZigxymo8EP+PETy1RJIUSa+mk4AAf5Q08KicTrpPKSWAvObKqobECumAkyDQU/59bnOPx9YS3cav9zKUsFBgOziaROOAGCbBCXDB1VwDmllylkTYlUJvjkWbchyIgz2XotK7szV1Sxgjih09TsQJSE8MtwZ3kw+GXG+84HRk5oLC/vTe59G9Uun7A0IKkSi82S9LBdIk6euw2MLw83qR2xj9dJ4y8mDmBMkqcitta7/9NBRuPvzuKuWc0cEXYU2CaEBm+eqB4dqpcZ/p/FR1iP4UioNuCZ4s05dwaOV91sltWTeqbv5o7gbW6i3zrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWZk2ipfrmVOuDUklIu3RE9GIhXwZSRuXvwX/zjzeEM=;
 b=WBL//Xhmp/cCPysr7bumymme0Og3QfLAU8s4atZvDFw2IDzxpT1OJ5wjkY1rpnIvoPoiZLzGEPJZYRKSvEo0y3SeoZ7VyUqe7y0Pjbo2ryqKjERAOBc3qQF/AvPI3fTBykJ7HRx9+JyyclI165itYzOuJzBu+SEe/c8zfvSTxUoXJOpiyqdz6eBADVklixzVf+dCgLIzW4PNjMvVmL4a4Wya3Xx2l53E7CUMiRWBesEaKWI3AsNABDJiZ5Sx7eb9214q8ouX9G1f1A6ix7Hp37tBpNh+Y1iFJf8v/wd7grufkKIT9Qs8823zzHTaxaUDYd5mZdKtQqYF6AEBtuCPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWZk2ipfrmVOuDUklIu3RE9GIhXwZSRuXvwX/zjzeEM=;
 b=fujfBNuFeklTWfH8Wc3Dlzr4GbP65CmS4PFCA1BPzOpNEbDG2Vg+AomXYwrqdsEABTbNEzdzpYxEa+jerUwaXmhC+KVT2G3asy6pMrXQMJsJtPMp9quevMay4Aew8DezoiVe2nnl7VShZh2G9GRLiEqMN9HvH6Ez5PG0kaUjEW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4655.eurprd04.prod.outlook.com (2603:10a6:803:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:35:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 09:35:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/2] remoteproc: support self recovery
Date:   Fri,  1 Jul 2022 17:37:00 +0800
Message-Id: <20220701093702.265249-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be43fe5-99ba-40e3-8a37-08da5b4501ce
X-MS-TrafficTypeDiagnostic: VI1PR04MB4655:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0bnp2EOPhuM+YFnjCxANjr+3pjjb54DlqoWl8VXf1087c67dveMc8YSPhqTaLlWa+o5rWZiBVxDz/YhEadlgLKCiVDNbNp11ZtnPzqK8cigRyI1pBBHpd42/DoG0m6ExgY92n4GT/gJfygJSmNzSXEfZnGIZkz/aF2cuMdRfEX2e7ezseiq8zTxZISOZsKGR2mUzhHVBzTPNLz/4jdzOeN0DXV8dMxAmVuOEoomhoXTAP11iqnsUSUeyBbADpdbVwYTDoR5+2LI0cgqsQvSm/7+XcDwK4Vyj5ogujldl/7GlzsilM5XT6zdn9ThSH60zzO5kBzcGGznIWpFzjirLSlvMMKD5HW9kfKbxDMFE0XGCJ2C6DzphRrAZwanbIfXhIPdr50LgxjY63I7wChQhIQkftwrYteO+GktzCFndeWs/HhSp9c7UMzwVxN2247OqYDuRxtDZiaH12wobh6psIXySWuw8+XAunwOQHk+OOe6YbGldOHB1exUMOyiNIAfi/qHpvlW0xaNvCchMykns1YOb9uK43ukl6KqBc/EZF4HCshHN48U7B4HloFaOD9wrmDd01FqsRKwd70P5HYjE6wmGLFf4Tkll4gxhFHeRUDfhiwHqDqLmUD5QKjKlUu/k+nPxx+jNTzujTshEkspIoJc9k2ALENOgkaTX14N/67kTi2yp5h9A+p+CdBv1jOo/DnZ7ZZgjiMOihY4Y87XBextCIihoP6bIppHOH8cmnKcYPzxjrlJWoIkoRRvxCDMbVWeqETtv/QzV7WYBewSv3Ock5ixK6IU8SOJ0T9GfVo1Dqk4t0vRZvKdkfYsKJDtihXaNGKboDUrUpoLhV3Ec2cpsuNf1XGtoVjr309TKXlcgrZgr0UaZ8zpf0q1gn74
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(1076003)(316002)(66556008)(66946007)(4326008)(66476007)(2616005)(86362001)(186003)(2906002)(8676002)(6512007)(8936002)(5660300002)(478600001)(26005)(6666004)(52116002)(6506007)(38350700002)(38100700002)(83380400001)(41300700001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjQyeB04QSI00w7HorZi3XxOgtoZFcqxx2gfMAxRpTmZj/TQY9QrcSoNEKxH?=
 =?us-ascii?Q?T/GqK5Prn0uIvgKV5NkCpL4Qr6+niN76Q0OLb4oItDk3wn6iRsLvhuz2yZN3?=
 =?us-ascii?Q?PspnPouOYheMaa7O79bsnx2PV6BAYu7gx5euvJsqkN9rPCx6w6Jg5mKoRvtJ?=
 =?us-ascii?Q?aGdqr4N0SkbJgOAq9/HlJC2BhZ2A80AAfi+U1qWg61LwVl2DATQoU4MLm9eh?=
 =?us-ascii?Q?50+qI5b2mFdyOLxXvVvK3o1eK8qAY2HI11DTu4ZnX+LHXZi+QIkI4B4Jn4+h?=
 =?us-ascii?Q?aiB9pB7mctMuSr4TPf5iJvd3rpQRvKguMBy03SlAIvVdoQR/e6dx6IqU5aS6?=
 =?us-ascii?Q?C/bmG7P6E0VH9wtRA0hvcwuF3f+ONRfUo1wMLQAZJ1p0f/2zoxoO318fnHBn?=
 =?us-ascii?Q?2AswWJk7c8Pemwa/AxF/cai3lHlPAIBEZG75sZolHMHgU2Lgo8hQksJB21Zp?=
 =?us-ascii?Q?35wyv5y/Tmqs0hGWfES1Ja6NvilUbgOs0EBYksckJqyU3+anGGLRSAWdKSuX?=
 =?us-ascii?Q?pfhnaRKO7YWwBqrB9l5yWw4wslnLB6nWKgMUkw3uDghDPp7MJCR34CpR1BXo?=
 =?us-ascii?Q?mlW+hX543Lg+PSuMQiBROMNvao0KPJtj+eAFhX+vT0ytIk/LS5VdkpaJuHIV?=
 =?us-ascii?Q?hLW8zLdeIG0jGK/X4889g79eBaFYGQcy2Ye/3rvK+rcebty3z1kA5/7ekEAn?=
 =?us-ascii?Q?cx7Y2J22aadg4Mr0hR5WwlbRIPLWx0V2SVbyYOUM5cwJH5uGtZsni7j2Y+ZI?=
 =?us-ascii?Q?H0eVLsLyqWM5DYis5HDtjEz/HYwdyru8yIw+X4NfDkx8MpNmjliW/QKAkoUU?=
 =?us-ascii?Q?dDaDO7gfJTzSrlYFoogefVnYQqaRtiE6iIedYyyI+kWk57SnBJ670LwM1HUu?=
 =?us-ascii?Q?qmVgWATD09BwdsrD19qDyCpjP59ib47gyaCjpzI1u+tkf9m3V8D1ZFW2yR1t?=
 =?us-ascii?Q?GTSQDbkzM67J6N/rm3UQ4RSHrpXpO8yoF/9ndCRMTSKMgBvuIX2i0Wmk4H4O?=
 =?us-ascii?Q?hWB6isOd3Z5cUYUtZw3sXBkeM23elU0/Qk40yZhVdjSderno92iwWTF2W/Mc?=
 =?us-ascii?Q?WtwI+P25u1EF2XnbjoOWn4MyLdczAm5VIgHr0FwgwT8z0r54iRoJgDXURFaK?=
 =?us-ascii?Q?S3GXGWyUvBo6V0fNTd9k7H0SKJzRRloHIelQiz4xp/gWvAZys6Zy6pH+4P43?=
 =?us-ascii?Q?LvIGzkXMCM8PPpDnE2kMe5tiQPgVHkWZ900KXEO5R6LKqBV88fY51vv0ey6V?=
 =?us-ascii?Q?X5IxFqt4qO8irteO6FuffZa2reBjEZhj+7C0NnYW0dskLE69EiUBvrd9pMK1?=
 =?us-ascii?Q?DV0FlVBQv5+HnOWUBCH40fpco/hJ+3VrG0z0QZ2tqLeQoaxCrX12b1bk4f9x?=
 =?us-ascii?Q?EjIjyPCpXKdVPRHSlO9yjPjbvJetfpsbbJerC62ud7ubQroqGvVMfuiLyJqN?=
 =?us-ascii?Q?DOAq8dQDIHvoM7NziKCawqlftu4iaJ+hrYnUrNYXldssVkPpvG/Jv28YjY4x?=
 =?us-ascii?Q?74ETAPsFt4m3tVzh2gXuV83vdBC6TaZXZQgKwwkWf1r93FPWK4saL6ak2R7O?=
 =?us-ascii?Q?lo86chbw8bNh6GVAmcI5KuvKBjDocL/akDjvktgz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be43fe5-99ba-40e3-8a37-08da5b4501ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:35:17.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIvhHDGTsNFjGZ8YRvd2fw1dv8ytYT/4747nf+jP7z2dHt6cLUlGZuvys/QEAMpGb/oWgfla/rUotL04SYdyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4655
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
 Rename rproc_firmware_recovery to rproc_boot_recovery
 Drop the unlock/lock when do reproc_attach_recovery

V5:
 Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
 Add kerneldoc for rproc features
 Change rproc_set_feature to return int type and add a max feature check
 Use __rproc_detach and __rproc_attach when do attach recovery
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/

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

 drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
 drivers/remoteproc/remoteproc_internal.h | 15 ++++++
 include/linux/remoteproc.h               | 15 ++++++
 3 files changed, 73 insertions(+), 19 deletions(-)

-- 
2.25.1

