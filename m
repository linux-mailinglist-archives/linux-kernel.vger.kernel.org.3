Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA284D2716
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiCIBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiCIBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:25:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0163F892;
        Tue,  8 Mar 2022 17:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K35K/Nn2ZiRBWVd2x8IFkXs4Ky/jKn/PJalyVIMQVjhoKjstAc1mTm/5L/DQ8eByQKVxuQfi/WRchh/j5edwIvy/J4eAUtEPv6IELQxRPtBjWlkw9b1C6sEQW4Or3xVLngeJNwxcdI3wz2CR6J2WFE1OsjzHcsp2tkSRv7i1EBbfkEQOmlmqKW5UZSJLPiZBegmM6wCJ6o3Qaxl30gwAS8mn2R03fa921XhZB8uDrtwA0/9WzVotIVRYsA+qVv4OVGUeXET8qwUvim4GBD6lcdRrfCqxlJiT1RsS8HUeYurUADbJ5FD6ODTUjkqMDJF8YbRVuKExLXuXKXnNlIcyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGweuggBnk3AQ02wK6JgGU6yJIbat/nGe/F8Ny3eduE=;
 b=JxcfeyY2ovhCiMyiJFYaQlnCGKvJhDu6anOs6W0iOmgM68uocBjOsqQ8rF7u0Xb98raMtuqvt416uvsN+G3bTvyyL3fIVsOXOEtzO7w7w8ZZKLKo4YApDGwORD5r/79tucPKuYMr21xgpVtDVV9x3xA+FcytGgHgSVLoJxdH5pMtSH+D6OzYFBlEMBVV+J9cxLo2CKS5bQJDZeb9FboMlZBA3Otzwxw81vEkFYRgeDNEWG0qYDW7q8DueQpXXlM/WAH0d0DYoMpkyy7PLgM61a78/O88rHnW/LfBrSFFMvUZFmGWCEFpP2eCYq3U2E6P1/5tfvdDVGiePXsyzxlEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGweuggBnk3AQ02wK6JgGU6yJIbat/nGe/F8Ny3eduE=;
 b=GqC1L5wO/SuOi6OpEgBzDkVt3aoTL3gCAi2L9Rfpy7D72JzLenakxOkpAeB+cdITINMH48VbWoaf7SJ5H6AT0o0ZyDRD8nBdHcBQj1I+mfbl11FGkwufoGlJiHJXUK7H/uianud+aQL8Mgde9ssqh3K/Of27n8OxiotdKRx4q1g=
Received: from CO2PR06CA0063.namprd06.prod.outlook.com (2603:10b6:104:3::21)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 01:24:28 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::66) by CO2PR06CA0063.outlook.office365.com
 (2603:10b6:104:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 01:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 01:24:27 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 19:24:22 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH v3 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
Date:   Wed, 9 Mar 2022 09:23:48 +0800
Message-ID: <20220309012351.616826-2-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220309012351.616826-1-Jinzhou.Su@amd.com>
References: <20220309012351.616826-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbb4bf1f-3448-4f2c-197f-08da016b8db9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4325:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4325B1C55BFAB9A11ACC1139900A9@CH2PR12MB4325.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPc5STIeNwHYfQSGiF1dh86dH7m2qazYolCf+9dx2lOKJmhVSIjD+2l55LLN27i4TKlfMqIpyzKVDICN400DURdL6/AbPeKoOnBAiXfUGCFh7RVxJ45sCSEJu80mGyEUXx2hm+GRZe4KvuUhE6vVpAvFr0lMyBhrkrVRTq04dRGvUCFljD9j3yoEmNDN2k58TI0HjB+DG6urszT3x03At161qwB1dL+swBveSkUxvQvauYB9Dv4Yk5tSJpZWzErUNpBeZVEDaJ1GODeEssdvRMJ63Iu4rW/DEj/V5WXDOHlyxEu8z9UO0r3QvDpoJlh1m0kKbC7a9FDLFOU1Ws0j/dqYzEERf2T2oU90eidVV74prI9QcQUglJlB/CmZRIimT4k1Z/Y9lJs+OtqKZHbcqxtdyvWJtFs26PiWhJjD0hkdm0eMtfttc8w2eodC83ruhbUCqt/OoQ94JWxdUaEjkZ8PcNDXoBCsJvjBcwzO92uqD/bDIr6Xr3V9gJovBJgL/e0khyDA8UrV4TfA/nOQK3P5W4xqU7dnsz9/AuOaQyBAvUubdveHb2STBJcQThkmWQb4jEva9TNcmlPZqc4IR8GmnZYfClVlqyVYwHbhw/j6RYpXwhT0R3pIsxi8FKHJsTeFvY1YXdETrygM5NDRuUY+elqSf0kN2rrI7VdeNtKU1Szs4C1bOvB+62qfuopJlIDez1ZsywOJNQDLZqbSJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(8936002)(508600001)(86362001)(6666004)(5660300002)(1076003)(2906002)(186003)(26005)(16526019)(40460700003)(82310400004)(4326008)(8676002)(70206006)(81166007)(47076005)(110136005)(2616005)(356005)(36860700001)(316002)(426003)(336012)(54906003)(36756003)(83380400001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 01:24:27.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb4bf1f-3448-4f2c-197f-08da016b8db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

