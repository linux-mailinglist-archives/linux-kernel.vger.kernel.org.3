Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC64DB20B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiCPOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiCPOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:00:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06166CA0;
        Wed, 16 Mar 2022 06:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btUNMUkSwgbhnYNoZXhBGvVpLKkXQZshA29sDySbNBcLIR6pYppXCSn2NtBvOnr9qRAfc6cO0VIeHMAwngL2nQoHfAB/PLRrqDUyFPlgyxTQ0Siz85LOQMDSim2ynsjb/Hw0TCp7xrISuLGl0duLYyDNJ8Obj68nXkwLM0qhiU+HXsD2IXxLL3gr5VemVwSNjtVQvdLjPDR3qizdHUxokf5l2dTSBB87kFap1o+SqRoQvZ9IkG9CTGqfU4qO4N+QdWoUSDjpl3CzVw4pq8So4Q92auksLdm4Ilvo7hkT3Ud3+UtR39RtqN7nxTzqAlIfSFEjE/5o0ZNSh0hXH3tEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=UkmBTUWsvUIUZ7O76mAZq3+aa9AvkPElM3q+FjSkwzXboHTMnG/f0e5i7FI8fkdnws1sz40H9B+bypZHFJJcnlKyTbJRUKKpImFX+75xjzFs4FyQiZ8nLlQ7cGRW+hC0MRN9X4D4WygV5ZNRTvlV88ygVyUFi8jM1pX0TW7aNwlt6cJZWjFoO+2gZtzB4/cLWwcqN43O4k/uSF1c975Xi7941Xvu3Ca3/eVUxpK7Ezp4xtdEwa3IXknyqFuZ3QDh/7VkY+xPzITFaaZuLUARFGpm6Jah+isaFykWToFpe+KoleRy5H0GqPBtn3Zz6diFSn7hlv0bbEb5PiF0BDf4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaSt2YuyCgTMOz8xoVKQnbq/RKA9LOyWJI5LPUGvaFQ=;
 b=oJInX4Tyl3+Q5WYvo3pdqxmp1v8Hs8I94nzEWs5qmqIoYeVmkqI8+EHWvLsTzJH9wE+kaq6kJCQU3/IzlPWvkzj6Ic7Kpt5Ktisj+0mCpbF18HsfSy4ySB1P7Vt3VIiqz7xjsZg/M7JiQHRkZXfhbc0VnY0Ew5tzHEDFlmhsKtX0YsBtm50ZAXqOIYjRrQACuHaaDC06/8HDf3xTwktsqVM/uf5c+tKriGl+y3MX2NGLXhEb/raJFSenlgsPgFxIpVbGvqDSFmHN9TkXW3JWk9Vljhcq3VUSAn4yuBvkI8Wf5b2LDkcdW13O42FxXdIYiJwcWwNQT0ADzvVKM2tLfw==
Received: from MWHPR14CA0010.namprd14.prod.outlook.com (2603:10b6:300:ae::20)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:58:49 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::f9) by MWHPR14CA0010.outlook.office365.com
 (2603:10b6:300:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 13:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 13:58:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 13:58:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 06:58:47 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 06:58:43 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v1 1/3] cpufreq: tegra194: add soc data to support multiple soc
Date:   Wed, 16 Mar 2022 19:28:29 +0530
Message-ID: <20220316135831.900-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316135831.900-1-sumitg@nvidia.com>
References: <20220316135831.900-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a8929f-2d4d-4d81-a2a7-08da075518b1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4293:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4293C22A5A46EA22C19B5E22B9119@CH2PR12MB4293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5nwtx+OxLUrtDRhHbHFSREN9LG/PmZ6NIrj/xH0zcP2aTnAbLJsGZOzzg1tfonFz+Qh8oCj29pDlFeifBoRlcoR5lwhv5dEhtkmhDsOqEW3yzChu9gR3D0xRSWyB2WUfq4JGtmCZ7dJHmAMxOWrt8fUrKgHx3hu560eRf2zdnIEXFqThvdulGtTpPslFqR2VhxpXj44F0wA1gaykvMHQbfMN9tcvFttE1Vg88/IrluUxxWCkM7wJuJReuAUt+WLmjFKu+wBoqCOvHU+0og+3mINsM4b5dcBRBd0v1OcdEDfnD+Ng7a8QUysDaNAj+bnO3VTN69juFeHe/gMMJETnmWkDTadaWWErrp6FhtJSQU13d4R+ZTsFg5dnkFOmjqtz44zNzD4doY+Qa2jiPnEEOcMKxRY5UHjeVqE86f2cju6nYzrAa0uadpwC9rcH+o9ClqhFjPwplhv7iMH4K0PLGvqp3TGQKR9MAJY1rJLE6jfTAnS2DdnlmwZanlLKM3qm3PtmPifZgQlsDJOH2xqKyZ02hqZ+Rxng45kCUbchyv9NOxhpu8AqiHFYJioZo+8nb5ZEBtQ6+rwEtE+Jj+030AJcf5MshZHjSz40A3VJKcDitiwO5Qud7I46cCyN8k3bmHF2Segv/mAAn2LvhLcQnxKiYzZE0c37Xw9tmlbPW4Kp3Gn1jD3NndNI/CFtB32fMLl7+dxwDqjlZxerMsmOPZyuLsJLQPr1VupMt5Y88M=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(110136005)(8936002)(921005)(316002)(356005)(2906002)(54906003)(81166007)(70206006)(70586007)(5660300002)(82310400004)(8676002)(4326008)(47076005)(6666004)(107886003)(26005)(186003)(336012)(426003)(1076003)(2616005)(83380400001)(40460700003)(36860700001)(508600001)(7696005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:58:49.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a8929f-2d4d-4d81-a2a7-08da075518b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

