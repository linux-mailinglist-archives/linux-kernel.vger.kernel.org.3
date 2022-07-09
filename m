Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78256C9E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGIOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:18:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D270E00B;
        Sat,  9 Jul 2022 07:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQN3z89ExnUSuZA2zyinOChGUAf5JmiKp+QBocuKwnOVvsboHqCAtHIOy5deg1h1vMa/QyXTkDLlTC1JHHqkVyQtiEbC/JFACFxfR0Jza71/zr2mqNYsHRE+/Esclaa4K4Z6yNatCTM8rnFCTpUKu1TR13jawW6lMWLbIin2SzPD6vhN6nGRu2L9QHrKwmESQNj+5U9vswfR22VPnYGnJZnR1+lO6ZMusNgj/Sar9kj7It6WV47N5bAal2UcU8CUNCK8maOY79VW4b5XPBfuHN3rqFPnqyC7NqoFNZEqiQAH0D/jT0f4A5ySjKVrKDQXp23XK9kYpW0agiccBgoW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=SyHyokeYjFm/qRnw/F4k4VQNgEA10dZ/pcIgsALIyvbC+JxrA1ZUB/0ykFdbB/3N2IUL3HMr/8MoDzEk9DanYtyOPy85tebDLj3lVgOxYnhhb5RPh+J09M6ql10uMzq6wyPA4LSgRkziQS/TF0gpNXSnjKzSRo6gW0jOI2Wz7o9ke13bIvhhTpT8ywea8/HPmBZezYg5XrjyeLwXntRqMgQoalbovz1jgWRZerQccRVsKhxB0xGgAIdNkO3dvl962O2BggPwJIrOsG3Sm0RHbQB84jIxOUsWSP76LmBD9L3Vtiv1S4II9R1FMpEP+jX9h9NlMeP07ucyo8/wl8twzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE1xs5A8thrUl5LPVV7c/9fZki/WFGQ1WGIKHjPsX8k=;
 b=szBAkWC3SXBn/83obxuHE/LdDpmZmij0cXmwVTQUUDDV5Ej97lTY9G+EV8jXzKW1Yfye+pq34vZJI4Zic2rZlahEBtMUIaD1nAdq1j+zzpBZSoqmjG8hbb6iHb2whU6SiWe4fsB8ghowuQbwbzwS+dr0kUfLFUdzsJ6ymoirIL8=
Received: from DS7PR03CA0325.namprd03.prod.outlook.com (2603:10b6:8:2b::34) by
 MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Sat, 9 Jul 2022 14:18:02 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b0) by DS7PR03CA0325.outlook.office365.com
 (2603:10b6:8:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Sat, 9 Jul 2022 14:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:18:02 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:17:57 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 02/14] cpufreq: amd-pstate: enable AMD Precision Boost mode switch
Date:   Sat, 9 Jul 2022 10:17:39 -0400
Message-ID: <20220709141739.834950-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89973b6-52cc-4707-d6fa-08da61b5d544
X-MS-TrafficTypeDiagnostic: MW3PR12MB4379:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gx3N9EWQ0H2jThndz9Dx9AvmSTNoa148G/fxwq3dWDNdDgXFqoyqDdhbVzu54FEOgDS7t2H4PyyM5kwngKIsGUH0qpgmR9Uz5+7ACcF0QfCzR0laEou6Y27NZnPA4Jp20wtEIfE4+nf03v/ffdNVHV5+ZUmT7hPo/2UpOWDyx0CApgtlFQj0GYSRtiM/FSO2jOCnmhm/Q4+5PN4Fnd5gwrMKbVxCe7P5VOB/I11m/XqoXLf0glr0GQvPw7JkE3PWycw3EX8/71APc4/KfMUoiF/V9Qb0oR6SD30kOaJq7rcsk4ubwQAsVeEIeXlYieUvBdKqDjtDBH0XNn6Z+rlo/CN1Xg4Iupb4QINJQ5UJkav4SAA4mitV3S3u9jv1z+4Ism87/imF0oSofPewKZVXV6rpJ2DV5aoqpV5R6iOCem7JeZmbBRDave9oW3983XXFYb30QLdHdouhVmQg1zSgt1x/yJ2lUKQ14CFd7pE6TDhwgn/s8/T2Vc1A9GUo3y3+oU88bEpp0KJm44TIK3iY6QOGLdObXgg2sP3q6Wfp/dva7Z7HvxIV8Jq7LZArY8kR5D8WKYpQejCLVOOMOjiAZMS0OmWmo/LxO9m2UT3tQyasDFd18XAgLrRkWfFyGTZdTDDOldrLQ24GqCSgXCqT0t6oxj0hNFoo3lZYR8PoZq/pSDw961mUji+owZC0a3AbSS5krZh93/17DgTa3QTpTsmBCOfHVVCmYGtqROms4IGts4Xj6F8PqEhaumVEyaLeVbHlhWS+UdwkqdnMOLZJ9xH9DdY9fRxGX9HWUP8O8VJnL4YvBRxXa6i1j330rs3Y8tOQEi4sBiLvPk79dhiXv2mWPlKl1x09A2SDHF09c2bttmOQj/bjE6I9Z+GT/IS+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(40480700001)(47076005)(36756003)(40460700003)(36860700001)(26005)(186003)(34020700004)(336012)(426003)(83380400001)(82310400005)(2906002)(70586007)(81166007)(6666004)(8936002)(16526019)(7696005)(86362001)(82740400003)(70206006)(4326008)(5660300002)(8676002)(6636002)(316002)(54906003)(110136005)(356005)(41300700001)(2616005)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:18:02.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89973b6-52cc-4707-d6fa-08da61b5d544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

