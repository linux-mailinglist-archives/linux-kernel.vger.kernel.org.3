Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53A50D877
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiDYEsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiDYErk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:47:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B1E96;
        Sun, 24 Apr 2022 21:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrhLw63QM+jZxhi97SpswO1Y/Rzjz8ejpy822/AbRJ1vY7OA7FlQJixCRoGucbvCI4EdmU8EeEgTMEHklUJPrk4rC+w4ZPtKL5xEI6zj6KRA+RvwwortnapOT83GvJtqSeAaXSJrKYad7Biq4NullR5mMcMg61Llyi/dM2vGa9It8TIi/Nw7XMtElcurkVBWgvGF0YuW+9yDlYi0RbCORF+l+GZ7bY8g+Vu0w5ZlaxDxJnOyi5YzsJJ+BuPiUjBrxscplC+z7Y8x/IBiUadLBp00MHAmu1eDTQtn03wkCRfnnGJ/tRu0sf+qj1eT5ERPAuXxqDCEJrYaV5TYqlDA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt+I1y8haQ2Xhy+OvdZG43MyUtdjhiuO4Uw2OF2PALw=;
 b=FPMlEcwWYDmlJnk2EsRG8t3JU296Kk6xwWhJGiammh4ffUGZAKS1g26wkfRS0bowhrVPBBc+xLqIwHcHQWyWcPrTpP9TgbAUJqT4b4La2PiTOKbJb5Pc1AOLogQnGHI/+ya0dyBd5QvQ/uDE2TlmIn0DCyApoT2JgHTHPksaKaqDNhlzVOVR92tcEICfyBuhloUeFXqY4jnqw8QbtINI00KSBkOK9KUb5mXR0aKcYxXcnjoGWIa70Ec1dy3q25SqSNwMf4C/Nm0amHyjq3mJLTF1FCzjxTqUr0VFx4NgoJCpteHNXFumhTltyj8yp1dOvdbaMi61NSmPbJ56g9h+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt+I1y8haQ2Xhy+OvdZG43MyUtdjhiuO4Uw2OF2PALw=;
 b=J5O1xLjCj35pICIw/mwIgJ+JuK/uVPE7bBcBLDSpCiFIVGsJx9aZ1gE/TrK7eQgbEZbzC2TWNq74DncgDkAwX53+ZFVq5SC95GiB0SPoRtW2zidjzCUCKnaxa/rAFI1V1tff4VZd18mE/bdaUw8hfQhAYqyMxjFV6L4XRho1YB0=
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 04:44:32 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::2b) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:24 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 3/6] perf/tool/amd/ibs: Warn about sampling period skew
Date:   Mon, 25 Apr 2022 10:13:20 +0530
Message-ID: <20220425044323.2830-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425044323.2830-1-ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b3218db-9319-4590-245c-08da26764aba
X-MS-TrafficTypeDiagnostic: LV2PR12MB5751:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5751B144BA05F0CF531EB8C4E0F89@LV2PR12MB5751.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: de3JqpyLDauviMlcmMqR+dInYVP7+A0FpKwiLOMLRgfW4AOwnysl88tTbpB1mCbhMSPbcV3AOg3zh8eRhzU1D4n3MCLw+COkTsNlNZ3RvL4NSynYefgIGq/fxT01LFcZ/f5dT0oBV4WoaxwcrCiiI4ovCRbPmejzuJshR1wCe4YUuTCrCbKwd48s8c5GWXV8ownURIVJaSbL39qd/Hf9KwXn5udQj+i+ZuhrwPZbUteM2wuRgCtAKDGGowqicea59J5R4AKSaw85e821kq6MxYTkwwnVJ9q0zv/DIBTitW3seogKmJESUl+qgZ/rEvIMNXIUnSmS2+IjAsj5/U03qJKxm7oMmLjebKN+jHu9Mv9fkv7CML8iC5dYDupW+e7W9ost+vWOgDEFhhHXKNYh9jb31/9b51DS8a6kXndbfei1SL6pSBitpT1S3gSSQqHDlGNxLqMZFQ1ctoHZp/373jsWpkPLUbNEptRi30yFgJ1hOqdCZbDHUQJQ+yYPbrjodSWj2v60NQtK/mRZeo5qN7k8zL2utoyCSfcRtW407jCPHIj8shOhOGL2BLOsN4c0ojspErSD5R+57Jk/q7AJIMyY9T339igodUmJmcRmaXoNZg/403T0BlAZwl9USixW3OeXpFxupzMenYX+8aXeULEa6ADUPoGvk6x85I+CKPiZuLOtZ3+sD6qcmUUJXQVGkOu8+ZS+YnajlM9Cu8LbuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(16526019)(70206006)(70586007)(316002)(1076003)(8936002)(356005)(4326008)(54906003)(8676002)(82310400005)(36860700001)(186003)(86362001)(44832011)(81166007)(110136005)(47076005)(36756003)(336012)(426003)(2616005)(26005)(40460700003)(6666004)(7696005)(83380400001)(7416002)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:32.7430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3218db-9319-4590-245c-08da26764aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 tools/perf/arch/x86/util/evsel.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c          |  7 +++++++
 tools/perf/util/evsel.h          |  1 +
 3 files changed, 39 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ac2899a25b7a..acaabdba5db8 100644
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
@@ -29,3 +31,32 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 
 	free(env.cpuid);
 }
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
+			pr_warning(
+"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
+"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
+			warned_once = 1;
+		}
+	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
+		if (attr->config & (1ULL << 16)) {
+			pr_warning(
+"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
+"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
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

