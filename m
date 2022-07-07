Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEF56AC45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiGGT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiGGT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:56:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC35C9CD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:56:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317f6128c86so134757037b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VTPpLSonRFchZeOdmeBL2sr3TWDo42K4dE3d7UKdw3M=;
        b=iZHOX2/vDNeRZKy3jhNTimAQoYKlKZbkEVCdFgHoeOXgGiyKdLv6IlSMbt5pXw1LK9
         SN/JPo+mr1yAbQMhnOsr8C4QZ/GzVOrHL24qVB2kG6U4WbwpUsw7uV5ScBZKHNZBO6LB
         CZI5snkNAurmla+akmvZnbZ3aiHcyvRFv8XF/lWcL/rg3uiOrRiQdNj+t0jIVY+9MUMs
         xgAY/Wa6ZqAo53/R1KKKovVxHxJxBdAf9GpjWjwGbhzJnPT1yGOG+yDGnw9CmUc+hxwq
         5zObhLY9rgC0XnGKwcNVVlj3VKNsUdwg9AabuuVOFf5xzL9/Gzb+0bUCe6+Gvc8belY9
         +H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VTPpLSonRFchZeOdmeBL2sr3TWDo42K4dE3d7UKdw3M=;
        b=Tca1IOLVFPrA1AcyACiNAB7XgIw3S9xIHJe8D3XgVkvwfOcIJYNbWoxEM8F3X3O1Na
         7ISF/Qrg0OLKYtkqyyB2TE0yLlxRQFADG7O5cqTNS1E91VSGSIMlUM6DYhLW8cQ4BACz
         mh8LWyoJVpqfLS9HXn0YjX2E5ozg2dxzUgdAKAR+RXTWQLynZXwed8b3qfK73wkrTggG
         OVhbvSIAKVVocEkGwBZSdMNB+OR/vKveiOH+rWRk7fYe74QDWzavT/Nye7HHE9R7Jove
         embv9MpWFE3fsjZopKuOchqNe7GfmtXdn5SpJQcW4cGqaHEI3N9vApw3kmus6FL88IyG
         8CPg==
X-Gm-Message-State: AJIora8wmjcQW1OwrD9lGg9zxrYMBG/DFrBNbJv3iAR4CCGH+KrJnMyP
        8QD/3stgqwT/DZGEP50wdqi+a+3Hx/cD
X-Google-Smtp-Source: AGRyM1sJh46RbpP41le7Fm7sV2oy0iqvhzP+SQGvIAeGeUn8NkZt29kJnOvblIQo00Pr8BQPfG6OSwtYhUyN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a0d:e8c8:0:b0:31d:555:b4ce with SMTP id
 r191-20020a0de8c8000000b0031d0555b4cemr6721011ywe.94.1657223777645; Thu, 07
 Jul 2022 12:56:17 -0700 (PDT)
Date:   Thu,  7 Jul 2022 12:56:10 -0700
Message-Id: <20220707195610.303254-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4] perf evlist: Remove group option.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The group option predates grouping events using curly braces added in
commit 89efb029502d ("perf tools: Add support to parse event group syntax")
The --group option was retained for legacy support (in August 2012) but
keeping it adds complexity.

v2, v3 and v4 were rebases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ----
 tools/perf/Documentation/perf-top.txt    |  7 ++-----
 tools/perf/builtin-record.c              |  2 --
 tools/perf/builtin-stat.c                |  6 ------
 tools/perf/builtin-top.c                 |  2 --
 tools/perf/tests/attr/README             |  2 --
 tools/perf/tests/attr/test-record-group  | 22 ----------------------
 tools/perf/tests/attr/test-stat-group    | 17 -----------------
 tools/perf/util/evlist.c                 |  2 +-
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/python.c                 |  8 --------
 tools/perf/util/record.c                 |  7 -------
 tools/perf/util/record.h                 |  1 -
 13 files changed, 3 insertions(+), 79 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group
 delete mode 100644 tools/perf/tests/attr/test-stat-group

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6bd6d07021ba..cd6ce29854b0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -238,10 +238,6 @@ OPTIONS
 	Also, by adding a comma, the number of mmap pages for AUX
 	area tracing can be specified.
 
---group::
-	Put all events in a single event group.  This precedes the --event
-	option and remains only for backward compatibility.  See --event.
-
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
 	kernel space and user space.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index c1fdba26bf53..e534d709cc5a 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -51,9 +51,6 @@ Default is to monitor all CPUS.
 --count-filter=<count>::
 	Only display functions with more events than this.
 
---group::
-        Put the counters into a counter group.
-
 --group-sort-idx::
 	Sort the output by the event at the index n in group. If n is invalid,
 	sort by the first event. It can support multiple groups with different
@@ -313,10 +310,10 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
 
 		perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
 
-	   Alternatively one can ask for --group and then two overhead columns
+	   Alternatively one can ask for a group and then two overhead columns
            will appear, the first for cycles and the second for the switch-on event.
 
-		perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+		perf top -e '{cycles,probe:icmp_rcv}' --switch-on=probe:icmp_rcv
 
 	This may be interesting to measure a workload only after some initialization
 	phase is over, i.e. insert a perf probe at that point and use the above
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cf5c5379ceaa..04a016520b7e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3197,8 +3197,6 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_BOOLEAN(0, "group", &record.opts.group,
-		    "put the counters into a counter group"),
 	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ce87a8eb7d7..225b63234e6c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -180,7 +180,6 @@ static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static int			big_num_opt			=  -1;
