Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995DC477673
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhLPP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:59:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4301 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhLPP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:58:57 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JFGvH1zSMz67w0f;
        Thu, 16 Dec 2021 23:56:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:58:55 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 15:58:52 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] perf pmu: Fix event list for uncore PMUs
Date:   Thu, 16 Dec 2021 23:53:37 +0800
Message-ID: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
changed the list for uncore PMUs, such that duplicate aliases are now
listed per PMU (which they should not be), like:

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

Fix uncore PMU alias list by also checking if events with PMU name are not
cpu PMUs.

Fixes: 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
Signed-off-by: John Garry <john.garry@huawei.com>
---
It would be helpful if someone with some of these hybrid CPU systems could
test this change, thanks!

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6ae58406f4fc..392f6a36418b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1659,6 +1659,24 @@ bool is_pmu_core(const char *name)
 	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
 }
 
+static bool pmu_alias_is_duplicate(struct sevent *alias_a,
+				   struct sevent *alias_b)
+{
+	/* Different names -> never duplicates */
+	if (strcmp(alias_a->name, alias_b->name))
+		return false;
+	if (!alias_a->pmu)
+		return true;
+	if (!alias_b->pmu)
+		return true;
+	if (!strcmp(alias_a->pmu, alias_b->pmu))
+		return true;
+	/* uncore PMUs */
+	if (!alias_a->is_cpu && !alias_b->is_cpu)
+		return true;
+	return false;
+}
+
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			bool long_desc, bool details_flag, bool deprecated,
 			const char *pmu_name)
@@ -1744,12 +1762,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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

