Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6500952DD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiESSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiESSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA265C65C;
        Thu, 19 May 2022 11:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrxlPbS/AEkLNqd0WmP34sHwScwbyQ9qHkNH8YUSICRlP8hlsDG1A5HjzxA+hZ96dXmkx0CDmH+fgrk1EVFCwMD6XKLY10lhKGqWQDdJHavfcc3W0wyjEJD7GzpkTOwX7v68ydw/pOWVMHTWaiZnTsPhoGpvNN0mXI2M3Jr0UBJaUIps7hW7wKtYmhiElAt8m7SwQeX6FcYFjonoijwZzVaYlKSoixDDkYB+3ydCnKNv1YQfaUErEXgFITW4SbHRqwhwLQikv99TuH+XxEUnvt+go6LdvwwWN16rJG5OPA2U6Co05VyiOTROwrlRLQ+qB1628cv55/XtAg7FyQOPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks1sE8wPnLTD3M708KnjA6H1k2KjBpuBiW7gF5Xl94c=;
 b=bJ2zlO8HwoMaig+iqdDgT+4Set1burGgZcLDBInSKi6A+FjwmwlbBosnIAF7I4NGpYeN83lfvWJVpE88KIWS+UoY4uDbMlxbTkXV0LKmCEZEhKgpRZgik79Zlzp2JqKSxvXtjNcmVzyBIi3SKQmiGgKjjYx8V47eaAvAJ4OR60idQWBJUNyoCPfU47TSlCKJMi/p5nTmsOjtZLr3/vDGbK1jWs9wy63VWMCT6rRshVNf4gVoFJL4uWfhEom6lk6WyjlcJtt+fK/B93NbRj6TkyMoIB6MLhSC7AaVMCrDPbXYr0QvltE5VF+CioubRpyWjCtAif+6HEvN7Pau2HHiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks1sE8wPnLTD3M708KnjA6H1k2KjBpuBiW7gF5Xl94c=;
 b=xbnjeczWzWBHUw/vmMrYj6+UZFE/PE6d48CXmR4jlmfzXXNEg4vAV/eVvT9t+yWjCy+FCEYX0ehtzBOG79OfQQfxtITgb6y+qRn23sa4dV/OnS6yLpwKWJL/TcAJUWYvm7a/kzfjVz5uKNRW0GbRD+by+WN5M6lz+MJ1HyMPBMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AM5PR0301MB2546.eurprd03.prod.outlook.com (2603:10a6:203:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 18:51:43 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::b513:6272:f3c5:c709%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 18:51:43 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] MIPS: Support I6500 multi-cluster configuration
