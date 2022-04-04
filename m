Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081144F14A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiDDMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbiDDMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297113D34;
        Mon,  4 Apr 2022 05:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5Am12zwkg0z/CpKEeVYTNPQxFPKvOV8hyYq8IOLuafWYl8onPkS6ILOjo2omcij/LQkRhub2femXg8TuvlUG5SWTetcc1zE/+hch37uX8E6+zM60OHF/5Bb4BbvHn4Up+JE11pZCwV8Ij20GlicYStu2G9jhZ7JYhuFXfKMEx6yY8V5j+j8EbwpP4H4RjVeIsZmgjk9niQU+aQ1H4RUUwofY0K+e0jIHRfrLcJImnsoJ8FnYN278+BDdnyQw7i/y1sR6DS586EFKVzLyaSzmeViwXmdV43LWZDzgUvaKmuFOc5E1qcXhK8d8aFXWaixwed8n0nQipRYj71NWk0KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=ASPyZ+kiaFluQjvEoh3+FxHyF7bmvum96jqf3dfe4lMO3gV7nbfBEDdcmBHuwQq9TeIgSDhE9taRjwqs6B4TaLqDRtkxV+hzinUCI2emLGZEat5X8zUNdr8EzP4DuNaq2Bo1ecMELThWO2FtkDPSN5/l1zMGnakPQKF0Yk1RshGYY2Xi/8PDjvK7b+hcbI3AeSJik87Btn6xtPBbGvUWQRch2AkCmFTlQ3P6VFlaGfyWIizM9JgAdGSdRKlq4lSUvK+NOoK+IvjQCpmZZITFc3VHzjVnMCOhBi0yzdqwTDJeE1cMll6YdTuYCn/TMuwB9r1Ahr8gX2z37+VBus4Jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=niq8h9ITl5211ukchL5WsSWhfAY+x7H/FhiLXd6C03N/+4wKr8KOODP5XeUoNL1nWur2ppvznQKWvDcI2fetTq7myh47xJOznjPxy2J7Nj1ma73PQckRsHeKenmrcDRl9dbmq5s2L/j1b590dvS/3qyEh/lDOybMG4AvA0jb9iKbadGJQfCz2x43jLu8AbjjyL1QPEnkZ1NrQaUx1SqfwH4q+1akcQNteHCpbtFDezjhgT3hU8muT3656Z72P6qkYNd157Qynfj4eYjlO9bVRgz5izg0BBSFJCxZ9rlJhirfrsiD04lYcQUpSrVkftVuBRAgpD//EbsnBSEkDLadmQ==
Received: from BN9PR03CA0968.namprd03.prod.outlook.com (2603:10b6:408:109::13)
 by BL0PR12MB2386.namprd12.prod.outlook.com (2603:10b6:207:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:17:35 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::19) by BN9PR03CA0968.outlook.office365.com
 (2603:10b6:408:109::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 12:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 12:17:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Apr
 2022 12:17:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:17:34 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 05:17:30 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v3 2/4] cpufreq: tegra194: add soc data to support multiple soc
Date:   Mon, 4 Apr 2022 17:47:11 +0530
Message-ID: <20220404121713.22461-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404121713.22461-1-sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 451e93d0-be60-48f9-e9aa-08da16351a52
X-MS-TrafficTypeDiagnostic: BL0PR12MB2386:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2386E29AE829C9B90C721FD5B9E59@BL0PR12MB2386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4CTY0e2x1ViWeV5uBL2FHh8bmeaR3Ijg8ymQEi0NCYYVngjaXmKQzK7rmXGm4tqbM6bikJo/L+5YwZb0C05AB+a0+XRSlIAnfEGeYBONtOuNMz4DLvkD1JBZ2SUtc6NV2dCXK8jNyXBDtYgkH45ro7mkydIJSs0alxY5TDbHVhAEFU1PUcqfKmF1aiVxldkCuGYGwKfdE+A3DL4z6DRZQ6+P6EzcmfYx5LVeYLVoFtZb5OTufzRmTy/g2hz6x+MOeArww1c6iAFOh0Iv9F5E5zyl9ykgk6Y9s7swoGQDsxKbxqgZzCQKvpgOpOkpuxz9XLj68wHNYqTJxz2BF2e4fAJQR9CFvdWYoJEkXhHMkJdrQiC/QJftr+LMSJj/xSda01JLRgbQId9MhfrncObq2qYL4OZRmVSxHk3ECZuzCu/rlMxiodm49d6a+SpDNE49NVSkqEJ3xWQwmAP9H1XiSN+s8lZAQTqGS+u2f1mwK2qxVNQmGZUwxYEfDB5Cm7/1kznvT1JyD0sNI1KbGJFpUW532L/XeLdwejOVO6B4dqZm6BXCs6GkJjMfRWzpMk8DgKfGc1JmXrqgRmMItaJFMPnxWw7po59JYbedJuR/OssnLhEJT2souscZf9Zrzdh42JoEz1REJSwZGLdjf8HgmB+xjuV2FP6tXdgRl01tl9UkvkYDDwnfq32cFjBFbNjBgqVuYFVXoQ6nLso//5Z/6uuftw7MdBiAkcRHIWIl5s=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(54906003)(110136005)(6666004)(82310400004)(356005)(921005)(81166007)(70206006)(40460700003)(2616005)(336012)(508600001)(426003)(83380400001)(26005)(186003)(4326008)(8676002)(7696005)(1076003)(107886003)(316002)(2906002)(47076005)(36860700001)(36756003)(86362001)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:17:35.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451e93d0-be60-48f9-e9aa-08da16351a52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding SoC data and ops to support multiple SoC's in same driver.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 142 +++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index ac381db25dbe..2d59b2bd0e1d 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved
+ * Copyright (c) 2020 - 2022, NVIDIA CORPORATION. All rights reserved
  */
 
 #include <linux/cpu.h>
