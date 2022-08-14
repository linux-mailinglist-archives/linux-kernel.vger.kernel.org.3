Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520BB5925A9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiHNQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiHNQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:56:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E61DA5E;
        Sun, 14 Aug 2022 09:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTmz8OMy5xWyV5JjnSl7tbV71J6S3fLz619bINBYEJe2CwxbJMsdS6D42OFWYI6jwgefo2SSo0BW79dLdeCsyVQPVYryjhHGP+sI6s3/2hbX+UzZDaJ3+G5NUcjdhi3iTDNpazAePiEUNTVzwqVDq9APKozHsilmsDVnsIEEBH81mHbkByrCGYV7qJhQxsVg1Wcwztbh95AXPHQFGfDG8Ai1NxndcogJXOj8s94DCuUJSxSg4ugY+LkxlDq6CVDU6qsLzmGIqN/czhoTvIpUARyjMUg2TLuNdcfL/FS7dNwU9FrybLCX7chgpxmCEMIGnPnCegzSM4+DuRWnJ+8BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qBvA2wnhY1v8H/ShRaty9HKl6VH2oMHcfg9zbJW9k4=;
 b=hsM1qsyLmyYaSkhy42Pt/id0MN7TlD1LR47QBWTHwcEnzhG1fa7yrpXSC0N1abDs6i9YG29OtTwAMZU4rbGZuDH0YHoWLL70LVoAxK0b5qV/VRzVrHwNDg4XL8VwZJo3Jm09DJuVd4qGJqwXIZfoRG5tv2Z3l4s/No/U5HsmaiK9zlc1n6EGNDiXTQ4CwxZ9wioH8HNW+WXxX/IV0T7tInAptUZHGp7bYZYo6+2qcJM/3GhjQrSCm6nDHNhgACFYEGTUETvCw/1SHwFnogz4iyaqmHobWYAr9Y8FbHX0af2tVALc94SsQ31ONI2B3lHe7e1t8YmF5Dvj8imWDFI8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qBvA2wnhY1v8H/ShRaty9HKl6VH2oMHcfg9zbJW9k4=;
 b=JcTsnhgc1xZLPAHZCWN36yv6Oh6Gh+06JJUCkcKd37qjz+K4rJMlZVnZuAU/v0YJdoYap1g1+qOvhlGElq3BJPGNm7XU+7tVwTr+kNXgNnbHG2Twxw1dNYx5w6wzp7u45dDlEAxGVNlK1xE0wKTRJiK3PpjqLGelSt5FFxuxbl4=
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 14 Aug
 2022 16:46:00 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::1c) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sun, 14 Aug 2022 16:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 16:45:59 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:45:22 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH] cpufreq: amd_pstate: Fix initial highest_perf value
Date:   Mon, 15 Aug 2022 00:44:21 +0800
Message-ID: <20220814164421.330891-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb77fc9-5c39-439b-80b5-08da7e14778f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6oogIbb3pDqXIMbYQD2bWspBkf96G9bjaMCCFWXsvPxmnAHQQfqIfZjAjRHkwW51UXjB54YRS69ptcDlg4les4eq1nsnSHrh3kL5iyk1ydzqG38Z8sU0k1XtCB1eriRRzbf4Zk/Sbfn9AOGvxfLm1ZIh8ojau3OAy+nyyQ93ms0k2CCOmywZ6GOlb8BJdSWVSwJhgYfVihxRPSQlfqW9FuAYcpcXLYIFLwXFxaPtjLi5+cvtSQN/uUrQWWj4cuJSJmAlETePDKTwBMLgvlm7swZbh4MffGWfPEGRPDYKgD3FHucL8c+uk8ikcv9GssOMv4PFJcz5lw5Anwr3xwzX2V1peVlMncWYBrl7hIQWqgbgLM3B7KaDS6yGEZNH7JDWnTEuztQAuLPrwLHeFTaI1OLCrOLJ9tpNPbZJ09LvOIBjW2hkEquAxmx2i/E91bGzLhYR70D5ZAzYXlcJytW3EWm27edn1JIvu6UaPOZMcPGAN8g4XPaDKzJ+2bEQ5wNDWixVFqGSJOj9e35U13AZJCAD94cxtv8SPMFZ3nQaTMWK2ZleUSSfW/Y/KGr48WNRKrQKhuCLHmB0SnmqmY7sS3wIJ98dVXS0IzWz7eOrEK9FfXy171jjFBfiwuop6ExOMG/DWctNOXa9GS4Aitoc6j9D/Bx3ylfMEBfzRJyrrRWCY1/Cu00eRKCygKCnjIhdX2snVzk99eBdOb/vf1RB/qPcdl+IbYVd+sSLodNV98cY08HD3ajDCTwCSP38JyE8ejyJFcoTHkQWBmHWEIi/R3g9eeW/baZBSbS7rYlnalZL/ziVQFUNsOIhPt9sVxeIrQxkpbhcS7hmDOvpbMMLkrCkN2bm38eMcl8d52IHH0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(70586007)(8936002)(8676002)(4326008)(26005)(70206006)(41300700001)(2906002)(5660300002)(478600001)(7696005)(47076005)(336012)(426003)(16526019)(186003)(40460700003)(83380400001)(86362001)(1076003)(2616005)(82740400003)(82310400005)(36756003)(81166007)(356005)(316002)(36860700001)(40480700001)(54906003)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:45:59.4810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb77fc9-5c39-439b-80b5-08da7e14778f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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
index 9f4375f7ab46..f778ab37e436 100644
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
+		highest_perf = cppc_perf.nominal_perf;
+
+	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
-- 
2.34.1