-static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
@@ -816,9 +815,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		child_pid = evsel_list->workload.pid;
 	}
 
-	if (group)
-		evlist__set_leader(evsel_list);
-
 	if (!cpu_map__is_dummy(evsel_list->core.user_requested_cpus)) {
 		if (affinity__setup(&saved_affinity) < 0)
 			return -1;
@@ -1228,8 +1224,6 @@ static struct option stat_options[] = {
 #endif
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
-	OPT_BOOLEAN('g', "group", &group,
-		    "put the counters into a counter group"),
 	OPT_BOOLEAN(0, "scale", &stat_config.scale,
 		    "Use --no-scale to disable counter scaling for multiplexing"),
 	OPT_INCR('v', "verbose", &verbose,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fd8fd913c533..44c8bf33ce81 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1470,8 +1470,6 @@ int cmd_top(int argc, const char **argv)
 			    "dump the symbol table used for profiling"),
 	OPT_INTEGER('f', "count-filter", &top.count_filter,
 		    "only display functions with more events than this"),
-	OPT_BOOLEAN(0, "group", &opts->group,
-			    "put the counters into a counter group"),
 	OPT_BOOLEAN('i', "no-inherit", &opts->no_inherit,
 		    "child tasks do not inherit counters"),
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index eb3f7d4bb324..4066fec7180a 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -49,7 +49,6 @@ Following tests are defined (with perf commands):
   perf record --call-graph dwarf kill		(test-record-graph-dwarf)
   perf record --call-graph fp kill              (test-record-graph-fp)
   perf record --call-graph fp kill              (test-record-graph-fp-aarch64)
-  perf record --group -e cycles,instructions kill (test-record-group)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
   perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
   perf record -D kill                           (test-record-no-delay)
@@ -66,6 +65,5 @@ Following tests are defined (with perf commands):
   perf stat -d kill                             (test-stat-detailed-1)
   perf stat -dd kill                            (test-stat-detailed-2)
   perf stat -ddd kill                           (test-stat-detailed-3)
-  perf stat --group -e cycles,instructions kill (test-stat-group)
   perf stat -e '{cycles,instructions}' kill     (test-stat-group1)
   perf stat -i -e cycles kill                   (test-stat-no-inherit)
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
deleted file mode 100644
index 14ee60fd3f41..000000000000
--- a/tools/perf/tests/attr/test-record-group
+++ /dev/null
@@ -1,22 +0,0 @@
-[config]
-command = record
-args    = --no-bpf-event --group -e cycles,instructions kill >/dev/null 2>&1
-ret     = 1
-
-[event-1:base-record]
-fd=1
-group_fd=-1
-sample_type=327
-read_format=4
-
-[event-2:base-record]
-fd=2
-group_fd=1
-config=1
-sample_type=327
-read_format=4
-mmap=0
-comm=0
-task=0
-enable_on_exec=0
-disabled=0
diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
deleted file mode 100644
index e15d6946e9b3..000000000000
--- a/tools/perf/tests/attr/test-stat-group
+++ /dev/null
@@ -1,17 +0,0 @@
-[config]
-command = stat
-args    = --group -e cycles,instructions kill >/dev/null 2>&1
-ret     = 1
-
-[event-1:base-stat]
-fd=1
-group_fd=-1
-read_format=3|15
-
-[event-2:base-stat]
-fd=2
-group_fd=1
-config=1
-disabled=0
-enable_on_exec=0
-read_format=3|15
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 48af7d379d82..4cc5c417d4a2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -224,7 +224,7 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	return err;
 }
 
-void evlist__set_leader(struct evlist *evlist)
+static void evlist__set_leader(struct evlist *evlist)
 {
 	perf_evlist__set_leader(&evlist->core);
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1bde9ccf4e7d..4cc31570d3d6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -206,8 +206,6 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 int evlist__create_maps(struct evlist *evlist, struct target *target);
 int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
-void evlist__set_leader(struct evlist *evlist);
-
 u64 __evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_branch_type(struct evlist *evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5be5fa2391de..53d70cda6063 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1134,14 +1134,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
 	struct evlist *evlist = &pevlist->evlist;
-	int group = 0;
-	static char *kwlist[] = { "group", NULL };
-
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
-		return NULL;
-
-	if (group)
-		evlist__set_leader(evlist);
 
 	if (evlist__open(evlist) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index b529636ab3ea..1744b8eaf63e 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	bool use_comm_exec;
 	bool sample_id = opts->sample_id;
 
-	/*
-	 * Set the evsel leader links before we configure attributes,
-	 * since some might depend on this info.
-	 */
-	if (opts->group)
-		evlist__set_leader(evlist);
-
 	if (perf_cpu_map__cpu(evlist->core.user_requested_cpus, 0).cpu < 0)
 		opts->no_inherit = true;
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 4269e916f450..46212bf020cf 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -13,7 +13,6 @@ struct option;
 
 struct record_opts {
 	struct target target;
-	bool	      group;
 	bool	      inherit_stat;
 	bool	      no_buffering;
 	bool	      no_inherit;
-- 
2.37.0.rc0.161.g10f37bed90-goog