@@ -35,12 +35,6 @@ enum cluster {
 	MAX_CLUSTERS,
 };
 
-struct tegra194_cpufreq_data {
-	void __iomem *regs;
-	size_t num_clusters;
-	struct cpufreq_frequency_table **tables;
-};
-
 struct tegra_cpu_ctr {
 	u32 cpu;
 	u32 coreclk_cnt, last_coreclk_cnt;
@@ -52,13 +46,42 @@ struct read_counters_work {
 	struct tegra_cpu_ctr c;
 };
 
+struct tegra_cpufreq_ops {
+	void (*read_counters)(struct tegra_cpu_ctr *c);
+	void (*set_cpu_ndiv)(struct cpufreq_policy *policy, u64 ndiv);
+	void (*get_cpu_cluster_id)(u32 cpu, u32 *cpuid, u32 *clusterid);
+	int (*get_cpu_ndiv)(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv);
+};
+
+struct tegra_cpufreq_soc {
+	struct tegra_cpufreq_ops *ops;
+	int maxcpus_per_cluster;
+};
+
+struct tegra194_cpufreq_data {
+	void __iomem *regs;
+	size_t num_clusters;
+	struct cpufreq_frequency_table **tables;
+	const struct tegra_cpufreq_soc *soc;
+};
+
 static struct workqueue_struct *read_counters_wq;
 
-static void get_cpu_cluster(void *cluster)
+static void tegra_get_cpu_mpidr(void *mpidr)
 {
-	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+}
+
+static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+{
+	u64 mpidr;
+
+	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
 
-	*((uint32_t *)cluster) = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	if (cpuid)
+		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	if (clusterid)
+		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 }
 
 /*
@@ -85,11 +108,24 @@ static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
 	return nltbl->ref_clk_hz / KHZ * ndiv / (nltbl->pdiv * nltbl->mdiv);
 }
 
+static void tegra194_read_counters(struct tegra_cpu_ctr *c)
+{
+	u64 val;
+
+	val = read_freq_feedback();
+	c->last_refclk_cnt = lower_32_bits(val);
+	c->last_coreclk_cnt = upper_32_bits(val);
+	udelay(US_DELAY);
+	val = read_freq_feedback();
+	c->refclk_cnt = lower_32_bits(val);
+	c->coreclk_cnt = upper_32_bits(val);
+}
+
 static void tegra_read_counters(struct work_struct *work)
 {
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
-	u64 val;
 
 	/*
 	 * ref_clk_counter(32 bit counter) runs on constant clk,
@@ -107,13 +143,7 @@ static void tegra_read_counters(struct work_struct *work)
 					  work);
 	c = &read_counters_work->c;
 
-	val = read_freq_feedback();
-	c->last_refclk_cnt = lower_32_bits(val);
-	c->last_coreclk_cnt = upper_32_bits(val);
-	udelay(US_DELAY);
-	val = read_freq_feedback();
-	c->refclk_cnt = lower_32_bits(val);
-	c->coreclk_cnt = upper_32_bits(val);
+	data->soc->ops->read_counters(c);
 }
 
 /*
@@ -177,7 +207,7 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	return (rate_mhz * KHZ); /* in KHz */
 }
 
-static void get_cpu_ndiv(void *ndiv)
+static void tegra194_get_cpu_ndiv_sysreg(void *ndiv)
 {
 	u64 ndiv_val;
 
@@ -186,30 +216,43 @@ static void get_cpu_ndiv(void *ndiv)
 	*(u64 *)ndiv = ndiv_val;
 }
 
