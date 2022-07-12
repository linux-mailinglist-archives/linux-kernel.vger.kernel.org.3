Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C42571F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiGLPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiGLPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:40:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DFDB96A2;
        Tue, 12 Jul 2022 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejplbJfY0+t8ySaHn6vSj2LYBct6TPb7e3sD1Uze2+dNIjvskxAbPR9SpYR4wV52POh5o1r0jG6j84PDx2kKBHNBrWkemW9ARaVEvHBlz+pm9WS0n/rdFKL+Fl2VBnI3DhDSi6DqaW7RSouebqaMseuXttbL1qmiOqxt3ICyIbt3pQFLEUUbv90p8wOInADVH/SQrGPkS4+AKo0O3Shg9oZn+z3gGZIyf6Vtje/d9kxg3dx9d9/A3lvGcHUvZipRuj24IhOe0Ooep1qGSs9puMAFX6kLYGLXHgk3fJzxlg821MlbBzxSCKpJT1VnEFa6p+tqdBxl1wdayMwWcg3qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=hQQLKh5Ap5pNQr1vaMKza0o7ePaUSl2Mg51mfr3EIk71kg0VyxHey/meYCm/+KLYvGANlrviB7i6AEtp+RS6goYcAhkgVBy+/wctGxOa8J3uW0T5Ksndigg4sQLxLNH26USVYsVrrNRDWRXK4iTJNk9SISL9yAuCFW+BJBHN9O5VBytDwJGAoNnDKitvMlglFfTnaX+j0MhjtCqSD1XSIE64XhCK2MO0hNqamx7an6RiLwRv6hsFG8Kl95ip0FuR3SGb7XXeMhotTJ7XCAzIDA0XJVcKKvjLlIc9qn5QUPvde4Y/aVhNUdmncubs2thwLsamE1Y+YqkhBW4QuuhUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=EZJ2Nex0huUtTw1UgKK/QoM0uRLrkJBAVkjLI3Ya53kDzKhNEGHFQIUHC8Nb3vqsQEUis722CY0OdHMqeFZvxCdYI83bDc/4rB2V+qc65IhfgAW2ceznqc0P5zg5wffujlQF5tgwjcxrd4ZvXOK+DFfBqV9JEK0dKa+I/ztp0LA=
Received: from BN9PR03CA0805.namprd03.prod.outlook.com (2603:10b6:408:13f::30)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 15:39:55 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::89) by BN9PR03CA0805.outlook.office365.com
 (2603:10b6:408:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Tue, 12 Jul 2022 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:39:55 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:39:47 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 02/13] cpufreq: amd-pstate: enable AMD Precision Boost mode switch
