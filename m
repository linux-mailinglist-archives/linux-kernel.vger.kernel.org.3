Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6A539BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbiFAD1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349394AbiFAD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:27:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA40A193D9;
        Tue, 31 May 2022 20:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM9ZO7x6Pws5Xo6kDVMMYLkcsXQWGNbn3Dd2O8PKETQaoGn+geTab5gzhaSF7kib0/gS9ootsRPLXwpMKYDSRYD7edRJI4JSUr8P7WAI5DcqY2PRhXTs5PcamYs/W3AjDygNREEYZfUWJKThUcxFUiLg1adyW+52IiHhNqwPPLSPdSRjLTq8aaA2Mb2Yz16n7LHzqWzOhgJBCljTtutmXE6c0UTn5tyXd9I+Zy8YYraBSK0g1YZZlXg19SpnQV6N5Sdl6onzKVj3qSEEQWD0o8OggYe1pfN4NVPxNYZZ3fF5ZO4MWWg9z/T8BFr2SMudqmL37WcxB/nMbmeUaLOjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cM8N53tSbFDfbKPHpxAdrzs3Ux75peOuqDcEUZOUWw=;
 b=JVZHWzRJ2EP42WUk2lI+aq+m0VjmNt4zLMOrdSSyhFPgX2lPKLZwaJP03z3QKl/U8i0fXNZK/ZXKcobwIN8Lns3AsgvZAA3sDdCS/3CFvAe3NRrTcPlvFnAret6gQKrLaVqXEr1ZgG8yixwutrp0L8sG8CSqp5ekaI7FtOwGOVWYPXAQbLH/MMQmOki/dxyaAwrWKZZeRY5CnCX/Pk6Z+pusqndrRf3vU8MPzM5vhKSXtT7mvNpsEPJUo1idu0+y+vRE6m6YLsOmFVhTnU1e1shGxcZbl5o5ooB1OQjp1qHcawTQEayK7FDY431v2TGV/jzQ7PPXKQ740jqLzF87nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cM8N53tSbFDfbKPHpxAdrzs3Ux75peOuqDcEUZOUWw=;
 b=AXK9udNebPaKmA8md7D4qInLoBaxxZ+Wl5/wsn316CRL1pXQwAq5JDIYn15s49+emevVWL0beIHD4r07yItBO4lSI1Gn1jjnxZTe0oA6LppBL35aKAuC9FgRkFl2tKiX1i6iv/l1qDB+gMupnIC7wk4fZgf+e1V+k4jWTimyHTE=
Received: from MWHPR10CA0052.namprd10.prod.outlook.com (2603:10b6:300:2c::14)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 03:27:33 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::73) by MWHPR10CA0052.outlook.office365.com
 (2603:10b6:300:2c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 03:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:27:33 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:27:21 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 1/8] perf record ibs: Warn about sampling period skew
Date:   Wed, 1 Jun 2022 08:56:01 +0530
Message-ID: <20220601032608.1034-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bcda395-e4a3-4e60-c21e-08da437eaa9b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB438902BE8B0F6E6D612276BBE0DF9@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntkM2kidzYuDevGiEcW5TXn9JvgGed1Hl4DSCWIDoLoo6vjew9bmWatIQMZy3hDftYEaReuBnjU3PqEl51QbNsj3pUSBr3v/2TsYnXNg7xyybQZ2Qzo6VFfE//mNcsN+wHpD77L8yv8N1746ojEHLYW6bYkMXdS4+yAX8imF0oMctr91XFqTh+bTsTKIOU9ZfRdca7kT7vWDDC6IsNzORvcaPG6PkpxyhiycPq9fHfTrc7OzHreXtwI7U8teXkxKZgvOOmo76Qk8/YgpskouKnPE0QjOgaQ1vuWKkUuiJX4mdTbKHxO6eKO38mMPNK+E0z24H3udXHg6GQi0uq0PwZ08+TudB25P6niIa+H17QloRzGYBm04A00Vdj23pVfGaw9/Hky7pQusu88AQVE4xScdLxg5CUh7Td6CDzPLFEkSlUJ+Sd/lShvsxct+JJXqmKXG6EZfJsnBsjp0/X+F71TSAdG63ZnWjUpZ4RV2E5WPVRRBuGPqMHfg40XzhUJW5EpRh6X0KEpGIB6xXdPQ6PeafVcFrlJe7hI3KJ+eqpiy8U/B0DPqrdbGA3vTUGAdFryL+En1qXlSv1Y3CPsKoyhNVUUkj8vT6c6ogm9MPKoV2yH0XTeA2COTxhrUN17MKaHgWoEF+G3HuHEJaO1nveokg5LxzKO8ArcDYKIgLWkjOIX3J660A4klNjgD8poy0icSBeALwVidciXf8RTfaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(336012)(1076003)(508600001)(186003)(16526019)(26005)(7696005)(83380400001)(36860700001)(6666004)(82310400005)(47076005)(70206006)(356005)(70586007)(8676002)(426003)(8936002)(4326008)(5660300002)(316002)(44832011)(86362001)(7416002)(36756003)(2906002)(54906003)(40460700003)(110136005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:27:33.1433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcda395-e4a3-4e60-c21e-08da437eaa9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 49 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 +++++
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 57 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 88306183d629..fceb904902ab 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -5,6 +5,7 @@
 #include "util/env.h"
 #include "util/pmu.h"
 #include "linux/string.h"
+#include "util/debug.h"
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
@@ -60,3 +61,51 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 		(!strcasecmp(evsel->name, "slots") ||
 		 strcasestr(evsel->name, "topdown"));
 }
+
+static void ibs_l3miss_warn(void)
+{
+	pr_warning(
+"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
+"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
+}
+
+void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
+{
+	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
+	static int warned_once;
+	/* 0: Uninitialized, 1: Yes, -1: No */
+	static int is_amd;
+
+	if (warned_once || is_amd == -1)
+		return;
+
+	if (!is_amd) {
+		struct perf_env *env = evsel__env(evsel);
+
+		if (!perf_env__cpuid(env) || !env->cpuid ||
+		    !strstarts(env->cpuid, "AuthenticAMD")) {
+			is_amd = -1;
+			return;
+		}
+		is_amd = 1;
+	}
+
+	evsel_pmu = evsel__find_pmu(evsel);
+	if (!evsel_pmu)
+		return;
+
+	ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
+	ibs_op_pmu = perf_pmu__find("ibs_op");
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
index ce499c5da8d7..8fea51a9cd90 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1091,6 +1091,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
 {
 }
 
+void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
+				    struct perf_event_attr *attr __maybe_unused)
+{
+}
+
 static void evsel__set_default_freq_period(struct record_opts *opts,
 					   struct perf_event_attr *attr)
 {
@@ -1366,6 +1371,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 */
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
+
+	arch__post_evsel_config(evsel, attr);
 }
 
 int evsel__set_filter(struct evsel *evsel, const char *filter)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 73ea48e94079..92bed8e2f7d8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -297,6 +297,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
+void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.31.1