-static void set_cpu_ndiv(void *data)
+static int tegra194_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
+{
+	int ret;
+
+	ret = smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, &ndiv, true);
+
+	return ret;
+}
+
+static void tegra194_set_cpu_ndiv_sysreg(void *data)
 {
-	struct cpufreq_frequency_table *tbl = data;
-	u64 ndiv_val = (u64)tbl->driver_data;
+	u64 ndiv_val = *(u64 *)data;
 
 	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
 }
 
+static void tegra194_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
+{
+	on_each_cpu_mask(policy->cpus, tegra194_set_cpu_ndiv_sysreg, &ndiv, true);
+}
+
 static unsigned int tegra194_get_speed(u32 cpu)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct cpufreq_frequency_table *pos;
+	u32 cpuid, clusterid;
 	unsigned int rate;
 	u64 ndiv;
 	int ret;
-	u32 cl;
 
-	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
+	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
 
 	/* reconstruct actual cpu freq using counters */
 	rate = tegra194_calculate_speed(cpu);
 
 	/* get last written ndiv value */
-	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	ret = data->soc->ops->get_cpu_ndiv(cpu, cpuid, clusterid, &ndiv);
 	if (WARN_ON_ONCE(ret))
 		return rate;
 
@@ -219,7 +262,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	 * to the last written ndiv value from freq_table. This is
 	 * done to return consistent value.
 	 */
-	cpufreq_for_each_valid_entry(pos, data->tables[cl]) {
+	cpufreq_for_each_valid_entry(pos, data->tables[clusterid]) {
 		if (pos->driver_data != ndiv)
 			continue;
 
@@ -237,19 +280,22 @@ static unsigned int tegra194_get_speed(u32 cpu)
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	u32 cpu;
-	u32 cl;
+	int maxcpus_per_cluster = data->soc->maxcpus_per_cluster;
+	u32 start_cpu, cpu;
+	u32 clusterid;
 
-	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
+	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
 
-	if (cl >= data->num_clusters || !data->tables[cl])
+	if (clusterid >= data->num_clusters || !data->tables[clusterid])
 		return -EINVAL;
 
+	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
 	/* set same policy for all cpus in a cluster */
-	for (cpu = (cl * 2); cpu < ((cl + 1) * 2); cpu++)
-		cpumask_set_cpu(cpu, policy->cpus);
-
-	policy->freq_table = data->tables[cl];
+	for (cpu = start_cpu; cpu < (start_cpu + maxcpus_per_cluster); cpu++) {
+		if (cpu_possible(cpu))
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+	policy->freq_table = data->tables[clusterid];
 	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
 
 	return 0;
@@ -259,13 +305,14 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
 	struct cpufreq_frequency_table *tbl = policy->freq_table + index;
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 
 	/*
 	 * Each core writes frequency in per core register. Then both cores
 	 * in a cluster run at same frequency which is the maximum frequency
 	 * request out of the values requested by both cores in that cluster.
 	 */
-	on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
+	data->soc->ops->set_cpu_ndiv(policy, (u64)tbl->driver_data);
 
 	return 0;
 }
@@ -280,6 +327,18 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.attr = cpufreq_generic_attr,
 };
 
+static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
+	.read_counters = tegra194_read_counters,
+	.get_cpu_cluster_id = tegra194_get_cpu_cluster_id,
+	.get_cpu_ndiv = tegra194_get_cpu_ndiv,
+	.set_cpu_ndiv = tegra194_set_cpu_ndiv,
+};
+
+const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
+	.ops = &tegra194_cpufreq_ops,
+	.maxcpus_per_cluster = 2,
+};
+
 static void tegra194_cpufreq_free_resources(void)
 {
 	destroy_workqueue(read_counters_wq);
@@ -359,6 +418,7 @@ init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
 
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
+	const struct tegra_cpufreq_soc *soc;
 	struct tegra194_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
 	int err, i;
@@ -367,6 +427,15 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	soc = of_device_get_match_data(&pdev->dev);
+
+	if (soc->ops && soc->maxcpus_per_cluster) {
+		data->soc = soc;
+	} else {
+		dev_err(&pdev->dev, "soc data missing\n");
+		return -EINVAL;
+	}
+
 	data->num_clusters = MAX_CLUSTERS;
 	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
 				    sizeof(*data->tables), GFP_KERNEL);
@@ -416,10 +485,9 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
-	{ .compatible = "nvidia,tegra194-ccplex", },
+	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
 
 static struct platform_driver tegra194_ccplex_driver = {
 	.driver = {
-- 
2.17.1

