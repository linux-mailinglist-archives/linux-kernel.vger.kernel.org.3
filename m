Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7F50B690
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447208AbiDVLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447196AbiDVLy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:54:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86105641F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqsCaHp2OBWCdcwMjkh09TsWeyk37B+vmDf38XF+z8kWHUeX4w2ZA8FWkk/0FTRixIT6IuBNZNDLHy3lOlLMiy+4/o60KvamyCnQO04CSIVE0BqtTqsPJr6ZTEG2GqyGXR30fK9rqmthKJmTQ0SzEuiGGc0moHd7yazifWwJrv8JnuQ+AOGblUQfe8nC60UeV1bI2cHj2Msaea7ylb0L1sStmFrQxYOgNsqXPuhbzGnrhVbnhd+35QdL2Plt8qxeb05TrX12JO0QPFgK82QOzJrXRU0wG6migniz/PQxRYdKMU/jZMdH3z1eqClEeDTM0f6PLwAvP/Hqg4l9xQkrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6QS0U4jgsSOMikwWUACcBgnhQDtLsNbVyxmKwhbhQ4=;
 b=A2PUrCBb/k5Nkj5YpK8hJ8CGasl7Ea70CPfBqpA6iBRyxfucuN3s56YHC0r/qC3tfAv8LoRjjV3M0YQM7v30ef1ggKxWvSV3/O0UDqYYbPi7Z+rhlkNPFus1l3DFifsrWN8CAgAn/WgF67DGs2Yk3I5x1AWKLn6wxF9/UKcoFo2iHaHkomhbK7om3MtKvSBkv6BQjFkltqgsuw8cl4ufYBmncyPS1XcH0Hyv4oSeE4i43Xh4cxkvqP0CtTb5Y6kXEp/E7xP8LwfuWXA45C9h0bAlGUSXjbfCG+lDFOn6QfnE7FKNMdi9kuFoLMSmydXMtoiI2VkkeLlXoj7OaAn1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6QS0U4jgsSOMikwWUACcBgnhQDtLsNbVyxmKwhbhQ4=;
 b=i0IcPEyu5IJoD43HGhmHiINjLtxAK45ZHLXKYNKYuLnR9JZ5np/tTLjfFwwgYdXQgvIMnb/3UO/9uwi9w+OUZxz4UgwnjzAu/VsHu/5yRWBCYGkepD/FCXCLgoHh6++31RwNMYJBYD6R7Q14S3q5QZaU47iLMf0bQ9d42ZkGabA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB3726.apcprd06.prod.outlook.com (2603:1096:4:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 11:52:03 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 11:52:03 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2 2/2] arm64: Add complex scheduler level for arm64
