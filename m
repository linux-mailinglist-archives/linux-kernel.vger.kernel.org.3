Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B050A378
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389834AbiDUO71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389907AbiDUO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:59:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9041433AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqYDRYy4yLA5pOE6muaqjdGIb+nzMQJFRLLesElc7oFhcPmcm0mch552Y2cWNMR/OcUueCtydtGRtOhHgYe2Za6nQunZxdQAAan+KGQUPwAn4ix7Fmbzz9zdcy8dHn0CTLuDAcDsYGyriXDvPqFLCACWsNks9nBaaBQcJAnqOdZEBhEpDdENcm4nJ/rRzOyDqR+RrKmcVvPtIFyUsWoGFad9bm8URFeXoQpsyfhHlBFknMcw7Q5Qer1U6KF4HbH0LuOejuZF4e4ZUFFfPN+BW1qZMd3USLOxYstPIK+XX2l9bfnLkaG80v/Lz1x2KbIOqpYgExJRpGnP9BUHHS26Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnsxugkmkyZGdRhPGfkJk/oZU7ZJ5yA6mDFRDR2Tpjc=;
 b=Oi4UOx8UCy59o2GEvkLfNa4GgQDYiNfImIpJGSyOvp8m0iGU52MG/KYNBZbW6jPF75GThmGpSF7GbKe0VLP3Z3YrFBdDBEPfmfAhuQABAFA2CkjfyDifqlpqJ32J5+C1+PQmI290/k63TT8M7KK70xObzhMTwrG5N4J9ErOR/aFiNw/N/HFC+RFYP+L8wlhFiMl/zlAUHmS9L6Gk3qU65HfX7VqDWqxh9e6qPQMbYtjsPIORGBgRt6OFX6yfZTdzYAAJr5MLYiL/Ih9bveJp1nGzpwijdSqrp3AeVRAo7N4l/pSnmHDAEz/FqahoCLH0HWfU9tuU3oj7ggQfDW/Hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnsxugkmkyZGdRhPGfkJk/oZU7ZJ5yA6mDFRDR2Tpjc=;
 b=mky74cyKDat+6oaeju+RvgBPLTkiWzRqxnqErVHjbm3aieIzPsaCxAJbiIzJ5/GIU4TJEO2hFXWyfzSaFQcSoDzg5bWi4Gxa+3SP1hqMQG0ruSmDi1v8RXBx/MJr3DQNF2vaOa30BcnPJVAQEyyer8K3lOlE+r2OF4H/4CQPTYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4308.apcprd06.prod.outlook.com (2603:1096:820:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 14:56:28 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:56:28 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH 2/2] arm64: Add complex scheduler level for arm64
