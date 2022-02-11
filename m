Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C14E4B2350
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiBKKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349012AbiBKKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38DEB8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v10-20020a05690204ca00b0061dd584eb83so17715652ybs.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T6JGdGZNTCjyP+otJD5NTUIMGGuyoHt747zi1J4QsAA=;
        b=eCPhIKZTqMXDP60Q7y+pcRZZUSgGO++J6Aa5HezZd0qD9BJgPv983xvggi2Ip6bTQl
         RxE+2Gz4uF8ZCRym6NU6PswR3OAL4ihwLVK4jZTLCKDEjE78BrYPB2noXSu0/Q0uf6aq
         rW7uPjuvNi9p17MWvXCGaB7F5lW+McFiDeaLjyeiJdh3zG+GC3gIXq9fge70qiiK2qy/
         5WX815bBmepNhC3s4uOmCR5bsK8ty7GzA/1BUmuWvK0jROb15CUEKao3Df0/5UGVHZOO
         o8vxGDwG3pkfqaAKtsgB6TxnokhlS9q5uY7MoqZJKGWNiyX7J4URcHxMMy+sFAs64tDZ
         ttsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T6JGdGZNTCjyP+otJD5NTUIMGGuyoHt747zi1J4QsAA=;
        b=mXnVH1Tla6eG+DyQ7HfdL1lh+k0FNgWxekpZZOTrqYTA1MvQKNQadbrGNWCHk0TJjB
         eRwiNEQ1OeHdcb0j/f6SSRtC9evCpWsBfDHjaTz2AQna+z+t9VlGw3XMhzD9FIS6kLH3
         otRlIMnP0IutZWitHj4Bij+vvzOCkeUkifQEyLm+9ekeFWSSfq/aqE+KLUQbxea8WLUW
         noT0BTwEW/0D1HIwgdf2yQJ5ZT0EBsp88OmoMG6qweKiyj2kRfXi6ucMeauAqcJEsMDP
         EzEdhN6JhFLcp1RrtOCYQXmW26Mjy2oWy7wPsMgddX1d2VMDU31XWSf4IFiFNEftj1m8
         okeQ==
X-Gm-Message-State: AOAM530+1Zs5b+X42w/R/Gf8JZFEi6pHJMJ+ibsQx/C2jlUEHl2hTzA4
        Zq00+knZebgOlHDZEXtxMKR8MputgRWU
