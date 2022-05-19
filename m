Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE252CB94
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiESFoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiESFow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:44:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9868BA573;
        Wed, 18 May 2022 22:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcY3bLeTMq7o+adbAJJ9n3/uyCojTPw0NrWHn/YDlVDTB8KezPj01gMpTvSF1+9YUorA/8kf0Nd+jqUWEbx8w+q1Dzp6gAEICshRbMY6NtJMXTzHtVFpCy4HUrXW2A8shX7JiQNmfVBEJsdYeJbnuhkoUMC8Q1KjGfLTPa12+IlybpyRAfmzRSVn8YxpxlRTu6hw7KEw+sF1vZHZazd2rqq8YSZcFOPuOLyVP8v6G89Q6+MiNo3JCjeE/bp4aX72q/KwZUDaqb/dwhDtz62dT+WFphNkDmmezOPBw9ebjjoiKZup9/1nykguvQ61asRNCLxejsTp1JjpRZDeCqXp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W+PgoL/IpgUl82UNdk7+TwuHNX7mjtPDS3dZfSdG3g=;
 b=mbYH6WmMXZa2ukamqYJElKPOyggXKPFiMOhoObWZMIQ8EzGaevZzqFZ8D4IzrfZtku2vgfCFWWWGWYVquiD3B/qIkukgF+wwxZzlyRmKsZeTQ1npJwC+oRp0XSlDvY6inq8kIge7v5pyTQ1CjYxi4fRY1HbVeX+l5m1ryKHWV0GJTFbxY0zgRf5iBscv5ms0vQaByrAET5QqfOkCT3e2V6IzfVHXZ7nVuy6rZGH6sa3kNrp1gRpAFrW4rXqlbc9gXwcwHb6C4H7caAF7hI1XQGtZdRjeDPAi5+V5iur4MrxolCPO9G6Y8F0mdyXjSzaEabggF2GzZgOH9rn5yFu5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W+PgoL/IpgUl82UNdk7+TwuHNX7mjtPDS3dZfSdG3g=;
 b=dCccD6smoo8YA2yQY8jgm5U4RLwLGvQapTFixvLhKkL5oVm6TTE53i2gpSMFiCw49Aqh9NNYhZij8AZUFIvbr1472Ks8v0q0QkAetivjR6Cj4qTl9bW8Ig14VexS39BsOg/WV9/9CYwGKk4M+9Wx8WVjdkDZsr1ZaQ6d6GOzWZg=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by BN8PR12MB2899.namprd12.prod.outlook.com (2603:10b6:408:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Thu, 19 May
 2022 05:44:48 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::6d) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Thu, 19 May 2022 05:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:44:47 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:44:35 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <rrichter@amd.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <irogers@google.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 1/5] perf record ibs: Warn about sampling period skew
Date:   Thu, 19 May 2022 11:13:51 +0530
Message-ID: <20220519054355.477-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519054355.477-1-ravi.bangoria@amd.com>
References: <20220519054355.477-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b45d1ed-7b43-4dcc-e1b7-08da395aaf1b
X-MS-TrafficTypeDiagnostic: BN8PR12MB2899:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB289915FF28952FB57B990897E0D09@BN8PR12MB2899.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUyHlHCkzNE9eP4GiUjqg+a967ME2pNFBq38iO5fupyJc0HVl0HWmfIdaXa8L3SH8Adf/LNprYVHSOJVb0Xr1hcBs7XqKTfDpgRdO8Ccox+gQIWtb+TX7NIScGbubwTiQ4NRgd89eiXZ8NObpkmKdh6JFGwFls7QwVK6GD/UeGiw+BNiPap4AvFqVQCrv+PAoIkzYh0fvW0M8qBtFFsv4x+ZSKCbpg7PAUQcf/8IjZtpaVVxcSCr2CLK7fxx34UEhb5ofzQ7ampKhTkNpc3nyNhE3F4Kw5H4DAjWgXqzn6Eplvj8F/wTI8S2Efx6khevePD0hGcypwd1st0dxdVqv3zUuWTf432/KEPlgpSE1wde6vF5/xZ1zhTijHOOvfgqyRn+Y+OtzRfsjLhiNxQKFVhkpFR9/NJaLVngb2U3eU2+BB3LDYMd90BPN0+3xkA4uSh7WWQJDVo09AL3N8KAYIAqgN4UdeVPAWHlvrLhLsSzhtBKAMHGfgLDI8NYEtqQ3bu2NXi6Ifhai2oHV5xTJ1Z9589YKsi/QTbNjiRNFSd5mOj2XGXoDz+TTmB6lLYHeiDB1WsZiEpSPI/9Xr8zBznE/Mbz5cKWpeblypMicTxjU5gHlkC6u/EJUXozhkjaTf1EodBeakhce293dJVv7z9vU5tOOZ+7GQhODN4XvuXis1PVuzzRjUjKfntl7TLXEA30In/t9jXv9Vr0qdgFFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(8676002)(4326008)(2616005)(26005)(186003)(16526019)(70206006)(70586007)(36860700001)(1076003)(82310400005)(83380400001)(8936002)(508600001)(81166007)(426003)(7696005)(336012)(47076005)(86362001)(356005)(40460700003)(7416002)(316002)(5660300002)(6666004)(36756003)(54906003)(2906002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:44:47.2151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b45d1ed-7b43-4dcc-e1b7-08da395aaf1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2899
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
2.27.0

