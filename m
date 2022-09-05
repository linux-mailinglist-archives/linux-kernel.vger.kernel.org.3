Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765645AD704
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIEP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIEP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:58:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298D412616;
        Mon,  5 Sep 2022 08:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBORDRsz5kGle9Y3bP1Gu/hpK/nuzq4n0cH15n3ZtVDGNWLY3AaAuV24Apa+HFqrDN5b1EQt5NJTblO1rMxF8AhzaWVDYqm39LsPXkzqfltZgfd26ZgW8URn3zYJvOqU/WBvdLrZRnb0T14a+8I/gHNPAbvpJx7m+RLJRRfSppmsBIgwkSas7zcOLJwM9ARaJzqemT+QYmK9Og0ybFv9V8nQd/YvGUIYyrZ4CxCiNyPxyiRazaGmMHbYCndoqDtpm+XiNyEwr7D+TTzzc7Vm3KJJ6oVEGUgkT8SphxB7DEcvFMoERMxwWKtBaNDXY7iuP6jdCw8lKc4N4BtnfP+/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFqqqRjkdG2e3v/z334g1131NoYzU4caX8u9JyR6s+E=;
 b=BiuRqu+H5PJdCQJZpSHejptEfTnJtup+YfoJLZJkrvyzivgZKEprFmjBNLcbuuMs8yyLo3v55i0NGYvZXz1w3Yc/Lxgz6Lr9k7DiEog9cxuycjuEKb8KTYayvRH2MOgjwrAXAgNLBlD0rabOmyAQi6UbxgdGQ2QqFp5baQt61YhSt5I9rWjjoXHAuDa1fbruORRP7uezhljMTUUKYeAWO9BOoLI0iKaekHchUgM25btSFyy7nctejrek0sZsl9d/nBzvnZlthv7Ilfp7HI9zfOHYiYVQa5sSFWFuiJtyGByChKPJ6muA/DlnSNpxSSjyV1CAbBFFF8noe6awfM96oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFqqqRjkdG2e3v/z334g1131NoYzU4caX8u9JyR6s+E=;
 b=Wg6kCRRtjnE+6SEZrhHQts9q6W4QSK2vgVb157J1Z5kN7HhzDPo5PSN+ORMxMyfTq6vJLS/81ybQ4YaD54MQ24VCKyf1plHF4iXuGjLdR+y9dg7nhDFITw19+pljS80xyVNfQY+mEi/tsDa3hYrrFlgHWDdQ6YENBkPH0us0P8ar/ejsQv8dLcdDdMrnjxEjL741wGLrkdGu03I1ED9SMB0gc0Q+RV7pzN64wptWCP02JfFE3pzC2S5tqWYAnkpNOZdWNaIWRF2vDzGSJWdEnZHTyuZdYg2Gh380leN2WA2nMbXX/8wv5i65j2JkdzDrz8Omrk2UlPd83oXWKxa05A==
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Mon, 5 Sep 2022 15:58:10 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b5) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 15:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 15:58:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 5 Sep 2022 15:58:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 5 Sep 2022 08:58:08 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 5 Sep 2022 08:58:06 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>
Subject: [Patch] cpufreq: tegra239: Add support for T239
Date:   Mon, 5 Sep 2022 21:27:59 +0530
Message-ID: <20220905155759.17743-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a045fc-e8e1-4239-2edf-08da8f576e4c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ampBNxy0GcY3dAGq9fDpiaaGGHjaYxyd7vc8VuoEHA3rcQo5Zmt9mQmXy2ZKaNo6yVHqQ8kdOn65mz65lmaOffSFwk9XTA+/qfxmJg8WT4S06W2Fe2xkNGyxxkAhk/qPoOIRtXwhV2jPmB7I+a4rvgeieYA5QazxTGzNr1lPJXJhC/KXhKuOtkxGFJ7qonXauMIlVMsp46S8uIaoS9gTLbbKwGK9LDqwArsgLRV7Y9SFc2jOCcV7QQErQHcG96N2ySUrGkAMyc6K/a9nIAQRG3SbvQBjFMF2QjSNKTPqJmS3vVanrLlCtkGMdzXpPyvWzyCAt7A5uU15wPxjEonWLJCybPYIERgWR+l/oqdkaN2BQcDWEMopyY4IiH5YVNB+os4qaD9lju0QsrQNq34jLBuzFq12fwK3LjU+pj9wOXNBm7iqHtrw85ujO+m02EL58Mw23spB2FBSPyh62JmksWvj6qLbXYBvJYFpYwmire7ocW6L3yOb82CyN8Qz6E6IzFHAHr+9L+aMEimPDduOcrRjgfmGVGJeCG0IvWmi8eCijBCMwkRG6k8YQZnUXlu1X4r8uc7XrEVgJfO8A2vKrGS168sQ8DAujUh6Bo43dzXqtuIahuWpIyY75S2lgme1aZdkb61Fu3rts5H3YIEAkK9vuKwSd960e4tA2AwEPwX4mPPKESpzaCZnJvCm6p2Y4AYR18ETUqfVGffY8atalVQGyZPxMqFpiYZII3fPXB2IdEss40CqFkD4q4JdHHjFNLtRoMW3CfPdQI5fDZgKM8SD5TreKQksNoLh9ncLua5J9I1FjykkAuncEAVYlu0a
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(107886003)(7696005)(26005)(6666004)(478600001)(41300700001)(47076005)(83380400001)(426003)(5660300002)(336012)(2906002)(2616005)(8936002)(40480700001)(82310400005)(40460700003)(54906003)(110136005)(186003)(1076003)(70206006)(4326008)(8676002)(70586007)(36756003)(82740400003)(86362001)(81166007)(356005)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 15:58:10.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a045fc-e8e1-4239-2edf-08da8f576e4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Tegra239 SoC which has eight cores in
a single cluster. Also, moving num_clusters to soc data
to avoid over allocating memory for four clusters always.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 1216046cf4c2..f38a760da61b 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -38,14 +38,6 @@
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
-enum cluster {
-	CLUSTER0,
-	CLUSTER1,
-	CLUSTER2,
-	CLUSTER3,
-	MAX_CLUSTERS,
-};
-
 struct tegra_cpu_ctr {
 	u32 cpu;
 	u32 coreclk_cnt, last_coreclk_cnt;
@@ -67,12 +59,12 @@ struct tegra_cpufreq_ops {
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
 	int maxcpus_per_cluster;
+	size_t num_clusters;
 	phys_addr_t actmon_cntr_base;
 };
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
-	size_t num_clusters;
 	struct cpufreq_frequency_table **tables;
 	const struct tegra_cpufreq_soc *soc;
 };
