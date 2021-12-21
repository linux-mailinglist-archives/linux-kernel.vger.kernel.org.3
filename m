Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DA47C39A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhLUQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:17:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4315 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhLUQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:17:02 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJM3W4fBzz6H87X;
        Wed, 22 Dec 2021 00:14:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 17:16:59 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 16:16:55 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengjun.xing@linux.intel.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2] perf pmu: Fix alias events list
Date:   Wed, 22 Dec 2021 00:11:30 +0800
Message-ID: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
changes the event list for uncore PMUs or arm64 heterogeneous CPU systems,
such that duplicate aliases are incorrectly listed per PMU (which they
should not be), like:

./perf list
...
unc_cbo_cache_lookup.any_es
[Unit: uncore_cbox L3 Lookup any request that access cache and found
line in E or S-state]
unc_cbo_cache_lookup.any_es
[Unit: uncore_cbox L3 Lookup any request that access cache and found
line in E or S-state]
unc_cbo_cache_lookup.any_i
[Unit: uncore_cbox L3 Lookup any request that access cache and found
line in I-state]
unc_cbo_cache_lookup.any_i
[Unit: uncore_cbox L3 Lookup any request that access cache and found
line in I-state]
...

Notice how the events are listed twice.

The named commit changed how we remove duplicate events, in that events
for different PMUs are not treated as duplicates. I suppose this is to
handle how "Each hybrid pmu event has been assigned with a pmu name".

Fix PMU alias listing by restoring behaviour to remove duplicates for
non-hybrid PMUs.

Fixes: 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
Signed-off-by: John Garry <john.garry@huawei.com>
---

Difference in v2:
- Change duplicate check to explicitly check for hybrid PMU

@Zhengjun Xing, Can you please check this new version? Thanks! 

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6ae58406f4fc..8dfbba15aeb8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1659,6 +1659,21 @@ bool is_pmu_core(const char *name)
 	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
 }
 
+static bool pmu_alias_is_duplicate(struct sevent *alias_a,
+				   struct sevent *alias_b)
+{
+	/* Different names -> never duplicates */
+	if (strcmp(alias_a->name, alias_b->name))
+		return false;
+
+	/* Don't remove duplicates for hybrid PMUs */
+	if (perf_pmu__is_hybrid(alias_a->pmu) &&
+	    perf_pmu__is_hybrid(alias_b->pmu))
+		return false;
+
+	return true;
+}
+
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			bool long_desc, bool details_flag, bool deprecated,
 			const char *pmu_name)
@@ -1744,12 +1759,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		/* Skip duplicates */
-		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
-			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
-			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
-				continue;
-			}
-		}
+		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
+			continue;
 
 		if (name_only) {
 			printf("%s ", aliases[j].name);
-- 
2.26.2

