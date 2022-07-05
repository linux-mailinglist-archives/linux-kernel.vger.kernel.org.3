Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B00566090
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGEBNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiGEBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:13:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762FEE19;
        Mon,  4 Jul 2022 18:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrlc/241qIWTHAhMYZxVIwY7LbCyQ2JOCXuK9pTzLYSp6yhv9LjwU/rFy7NA/otiMvTzgzL+NJs+lzhMLGVTRvXb0rQVUM9jhiW6e15MSIEhpdj44EV6aMUHaTnP/QAknAdytfYXUfqH0zsHJStl4F8ZugO1I0NEsKIcEPnXqgQceMupirhO50NHN4Pnrx6wAYqVt61pFti+USbrMtTcIX0TgSNn2aP0Qzar8qrrmuqHqw1eaxgKDOynD+rIKIjtL4x6LetqoSHVGcNTqptde+SiXh8DP4FnPv+xlYsiq7uCGPgbzeXVb6g9htNOBIMBjmFQsbb+HKl0DhlelN1iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2+aL3NaizpYxplvW2GPUVb/9F8n2S5ika2pp9+VEuk=;
 b=A2Y4pdYPEbTjdqq/Mdh9ebK8HWARQSJBITjoDuKuskSiY58cK1UioAYdEI6W1wc43zivBAMLF8BELi6eT2kZ03T/z/UJjFLkjn8eUwgYg15zwCL4LtHgpBO42mYC9/SUiOMJpj0pPRjdF5eg5E6X6djoyAq/qkJ8rtPvNVne3Gl2d7wG6D2UIn3idhkBN1gHSFzxdR2jmM7PiQiYonWzelpuJh5p3dZ9smwut5vZ182bsCOQkOJpy8eRJy4zXb8yN2XA4bGH2yvUA1Zd4geMVwyaHQHdetp81fZvM1/K1cDtam0CWP0vp+Xsp4L9hVlJ+rmK/6E0BroMd2iDRJ5/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2+aL3NaizpYxplvW2GPUVb/9F8n2S5ika2pp9+VEuk=;
 b=ijmbsdYWi9NGl3LCCRaBZqNcl9DlbXV/6xWjD4NJRbf8XwgnQ0rpLI1zFzu+dfBm6Ekw7F8S1+cn5Bwt69P7KvZy15k/1qBQRy/xKAiHFyzo93k+3UQmuy0af3G1Y6NAcIpXFbl7ad7Q8C5Mg1AeKdtYyKdp3T0fDIQQj7KUayQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4365.eurprd04.prod.outlook.com (2603:10a6:803:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 01:13:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 01:13:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/2] remoteproc: support self recovery
