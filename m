Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB68F4BFCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiBVPgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiBVPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:36:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C1163D75;
        Tue, 22 Feb 2022 07:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeAz3sPNNER3HKeAedHZc5IL60MtX3L/bdGSZTzB5FNJH1tVbIWhT7XVUAw9LLzwoNE7OFyi7jTLDWki8QOcLLkuHjlMQTGf1FQNg4qxZA6OGqxqhOYkk0KuaBTwOz7TfNy8PGrr5R0tFQD+nAzdkiD0ATrP15Tbc8KBplOdgSoxozfGdk/krOJMPuJKGRba0oOfM6Nb0na3Pz0RbQ/iOLxCcishg8+JkmdU36md7i3/jUeVBzEQQAhPqUAP3pwSI2NaAF9J7kPIfCUP3DKy77sf00eqspj/x9C1Dk/zhbfRWIQwfjhcoGDbMigk7IHFVcTe2cv2GVP5D2K80r6xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epeeg02BuMnxNEbUPrAQ+z3CF1R0ncvHQPRNW0S56J8=;
 b=TQ7d6qzPpTLPebzc/OXsf8RZQT+/E/QG8NhGn6WeXA/KnX4LhifucIML3KskIOe2bmgfUvd5G1dsAK+hCAlPPkhAYHj/cKG9CBv2LvUN6H4LNq6yI3cJcfBhGMltG+YF7nSRxN2ICcWccxcgoF7xbDuJYN0JT69LLOSNyoxx0xCfNtCBcmkwkOJLQJqBU0id/sZwXhoyqZtBHuMlsLducdB+KGzljeyVPXgnd9SzugyXPKJHWOkF+6tLq5aF/9nsOebaxm8ZTFDRLyAAYGLhFz9Ko4+mvpZN9/+IQqlUrfka9Gdh1HMhlzKbWqQ0ee1zV91Gu5uNFVYyHGKgKjdWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epeeg02BuMnxNEbUPrAQ+z3CF1R0ncvHQPRNW0S56J8=;
 b=QlOYXfzCu39umAB1Q9H+muxideB+4B20o6Flsvwb6V0WYbiXUeoxIe4ScHmsPKVOhUZeLCTNvlb7/ByJjcqK7SQl2oFDmQ0j/ItNT4P6yxkbbphTHLrK0vqUi3BuvCXZdrfbOineakvYeChNcb3HyrrursyZg7AeTxflFEVu0Jg=
Received: from DM5PR07CA0030.namprd07.prod.outlook.com (2603:10b6:3:16::16) by
 MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 15:35:34 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::c2) by DM5PR07CA0030.outlook.office365.com
 (2603:10b6:3:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:33 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:28 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 09/10] cpupower: Add function to print AMD P-State performance capabilities
Date:   Tue, 22 Feb 2022 23:34:25 +0800
Message-ID: <20220222153426.2216974-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c313cdf-fdbd-4d5e-c873-08d9f618f765
X-MS-TrafficTypeDiagnostic: MN0PR12MB5978:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB59783DBA8BA2ED14D8973C7EEC3B9@MN0PR12MB5978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMVUez9j1LF4rrItoCOvjNPmPzJR1tDIyym/q8xRkmMqSrXK+9XLmlaON2EFG0Juftk6TwGNvxfB5y7lHi4QHwyhxD88kyuieNOW1vMh6MwCe7f8b8IPhwii7S+CRd053arMyh8OmpJuxfF+7P2fgIXyOXryK+uMRmNdUT68QbBA7M4XlUceRia88D03yqvfj+2oN6HlAu7+wpSjl2DJkm/wDpPYHW+RwI++ABZAtPTgou8wicPRJu1Z4iGbOJPXRGcHCXRs41M6iGsdfeFyFTrcK4OuJyX09tkDQAMKT0bTmYYJ3vfQceZuLXB3vzAlxQ8aq6VM0PPEKfTYf6SZmHmi+ZIKd7oEm4C8zjAkBcWEn7utg+XfleZ6mM7ymHhOw/5Kc55AR0Du6nk71qJo4qSFkGw9YALm0Rgo3mU4v4TCJ1KEJX369TU13gJ242V/27FUi/aWNUdGSy4pVgdr6Um3yQ5wiL6jDGYLdC1887IFSabLRAdpiQWNSy1J3Hx4j9ZdKeZoFrNJL80/0tZVXrYjjoZ+Y3+2VA2bcPV/++7LikLyw8XsMBb0yDFHZAHDTX7VO6BmfxkXFBz+odJ2P54/hra81UdmrcmsLWDcG4itrAkee/XlTpOPMFSJwJ84JMTMdQmFGQ/b/x3iWzDBlWhyB8qBPtAOmtM+PJYRoAodL6jzaogMJhZW9ODNJllH4Is2X+kgznbw8GjudF149Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(356005)(186003)(1076003)(6666004)(40460700003)(47076005)(54906003)(110136005)(2906002)(83380400001)(81166007)(86362001)(8936002)(36756003)(336012)(16526019)(82310400004)(316002)(508600001)(36860700001)(7416002)(2616005)(5660300002)(7696005)(426003)(8676002)(70206006)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:33.8832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c313cdf-fdbd-4d5e-c873-08d9f618f765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD P-State kernel module is using the fine grain frequency instead of
acpi hardware pstate. So add a function to print performance and
frequency values.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |  9 ++++--
 tools/power/cpupower/utils/helpers/amd.c     | 29 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 ++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index b429454bf3ae..235243ec5ce0 100644
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
+		return 0;
+	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+		    cpupower_cpu_info.family >= 0x10) ||
+		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index f5ba528dc7db..c519cc89c97f 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -193,5 +193,34 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
 
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
+	/*
+	 * If boost isn't active, the cpuinfo_max doesn't indicate real max
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
 /* AMD P-State Helper Functions ************************************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index fa2a8c1b1d26..96e4bede078b 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -142,6 +142,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 bool cpupower_amd_pstate_enabled(void);
 void amd_pstate_boost_init(unsigned int cpu,
 			   int *support, int *active);
+void amd_pstate_show_perf_and_freq(unsigned int cpu,
+				   int no_rounding);
 
 /* AMD P-State stuff **************************/
 
@@ -182,6 +184,9 @@ static inline bool cpupower_amd_pstate_enabled(void)
 static inline void amd_pstate_boost_init(unsigned int cpu, int *support,
 					 int *active)
 {}
+static inline void amd_pstate_show_perf_and_freq(unsigned int cpu,
+						 int no_rounding)
+{}
 
 /* cpuid and cpuinfo helpers  **************************/
 
-- 
2.25.1