Date:   Thu, 21 Apr 2022 07:55:58 -0700
Message-Id: <1650552960-60165-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
References: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d957549a-c692-408a-147f-08da23a71cf5
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4308:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB43089074CF8F86032B3DC10DBDF49@KL1PR0601MB4308.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BGc4b8V9WEQCIIuZsR4CWKN9HNBd6EneIznDpSEEKsVKE7T4YOsvSARIIkeCO1tFxI+JXvllZnzB0FdyNnAKUVS1UZj8Wti8moFkaY83JvmTbiaOCWKLUDe3IXOh3ah/YZk11U08FguLgfyuInJXaODAEZ+Q31E4x3SD8lS4rfZ2j2TyS9KnBiLnrf7MJqXHhhZfdW9RtjbvOGn8597qCMNEkiwkej3GORVR2w7ef7lvyuTQ5csNLjrrdi9m0SThhwl96MnZebsLEmqLM+TBVvXKaec02ghoLN5K0B5rsPd2Cm3L97pLYKC1KZ5eHc7Tw/RmkwpTwmY7f+J6BkAii87kvySCQsR5tVZw3Nnsv4YPt2r4YlNUWrDqJIL5gPOFHFMy76cKIdITYKvQkVDqqAKz66WyJUFvsoVTpua1M07b0NZk141kO1wIqA4D8dChBGeYoy21ZdcxA8gXSLXxHStYYRlBXqrqVGnazNUNgt8S6PjYTiBGgbdWTV+8oPreaVImPN32Wilk8Px72EJE2vOsCUJhlsg8bkENBfUzF8+SpYF/bfeWLli9jdejYORcrt3Vf+ab2zebe2v23OLqXUrGPfzArlXxyq/qwwZ+VCXXLgWo4KrWVPDsc88s/rZBZIj5Re74yE8MsUPmgUHhW9H+HOL6dv5yuIrIsR6G0rrIQFDwiujFWmVzKVXrHbA7jaEIxkfm4b7dJT7W3emlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(8936002)(508600001)(26005)(86362001)(316002)(110136005)(52116002)(107886003)(4326008)(186003)(66556008)(36756003)(83380400001)(6506007)(66946007)(6512007)(2906002)(5660300002)(66476007)(2616005)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBocm9HQ3pYWFNOWjlybG5odThaQ0xMNVlwQWlacnRNSkR1UDdiVnByNk9F?=
 =?utf-8?B?L29rbnNCMnd0MmtlUjhIbGlFVzM0UlBORHltYml5SkRXMTA5OGFiNnRPc1Vr?=
 =?utf-8?B?ZDRKKzlqWVJGQ0FBSUFBM2tXd05LUHlHQUR3OVZiTElOeTcyaDZ2M0p4OExY?=
 =?utf-8?B?cG5CUkZzNE1CTms4NS9aSFNVRmlNUVR6bHVPSktZMER1VVZibnBvcjZqVjlU?=
 =?utf-8?B?eXJnUWhIaUZzODlvWXc4WkdpY0Fzbjd6cU9aMi83dTdBZ0tUOEE3aVREc1Zn?=
 =?utf-8?B?cVkwRUNGUVFQQjcwdTZKMW1weEdmeUFHQzBMcW5ZbnRJdGVmTUlzWmZ0cWFY?=
 =?utf-8?B?THhhM0JUbDhUNDFkM0tnUG1vZSt4akJ0a1F3WHZ0eWRhUzRYNCswVlJhd1Mx?=
 =?utf-8?B?WGozVlJiVThoODg5MktPNmRrSEZ5MCtIZ3MwSzg5ajM4U2xHOHhtRmV1c3ZP?=
 =?utf-8?B?SGpVaHp1SysvNktWd3JUVWtSMUxnUGNSMmFUbFBaUUNKYmRSbUIrTkVsRTlu?=
 =?utf-8?B?U1VyU2VDbTh2RVkyQ3EyUUNib2MxQ2RCN0h0b2plNjdnbjVMb1YvbGpZV3Zq?=
 =?utf-8?B?OU9GSUtSTmRMVU00TXhsL0R5K1ppajlkTGxLdjl3c2JDdktlUmRRUWVBaGZi?=
 =?utf-8?B?cDNRV2UwcjNCbXI2cW5ROENYTGlxQ3BKcEh2OEptdENEd2NxTFRtcFdsVkhM?=
 =?utf-8?B?U1laNVg2RXpkODloaFhUUGdPLy9vUlRhT1Ayb2ZveXRXdS9IU1FYSitQckZa?=
 =?utf-8?B?cXhLTkxUWFVKRnhINXFkR3A4U0ttZEg3c3ZnR2R0ZUFOTy9YUGRjU05YeGVh?=
 =?utf-8?B?cEIxc3MrRUFpbkxoSlZPbDNMQm5DNEFEazdEY2IrYVByL0hFWUo1Ym8xVEFv?=
 =?utf-8?B?Qnl6djNwekp1a09vcXcvS0FXN0lMRTJMa2RNM2ltMFNMZjY0Z0RrS1JMVW9U?=
 =?utf-8?B?TjF6emY4UmRDRzFSY1p3WGt5eGZGS1hnNk11cGNVWFozZnJvMU55QzRCWHpR?=
 =?utf-8?B?eTJvN0tyMmhCQ0xRa1ZOWU1wYmpWY0FSbEFlZFdSUHhBVmxBUzVPb3BGYkxt?=
 =?utf-8?B?dEJYVEJ4My8yeWU0Wjl5Zjg5emxSRmVGMVppcnFOR3Z0b25zUDJ4OGgxN2c5?=
 =?utf-8?B?UEY1b2RBSjNqbVBkY0FveE5OMGdMS3lReDQxdzJvbklibnpQZ1VLN0VwS0JR?=
 =?utf-8?B?V1BsZlVrSVo5UGJCMXJLNUxxYStsS1doUkExN21aQXJrUloxcFBIOWxsckta?=
 =?utf-8?B?bjlscWo0cUpRcTVzdnZXaEdLeXhscG9ta05xc0FvUVo4eTZnU2FnYk1JTlBZ?=
 =?utf-8?B?ZjlIaXVFdDBrZ0FIV3M1R0VjRDhpQ1p5WnZGUmlZMVhZWXl0TEFGL08xSWhY?=
 =?utf-8?B?TlFnNkpzcVUyUGpzb0NSZW9vSjlIVWdmTjd2c1RJazhqdU9YNXQyRU0relFi?=
 =?utf-8?B?ZDJ2aVN3Q2N5R0FXczdWek1yM0VNMlBuNVp4K0kvVDEzZTRaY21tRVEzWW9P?=
 =?utf-8?B?Nm9FaFRYVFhIYUN1WDY2R2crcHEvb29PVFc1MUUzVWd1WHBrb3RmeXo4OFBJ?=
 =?utf-8?B?OE1RcG4zeGMrcitpZkFyS0J0MmoyOVdXMkpWMDZFR2VzVlJQNFFvZ01xQWlX?=
 =?utf-8?B?WlZEY3BoVDY1NXh1aUtldmZEVFJUQTk2cUZoeTdvYXgrT3pwLzNCUzJpV3Yx?=
 =?utf-8?B?THJnMXAzVUQ0MWs4VERLZ2YxbUlrMGNyd1VjcmVEb3BudWFCclhGN0twazVN?=
 =?utf-8?B?M2NOL1hseFZnUEZNZ0hvRDVwM21KbWJrTDJ0ekxTMG9BMHhKbmgvSXpkVHRu?=
 =?utf-8?B?Y05MM2pEVm10QWNVMnNlZkc2Z1FZSDhDdDE4TkRDRTVqRXZaZmwwOE9TMFhT?=
 =?utf-8?B?M3BuMjRsS0ZONmN5VE91WmZnWTN3TXdqWVJYMVMvVjdacVFzd2J1SFJnRGo5?=
 =?utf-8?B?T0lLSURlVVkvR0lORXczUFByd1U0SXQ0aXdSSmRVWjRRRytJN3E1azZaYVRJ?=
 =?utf-8?B?UFBBdVhEWktXbHY0QWNxY21za2dXOFhpQmtsRHVIeTdFUFVGZ3c5Q2hhMXBP?=
 =?utf-8?B?OEdrb0h2WEJOa2w2MEM2YjZLMXh2akkvUE9VOUl6UXQzY3F0RFRxNUhqVTNT?=
 =?utf-8?B?Q1pGdFBIM1orYnNwVzYrbys1ekxqaG9OVldGeEx2WFZQT1FZcGJoOVBsRDVq?=
 =?utf-8?B?Tys2b1YzWUVKL3BKT1R2djAwS1FacWJsZkF0ejFWcGFBREwyMzVmbU1BMmpC?=
 =?utf-8?B?bHUzbUczNllkU2hFU29NWGxhbnNLeFpSR0hIdElOZWptWDBKam9rY0ZzaDEy?=
 =?utf-8?B?V2FySE16ZDhFalI2NzZITk8vYVA4R2UwU0l4cXd1ajZpakQ4eGMwUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d957549a-c692-408a-147f-08da23a71cf5
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:56:28.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szN83Tk6aXkC6jQTzaSLb8AETQsLG4y/UsK17GqeHR+TTdA++g7FaR+B4i4wGSsrcgP8QAHg44E/y85uBuAzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4308
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The DSU-110 DynamIQ™ cluster supports blocks that are called complexes
which contain up to two cores of the same type and some shared logic.
Sharing some logic between the cores can make a complex area efficient.