Date:   Tue, 12 Jul 2022 11:39:36 -0400
Message-ID: <b3db7981e407d5f111eeb27a8504a4ed7979ba60.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8628ba67-8f39-4134-e038-08da641cc4f0
X-MS-TrafficTypeDiagnostic: IA1PR12MB6091:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmdInD08Nw4BCoHORIscfJVnXbE2l7QE57iWQ98kVO7slYlYgXxRWgfeFSbK/tcsAqzmyzAp+IYYecmV64+GvVBFI3j2WEQymJGnihlvyLydWKAavLhXdloevYiSur0hORgALD+I1hedH6wJv91TM7hrv1kAaX72cNo4MOM5hqFMDdWuGrIHu5Fav8r4KeHnNcgIaYRj0Fe2j62uJMoepexyLAlFkypHSNWEJwGtjap+Aq46hPphdMoaPEU4OgntbUZZ25W7bQrBQK+k8GlzoUNAHsPJvBvw6Oe0hKqMTvEVmLxw/uEP0Gud4PQaOcsP0GUTjg8fX3Z9D2EwNW9sM3I9c6TJKZ9ewz0gbgDAsQthHzbu/KEZQA4nZ//GA1GftJ9sSYdVL1twxTmuFDVjC0XhkkyJOVZ/JTWOSlzFYy1EEW0u+N0OGGIOEAssm4PLzEij4zj9C1IvpILLAwCHJAgTdeXUo6JGwuOFImjfUHc0rqhNuLwvR6AUAAejPIJcOuGFm7+wATMABh7cNxaXedLWW/Xrwybm/Qs3u8Pwsqe7aQuM+K09aRE0YDRN66dpjreK+tNEOd8J6Zb/6FKXVp2J9P9i24hVB6L0S52JZFEGButOHuBFL2AG3MYyM7StmgLAiauJVVtmLoXILkebVCKWP3FRyfSTRp3V/O+fKt1zyLbmw9QYJj7UfqZ880i1AI3AZYICh8Odv3dIVEvO06ecAKMJOKoAyQobTGk9W+mZnP44nMromORUOQq5y171XvVG4cVzlS4Px8HJ9c4Ce0JDCef+w69x+PHsfvYmB8kT3JBlw4pIGD+AI16b5Hlx6xsiJ1Ygf9XbSxXXZB7MeLzeuTnyQh64AmeURFnq8m8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(7416002)(83380400001)(356005)(8936002)(5660300002)(2906002)(40480700001)(82740400003)(36860700001)(40460700003)(82310400005)(6636002)(426003)(47076005)(81166007)(86362001)(8676002)(478600001)(110136005)(70206006)(54906003)(186003)(316002)(41300700001)(6666004)(4326008)(26005)(2616005)(336012)(36756003)(7696005)(16526019)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:39:55.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8628ba67-8f39-4134-e038-08da641cc4f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to switch AMD precision boost state to scale cpu max
frequency that will help to improve the processor throughput.

when set boost state to be enabled, user will need to execute below commands,
the CPU will reach absolute maximum performance level or the highest perf which
CPU physical support. This performance level may not be sustainable for
long durations, it will help to improve the IO workload tasks.

* turn on CPU boost state under root
  echo 1 > /sys/devices/system/cpu/cpufreq/boost

If user set boost off,the CPU can reach to the maximum sustained
performance level of the process, that level is the process can maintain
continously working and definitely it can save some power compared to
boost on mode.

* turn off CPU boost state under root
  echo 0 > /sys/devices/system/cpu/cpufreq/boost

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 drivers/cpufreq/amd-pstate.c     | 22 +++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 869508de8269..b952fd6d6916 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -559,6 +559,8 @@
 #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+#define AMD_CPPC_PRECISION_BOOST_BIT	25
+#define AMD_CPPC_PRECISION_BOOST_ENABLED	BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ac75c1cde9c..188e055e24a2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -122,6 +122,7 @@ struct amd_cpudata {
 
 	u64 freq;
 	bool	boost_supported;
+	u64 	cppc_hw_conf_cached;
 };
 
 static inline int pstate_enable(bool enable)
@@ -438,18 +439,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int ret;
+	u64 value;
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EINVAL;
 	}
 
-	if (state)
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
+	if (ret)
+		return ret;
+
+	if (state) {
+		value |= AMD_CPPC_PRECISION_BOOST_ENABLED;
 		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
+	} else {
+		value &= ~AMD_CPPC_PRECISION_BOOST_ENABLED;
 		policy->cpuinfo.max_freq = cpudata->nominal_freq;
-
+	}
 	policy->max = policy->cpuinfo.max_freq;
+	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
+	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, value);
 
 	ret = freq_qos_update_request(&cpudata->req[1],
 				      policy->cpuinfo.max_freq);
@@ -478,6 +488,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
+	u64 value;
 
 	dev = get_cpu_device(policy->cpu);
 	if (!dev)
@@ -542,6 +553,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
+	if (ret)
+		return ret;
+	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
+
 	amd_pstate_boost_init(cpudata);
 
 	return 0;
-- 
2.25.1

