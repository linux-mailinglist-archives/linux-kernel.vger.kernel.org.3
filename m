Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC511463D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhK3RyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244811AbhK3Rxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:53:53 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08625C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:50:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x3-20020a17090a1f8300b001a285b9f2cbso7168736pja.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KiCz3H5tdXkEbVfso8mDhZdEvp8PjEmgkQ1PXwPZG3Y=;
        b=oN1EhBqjyTaJsgzHaZkerl9/TWhUU6QQzLU3hlilqoUKxaEwPnMevQlR6Tnfl3vleJ
         SNshsukX9eSBTi2oVaG2j2nlyfq5i2Ddw+b3FHvqg7stNcHdvQba7kPInJrpUiCJRsVX
         Vh+l/H3m9BgVxTwUi8CPZz4lHjP0AjgbXbFRjXYhaE8SGDaGd2hyfCDiVVY+xVbtQzEq
         Ll6263efqsNy6MBASWI9agMSP58lN0z+yW+0iWkPNoOLKc4Ml9zwh6aqG9umBdufgp05
         sCNaPUYSY9FYCHT8IbbWub7cW51GhdRsiOMSJGd7uwkh/N9TeYmvvozH56QmgnTFaxRv
         FEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KiCz3H5tdXkEbVfso8mDhZdEvp8PjEmgkQ1PXwPZG3Y=;
        b=PiGhn16nlUtuW53Xu08XJXlcRBHxqkNjzpk3rgI4HqS3L5e22y/t5Vhdhx/vrWmRzo
         TFruGYaFaYUNzLuhGngQRsFASeWEDnst5/FG4fcsE+97WRPbLnK0jzOh4HMm9fcYQ4Wj
         hl4QwuAO5EV35JUYvc3qs11ZxEooUVefAP56WXr2z6bF7F1xiXrSZMUQFO+PmY1qHtpM
         v7nws1xBwFGbEeQvpYw4BaKcH48Khf9x4CvSxB3umkt1YoD0jcML+8Yy8rRgBGrigg3r
         2erkqK25vSaspoHqe0dYyfKeo0CVCCzjLmmBYin6rUjGHT+Rzj4ahk1JjXLwVAGnW5D7
         3U3Q==
X-Gm-Message-State: AOAM531EH4FhSaWFClBisqX4cN5ZNxKeoZR/d/PV12hgUVSOFP6z608x
        7ehafbIU1qaQ7ppjkLTsM3swqoioIie7
X-Google-Smtp-Source: ABdhPJyMX+za+dRQ9OY5tluXtc4ZIXqWSdZxJs8B+y/Hi53vXdCkv98q84YI3yjI3tlSGfRlowjIorghKoR7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e82d:9b6a:8f25:a0c4])
 (user=irogers job=sendgmr) by 2002:a63:a45:: with SMTP id z5mr517223pgk.392.1638294631404;
 Tue, 30 Nov 2021 09:50:31 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:49:44 -0800
Message-Id: <20211130174945.247604-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 1/2] perf evlist: Allow setting arbitrary leader
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leader of a group is the first, but allow it to be an arbitrary
list member so that for Intel topdown events slots may always be the
group leader.

v3. Switched list_entry to list_first_entry as suggested by Arnaldo
    Carvalho de Melo <acme@kernel.org>.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 15 +++++++++------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/parse-events.c           |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e37dfad31383..245acbc53bd3 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
 
-void __perf_evlist__set_leader(struct list_head *list)
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *evsel, *leader;
+	struct perf_evsel *first, *last, *evsel;
 
-	leader = list_entry(list->next, struct perf_evsel, node);
-	evsel = list_entry(list->prev, struct perf_evsel, node);
+	first = list_first_entry(list, struct perf_evsel, node);
+	last = list_last_entry(list, struct perf_evsel, node);
 
-	leader->nr_members = evsel->idx - leader->idx + 1;
+	leader->nr_members = last->idx - first->idx + 1;
 
 	__perf_evlist__for_each_entry(list, evsel)
 		evsel->leader = leader;
@@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
 void perf_evlist__set_leader(struct perf_evlist *evlist)
 {
 	if (evlist->nr_entries) {
+		struct perf_evsel *first = list_entry(evlist->entries.next,
+						struct perf_evsel, node);
+
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f366dbad6a88..6f74269a3ad4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
-void __perf_evlist__set_leader(struct list_head *list);
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..c2935aca4b67 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__perf_evlist__set_leader(list);
-	leader = list_entry(list->next, struct evsel, core.node);
+	leader = list_first_entry(list, struct evsel, core.node);
+	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