X-Google-Smtp-Source: ABdhPJyRWBx8o72en74N6m4vWukaGdI1xCuaE2DomITKvjMtP0X71IKua41eeREWnxiYiW8gnOoWWp0RammA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2cc:: with SMTP id
 w12mr688464ybh.65.1644575690512; Fri, 11 Feb 2022 02:34:50 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:05 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-13-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 12/22] perf maps: Remove rb_node from struct map
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct map is reference counted, having it also be a node in an
red-black tree complicates the reference counting. Switch to having a
map_rb_node which is a red-block tree node but points at the reference
counted struct map. This reference is responsible for a single reference
count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/event.c    |  13 +-
 tools/perf/builtin-report.c         |   6 +-
 tools/perf/tests/maps.c             |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c |  17 +--
 tools/perf/util/machine.c           |  62 ++++++----
 tools/perf/util/map.c               |  16 ---
 tools/perf/util/map.h               |   1 -
 tools/perf/util/maps.c              | 182 ++++++++++++++++++----------
 tools/perf/util/maps.h              |  17 ++-
 tools/perf/util/probe-event.c       |  18 +--
 tools/perf/util/symbol-elf.c        |   9 +-
 tools/perf/util/symbol.c            |  77 +++++++-----
 tools/perf/util/synthetic-events.c  |  26 ++--
 tools/perf/util/thread.c            |  10 +-
 tools/perf/util/vdso.c              |   7 +-
 15 files changed, 288 insertions(+), 181 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index e670f3547581..7b6b0c98fb36 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -17,7 +17,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 				       struct machine *machine)
 {
 	int rc = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 	struct maps *kmaps = machine__kernel_maps(machine);
 	union perf_event *event = zalloc(sizeof(event->mmap) +
 					 machine->id_hdr_size);
@@ -31,11 +31,12 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 	maps__for_each_entry(kmaps, pos) {
 		struct kmap *kmap;
 		size_t size;
+		struct map *map = pos->map;
 
-		if (!__map__is_extra_kernel_map(pos))
+		if (!__map__is_extra_kernel_map(map))
 			continue;
 
-		kmap = map__kmap(pos);
+		kmap = map__kmap(map);
 
 		size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
 		       PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
@@ -56,9 +57,9 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 
 		event->mmap.header.size = size;
 
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pgoff = pos->pgoff;
+		event->mmap.start = map->start;
+		event->mmap.len   = map->end - map->start;
+		event->mmap.pgoff = map->pgoff;
 		event->mmap.pid   = machine->pid;
 
 		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1dd92d8c9279..57611ef725c3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -799,9 +799,11 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 {
 	size_t printed = 0;
-	struct map *map;
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
 
-	maps__for_each_entry(maps, map) {
 		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
 				   indent, "", map->start, map->end,
 				   map->prot & PROT_READ ? 'r' : '-',
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 6f53f17f788e..a58274598587 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -15,10 +15,12 @@ struct map_def {
 
 static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
 {
-	struct map *map;
+	struct map_rb_node *rb_node;
 	unsigned int i = 0;
 
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
+
 		if (i > 0)
 			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
 
@@ -74,7 +76,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 
 		map->start = bpf_progs[i].start;
 		map->end   = bpf_progs[i].end;
-		maps__insert(maps, map);
+		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
 		map__put(map);
 	}
 
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 84bf5f640065..11a230ee5894 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -117,7 +117,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	int err = -1;
 	struct rb_node *nd;
 	struct symbol *sym;
-	struct map *kallsyms_map, *vmlinux_map, *map;
+	struct map *kallsyms_map, *vmlinux_map;
+	struct map_rb_node *rb_node;
 	struct machine kallsyms, vmlinux;
 	struct maps *maps = machine__kernel_maps(&vmlinux);
 	u64 mem_start, mem_end;
@@ -285,15 +286,15 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	header_printed = false;
 
-	maps__for_each_entry(maps, map) {
-		struct map *
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
 		/*
 		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
 		 * the kernel will have the path for the vmlinux file being used,
 		 * so use the short name, less descriptive but the same ("[kernel]" in
 		 * both cases.
 		 */
-		pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
+		struct map *pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
 								map->dso->short_name :
 								map->dso->name));
 		if (pair) {
@@ -309,8 +310,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	header_printed = false;
 
-	maps__for_each_entry(maps, map) {
-		struct map *pair;
+	maps__for_each_entry(maps, rb_node) {
+		struct map *pair, *map = rb_node->map;
 
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
@@ -339,7 +340,9 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 	maps = machine__kernel_maps(&kallsyms);
 
-	maps__for_each_entry(maps, map) {
+	maps__for_each_entry(maps, rb_node) {
+		struct map *map = rb_node->map;
+
 		if (!map->priv) {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in kallsyms:\n");
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 57fbdba66425..fa25174cabf7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -786,6 +786,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 	if (!map) {
 		struct dso *dso = dso__new(event->ksymbol.name);
+		int err;
 
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
@@ -805,8 +806,11 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
-		maps__insert(machine__kernel_maps(machine), map);
+		err = maps__insert(machine__kernel_maps(machine), map);
 		map__put(map);
+		if (err)
+			return err;
+
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
@@ -906,6 +910,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	struct map *map = NULL;
 	struct kmod_path m;
 	struct dso *dso;
+	int err;
 
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
@@ -918,10 +923,14 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (map == NULL)
 		goto out;
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 
 	/* Put the map here because maps__insert already got it */
 	map__put(map);
+
+	/* If maps__insert failed, return NULL. */
+	if (err)
+		map = NULL;
 out:
 	/* put the dso here, corresponding to  machine__findnew_module_dso */
 	dso__put(dso);
@@ -1092,10 +1101,11 @@ int machine__create_extra_kernel_map(struct machine *machine,
 {
 	struct kmap *kmap;
 	struct map *map;
+	int err;
 
 	map = map__new2(xm->start, kernel);
 	if (!map)
-		return -1;
+		return -ENOMEM;
 
 	map->end   = xm->end;
 	map->pgoff = xm->pgoff;
@@ -1104,14 +1114,16 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 
-	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
-		  kmap->name, map->start, map->end);
+	if (!err) {
+		pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
+			kmap->name, map->start, map->end);
+	}
 
 	map__put(map);
 
-	return 0;
+	return err;
 }
 
 static u64 find_entry_trampoline(struct dso *dso)
@@ -1152,16 +1164,16 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 	struct maps *kmaps = machine__kernel_maps(machine);
 	int nr_cpus_avail, cpu;
 	bool found = false;
-	struct map *map;
+	struct map_rb_node *rb_node;
 	u64 pgoff;
 
 	/*
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	maps__for_each_entry(kmaps, map) {
+	maps__for_each_entry(kmaps, rb_node) {
+		struct map *dest_map, *map = rb_node->map;
 		struct kmap *kmap = __map__kmap(map);
-		struct map *dest_map;
 
 		if (!kmap || !is_entry_trampoline(kmap->name))
 			continue;
@@ -1216,11 +1228,10 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 
 	machine->vmlinux_map = map__new2(0, kernel);
 	if (machine->vmlinux_map == NULL)
-		return -1;
+		return -ENOMEM;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
-	return 0;
+	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
 }
 
 void machine__destroy_kernel_maps(struct machine *machine)
@@ -1542,25 +1553,26 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		machine->vmlinux_map->end = ~0ULL;
 }
 
-static void machine__update_kernel_mmap(struct machine *machine,
+static int machine__update_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
 	struct map *map = machine__kernel_map(machine);
+	int err;
 
 	map__get(map);
 	maps__remove(machine__kernel_maps(machine), map);
 
 	machine__set_kernel_mmap(machine, start, end);
 
-	maps__insert(machine__kernel_maps(machine), map);
+	err = maps__insert(machine__kernel_maps(machine), map);
 	map__put(map);
+	return err;
 }
 
 int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
-	struct map *map;
 	u64 start = 0, end = ~0ULL;
 	int ret;
 
@@ -1592,7 +1604,9 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, start, end);
+		ret = machine__update_kernel_mmap(machine, start, end);
+		if (ret < 0)
+			goto out_put;
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
@@ -1600,9 +1614,12 @@ int machine__create_kernel_maps(struct machine *machine)
 
 	if (end == ~0ULL) {
 		/* update end address of the kernel map using adjacent module address */
-		map = map__next(machine__kernel_map(machine));
-		if (map)
-			machine__set_kernel_mmap(machine, start, map->start);
+		struct map_rb_node *rb_node = maps__find_node(machine__kernel_maps(machine),
+							machine__kernel_map(machine));
+		struct map_rb_node *next = map_rb_node__next(rb_node);
+
+		if (next)
+			machine__set_kernel_mmap(machine, start, next->map->start);
 	}
 
 out_put:
@@ -1726,7 +1743,10 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__update_kernel_mmap(machine, xm->start, xm->end);
+		if (machine__update_kernel_mmap(machine, xm->start, xm->end) < 0) {
+			dso__put(kernel);
+			goto out_problem;
+		}
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(kernel, bid);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8bbf9246a3cf..dfa5f6b7381f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -111,7 +111,6 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->dso      = dso__get(dso);
 	map->map_ip   = map__map_ip;
 	map->unmap_ip = map__unmap_ip;
-	RB_CLEAR_NODE(&map->rb_node);
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -383,7 +382,6 @@ struct map *map__clone(struct map *from)
 	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
-		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
 	}
 
@@ -523,20 +521,6 @@ bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 	return ip >= map->start && ip < map->end;
 }
 
-static struct map *__map__next(struct map *map)
-{
-	struct rb_node *next = rb_next(&map->rb_node);
-
-	if (next)
-		return rb_entry(next, struct map, rb_node);
-	return NULL;
-}
-
-struct map *map__next(struct map *map)
-{
-	return map ? __map__next(map) : NULL;
-}
-
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 2879cae05ee0..d1a6f85fd31d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,7 +16,6 @@ struct maps;
 struct machine;
 
 struct map {
-	struct rb_node		rb_node;
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ededabf0a230..beb09b9a122c 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,9 +10,7 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
-static void __maps__insert(struct maps *maps, struct map *map);
-
-void maps__init(struct maps *maps, struct machine *machine)
+static void maps__init(struct maps *maps, struct machine *machine)
 {
 	maps->entries = RB_ROOT;
 	init_rwsem(&maps->lock);
@@ -32,10 +30,44 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	maps->nr_maps_allocated = 0;
 }
 
-void maps__insert(struct maps *maps, struct map *map)
+static int __maps__insert(struct maps *maps, struct map *map)
+{
+	struct rb_node **p = &maps->entries.rb_node;
+	struct rb_node *parent = NULL;
+	const u64 ip = map->start;
+	struct map_rb_node *m, *new_rb_node;
+
+	new_rb_node = malloc(sizeof(*new_rb_node));
+	if (!new_rb_node)
+		return -ENOMEM;
+
+	RB_CLEAR_NODE(&new_rb_node->rb_node);
+	new_rb_node->map = map;
+
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map_rb_node, rb_node);
+		if (ip < m->map->start)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&new_rb_node->rb_node, parent, p);
+	rb_insert_color(&new_rb_node->rb_node, &maps->entries);
+	map__get(map);
+	return 0;
+}
+
+int maps__insert(struct maps *maps, struct map *map)
 {
+	int err;
+
 	down_write(&maps->lock);
-	__maps__insert(maps, map);
+	err = __maps__insert(maps, map);
+	if (err)
+		goto out;
+
 	++maps->nr_maps;
 
 	if (map->dso && map->dso->kernel) {
@@ -59,8 +91,8 @@ void maps__insert(struct maps *maps, struct map *map)
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
-				up_write(&maps->lock);
-				return;
+				err = -ENOMEM;
+				goto out;
 			}
 
 			maps->maps_by_name = maps_by_name;
@@ -69,22 +101,29 @@ void maps__insert(struct maps *maps, struct map *map)
 		maps->maps_by_name[maps->nr_maps - 1] = map;
 		__maps__sort_by_name(maps);
 	}
+out:
 	up_write(&maps->lock);
+	return err;
 }
 
-static void __maps__remove(struct maps *maps, struct map *map)
+static void __maps__remove(struct maps *maps, struct map_rb_node *rb_node)
 {
-	rb_erase_init(&map->rb_node, &maps->entries);
-	map__put(map);
+	rb_erase_init(&rb_node->rb_node, &maps->entries);
+	map__put(rb_node->map);
+	free(rb_node);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
 {
+	struct map_rb_node *rb_node;
+
 	down_write(&maps->lock);
 	if (maps->last_search_by_name == map)
 		maps->last_search_by_name = NULL;
 
-	__maps__remove(maps, map);
+	rb_node = maps__find_node(maps, map);
+	assert(rb_node->map == map);
+	__maps__remove(maps, rb_node);
 	--maps->nr_maps;
 	if (maps->maps_by_name)
 		__maps__free_maps_by_name(maps);
@@ -93,15 +132,16 @@ void maps__remove(struct maps *maps, struct map *map)
 
 static void __maps__purge(struct maps *maps)
 {
-	struct map *pos, *next;
+	struct map_rb_node *pos, *next;
 
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  &maps->entries);
-		map__put(pos);
+		map__put(pos->map);
+		free(pos);
 	}
 }
 
-void maps__exit(struct maps *maps)
+static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
@@ -153,21 +193,21 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
 {
 	struct symbol *sym;
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	down_read(&maps->lock);
 
 	maps__for_each_entry(maps, pos) {
-		sym = map__find_symbol_by_name(pos, name);
+		sym = map__find_symbol_by_name(pos->map, name);
 
 		if (sym == NULL)
 			continue;
-		if (!map__contains_symbol(pos, sym)) {
+		if (!map__contains_symbol(pos->map, sym)) {
 			sym = NULL;
 			continue;
 		}
 		if (mapp != NULL)
-			*mapp = pos;
+			*mapp = pos->map;
 		goto out;
 	}
 
@@ -196,15 +236,15 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 size_t maps__fprintf(struct maps *maps, FILE *fp)
 {
 	size_t printed = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	down_read(&maps->lock);
 
 	maps__for_each_entry(maps, pos) {
 		printed += fprintf(fp, "Map:");
-		printed += map__fprintf(pos, fp);
+		printed += map__fprintf(pos->map, fp);
 		if (verbose > 2) {
-			printed += dso__fprintf(pos->dso, fp);
+			printed += dso__fprintf(pos->map->dso, fp);
 			printed += fprintf(fp, "--\n");
 		}
 	}
@@ -231,11 +271,11 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 	next = root->rb_node;
 	first = NULL;
 	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
+		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 
-		if (pos->end > map->start) {
+		if (pos->map->end > map->start) {
 			first = next;
-			if (pos->start <= map->start)
+			if (pos->map->start <= map->start)
 				break;
 			next = next->rb_left;
 		} else
@@ -244,14 +284,14 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 	next = first;
 	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
+		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
 
 		/*
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (pos->start >= map->end)
+		if (pos->map->start >= map->end)
 			break;
 
 		if (verbose >= 2) {
@@ -262,7 +302,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			} else {
 				fputs("overlapping maps:\n", fp);
 				map__fprintf(map, fp);
-				map__fprintf(pos, fp);
+				map__fprintf(pos->map, fp);
 			}
 		}
 
@@ -271,8 +311,8 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map->start > pos->start) {
-			struct map *before = map__clone(pos);
+		if (map->start > pos->map->start) {
+			struct map *before = map__clone(pos->map);
 
 			if (before == NULL) {
 				err = -ENOMEM;
@@ -280,14 +320,17 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			before->end = map->start;
-			__maps__insert(maps, before);
+			err = __maps__insert(maps, before);
+			if (err)
+				goto put_map;
+
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
 			map__put(before);
 		}
 
-		if (map->end < pos->end) {
-			struct map *after = map__clone(pos);
+		if (map->end < pos->map->end) {
+			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
 				err = -ENOMEM;
@@ -295,15 +338,19 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			after->start = map->end;
-			after->pgoff += map->end - pos->start;
-			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__maps__insert(maps, after);
+			after->pgoff += map->end - pos->map->start;
+			assert(pos->map->map_ip(pos->map, map->end) ==
+				after->map_ip(after, map->end));
+			err = __maps__insert(maps, after);
+			if (err)
+				goto put_map;
+
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
 		}
 put_map:
-		map__put(pos);
+		map__put(pos->map);
 
 		if (err)
 			goto out;
@@ -322,12 +369,12 @@ int maps__clone(struct thread *thread, struct maps *parent)
 {
 	struct maps *maps = thread->maps;
 	int err;
-	struct map *map;
+	struct map_rb_node *rb_node;
 
 	down_read(&parent->lock);
 
-	maps__for_each_entry(parent, map) {
-		struct map *new = map__clone(map);
+	maps__for_each_entry(parent, rb_node) {
+		struct map *new = map__clone(rb_node->map);
 
 		if (new == NULL) {
 			err = -ENOMEM;
@@ -338,7 +385,10 @@ int maps__clone(struct thread *thread, struct maps *parent)
 		if (err)
 			goto out_unlock;
 
-		maps__insert(maps, new);
+		err = maps__insert(maps, new);
+		if (err)
+			goto out_unlock;
+
 		map__put(new);
 	}
 
@@ -348,40 +398,30 @@ int maps__clone(struct thread *thread, struct maps *parent)
 	return err;
 }
 
-static void __maps__insert(struct maps *maps, struct map *map)
+struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
 {
-	struct rb_node **p = &maps->entries.rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = map->start;
-	struct map *m;
+	struct map_rb_node *rb_node;
 
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node);
-		if (ip < m->start)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	maps__for_each_entry(maps, rb_node) {
+		if (rb_node->map == map)
+			return rb_node;
 	}
-
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color(&map->rb_node, &maps->entries);
-	map__get(map);
+	return NULL;
 }
 
 struct map *maps__find(struct maps *maps, u64 ip)
 {
 	struct rb_node *p;
-	struct map *m;
+	struct map_rb_node *m;
 
 	down_read(&maps->lock);
 
 	p = maps->entries.rb_node;
 	while (p != NULL) {
-		m = rb_entry(p, struct map, rb_node);
-		if (ip < m->start)
+		m = rb_entry(p, struct map_rb_node, rb_node);
+		if (ip < m->map->start)
 			p = p->rb_left;
-		else if (ip >= m->end)
+		else if (ip >= m->map->end)
 			p = p->rb_right;
 		else
 			goto out;
@@ -390,14 +430,30 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	m = NULL;
 out:
 	up_read(&maps->lock);
-	return m;
+
+	return m ? m->map : NULL;
 }
 
-struct map *maps__first(struct maps *maps)
+struct map_rb_node *maps__first(struct maps *maps)
 {
 	struct rb_node *first = rb_first(&maps->entries);
 
 	if (first)
-		return rb_entry(first, struct map, rb_node);
+		return rb_entry(first, struct map_rb_node, rb_node);
 	return NULL;
 }
+
+struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
+{
+	struct rb_node *next;
+
+	if (!node)
+		return NULL;
+
+	next = rb_next(&node->rb_node);
+
+	if (!next)
+		return NULL;
+
+	return rb_entry(next, struct map_rb_node, rb_node);
+}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 7e729ff42749..512746ec0f9a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -15,15 +15,22 @@ struct map;
 struct maps;
 struct thread;
 
+struct map_rb_node {
+	struct rb_node rb_node;
+	struct map *map;
+};
+
+struct map_rb_node *maps__first(struct maps *maps);
+struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
+struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
-struct map *maps__first(struct maps *maps);
-struct map *map__next(struct map *map);
 
 #define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map__next(map))
+	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
 #define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
+	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
+	     map = next, next = map_rb_node__next(map))
 
 struct maps {
 	struct rb_root      entries;
@@ -63,7 +70,7 @@ void maps__put(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
-void maps__insert(struct maps *maps, struct map *map);
+int maps__insert(struct maps *maps, struct map *map);
 
 void maps__remove(struct maps *maps, struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index bc5ab782ace5..f9fbf611f2bf 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -150,23 +150,27 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 static struct map *kernel_get_module_map(const char *module)
 {
 	struct maps *maps = machine__kernel_maps(host_machine);
-	struct map *pos;
+	struct map_rb_node *pos;
 
 	/* A file path -- this is an offline module */
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
 	if (!module) {
-		pos = machine__kernel_map(host_machine);
-		return map__get(pos);
+		struct map *map = machine__kernel_map(host_machine);
+
+		return map__get(map);
 	}
 
 	maps__for_each_entry(maps, pos) {
 		/* short_name is "[module]" */
-		if (strncmp(pos->dso->short_name + 1, module,
-			    pos->dso->short_name_len - 2) == 0 &&
-		    module[pos->dso->short_name_len - 2] == '\0') {
-			return map__get(pos);
+		const char *short_name = pos->map->dso->short_name;
+		u16 short_name_len =  pos->map->dso->short_name_len;
+
+		if (strncmp(short_name + 1, module,
+			    short_name_len - 2) == 0 &&
+		    module[short_name_len - 2] == '\0') {
+			return map__get(pos->map);
 		}
 	}
 	return NULL;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 31cd59a2b66e..4607c9438866 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1000,10 +1000,14 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map->unmap_ip = map__unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
+				int err;
+
 				map__get(map);
 				maps__remove(kmaps, map);
-				maps__insert(kmaps, map);
+				err = maps__insert(kmaps, map);
 				map__put(map);
+				if (err)
+					return err;
 			}
 		}
 
@@ -1056,7 +1060,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
-		maps__insert(kmaps, curr_map);
+		if (maps__insert(kmaps, curr_map))
+			return -1;
 		/*
 		 * Add it before we drop the reference to curr_map, i.e. while
 		 * we still are sure to have a reference to this DSO via
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 99accae7d3b8..266c65bb8bbb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -247,13 +247,13 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 
 void maps__fixup_end(struct maps *maps)
 {
-	struct map *prev = NULL, *curr;
+	struct map_rb_node *prev = NULL, *curr;
 
 	down_write(&maps->lock);
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !prev->end)
-			prev->end = curr->start;
+		if (prev != NULL && !prev->map->end)
+			prev->map->end = curr->map->start;
 
 		prev = curr;
 	}
@@ -262,8 +262,8 @@ void maps__fixup_end(struct maps *maps)
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (curr && !curr->end)
-		curr->end = ~0ULL;
+	if (curr && !curr->map->end)
+		curr->map->end = ~0ULL;
 
 	up_write(&maps->lock);
 }
@@ -911,7 +911,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			}
 
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
-			maps__insert(kmaps, curr_map);
+			if (maps__insert(kmaps, curr_map)) {
+				dso__put(ndso);
+				return -1;
+			}
 			++kernel_range;
 		} else if (delta) {
 			/* Kernel was relocated at boot time */
@@ -1099,14 +1102,15 @@ int compare_proc_modules(const char *from, const char *to)
 static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
-	struct map *old_map;
+	struct map_rb_node *old_node;
 	int err;
 
 	err = read_proc_modules(filename, &modules);
 	if (err)
 		return err;
 
-	maps__for_each_entry(kmaps, old_map) {
+	maps__for_each_entry(kmaps, old_node) {
+		struct map *old_map = old_node->map;
 		struct module_info *mi;
 
 		if (!__map__is_kmodule(old_map)) {
@@ -1224,10 +1228,13 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
  */
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
-	struct map *old_map;
+	struct map_rb_node *rb_node;
 	LIST_HEAD(merged);
+	int err = 0;
+
+	maps__for_each_entry(kmaps, rb_node) {
+		struct map *old_map = rb_node->map;
 
-	maps__for_each_entry(kmaps, old_map) {
 		/* no overload with this one */
 		if (new_map->end < old_map->start ||
 		    new_map->start >= old_map->end)
@@ -1252,13 +1259,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				struct map_list_node *m;
 
 				m = malloc(sizeof(*m));
-				if (!m)
-					return -ENOMEM;
+				if (!m) {
+					err = -ENOMEM;
+					goto out;
+				}
 
 				m->map = map__clone(new_map);
 				if (!m->map) {
 					free(m);
-					return -ENOMEM;
+					err = -ENOMEM;
+					goto out;
 				}
 
 				m->map->end = old_map->start;
@@ -1290,21 +1300,24 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 		}
 	}
 
+out:
 	while (!list_empty(&merged)) {
 		struct map_list_node *old_node;
 
 		old_node = list_entry(merged.next, struct map_list_node, node);
 		list_del_init(&old_node->node);
-		maps__insert(kmaps, old_node->map);
+		if (!err)
+			err = maps__insert(kmaps, old_node->map);
 		map__put(old_node->map);
 		free(old_node);
 	}
 
 	if (new_map) {
-		maps__insert(kmaps, new_map);
+		if (!err)
+			err = maps__insert(kmaps, new_map);
 		map__put(new_map);
 	}
-	return 0;
+	return err;
 }
 
 static int dso__load_kcore(struct dso *dso, struct map *map,
@@ -1312,7 +1325,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *replacement_map = NULL, *next;
+	struct map *replacement_map = NULL;
+	struct map_rb_node *old_node, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1359,7 +1373,9 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__for_each_entry_safe(kmaps, old_map, next) {
+	maps__for_each_entry_safe(kmaps, old_node, next) {
+		struct map *old_map = old_node->map;
+
 		/*
 		 * We need to preserve eBPF maps even if they are
 		 * covered by kcore, because we need to access
@@ -1400,17 +1416,21 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			maps__remove(kmaps, map);
-			maps__insert(kmaps, map);
+			err = maps__insert(kmaps, map);
 			map__put(map);
 			map__put(new_node->map);
+			if (err)
+				goto out_err;
 		} else {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
 			 * stay intact.
 			 */
-			if (maps__merge_in(kmaps, new_node->map))
+			if (maps__merge_in(kmaps, new_node->map)) {
+				err = -EINVAL;
 				goto out_err;
+			}
 		}
 		free(new_node);
 	}
@@ -1457,7 +1477,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(list_node);
 	}
 	close(fd);
-	return -EINVAL;
+	return err;
 }
 
 /*
@@ -1991,8 +2011,9 @@ void __maps__sort_by_name(struct maps *maps)
 
 static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 {
-	struct map *map;
-	struct map **maps_by_name = realloc(maps->maps_by_name, maps->nr_maps * sizeof(map));
+	struct map_rb_node *rb_node;
+	struct map **maps_by_name = realloc(maps->maps_by_name,
+					    maps->nr_maps * sizeof(struct map *));
 	int i = 0;
 
 	if (maps_by_name == NULL)
@@ -2001,8 +2022,8 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	maps->maps_by_name = maps_by_name;
 	maps->nr_maps_allocated = maps->nr_maps;
 
-	maps__for_each_entry(maps, map)
-		maps_by_name[i++] = map;
+	maps__for_each_entry(maps, rb_node)
+		maps_by_name[i++] = rb_node->map;
 
 	__maps__sort_by_name(maps);
 	return 0;
@@ -2024,6 +2045,7 @@ static struct map *__maps__find_by_name(struct maps *maps, const char *name)
 
 struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
+	struct map_rb_node *rb_node;
 	struct map *map;
 
 	down_read(&maps->lock);
@@ -2042,12 +2064,13 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		goto out_unlock;
 
 	/* Fallback to traversing the rbtree... */
-	maps__for_each_entry(maps, map)
+	maps__for_each_entry(maps, rb_node) {
+		map = rb_node->map;
 		if (strcmp(map->dso->short_name, name) == 0) {
 			maps->last_search_by_name = map;
 			goto out_unlock;
 		}
-
+	}
 	map = NULL;
 
 out_unlock:
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 70f095624a0b..ed2d55d224aa 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -639,7 +639,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 				   struct machine *machine)
 {
 	int rc = 0;
-	struct map *pos;
+	struct map_rb_node *pos;
 	struct maps *maps = machine__kernel_maps(machine);
 	union perf_event *event;
 	size_t size = symbol_conf.buildid_mmap2 ?
@@ -662,37 +662,39 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
 	maps__for_each_entry(maps, pos) {
-		if (!__map__is_kmodule(pos))
+		struct map *map = pos->map;
+
+		if (!__map__is_kmodule(map))
 			continue;
 
 		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
 			event->mmap2.header.type = PERF_RECORD_MMAP2;
 			event->mmap2.header.size = (sizeof(event->mmap2) -
 						(sizeof(event->mmap2.filename) - size));
 			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
 			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = pos->start;
-			event->mmap2.len   = pos->end - pos->start;
+			event->mmap2.start = map->start;
+			event->mmap2.len   = map->end - map->start;
 			event->mmap2.pid   = machine->pid;
 
-			memcpy(event->mmap2.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
+			memcpy(event->mmap2.filename, map->dso->long_name,
+			       map->dso->long_name_len + 1);
 
 			perf_record_mmap2__read_build_id(&event->mmap2, false);
 		} else {
-			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
 			event->mmap.header.size = (sizeof(event->mmap) -
 						(sizeof(event->mmap.filename) - size));
 			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
 			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = pos->start;
-			event->mmap.len   = pos->end - pos->start;
+			event->mmap.start = map->start;
+			event->mmap.len   = map->end - map->start;
 			event->mmap.pid   = machine->pid;
 
-			memcpy(event->mmap.filename, pos->dso->long_name,
-			       pos->dso->long_name_len + 1);
+			memcpy(event->mmap.filename, map->dso->long_name,
+			       map->dso->long_name_len + 1);
 		}
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 665e5c0618ed..4baf4db8af65 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -338,9 +338,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
 		return ret;
 
 	maps__fixup_overlappings(thread->maps, map, stderr);
-	maps__insert(thread->maps, map);
-
-	return 0;
+	return maps__insert(thread->maps, map);
 }
 
 static int __thread__prepare_access(struct thread *thread)
@@ -348,12 +346,12 @@ static int __thread__prepare_access(struct thread *thread)
 	bool initialized = false;
 	int err = 0;
 	struct maps *maps = thread->maps;
-	struct map *map;
+	struct map_rb_node *rb_node;
 
 	down_read(&maps->lock);
 
-	maps__for_each_entry(maps, map) {
-		err = unwind__prepare_access(thread->maps, map, &initialized);
+	maps__for_each_entry(maps, rb_node) {
+		err = unwind__prepare_access(thread->maps, rb_node->map, &initialized);
 		if (err || initialized)
 			break;
 	}
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 43beb169631d..835c39efb80d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -144,10 +144,11 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map;
+	struct map_rb_node *rb_node;
+
+	maps__for_each_entry(thread->maps, rb_node) {
+		struct dso *dso = rb_node->map->dso;
 
-	maps__for_each_entry(thread->maps, map) {
-		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
 		dso_type = dso__type(dso, machine);
-- 
2.35.1.265.g69c8d7142f-goog

