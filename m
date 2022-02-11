Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B54B233B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiBKKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349018AbiBKKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4CF03
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v134-20020a25618c000000b00620dc86b9d6so10533719ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q8G14SAEa7uvFBFKYlo5q0orDY3ugG7lRFTfspG1Us0=;
        b=FwigVHlABX1R9xopZ1QIVsESmoMSH6rcpeBlxM37cWyrtfo8Na0UI9actTepeXh0Ae
         nfo8awP8PtTXMgd92hbHUSnujM/pMAbNuvCT/+UJrNWBi/hSUB7XliUkgGyxYv5nmCBS
         1sUBkEWmzzpatEbfWDQL4enX1ikwEJRjKtb5/g9ba+aBBj1i6T/wofaFMxZZcy+Ed2mt
         DkMG+M26abzPDmKK1zxnlnqCFnfNEVCW4qQHeBl3w/CfeijdPZ6VxYUWoplVrCW+z5jD
         eSs7vYtD/HdKtc3A5A0W5mMCwPlziwEujBlZx4EmWILDJKQXh9aulbsGcFPlifEYvhfr
         PFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q8G14SAEa7uvFBFKYlo5q0orDY3ugG7lRFTfspG1Us0=;
        b=iO1dvfbLhst6XrCt4yGSyysxGtj1kLG/CGPOmnTWST3bc9tbHP3MA6JmukfzhsOJlg
         rJY30cPuGqSRjZHs8o8RmL/XajNqS2Eiz7kVR91/EWVRvnQjc0V//gFFRxXXun/m1ix1
         /qCh5kd1PEVosC1AD7nyBGX/vMhMZrr3ayi91V6tgyvhORNdEF+Ig9y2l98rJbcwqS5f
         srX2JB0o1IhjUeyBdDbf1p5LeuCYjntGqx4uB08sW1OjWgPdH5g/rabexsfiSG2taeJB
         MW9RoZE4T5pxA4pbKgJ9u5jlE/5dKXswHAXffM+YQS0fP2239wgWny6ohb6OKKe5X9or
         Ig1w==
X-Gm-Message-State: AOAM532gRhXMWwd0EBzcUbJrrqMYunCCCUKbRQRp6oyBz+CtDw4ovqyM
        AjW5JzJlYIbOdO2kOdAlio8uITwSl5+i
X-Google-Smtp-Source: ABdhPJz6VWRRigwUwx8Pzmr7Q/qEuaNnd4Q5QLLowxQSdqlEbXhZEZbQyT6q2aT5O8E6vi6g/JZla4Hm8u6+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:e40a:: with SMTP id
 r10mr906703ywl.276.1644575695597; Fri, 11 Feb 2022 02:34:55 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:07 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-15-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 14/22] perf maps: Add functions to access maps
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce functions to access struct maps. These functions reduce the
number of places reference counting is necessary. While tidying APIs do
some small const-ification, in particlar to unwind_libunwind_ops.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  |  7 +-
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/ui/browsers/hists.c                |  3 +-
 tools/perf/util/callchain.c                   |  9 +--
 tools/perf/util/db-export.c                   | 12 ++--
 tools/perf/util/dlfilter.c                    |  8 ++-
 tools/perf/util/event.c                       |  4 +-
 tools/perf/util/hist.c                        |  2 +-
 tools/perf/util/machine.c                     |  2 +-
 tools/perf/util/map.c                         | 14 ++--
 tools/perf/util/maps.c                        | 69 +++++++++++--------
 tools/perf/util/maps.h                        | 47 ++++++++++---
 .../scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/sort.c                        |  2 +-
 tools/perf/util/symbol-elf.c                  |  2 +-
 tools/perf/util/symbol.c                      | 36 +++++-----
 tools/perf/util/thread-stack.c                |  4 +-
 tools/perf/util/thread.c                      |  4 +-
 tools/perf/util/unwind-libunwind-local.c      | 16 +++--
 tools/perf/util/unwind-libunwind.c            | 30 +++++---
 20 files changed, 170 insertions(+), 105 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 895f5fc23965..b64013a87c54 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -98,10 +98,11 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 	if (!c)
 		return NULL;
 
