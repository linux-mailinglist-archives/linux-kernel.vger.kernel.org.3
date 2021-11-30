Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217F84634AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhK3Mmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:55 -0500
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:4065
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241976AbhK3MmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:42:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs93IRIABLFWHOo6sWaVwfu0YNYRNOz812xrye9jq+d/4q8+Jiq5Mn6oU2cJ9rRt1uhyM8k9viiXdSGFo7cpnab7VNT/s6IDBYs1/MYHK9dO6dvt2rLh3oN8ZSxXpYXpNf7f0caAixBA6in7P6HMl7KfR7fqIP7NF7+w4zZ6nWTiwG14RCrzTugERqsaOP0KS2Q15EXhky3FdQBRnJhzg6IVE/OG0Lp3UyZ1ZzaRwurJGTzAESEue6YeXU7CXrdMVX4QWf9rYntpCy0UHqyfz6ol86TeZC4RgIXfZXFu9HamiwexUUWgdK4kUEtbovim+pdn/iUuucZbOcQsUWvysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfLxVQRzjwsSqbRDBQgrmnDJa48dVM0mI0y6dk5QTYk=;
 b=Qonqyp/9g7WA5QLZhA5LN9loLQjJtWxGISbSOmW4Q6C1wbK1F7VMZpAabOC5bBszVaPeIzxcBa3GTmithvJahkBHl6bhqPCl/8YbCCaV7kD3nQwQPqhZ6O/bAhiMbw06yQJ52eG0QAy00fokhmLFFB9SHN681OqGUDTvy6WXw8IwrltinB8PgRbT2Ye91o6zcyFMQHmPtpVdMUYLXpLzTUfSDiH6aJBbDCMO50X/PAnPt9nnFHArao6aPuxjrmMWEFMHlLax0r/rLw5uQFcJxYstnoEdomlwaZOgV/TPAg6BEfBtWkU4GXPRyzp8FUrG+28sa/47pcm4B1UQDV8uVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfLxVQRzjwsSqbRDBQgrmnDJa48dVM0mI0y6dk5QTYk=;
 b=RCoidPUNNDoW537K293UxeRH44TuDxTyuZ93szwmzFUsVfmM4gOctbhml59gGtEymvS1/PD8nH4bUIclIIjXns9WpYBrkoLE5R+N+IeeScHo96s0jUjB8/2HH7ZhH9Pm9kKxNPxiqwTSSoWCsSP8AGw4Fu+FhT7S8ijEHzu0nVU=
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 12:38:37 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::2d) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:36 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:32 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 21/22] cpupower: print amd-pstate information on cpupower
Date:   Tue, 30 Nov 2021 20:36:40 +0800
Message-ID: <20211130123641.1449041-22-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bebddf80-2139-474c-c36e-08d9b3fe5466
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00627F939F81EA19E4376C48EC679@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o78OyRIZBxwVqQpcDbJ9X43Sv1A0W+E3fYL9AHxTX96hW+99MenD4SrKrCEi0OpMffp5X56kPR6ltwV+e9mx0SEUE/Mb57nR17n1qYha8erlUmxYkH4RTCOblcsgVNodv5NB0oEwxSIZDt7bEcO5iiRxhNh2z9YxmARv4cw1N8EQ0yOV2VglJDoE20DJhV3wnc7P317gVwedjWzOM9vWGtniBNNS3g9zkIw9M754xYsMviYVDeO80nLHC3lN1dxcHoras2x2Pw0+3xE2nwp96LYlhe/0pYwSPYme3e9d86dY0Mu/k3H/qCwLmAERpQnn4w/5nmrpSYdaG+t57Ci1QswWwJKURykFt6K0vnmJOrS+UmAEDiEgr+mSGzT4IrUufEWkQfhn6NG6ngEqpGSMM1kL9x0xHOwucnCRE/fNxXFEPtcQkoq4hZVfvLaa3EOEdFqEPLbR4mRLcrQfaAW70Ab2Hi4gzi99o5CDluZ6N0FZu+5W9oa0mhrla/4TAd6Fj7NeeOR1qjcDBDypIaoTrH1adodfatUDjjee8hD9G6UC/ZjZl219MzN3cvqRk84GGPQtcdcC13zIwhUkrzWgWPc0cfb6T098Mo1+2DEmHu07z9YwwmNipJKQwd+aDf2J7eCLA48Sya+oGukwzaTi75HqVWuMzjGWgGXBp9nrl65mFuppERnEs2Mq2nEXdz1eWHDJKaNX5vMTdv71UIWBYwrz0Sa8lSKpKH9gLsYkqP5VtNZKjXnwrLgMPzS+gODC3WsKnvIbBYQEsmgkSq0joa0kS5aw+xHWvvnyxC2WDEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(110136005)(2616005)(508600001)(86362001)(83380400001)(54906003)(2906002)(8676002)(16526019)(6666004)(47076005)(336012)(36860700001)(70586007)(426003)(70206006)(8936002)(5660300002)(1076003)(316002)(7416002)(4326008)(356005)(82310400004)(36756003)(81166007)(26005)(186003)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:36.8272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bebddf80-2139-474c-c36e-08d9b3fe5466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate kernel module is using the fine grain frequency instead of
acpi hardware pstate. So the performance and frequency values should be
printed in frequency-info.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |  9 ++++---
 tools/power/cpupower/utils/helpers/amd.c     | 28 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 ++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index b429454bf3ae..f828f3c35a6f 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -146,9 +146,12 @@ static int get_boost_mode_x86(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	     cpupower_cpu_info.family >= 0x10) ||
-	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_show_perf_and_freq(cpu, no_rounding);
+	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+		    cpupower_cpu_info.family >= 0x10) ||
+		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index bde6065cabf4..a1115891d76d 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -193,5 +193,33 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
 
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
+	/* If boost isn't active, the cpuinfo_max doesn't indicate real max
+	 * frequency. So we read it back from amd-pstate sysfs entry.
+	 */
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ), no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Nominal Performance: %lu. Nominal Frequency: "),
+	       acpi_cppc_get_data(cpu, NOMINAL_PERF));
+	print_speed(acpi_cppc_get_data(cpu, NOMINAL_FREQ) * 1000,
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_NONLINEAR_PERF));
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_FREQ),
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Performance: %lu. Lowest Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_PERF));
+	print_speed(acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000, no_rounding);
+	printf(".\n");
+}
+
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index fbbfa6047c83..5f6862502dbf 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -142,6 +142,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 extern bool cpupower_amd_pstate_enabled(void);
 extern void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active);
+extern void amd_pstate_show_perf_and_freq(unsigned int cpu,
+					  int no_rounding);
 
 /* AMD P-States stuff **************************/
 
@@ -182,6 +184,9 @@ static inline bool cpupower_amd_pstate_enabled(void)
 static void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active)
 { return; }
+static inline void amd_pstate_show_perf_and_freq(unsigned int cpu,
+						 int no_rounding)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
-- 
2.25.1