Date:   Tue,  5 Jul 2022 09:15:25 +0800
Message-Id: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0c9a13-fd35-4401-d57a-08da5e239ba9
X-MS-TrafficTypeDiagnostic: VI1PR04MB4365:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxw7d0DjtuXCmw2gEZOwiKVJungDmWCbTM66WsVunITTonX2dY/SHW99FrnW/s0NxO8QBThJddQJowjyG+g61hopu+J6s3o3kIlESuR2MwY7fqjVW8iWkmwU+s5YbD3XAzPpcM3n4LRcOTKETDd4VzzVtZvLavjQWjhdpNTMP3/Ucu0LQhnzWLO3trS3KFb+dsmFz7Ald9+Fo5srPAieDhmEd0lnmDc0HB7lFKYuBQ3JJx9gcdOl4n47mU2RFtLBW7EcLWXEnJuCuc+tKGoIYP30NFWVxr98I5s31JRWgKWfc2l/CDEqwyXVpMNkbKl298yEG6Dxzc5bR0VBSVlIxNI9TzEocjonJUoQl5PKuMqWjVzmroP+iW/0pzojV7kTa87tNopEAo0/ovRKC7wddxm5TMbMyicgPMj+kGLhCCY+bnQeuG0g0RCpNhMbOd11MXhxXPGw18r85W+WFiiwSmvege8nvV7T9Gg6FWK/bObKwWANfNJoc5/y/fFJkWRSbdwhpiCpMQLDaXGCFIbrRlo3j0UlCR3KP66vVDUI27irv/OsMqjh7W5p/WQyOHULHiV7es7aJFkQ6EXC1EzMHzQ1hFyXJC8zrHskv/SFzdMZ8mPDBR6/pYn8nkm/iXKEPgLe5pTCt9MI9O/fSxnlIwcOwAEfv9GS1VT44pSodL6U23YDgw8UWs2eRB1uhtFnFkYv432lmgcd6/uSjbSECX8N+gD72ywlmqtArOgYK/hzc0pV5eyZ8/YcJYDJ8bazAzqh+cA7BW2uSvvrpgILHhCQ4KgtdAYMBO07RsZvhWPP+YlLZdAZDNjW+wkT8zUr7RyvPnquaQNrsInvLzxj5XpiE3p2Okak/uRa/d+dDlr6AwLs0TtlA9uNLSq7DEoj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(6666004)(52116002)(2616005)(6506007)(4326008)(66946007)(8676002)(66476007)(41300700001)(86362001)(966005)(6512007)(66556008)(26005)(6486002)(316002)(38350700002)(1076003)(478600001)(38100700002)(2906002)(8936002)(186003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwluEDuAixv++T+VEufoPDpYzJ/j7ZvgfZD7OU/2J53EqAQzy/oPESpNt+qu?=
 =?us-ascii?Q?wsH8nA6Nm3HCQmzi+tuIZ2n/rYFST0C9zHIHKRScIi7VE4kNVS4rsPgPy3uo?=
 =?us-ascii?Q?B8xx2VpGnlrhxy33iqkateM2B4dr/hUJ32r3+ABUOTpFb38J6ZmzH1uDIIFc?=
 =?us-ascii?Q?VWc3Qyhkk9GU96Lgr2DOz6z+ZmeEIzRGuyeau2Z1vRroGHLxYdgkGWCeoqdb?=
 =?us-ascii?Q?Dd0KGTyvkb5Z7G71x1yaILgPupERfi/cis9dlXdEfLTz7ZpY7xOGS8bOi/ch?=
 =?us-ascii?Q?1vOsbwfxWPEKtgZwd0y594hpEs6niKP+DeYxeBpcLDsQje+DlvbLlVhdeyh6?=
 =?us-ascii?Q?Ogqcu2gGUJ6B2DmAC6b/IAf9xFccwShAFg3zoXMjL8TBaUXyPy/M4VfAWUWr?=
 =?us-ascii?Q?gnrpmjxUyWInVbO7bvLNqHOSR3+O5Jqm2T6Tpf6IwzpfTrb132oBJp5RPQps?=
 =?us-ascii?Q?83ouF9E/OLxY4TPSvkgh2K2bBcBcaOKVcayhasHudIuDR8EIFm0Du84DxCqJ?=
 =?us-ascii?Q?A+HFkRcb8NoFTPm3w/t1zOFoB7h8l/dNTkifkZ4hsvH/qyUDWzhHZd9jNwyu?=
 =?us-ascii?Q?b2yKm2VfI0SHn/kI/FfNdPqKpL6S/WX/f5195YQPADjfTO261mNkb0qFVOIC?=
 =?us-ascii?Q?5XYFPFIus5laKrEkVcfG2dYYl7dX9pH0ie7kyOOrqD7jez4XqlwWe7cN8Skl?=
 =?us-ascii?Q?NsNAUqVbCv7/ysEYJxoJwn6NFY+fYV1562U1GxJEqjS2I2mTru58vmATxAFn?=
 =?us-ascii?Q?LSSj73yCwR/fIeVdlRIvgTzbHAE+N1+upJx754nS6t4qaGS2GrNRoN31sMZM?=
 =?us-ascii?Q?w8H1wswrBB+YuLRCLEfnYXUZBNljNAfN+DHB8JmMlVZrOHnrDU2wrUyoMQg9?=
 =?us-ascii?Q?P4Qd4z08EnV8Wwi1Mpll8C3b1KgN4qD/0q4y5aPAfqHlVPpzjAvEGRHZ5dD8?=
 =?us-ascii?Q?ijWdzZ/leq+3oRAawK6R4UZVxcOi0skdOBxKQEc6qS+y4DO32gBrw1Kf3sV4?=
 =?us-ascii?Q?oi8tuxbOIYZdjN3qyLP2r+wRIu2A/C6kXQEYBOHUDapR1jNQsiD9O+t20xw2?=
 =?us-ascii?Q?8uuR8o98vrhHeddLuY8QFVAv8Ii03mhSeMvQYdJDESmKPM4lCxYM/DaZNXzI?=
 =?us-ascii?Q?Ye0iiVqLUPibZkbsxcELwGolDHkvxtbiczECqY6jspZmRBlnjkkyeDOwu6WD?=
 =?us-ascii?Q?M3VQ/yfaB2n9/TibxnTGVsBRavqCuvvmZFC39OFVSt1Zl1GpvviqcpZIXsiP?=
 =?us-ascii?Q?jwafrC70X+UMlCk/sxyPCzYK+ih5OErlFi52T3X9ws0+RskhkSFSB3DEdexS?=
 =?us-ascii?Q?n/oXs/Rspkjlt7w3XIcHQ2hSODBe/i7RI3BM/rbBZeWImzzs2I1ZkS1fDaIi?=
 =?us-ascii?Q?g+nu8bVLtfHWN2rLkr2p8wa1IlJjgyKeUOVRihVLu7PpIEiY/QGth0fgcvAt?=
 =?us-ascii?Q?rGDFj55KY6GLd9BUHBEQH+tVWbivTZHLrsUy+7H9mCM5ES1C6tD2kpkj+Kyt?=
 =?us-ascii?Q?GfvYKaNeVmWYRuqs7cu1gWPlGhs1ciAVOzkndkZCV7VOt/vwWtekWvAKOUm+?=
 =?us-ascii?Q?tCxANcdB2xC9s+eJLJYAWIoBa4hoVGiAexi5cT9/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0c9a13-fd35-4401-d57a-08da5e239ba9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 01:13:45.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //Ew3V9KvLf5OErt7mE8C8NNNnxHQzFESLe/7CblN/ls3zRFh6kLw3jWFl8OGJqyBgis470nJR0n4blqFrCkrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4365
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V7:
 Per comments from Arnaud Pouliquen:
   Typo fixes
   Added A-b tag

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
 include/linux/remoteproc.h               | 16 ++++++
 3 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.25.1

