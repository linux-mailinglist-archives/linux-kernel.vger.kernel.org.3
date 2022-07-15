Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86578575F07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGOKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiGOKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A583F1D;
        Fri, 15 Jul 2022 03:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiUsXII+eWA2NIUxruYJnqUEqfWsIWKr228rxCfAHpMpJIdWYSRLUl/0xHXyP08F01RgKrmi0Mo4EezQbXobvw6iGtPR2ixSSfAcJMOekIOwmd+w3gEybK8h4ZT60W4JvDpFxXj/lxeLngSrXu2x22+CG4Uck+dsAi6RJzU9CiTknKCf4jICTFdrOaKDr2lLz/8vGJZhtTu73k/f8LLcUWMdxmJbAmY5z+H3OuniapfW1AwvqHy8M5RphiailxktHFY3VEXsrxJozcWSeSox9yKAwxKQZOK4Efvouxl741lU6jD6vEW/wNBYRtotLTiwOTBq4Bc8lhj8xRwHfJAmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvAEdmGWIfoWRkzwcliXGMGGn9wOjYVOFwAF5eM65+k=;
 b=k9pUcakIUSpkU9uTJw8f6/gpNJmBZLJEAHSYHz/tei8r5/ypAzcPUW3zGhz9VvoBbqXKEz5AoIWeHLkZGi0HzPQSGL1UsWBxRizY4EgtOWmrObne0cuJg2zuQnusQFkiBpMAwT5SBzrbF50qWTt+ZmCvSlSxls3Yl5WZ0HxIisX03uG2J7Ok5o19mN9/wdDfZ3cra+MDB//sAeqhEhrq++7MpV7gAm+o8NOCfpZdTgKG/snCmIRGIRtYmGmunYpJ2gJ3aWDafnbju3NEW2LlDQ/nDViVkThrtywtuJKF9uSdFzdDvlrhwi9JgQH6e2mIZ1SOF8nXSDj3wwrRQx17QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvAEdmGWIfoWRkzwcliXGMGGn9wOjYVOFwAF5eM65+k=;
 b=YBK1VCXxqvk9HtUdeZuksjsq9enB2NQrINCQCQlaJ6L8y3nWjYc7oprX5DbXx2A89i2KzV7GA6sRH8NP4p/zyr2LC7nXb9kxMUo6cRNrdhHUMiAZU8M4VihRjnLh9v+ptujb9KoWZaF1uNkaI6fAVrNRzqqTmdFbbSFzA7x63rY=
Received: from BN6PR22CA0059.namprd22.prod.outlook.com (2603:10b6:404:ca::21)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:05:00 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::43) by BN6PR22CA0059.outlook.office365.com
 (2603:10b6:404:ca::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:00 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:04:51 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 02/13] cpufreq: amd-pstate: enable AMD Precision Boost mode switch
Date:   Fri, 15 Jul 2022 06:04:21 -0400
Message-ID: <b3db7981e407d5f111eeb27a8504a4ed7979ba60.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c337b38-2ed6-44c2-e86f-08da66497aa6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uR2E/K9f0sw5k3ZmqY55U+diRCGL3WFHtzw0Pv2N33V1pb2H/parNw9ylM7p4vZAGCjtaVFcdOQw181ncfVZNr4h1IOZHEYYTswhe8wdq4+Z+k14FnQ9XJBo7+bAkgKHN4h5uIB3Yu1k8GDOkiVffV1ikchHK3SnQXx0ij0OhehP0buFZ4ubnsUG6wILdiWjOZ5silxDz7QlnMB2GUDcYH8qVA9JIxTMV0ubvMwKE9Ri70YB63SpOG4UGWg4cSAqQKlBuJcXsLu2bC1Qmgq+bPQYfbye0LVcAMqDx5/kbUHFX5pjhnYsTWdxHY4VvDnUPbCoegtH2Fk/vVdAb2J7qsyctpNd5EqsTR8OyA6Xba4T+LyM/IXmy3M/mMHazU103/AYQaMuttrWgeRYz8Io3iIVFxYZoSlDbReZGEfApMqGx8AIi9u5eYiKTmhxAP5zhvvc4g401ZAUPLnV1goLrYvT/U3W2jRoVZ6xi+B09BsInnLb1CZcNsoDplSGA6F5HBMkBwv9eK7dt+cRrC33/uZtW0L2CV45/4gKSjW9xQMHKpgE9e2IlghHKIhnfIvnq7bOquXimsn/L0mCKfy7TEzUNgRslbACZYpSABtaRnkZcTaKsQjCUziREVEU/5zvpsRtHCUdEmAA34IGkQsFgNPgL1ejulUs/CwSQRnEa7tciiiZYkUm6FfhsTQvr6x/VXzKG7h1XkC/LswiepoRnXFeDG7QzJhLvMxlout9aUl0s8bdtZk0AfOaDE6Hr4bwj2jKHRbqou80mQVLnz7JJPhD/IAa8KptVqtL2e3XCH6nKzX0RdnsKvcYvOvJ++sCauN4o0Tbdb259rlTK5ojVGqtUssV/zu948vlPiNGsro=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(110136005)(82310400005)(316002)(54906003)(2616005)(41300700001)(6636002)(7696005)(86362001)(478600001)(356005)(40480700001)(6666004)(82740400003)(40460700003)(26005)(81166007)(70206006)(83380400001)(426003)(186003)(36860700001)(36756003)(5660300002)(336012)(16526019)(47076005)(70586007)(4326008)(8676002)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:00.2126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c337b38-2ed6-44c2-e86f-08da66497aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.32.0

