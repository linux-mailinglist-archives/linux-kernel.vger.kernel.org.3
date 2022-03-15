Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624F44D95CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbiCOIAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiCOIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:00:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381042B278
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtRXVB5LWeRZ4+l8SwvV7sfVqvoqBAc3zESYnkOMN/ByVUZ4LzYNnOm7e6ZrdO+17GsCi80LJ17GUhHcKpdNqAP+9ii5lQpG5xgQAhdDUbO0C2PdOG1ITTC8jEOEu3HbBR+dPgFJdcxYd977/OFQZJaYH/2LXK936kE1oPnuTw1HelcRjA1RJMh5SnVialmGMAsjg74CmgbUTt7F5RfyyNM7+kzaILxF9cHhboLjYb/S0KHydu2C2m1BoJXB8/IFWe7mDE6FYKl+3TgpKPnIgdCC3UxFM8Y+U+z60/3mDee4CDjZZHzGrV3gxfQNQTMjRDO6fkTV0jo5x6CidZ9hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVENytnd0DY4upwZTTub86qNF/K0XZ1OFm9Gb0yxNhI=;
 b=nlDFCqzsMsBM2iQtaPL5EB9TfFvbmiIel6zY4fznA26QVl6TdtZhL6PeGVcFFmcfYKJGctIbbX3ppHtZiQTRzP3KCwHScS9AsIPUs0zIYjQI8g9O9qmSiokH67EOat/OvufCkwgyKZVHLzcmgQ+yMwiNtLbIHRWUdie5o8PggDLFBLGkv/AIDfNdqYLz89fjv6qkLeB/3Y0dYGowrz2Ee4gENMTF4SMe7J1Sup5Es5XOrnREU/+foIK4x9DzwE+wrAqQIy8I27qTj/jEtTlKbvyJxAyKrwARCLnBhopxEV687EoiVV/cGiXcrSdCBxDuGaXbZbH5yEXGNpBh3pVtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVENytnd0DY4upwZTTub86qNF/K0XZ1OFm9Gb0yxNhI=;
 b=PTmyuyOPc6CpEwat/0ghA2iDpEqYM+SDT+3us+7MoDFh4TK2Af8bXFoXJHfgUivz3jQ+XeV0YT8tooO6BT4joocmcFz2yH0rQYkdueUth2J+IFTDgKOQeBuZUudtL+3A6hm6dvLo9aCSGH8fXA3168GjM6h1Itt5FbP1radyzrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by HK0PR06MB3650.apcprd06.prod.outlook.com (2603:1096:203:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 07:59:33 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:59:33 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: dynamic config sd_flags if described in DT
Date:   Tue, 15 Mar 2022 00:58:54 -0700
Message-Id: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acd76b9c-e1e0-4e25-72b5-08da0659bd84
X-MS-TrafficTypeDiagnostic: HK0PR06MB3650:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB36509A699763F9FFEB00F5AEBD109@HK0PR06MB3650.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwxRa1a+x+OVA61bsPhvCMoAPrTCc4yBPgTwMntRKHYuYxIX6jaJQP5TfpbZC+eW0rMfKBMZedfbzB+tc9MGjMc334Po3pVx2Yc83JIU4CBwpherv5fGCjaQJszaZW/uGraF4qwBTiaz4KwmjIroSTSCojLkCzYnzD4cqKBCpPvl0kfn0IRoFx/098maCkw6yqewBdnnGGLOO6+FGtUkhx6j02B6gVh9ESVcW4Uj1kD7AJ6MkIJW66ySkEbStxuCfFfbZFjY7pTD5uYU4kX1LuFKrZsvQto7Bvgz9Hp6bl/Z3KDPWR1yTLrvjtN1ooYyrqyuID/HHbRhmWzE8papo0Mibt4leq3D48yT9lfra20LepT9EPI7N7z+ZCTiZRgqbcAd5JSoeujODA/iyZHxpm34rJVBVJr2sNXy0FbYvTYs5Yd1lnsl3AmF6J8xZPX+L/3L2X2xw37ZWRHm0Up0UVxVGS7JNwW7YvzoQKGVWG7X4X7q2bb+kUaK7g5wfOKdSDMTb7ibacIM1roeXRy34j0Hr/zkeJv3eGjICDDLadQLtFxFKuR7LvB3j9gBi2tsJ2NyrkOZs2dAPo4R+AGZRSQ87IBY2vIjA26MZM9GY3Y5i+8q2yThY7iF+gSFYWyN5mbL8JcdGO4bNT8UUE1vXhgGKsOTsIHo6EX27sfolFd2rmvOm4uLeqwwVMDJKosUMees8nYKJTRzDAhZg3LH/DQ9RSwiDtv8SIVkbArOjmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(921005)(38350700002)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(110136005)(2906002)(7416002)(5660300002)(8936002)(26005)(107886003)(2616005)(186003)(6486002)(508600001)(6506007)(6512007)(52116002)(36756003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SGVly2sLk7K1EB3wQcw7yQrB+amL+gzqpD13rU9kEXtD7JOBM6l7slBHK0dj?=
 =?us-ascii?Q?qhS1QN+AKYRef13vDJVRGkwAaN3xz+lVJFCCiGuZKNPQuVjo/DtPVwDDIJhf?=
 =?us-ascii?Q?87V2qfGe+WzHA8QritS+4Gu/8RqDZ3Vorz638VjTykb3b0VZIE0gCC769fhd?=
 =?us-ascii?Q?TiJXFoz0om05G2WeSYFdveMhDfuB1usuUFZhaSZdZ7HArE8sERGkUo9iDYqY?=
 =?us-ascii?Q?Do02vv1DJoC5xHD5ncqjd313+TLR17a/6MX9T7ocF2FGw7ejU1Frg3jDqJQf?=
 =?us-ascii?Q?QAPn4qGHylDI3FVg+kjm/IlHmrz8BywGpbkPCSTx+sKjT8i5whleXPFmbZOX?=
 =?us-ascii?Q?4sZ3/DsPpcfy/QX/R9z72olX/6lYLi6VfYQP7NCbb+ur+3KoeYGzjuRaQwzq?=
 =?us-ascii?Q?l2Uw7jfhdH/93el6kgeF3JKzE91rQE5xAx7JqsoAbybMiOGP9vKV277dfC8K?=
 =?us-ascii?Q?0pE7vUjQy5g8SZObyLFLOfbxUWXF+nSZ06Ro1GezRaXB+vK4yNlwiRtF5PgE?=
 =?us-ascii?Q?eNdvlKq1xd5AcxlKGJ6gHUwLF+dV4+R+RSHhKEowcoQMXAGcerXwFZE1JD3P?=
 =?us-ascii?Q?AyirKlVnXS8m4jxvmwBpLXJWonUSXWMdsutVdvnr0mai9eLxrRrkyx1cyhrI?=
 =?us-ascii?Q?wrN0wg2ARFPIcws9xGzX1VwzZ2iaEnf5XN/xweCt5Mcx1ijgW712NWXV2UKj?=
 =?us-ascii?Q?b8qMb4b+uVSiUlQFZYatS0mHuDMT5t5xj08p9sYBwKtNOFguR0TKaWIy6HUX?=
 =?us-ascii?Q?shkPvCsN45R7gZqYT8HL0wieY2jG8l850BJX0e/vdGHPCHQOU9yfZNZK3CXF?=
 =?us-ascii?Q?Ueyo6H1wOXQnm705UA9yOmZXcWiXaIoI8g28TK0wf4YfY++hYWYohXPTwvo6?=
 =?us-ascii?Q?rNszYRPlaTL6D4GJ0PCJWciu10fwzxLY7tyFLDCJx0jm1rPWjvp4M9n914f+?=
 =?us-ascii?Q?0x4dOOvQNzAo8as9CarodIzmCH3QSFGRMGG13hFJ4Va8/+yYUZlxelVaRQaL?=
 =?us-ascii?Q?OfpSMQsTZrtSOiXoK0q2dZmQmy/UW27vylo5kXBDB7Y1FAoHKd0LFryES8qX?=
 =?us-ascii?Q?6UHZLPSibfokUmBlW4O7P3ifKYRj62HZ2YuMkuAZ+2D0bLHT/5qJ491uXoAT?=
 =?us-ascii?Q?ti6o4GJvjTd/wsiHzsAHzcawAJ4P2+zZfmw9VSOoCPKwncGYWyOhF/xV/yEN?=
 =?us-ascii?Q?Rj4jplMBWW68vTnOUUDGyutBm9wsEv2BKalOAD3ju5PzmTlFxWWtUTWYxOu8?=
 =?us-ascii?Q?gVtE7qGNiU3WoZu9TWnWiPHFGL+fsWYtmvvABh/4aJAjYu0NqwLG3ISVdfiq?=
 =?us-ascii?Q?svLDG/ldX49J/ZQdxzVqI8+WltTvuo/bqAoFPBYsDddmq4TxAYB9cI3vuIbv?=
 =?us-ascii?Q?LpkaH0JTXMvyaSFglFxkdkHg5u6if03MSGFT2w0vjlRV0OU1SI6UgFStYrs7?=
 =?us-ascii?Q?q6dqdGr5LAKzKqFBbZAdak8jpib3TvPY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd76b9c-e1e0-4e25-72b5-08da0659bd84
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:59:33.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldSsjBMDiWujWafJJbR0Hp8j61e7r7PauMlKcRaJCU+1Pkiog103ySL3UJ5DdsPvrxl82AGghei3yb5h6vTRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3650
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The device tree can describe cache topology by "next-level-cache",
Prefer configuring SD_SHARE_PKG_RESOURCES from DT instead of default value.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/kernel/smp.c         |  1 +
 arch/arm64/kernel/smp.c       |  1 +
 arch/riscv/kernel/smpboot.c   |  1 +
 drivers/base/arch_topology.c  | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h |  2 ++
 kernel/sched/topology.c       | 10 ++++++++
 6 files changed, 74 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 73fc645..62bbd9a
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -508,6 +508,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	unsigned int ncores = num_possible_cpus();
 
 	init_cpu_topology();
+	init_cpu_cache_topology();
 
 	smp_store_cpu_info(smp_processor_id());
 
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
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 622f226..4f5a8b7
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -41,6 +41,7 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
+	init_cpu_cache_topology();
 #ifdef CONFIG_RISCV_ERRATA_ALTERNATIVE
 	apply_boot_alternatives();
 #endif
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9761541..127f540
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -609,6 +609,65 @@ static int __init parse_dt_topology(void)
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
+int cpus_share_self_cache(const struct cpumask *cpu_map)
+{
+	int cache_level, cpu_id;
+	int first, last;
+	int id = cpumask_first(cpu_map);
+	int size = cpumask_weight(cpu_map);
+
+	for (cache_level = 0; cache_level < MAX_CACHE_LEVEL; cache_level++) {
+		if (!cache_topology[cpu][cache_level])
+			return -1;
+
+		first = -1;
+		last = id;
+		for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
+			if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
+				if (cpu_id < id || cpu_id >= id + size)
+					return 0;
+
+				first = (first == -1)?cpu_id:first;
+				last = cpu_id;
+			}
+		}
+
+		if (first == id && last == id + size)
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
  * cpu topology table
  */
 struct cpu_topology cpu_topology[NR_CPUS];
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index cce6136b..862e584
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -82,6 +82,8 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
+void init_cpu_cache_topology(void);
+int cpus_share_self_cache(const struct cpumask *cpu_map);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a70..8264e2d
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1527,6 +1527,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
 	int sd_id, sd_weight, sd_flags = 0;
 	struct cpumask *sd_span;
+	int ret;
 
 #ifdef CONFIG_NUMA
 	/*
@@ -1539,6 +1540,15 @@ sd_init(struct sched_domain_topology_level *tl,
 
 	if (tl->sd_flags)
 		sd_flags = (*tl->sd_flags)();
+
+#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+	ret = cpus_share_self_cache(cpu_map);
+	if (ret == 1)
+		sd_flags |= SD_SHARE_PKG_RESOURCES;
+	else if (ret == 0)
+		sd_flags &= ~SD_SHARE_PKG_RESOURCES;
+#endif
+
 	if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
 			"wrong sd_flags in topology description\n"))
 		sd_flags &= TOPOLOGY_SD_FLAGS;
-- 
2.7.4

