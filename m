Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687AB4F14A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiDDMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbiDDMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724113DF9;
        Mon,  4 Apr 2022 05:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIRS8/jQ+TM/Axt7Ax29ikFVpsxtyyXoWJ0NcpdXbMC4xhI4hMVdd0okY2vAlf4H5sUoxzwVRTn0+cXmQRDX6eD1HqOwaFXfE7xL1adp5590EV5aDx/VknRFLcFdlIKcA4FexfXM1KwDwZUFjlfN/OcSMs84e2ibuQvWftBd5AbGzlY8U03Fh2vYseKg3+10g4PqEoEQ+6OIakCvil4mrZxKIXFAD0P5Yg7adsfneDvQKU9LMWTGfl+ChpHIhVPn4RINR6OUWNsDdZgHqVUprISLKjuK6cZmypBf0+BBSgowukA+N4WlcCCnSqkPlxxtay6nfsb8gvdPhlqxNeQhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=FYq4dR/8r9S/7MH9TaPXLLCuNb0iiE4GSzWbIL2ZM7+7eJzz5knJPwJ6hE//dp1wAQSYh5nGG3NRvQAgDq+/YLnWCk4a0Ob9cACDcbXliirg7ndFu7PrNY7uqgeWXnbrgWkC0KNPMqLbkR/D64u19Q8U2FGJyycCz80IvlWMkoS3pQDlCl0q5VH422Iuf0E1qDJ92JJA8MDKMJH4yVeHPQJwUtbgPU+YnwDxyp/EIVb6Qsk5X3j+2Cw0JFB+7pI2TWjwTUV3bKkgbEq5Bi2xovOvIlRD7hp/duA2pPpCdL64cKIehZQ2VEAX+G09gj1aNK9dA0dWsrxgCrIZeXUPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc4iAL8TXxvbp7/DyB/nsLSUrz912sWCvcI8+//F0VU=;
 b=sDMI6/kUsm+4ACkpajqa1bKgcvpy++UCpnspW/4zU7Pp6yibIAgPHesPdELC3whFJYCLN4uwAqbKVUpGe8vQDbAL5s7UbDO184X+5780cT8PmrGMIPBqkOIf0aUsq8B1soEeAKl9VwjerS+vHrihzWplHZpXye+GKWFh1QSTjWSlOOUuU0z7eHUiPM52Sq9GQvkkRogk15lKgZWREHPiMypjpgwZO2qDde4rXJPTb18gLViUbyq+QmTWpPQd4Suehu98iFHHlhmSByBF8gYUDyqr2dMwYfMSa/YLynS1Q9BJ31tjkfFsf6gP7CUKmWqFJ0ZZYg3ZC1O8NOWry14NgA==
Received: from MW2PR2101CA0011.namprd21.prod.outlook.com (2603:10b6:302:1::24)
 by BY5PR12MB3650.namprd12.prod.outlook.com (2603:10b6:a03:1a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:17:41 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::14) by MW2PR2101CA0011.outlook.office365.com
 (2603:10b6:302:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.4 via Frontend
 Transport; Mon, 4 Apr 2022 12:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 12:17:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Apr
 2022 12:17:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:17:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 4 Apr 2022 05:17:35 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v3 3/4] cpufreq: tegra194: Add support for Tegra234
Date:   Mon, 4 Apr 2022 17:47:12 +0530
Message-ID: <20220404121713.22461-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404121713.22461-1-sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c0c040-4a4a-4859-7a80-08da16351d5d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3650:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3650FDEC45CC46EE52DB9C05B9E59@BY5PR12MB3650.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sycV4V4Nk/Q14LfqaP9tpSptVenmR+mpECOahIfLffWWn4OG/R3bYpJ3Sp0Czx5tdQhwKek7uXMJJjiNJgBao44QPJ8Ubuu7Rk5F1ga9ZybCtsAuMYAbR1HqloueFvS+ToJ2dR4BUilxmk8Hz1rQZy7zLgcE0YUHy5eHtOLooNzo6TyDqtsorSPEgq468xcls5fc/WwBF8zV2hdb+52sQSwQqgEMhdQ5BjVenhPDK8E/SbjcG/A1S2WJU2YHdf0rLNnw5iBeJmIYTiwQG+AbNrKy1SyO197noTn7VYtezMK9nYbvjBL+NaZmoc27AqNlC/bGblsUANgnQ/hyYYRXMLRVxgckge7qhQ8XoZ3Xk3tL497l38wHlJhSe5fQ1osDoHKcw/m96G4AFvEMSmU0ATtWVrsRNmgFbQBBz0QoC32reD04TmeSUvFXTSHk5IV4dFgj90kGlxen38SvVvtPkyUU35XdwRNNrRsV2JQ1favL5uMv3q/1F+7DXMCqx12TAXUJOllG4Brr920gm+qbu5DmLvTBjbLf5X9FEshGSIoOR74p9gvIgStW9cfoWSQ46bYvztRTF24sFT1F93ndNxNLjBQv27g0UNgrYzumURJ2K0/ryKhhT83Z6OyQSVVeG7TlryA6oh0AoB+PBTntXT1PfIRQIi2/WTLupl1Ysxdqeoxwl+VlHXXrWqL1hSG6yQVSzCex0WMPB6fnVccq2OP2iNwopuvIdmp3x3vixQ=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(107886003)(70206006)(70586007)(1076003)(26005)(186003)(83380400001)(36756003)(86362001)(508600001)(316002)(6666004)(54906003)(110136005)(7696005)(426003)(336012)(82310400004)(36860700001)(81166007)(921005)(356005)(5660300002)(8936002)(40460700003)(47076005)(8676002)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:17:40.6996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c0c040-4a4a-4859-7a80-08da16351d5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3650
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

