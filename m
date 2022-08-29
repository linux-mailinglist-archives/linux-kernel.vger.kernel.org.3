Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42B5A42D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiH2F7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2F7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:59:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172E22B1D;
        Sun, 28 Aug 2022 22:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqUe7Gc/5Vtvf4WoYRHvZv3NrmsmQqJjFfTHqckD2w6UIPcXFqG0hqHTRfzCPFnUwZ9mfF73k22aV1y8sCDNHjm+m6068OL1Kd7wrHtraYYrAogEDc7NtwATC4eGbK8diN48VhXSUy3LlemXCupiKSG/3ZTVz270IAWQhxxlB2Sy8NNahHVnMl6QSLedUrk0/11hFzo+4n41zUyVxeFG2LO8uHGAhoNN3d3okvrsuiYCj3K+XJtWgKhjJHHivlpQ9tp1XRMbGMKm/yWyze0qFxCipyDEbaawJJ7bnaQXD0kSnk37Yy+xExpNv+0UCrcTmS1Wl53giJOC87e5XTx8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+scjsiX664wyq5ZEUKjsz1yHeoIahnpddeJCtxAkTO8=;
 b=cvaLKVOW6au4HroE0mdryVmHkZzGRjKbB8GPWzZd8N5jIkQZQxWMeXgf25dyFDFG4UwUbQfYucLIqzqlxeSNTpngln9CC36SFu02bTeM5fUF+aAB9uLLumUuTPf9cqrzRQu9I26k+CspNEx3YeCIjvqsEMRPFVf+US1hnRNSSXNTWae3FZqI3FltlGtZJ+pLUkTtUBAMOxbuRD0cBOZDQSYOZEwzGx/ndMeMOTSjImYnk95R6kV14Ef1y4F+pqtbi8xGwVOWx4oGjHw6xyhuxik0qIPnMS8LR43MMFEAsd/ugsUiaZZbfjqO8vakN1E7EPBX8uY7jUobPwxrRnIMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+scjsiX664wyq5ZEUKjsz1yHeoIahnpddeJCtxAkTO8=;
 b=fblSg2c4TIJzLuWKX7stY3RqpxFm9KWoKL5c5Y58RqUcOCf+FNLryUbeQkAzlgYFlgvp0dHPgf0lbBl56QxaGe5VMbanDjGWwM2MpuunEE5DEHnze+ip/8FqsBs/iKtWvGLelYNo8uGePRQ5R4FvRdBo7PR1GuOATG68dxKjCvo=
Received: from MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18)
 by BN6PR1201MB0163.namprd12.prod.outlook.com (2603:10b6:405:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 05:59:35 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89::4) by MW4PR04CA0283.outlook.office365.com
 (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Mon, 29 Aug 2022 05:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 05:59:34 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 00:59:29 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf value
Date:   Mon, 29 Aug 2022 13:59:01 +0800
Message-ID: <20220829055901.24593-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1ac5674-4fb3-4fd3-d83c-08da8983a5eb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbSbSngI8MJkuffBLYjtTcdvtQsrzoaZhg0bofIm/VrZ+7sTh1iogXAcVCaSgRlzvKf8EtGvK8z7yy5O58GUkE41LC1AU9T7h5fGoFkdHmF/XdnkATcS+e7t+QNVANR/GBgHEz6CV+fB+FUpDUqRQK2dAykXcpMW69d1+KSsuCLPnzXV5oSFCUYc4HWSSmArOY09t84goGs2UAiGQwLl3IYOWNcOuiRsjkJhDFpCMG1M/quBAQmnRyoXOqWJF0UkcJtHoeNlufu4lvr/nnGPCLcxIxwYLfdL8vqrrlzOahq6f86DD9z501v/pxoCqlBCbh/5c/U4QW9tqogDh1w6KLMoy/SghSq+HmpUwuWL58BhPZBnP5Hh1a1iKvAEROSEfey8TOdoJjkzs2tqjAAwnQOJ+io+hSEe1tqVX9WBfKRdYaKw8Nfonrgqb1XKZbvCINFhLGyedDJ+/oSlGdZD/5qcgiA/7sw8giu+eZuIkCbWOGjNwT/gKmLE8c0kohmGZKJz+IMksynbQeAGAKcX+gxctW+gZyMlDkuD0UmX8gDXblaTjaKbB276TWqLhqmNLrimXzf6MFHH4SNRIClOZGJzudBOpYvtwNEJ2t1ZMSJW3pzWE2KQqXC7NBShlq3UOm/Nec4PAsKJP2eZE9ruCQMTNnrfCm2vNQYFGDth9tRI+ZRPco+h8ws4hzMyDsS4A0HERe7MB2UIznGW6SI45Rq2w8saWNqBxHME/3uhGwYslyZj/dXuLD2LLoJ8IOBOBdv8l9FGDlx46Sej872Cxn3wvVKGbuQ/yLjO3uvk5K0soByz4I12SZsiXvTiioDQdudR9aqbwhE3hIE13ndatg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(40470700004)(36840700001)(41300700001)(8936002)(7696005)(6666004)(26005)(478600001)(40460700003)(86362001)(356005)(82740400003)(40480700001)(36756003)(82310400005)(81166007)(2906002)(83380400001)(47076005)(336012)(16526019)(36860700001)(2616005)(186003)(426003)(1076003)(8676002)(70586007)(70206006)(5660300002)(4326008)(110136005)(316002)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 05:59:34.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ac5674-4fb3-4fd3-d83c-08da8983a5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid some new AMD processors use wrong highest perf when amd pstate
driver loaded, this fix will query the highest perf from MSR register
MSR_AMD_CPPC_CAP1 and cppc_acpi interface firstly, then compare with the
highest perf value got by calling amd_get_highest_perf() function.

The lower value will be the correct highest perf we need to use.
Otherwise the CPU max MHz will be incorrect if the
amd_get_highest_perf() did not cover the new process family and model ID.

Like this lscpu info, the max frequency is incorrect.

Vendor ID:               AuthenticAMD
    Socket(s):           1
    Stepping:            2
    CPU max MHz:         5410.0000
    CPU min MHz:         400.0000
    BogoMIPS:            5600.54

Fixes: 3743d55b289c2 (x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations)
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9f4375f7ab46..30fbd30c0949 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -354,6 +354,7 @@ static inline int amd_pstate_enable(bool enable)
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
+	u32 highest_perf;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -365,7 +366,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	 *
 	 * CPPC entry doesn't indicate the highest performance in some ASICs.
 	 */
-	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
+		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
+
+	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
@@ -377,12 +382,17 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 static int cppc_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u32 highest_perf;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > cppc_perf.highest_perf)
+		highest_perf = cppc_perf.highest_perf;
+
+	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
-- 
2.34.1

