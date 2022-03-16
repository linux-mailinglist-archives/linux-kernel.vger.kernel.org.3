Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B334DB20D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbiCPOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356395AbiCPOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:00:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8800443F1;
        Wed, 16 Mar 2022 06:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKh5jG+khcYfwkZqDM0NWMe6TlG16KK2Vv3RciOIZ+LyZfMZ4QZl9HEsh8E4N8UMKJM7FDbNvQ0XjxPerso/oBNObZ0SIWFCJaWpvsiQScZhQrUQlwUYyu64O+uS2yf1ExhbfR+2pRyety+6BgXsbqa6wajr6Htv2JSML1DPtYJZSKY+H8atOnQGSnrOFXIgU22H63AdV5GS8z0ohOETK2Dg/uyFdEZn2OnyUMm33HBkMIEC7B3jx34CVSLqZeslU5QXRL0xtUerBrPYYRoEeQ4aTsoffC3rP4qgEq7tWpqF/hFAU1afK7PWy22vqiEDJqL5OSKfLcQ/Xv/voju17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjGna8v4bnh52VWGQIdvcj8kzLJ8QGi0ODbLx6zVlTY=;
 b=JGnjrL5dvvzeLKvoS4qJ+oJ8NCvice+vKS0Wm8qFS0bzGp7a9CjOet8slWiFFmGfbN2MYaw1PjJCO9Zq1KitpVMB1nM8huE/i2/Z+xXjCZm3dvfT8YRZw94N4MMzAyDsX8PskkBWA6l9bNFFd6+N5yVTE6nG6vett1fbbYZZMzJH22CZvfxJ9MwiB367rR3Y+8i29YI9e6Y7WeNmkxnmSp9gfTB3t+h58luxFZ3bWufCJNLZN3Jm6Dp84vNBlIVNF6mjpY6WOEV7021UOZfRe/3RC/BbdRorWhi95b+gYfsNWzhFSplDR0pWVm7o/5oQfua2brO3NWcQcXN968+hYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjGna8v4bnh52VWGQIdvcj8kzLJ8QGi0ODbLx6zVlTY=;
 b=cFPoZjFIC24WVPDefknk+0yVMuPfj1yYuCNqW20q+7gJERh+Df2pCjR++D6RLvbBeRazMTfp/gzzPZ1NhP2v4KjLQv4aiJnTx29DLAe1n6qwxTyBzK3Gnq2Iq+DzteUMnejk1SaWsC4894adR2QxAObyjgCIZ1FNozL9iE9sICXLqhVK4rQenQg1FstlwuPMNvdvHUcszc7Y6/BXSUfmrej4dfWRcUJgBEi/DKCvMkg1U43AHrmfBw7toi0UgEn6s22J757qm5lnn942lMlm/kdWVxlWf1DSeyhAYNvipnB9ARMvl75M17mkcq/bKV5sf+qeo2S6+s34yfAlXlNtNg==
Received: from DM5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:3:117::17)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 13:59:01 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::bb) by DM5PR13CA0055.outlook.office365.com
 (2603:10b6:3:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Wed, 16 Mar 2022 13:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 13:59:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 13:59:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 06:58:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 06:58:54 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v1 3/3] cpufreq: tegra194: Add support for Tegra234
Date:   Wed, 16 Mar 2022 19:28:31 +0530
Message-ID: <20220316135831.900-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316135831.900-1-sumitg@nvidia.com>
References: <20220316135831.900-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c32d092-4ddc-432a-5f5f-08da07551f92
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5119244F844BAF3276052DF4B9119@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YvcD0gnT0WDBRAr94Os74WsaNdpud3yyQABynJIrQwbyDFW+TQ5umS+nXwUAEFW15pZ8lt5lCqxlK9b5hughOSlfwlnJLuqT7yQ5Ii+2nEd9lLPYc1iXS4EOmv9a1/yBZDLKPTnaRbfPr3wiDMWJtpXgjCLHJYfdexNw3COhm1sMr9miicO315IVSd0ktXzMUl3QZSbXiGE/r0LdBmFDSC1nVfSnL00+q25USVolDWhr2NecbH5wnvti0zfry9rFPHlU168NUi8uPXWO878O3pvTvmkhoL53RcHHWJ3h+sjhoq3L2aeMpRL+8JKQfpfp5hrrTyKjEXmActiNyh+sWW7QlNT1cGzXow8e29+TgiAzDZ+0JFCsLPdFlX6Qq0YW/m5r1tZSHod+qZ+ttKNqw4iubNW1qk3FNmnmwhamBY7BYTITF+pVUcEEOZA+Vqj0ZoPgyB2DTlrPG5IEKAfljtAcxbIsj6AOZ1FbEVaRkWwNHC7A+y+phdHfTMNDThUNtFl+orOW4IUMeQHiWdvtSK9rNhaQiQih4u7XZ3faigkg9ghiujxkXkpqwkCAviqE5+WNgeSZ4Ex888MB6Ip3qO9unvak/wmFEHV3PnY+38lVMHOMPJ6QiESXZBq/74/vAlMyTAVHH+6MqKj5ClCe5G9t4MBl3/c3xnhh58iyYYLc7VPiBbqlruxHvemE1FO6YqEAQPjUotsCgEzisXYDF4u93PmZsx3Tzd9kpJuZPE=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(86362001)(110136005)(426003)(336012)(82310400004)(5660300002)(40460700003)(8936002)(107886003)(1076003)(54906003)(186003)(81166007)(921005)(356005)(4326008)(508600001)(26005)(70206006)(8676002)(70586007)(6666004)(316002)(7696005)(2906002)(83380400001)(36756003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:59:00.8553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c32d092-4ddc-432a-5f5f-08da07551f92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 2d59b2bd0e1d..6b944d00c35a 100644
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
 
+	if (of_device_is_compatible(pdev->dev.of_node, "nvidia,tegra234-ccplex-cluster")) {
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

