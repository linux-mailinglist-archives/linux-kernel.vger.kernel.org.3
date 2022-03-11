Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688344D58D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbiCKD06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbiCKD05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:26:57 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4D19BE4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/mmqRCKc+3/dVR/CcSD3hrNhKPF3pGcF1ekm3Etizp7sRnOeSAjBW+D74K0uQ6f2NPvo89JNDpssVCV4Yqq/4hXyfLE1USnYza3QYL82AK8QjDhbZ/NEUFtQ8ilkXl0ZV9rtsfQj1si7t6Gu7jBlbP5+HjoBOZi/bTO7fKMATeJ4jCo7OLSPbRRiuvQWQzdPreMfRZql2aNE2vnwKSlJQ+tqbeHYDQwJ51rTLIiA9R+ecYSpIz/lBvicsyx5KtuAWBFO/HfAqE+ewvjDkkmSU7zcdJ/AJEWFT/B+1glnxSNqxhRDawMXAuog/Mm6CC86NtaW8I06xaWtu8vdXVCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLBC2Fggod8qLdTkNIQHbLmppCvhxtc38MzF0FBUzG0=;
 b=LRm9O84GZPW3S2xSvtFMz1Ja6Va1wSk+JGI+ELy+HfLj2YQvd6qE88LBhmdi6HDeoofjub2YePhFgY7jHGxDSYBEhPR+07vHskOOH1qq5oWYh3bRyTEKnp27WvFU1aOG9JgyBLTJ9rtgMd64m9W1E3MJSplfp26GDgwN/A58AXH3JO48GWvRGJJ6zD/il2Qkl2GfFRi6YbF02zc/31S3XzxK53Jlzs84eB9S+etRaWwV6O/6gJI+83T4H8ICHVaX7xLsR4Z3FdYtoo+mDLxiPtr9Bb3QCR90m6ghkoN/4o92c00INh9K0uVVkf4tOKzlBncDuJfr1pYorwAYelmSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLBC2Fggod8qLdTkNIQHbLmppCvhxtc38MzF0FBUzG0=;
 b=U3SuOq97Tw8nWOqmo70PNVG3TrIhZvbOzlUZYSE6oKGq8R3mEHX0yAsNC8cV90z24U6L+tvkMDZpaJN99iT6aIEyxvjm89PPH3MGPysKVu7D6r9l3nTth2F0BP0Xdc/RDTXIw/ZrDWUdHuvLBKXwU0a6EEPfEGegZgYjI2m37Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB4852.apcprd06.prod.outlook.com (2603:1096:4:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 03:25:49 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 03:25:49 +0000
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
Subject: [PATCH V2] sched: topology: make cache topology separate from cpu topology
Date:   Thu, 10 Mar 2022 19:25:33 -0800
Message-Id: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0094.apcprd06.prod.outlook.com
 (2603:1096:3:14::20) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3848944-d989-47aa-2791-08da030ed6e5
X-MS-TrafficTypeDiagnostic: SG2PR06MB4852:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB4852D4A4B9DFB560A48C19B0BD0C9@SG2PR06MB4852.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9xizsUPv59fqBbaOofNTzdybChR7kP9tjsHVBnMKi8+enQVLP8E7CzXBp9YxaRtKCHle76Rskyn+eiwSEGhdhT18YguP5eg4VxFRWee1zZp3yDqEHTpQmXhxj2G2eNiEUcZHO0A34DveuI3PyKExoZubJQxyyjQ0oT5yYHvLf2wx+Joe3xGqxHzIbtSlq52AqBtOQocya0hucG31myG0OCDrJgZ92iSuuWYTNxpLS+8n24GQMp2TRtfrI2xi56CzKs1t0nYcJ3QRn2qXwjLRr0wANKOmKZ4B8kwyJkY4yDA9NfWKlWB9RWYB/Z8tWbH1O5pBzPrN4iYbWzbx0r8f/JxDvQCeA8EUmHwKE2nq7a031LnBxQmzMBrpR+1egCj+9gZI5ierM6jKJJMN70K8V4lbjXBDDpPBui/t+Yq3nxczKOEq5w37K72UA7rfJkxUbbx0qGiows++SbueGc6KLpHm/gMQJ0K7/K9MisnswkNXRpiRHKoJtuw5btmgqUbLxlHGbYOQXYRfZw5czx7qXj5ZM57AwV5eX/f5NUUVZqaki5S8s8ZXMINvtRZaBHajLgMP340LqfPd1MomVZ9utkN5zXWpg04OcpoCoqi/KOsKmYK885eh81ttv8RkHOrjJWg8BcZzGsbndVmTszAM9jP4L5ryuxs9JMTF+2wpBDipmcn2wWNpqyOgVM+L86GUhqmYs/cXLRBKcehzNvXBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(316002)(36756003)(83380400001)(5660300002)(107886003)(8936002)(4326008)(6486002)(66556008)(8676002)(110136005)(66476007)(38100700002)(38350700002)(6512007)(508600001)(2906002)(921005)(186003)(26005)(52116002)(2616005)(7416002)(6666004)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JNh2op3kDHlseKMvhVlTJCuC5KgCVnY9g+LhY906uskF5+pidq8TESvlrBGv?=
 =?us-ascii?Q?B15vLr5PDbfY68TlLFxw5/gPtV27qGlIYoJwKR9w3NeTWETmJSyLbSAg2TeX?=
 =?us-ascii?Q?LDIwgAMTRCjOpbucjCt6uFzJDV2SVWzjBhgx7vAb3d9xKsh6b38nr66uJOOg?=
 =?us-ascii?Q?33FyXaB9Qd6lQOzPrqXllY2OpV49gQr+dYctX+DHjw8tKZMiy5iMedDYylfj?=
 =?us-ascii?Q?4vsxgjAZBm/M5S5XjGLSTNA2NHeKcnAwCsCQdxyS7HGsK5D5LJI/RGiPCHtC?=
 =?us-ascii?Q?hGpYYcZexSxX151C/0CCIQIqt8Fg0Tzemqq6OQ/YTDR7HE7TwjH9VtrTCmMu?=
 =?us-ascii?Q?qpCJenOXctwsPf0Czp4E0s15s0iL6InjdUWAVHeDGnCwH66PZIUaD9aRHNYY?=
 =?us-ascii?Q?t6Ve4nz+O9ARoj32e+vGaJnDw5g8l/Ilo8hCnnlXFv96DeDNPpMlNJm2a6Bs?=
 =?us-ascii?Q?c9UwBZ++37vfiuHnWFM/w6tLl0IAoBWn6Fk9Af7rF9AGLJnEvRDtPTpItkOL?=
 =?us-ascii?Q?GfVYJN3lrH6abimtqkKgLgUajVPrn5NzLt9aukf0PRndyVxJ+YIILFWRe9LO?=
 =?us-ascii?Q?SEnyRbIOefB2Qo/Uayc/LXS5yKY0VSrXjTVeQ/s54z/UJXe+/SR09WztVxHv?=
 =?us-ascii?Q?/NlPIJLoi4GLy6si4PcYTqo0lu7yhvZv4BAB3gwS8UAteo5l1L7sqZS9SmKb?=
 =?us-ascii?Q?X6hd6RRyNPvyZPpo8ogzf0X7QLjC9PtEcY7I6HTVy4FxIi97ZroV/ouiVvK4?=
 =?us-ascii?Q?0/vGtlnIDh3+w8WAVwI034TN6hZnI1qzronlpqVzAiC55DxCY3ypMshZoTfH?=
 =?us-ascii?Q?NkgKTBQfOnaSmoOw31Z45tygQN9JkWlCNNI5B3uG53WI4iBg93Jm6IftlIkv?=
 =?us-ascii?Q?IZa3NUtEf354MulcraJYha1CD/EzmjxKxxEJtzyCOjpyMl0geTXebxAr5vyp?=
 =?us-ascii?Q?/8IsxX6n/lxJ1mlCJByZK/Dvu16ZlVHh1H+CbLeVUtSCyptKaSphXuDsd7Mc?=
 =?us-ascii?Q?eXdVibjSgWJKeWB9YqFOj2R4787TGwszovUI6VZJe5GKK/dld4JSWypNEUG/?=
 =?us-ascii?Q?3jNMrG+Ar47W2jkAOz+js13gwTLicVG03tkAU3JjPiTJbR2SfRf33rw0QG7K?=
 =?us-ascii?Q?rRFMAIyymsMUsb3dp1kziLfnjDCQ4/PpuSGrZdk9TqKXZAMCQg6egM0+pJgy?=
 =?us-ascii?Q?JMsx8hJpEJzxA+fAt/Tidon4oFup1LL6u9CiJgng5wnxrJP7kukCybndbbgL?=
 =?us-ascii?Q?/ea/ZiXezVUdFwdS3MlEuNVicuNiG4kNcG7aYDfRm0hbGnFGrJHFEcIXQZI0?=
 =?us-ascii?Q?iQ3j6dlaUAbBL0dpqT6AWk4j7WsHy7Exem2Wd3ZKZ287iiICfrg9Zix6yAvw?=
 =?us-ascii?Q?diyLo5H7rcK25sMIkNPqd08p9xHTS+xSREbqAdbgbMKzwR+1+u5Te11kC7wl?=
 =?us-ascii?Q?t58Bf61KQ3aQt8eFVebCE3X3zmhSNxB70brF07fxjjCUGf3z6beShfxj2PBX?=
 =?us-ascii?Q?ASkY+RWxmzudy1RHfm0oT806hkOKVoEaEQP3bGbC+kT3bosw6uz3t9fkxuy1?=
 =?us-ascii?Q?NlObyzAcPT1qdomLYEcsK3+bInvDAZBuF7nqExPqG0PRfP9Q1imzB0lZ0wpn?=
 =?us-ascii?Q?RT3sM7FS8em0BosVkqLzPaU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3848944-d989-47aa-2791-08da030ed6e5
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 03:25:49.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LRxq0fWZPVPdNLkJDs+ntpM9+gEhht8I7dGjvjsEs2ahT7WeJaFC9cbVkEhdi4RHI5tvpXHWv4fK+Lhs8Rjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Some architectures(e.g. ARM64), caches are implemented like below:
SD(Level 1):          ************ DIE ************
SD(Level 0):          **** MC ****    **** MC *****
cluster:              **cluster 0**   **cluster 1**
cores:                0   1   2   3   4   5   6   7
cache(Level 1):       C   C   C   C   C   C   C   C
cache(Level 2):  	  **C**   **C**   **C**   **C**
cache(Level 3):       *******shared Level 3********
sd_llc_id(current):   0   0   0   0   4   4   4   4
sd_llc_id(should be): 0   0   2   2   4   4   6   6

Caches and cpus have different topology, this causes cpus_share_cache()
return the wrong value in sd, which will affect the CPU load balance.

The cost of migration in core[0-1] is different to core[2-3] within sd,
because core[0-1] shared L2 cache, but not shared with core[2-3].

Cache topology should be separated with CPU topology, it can be obtained
from "next-level-cache" in DTS preferentially.

V2:
move fix_cpu_llc() to arch_topology.c

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/smp.c       |  1 +
 drivers/base/arch_topology.c  | 56 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h |  2 ++
 kernel/sched/topology.c       |  3 +++
 4 files changed, 62 insertions(+)

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
index 9761541..d6e59b8
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -609,6 +609,62 @@ static int __init parse_dt_topology(void)
 #endif
 
 /*
+ * cpu cache topology table
+ */
+#define MAX_CACHE_LEVEL 7
+struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
+
+void init_cpu_cache_topology(void)
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
+		while (level < MAX_CACHE_LEVEL) {
+			node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
+			if (!node_cache)
+				break;
+
+			cache_topology[cpu][level++] = node_cache;
+		}
+		of_node_put(node_cpu);
+	}
+}
+
+void fix_cpu_llc(int cpu, int *first_cpu, int *cpu_num)
+{
+	int cache_level, cpu_id;
+	int first, last;
+	int id = *first_cpu;
+	int size = *cpu_num;
+
+	for (cache_level = 0; cache_level < MAX_CACHE_LEVEL; cache_level++) {
+		if (!cache_topology[cpu][cache_level])
+			break;
+
+		first = -1;
+		last = id;
+		for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
+			if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
+				if (cpu_id < id || cpu_id >= id + size)
+					return;
+
+				first = (first == -1)?cpu_id:first;
+				last = cpu_id;
+			}
+		}
+		*first_cpu = first;
+		*cpu_num = last - first + 1;
+	}
+}
+
+/*
  * cpu topology table
  */
 struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index cce6136b..3048fa6
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -82,6 +82,8 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
+void init_cpu_cache_topology(void);
+void fix_cpu_llc(int cpu, int *first_cpu, int *cpu_num);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a70..d894ced
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -661,6 +661,9 @@ static void update_top_cache_domain(int cpu)
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
+#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+		fix_cpu_llc(cpu, &id, &size);
+#endif
 		sds = sd->shared;
 	}
 
-- 
2.7.4

