Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D8533C50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiEYMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiEYMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:10:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B84338B3;
        Wed, 25 May 2022 05:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug46c3hhUFq4yL/6EASsBu9+IWPU+DENx/z9GLImXn05ehiVrWYWtTe6BPXDHmTVhrpH48LDCYPnXYS+ISQRzNVU4ILpMUm3XwYTOO0Ge1iJrvtxWFY45Aro/fBxo8D5j0taXGg4q2XNrv31V2jHlfLCH+YXyXH2hXLR4Z5kRlq7WwSdAG0Aks/se3yy1J9kSx80sjXhf2oOwWkMrnGnFSUc69FHlLuu56cdziUR2j00drLjB9lt7FXdYeFm84suJw2AwtbG1R5OxrX8ui+dRvLmtJvgQAAy3DKEaQEox6fuRKgW6P60S6NVhu9L/bPqt7LumU8d1oMMtWabMQDe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeP4Tijz+ZcdoJ7o2o2Udote6cXdXj7xoiNdWjCLQLI=;
 b=iUfPodhaQESQPC1xVV9pcshkAiwpVHBBsb5NSMFVfOqVuCgMSMPYrO34uUFFdLzr2bz0Mq+D4gO7XIc1W4VYSIpznJ5aQNsuto0yUPUYMprCtfEsZ9I9RFDEunr2oZq4pFYsSiwU/4vOuvfKH1KqycowRN8flZN24U8HAcsKpZ02g2pkLWhCe8wzHwPf9uwGqxxN46l9DK9ZqKZ8kg3Nme05P4aGu9KUiHMpJcagC1wzAkhLFF+wO5JVO6m4iE3J2SwRF24rrYnLMrShmsHAXtmtsdrZWmZCqtZDwpnCrdMyzdjNjB2is8h1nOk2h3GvrMcU0MBvp94XjioifKFXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeP4Tijz+ZcdoJ7o2o2Udote6cXdXj7xoiNdWjCLQLI=;
 b=DlcxtVaqZ2OG3+1zBr5lUIpSdxcWxpxcAe2GXtiH2neJzCXJi+Gg5JcoA7CkaM6OHz4XtMDWeOmkwPLoI+LqX+7FPemNjgQ8JXIy8LIOzvu+MmofN0IzmevzOtw74e/2s6JRWla2Hy5v9U4fsdVjl1Ql/ZFb9qPOPCcGbTbtxgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:49 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:49 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v2 00/12] MIPS: Support I6500 multi-cluster configuration