Date:   Thu, 19 May 2022 20:51:13 +0200
Message-Id: <20220519185125.11686-1-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0016.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::26) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3230f5f-76ef-41b5-2dc2-08da39c89db8
X-MS-TrafficTypeDiagnostic: AM5PR0301MB2546:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0301MB2546C746CF967579CC9E6297EFD09@AM5PR0301MB2546.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvKqFhA0AfenDsY+AvtKumuM8qK1AtB67tRy05gIwVq2G1pHOa0U5SjMnsHGSoAL0C5M8pEWzTuHZVeDq+ZTw+bKGhy5Fy0fqaR57tTaC7c6hxqxTIS8DqQoBSFRVuILVIQDwIJiatdHg+WEnCnEBY5hhjGPcIDQi0WhVHMhkIOpGeBkjdvpiS9ktInkesmzJogqLgWJiPPj8knm47u7PfQ5VO6Zr4s+pmikHEebkCdC+BpR7026QZD57s/7gHPOIpeEP6sB3wsuuvd0ARmrwDwfm4AAZGjRgBdl8FRHnaXZ7qa8Ch7s70YwW6LANrDl2We1y0Bh1UxP0InTf1oN0rUbGid7uHb5L7IbI56M3SCgbRtq1HZASeMKTbXOuRDw/Ss2uRtgllUDtoZXnFJNrbIurxLYSzr5z91I54a9ZhmuyISbrblI6iwTXv//pXdayoqaLMw/5+3yuz8zPOLNqXr9MmQwYG0aGVeXPr7sg6f+T9HIJa6oOaGDIzl70D04G5NwDonlb/18T8XQl+jQL3bjV9cglDS1DXAcdp9U0XQNTcvNReAIgnvy++nYoFe4ocpKXGzaN6KdDVpPu0y07sILQ/1Rr87OyGPmCRz2AcNDFzox4Ko1kTpJkV1fCMkkIoa5M7Tpep00charcjRJhP60AZA7n0xC5oZui+CMtyD+M39wjmjmtt5u1MDE8al4NeAMnX9O7850mR2kexBWFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(366004)(39840400004)(396003)(136003)(5660300002)(66476007)(66556008)(38100700002)(8676002)(38350700002)(4326008)(8936002)(66946007)(83380400001)(6512007)(26005)(86362001)(36756003)(52116002)(316002)(6666004)(41300700001)(2906002)(6916009)(54906003)(6506007)(6486002)(1076003)(2616005)(186003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?niiyVHskiiKwFvU5xfCV1jS9RMC0qjt+1K55vwSbS24FtJkSZiuOidxKd4DL?=
 =?us-ascii?Q?pNFbEufIiLhpU4A3OSsQpc3ldqxkaifyt06nc6YsZ5Yf80k/Tzpv1Pch/JNQ?=
 =?us-ascii?Q?QCQBS2edednMCXJf4gyfTUR9l50bdIho3NZoU26q1+CP+P/L74zQHUk3VJee?=
 =?us-ascii?Q?+1pBpRQGtrsu7yDIouaeT5n3Vjv/jnOSF3RHtkLHqx0XFidIO08ZxrZ/DPZ5?=
 =?us-ascii?Q?lu0VBXPoQ88Q8yvSo/Vh0Wu60osMy08ALkdzCkCgW/UA6eIk29G7bGg7fLki?=
 =?us-ascii?Q?V+Ci5+bOG1/4AsvLYsVhthINfegEaUAgfQRhn5b5MIk2UVKcmWK8Q4811Y5V?=
 =?us-ascii?Q?9ahP9rrkDXQj/6F3189MUNnX9bBCeyD/m8oQldEqcj4H37nrE1xD8CdDZ8rx?=
 =?us-ascii?Q?uUUx8EWRlcbxTu2X1e0TQq7jWZ1uwIaSYXdKPyFiTArIhRgqGlVMhkJ8KE7Y?=
 =?us-ascii?Q?OgOCFSCCP7VraBKJ3IkC+XAx0IdbTgeExmqiI+S6NdhwCySmXcU652aROoN8?=
 =?us-ascii?Q?JFmE8WXoZ0CpHZmk+h1tkj5FXzE9UlBhUcDw0zcPJVdBfSSXnUFfPIrAFoij?=
 =?us-ascii?Q?zybIbjviILNtjzkfjmCBRFMkMFwejwogXL3ROzttU/NNgRW+cK/xXXfD8rWU?=
 =?us-ascii?Q?b0clueaDY3bW8TlqM8Q9qnxnQupjVefWfvp8jZquthA+WNLe/j0hwWls4+Q6?=
 =?us-ascii?Q?Y3oKKWykOkILK/jAEHesj9/jmRotoum9wWuK0eCjyatWzRxVdSNgIDRSPcAY?=
 =?us-ascii?Q?Rtr9vU/NKgiKMZU31g/l7aRy0J2D0c1CkCZ9Tk10YBuVJ5B4W+aPoDG79KsE?=
 =?us-ascii?Q?1iPXlk14ycYH3gUzeOVjKvuzqCpqTAzlfltMcqX6Lx3zMz9FOE1pClBbm8O5?=
 =?us-ascii?Q?Ap9DnUfvPqtGSa7NUiT2wu4pxlx94KSNDqEmoyHmU6YzavWwZNliGkhK76Kg?=
 =?us-ascii?Q?b4OfTuOL3UNTTAFj8csLweWo5e7JXY6PAaDXFxdA1PoZmQigurXutrDNOaIV?=
 =?us-ascii?Q?mOzYmbp1eCxJgtzhYkiz1D1Hxr5y884219v6aGpmEF64/emFHl2FjjM6ENzS?=
 =?us-ascii?Q?LwLpygciew8kusdDMYRiWshz51CgjrFCRnVKDKKud/RniUYDNaAywJMw5AE8?=
 =?us-ascii?Q?m2+KKhRuR04W5ehOatqsbSZg6eLklPc/5ywRuukFKvLTP4ZWJyhJZKdImshR?=
 =?us-ascii?Q?8HUgtSX7ZTOJVGoV2cRgaSH/AeTjpiGIaMqvM2VbsWUrDsQZWoGMpWJhmImG?=
 =?us-ascii?Q?+BUUnRL1ZqD/ndoO5q+qoTD9+VCz53FQvDMYJsummL3K6Wp5FNIptQwvuWqV?=
 =?us-ascii?Q?s4CILw3GSZ55IDdeZz/IE3aJ2iQkyoM0QqsA+OM4gZMJ7buTfm+WyD9OJspr?=
 =?us-ascii?Q?sM3Cq9DN4f/XW2P7l3qHAR5dyClqsRH7AGnCT0NdMe5nioag9ZmVHwjNwssP?=
 =?us-ascii?Q?1aEmplky6wMC6kObzcW2dS8Osa3FLgYq+BDkpSsH0dpQqM7xhYJrZ4Eu1VZi?=
 =?us-ascii?Q?UMs2uyEqt0R9No/QgcCIswS+BNc01pmtBFd0OuZ9PyTODhVTFuQmP586b3nV?=
 =?us-ascii?Q?yad3nvofnPrNxdoSjHojHh4CIu97+lntjlb0FPCJRN3ld7CpR2l/EXX3CnvQ?=
 =?us-ascii?Q?7GfiXOVp7MELsiK46uLjit8j0DuGq2ovR+thzTxrQ8cMCzkZXpVmRh5Zx+eM?=
 =?us-ascii?Q?ItKazKhgAViuq/fIZZ3+i9rWhIjlKCxOsAjUczBftagDZxi+4u0jREGQyVuW?=
 =?us-ascii?Q?zSDQNNgYe3YjFYd+MCB07ShkjSa8C2A=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3230f5f-76ef-41b5-2dc2-08da39c89db8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:43.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3x8ywcmKtAEBJyWARV7xK/0pSwJkpMXd4KQ8Eo4LBFTg9E+SSO2lqBPE0F+2np7X5I8ob0C2U+eTHBafYWgP3xOTA5qLx56S0JtjpX4l0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from Paul Burton MIPS repo with minor changes. Tested with
64r6el_defconfig on Boston board in 2 cluster/2 VPU and 1 cluster/4 VPU
configurations.

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

