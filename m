Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1B53081F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355550AbiEWDke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiEWDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:40:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367036149;
        Sun, 22 May 2022 20:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mubXw6pEwX4xGnnPjbag6HqkvNXiCCei30PRhyJNJ++wfdUfEDCTjMIeNKJAQNRofhZ20GbI/COGynR6n7t/96I7CW0eZs0itxPlODnPvnjW0XqK1nRKIknTZ3b9N8/+3Lw7jfRaMYu2plwh4M6N6hNOXiaobpt4n/AACISlLfsMqyB/PQO23dFLx1z9JuPjNOWLCYgu2xNRguNl5wbHntgFB8pk1egzGccqacybuOsFWpBUdq/uqDYBiN5BA4FQdJLGYrot1ZZn6S0oye4kPUeZmb2x6Y3tU78SfG0geUoPB8haIXIPd5JANLF3rJ/o9UNtdtQy9jSpebV6LkzPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/+TlCJY4Q23MjGliKtfPGmGvLJoy7hxKRM4k+bCFcY=;
 b=L63nBOzS8pa2gHtj2kTWULwBVbsKtkCl+aP4nkepPLh/sz06v3yaRiJeDyaIyfgx1bchkjHxbHYHJQ67c5644mLUblSETFHYXpQmmES2lWWpfhGXnbw7zB8gMeb/zrar5bfiYky5NcjAzjNO3vZU2xHcmhQYlYufOkcXSp3Hx9NknLwkG7ZJQnpxOko9dPXmZA4YFIMWNt0cvyyamQ8qTnRDq475PjyjZ3vyfkusM0mJLnmPbg54nqszkkWaiqzfyBXA3sYD5o8HIsrslUc8NGsnS5eLHPhpUAgzM+meTV0R8UCCI7uMc/2mr8S6gOcIqRC51jo6vzeyGELq9UdzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/+TlCJY4Q23MjGliKtfPGmGvLJoy7hxKRM4k+bCFcY=;
 b=gpod7ihKzVNiS7cJCgnT82mO5oTyrtsZeOTJEx4pvuYn+ctMJYQxcBmDpJ97Kvl5s0WAa+PGt1fGasiygscgc4NNANucNTqj/nQuIgpcITHpcFMLRkinlzTyTdVlg7y3p3Ft8gVC1blJk9QIOcDnUtNutnSpBE/Z3XnDlvwUO48=
Received: from DM6PR04CA0004.namprd04.prod.outlook.com (2603:10b6:5:334::9) by
 DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Mon, 23 May 2022 03:40:27 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::5f) by DM6PR04CA0004.outlook.office365.com
 (2603:10b6:5:334::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Mon, 23 May 2022 03:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:40:27 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:12 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 1/5] perf record ibs: Warn about sampling period skew
Date:   Mon, 23 May 2022 09:09:41 +0530
Message-ID: <20220523033945.1612-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523033945.1612-1-ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8d7b16-078f-4f79-117e-08da3c6dfa41
X-MS-TrafficTypeDiagnostic: DM6PR12MB4878:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4878FCF1733B0D57FC4CA343E0D49@DM6PR12MB4878.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP2QKueLPTd5gY8JcIcK+/7c/MbaCgGsHnnv50VQxK11HcPUluGmFAWrtVvzuzs5HBjm8BFe2SZnpuOezVcM1k//EbKAtZmBsxkbgk4jMoIriwMN6uW81oXw9zEhQOmfxvO5aMXHBOXW2e8fVhe5wy/5gbLkGeK1EtuTslX1MPZzu+Clee7hovUjEmcEHzCeD9lZW+tss+wHvTCkTQ5POI4kX5t127yWGHMkqt0+QjDrpNHWiDQEjgejvKGymU9w/xAGiLxrExmliGMKDsQsya8MkQ8KbX2FR0rySeRteFVoHCRHMTn6kzJav7wzFf4sC3CAN24Lco+W2CdIdnZNfwlTwqOQ0ZiOoHMkkMhM3YAwJJg2LhUfpDinV1v6TAqqc1IKW+u2KZyY/rIELa8Qr3S3xtaH8Mqw58PYlI8D1VyuTkVjLwlJoep/eHa6HvSmHkmt5A0ZtoSPrOc29LfUMrd01d/w+igSb66orULHdjTu8kwnQGtJGEVclPmnYgTctvbSdurfNdILz/QnPm3ATkjbd59rThZUWFs2az2+PDOHxGcDkFv1RIWncduLTD9tSO8cmQFTU0HcUwUyRpEC7SkL+1lE6kr2hSUB5jUQMdxt9zmizqupsAVqcA59Z2BZkcZo0wMwuGejAQvdbRdoLLZsawKc/NsmxG8g0HgYCStudel9zpWv0YScbrUqPtZN13tOP2BtkgSMVExQsJz/YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7416002)(8676002)(6916009)(316002)(54906003)(5660300002)(70586007)(81166007)(7696005)(44832011)(82310400005)(70206006)(40460700003)(86362001)(6666004)(4326008)(508600001)(356005)(26005)(1076003)(8936002)(426003)(336012)(36860700001)(186003)(83380400001)(16526019)(36756003)(47076005)(2616005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:40:27.2922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8d7b16-078f-4f79-117e-08da3c6dfa41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
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
 tools/perf/arch/x86/util/evsel.c | 50 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 +++++
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 58 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ac2899a25b7a..e8ff4ddb53c9 100644
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
@@ -29,3 +31,51 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 
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
index 2a1729e7aee4..e9be9b94a062 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1064,6 +1064,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
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
@@ -1339,6 +1344,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 */
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
+
+	arch__post_evsel_config(evsel, attr);
 }
 
 int evsel__set_filter(struct evsel *evsel, const char *filter)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 041b42d33bf5..207de5082ee9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -281,6 +281,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
+void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.31.1