This patch adds complex level for complexs and automatically enables
the load balance among complexs. It will directly benefit a lot of
workload which loves more resources such as memory bandwidth, caches.

Testing has been done in qcom sm8450 with Stream benchmark:
8threads stream (2 little cores * 2(complex) + 3 middle cores + 1 big core)
                stream                 stream
                w/o patch              w/ patch
MB/sec copy     37579.2 (   0.00%)    39127.3 (   4.12%)
MB/sec scale    38261.1 (   0.00%)    39195.4 (   2.44%)
MB/sec add      39497.0 (   0.00%)    41101.5 (   4.06%)
MB/sec triad    39885.6 (   0.00%)    40772.7 (   2.22%)

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/Kconfig      | 13 +++++++++++
 arch/arm64/kernel/smp.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index edbe035cb0e3..4063de8c6153 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1207,6 +1207,19 @@ config SCHED_CLUSTER
 	  by sharing mid-level caches, last-level cache tags or internal
 	  busses.
 
+config SCHED_COMPLEX
+	bool "Complex scheduler support"
+	help
+	  DSU supports blocks that are called complexes which contain up to
+	  two cores of the same type and some shared logic. Sharing some logic
+	  between the cores can make a complex area efficient.
+
+	  Complex also can be considered as a shared cache group smaller
+	  than cluster.
+
+	  Complex scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have complexs of CPUs.
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	help
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b46041f2b97..526765112146 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/topology.h>
 #include <linux/interrupt.h>
 #include <linux/cache.h>
 #include <linux/profile.h>