Date:   Fri, 22 Apr 2022 04:51:26 -0700
Message-Id: <1650628289-67716-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d699879-2e87-4249-7fb8-08da24568446
X-MS-TrafficTypeDiagnostic: SG2PR06MB3726:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3726BBA81A1D233F6AA1B5E8BDF79@SG2PR06MB3726.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlGqHblR3PSU9UE0GsY0Q2Dld9Cm4ljqBCUX31tunixqwqOJpgzCvEA+IwvrC+xPRLYGOJKM4HxVTqe4G4Npn+Tx9fyUwSLGS7W9hw7vA9+tcjsq4xJIegoZZRnI26JwPKL1vBn24iRMlKVCjLcmFPoCJVVELGa35h3bxByebUn0M3JFQHmHmS13i+b2fVeSjy6jdjQGUqwR/YaHF065YZ6e+oB0A875TNu4MX6nJJHoUWkww+AmPf8BiKUWwqdt1rm6XJURtJboCPltQDbfrv5GJCMJhREcp/e/7VRbHLNFosVV/Gc/NS6fr35y/J8Sq9nlWpgvtJ3ydVpvkGMcvpl53IISL2pYCqBKa+jXV8qY8L1TI1YUXJ81glNFqWv+KQHsQPrBNZvU+/zehYrb2gVPrqXFDZIfLN3v/lJrogKk2TsVbtILTsDnxgSMk1f+mz1dc4dIUgAVw1j0jv7hPPP8IwPZSTfVnumh5CawjWfLSMdsZT55scKOQaVpddesTg/lmUJPYXeSVimO0QeCHPH+F1rQybkE4XND7lmc4lDY2IXIPuSLKRjY7Onffe/J0+Mf7+zEf1XjkmIlQlZG6eWW661jCWnyTnsuebqfwYrTIURBi8CBSm+Qf9Z75StS00LHXrAMCt0mKF7UXaRFszWXGkrf4EAvRoOnykL+I2ZoToQcRUoOwwN8w/CsAbUsdx5cqGX0P7GUbbHmsAbo2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(107886003)(66946007)(83380400001)(5660300002)(316002)(26005)(6666004)(6506007)(6512007)(6486002)(52116002)(508600001)(36756003)(66556008)(66476007)(86362001)(2616005)(110136005)(8936002)(8676002)(38100700002)(38350700002)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZ2WEhBb1liTFJyM29Bcko0Y1lIRXlqR0RoS0FYSDhFSG5lUVJIRnVhSEZj?=
 =?utf-8?B?bWVuQjhsOUFaSHRYRk9kbWtpUVl5aGR0Z0xHUEpoZW4wNWtPWEVWM1lzK2tv?=
 =?utf-8?B?MFlMenBWTjNIeDY4djZLNno5b0gxREdBZWpFb2ZxdXpvbVhLV3Nramd4dFI1?=
 =?utf-8?B?aEJHelREcXN1WThtUVpEOUxzeHg3ME1kelB6Um1XSENkSEQ4THprc0wyWXJC?=
 =?utf-8?B?QWFBOFBLd0NEY0c4L2srakFTbXBybzFHU0ZtdWk0Vkx1T280dFVaeEp2ak9t?=
 =?utf-8?B?dE1KdkI5bFgrQ29EMDFBc0VyQkhKT1h1d21RU3N0YTQycWx0NVJhUnVGaGQ3?=
 =?utf-8?B?bEtZMFl0ZHZxM2l3L3JLUWNHRlNSWnBJVVNFNFZ2WG9UWWk3dE5YZyt6TmNE?=
 =?utf-8?B?SUtwUllmN2lNOThvbGJwY3czUlFrb2E2TzROUEtGUkxWb3d0M1dlZUZnc2cr?=
 =?utf-8?B?WWdTQnFXQkxDdU1iODkvWlVEYSs1YTVYQjlLOGsxUWRnanhFMy8xM2ZVRXBH?=
 =?utf-8?B?enFHcE1GSGU4ZU96S3ArWWhBbXA2dTFZRCt6K3dvL3Vqb252Q1MwTWFpdFIv?=
 =?utf-8?B?QUl6dTBxREc4WEZ3cXdWUC9HWmFMR25JaFU0MnlUUGZJVFJKMEJyOFlBWDQ5?=
 =?utf-8?B?QUFzWmtDaUdrb1lYcE9MQkZvNVRsVGpucDM0dzJTcUNiT3RHMlh3QWJnTXlG?=
 =?utf-8?B?bFJNTytiNURiR2U3dWtOblp5V1d1aDJCUHNsVFJwY1NmdDk4S1N0Q1RtSE5J?=
 =?utf-8?B?YktGbFFhMzM3Tjl3eGlTUThJKzdsWDg4bk5taEN0M2RoYXRaVXpBYTY0WE95?=
 =?utf-8?B?am5jcTVRNnhyWU5uYzJtb1BSOTVLaDliYk1RL1VHQXdXU3BYeXlBZFpyUFl4?=
 =?utf-8?B?aFllUnQzckh4MkRUejRpWXd3QjFXS014OXN2aUhRZ1lxU0JsNzlGMmdvcGtt?=
 =?utf-8?B?RHJyZVMrVGJ6QnZ5bHNCYUxNMEpqMWFacUttNTJtWHBiU1BPV3ZtanR3R0hS?=
 =?utf-8?B?M3NSUFJsNms4RGJINTJ4VUJoaEpSNlZEbVVLaWc5dHhMOVh3MjlQRXYyNTYw?=
 =?utf-8?B?WUZXQytiWloyV0ZLVnhOVWgyTXZCUmErK0lVV05DZFpXM2txNWltZEl3QXZV?=
 =?utf-8?B?RjFWYkpyd29MNHVmS3duRndwV0ltVHRZV2tkaTlFaHRpY3k4OFloaVhxSnBx?=
 =?utf-8?B?U2tYaGJVZ1JMV3RTQ0h6VFl1UncyVktnSnVTNUhYMWpnZncrVnUyUzBHOGVo?=
 =?utf-8?B?VXBSYjRkSDJrelhwbHh5QjViQzNKU1dzWElyZmNHbGdYdGJNSTJDQW1rZWht?=
 =?utf-8?B?V0Zwdzk2TUpXV2tKamF3Tk54N0pEZ1BmZjBIQ2tTTCtxSDFmVWJpeVVjY1dR?=
 =?utf-8?B?dlZWWHNGRzhiTDdDUmV2UWZNTXA2WHdhS2Yxc2NqNHFGVGIrLzBxck5uTysr?=
 =?utf-8?B?NU5ZaFRJUERweG55eG5ieVhEdXlzem96NkZnQ1BCSjJSSVdXVUo2SWhHVXUr?=
 =?utf-8?B?S1lxcUR6bUtFRm1ZY1F6enJtVmhhYVJxMm1Hc1pWUTFFT0pkNS8vUHduSkZU?=
 =?utf-8?B?WXArSzVoMnRrbENaMDdEbEVrbnFVSXd4UzJGU1VlU0x4c3ZZYnZ5alNaZTJN?=
 =?utf-8?B?bXo1ZFJHdm1sdnpoRzBpdkN4YytmdGxyRHpUTmRUZmRWd3A2aG12N0YwMm1P?=
 =?utf-8?B?NFdmOVBURmRjcEgwQUxrOE95TEo4SVFhc3JzR1BENHNFa0k4T3JZV2prUXlG?=
 =?utf-8?B?U1Iyc1l2SDVUdmlHcnEzQUoxZmhjOGhUUGRjNWIwNXladDRqVG1NRllWcXox?=
 =?utf-8?B?aExUQjluSmhoWEsyeE5tZU5VTGhKdFZmZ0RQbU54VmY4eHNTTk4xSURRTnZI?=
 =?utf-8?B?cWhRcUxXWm8yZVNIRTZJN1l0bjZIWUQwOE52dlJYZHVhdU1IZDdFK0JWSGhJ?=
 =?utf-8?B?citCaGw3dWdid25kWVlIalNLRjFBWXdGNjk4cE1VMkNqWGVQRHdWdGVQM1cy?=
 =?utf-8?B?UjVvLzFPZDROcUk5QXlTUHhyaHBDb0NKL012VjFwakVmTFczSUtIejVyQkVK?=
 =?utf-8?B?L0VFR1Q0T09nekdiNlY1cEdJcGZSWmk3ZDRXcDF0NlpxWDFFSjNRWkZWKzdI?=
 =?utf-8?B?eDVrWVRsVE9kQ0h2d0l1Q3ZxSzhYZ0xTbFFmTGp5RHduS1lBQm9HU0RDUCt3?=
 =?utf-8?B?MHJUSFhFUm1ZVmgxT0ZUYURQTWlDTzNvQWNUdGRNbDR6WS94NkVIRHV1c1pv?=
 =?utf-8?B?bml4WEwvb2tvUHE5bmp4Q0RmY2lGd0I5VmJDRU9jYnc3T1ViaUs3Y0NCZkJR?=
 =?utf-8?B?ajIzUXVpVjBXYStEbDkrMENrK01JN1kreERkazZzREV2L29WVUQzOU56MXNX?=
 =?utf-8?Q?4Zf9CMExVEUInZEY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d699879-2e87-4249-7fb8-08da24568446
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 11:52:03.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRR9H59bvSvLrbKkZwwdqDYkqlKFvaWVWudefc+eY9zQAWYKmDdpwYFAV8bJJ524CIbSf4Zii8P/qPvVD3QNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3726
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

Testing has been done with Stream benchmark:
8threads stream (2 little cores * 2(complex) + 3 medium cores + 1 big core)
                stream                 stream
                w/o patch              w/ patch
MB/sec copy     37579.2 (   0.00%)    39127.3 (   4.12%)
MB/sec scale    38261.1 (   0.00%)    39195.4 (   2.44%)
MB/sec add      39497.0 (   0.00%)    41101.5 (   4.06%)
MB/sec triad    39885.6 (   0.00%)    40772.7 (   2.22%)

And in order to support this features, we defined arm64_topology.

V2:
fix commit log and loop more

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
+	find_subset_of_share_cache(core_mask, cpu, &per_cpu(cpu_complex_map, cpu));
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
2.7.4

