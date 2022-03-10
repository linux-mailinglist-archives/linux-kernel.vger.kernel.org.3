Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486104D4789
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbiCJNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbiCJNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:00:38 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417D6623E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBHxvG7GFFRlf92aa2aGtQnM2zFgDRYB8e9gY1hHyU4fM29o7puGD3NoCSbDEXrxl4ghkZshMuFeiw/x/kMlYbYmVeFXNlexkFW45qCnR5nOH9MUwV4SNxZYouy8pHWesAks5n+K+BlJ5bRqKAQtRadQ6rvZaLmNE/K6VDuDPKHHmMmW2b56WdStl3FWzEczFdhud4dR/pE5/ZvuSKdzA/CsyXRTHv+IJnupUHqS93qtJ0UQFlvIfpb7Dle9N9xyUH9ijxI9lWZX+uiuXZyRvTHnKgjvA7h6S2Dv7Fs2J5CKHMfQFQ/a5wCbz0txMi7PEer2dwTshNaYrdG7SfCewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9g9fgQ89v8y1uVdWoCBcrEllBkos0KUdv/TElvOlQY=;
 b=m0IV/Ad9BRqld328EBPTtqLTDq0FtG616dc5h538he++RbzFoz2DFvmP1xcwcGjq4MlkWbz+5cNAZzc//Yv/KvBPgUE+3eh2GWImzY+SeKg3G9fKIcVGyAPR286wUxdrgC/kD7lZJJyr0NRsTxZQJTjgKQydD2z0/aiuAdV+2bXYRVUHtixWsNShnYZczKmWtXmBXW0L/y1H9xIWkwt3G3Nef/KeO709RwAhZTjETV6VYHV3G8xH1Zs7BOkDzt5uykhEq07GpxIH8qLv5f0VVogdKjmHlTWt+ELEaBmfXDC1tFqLyWuPwmCdxzeMiuc8Q5XSZw7BQYt1/fklz2nDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9g9fgQ89v8y1uVdWoCBcrEllBkos0KUdv/TElvOlQY=;
 b=N1vUj3URQvRSUFul1fdBJJu+NE/yrEV9D1osVoMnTtG2HJwz3vMX8arjOGpWwDAuj0MRhVdSYquyhZFiDTJsoeg4moE4JvtLfoROjsO3P/SS1hCD5ClvbRe5M9OUBpXbMtVLDMxqGzNSjBWO4v/wG/h5IHusgALOISHEYhebi6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TY2PR06MB2912.apcprd06.prod.outlook.com (2603:1096:404:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 12:59:33 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 12:59:33 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: topology: make cache topology separate from cpu topology
Date:   Thu, 10 Mar 2022 04:58:44 -0800
Message-Id: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88bb79fa-87d3-4e19-87f7-08da0295d268
X-MS-TrafficTypeDiagnostic: TY2PR06MB2912:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB29125298FCBD494E19134284BD0B9@TY2PR06MB2912.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQCf35i3xekFWyZ0mqBZHCyRZ7ukarTj9ej2+CqHp6rFoflBr6iB37WLfKjPHbGRmGcubXEII1FU+x7iEu27o/WHeMvyB4wNOYG1kWEDtlLLQ3yjC9rrH00ajDX4dwQxLPAz0JlraAB83FQEHqNaeQHVLMK+9sMY0N3hbvjrC8DUhcXvLHisPjQdic+iEuYImK53LQbIAoXKeyWeVhApb3I3GujAG9Eo+fnkaq9YRyFnonJu9DDuPq7Xb0yWI6gkUFjHyd4NdCdpPXm8d3HqycFSgblCwF5S80cs6ok/pJLYH7Sy2m9Hkkb/9SuWCQkcKA6ueD5uqpIl9K3d/C1UmfhMSjp2fRn29CtyWnEoHNLN2FYODnlE8xdCM6D5jGggkiIS0Ll6Bu4yMUEQb+1mOtPtW4j/dQYZQ9UWy29fjVB4uslNbY9YrrWLZge5PPtgusPwuSX5Is1IOi74dWhYE8MPDjvWuEJx+KYeLzfwHhAHL+XBoDBT6kW2e1+ssEMCusA4hPIpJjGzDVfxUcSFWiysL5VXk628bkpE+mbBFTKTevLInrHA7uZ8TDGiQ+nvsx6K5ETr216EMMF0isH+4h1EJiSVJClB4C1iYPe9H70tw8s5iq+p5DqUGT005AnFHwSUnNaDEtKjI0cP1jf6DH+20hHduvkFeu8XHUz8WhXYtyqY6vlowWxoLghEVxXy+8Ws1oLYe4XnB5rlkND774vYy2owArkK2/XyNBy5HSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(86362001)(7416002)(6506007)(38100700002)(38350700002)(8936002)(921005)(66556008)(66476007)(66946007)(5660300002)(36756003)(83380400001)(8676002)(4326008)(2906002)(26005)(6512007)(52116002)(6666004)(2616005)(107886003)(186003)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGF12/VzYtPVFhw//L6veZKqxsXL9MuhvAgXjBvNmUkPBsnnjfRVj44Yu0Y2?=
 =?us-ascii?Q?gFlx4eeT69frpv0FDLdBpxyOsExeb5wBP5C+QyJoR+1QDHwcC5buwa8M+XVP?=
 =?us-ascii?Q?wrn/ShMmB7lSnJvXJvjXdFbWW1qjcC+2q/Iqz5rXVhD06gy+1nhNv8vQ+P9T?=
 =?us-ascii?Q?jPCi4CAVkZL22X+qrpKZ8saZchbsHu1zSaFa4wSWgHG8jgd3dnljhLAk6Mn3?=
 =?us-ascii?Q?uvMzfSZSA9vecHBNjt8g7MS8mTHg84KP2aEd3YHj3VMHWYVbohdTY8l7zsd1?=
 =?us-ascii?Q?/asmYY8VMTttck4oGYe8SSYYtFpzEbSE3MLvpO8fxV3+i4y8t4SjLZokfywg?=
 =?us-ascii?Q?HMjl6OZPSpWs7BIzmZ7LgzUiWE/ixWHH5QvVd5nRqPoMsHZ/opKs2WDSfhWZ?=
 =?us-ascii?Q?eE6H0qvgLHZTnS7LHlhBwVRi+MSaGOXFn1eKtykUyzZtSAxJYsva95yLqlD4?=
 =?us-ascii?Q?X+NBH7OxbmIi1S1V6DzQU0O57cOsAHpOAHpEKNEeNc2UNt7PciszQyAsUJbP?=
 =?us-ascii?Q?j8pxC13krODCEqiROoiNXS28gAuhxEydvSPyltD7a7Vslo4sViANRQyrRCZT?=
 =?us-ascii?Q?sDO+ZKJo55sLm+VxY6QC27zJstTmEDmiPzvLXfpkwd+AU0oLv6v+Ce8pGaOk?=
 =?us-ascii?Q?/vUWJqkP2qYVPnz+vXHv8ZPjmnLc5eJ3uPyk+WBJ/SADzGvFpxEMLMwHj8ev?=
 =?us-ascii?Q?zDNKEidZ86P9weyKw9F9uZzvXRbbAgqs6tznuxJxLkNCJ4G4qbsYgeqSw4vu?=
 =?us-ascii?Q?kQ6og5ILeU5FGHkdQiBhVXruHJw6AM/ZbYc1+nbBOYT7aid3FAvpQUwWhiH3?=
 =?us-ascii?Q?Ps+mPN71xtWzciRxlcL9laV2BCHb0imiUbOHVdve7W7+/FrSHBOlD+IecyWB?=
 =?us-ascii?Q?liVHY3CAdIeFOWVuCKqXc+5DwsejYjTLVzBnV3Lp9vJDaueO2msoyJ4RbIsz?=
 =?us-ascii?Q?RsDgjLyzZLWge3lmdmAYD57r4/o2V5h88ZqnNblyutR6aRzk2ctO8Bquxmdq?=
 =?us-ascii?Q?8crxYSMGwiVskf1+8gsRJqXThrUTmxqNwuiES0At9IjKUuAL/RC8j3mw718c?=
 =?us-ascii?Q?yKNXqgCjhsGEye3U0qhIVIxFnATQvf+SL3QGvrGoNl2uTIF6nA4sWN6Rj9T4?=
 =?us-ascii?Q?OEUh3lOLeL0vnocSIAAoptoqIe1Gy5r7M0RyLDuNeSS7t2fCCdtZ8d+LRJw0?=
 =?us-ascii?Q?7/2yRc8utw4b44uUncl8vCRXf63NBx/CZ40XqB/wSx1JKiS4C8P5IMBj4HxI?=
 =?us-ascii?Q?s3SJhxNj7zqo1MOJnI1Ormv6f7I5L+3D4+/I6KpBDR8sxPv55y8/tGdsKN/t?=
 =?us-ascii?Q?kPX3QcOy0epAoxr+8+Fnt+uKO/AyRtq65DysvwtR16eMlA2SqPeafdKUPMSs?=
 =?us-ascii?Q?WIvgvGYsZomeQ7iX3hXswy1rgXxgMYpXtp/tSn1x5SCKArsskBEVk0NSBInn?=
 =?us-ascii?Q?RkrugTTkqL6R/8wq6ADIs0ed41CHelf4CYf1gkdft36/byLz+Rr8oVz5wL1r?=
 =?us-ascii?Q?8XqskuxFL6I0dLqEMGWUgdowMG68BN1sIn23sPXp9MIFPnWXmIcB2K2y4ie3?=
 =?us-ascii?Q?8ppFPP+V71eRbNelQ7JgVBRjQ0iIku8Udgx8LBngoWpojkqPMMuMRBcyaLzb?=
 =?us-ascii?Q?ZRYbSYOZOGYbHImaX9IOR5E=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bb79fa-87d3-4e19-87f7-08da0295d268
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 12:59:33.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q5xYRKdJ9f1my5n0a00CscsBm1rpbf3SwGF8ACIRzIKEApbrduSD1QclJ4auUp1kWRK1pN0o3fZkBSPCQm7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2912
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Some architectures(e.g. ARM64), caches are implemented below:
cluster:              ****** cluster 0 *****      ****** cluster 1 *****
core:                 0      1      2      3      4      5      6      7
cache(Leveln):        **cache0**   **cache1**	 **cache2**   **cache3**
sd_llc_id(current):   0      0      0      0      4      4      4      4
sd_llc_id(should be): 0      0      2      2      4      4      6      6

Caches and cpus have different topology, this causes cpus_share_cache()
return the wrong value, which will affect the CPU load balance.

Cache topology should be separated with CPU topology, it can be obtained
from "next-level-cache" in DTS preferentially.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/smp.c       |  1 +
 drivers/base/arch_topology.c  | 23 +++++++++++++++++++++++
 include/linux/arch_topology.h |  3 +++
 kernel/sched/topology.c       | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 27df5c1..94cf649
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -723,6 +723,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	unsigned int this_cpu;
 
 	init_cpu_topology();
+	init_cpu_cache_topology();
 
 	this_cpu = smp_processor_id();
 	store_cpu_topology(this_cpu);
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9761541..613213f
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -613,6 +613,7 @@ static int __init parse_dt_topology(void)
  */
 struct cpu_topology cpu_topology[NR_CPUS];
 EXPORT_SYMBOL_GPL(cpu_topology);
+struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVEL];
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
@@ -738,4 +739,26 @@ void __init init_cpu_topology(void)
 	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
