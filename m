Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86553D58E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350532AbiFDEqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiFDEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:46:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083657B39;
        Fri,  3 Jun 2022 21:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEPwTlpuWN/808HyQ8gmr7pOBr5mzK47Ll3bNlyVv5h7TuHa7adiyyqUz/ZPbQaAZqK3aNYaddPTsm8bWQ3dKTg+gyU+3Gg/GawiCMNTK5wTThaK8T2QqcCBV2XmCTZ0CAV4B7Xu2O7nLfj5TfxbMrfxyMqVCITdE7hN2SvKTr0xuVZVNMuCQ/eBkQZdDLiejrQgs3WAl1XVqXNgYQ+rb73S563DTQbaO20bKMdioo4cuJ0dWk/wS3NcxLcp74UotNFp2i1RJ6bbSg9rFr+Okd3Uu6fYtybqKb7d4JX2wAcLwpgDgZ0prvezF/7LYDkL7u62K+/O7TnNoHTkA55oAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhcZvmFDQ0Z8K8YA1IHRLQ/zT9oPQnpwikZlNDSTCLw=;
 b=Y2ZwTkk74cAkics9gE50f6gtarwONsNG9Bf75TlN1iExKrMFMUWwACYtkNQKft+lT8mB1tFu/cr1b9pj7EmBOw6dk6JitSXZ06gi5mP9LomKv80S4DLdEN1n3uC2qRmeIve8n4EVJNKuh+UTdxJNw7r31K6ARUGfDLrDtm3qLNNPU6zrUvXqeGaa22oS9cMpgOVrpTaFPqMP9iOrPFGgR3reUdBKAc8Dz5+PSgFqVvjKWLrPrMSCQyeBRh1lPWC97EgLzqTECXGGRecy4MoIiYHUUkZSknqesHYBQfGybKOw0P+lO7lFCnsq1iZsAr7tHZT7cOtG29YnX7AU+kdwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhcZvmFDQ0Z8K8YA1IHRLQ/zT9oPQnpwikZlNDSTCLw=;
 b=v+4susb4vGJwDHLngq0ZLd+2q4Ni4DbfXAPRgqEXM9PqDB0D6StjvIiSjQwXeQlxw1dl3g3Sgtw0WJ3dEUCzIFWKIxmK7qIDErSTZcQWfJjOffJ2QiXMbftbR/7YSy3nU3kbpsr/DPelDolxhJ9CyKXyXFZmwDTQ92Ox5mIPsbw=
Received: from BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21)
 by BN6PR12MB1762.namprd12.prod.outlook.com (2603:10b6:404:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Sat, 4 Jun
 2022 04:46:37 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::eb) by BN6PR13CA0059.outlook.office365.com
 (2603:10b6:404:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7 via Frontend
 Transport; Sat, 4 Jun 2022 04:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:46:37 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:46:25 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 1/8] perf record ibs: Warn about sampling period skew
Date:   Sat, 4 Jun 2022 10:15:12 +0530
Message-ID: <20220604044519.594-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6715650-1470-44fd-30b7-08da45e535ae
X-MS-TrafficTypeDiagnostic: BN6PR12MB1762:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1762F778D38CDB30C12A6F6FE0A09@BN6PR12MB1762.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYoI0ROe2YD+VnGTOsK1Ejj/qWB0Pj00KXaG/AasEq3aTIeZc+qxrdNxBiP+8Vh1ybLTXZZO3v9etYqVLi8mP/6yPcdGTEzqYxW3Djrh6NKOAEeKZrK7peCCoZGAWn27vxlPPqLCzqSI5CJsTEc5LQjzDmWGm1KfAZbZ8s8HHp//z8aeLa3QRIzm+Qw0WSl9fIiuoeqrzrbbQ8eLZGMutfZ4mgfmPWNO9bi/owesdDqnDEMgmkjr0naUXRnCDw6l+vFIj3jGgKHR22bRwThcr1VGkAiRsXEHEdUMGyNzXPXhJe/PQicxXi9ShfY+wuoB1fVapazTwRbNGEAFANAPbP+haubj7MgmSQMR+VSTeKvcUd1ylWW/RoIcSkJ94G86t/WShQFLMR6KImDz1/DnZ+0D0RJ231nZp8BgvaUDlJ4fYzyfnz2F0BFp2141bMaqU8amOcTdzC1qFeY5Vl1xGM2oMADyTS9TuJOOx1y1xoVSavTJ7X0wuMEd3ck3lj0bnASVBa5I4zTCGNGYCNwG1hhaFbOgzT56P/WykOaJbZsdMCNSKdfkcI3V28mKhp8XkdmjWC+EHIMYsB8eejceb2Yd61WaVc7rEonT8Hhj/U6cZXR5gX+3OQ18gWSwUfE4QronZXemQ9hkX03siO1gqC8+JSXA/Gr6l4nK+wtvJQmya9ccYcqIXZyPgEHC2usFi9d8zYNAFo11oRJWajZAcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(7416002)(83380400001)(7696005)(508600001)(356005)(5660300002)(4326008)(6666004)(8676002)(2906002)(70206006)(70586007)(44832011)(86362001)(47076005)(8936002)(82310400005)(54906003)(36860700001)(6916009)(81166007)(426003)(336012)(2616005)(36756003)(316002)(40460700003)(1076003)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:46:37.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6715650-1470-44fd-30b7-08da45e535ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1762
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
 tools/perf/arch/x86/util/evsel.c | 52 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 +++++
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 60 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 88306183d629..53763e583804 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -5,6 +5,10 @@
 #include "util/env.h"
 #include "util/pmu.h"
 #include "linux/string.h"
+#include "util/debug.h"
+
+#define IBS_FETCH_L3MISSONLY	(1ULL << 59)
+#define IBS_OP_L3MISSONLY	(1ULL << 16)
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
@@ -60,3 +64,51 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
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
+		if (attr->config & IBS_FETCH_L3MISSONLY) {
+			ibs_l3miss_warn();
+			warned_once = 1;
+		}
+	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
+		if (attr->config & IBS_OP_L3MISSONLY) {
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

