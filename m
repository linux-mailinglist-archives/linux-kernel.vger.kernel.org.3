Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901914BFD01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiBVPgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiBVPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:36:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A8164D2E;
        Tue, 22 Feb 2022 07:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK2Jv28KTxEpDleSbjEVIlTvCI7KT5jwDBrS0FN10X//MsNg4MHQ+2DWRXwrBM+iFFYoYixiMxC1OMmA3LhrrBIuy47bNpToR/KoW/+YmzpjqlpKfdD308fINTXDttVprQRe340Rcxi2lBv9U6Y/U4/+0Rq9yh2/E2Uet/ymMc/VZQbN1gKhlYj3S4qlRgv1696cEG4GCBgKlP6bCPshlOyH77fO0RBsea5QmvFRzXiyP9IAcjIb9ublGwVoW0WqxeQUuzJcPHYmxnuy4Pp9nqnugJ4SMtdCEFO4urlhYqAzU6ZzL+MM38j3YptRJ6da5PzH8iK8FwYI8n58TPWyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HL/SAV/WHo81zRVKFOYyDSgxHhmuNxe0NctIGASBKU=;
 b=lJzBcl+rAVGfc6A5cDZJweeb3TeJW2JkrjyY4LoD3PtdZFyKVexwWTUu7fW5Iovv713Mp22eXy3rSoz4usu8asiBoaJqvOYujkLDYdx8viATNb688rNPW+PR0UnVpHoAuuEcVWniRBgD2ddfFtJfMUVLg3m4yKUVVYvubqq29T5pKAeNluflaGom/pQ1/vKngkw+1vEbnfxqtg9yiNJsfzuUpW6Tf1mCS0rkyyB/Kh51b3pq1XugtWoxJpytzIwiBCXhsqV4O9JvwXg0YUSVjrwqI2siRY1NWCQemO8kAbqpzSF4yUXhFOfzjt7J113M1/rY74kA9QDvI8LIgX/xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HL/SAV/WHo81zRVKFOYyDSgxHhmuNxe0NctIGASBKU=;
 b=CnbAuBqGRcd234RPzYrfe0PJUTO1C8bqw6eUfAOeobagXpLk8zaA3SHuAnpjClvJXx9E492TB9slvHq9H6pdxAgfPIGwBV2O7dl+BelKf7pMzdJ55z+15WyXjJ4U+z4qWc5R0iUPYluruqWrJrW9/Ko9hrp4D/2E8uleN2mac2o=
