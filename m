Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864764C0FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiBWKEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbiBWKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:04:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ABE8A329;
        Wed, 23 Feb 2022 02:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnC3ZymEgGzwqhYsejNJI1l1M0hZpmWOYgD4nUV9bm2rq30p8vp6Jh6FRBSHPNBp9htTmi9HM+KDJEJ4d89fYP97MCV2CXJaFSiAuUI2GqKxWGwd3xzvTLLkQw+baWIz4xYzg9+1Bs+aUBO0ynnLEk/dtrnTN+48yFOIF3DEVdz6M4z7zD+YP6OaOAOH9MJYjVWWgqOO7VbkYYyD9RMVsFMMQ6sx1bX3NeBx6Fz+rc4H2Ux/1vUFIgXaxMS2E4UQRDuHXuwuTkSgX4WdBXLVhd6ytn17OR0l7f98RqMcRy7lm3kBG+Ain9v9mGZprSfIAlZLIzNxhtxNgq65bICDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3m27Tin06r/SOSAuBd2B2BaUpZXyaOJbLrZovwEPQ4=;
 b=nS78BXO3QPmbsZuA0SvowkyJxFEYBCifZrPpu+Nc/jLQRYYNrAjdWvyjTdCVLHJ+nv0w3/5lmSEnXgLaXaIuAnsUxpPpbv2qQa7FYgf2PzXFneRtp9YyYp1bZXkmNVXKt0FD6DcJNmsva4qqtkwry1h8HZRRCsI2U3XLlR4I8kWXBUzr+oUovkrV6qxiWGY30tg1peYzwTsTMeYDux6NmnKSrm3pkc7gcZxklE4+4weHQG/34O6owrY8Xo8e+qL+qpYZAMkrh8vij42MK0UIhnc6w++mKHb5ewjyYUgazLwY2u1cjq5wiq0TfQug+SG/0lGyhd3Ewhm/PwnKDHnGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3m27Tin06r/SOSAuBd2B2BaUpZXyaOJbLrZovwEPQ4=;
 b=4X84WDnhilk1NGgEJScgu+PZjSICLyIZLulRvqOv5bFr/52X99KXpPT7gfcgIfS7Z11w9xodFHXEaZ4LyTalPzBK1PAkuuc9fgsmPxwc5OKqOA4RmQ/gSUxa+w39rHu/ttSXW7odTNIT4PtMGhoJxl0dO+nJdtW0YdlgvoKdfWE=
Received: from DM5PR11CA0001.namprd11.prod.outlook.com (2603:10b6:3:115::11)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 10:04:15 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::8c) by DM5PR11CA0001.outlook.office365.com
 (2603:10b6:3:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 10:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:04:15 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 04:04:10 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
Date:   Wed, 23 Feb 2022 18:03:48 +0800
Message-ID: <20220223100350.3523826-2-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b536d3-dfc5-4170-115f-08d9f6b3d916
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3433831686AF1F06850F848E903C9@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJXiG/JO9FmhKaYQO7zzh3MvAyRbAqU8tgmr4CFRqCHql/1pBMgbfSz94TLImvUCCYP7jYfRIpwsxjL5kKiuk/GnxMXcNYum/ARoSjNIj7o/OolDZWnjVjF5Akntstn+uSh/IjKU3eoMM+tsbLVhbdTAeg+9RsQrEqfLA5nCFUOQPitTjFbgxaoewJJos5Vc3WyAimUdoC6Hd83opjx+Fb5eaY+MHFbarPTYuCth5YjZJA8BRJI2O4dIf6xMXGmvjNjx0zFbFguU5mrCFlewRx0bT60RijW44UGS3RY8iLpnsRXu90hvWz2q0C8lFUNbVEBkzpbCUxun3j12maRVwltD9qHvhRIHw8bZ/ScpfuuGx4SugVRZTOvtYKEct7l1GxQv09HnI1Pu9aFdP5sC9SvlH/nu1b+wStpXM/KRJ8ZCbH5iaMfhf11Ht6LeRlu1W9VZCAv8gYE0WVlux45PprI9ZYlq4sk23CdzL0CgZtYZy7aiYqdmJr9GfkXSP4ZgMZDDBtrd9MrdWhF3LVMJyA6OIl/Ggqv2VdnwSraDs0qFf5heRcQJpCs00yEnUpO/L/UYSWuI1kF5XyRDAUpv3qGnDLupoXLcam+5sQRjFNaiTac1ADwi2pkuz/CaflSgvembKZYvElmtWY8M685aGZmUzS6Mt6GjK2PjvRGqZHwhuxxESs5A1K1PDisynQDPKDlBqfzLsf4BqTg/lN72NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(2906002)(6666004)(81166007)(7696005)(8936002)(356005)(36756003)(110136005)(54906003)(5660300002)(316002)(508600001)(16526019)(70586007)(70206006)(8676002)(26005)(83380400001)(86362001)(36860700001)(47076005)(4326008)(1076003)(426003)(336012)(186003)(40460700003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:04:15.0223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b536d3-dfc5-4170-115f-08d9f6b3d916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
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

