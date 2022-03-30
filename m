Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E24EC6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347013AbiC3Olp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiC3Olm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:41:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F81F53B54;
        Wed, 30 Mar 2022 07:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVuNKVccDao4KKLJj81mcJnOZEknM6xw0xcWblWc7FENj/jBs64mHEf/dbYKEOGzcmvYJwz1erYMlcGyENCtlS4+5XDuOjlUeaOGPYpx9qxchanHMFkhlTVr4vxbawp0aNORkdWhJrKMlrbAdWgeUFo3SKnzml3qgJdCFeTj6pyiCwFKpm1ncay6+ZiIky8KDqGPPnnKDtMQgBHFOkssSM6/MED4ReDkyYP/gSmUSbG5jKJp1wM6XA51tQPoSiJI5ra83Hl/Ve0YNblKulEDRN7LH+TO59x1HkO19w425FOIQ5JVsNsGzfLNqaou8w8/fBAwY2Ad7FUmFJKMQGmfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=leViL+OzNtprXi9TISdZl2a8p1rEk6aC0KZIxnuUvctQhMSXMJtG3YPOD+5S6j6eRezjci1m6fgOAC/2jVDuBcIkK5RQ/oSwEDX8pH6LzDUOtkK6iddUFGAqLlhHMp4Mtb7EMS5FFRG88vQ/F/Pk5BAVIeljAD9WovqjROzCetyWYBi221G6RHhn+EpeARF50p4kR2mWpPljT5ygv783BXyaxg0Z9/9NBhdnw1STR9uba+jUzxn8iHWeC/onkta5vZOPS7SMdnleHr4tvbbOMdnfPgqNjWbVI8pgVmlgZpdvRdD+lFiAFcZY5dGa8J0Sho3AGtQnzZagm/jaHxgtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=s7hIqWY8NC2tHLWA88xkdeqosAamlZewdNV3jrElNnCrUN1pRK6YpHKt/K2uze0wcy0TrR2yiCmUsqPb6DFJ76OO0uWlDWh3i8jOMXg2mHVxnwzOZGGARUSUnPDu0yVtm8cY6m/rFUdRydYTUrLOuDvGJwOmZz2vLZNDXT5qGp+9DR5l3Z6+kRA4uESFztapo7hgZqvjj4gA4RI3uR4u1FImNWzgoCTJqTLbFc4l7a3yX0h0ZlHQIxVB2FdXfb6foKifjtV75xCk/kwV2x4I9/AP7yRXuDJm9BEhubEeCA85pNbOre3P3IEi176Wzl5SExtTMy8Ds+A/azFgbBrQTA==
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 14:38:55 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::35) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 14:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 14:38:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 14:38:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 07:38:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 30 Mar 2022 07:38:49 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2 4/4] cpufreq: tegra194: Add support for Tegra234
Date:   Wed, 30 Mar 2022 20:08:19 +0530
Message-ID: <20220330143819.27476-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330143819.27476-1-sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee475d2-38b3-462b-7e52-08da125b044e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2481DDAC2768C257EFA439C7B91F9@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBUaeK0jUv42I0674uzDX/aXQZw2ksn2sTwr1xOA8tJMo/dMsr06d7izQTV+LoEXUAgJ+49KFFu+8+qDpYbfkrjitEUIezi4Bk/ByVbmsWy0jaQ4VYL80IHMhsRhA6omKtklFDCHt6eeeQK/oTYTmU+kQyuj/4FbmoZShfnxeK0M/jwNWIvpxnRQ8RDEClJpxz9TuUa4HCsaWyBOUyUeN8L5gItNejdXa2y/mo8rjQA2tUqn+3VJ3AYxgKp1zgj45ESxb5QDXlCuwH10doczrRNjIitNq0BLgyj1+voa03HPe6cuUZXWOBsq9u3cRcvfaetRYw6LQJcA+qTqV7zlxhslb1R9AIWNSUgoc560xngd3tktbXRRcBCnoFG8vLEiM0QH2e8DvJ8E8N6x0TC+NrKpkd+jedzBFydYQDoKD13TJdxIgD3jilGLKJLlx7WXjTlIr/RkFSLF9+wifHYuZz9lDP/7nK9rIDb7FNxo2NQDCesYJqkQ/OUVrJaHbaRRlKB6KhyCM9O2HB9y0WQbXaWYIJmgHJoJw2Cq893SuMF7kEnR3lKRWp4+6gt8OPDaTL+DpuuG1zJ75pfJpaDIvnhAuZ1bAWJwVQ1wefcYnng4GgQq5troUpuo7K0XN/QK96tDxEuqi14vPngQ5+cDoQ96zd0pcLuvBiPqhbuvqOyBKHK51OWhNGzx1/dR10B2hFqFHdYEkJnsq0112YzyXYPTTr7xD6GI7CiY+F5Sm5I=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(70206006)(2616005)(921005)(107886003)(82310400004)(70586007)(356005)(8676002)(1076003)(47076005)(6666004)(81166007)(7696005)(4326008)(2906002)(83380400001)(40460700003)(110136005)(186003)(316002)(36756003)(26005)(336012)(86362001)(5660300002)(54906003)(36860700001)(426003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:38:54.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee475d2-38b3-462b-7e52-08da125b044e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

