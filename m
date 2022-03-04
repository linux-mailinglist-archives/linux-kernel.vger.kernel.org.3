Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1F4CCD91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiCDGKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiCDGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:10:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B02B13D0F;
        Thu,  3 Mar 2022 22:09:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os9GBHywhLpa0es5Rav8hcd3Fu6ZDCyK5qV7VwUj4QKwmW9EWGUpI8cMzjS7Urd3OYr2tKtgo/HjAxo1n7XhDohsHCc3jwCXGZNEuRbdRcDeveV0CxeZ38d0dsxo31X+KtJDO2xm7gfAKnH/9QiShFd8W9eAPGmSf2KQoEdzPu18BxdSyst9SZG2Zj4/z9+Kz/beMrYjHVohMWbWXiVhX2SRJv12A7+gVvq0QuDEfDiQZk3KHmSG6PI7aXZwtvSb0i92wLQa9OjeWsBGoQ+MWQ0RqHFtYv2yATJ05+X9wcLw86/X3STVBT12/2Hf3YyjhnmYOYBA2AI1QPic3lrQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGweuggBnk3AQ02wK6JgGU6yJIbat/nGe/F8Ny3eduE=;
 b=XCAa+xydyFqNBVUQUdKHaf83kyLYwKHJZC2gkpAwPBGGBripdi0HV7ZjvAVE7S8lGjzAlTwRmdwjWbQppn/GDtzcoVVsNhQSt8T0BqlKdTcJaoQONV/8iWV6g0YmzK7nq70lgSAG1ig2zPK2a2UdHRgWK81r25njPODeGWKAIl1S+9hKza2YZ1cYFzJsXZsiF/pWVkVE4KS0GWh4wdI3JFfOPEgsre1eiSV2ln0L16XoxrmClj2qMeyjLKUE83XbuiX4ogOnnD1pWfkV8m1yVFNI2Jo/I/kdrdxlOTypH4Ij4+L3btmRCrx7jRqjtnYuF/WA2xM6N/OV/XOXbo4/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGweuggBnk3AQ02wK6JgGU6yJIbat/nGe/F8Ny3eduE=;
 b=Yea0/UmuTNy02DOglph9gcUZfliHUjjORTQEOf3MUX6+UnO+KOZnM5XvrXYb/58o4osbM2HXDlQ/eANVW3Q62qjGMZNyEdPsHDN4i0fTqsaLLqZudv2p3FVdBurNUDJaOc6fkpWcuQtb5rDAhzJqtVarS8vfU3MXcXSnd2BWjas=
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 06:09:17 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::3b) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 06:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:09:16 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Mar 2022 00:09:12 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
Date:   Fri, 4 Mar 2022 14:07:21 +0800
Message-ID: <20220304060724.314582-2-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304060724.314582-1-Jinzhou.Su@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087784d6-3e72-4b0d-2785-08d9fda583aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3983DF3D2D9B79D13BF2596990059@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwwBkPYWqp5iDiiiR7ShzceboDeJxpoJSiv2Diyt60KR/YLtnuUdeiZZD/d8klQgIxOZKttizT7E8KUAeJCCnYZix/hejotIVG8El8h4j01g/AF6qKg3qaFG+0/maqqSFPf9ROguu6GqmoqhvYiTkYwu3Wk0HjUjCEc2OhlxCLuCnF7IAwOl6GfKL0W1FJFaCuLkhQ+yR2Rog5EwgFzTwNhMOjbuROMVHA1De98mtpG+FOgKKO4KZpA9SuwAKRSHP16D6noSLhz458XwnNgizdbntUYEvYp3nImcU38PR1YGBHLFZG0luoIpsPYhN9qtcxKdG+6SL+4FyGPEKaE0QwVeEDgJUkNxwOoTuWZ1vb3/gpfteEHYIV2pcvX/K0kU6/oYT/6R6mHO6bRpzbb1PP/3RfeEGckkaAE+OV+Iq0wrEuaIllXzHxGv3+N0yIVwWjGh5ErcKoX5SrwcY6poqfaT+oh+6Ax3AjZlZR12X1VmmoN8RmfuGMG5MYd8LN37PAAp3X7b6LVVboYBNTKfDs5Y0iZ+4BYTAILygJy2WFBLwlsPkVcKBBtf0M7OPm7IWLMcOwJnrKiW6ibs7sY1LDdxMdq62LDOa+Jq7B5km7/oZWpvBmbjxV+vjmdYHOIQAdGBVGyt0xQNVWbza8Bml66wQK0NAYl732OLBR3ZZPZQ4VfaPsJZPoWLhhr9Po4atUwZTvk68YJ2cN6HymTZmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(5660300002)(6666004)(83380400001)(36756003)(110136005)(54906003)(1076003)(186003)(26005)(47076005)(16526019)(336012)(7696005)(426003)(2616005)(2906002)(8936002)(316002)(508600001)(82310400004)(8676002)(356005)(4326008)(86362001)(81166007)(70206006)(70586007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:09:16.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087784d6-3e72-4b0d-2785-08d9fda583aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add frequency, mperf, aperf and tsc in the trace. This can be used
to debug and tune the performance of AMD P-state driver.

Use the time difference between amd_pstate_update to calculate CPU
frequency. There could be sleep in arch_freq_get_on_cpu, so do not
use it here.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
 drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 647505957d4f..35f38ae67fb1 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
 	TP_PROTO(unsigned long min_perf,
 		 unsigned long target_perf,
 		 unsigned long capacity,
+		 u64 freq,
+		 u64 mperf,
+		 u64 aperf,
+		 u64 tsc,
 		 unsigned int cpu_id,
 		 bool changed,
 		 bool fast_switch
@@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
 	TP_ARGS(min_perf,
 		target_perf,
 		capacity,
+		freq,
+		mperf,
+		aperf,
+		tsc,
 		cpu_id,
 		changed,
 		fast_switch
@@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
 		__field(unsigned long, min_perf)
 		__field(unsigned long, target_perf)
 		__field(unsigned long, capacity)
+		__field(unsigned long long, freq)
+		__field(unsigned long long, mperf)
+		__field(unsigned long long, aperf)
+		__field(unsigned long long, tsc)
 		__field(unsigned int, cpu_id)
 		__field(bool, changed)
 		__field(bool, fast_switch)
@@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
 		__entry->min_perf = min_perf;
 		__entry->target_perf = target_perf;
 		__entry->capacity = capacity;
+		__entry->freq = freq;
+		__entry->mperf = mperf;
+		__entry->aperf = aperf;
+		__entry->tsc = tsc;
 		__entry->cpu_id = cpu_id;
 		__entry->changed = changed;
 		__entry->fast_switch = fast_switch;
 		),
 
-	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
 		  (unsigned long)__entry->min_perf,
 		  (unsigned long)__entry->target_perf,
 		  (unsigned long)__entry->capacity,
+		  (unsigned long long)__entry->freq,
+		  (unsigned long long)__entry->mperf,
+		  (unsigned long long)__entry->aperf,
+		  (unsigned long long)__entry->tsc,
 		  (unsigned int)__entry->cpu_id,
 		  (__entry->changed) ? "true" : "false",
 		  (__entry->fast_switch) ? "true" : "false"
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ce75ed11f8e..7be38bc6a673 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
 
 static struct cpufreq_driver amd_pstate_driver;
 
+/**
+ * struct  amd_aperf_mperf
+ * @aperf: actual performance frequency clock count
+ * @mperf: maximum performance frequency clock count
+ * @tsc:   time stamp counter
+ */
+struct amd_aperf_mperf {
+	u64 aperf;
+	u64 mperf;
+	u64 tsc;
+};
+
 /**
  * struct amd_cpudata - private CPU data for AMD P-State
  * @cpu: CPU number
@@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
+ * @prev: Last Aperf/Mperf/tsc count value read from register
+ * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
@@ -102,6 +117,10 @@ struct amd_cpudata {
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
 
+	struct amd_aperf_mperf cur;
+	struct amd_aperf_mperf prev;
+
+	u64 freq;
 	bool	boost_supported;
 };
 
@@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					    max_perf, fast_switch);
 }
 
+static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
+{
+	u64 aperf, mperf, tsc;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+	tsc = rdtsc();
+
+	if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
+		local_irq_restore(flags);
+		return false;
+	}
+
+	local_irq_restore(flags);
+
+	cpudata->cur.aperf = aperf;
+	cpudata->cur.mperf = mperf;
+	cpudata->cur.tsc =  tsc;
+	cpudata->cur.aperf -= cpudata->prev.aperf;
+	cpudata->cur.mperf -= cpudata->prev.mperf;
+	cpudata->cur.tsc -= cpudata->prev.tsc;
+
+	cpudata->prev.aperf = aperf;
+	cpudata->prev.mperf = mperf;
+	cpudata->prev.tsc = tsc;
+
+	cpudata->freq = div64_u64((cpudata->cur.aperf * cpu_khz), cpudata->cur.mperf);
+
+	return true;
+}
+
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch)
 {
@@ -226,8 +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
-			      cpudata->cpu, (value != prev), fast_switch);
+	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
+		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
+			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
+				cpudata->cpu, (value != prev), fast_switch);
+	}
 
 	if (value == prev)
 		return;
-- 
2.27.0