@@ -57,6 +58,10 @@
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
+#ifdef SCHED_COMPLEX
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_t, cpu_complex_map);
+#endif
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -715,6 +720,47 @@ void __init smp_init_cpus(void)
 	}
 }
 
+#ifdef SCHED_COMPLEX
+static int arm64_complex_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES;
+}
+
+const struct cpumask *arm64_complex_mask(int cpu)
+{
+	const struct cpumask *core_mask = cpu_cpu_mask(cpu);
+
+	/* Find the smaller shared cache level than clustergroup and coregroup*/
+#ifdef CONFIG_SCHED_MC
+	core_mask = cpu_coregroup_mask(cpu);
+#endif
+#ifdef CONFIG_SCHED_CLUSTER
+	core_mask = cpu_clustergroup_mask(cpu);
+#endif
+
+	find_max_sub_sc(core_mask, cpu, &per_cpu(cpu_complex_map, cpu));
+
+	return &per_cpu(cpu_complex_map, cpu);
+}
+#endif
+
+static struct sched_domain_topology_level arm64_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_COMPLEX
+	{ arm64_complex_mask, arm64_complex_flags, SD_INIT_NAME(CPL) },
+#endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	const struct cpu_operations *ops;
@@ -723,9 +769,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	unsigned int this_cpu;
 
 	init_cpu_topology();
-
 	this_cpu = smp_processor_id();
 	store_cpu_topology(this_cpu);
+	set_sched_topology(arm64_topology);
 	numa_store_cpu_info(this_cpu);
 	numa_add_cpu(this_cpu);
 
-- 
2.27.0.windows.1