Date:   Wed, 25 May 2022 14:10:18 +0200
Message-Id: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18aa45e5-ddcc-4256-e53f-08da3e479b27
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7859CFD6855E929C85B057C9EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2xDe9RnzQAHGSpTtigZQWgkBlfzR1iWWLIJyzDUw1fy4vp0j6pmcfY/ri+5n8FwFfeETOkdL7ZwsOulV0tusqzZrAWSSjsAyN72vTOZw7NQSle9uPKDOnlRbyx/pdA5TErLr3gF30QYt4GvpooBA1X0/8fN5QzL3F9oKc8DTL1U8aa6EcLHnR54e0vvBZ1tIZmwYHNtu8J6YGKEevi9pGtDHzn2+rQyDT9UPS69PBmkDb+VIJ2V8R14Of7fpyB88lnLRQTeBFaiCMmWmMHCLht08VKq8Ay37V9OnwgWlyGuYFboldWnIb3XKD6jaqaVnvNa66v/yHx2x3jlgy87+rYDeLYoa/FMDKe+yyB31PK83LwP3T+aeX40KXnSJvzUFSyQgz9xU8u6bPUANBx801+IzZhxIzhoJCAS/yxn77shMeBI/E7FOkcY079Z+VpWKcRYhqrtGW2Wsz77NLKppD2zMwm8Q7DH35i9l7uG1RbStQ4dcXR5RgNSfdx37Y88qtL5QMsvaQhY3BF/A3uRD22K4GNrEfdbuB3P3ziIIt4phXoyCUH726xGYJZrTW31869Z7vUiY+txcTlNV4LxqzXPJS3cNYLkA9vmUE9FLXz7Z8mqZ08HCbxgLE/NAJrOMukYkZF51ZRdIoRWhmjqPGY2hxSSTG1NMK4oKH1CmQBFLrmSXREkMUFX5T+LNisjXoLlziwKmSjdt8vtkpn1HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(39830400003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LAItOg1PI7OBo0MgwFS933IoxmVQtEGA5r3UOPj/TN0X534FWgC+LnbAL06?=
 =?us-ascii?Q?PbZqUEZowpvtLDWmMe/lkCxHGzFVlyhLhvkzuE1H7yHMT2JYbqpRG90BRU2W?=
 =?us-ascii?Q?8M912SBgb3W8fveutDqTnrS8l5nP6+V7xJ+jkW7DkJAqXZBnGgESwvdXIGuM?=
 =?us-ascii?Q?ajk67wVcgLKoxx6udoiWBR9J9JD8vsTn0dWUC8BbKZjI7FBtQw7c/NFNvOhC?=
 =?us-ascii?Q?NO7JVJx4vnpmJJ4SSalE2Gra1ZH3yoGkWydgmMAIlqbNgWCRjJrAIsKwppDA?=
 =?us-ascii?Q?+tK0K8aYe0ClEHCBILAzy628EPtqFtPYyWFWTQDV67aYCqKEhxxL0jaGN8oH?=
 =?us-ascii?Q?qkM/5OSLgnoIvgzsJ6ETq5F1JqolEa9+9LkCTO0kfsHurEGuVNvu74R7dx+9?=
 =?us-ascii?Q?OpSczb6GjYF/tWDWCy98M3EzJxcoYkQizfsicdGSjao9itNY1RXJ5oqJAnpe?=
 =?us-ascii?Q?EczFUHPO6kvYQC/5GXLilvLSiASboDJ2BtMB/y4/TGX6RpCRCwa54n5DR8Yp?=
 =?us-ascii?Q?RgseJtIwxLznaEhUK0TB4oWXvMJhz9IiJNsRVvQkRdHf5g7EJtz9qQc3hBQU?=
 =?us-ascii?Q?yoXSv2WQ/IodnxARKfPfZNlqMVTjpIwVI/Uff9tQClvcJd1l0uYGttdSHsWr?=
 =?us-ascii?Q?U8S0qoUFy0e22I5OR1uxfPkz6lAzjJMJTDSDPrBaiDacYly2UR2UryTqzkZz?=
 =?us-ascii?Q?K9w7N60ZcG2PBtpazCOxAZNjpphcyUelTrH/sgNVUvrlxBr2tQmhrC/YSGiN?=
 =?us-ascii?Q?8FpWhY8XtFhzKDygGbT3LX5hMSWw4Hqo9oEtq28HjHa1jOoQa1U3zueiBzva?=
 =?us-ascii?Q?3d291pvWo849hdWFCBPjfH95J5e/7P1QhNw3sW8B5j39v4tMF7/CPK6WeaFp?=
 =?us-ascii?Q?eFMPR4ZBT7gtppRyO1vfRkXu8XjsIrsa+6D4q3c+M/CaJEoLCMvXZrcRnZvB?=
 =?us-ascii?Q?u9YHon7mJxs6znevNAJgJNDjXlo2zhx0Uzj6/x8Ian1gNkQFfZj8AvWH3Ker?=
 =?us-ascii?Q?AJOh0eFmc/rIKTBlLE1W6Fa7v2iVse29V+geAmBbCW8ta0TiKPpkeW9dDnmf?=
 =?us-ascii?Q?5/LA6gf4vVrB9HQa2yyL9voP7bCHuNN89JyKQEAQ/mwzvLmjY1uLNDFrbn9s?=
 =?us-ascii?Q?x31PglDrBOl3P9FQndTWQa78sxeHueg/uTKZ6uXC6cPCukkSyZhIDAfoeHLQ?=
 =?us-ascii?Q?aTcU2ZwEn3qtzat8Ig2LY5Q3+MraUoarTluEQbZknP+mkS7jztUWuAQ41NNW?=
 =?us-ascii?Q?pyhFrLDtI5+dQn5LyUaj8/DyK7j5r8jHAoyuBIvVbSLoaewbsNVAHK1c1gua?=
 =?us-ascii?Q?pTXW3YKVc0gQAaCHHPxnLw+g7envq8uiZ3nHXODCJZ772yS4T/Cl4i6VZUBW?=
 =?us-ascii?Q?mUn8aYrJCV5RGsFA2glyv03Gn1p4q8T28GyTFbGlB0LYf9BEeZVmw8lpVcgk?=
 =?us-ascii?Q?nBY8BZNOY0CAsZ9i+eIOBaZwhtElAAUqusY0BPAJpAjI80MJmuUVRnxmav3Y?=
 =?us-ascii?Q?Wh0hBrVxWNrsvASBvG2HSSZqHORPMfaU1SXvZY0iEE1Q0SGCoh8FS6rt8BHW?=
 =?us-ascii?Q?3qRZsyp3g04OEG++k0XSdENus9ijdcaTdD+H0c9/JxTRaJPzbOlFpqvQnWb6?=
 =?us-ascii?Q?IAJueZJUiuCTywk7b0X9U7tyo5GQRW4udVq9DqjSAXWwEQSmHu5t4AX7qqNo?=
 =?us-ascii?Q?vcrSDlf6OlGCz1bP+i4BcqpGe4wi0SVXfXjG9LDp79UmbwnnOHE6wXIHOesD?=
 =?us-ascii?Q?qZMCGNmKLr5EMM4ZhBaAXT8epEigtGs=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aa45e5-ddcc-4256-e53f-08da3e479b27
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:49.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjnnowf2W/9mQuYIQIEvuKzLY4+miK3nCGGh5nu5ol54SSElhp3tTp8AbDCaWBwp4Afvuj4HTzs66Z+nv7MFq3FXY/pigJjDv6K849wY7Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from Paul Burton MIPS repo with minor changes from Chao-ying Fu.
Tested with 64r6el_defconfig on Boston board in 2 cluster/2 VPU and
1 cluster/4 VPU configurations.


v2:
 Apply correct Signed-off-by to avoid confusion.
 

Chao-ying Fu (1):
  irqchip: mips-gic: Setup defaults in each cluster

Paul Burton (11):
  MIPS: CPS: Add a couple of multi-cluster utility functions
  MIPS: GIC: Generate redirect block accessors
  irqchip: mips-gic: Introduce gic_with_each_online_cpu()
  irqchip: mips-gic: Support multi-cluster in gic_with_each_online_cpu()
  irqchip: mips-gic: Multi-cluster support
  clocksource: mips-gic-timer: Always use cluster 0 counter as clocksource
  clocksource: mips-gic-timer: Enable counter when CPUs start
  MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
  MIPS: CPS: Introduce struct cluster_boot_config
  MIPS: Report cluster in /proc/cpuinfo
  MIPS: CPS: Boot CPUs in secondary clusters

 arch/mips/include/asm/mips-cm.h      |  18 ++
 arch/mips/include/asm/mips-cps.h     |  38 ++++
 arch/mips/include/asm/mips-gic.h     |  50 +++--
 arch/mips/include/asm/smp-cps.h      |   7 +-
 arch/mips/kernel/asm-offsets.c       |   3 +
 arch/mips/kernel/cps-vec.S           |  19 +-
 arch/mips/kernel/mips-cm.c           |  41 +++-
 arch/mips/kernel/pm-cps.c            |  35 ++--
 arch/mips/kernel/proc.c              |   3 +
 arch/mips/kernel/smp-cps.c           | 297 ++++++++++++++++++++++-----
 drivers/clocksource/mips-gic-timer.c |  45 +++-
 drivers/irqchip/Kconfig              |   1 +
 drivers/irqchip/irq-mips-gic.c       | 263 +++++++++++++++++++++---
 13 files changed, 692 insertions(+), 128 deletions(-)

-- 
2.17.1

