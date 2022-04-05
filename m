Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE94F3F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiDEUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382327AbiDEORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FC160C3A;
        Tue,  5 Apr 2022 06:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h55KPj0vTAC0+uQSP4ltWzU5kq6GmPD6U3rPzmQntlBMXCpRuJmh4bPyxs2xdk245rGp0vZ8QcIASqJct0E39h3BCPqR0MiRfIExuIZ6m+tWQOZo6AeP6hLLC+WoxyS5XOrRWK96DG5GmYPs6Un2T6lL0Dvyh3n7XA3OQ5bXzzwVmSM8ShLgVh0SRB+NdNUG/f55kknsEoK/n/AmH/z2LXXDvYmvyEGKEtbx/LDwkb0weF2k3ex2RbiLtgLT6EZCogNSStg2bWCnbLizXCEDjcXeopOstik2EnY6O6hPICwADVT7HnnBBvMykZwqDzJLbDrwY5DnLgEWgMQQXBdxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=gQBGTKt+dlQlaafUzVSHVdonG0V68fRhYdg8bTa+xpMC83oOww7A3JqIsFA4tsMAAcx/i57+XSvwQyVIOdEseVJL5GRaPnHTT2LbBr6cG75lX74N8K98WOaavy4uBRf6bpRkUK/k2A4UT0Gj1qOkZA37+K2X/9uOrIA3fy5bryPuES3g/SHjkrIndNvM5+14OsaM83M93+uWWdaIIz5WrI/DFX/8uBjfjvfXwmaoaz0cSDCJC8ke624LItjit2lU8k+N65AMkaX5V9nNH4XFh8LXYidXxZ6UGANFRvBdqqFYa72mQ+MLpXfEvGCkf4GIqCaA+3bUjzuuUG8IJ7axOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=ZgZasr3W7WOjwcnpSRzxK4BDXnlIchOTDpbi60p/SLyMzP+fe/wjaX05LhVTzS73Mv6IQ3bmlCGmfdWUOXTHybnX+3sisCI/NPbOEAf3GSkBHIzMwUdlfGzK9Oyta87mWATW0oXi2aRFmq5sSP5m6ArqgK6MQqg9QeJDTF2V/e1wo7q+oESCFA7r4F9h3fEDh1nk0QWUM9QvCyjBn+QOsii8fiwrzVsArnJJotBDVZ2Ei01TtfZVnO76ZwqVP3I2zi+5mWDD9vmsJnFZ/jZPbL/BESI9lmLi6QyvpUOrOi/DDu2goMegbEg1FHbu8WuZwRASmI1XqXgVCVzhElkbNw==
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Tue, 5 Apr 2022 13:01:43 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::62) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 13:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:01:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 13:01:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 06:01:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 06:01:38 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v4 3/4] cpufreq: tegra194: Add support for Tegra234
Date:   Tue, 5 Apr 2022 18:31:18 +0530
Message-ID: <20220405130119.4697-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220405130119.4697-1-sumitg@nvidia.com>
References: <20220405130119.4697-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06afbc8c-f5c3-4d6a-2f9b-08da17046eab
X-MS-TrafficTypeDiagnostic: DS7PR12MB5862:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5862DC6A85D714CE17D38082B9E49@DS7PR12MB5862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5yl9kNog7rKLeApaZenLoj4KsWfYkg0xctt22QsFw8obbr7t1s/V/HFkcgb+6lvkfS6wSFc3Mapn8IaMw42G+9H4PyxjI6dOhIgqdKf2KY3jj6eGdcpl0YfT0Bxch8q1qydYU8NqtmRrLAG7brgo88ukEg9WP5JbYgPO8pgqIVhzE5R6yqd9W+8hYsNxUU8NynZT16dqf4AdaLYwL154ac6kXU0oA/RRze/iOofzlBWBFpwT39YsNX4kOY+CBVVvLSuSZTlkDvFXNLAmo4uza3YfsAL0z01Hf/HtktTteQpKC1sbN6TbzRvgUo0H/6hNA9hIvmgsj0fIqRzsBdmiZV1UP/FPxXCsAMZ+W6NyJxWr3QM2/sjmeDKlY4whJGm8LMemZZ1BdY9FYronTLih1eZJCoYMjzjYNaGFQNi6pXPIFKibNgRrce8VYEJay/zKb3RCLWpilaL7RHF9PsXI9p+iL3idMFhyTikpFO17CLeicTfKzGa507YP7ctAzcyLuBaCJSQNwKWw1mCkD9WpTwU0e4ivkgpcVUHnuyV6hHVRY4gAv/DDZ+dqQnwB+llG3ccOHmap3uf3iJoNsrk5ZjQEiMdK1078hMGSc2nxrW55VUumrylX3k2IiuNxyr7FrTKCePA9gy39VzyFtVnAAkV1rIUWt874Umd6Tn9oIWx7GcpKCZB0bz8XVO9hCLybOwx0ZnZjLVRDNZjhyyTE9EXxT11jxSuITgQMleZRs4=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(47076005)(426003)(336012)(82310400005)(70206006)(70586007)(36860700001)(110136005)(54906003)(8936002)(6666004)(83380400001)(26005)(186003)(4326008)(1076003)(2906002)(5660300002)(86362001)(81166007)(40460700003)(8676002)(316002)(2616005)(107886003)(921005)(508600001)(356005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:01:42.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06afbc8c-f5c3-4d6a-2f9b-08da17046eab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver support for Tegra234 cpufreq.
Tegra234 has per core MMIO registers instead of system registers for
cpu frequency requests and to read the counters for re-constructing
the cpu frequency. Also, MPIDR affinity info in Tegra234 is different
from Tegra194.
Added ops hooks  and soc data for Tegra234. This will help to easily
add variants of Tegra234 and future SoC's which use similar logic to
{get|set} the cpu frequency.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 104 +++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 2d59b2bd0e1d..2a6a98764a8c 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -24,6 +24,17 @@
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
 #define MAX_CNT                 ~0U
 
+#define NDIV_MASK              0x1FF
+
+#define CORE_OFFSET(cpu)			(cpu * 8)
+#define CMU_CLKS_BASE				0x2000
+#define SCRATCH_FREQ_CORE_REG(data, cpu)	(data->regs + CMU_CLKS_BASE + CORE_OFFSET(cpu))
+
+#define MMCRAB_CLUSTER_BASE(cl)			(0x30000 + (cl * 0x10000))
+#define CLUSTER_ACTMON_BASE(data, cl) \
+			(data->regs + (MMCRAB_CLUSTER_BASE(cl) + data->soc->actmon_cntr_base))
+#define CORE_ACTMON_CNTR_REG(data, cl, cpu)	(CLUSTER_ACTMON_BASE(data, cl) + CORE_OFFSET(cpu))
+
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
@@ -56,6 +67,7 @@ struct tegra_cpufreq_ops {
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
 	int maxcpus_per_cluster;
+	phys_addr_t actmon_cntr_base;
 };
 
 struct tegra194_cpufreq_data {
@@ -72,6 +84,90 @@ static void tegra_get_cpu_mpidr(void *mpidr)
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 }
 
+static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+{
+	u64 mpidr;
+
+	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+
+	if (cpuid)
+		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	if (clusterid)
+		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+}
+
+static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	void __iomem *freq_core_reg;
+	u64 mpidr_id;
+
+	/* use physical id to get address of per core frequency register */
+	mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
+	freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
+
+	*ndiv = readl(freq_core_reg) & NDIV_MASK;
+
+	return 0;
+}
+
+static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	void __iomem *freq_core_reg;
+	u32 cpu, cpuid, clusterid;
+	u64 mpidr_id;
+
+	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
+		data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
+
+		/* use physical id to get address of per core frequency register */
+		mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
+		freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
+
+		writel(ndiv, freq_core_reg);
+	}
+}
+
+/*
+ * This register provides access to two counter values with a single
+ * 64-bit read. The counter values are used to determine the average
+ * actual frequency a core has run at over a period of time.
+ *     [63:32] PLLP counter: Counts at fixed frequency (408 MHz)
+ *     [31:0] Core clock counter: Counts on every core clock cycle
+ */
+static void tegra234_read_counters(struct tegra_cpu_ctr *c)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	void __iomem *actmon_reg;
+	u32 cpuid, clusterid;
+	u64 val;
+
+	data->soc->ops->get_cpu_cluster_id(c->cpu, &cpuid, &clusterid);
+	actmon_reg = CORE_ACTMON_CNTR_REG(data, clusterid, cpuid);
+
+	val = readq(actmon_reg);
+	c->last_refclk_cnt = upper_32_bits(val);
+	c->last_coreclk_cnt = lower_32_bits(val);
+	udelay(US_DELAY);
+	val = readq(actmon_reg);
+	c->refclk_cnt = upper_32_bits(val);
+	c->coreclk_cnt = lower_32_bits(val);
+}
+
+static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
+	.read_counters = tegra234_read_counters,
+	.get_cpu_cluster_id = tegra234_get_cpu_cluster_id,
+	.get_cpu_ndiv = tegra234_get_cpu_ndiv,
+	.set_cpu_ndiv = tegra234_set_cpu_ndiv,
+};
+
+const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
+	.ops = &tegra234_cpufreq_ops,
+	.actmon_cntr_base = 0x9000,
+	.maxcpus_per_cluster = 4,
+};
+
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
@@ -442,6 +538,13 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!data->tables)
 		return -ENOMEM;
 
+	if (soc->actmon_cntr_base) {
+		/* mmio registers are used for frequency request and re-construction */
+		data->regs = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(data->regs))
+			return PTR_ERR(data->regs);
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	bpmp = tegra_bpmp_get(&pdev->dev);
@@ -486,6 +589,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
 
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
+	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

