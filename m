Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D744EC6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbiC3Oke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346960AbiC3Oka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:40:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22595372F;
        Wed, 30 Mar 2022 07:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwSJZ5Y6yIoUXdaZ7ZFlLugipSz/e0EOCi3v8xwkzVu2LbHEGvo6El3IuW8NGp+pmohB4k4pGZYol9UDO23r3Rw+kaNF8F95rPitoEWD9k2s40NQANSIpcFfgmYnyXCdu/NeHS0f0EwnRjGdy73HIq9n4NvZTwgL25mu+1uUHuYxvigq5Fa10eIf8mBUXn4n2OrnIMvMvtzfVUlpIUdRToU5G14Fz/7iQJ4u8MmvrjCOX3i+VoYNFV1nud37YIe25yQ3JxbgnztPlYz3iGvdPoeVbni9qrekGrHb7D0/75nleSoM85zNf3f8fq6UE87jxGuhPDJpdCj+yvpH5xL2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=Yg2qbaZfcT3NyJsoGUNE3ifdMiqhBrjujkwiHNbvrI73O0qlQAlhqnqwmkreQfhBCQ/e6E5MqOYzc4EyibZs7AE1PyYVc2+da1NGPOdakcb/iUPW4sMHpL+DPelkMs9QT/ismfzVqOzU/WETjXOVi/wAKaxxA7CezuymN3yEsPY+7hmwTxVRR6li1AVSbRtOkwKsrnn6hHiLjgQ2xMAHGnX/l1zkPhqvMTQqNM5sZO5VwD0Ai2wXwiAmZPIsG5aDcJ+UoyFq7xuJZanOYdSf6/r8vh8ajWBy1qwHXz0u0EYsZzQz13nF5ZNvoZdjkTRQHg6j896c6qSCmGIVOIoFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=Z4znYpVlV3WekZ0rkAXaZGGKZsaL7RnDZluYd3GPSiyV239KF32VwprMdhuZv3nr6poA6kVm7wtzR3Peb/o86rPuO9p2zNUYA16papiIbLgwDmVaoSgHw8MXOjEg8ZncIbCnfuflR7rKrUy1LhmSb+PIxMEaVIIYeOvI2JpobV1pYcVbW0uyeCOhAwAzHyoXrS/6xtRiWcGmPHV0b0Ycv6dRtrm+Oz7wuS5U7VhByM/ww52yocHQ3e6lS19Ft3dd6W3MeNL36meen1P1LtAaUb+FXtWJJorydq46rtO4KF4VwtCdjyUAnfdH//xXNkLCy1Rz6U7AL0S6ldDvq+KxIQ==
Received: from MW4PR04CA0371.namprd04.prod.outlook.com (2603:10b6:303:81::16)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 14:38:42 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::3f) by MW4PR04CA0371.outlook.office365.com
 (2603:10b6:303:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 14:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 14:38:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 14:38:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 07:38:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 30 Mar 2022 07:38:37 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2 1/4] cpufreq: tegra194: add soc data to support multiple soc
Date:   Wed, 30 Mar 2022 20:08:16 +0530
Message-ID: <20220330143819.27476-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330143819.27476-1-sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d0141bc-13cb-4c65-eb12-08da125afcdf
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0037:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0037EB15F6EFA69C40DF67F1B91F9@CY4PR1201MB0037.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ChG0pVc3ELovR/aw4WxPUbC7UmII6gr2mJIH+gLliqAwMAuJpjxQ848+Ryi9z7lrcum3f5pxnGzGoMJvnsJiu3AQebo5kO0ylrb0phzGknlg8wGiRVrX8GZq0UNC8cLZZ6VPu39D0OblAsM2biK6hpS4hDGrtJ/Cc525vIZ/OrmtRCKxnKbSyDFjEuKyXdhVmfDd4XEhwiYW0nSGB6LrUFhN+l9ic5XT0P+UxdoYfznaJFZdLOvomRCPJ/C0JjoxYdbHji173Uw5B4smjsSUKpFsmZhHnclIqhYUQux3OljLRXKhvTxskdEtuY29sLnFwIsxt7qUl97hCGZLsadn5bYV/XWbDVJS7vO0FxNl1G2gZDNwoyTQ7P9PoDTyYv6WVGMRFtxj3yZm/sOe8hwpIBeDiPVkMxiSRY48DVsuPYYrBlkFNzo/VTdTqe69G+S7YFCwAOmlCFGRYvFlbhStW5piX6xcmAuDOXDAcUmx/3oB1uKb/fsVo3vhijkSjEgLz9eJASn3NI9Btq7GleRv8Vs6KuXmc2ABjUq81lWTBxbGjO3K9fby6k90yCjW3WQg9qNwAWok4/VZwCvBtFh/TxCv0LqO5rENNbcF5+H9QluVylcZrwAhh2sLmhLmScsL5r+jc4c5DlsvM6BGEHXK+GS6k3/HCrWKVrrRnDJJrDgNeo5N0K6b/AxD5Q0EYwzQmhfQ3k3CkrzbZ6NEXselzDWXqPmX9X376xIkuYTfmM=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(36756003)(336012)(426003)(186003)(36860700001)(47076005)(356005)(83380400001)(81166007)(107886003)(1076003)(26005)(2616005)(921005)(54906003)(4326008)(86362001)(70206006)(316002)(5660300002)(2906002)(8676002)(7696005)(8936002)(70586007)(6666004)(508600001)(82310400004)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:38:42.3830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0141bc-13cb-4c65-eb12-08da125afcdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