Received: from DM5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:3:13f::34)
 by MW2PR12MB2474.namprd12.prod.outlook.com (2603:10b6:907:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 15:35:39 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::12) by DM5PR17CA0072.outlook.office365.com
 (2603:10b6:3:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:38 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:33 -0600
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
Subject: [PATCH v7 10/10] cpupower: Add "perf" option to print AMD P-State information
Date:   Tue, 22 Feb 2022 23:34:26 +0800
Message-ID: <20220222153426.2216974-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 137bd525-880d-4405-ddea-08d9f618fa35
X-MS-TrafficTypeDiagnostic: MW2PR12MB2474:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB247459500D5AC551ED34512EEC3B9@MW2PR12MB2474.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dev52UD9Y0CEc2JMkbW8iHZWMIJYLkgYXSI4gysgk9FYN76iW09pPZchVfDbf5jHxdw1ZU2h43GKylJYJLHeWAY5y3SQ0MuZoxY0D2VWI6qkp/z48iJDLH+EcBltva09p4kOr0zeH0jkScXxJjcWScKi5ct5WHEkNvuUWRIRaQTQzWwYNQ7ziCSXrhS8cs4DaO4U2DszeL3VpK90JyKaArZBBMOzIsnMlAXQv06QNvbVWIwVRLl78A9tPT1r3QXMytUhOY+4GioZr+BTQkKQHhJ2eGY95dl2ZKm41cBj9L/UCcPE9ZWJUV+05mD5smlcK4mNrYGTwJL4qK8jbclgq7Ds+G0adAULbxYARIYf7Tk7D/OjWwgmP+gI/bNAR47lV/M/zwjqR3STKMv+SY5BksRUWU2IfoLXdd+o4PAMVyyCh1TJgdwj9avMqbqWU7dFtR5CuKLBaXry30eyXbzIE/pUmjJZnxajCDSU9AyCwYFpt9riNr1FFFW9wttQS4ino4aMK5QHasrDHSVAzXwWapgROoNrQ9AXL4sewhi5HwZv0UqzO/VIekwkpk7c1mNiXMTPiqNqw0RSB4+IHCT/FjQrXDgrdhj5ptHNB9iqhsJobx61Hc4+aV58tfy0L047Z5D0QQmcw6KbdtoXBs8rtSlagbmCBUz/NrrDdYLnGwJh8nWmVADRiJ7C+QBYdP0Uc2fEuJrE6PJII/9gCuzOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(316002)(54906003)(508600001)(47076005)(8936002)(40460700003)(2616005)(36756003)(7696005)(70586007)(110136005)(4326008)(426003)(7416002)(82310400004)(86362001)(336012)(186003)(26005)(16526019)(1076003)(36860700001)(81166007)(83380400001)(70206006)(8676002)(5660300002)(356005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:38.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137bd525-880d-4405-ddea-08d9f618fa35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-r --perf" option in cpupower-frequency-info to get the performance
and frequency values for AMD P-State.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../cpupower/man/cpupower-frequency-info.1    |  3 +++
 tools/power/cpupower/utils/cpufreq-info.c     | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 6aa8d239dff9..dd545b499480 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -53,6 +53,9 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
 \fB\-n\fR \fB\-\-no-rounding\fR
 Output frequencies and latencies without rounding off values.
 .TP  
+\fB\-c\fR \fB\-\-perf\fR
+Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
+.TP
 .SH "REMARKS"
 .LP 
 By default only values of core zero are displayed. How to display settings of
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 235243ec5ce0..0646f615fe2d 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -438,6 +438,17 @@ static int get_latency(unsigned int cpu, unsigned int human)
 	return 0;
 }
 
+/* --performance / -c */
+
+static int get_perf_cap(unsigned int cpu)
+{
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE)
+		amd_pstate_show_perf_and_freq(cpu, no_rounding);
+
+	return 0;
+}
+
 static void debug_output_one(unsigned int cpu)
 {
 	struct cpufreq_available_frequencies *freqs;
@@ -466,6 +477,7 @@ static void debug_output_one(unsigned int cpu)
 	if (get_freq_hardware(cpu, 1) < 0)
 		get_freq_kernel(cpu, 1);
 	get_boost_mode(cpu);
+	get_perf_cap(cpu);
 }
 
 static struct option info_opts[] = {
@@ -484,6 +496,7 @@ static struct option info_opts[] = {
 	{"proc",	 no_argument,		 NULL,	 'o'},
 	{"human",	 no_argument,		 NULL,	 'm'},
 	{"no-rounding", no_argument,	 NULL,	 'n'},
+	{"performance", no_argument,	 NULL,	 'c'},
 	{ },
 };
 
@@ -497,7 +510,7 @@ int cmd_freq_info(int argc, char **argv)
 	int output_param = 0;
 
 	do {
-		ret = getopt_long(argc, argv, "oefwldpgrasmybn", info_opts,
+		ret = getopt_long(argc, argv, "oefwldpgrasmybnc", info_opts,
 				  NULL);
 		switch (ret) {
 		case '?':
@@ -520,6 +533,7 @@ int cmd_freq_info(int argc, char **argv)
 		case 'e':
 		case 's':
 		case 'y':
+		case 'c':
 			if (output_param) {
 				output_param = -1;
 				cont = 0;
@@ -626,6 +640,9 @@ int cmd_freq_info(int argc, char **argv)
 		case 'y':
 			ret = get_latency(cpu, human);
 			break;
+		case 'c':
+			ret = get_perf_cap(cpu);
+			break;
 		}
 		if (ret)
 			return ret;
-- 
2.25.1

