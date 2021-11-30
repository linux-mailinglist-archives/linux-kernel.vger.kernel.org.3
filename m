Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE61463D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbhK3RyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbhK3Rxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:53:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:50:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so7174543pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U7Dg4oC6ocI6CKoM5ppGQzNQ8+x/PuBIGi6e9CNMLeo=;
        b=lF5kq7u970hI06+7XOMiUavCelRFw04N2y9gtg/63mkWvUw1xh1uE+Eec4LFYOLuGn
         GFpuUgUxkQ+o/gN5za0LkBM4IzuZ/Ghg0DzmGAyNbaIYa3htr+EFlq48VWW4ygu7Z132
         CU2K0+MNrYX6SmOiwYv2QsrP+PUUhrC4mf0pAdm6OOKIP8tuPKALQ2ikolzfPZQ4zg1n
         gVfakzZCbZqiKhdniWaw7zDFHNpVEKshn2z8wfDwTwwbE3mW8KbH9im0ens4fXiJqEJ9
         HOLqm28CdBaTWX0tMXb9jr+BCXJ7+M4R2Flhj3ZNzjcnQkkzAe0uHYBQWLk1xttvU3jT
         vvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U7Dg4oC6ocI6CKoM5ppGQzNQ8+x/PuBIGi6e9CNMLeo=;
        b=WZC3a5KSm7+m2EZwnG9FO3iPsQ9wz+ZkKB2PjYAwMqU9cK6o6Af/olx5Ie4GvvKgLW
         BaMHE4AWuSJ5m7Iz6SxcbfPR5psWBr3k6A8d80Zny1lxzKLZKhjvD3GkacHIWRws5471
         bvw14y4+7XarHRTfcNBHNV+bAQLo4tMQ8F5SH9WwidvxiZIsQ8uN7SjAvvyJyjR3KX/7
         QzGMIsSnCMptvDB5DFYnS5T1PNfNkjdP5ICjx2oBopCJGrlFpibWopX2y87SG7a03o87
         EOl7xLODknympA9gFGNN09jsN73PfZG5uLV66NwORUzBvUQq7R9ousjXcHZSidJP4/RX
         gCPQ==
X-Gm-Message-State: AOAM533HjPLBgafLv3k2Ap2fCYZmkR7AS162YHS/RJLD8EFNXz3VRVZP
        hmzhS+Wh1ELpLv80KIn4Ha9sGzi8wlyQ
X-Google-Smtp-Source: ABdhPJxK6lgVlN0HFqo+M1P2HL7Jl+LjlkTWYli9UlFEEfF2OEBgEBbeQJTD+Km4IzmTRHmfKTQ8+Jdl5kMv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e82d:9b6a:8f25:a0c4])
 (user=irogers job=sendgmr) by 2002:a63:8641:: with SMTP id
 x62mr531580pgd.232.1638294633536; Tue, 30 Nov 2021 09:50:33 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:49:45 -0800
In-Reply-To: <20211130174945.247604-1-irogers@google.com>
Message-Id: <20211130174945.247604-2-irogers@google.com>
Mime-Version: 1.0
References: <20211130174945.247604-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 2/2] perf parse-events: Architecture specific leader override
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

Currently topdown events must appear after a slots event:

$ perf stat -e '{slots,topdown-fe-bound}' /bin/true

 Performance counter stats for '/bin/true':

         3,183,090      slots
           986,133      topdown-fe-bound

Reversing the events yields:

$ perf stat -e '{topdown-fe-bound,slots}' /bin/true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).

For metrics the order of events is determined by iterating over a
hashmap, and so slots isn't guaranteed to be first which can yield this
error.

Change the set_leader in parse-events, called when a group is closed, so
that rather than always making the first event the leader, if the slots
event exists then it is made the leader. It is then moved to the head of
the evlist otherwise it won't be opened in the correct order.

The result is:

$ perf stat -e '{topdown-fe-bound,slots}' /bin/true

 Performance counter stats for '/bin/true':

         3,274,795      slots
         1,001,702      topdown-fe-bound

A problem with this approach is the slots event is identified by name,
names can be overwritten like 'cpu/slots,name=foo/' and this causes the
leader change to fail.

The change also modifies and fixes mixed groups like, with the change:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

        5574985410      slots
         971981616      instructions
        1348461887      topdown-fe-bound

       2.001263120 seconds time elapsed

Without the change:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

     <not counted>      instructions
     <not counted>      slots
   <not supported>      topdown-fe-bound

       2.006247990 seconds time elapsed

Something that may be undesirable here is that the events are reordered
in the output.

v2. Move the list_move operation into parse_events__set_leader as
    suggested by Jiri Olsa <jolsa@redhat.com>.

v3. Switched list_entry to list_first_entry as suggested by Arnaldo
    Carvalho de Melo <acme@kernel.org>.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
 tools/perf/util/evlist.h          |  1 +
 tools/perf/util/parse-events.c    |  8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 0b0951030a2f..f924246eff78 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
 	else
 		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
 }
+
+struct evsel *arch_evlist__leader(struct list_head *list)
+{
+	struct evsel *evsel, *first;
+
+	first = list_first_entry(list, struct evsel, core.node);
+
+	if (!pmu_have_event("cpu", "slots"))
+		return first;
+
+	__evlist__for_each_entry(list, evsel) {
+		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
+			evsel->name && strstr(evsel->name, "slots"))
+			return evsel;
+	}
+	return first;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..993437ffe429 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
 	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
 int arch_evlist__add_default_attrs(struct evlist *evlist);
+struct evsel *arch_evlist__leader(struct list_head *list);
 
 int evlist__add_dummy(struct evlist *evlist);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c2935aca4b67..1faf3c19430b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1821,6 +1821,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	return ret;
 }
 
+__weak struct evsel *arch_evlist__leader(struct list_head *list)
+{
+	return list_first_entry(list, struct evsel, core.node);
+}
+
 void parse_events__set_leader(char *name, struct list_head *list,
 			      struct parse_events_state *parse_state)
 {
@@ -1834,9 +1839,10 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	leader = list_first_entry(list, struct evsel, core.node);
+	leader = arch_evlist__leader(list);
 	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
+	list_move(&leader->core.node, list);
 }
 
 /* list_event is assumed to point to malloc'ed memory */
-- 
2.34.0.rc2.393.gf8c9666880-goog

