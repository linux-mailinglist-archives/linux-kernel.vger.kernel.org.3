Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14F56A8B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiGGQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:55:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5F11D335;
        Thu,  7 Jul 2022 09:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRRgHLikBi/dXAgUX5JzoxuGvwHkH2eK3aHr/Fj2C01sVUF9wJlyWe46spABlI/pDean1g2L7xFTEcZd3e8l9N6CX1R5pi3PmLemJn4R25MkrBRExUsEGlqXOYF8H9s7Sn/x61q2y6QpW4TtkBcvNFApuT6NI4cU4+3HqTPCYTu7cqD2MDEY4HcfLCkSik4TQO8x1XV1YLNfVWZPnMb8eSQGjRIfvWtpwRFsQthJgDrMfVG5Snnk3/tCkfmAGFDZSi/do/52NRWNPzA9zcOihrGmJq5pScPvQSlHXrpsTB5imkNhRN0fpOKg8sN7Py9yO/Uk5W9O/idS4HEg3cMPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=WMxwQlHI/F8NdBCBoSl+52UOgiawNypMbdfXMhmmm98PC8PikqdpRCq3YPcFdINA2HpFAsN4XG4/L7PPfLAypcsB3AOrm5Ca2/P7GX0ogY1mZEGzDVmYNRs3G9qIM/G1ZOnTM3pHtkrCP6RW4+j6QYxmagZBgVFEwGFesjZAl2fmto7Eb+s/kRk2hc0aEQw07fWvOugDB73ui5V5rsGlAxJ2WVpke9bF7QVrvAtIepRVe/d04iRqc89cTrC6+sIUD22tDhQC57mYFHaq2BEdiDMrskF8QnojmK8rh1EtYYHAV9xzfkKm8WS6kcK/IWKFS2CiICY9baCH0qwiePQAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=aGquq+dbGnnAzbUhdSfb7ZiS6MX883syOZpztsor+5XLIFXW/NwGMo2SnGjJoHWAUd3ca4gVbx+2j3MfzTg74r+kpYeshwOg6oODuT0mps+BoATuPnDVRt7WYzkpcgGouG0qIJJP7NP9+M1PuCcqMv6p4sJqrp1fWd9IJVBxXvY=
Received: from BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::17)
 by CY4PR12MB1416.namprd12.prod.outlook.com (2603:10b6:903:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 16:55:48 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::ba) by BN9P223CA0012.outlook.office365.com
 (2603:10b6:408:10b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 16:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 16:55:47 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:55:40 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>
Subject: [PATCH 02/12] cpufreq: amd-pstate: enable AMD Precision Boost mode switch
Date:   Thu, 7 Jul 2022 12:55:21 -0400
Message-ID: <20220707165522.212990-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e440c9b4-e136-4bb6-e215-08da60398a5d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tCIUVGvmgusYDmk5/HMVr+tVNSehD6/srb/IR7pJAWatVSTzplAKy6ofMt2uoYjWScbzc5MSFEC/+yXSCVjYExUONOauTSg8vvnGlDebZFIfk43FA9eiz6l82tHk71NkUZCvmNnxNmwKP3YYTy5KRZ2pxAuD0UvDSCjA9iYPhdP39kYmn9KaC8QxYNPVJDikfhhunZCLx/I4z44haC1RbHz18bT5Fval7b/GjQkIdC4UYcNNMi4aE1GyLLYRockuEmExIL8BvLwhQ9K6P/peCRnl8ixytgWFRSd2JhGy+Ehr1lNoZf7ul0wsUpxG4tu1p4PrD4nNgb/JJdfelushEW1Vlnm+Xu73z44qWwvydT/X6DwuCYfmXFSf11mX4LNZZq3WXokQ6lhK+Lq+OUvIc8BG/theH0g9xzJIPrtqxJvkxxEGk/xFXykfzmh1SpnGHTWOB9coEV25izNi3MhS3bvaBM7tyfyxLnHSkTdPQB1/aCzsAo5AspN1nFVPan+tdNf1O8cbrxjCTLRG1VHwQ85BvMVM82r0X8uHt2OLxIo4nPf5RmNn0B++rwtVZXJ6VN26XSFKraPdaZJCGB5zMAHnyfKv4JuLc7x4B/84STiATPpD1jPisLrlKD7++gTo62Q1/33yE5xU3bNyrVzRX+pdCgvbbFfM3Udr9mM6sikjBNtZxnFXdU7QDLgHGacmLoBRoYuv2TsP+ILg6vcpV/+VnfrUUx3PfYjoJZuYxX4JcXi3qVFHCRGTT5KC2Jt3C0WlciaB5c1AE5ptjdsrTBo7/X+Zn9lsfQFF7/gLmmSaUtGaKl2f6dpl+bA4kN+AK2Ap+UKQmUMi45KGXCu2vY9mHfrRT6ilM61XGsxrUqKGu7yxMSxxizc0Bx/cK0TG5k7raqeEtX73ag3dqVqvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(8676002)(70206006)(70586007)(82310400005)(4326008)(5660300002)(356005)(8936002)(921005)(86362001)(2906002)(336012)(7416002)(82740400003)(81166007)(426003)(47076005)(83380400001)(41300700001)(16526019)(7696005)(40480700001)(6666004)(1076003)(40460700003)(110136005)(36860700001)(54906003)(2616005)(478600001)(186003)(36756003)(316002)(26005)(34020700004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:55:47.6376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e440c9b4-e136-4bb6-e215-08da60398a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1416
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