+
+void __init init_cpu_cache_topology(void)
+{
+	struct device_node *node_cpu, *node_cache;
+	int cpu, level;
+
+	for_each_possible_cpu(cpu) {
+		node_cpu = of_get_cpu_node(cpu, NULL);
+		if (!node_cpu)
+			continue;
+
+		level = 0;
+		node_cache = node_cpu;
+		while (level < MAX_CPU_CACHE_LEVEL) {
+			node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
+			if (!node_cache)
+				break;
+			cache_topology[cpu][level++] = node_cache;
+		}
+		of_node_put(node_cpu);
+	}
+}
 #endif
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index cce6136b..d37f47d
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -72,6 +72,8 @@ struct cpu_topology {
 };
 
 #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+#define MAX_CPU_CACHE_LEVEL 7
+extern struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVEL];
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
@@ -82,6 +84,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
+void init_cpu_cache_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a70..10850d6
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -650,6 +650,36 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
+static void set_sd_llc(int cpu, struct sched_domain *sd, int *first_cpu, int *cpu_num)
+{
+	int cache_level, cpu_id;
+	int first, last;
+	int id = cpumask_first(sched_domain_span(sd));
+	int size = cpumask_weight(sched_domain_span(sd));
+
+	*first_cpu = id;
+	*cpu_num = size;
+
+	for (cache_level = 0; cache_level < MAX_CPU_CACHE_LEVEL; cache_level++) {
+		if (!cache_topology[cpu][cache_level])
+			break;
+
+		first = -1;
+		last = id;
+		for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
+			if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
+				if (cpu_id >= id && cpu_id < id + size) {
+					first = (first == -1)?cpu_id:first;
+					last = cpu_id;
+				} else
+					return;
+			}
+		}
+		*first_cpu = first;
+		*cpu_num = last - first + 1;
+	}
+}
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
@@ -659,8 +689,7 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
-		id = cpumask_first(sched_domain_span(sd));
-		size = cpumask_weight(sched_domain_span(sd));
+		set_sd_llc(cpu, sd, &id, &size);
 		sds = sd->shared;
 	}
 
-- 
2.7.4

