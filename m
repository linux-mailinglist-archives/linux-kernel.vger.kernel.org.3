Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6C51F3A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiEIE5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiEIEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:54:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1A27CFA;
        Sun,  8 May 2022 21:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTNi9VGt3laKTlgZWcCIpgyTe77O16vaLMhNHcoFdbjw+zBgt1K4S4cVLNCt6ceCXFCg4VkqsTbraHeksB54VbO2xyKe7UElXBAaEwwxPJtf2ueOQAzKSCC7XCuiIpPo6o50MwgV4r4T3CbQ6AJkmdbnhjBEQH81nRx3zSUYqIbEee95bGXCMs8LcyLfPlZR5J53o84LVGYqedxTk1WG3+QNiD4xL8UsCLT+U/2PFLgl+wHEX7lnvUH72xk54DGKx+PUHDq5+rWqEm3D4lb978AQfD2nRuKaqVZzbvd/El2VFuEZUcNLD89wIITx/d8MLRax7KlrBCAzhgqMm2YhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OOXXu6v5KPvB+r6zyrx9a4ZJj65cznCHut5dWhNESk=;
 b=cdnF+82Kpa4T/4w7UnYDfktMtNMAPB8e7BYo9uSmUkr4GSpm+PzjovOPHW2uSzqU4vtzCjkzsfjgrspqReHjloADMOlr/ShEGzrNtrJBkyw7m3OwQ2oX3VKxRUCNOAF61xzuhMl1cZRcLqeN/UrCcZeAYnV10DaQKY//XcaB1HITMdajhynzbKSdRq6WWfSa8/BJ/e4OVxy/7ysGinXOl8ndly8TnMKw2HuyaINprUa40Thxjmp1+WPx1RXqHVeYvXAIQk2Q6xQRSVxYG0vhyPdnvtGBwN/EKfAJmGz6EftiXUPZSY9OnVpCftYwpE70fab/nsk5wViTEvfESBjWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OOXXu6v5KPvB+r6zyrx9a4ZJj65cznCHut5dWhNESk=;
 b=kgzlFbliQh3dYWdYqsAhpENJNrJbbpaGlS41tm+YsIVQa1NTnlqiJtj1cqXU1H6qY9Wp0/YgEQC6zGgWAX4O5i4c/2cdnpdPVAV2bnbjTloTT3FkI64aFgMtYe3u2+BP3tf7lJBZAk6n6w+GP3ApZzb3DFboMJPz+OqO/+0bHSg=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 04:50:38 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::6b) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 04:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:50:38 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:50:29 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 5/8] perf record ibs: Warn about sampling period skew
Date:   Mon, 9 May 2022 10:19:11 +0530
Message-ID: <20220509044914.1473-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509044914.1473-1-ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10322187-d6f5-4313-d871-08da3177768f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB412470D962F367521B488BD6E0C69@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7Q6mTGvKkZwFfXwXqgF8YwjQt1wMOZED57BIinjBLfqXFKF/zIgck2U22gN6wulTQyXen0AJyc/WIDLxNrZrZZoNT+UVCyoPtaBHyaFrP76KKVf57vfVhWsC+fYGjF8s+1IpvaCTHXRYrR/5knQQe8yTLYa/EBXuq4e5/lIQK8NMF+IuwUxG1ix4BORV2d1N8IkrnNxIGG1W7e3kT/p1gmaDRP5Bvj8G255Qf7It2jBmRh4GE9TzXNkfXqkJF0AumqrhwzxvPoBADKJLvwP7vceg0vFeOpPcfc4aMJRG3vp16FM9VmZ4jhIX0aKAhiRxpDm2uckRoOxviBfT9uQA/un64oyE4NkYrRDZfyDzTyz1A5s5YfuRgFRz50uhAelRy5G7pbwak97yqQmmKLWAMOfGsjLoQttAvhrwMICoD3sunok+Sd2MEelc4DSCtaIfOYdi5PS3xq8PwoQ+agcGyiF9D5R3Nmt/Q7ddzIHVWr4GgHLf9hLzw46C9EYAqV6RsHoyREVVxPvjR3+mw+g8mXg7sS8VM+wMR94UdDjKtqoAnxyAdMg9SuPO8neDR4iEjLCzCglQtVoNzFPvkqK/p7jAa7GgBpnKCq2Z4VtJY+UyCHr1KJ25X7BU14tcZw/V+BiV5rDcwXrDfYsID7RTXRBSuxoOmNJfHWlF9gN8S8GWERr9bOFveNN0QHqG0C+RAIe7Cn27L0Anpviyy4QOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(186003)(6666004)(36860700001)(7696005)(44832011)(26005)(1076003)(2616005)(2906002)(36756003)(47076005)(336012)(82310400005)(426003)(40460700003)(110136005)(356005)(5660300002)(86362001)(7416002)(508600001)(8936002)(54906003)(70206006)(70586007)(8676002)(4326008)(81166007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:38.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10322187-d6f5-4313-d871-08da3177768f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samples without an L3 miss are discarded and counter is reset with
random value (between 1-15 for fetch pmu and 1-127 for op pmu) when
IBS L3 miss filtering is enabled. This causes a sampling period skew
but there is no way to reconstruct aggregated sampling period. So
print a warning at perf record if user sets l3missonly=1.

Ex:
  # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
  WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
  and tagged operation does not cause L3 Miss. This causes sampling period skew.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/evsel.c | 34 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 +++++++
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ac2899a25b7a..6399faa70a88 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -4,6 +4,8 @@
 #include "util/evsel.h"
 #include "util/env.h"
 #include "linux/string.h"
+#include "util/pmu.h"
+#include "util/debug.h"
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
@@ -29,3 +31,35 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 
 	free(env.cpuid);
 }
+
+static void ibs_l3miss_warn(void)
+{
+	pr_warning(
+"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
+"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
+}
+
+void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr)
+{
+	struct perf_env *env = evsel__env(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
+	struct perf_pmu *ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
+	struct perf_pmu *ibs_op_pmu = perf_pmu__find("ibs_op");
+	static int warned_once;
+
+	if (warned_once || !perf_env__cpuid(env) || !env->cpuid ||
+	    !strstarts(env->cpuid, "AuthenticAMD") || !evsel_pmu)
+		return;
+
+	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
+		if (attr->config & (1ULL << 59)) {
+			ibs_l3miss_warn();
+			warned_once = 1;
+		}
+	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
+		if (attr->config & (1ULL << 16)) {
+			ibs_l3miss_warn();
+			warned_once = 1;
+		}
+	}
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2a1729e7aee4..4f8b72d4a521 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1064,6 +1064,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
 {
 }
 
+void __weak arch_evsel__warn_ambiguity(struct evsel *evsel __maybe_unused,
+				       struct perf_event_attr *attr __maybe_unused)
+{
+}
+
 static void evsel__set_default_freq_period(struct record_opts *opts,
 					   struct perf_event_attr *attr)
 {
@@ -1339,6 +1344,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 */
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
+
+	arch_evsel__warn_ambiguity(evsel, attr);
 }
 
 int evsel__set_filter(struct evsel *evsel, const char *filter)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 041b42d33bf5..195ae30ec45b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -281,6 +281,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
+void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.27.0

