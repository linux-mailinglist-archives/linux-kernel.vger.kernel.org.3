Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B496490B42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiAQPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:15:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4420 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiAQPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:15:41 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JcwNg44Rnz6FCHy;
        Mon, 17 Jan 2022 23:11:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:15:38 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 15:15:35 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] perf test: Add pmu-events test for aliases with hyphens
Date:   Mon, 17 Jan 2022 23:10:14 +0800
Message-ID: <1642432215-234089-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
References: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for aliases with hyphens in the name to ensure that the
pmu-events tables are as expects. There should be no reason why these sort
of aliases would be treated differently, but no harm in checking.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/test/test_soc/cpu/uncore.json        | 16 ++++++++++
 tools/perf/tests/pmu-events.c                 | 32 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
index 73089c682f80..41bac1c6a008 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
@@ -18,6 +18,22 @@
 	    "Invert": "0",
 	    "EdgeDetect": "0"
   },
+  {
+	    "Unit": "CBO",
+	    "EventCode": "0xE0",
+	    "UMask": "0x00",
+	    "EventName": "event-hyphen",
+	    "BriefDescription": "UNC_CBO_HYPHEN",
+	    "PublicDescription": "UNC_CBO_HYPHEN"
+  },
+  {
+	    "Unit": "CBO",
+	    "EventCode": "0xC0",
+	    "UMask": "0x00",
+	    "EventName": "event-two-hyph",
+	    "BriefDescription": "UNC_CBO_TWO_HYPH",
+	    "PublicDescription": "UNC_CBO_TWO_HYPH"
+  },
   {
 	    "EventCode": "0x7",
 	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index df1c9a3cc05b..1c695fb5a79c 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -143,6 +143,34 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.matching_pmu = "uncore_cbox_0",
 };
 
+static const struct perf_pmu_test_event uncore_hyphen = {
+	.event = {
+		.name = "event-hyphen",
+		.event = "umask=0x00,event=0xe0",
+		.desc = "Unit: uncore_cbox UNC_CBO_HYPHEN",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_HYPHEN",
+		.pmu = "uncore_cbox",
+	},
+	.alias_str = "umask=0,event=0xe0",
+	.alias_long_desc = "UNC_CBO_HYPHEN",
+	.matching_pmu = "uncore_cbox_0",
+};
+
+static const struct perf_pmu_test_event uncore_two_hyph = {
+	.event = {
+		.name = "event-two-hyph",
+		.event = "umask=0x00,event=0xc0",
+		.desc = "Unit: uncore_cbox UNC_CBO_TWO_HYPH",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_TWO_HYPH",
+		.pmu = "uncore_cbox",
+	},
+	.alias_str = "umask=0,event=0xc0",
+	.alias_long_desc = "UNC_CBO_TWO_HYPH",
+	.matching_pmu = "uncore_cbox_0",
+};
+
 static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 	.event = {
 		.name = "uncore_hisi_l3c.rd_hit_cpipe",
@@ -188,6 +216,8 @@ static const struct perf_pmu_test_event uncore_imc_cache_hits = {
 static const struct perf_pmu_test_event *uncore_events[] = {
 	&uncore_hisi_ddrc_flux_wcmd,
 	&unc_cbo_xsnp_response_miss_eviction,
+	&uncore_hyphen,
+	&uncore_two_hyph,
 	&uncore_hisi_l3c_rd_hit_cpipe,
 	&uncore_imc_free_running_cache_miss,
 	&uncore_imc_cache_hits,
@@ -654,6 +684,8 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		},
 		.aliases = {
 			&unc_cbo_xsnp_response_miss_eviction,
+			&uncore_hyphen,
+			&uncore_two_hyph,
 		},
 	},
 	{
-- 
2.26.2