-	if (c->sample->ip && !c->sample->insn_len &&
-	    c->al->thread->maps && c->al->thread->maps->machine)
-		script_fetch_insn(c->sample, c->al->thread, c->al->thread->maps->machine);
+	if (c->sample->ip && !c->sample->insn_len && c->al->thread->maps) {
+		struct machine *machine =  maps__machine(c->al->thread->maps);
 
+		script_fetch_insn(c->sample, c->al->thread, machine);
+	}
 	if (!c->sample->insn_len)
 		Py_RETURN_NONE; /* N.B. This is a return statement */
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 5610767b407f..6eafe36a8704 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -268,7 +268,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		len = al.map->end - addr;
 
 	/* Read the object code using perf */
-	ret_len = dso__data_read_offset(al.map->dso, thread->maps->machine,
+	ret_len = dso__data_read_offset(al.map->dso, maps__machine(thread->maps),
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b72ee6822222..572ff38ceb0f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3139,7 +3139,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'k':
 			if (browser->selection != NULL)
-				hists_browser__zoom_map(browser, browser->selection->maps->machine->vmlinux_map);
+				hists_browser__zoom_map(browser,
+					      maps__machine(browser->selection->maps)->vmlinux_map);
 			continue;
 		case 'V':
 			verbose = (verbose + 1) % 4;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5c27a4b2e7a7..61bb3fb2107a 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1106,6 +1106,8 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
+	struct machine *machine = maps__machine(node->ms.maps);
+
 	al->maps = node->ms.maps;
 	al->map = node->ms.map;
 	al->sym = node->ms.sym;
@@ -1118,9 +1120,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-
-	if (al->maps == machine__kernel_maps(al->maps->machine)) {
-		if (machine__is_host(al->maps->machine)) {
+	if (al->maps == machine__kernel_maps(machine)) {
+		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
 		} else {
@@ -1128,7 +1129,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			al->level = 'g';
 		}
 	} else {
-		if (machine__is_host(al->maps->machine)) {
+		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_USER;
 			al->level = '.';
 		} else if (perf_guest) {
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index e0d4f08839fb..1cfcfdd3cf52 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = al->map->dso;
 
-		err = db_export__dso(dbe, dso, al->maps->machine);
+		err = db_export__dso(dbe, dso, maps__machine(al->maps));
 		if (err)
 			return err;
 		*dso_db_id = dso->db_id;
@@ -354,19 +354,21 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
+	struct machine *machine;
 	int err;
 
 	err = db_export__evsel(dbe, evsel);
 	if (err)
 		return err;
 
-	err = db_export__machine(dbe, al->maps->machine);
+	machine = maps__machine(al->maps);
+	err = db_export__machine(dbe, machine);
 	if (err)
 		return err;
 
-	main_thread = thread__main_thread(al->maps->machine, thread);
+	main_thread = thread__main_thread(machine, thread);
 
-	err = db_export__threads(dbe, thread, main_thread, al->maps->machine, &comm);
+	err = db_export__threads(dbe, thread, main_thread, machine, &comm);
 	if (err)
 		goto out_put;
 
@@ -380,7 +382,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (dbe->cpr) {
-		struct call_path *cp = call_path_from_sample(dbe, al->maps->machine,
+		struct call_path *cp = call_path_from_sample(dbe, machine,
 							     thread, sample,
 							     evsel);
 		if (cp) {
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index db964d5a52af..d59462af15f1 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -197,8 +197,12 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 		if (!al->thread && machine__resolve(d->machine, al, d->sample) < 0)
 			return NULL;
 
-		if (al->thread->maps && al->thread->maps->machine)
-			script_fetch_insn(d->sample, al->thread, al->thread->maps->machine);
+		if (al->thread->maps) {
+			struct machine *machine = maps__machine(al->thread->maps);
+
+			if (machine)
+				script_fetch_insn(d->sample, al->thread, machine);
+		}
 	}
 
 	if (!d->sample->insn_len)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 6439c888ae38..40a3b1a35613 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -571,7 +571,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
 	struct maps *maps = thread->maps;
-	struct machine *machine = maps->machine;
+	struct machine *machine = maps__machine(maps);
 	bool load_map = false;
 
 	al->maps = maps;
@@ -636,7 +636,7 @@ struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
 				struct addr_location *al)
 {
 	struct map *map = thread__find_map(thread, cpumode, addr, al);
-	struct machine *machine = thread->maps->machine;
+	struct machine *machine = maps__machine(thread->maps);
 	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
 
 	if (map || addr_cpumode == cpumode)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0a8033b09e28..78f9fbb925a7 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -237,7 +237,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->cgroup) {
 		const char *cgrp_name = "unknown";
-		struct cgroup *cgrp = cgroup__find(h->ms.maps->machine->env,
+		struct cgroup *cgrp = cgroup__find(maps__machine(h->ms.maps)->env,
 						   h->cgroup);
 		if (cgrp != NULL)
 			cgrp_name = cgrp->name;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fa25174cabf7..88279008e761 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2739,7 +2739,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 static u64 get_leaf_frame_caller(struct perf_sample *sample,
 		struct thread *thread, int usr_idx)
 {
-	if (machine__normalized_is(thread->maps->machine, "arm64"))
+	if (machine__normalized_is(maps__machine(thread->maps), "arm64"))
 		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
 	else
 		return 0;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 166c84c829f6..57e926ce115f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -220,7 +220,7 @@ bool __map__is_kernel(const struct map *map)
 {
 	if (!map->dso->kernel)
 		return false;
-	return machine__kernel_map(map__kmaps((struct map *)map)->machine) == map;
+	return machine__kernel_map(maps__machine(map__kmaps((struct map *)map))) == map;
 }
 
 bool __map__is_extra_kernel_map(const struct map *map)
@@ -461,11 +461,15 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 	 * kcore may not either. However the trampoline object code is on the
 	 * main kernel map, so just use that instead.
 	 */
-	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps && kmap->kmaps->machine) {
-		struct map *kernel_map = machine__kernel_map(kmap->kmaps->machine);
+	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps) {
+		struct machine *machine = maps__machine(kmap->kmaps);
 
-		if (kernel_map)
-			map = kernel_map;
+		if (machine) {
+			struct map *kernel_map = machine__kernel_map(machine);
+
+			if (kernel_map)
+				map = kernel_map;
+		}
 	}
 
 	if (!map->dso->adjust_symbols)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index beb09b9a122c..9fc3e7186b8e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -13,7 +13,7 @@
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	maps->entries = RB_ROOT;
-	init_rwsem(&maps->lock);
+	init_rwsem(maps__lock(maps));
 	maps->machine = machine;
 	maps->last_search_by_name = NULL;
 	maps->nr_maps = 0;
@@ -32,7 +32,7 @@ static void __maps__free_maps_by_name(struct maps *maps)
 
 static int __maps__insert(struct maps *maps, struct map *map)
 {
-	struct rb_node **p = &maps->entries.rb_node;
+	struct rb_node **p = &maps__entries(maps)->rb_node;
 	struct rb_node *parent = NULL;
 	const u64 ip = map->start;
 	struct map_rb_node *m, *new_rb_node;
@@ -54,7 +54,7 @@ static int __maps__insert(struct maps *maps, struct map *map)
 	}
 
 	rb_link_node(&new_rb_node->rb_node, parent, p);
-	rb_insert_color(&new_rb_node->rb_node, &maps->entries);
+	rb_insert_color(&new_rb_node->rb_node, maps__entries(maps));
 	map__get(map);
 	return 0;
 }
@@ -63,7 +63,7 @@ int maps__insert(struct maps *maps, struct map *map)
 {
 	int err;
 
-	down_write(&maps->lock);
+	down_write(maps__lock(maps));
 	err = __maps__insert(maps, map);
 	if (err)
 		goto out;
@@ -84,10 +84,11 @@ int maps__insert(struct maps *maps, struct map *map)
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
 	 */
-	if (maps->maps_by_name) {
-		if (maps->nr_maps > maps->nr_maps_allocated) {
-			int nr_allocate = maps->nr_maps * 2;
-			struct map **maps_by_name = realloc(maps->maps_by_name, nr_allocate * sizeof(map));
+	if (maps__maps_by_name(maps)) {
+		if (maps__nr_maps(maps) > maps->nr_maps_allocated) {
+			int nr_allocate = maps__nr_maps(maps) * 2;
+			struct map **maps_by_name = realloc(maps__maps_by_name(maps),
+							    nr_allocate * sizeof(map));
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
@@ -98,17 +99,17 @@ int maps__insert(struct maps *maps, struct map *map)
 			maps->maps_by_name = maps_by_name;
 			maps->nr_maps_allocated = nr_allocate;
 		}
-		maps->maps_by_name[maps->nr_maps - 1] = map;
+		maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] = map;
 		__maps__sort_by_name(maps);
 	}
 out:
-	up_write(&maps->lock);
+	up_write(maps__lock(maps));
 	return err;
 }
 
 static void __maps__remove(struct maps *maps, struct map_rb_node *rb_node)
 {
-	rb_erase_init(&rb_node->rb_node, &maps->entries);
+	rb_erase_init(&rb_node->rb_node, maps__entries(maps));
 	map__put(rb_node->map);
 	free(rb_node);
 }
@@ -117,7 +118,7 @@ void maps__remove(struct maps *maps, struct map *map)
 {
 	struct map_rb_node *rb_node;
 
-	down_write(&maps->lock);
+	down_write(maps__lock(maps));
 	if (maps->last_search_by_name == map)
 		maps->last_search_by_name = NULL;
 
@@ -125,9 +126,9 @@ void maps__remove(struct maps *maps, struct map *map)
 	assert(rb_node->map == map);
 	__maps__remove(maps, rb_node);
 	--maps->nr_maps;
-	if (maps->maps_by_name)
+	if (maps__maps_by_name(maps))
 		__maps__free_maps_by_name(maps);
-	up_write(&maps->lock);
+	up_write(maps__lock(maps));
 }
 
 static void __maps__purge(struct maps *maps)
@@ -135,7 +136,7 @@ static void __maps__purge(struct maps *maps)
 	struct map_rb_node *pos, *next;
 
 	maps__for_each_entry_safe(maps, pos, next) {
-		rb_erase_init(&pos->rb_node,  &maps->entries);
+		rb_erase_init(&pos->rb_node,  maps__entries(maps));
 		map__put(pos->map);
 		free(pos);
 	}
@@ -143,9 +144,9 @@ static void __maps__purge(struct maps *maps)
 
 static void maps__exit(struct maps *maps)
 {
-	down_write(&maps->lock);
+	down_write(maps__lock(maps));
 	__maps__purge(maps);
-	up_write(&maps->lock);
+	up_write(maps__lock(maps));
 }
 
 bool maps__empty(struct maps *maps)
@@ -170,6 +171,14 @@ void maps__delete(struct maps *maps)
 	free(maps);
 }
 
+struct maps *maps__get(struct maps *maps)
+{
+	if (maps)
+		refcount_inc(&maps->refcnt);
+
+	return maps;
+}
+
 void maps__put(struct maps *maps)
 {
 	if (maps && refcount_dec_and_test(&maps->refcnt))
@@ -195,7 +204,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 	struct symbol *sym;
 	struct map_rb_node *pos;
 
-	down_read(&maps->lock);
+	down_read(maps__lock(maps));
 
 	maps__for_each_entry(maps, pos) {
 		sym = map__find_symbol_by_name(pos->map, name);
@@ -213,7 +222,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
 
 	sym = NULL;
 out:
-	up_read(&maps->lock);
+	up_read(maps__lock(maps));
 	return sym;
 }
 
@@ -238,7 +247,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 	size_t printed = 0;
 	struct map_rb_node *pos;
 
-	down_read(&maps->lock);
+	down_read(maps__lock(maps));
 
 	maps__for_each_entry(maps, pos) {
 		printed += fprintf(fp, "Map:");
@@ -249,7 +258,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 		}
 	}
 
-	up_read(&maps->lock);
+	up_read(maps__lock(maps));
 
 	return printed;
 }
@@ -260,9 +269,9 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 	struct rb_node *next, *first;
 	int err = 0;
 
-	down_write(&maps->lock);
+	down_write(maps__lock(maps));
 
-	root = &maps->entries;
+	root = maps__entries(maps);
 
 	/*
 	 * Find first map where end > map->start.
@@ -358,7 +367,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 	err = 0;
 out:
-	up_write(&maps->lock);
+	up_write(maps__lock(maps));
 	return err;
 }
 
@@ -371,7 +380,7 @@ int maps__clone(struct thread *thread, struct maps *parent)
 	int err;
 	struct map_rb_node *rb_node;
 
-	down_read(&parent->lock);
+	down_read(maps__lock(parent));
 
 	maps__for_each_entry(parent, rb_node) {
 		struct map *new = map__clone(rb_node->map);
@@ -394,7 +403,7 @@ int maps__clone(struct thread *thread, struct maps *parent)
 
 	err = 0;
 out_unlock:
-	up_read(&parent->lock);
+	up_read(maps__lock(parent));
 	return err;
 }
 
@@ -414,9 +423,9 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	struct rb_node *p;
 	struct map_rb_node *m;
 
-	down_read(&maps->lock);
+	down_read(maps__lock(maps));
 
-	p = maps->entries.rb_node;
+	p = maps__entries(maps)->rb_node;
 	while (p != NULL) {
 		m = rb_entry(p, struct map_rb_node, rb_node);
 		if (ip < m->map->start)
@@ -429,14 +438,14 @@ struct map *maps__find(struct maps *maps, u64 ip)
 
 	m = NULL;
 out:
-	up_read(&maps->lock);
+	up_read(maps__lock(maps));
 
 	return m ? m->map : NULL;
 }
 
 struct map_rb_node *maps__first(struct maps *maps)
 {
-	struct rb_node *first = rb_first(&maps->entries);
+	struct rb_node *first = rb_first(maps__entries(maps));
 
 	if (first)
 		return rb_entry(first, struct map_rb_node, rb_node);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 512746ec0f9a..bde3390c7096 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,7 +43,7 @@ struct maps {
 	unsigned int	 nr_maps_allocated;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
-	struct unwind_libunwind_ops	*unwind_libunwind_ops;
+	const struct unwind_libunwind_ops *unwind_libunwind_ops;
 #endif
 };
 
@@ -58,20 +58,51 @@ struct kmap {
 struct maps *maps__new(struct machine *machine);
 void maps__delete(struct maps *maps);
 bool maps__empty(struct maps *maps);
+int maps__clone(struct thread *thread, struct maps *parent);
+
+struct maps *maps__get(struct maps *maps);
+void maps__put(struct maps *maps);
 
-static inline struct maps *maps__get(struct maps *maps)
+static inline struct rb_root *maps__entries(struct maps *maps)
 {
-	if (maps)
-		refcount_inc(&maps->refcnt);
-	return maps;
+	return &maps->entries;
 }
 
-void maps__put(struct maps *maps);
-int maps__clone(struct thread *thread, struct maps *parent);
+static inline struct machine *maps__machine(struct maps *maps)
+{
+	return maps->machine;
+}
+
+static inline struct rw_semaphore *maps__lock(struct maps *maps)
+{
+	return &maps->lock;
+}
+
+static inline struct map **maps__maps_by_name(struct maps *maps)
+{
+	return maps->maps_by_name;
+}
+
+static inline unsigned int maps__nr_maps(const struct maps *maps)
+{
+	return maps->nr_maps;
+}
+
+#ifdef HAVE_LIBUNWIND_SUPPORT
+static inline void *maps__addr_space(struct maps *maps)
+{
+	return maps->addr_space;
+}
+
+static inline const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
+{
+	return maps->unwind_libunwind_ops;
+}
+#endif
+
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
 int maps__insert(struct maps *maps, struct map *map);
-
 void maps__remove(struct maps *maps, struct map *map);
 
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e752e1f4a5f0..0290dc3a6258 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1220,7 +1220,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
-	tuple_set_d64(t, 2, es->al->maps->machine->db_id);
+	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
 	tuple_set_d64(t, 3, es->al->thread->db_id);
 	tuple_set_d64(t, 4, es->comm_db_id);
 	tuple_set_d64(t, 5, es->dso_db_id);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index cfba8c337783..25686d67ee6f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -661,7 +661,7 @@ static int hist_entry__cgroup_snprintf(struct hist_entry *he,
 	const char *cgrp_name = "N/A";
 
 	if (he->cgroup) {
-		struct cgroup *cgrp = cgroup__find(he->ms.maps->machine->env,
+		struct cgroup *cgrp = cgroup__find(maps__machine(he->ms.maps)->env,
 						   he->cgroup);
 		if (cgrp != NULL)
 			cgrp_name = cgrp->name;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4607c9438866..3ca9a0968345 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1067,7 +1067,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 * we still are sure to have a reference to this DSO via
 		 * *curr_map->dso.
 		 */
-		dsos__add(&kmaps->machine->dsos, curr_dso);
+		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
 		/* kmaps already got it */
 		map__put(curr_map);
 		dso__set_loaded(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e8045b1c8700..9b51e669a722 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -249,7 +249,7 @@ void maps__fixup_end(struct maps *maps)
 {
 	struct map_rb_node *prev = NULL, *curr;
 
-	down_write(&maps->lock);
+	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
 		if (prev != NULL && !prev->map->end)
@@ -265,7 +265,7 @@ void maps__fixup_end(struct maps *maps)
 	if (curr && !curr->map->end)
 		curr->map->end = ~0ULL;
 
-	up_write(&maps->lock);
+	up_write(maps__lock(maps));
 }
 
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
@@ -813,7 +813,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	if (!kmaps)
 		return -1;
 
-	machine = kmaps->machine;
+	machine = maps__machine(kmaps);
 
 	x86_64 = machine__is(machine, "x86_64");
 
@@ -937,7 +937,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 	if (curr_map != initial_map &&
 	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
-	    machine__is_default_guest(kmaps->machine)) {
+	    machine__is_default_guest(maps__machine(kmaps))) {
 		dso__set_loaded(curr_map->dso);
 	}
 
@@ -1336,7 +1336,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!kmaps)
 		return -EINVAL;
 
-	machine = kmaps->machine;
+	machine = maps__machine(kmaps);
 
 	/* This function requires that the map is the kernel map */
 	if (!__map__is_kernel(map))
@@ -1851,7 +1851,7 @@ int dso__load(struct dso *dso, struct map *map)
 		else if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
-		machine = map__kmaps(map)->machine;
+		machine = maps__machine(map__kmaps(map));
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2006,21 +2006,21 @@ static int map__strcmp_name(const void *name, const void *b)
 
 void __maps__sort_by_name(struct maps *maps)
 {
-	qsort(maps->maps_by_name, maps->nr_maps, sizeof(struct map *), map__strcmp);
+	qsort(maps__maps_by_name(maps), maps__nr_maps(maps), sizeof(struct map *), map__strcmp);
 }
 
 static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 {
 	struct map_rb_node *rb_node;
-	struct map **maps_by_name = realloc(maps->maps_by_name,
-					    maps->nr_maps * sizeof(struct map *));
+	struct map **maps_by_name = realloc(maps__maps_by_name(maps),
+					    maps__nr_maps(maps) * sizeof(struct map *));
 	int i = 0;
 
 	if (maps_by_name == NULL)
 		return -1;
 
 	maps->maps_by_name = maps_by_name;
-	maps->nr_maps_allocated = maps->nr_maps;
+	maps->nr_maps_allocated = maps__nr_maps(maps);
 
 	maps__for_each_entry(maps, rb_node)
 		maps_by_name[i++] = rb_node->map;
@@ -2033,11 +2033,12 @@ static struct map *__maps__find_by_name(struct maps *maps, const char *name)
 {
 	struct map **mapp;
 
-	if (maps->maps_by_name == NULL &&
+	if (maps__maps_by_name(maps) == NULL &&
 	    map__groups__sort_by_name_from_rbtree(maps))
 		return NULL;
 
-	mapp = bsearch(name, maps->maps_by_name, maps->nr_maps, sizeof(*mapp), map__strcmp_name);
+	mapp = bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
+		       sizeof(*mapp), map__strcmp_name);
 	if (mapp)
 		return *mapp;
 	return NULL;
@@ -2048,9 +2049,10 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	struct map_rb_node *rb_node;
 	struct map *map;
 
-	down_read(&maps->lock);
+	down_read(maps__lock(maps));
 
-	if (maps->last_search_by_name && strcmp(maps->last_search_by_name->dso->short_name, name) == 0) {
+	if (maps->last_search_by_name &&
+	    strcmp(maps->last_search_by_name->dso->short_name, name) == 0) {
 		map = maps->last_search_by_name;
 		goto out_unlock;
 	}
@@ -2060,7 +2062,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	 * made.
 	 */
 	map = __maps__find_by_name(maps, name);
-	if (map || maps->maps_by_name != NULL)
+	if (map || maps__maps_by_name(maps) != NULL)
 		goto out_unlock;
 
 	/* Fallback to traversing the rbtree... */
@@ -2074,7 +2076,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	map = NULL;
 
 out_unlock:
-	up_read(&maps->lock);
+	up_read(maps__lock(maps));
 	return map;
 }
 
@@ -2326,7 +2328,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
-	struct machine *machine = map__kmaps(map)->machine;
+	struct machine *machine = maps__machine(map__kmaps(map));
 	char path[PATH_MAX];
 
 	if (machine__is_default_guest(machine)) {
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 1b992bbba4e8..4b85c1728012 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -155,8 +155,8 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 		ts->br_stack_sz = br_stack_sz;
 	}
 
-	if (thread->maps && thread->maps->machine) {
-		struct machine *machine = thread->maps->machine;
+	if (thread->maps && maps__machine(thread->maps)) {
+		struct machine *machine = maps__machine(thread->maps);
 		const char *arch = perf_env__arch(machine->env);
 
 		ts->kernel_start = machine__kernel_start(machine);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4baf4db8af65..c2256777b813 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -348,7 +348,7 @@ static int __thread__prepare_access(struct thread *thread)
 	struct maps *maps = thread->maps;
 	struct map_rb_node *rb_node;
 
-	down_read(&maps->lock);
+	down_read(maps__lock(maps));
 
 	maps__for_each_entry(maps, rb_node) {
 		err = unwind__prepare_access(thread->maps, rb_node->map, &initialized);
@@ -356,7 +356,7 @@ static int __thread__prepare_access(struct thread *thread)
 			break;
 	}
 
-	up_read(&maps->lock);
+	up_read(maps__lock(maps));
 
 	return err;
 }
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 71a353349181..7e6c59811292 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -618,24 +618,26 @@ static unw_accessors_t accessors = {
 
 static int _unwind__prepare_access(struct maps *maps)
 {
-	maps->addr_space = unw_create_addr_space(&accessors, 0);
-	if (!maps->addr_space) {
+	void *addr_space = unw_create_addr_space(&accessors, 0);
+
+	maps->addr_space = addr_space;
+	if (!addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
 	}
 
-	unw_set_caching_policy(maps->addr_space, UNW_CACHE_GLOBAL);
+	unw_set_caching_policy(addr_space, UNW_CACHE_GLOBAL);
 	return 0;
 }
 
 static void _unwind__flush_access(struct maps *maps)
 {
-	unw_flush_cache(maps->addr_space, 0, 0);
+	unw_flush_cache(maps__addr_space(maps), 0, 0);
 }
 
 static void _unwind__finish_access(struct maps *maps)
 {
-	unw_destroy_addr_space(maps->addr_space);
+	unw_destroy_addr_space(maps__addr_space(maps));
 }
 
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
@@ -660,7 +662,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	 */
 	if (max_stack - 1 > 0) {
 		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
-		addr_space = ui->thread->maps->addr_space;
+		addr_space = maps__addr_space(ui->thread->maps);
 
 		if (addr_space == NULL)
 			return -1;
@@ -709,7 +711,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	struct unwind_info ui = {
 		.sample       = data,
 		.thread       = thread,
-		.machine      = thread->maps->machine,
+		.machine      = maps__machine(thread->maps),
 	};
 
 	if (!data->user_regs.regs)
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index e89a5479b361..7b797ffadd19 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -22,12 +22,13 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 	const char *arch;
 	enum dso_type dso_type;
 	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
+	struct machine *machine;
 	int err;
 
 	if (!dwarf_callchain_users)
 		return 0;
 
-	if (maps->addr_space) {
+	if (maps__addr_space(maps)) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
 			 map->dso->name);
 		if (initialized)
@@ -35,15 +36,16 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		return 0;
 	}
 
+	machine = maps__machine(maps);
 	/* env->arch is NULL for live-mode (i.e. perf top) */
-	if (!maps->machine->env || !maps->machine->env->arch)
+	if (!machine->env || !machine->env->arch)
 		goto out_register;
 
-	dso_type = dso__type(map->dso, maps->machine);
+	dso_type = dso__type(map->dso, machine);
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
-	arch = perf_env__arch(maps->machine->env);
+	arch = perf_env__arch(machine->env);
 
 	if (!strcmp(arch, "x86")) {
 		if (dso_type != DSO__TYPE_64BIT)
@@ -60,7 +62,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 out_register:
 	unwind__register_ops(maps, ops);
 
-	err = maps->unwind_libunwind_ops->prepare_access(maps);
+	err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
 	if (initialized)
 		*initialized = err ? false : true;
 	return err;
@@ -68,21 +70,27 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 
 void unwind__flush_access(struct maps *maps)
 {
-	if (maps->unwind_libunwind_ops)
-		maps->unwind_libunwind_ops->flush_access(maps);
+	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(maps);
+
+	if (ops)
+		ops->flush_access(maps);
 }
 
 void unwind__finish_access(struct maps *maps)
 {
-	if (maps->unwind_libunwind_ops)
-		maps->unwind_libunwind_ops->finish_access(maps);
+	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(maps);
+
+	if (ops)
+		ops->finish_access(maps);
 }
 
 int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			 struct thread *thread,
 			 struct perf_sample *data, int max_stack)
 {
-	if (thread->maps->unwind_libunwind_ops)
-		return thread->maps->unwind_libunwind_ops->get_entries(cb, arg, thread, data, max_stack);
+	const struct unwind_libunwind_ops *ops = maps__unwind_libunwind_ops(thread->maps);
+
+	if (ops)
+		return ops->get_entries(cb, arg, thread, data, max_stack);
 	return 0;
 }
-- 
2.35.1.265.g69c8d7142f-goog