@@ -166,6 +158,14 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
+	.num_clusters = 3,
+};
+
+const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
+	.ops = &tegra234_cpufreq_ops,
+	.actmon_cntr_base = 0x4000,
+	.maxcpus_per_cluster = 8,
+	.num_clusters = 1,
 };
 
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
@@ -382,7 +382,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 
 	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
 
-	if (clusterid >= data->num_clusters || !data->tables[clusterid])
+	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
 		return -EINVAL;
 
 	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
@@ -433,6 +433,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
 	.maxcpus_per_cluster = 2,
+	.num_clusters = 4,
 };
 
 static void tegra194_cpufreq_free_resources(void)
@@ -525,15 +526,14 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
 		return -EINVAL;
 	}
 
-	data->num_clusters = MAX_CLUSTERS;
-	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
+	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
 				    sizeof(*data->tables), GFP_KERNEL);
 	if (!data->tables)
 		return -ENOMEM;
@@ -558,7 +558,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		goto put_bpmp;
 	}
 
-	for (i = 0; i < data->num_clusters; i++) {
+	for (i = 0; i < data->soc->num_clusters; i++) {
 		data->tables[i] = init_freq_table(pdev, bpmp, i);
 		if (IS_ERR(data->tables[i])) {
 			err = PTR_ERR(data->tables[i]);
@@ -590,6 +590,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
+	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

