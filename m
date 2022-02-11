Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C944B2352
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiBKKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:36:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349060AbiBKKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D591F1C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so17944574ybh.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bydfP/IeA/FQ2vY0275cM3DwZ6uf7kn04PaBig786tE=;
        b=PMNrz+LPg3RGnca5ap5Rca9sDX+tMmTq6Jbe+hVD301DmjbsFoKAnYmdeIVDMUn7Ua
         Hn1uZkTybNVhzmTI/gAfTMynzPPL2nWhUwYT7VoZj/OP8FYFMlYdTaxvb7gcGY3AuVja
         XdLPqpUO/Wm1oyXdKkCKvXPv566OutelV7krNDUtvZRoA/t3rHtTxLwYZp7ppojc7HBw
         u+2q4hBzzr+dEaSofHmnnan1YhhaCxacpEhMtylx+xAzLrMhz5Et8e4rXRPD+siu2QD9
         JTbwqPVOisjMc7pzrM9f/NMIWkCSYzKKUsTlrvaYU738rrwaVQ9Nwgt1+pJoR4U/khFS
         eseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bydfP/IeA/FQ2vY0275cM3DwZ6uf7kn04PaBig786tE=;
        b=jSqXPEjzmXGHa91PuWuczpj8a6aLfIM0fhxM+Bbersrf3lBnSVjZb8l5sK9DC4YdFP
         sdH5XRlAQ3MHzVwggi0jXZ2VOnF/Du6wQ6oCjxDuAxjxAIoTPhGDeukwgAnGacxdh4OZ
         DXPXApqFneW2rQAdDv+Z9iNy1z0eJcjcUxSB3pSNql/MEWb78zEHSPKIoA/wqT4Exadw
         yoyTPTx1yhRY3XdHlzcVwRgGwHzQalkW1yQ8rRpbjQG6kdMoe1vBtkln7yZM7IeiarKy
         rm+/yPYjhJflVCKg62tt20hVQTRJb+Uwkx6N4V57WE4MxLpArc8jt8D0haVAfCWEe3xr
         2SWw==
X-Gm-Message-State: AOAM531an8jFk4M4/JY+EpF+PfM+sGOE7BSoL4RN/lD7cgkdFMmDNMuo
        iNBdZqp8MFSj7BJa2bDMp8/AV2kMN2Pn
X-Google-Smtp-Source: ABdhPJyIoM4fqJlSodF6pcrAfBiNdbgleVfB2n74Pc95/Y8zMql0yy77CnzTgyQDPi8aaasu7yGIpr/bwQNr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:6b45:: with SMTP id
 o5mr681905ybm.704.1644575715542; Fri, 11 Feb 2022 02:35:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:15 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-23-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 22/22] perf map: Add reference count checking
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

There's no strict get/put policy with map that leads to leaks or use
after free. Reference count checking identifies correct pairing of gets
and puts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/s390/annotate/instructions.c |  2 +-
 tools/perf/builtin-top.c                     |  4 +-
 tools/perf/tests/hists_link.c                |  2 +-
 tools/perf/tests/maps.c                      | 20 +++---
 tools/perf/tests/vmlinux-kallsyms.c          |  4 +-
 tools/perf/util/annotate.c                   |  4 +-
 tools/perf/util/machine.c                    | 26 ++++----
 tools/perf/util/map.c                        | 65 +++++++++++---------
 tools/perf/util/map.h                        | 34 +++++-----
 tools/perf/util/maps.c                       | 11 ++--
 tools/perf/util/symbol-elf.c                 | 27 ++++----
 tools/perf/util/symbol.c                     | 42 +++++++------
 12 files changed, 127 insertions(+), 114 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 740f1a63bc04..9953d510f7c1 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -40,7 +40,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map,
-			      map->map_ip(target.ms.map, target.addr)
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
 			     ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8db1df7bdabe..269d2dc3647c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -190,7 +190,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 	if (use_browser <= 0)
 		sleep(5);
 
-	map->erange_warned = true;
+	RC_CHK_ACCESS(map)->erange_warned = true;
 }
 
 static void perf_top__record_precise_ip(struct perf_top *top,
@@ -223,7 +223,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 		 */
 		pthread_mutex_unlock(&he->hists->lock);
 
-		if (err == -ERANGE && !he->ms.map->erange_warned)
+		if (err == -ERANGE && !RC_CHK_ACCESS(he->ms.map)->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
 		else if (err == -ENOMEM) {
 			pr_err("Not enough memory for annotating '%s' symbol!\n",
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 060e8731feff..6aae97c5c5a8 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -145,7 +145,7 @@ static int find_sample(struct sample *samples, size_t nr_samples,
 {
 	while (nr_samples--) {
 		if (samples->thread == t &&
-		    samples->map == m &&
+		    RC_CHK_ACCESS(samples->map) == RC_CHK_ACCESS(m) &&
 		    samples->sym == s)
 			return 1;
 		samples++;
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 38c1ec0074d1..9ef13e3316cd 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -30,7 +30,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 			if (map__start(map) != merged[i].start ||
 			    map__end(map) != merged[i].end ||
 			    strcmp(map__dso(map)->name, merged[i].name) ||
-			    refcount_read(&map->refcnt) != 1) {
+			    refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 1) {
 				failed = true;
 			}
 			i++;
@@ -50,7 +50,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 				map__start(map),
 				map__end(map),
 				map__dso(map)->name,
-				refcount_read(&map->refcnt));
+				refcount_read(&RC_CHK_ACCESS(map)->refcnt));
 		}
 	}
 	return failed ? TEST_FAIL : TEST_OK;
@@ -95,8 +95,8 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 		map = dso__new_map(bpf_progs[i].name);
 		TEST_ASSERT_VAL("failed to create map", map);
 
-		map->start = bpf_progs[i].start;
-		map->end   = bpf_progs[i].end;
+		RC_CHK_ACCESS(map)->start = bpf_progs[i].start;
+		RC_CHK_ACCESS(map)->end   = bpf_progs[i].end;
 		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
 		map__put(map);
 	}
@@ -111,16 +111,16 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	TEST_ASSERT_VAL("failed to create map", map_kcore3);
 
 	/* kcore1 map overlaps over all bpf maps */
-	map_kcore1->start = 100;
-	map_kcore1->end   = 1000;
+	RC_CHK_ACCESS(map_kcore1)->start = 100;
+	RC_CHK_ACCESS(map_kcore1)->end   = 1000;
 
 	/* kcore2 map hides behind bpf_prog_2 */
-	map_kcore2->start = 550;
-	map_kcore2->end   = 570;
+	RC_CHK_ACCESS(map_kcore2)->start = 550;
+	RC_CHK_ACCESS(map_kcore2)->end   = 570;
 
 	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
-	map_kcore3->start = 880;
-	map_kcore3->end   = 1100;
+	RC_CHK_ACCESS(map_kcore3)->start = 880;
+	RC_CHK_ACCESS(map_kcore3)->end   = 1100;
 
 	ret = maps__merge_in(maps, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 5afab21455f1..be22822f341e 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -299,7 +299,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 						? map__dso(map)->short_name
 						: map__dso(map)->name);
 		if (pair) {
-			pair->priv = 1;
+			RC_CHK_ACCESS(pair)->priv = 1;
 		} else {
 			if (!header_printed) {
 				pr_info("WARN: Maps only in vmlinux:\n");
@@ -335,7 +335,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 					map__start(pair), map__end(pair),
 					map__pgoff(pair));
 			pr_info(" %s\n", map__dso(pair)->name);
-			pair->priv = 1;
+			RC_CHK_ACCESS(pair)->priv = 1;
 		}
 	}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3a7433d3e48a..6afe2aa3321c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -281,7 +281,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map,
-			      map->map_ip(target.ms.map, target.addr)
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
 			      ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -411,7 +411,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 */
 	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map,
-			      map->map_ip(target.ms.map, target.addr)
+			      RC_CHK_ACCESS(map)->map_ip(target.ms.map, target.addr)
 			      ) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 49e4891e92b7..d948d365c5a8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -812,8 +812,8 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_loaded(map__dso(map));
 		}
 
-		map->start = event->ksymbol.addr;
-		map->end = map__start(map) + event->ksymbol.len;
+		RC_CHK_ACCESS(map)->start = event->ksymbol.addr;
+		RC_CHK_ACCESS(map)->end = map__start(map) + event->ksymbol.len;
 		err = maps__insert(machine__kernel_maps(machine), map);
 		if (err) {
 			err = -ENOMEM;
@@ -853,7 +853,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	if (!map)
 		return 0;
 
-	if (map != machine->vmlinux_map)
+	if (RC_CHK_ACCESS(map) != RC_CHK_ACCESS(machine->vmlinux_map))
 		maps__remove(machine__kernel_maps(machine), map);
 	else {
 		sym = dso__find_symbol(map__dso(map),
@@ -1120,8 +1120,8 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	if (!map)
 		return -ENOMEM;
 
-	map->end   = xm->end;
-	map->pgoff = xm->pgoff;
+	RC_CHK_ACCESS(map)->end   = xm->end;
+	RC_CHK_ACCESS(map)->pgoff = xm->pgoff;
 
 	kmap = map__kmap(map);
 
@@ -1193,7 +1193,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 
 		dest_map = maps__find(kmaps, map__pgoff(map));
 		if (dest_map != map)
-			map->pgoff = map__map_ip(dest_map, map__pgoff(map));
+			RC_CHK_ACCESS(map)->pgoff = map__map_ip(dest_map, map__pgoff(map));
 		found = true;
 	}
 	if (found || machine->trampolines_mapped)
@@ -1244,8 +1244,8 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	if (machine->vmlinux_map == NULL)
 		return -ENOMEM;
 
-	machine->vmlinux_map->map_ip = map__identity_ip;
-	machine->vmlinux_map->unmap_ip = map__identity_ip;
+	RC_CHK_ACCESS(machine->vmlinux_map)->map_ip = map__identity_ip;
+	RC_CHK_ACCESS(machine->vmlinux_map)->unmap_ip = map__identity_ip;
 	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
 }
 
@@ -1522,7 +1522,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	map = machine__addnew_module_map(machine, start, name);
 	if (map == NULL)
 		return -1;
-	map->end = start + size;
+	RC_CHK_ACCESS(map)->end = start + size;
 
 	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
 	map__put(map);
@@ -1558,14 +1558,14 @@ static int machine__create_modules(struct machine *machine)
 static void machine__set_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
-	machine->vmlinux_map->start = start;
-	machine->vmlinux_map->end   = end;
+	RC_CHK_ACCESS(machine->vmlinux_map)->start = start;
+	RC_CHK_ACCESS(machine->vmlinux_map)->end   = end;
 	/*
 	 * Be a bit paranoid here, some perf.data file came with
 	 * a zero sized synthesized MMAP event for the kernel.
 	 */
 	if (start == 0 && end == 0)
-		machine->vmlinux_map->end = ~0ULL;
+		RC_CHK_ACCESS(machine->vmlinux_map)->end = ~0ULL;
 }
 
 static int machine__update_kernel_mmap(struct machine *machine,
@@ -1700,7 +1700,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (map == NULL)
 			goto out_problem;
 
-		map->end = map__start(map) + xm->end - xm->start;
+		RC_CHK_ACCESS(map)->end = map__start(map) + xm->end - xm->start;
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(map__dso(map), bid);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 47d81e361e29..ad52c763596d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -104,15 +104,15 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 {
-	map->start    = start;
-	map->end      = end;
-	map->pgoff    = pgoff;
-	map->reloc    = 0;
-	map->dso      = dso__get(dso);
-	map->map_ip   = map__dso_map_ip;
-	map->unmap_ip = map__dso_unmap_ip;
-	map->erange_warned = false;
-	refcount_set(&map->refcnt, 1);
+	RC_CHK_ACCESS(map)->start    = start;
+	RC_CHK_ACCESS(map)->end      = end;
+	RC_CHK_ACCESS(map)->pgoff    = pgoff;
+	RC_CHK_ACCESS(map)->reloc    = 0;
+	RC_CHK_ACCESS(map)->dso      = dso__get(dso);
+	RC_CHK_ACCESS(map)->map_ip   = map__dso_map_ip;
+	RC_CHK_ACCESS(map)->unmap_ip = map__dso_unmap_ip;
+	RC_CHK_ACCESS(map)->erange_warned = false;
+	refcount_set(&RC_CHK_ACCESS(map)->refcnt, 1);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -120,12 +120,13 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u32 prot, u32 flags, struct build_id *bid,
 		     char *filename, struct thread *thread)
 {
-	struct map *map;
+	struct map *res;
+	RC_STRUCT(map) *map;
 	struct nsinfo *nsi = NULL;
 	struct nsinfo *nnsi;
 
 	map = malloc(sizeof(*map));
-	if (map != NULL) {
+	if (ADD_RC_CHK(res, map)) {
 		char newfilename[PATH_MAX];
 		struct dso *dso;
 		int anon, no_dso, vdso, android;
@@ -168,7 +169,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
-		map__init(map, start, start + len, pgoff, dso);
+		map__init(res, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
 			map->map_ip = map->unmap_ip = map__identity_ip;
@@ -191,10 +192,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 
 		dso__put(dso);
 	}
-	return map;
+	return res;
 out_delete:
 	nsinfo__put(nsi);
-	free(map);
+	RC_CHK_FREE(res);
 	return NULL;
 }
 
@@ -205,17 +206,18 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  */
 struct map *map__new2(u64 start, struct dso *dso)
 {
-	struct map *map;
+	struct map *res;
+	RC_STRUCT(map) *map;
 
 	map = calloc(1, sizeof(*map) + (dso->kernel ? sizeof(struct kmap) : 0));
-	if (map != NULL) {
+	if (ADD_RC_CHK(res, map)) {
 		/*
 		 * ->end will be filled after we load all the symbols
 		 */
-		map__init(map, start, 0, 0, dso);
+		map__init(res, start, 0, 0, dso);
 	}
 
-	return map;
+	return res;
 }
 
 bool __map__is_kernel(const struct map *map)
@@ -277,20 +279,22 @@ bool map__has_symbols(const struct map *map)
 
 static void map__exit(struct map *map)
 {
-	BUG_ON(refcount_read(&map->refcnt) != 0);
-	dso__zput(map->dso);
+	BUG_ON(refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 0);
+	dso__zput(RC_CHK_ACCESS(map)->dso);
 }
 
 void map__delete(struct map *map)
 {
 	map__exit(map);
-	free(map);
+	RC_CHK_FREE(map);
 }
 
 void map__put(struct map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(&RC_CHK_ACCESS(map)->refcnt))
 		map__delete(map);
+	else
+		RC_CHK_PUT(map);
 }
 
 void map__fixup_start(struct map *map)
@@ -299,7 +303,7 @@ void map__fixup_start(struct map *map)
 	struct rb_node *nd = rb_first_cached(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map->start = sym->start;
+		RC_CHK_ACCESS(map)->start = sym->start;
 	}
 }
 
@@ -309,7 +313,7 @@ void map__fixup_end(struct map *map)
 	struct rb_node *nd = rb_last(&symbols->rb_root);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
-		map->end = sym->end;
+		RC_CHK_ACCESS(map)->end = sym->end;
 	}
 }
 
@@ -376,19 +380,20 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 
 struct map *map__clone(struct map *from)
 {
-	struct map *map;
-	size_t size = sizeof(struct map);
+	struct map *res;
+	RC_STRUCT(map) *map;
+	size_t size = sizeof(RC_STRUCT(map));
 
 	if (map__dso(from) && map__dso(from)->kernel)
 		size += sizeof(struct kmap);
 
-	map = memdup(from, size);
-	if (map != NULL) {
+	map = memdup(RC_CHK_ACCESS(from), size);
+	if (ADD_RC_CHK(res, map)) {
 		refcount_set(&map->refcnt, 1);
 		map->dso = dso__get(map->dso);
 	}
 
-	return map;
+	return res;
 }
 
 size_t map__fprintf(struct map *map, FILE *fp)
@@ -534,7 +539,7 @@ struct kmap *__map__kmap(struct map *map)
 {
 	if (!map__dso(map) || !map__dso(map)->kernel)
 		return NULL;
-	return (struct kmap *)(&map[1]);
+	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
 
 struct kmap *map__kmap(struct map *map)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 99ef0464a357..6a6bc7605e75 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -10,12 +10,13 @@
 #include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <internal/rc_check.h>
 
 struct dso;
 struct maps;
 struct machine;
 
-struct map {
+DECLARE_RC_STRUCT(map) {
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
@@ -49,52 +50,52 @@ u64 map__identity_ip(const struct map *map __maybe_unused, u64 ip);
 
 static inline struct dso *map__dso(const struct map *map)
 {
-	return map->dso;
+	return RC_CHK_ACCESS(map)->dso;
 }
 
 static inline u64 map__map_ip(const struct map *map, u64 ip)
 {
-	return map->map_ip(map, ip);
+	return RC_CHK_ACCESS(map)->map_ip(map, ip);
 }
 
 static inline u64 map__unmap_ip(const struct map *map, u64 ip)
 {
-	return map->unmap_ip(map, ip);
+	return RC_CHK_ACCESS(map)->unmap_ip(map, ip);
 }
 
 static inline u64 map__start(const struct map *map)
 {
-	return map->start;
+	return RC_CHK_ACCESS(map)->start;
 }
 
 static inline u64 map__end(const struct map *map)
 {
-	return map->end;
+	return RC_CHK_ACCESS(map)->end;
 }
 
 static inline u64 map__pgoff(const struct map *map)
 {
-	return map->pgoff;
+	return RC_CHK_ACCESS(map)->pgoff;
 }
 
 static inline u64 map__reloc(const struct map *map)
 {
-	return map->reloc;
+	return RC_CHK_ACCESS(map)->reloc;
 }
 
 static inline u32 map__flags(const struct map *map)
 {
-	return map->flags;
+	return RC_CHK_ACCESS(map)->flags;
 }
 
 static inline u32 map__prot(const struct map *map)
 {
-	return map->prot;
+	return RC_CHK_ACCESS(map)->prot;
 }
 
 static inline bool map__priv(const struct map *map)
 {
-	return map->priv;
+	return RC_CHK_ACCESS(map)->priv;
 }
 
 static inline size_t map__size(const struct map *map)
@@ -119,7 +120,7 @@ struct thread;
  * Note: caller must ensure map->dso is not NULL (map is loaded).
  */
 #define map__for_each_symbol(map, pos, n)	\
-	dso__for_each_symbol(map->dso, pos, n)
+	dso__for_each_symbol(map__dso(map), pos, n)
 
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
@@ -153,9 +154,12 @@ struct map *map__clone(struct map *map);
 
 static inline struct map *map__get(struct map *map)
 {
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
+	struct map *result;
+
+	if (RC_CHK_GET(result, map))
+		refcount_inc(&RC_CHK_ACCESS(map)->refcnt);
+
+	return result;
 }
 
 void map__put(struct map *map);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index da59204cb9bb..c579161c12c8 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -124,7 +124,7 @@ void maps__remove(struct maps *maps, struct map *map)
 		RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
 
 	rb_node = maps__find_node(maps, map);
-	assert(rb_node->map == map);
+	assert(rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map));
 	__maps__remove(maps, rb_node);
 	--RC_CHK_ACCESS(maps)->nr_maps;
 	if (maps__maps_by_name(maps))
@@ -335,7 +335,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			before->end = map__start(map);
+			RC_CHK_ACCESS(before)->end = map__start(map);
 			if (!__maps__insert(maps, before)) {
 				map__put(before);
 				err = -ENOMEM;
@@ -355,8 +355,9 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			after->start = map__end(map);
-			after->pgoff += map__end(map) - map__start(pos->map);
+			RC_CHK_ACCESS(after)->start = map__end(map);
+			RC_CHK_ACCESS(after)->pgoff +=
+				map__end(map) - map__start(pos->map);
 			assert(map__map_ip(pos->map, map__end(map)) ==
 				map__map_ip(after, map__end(map)));
 			if (!__maps__insert(maps, after)) {
@@ -418,7 +419,7 @@ struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
 	struct map_rb_node *rb_node;
 
 	maps__for_each_entry(maps, rb_node) {
-		if (rb_node->map == map)
+		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
 			return rb_node;
 	}
 	return NULL;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 056405d3d655..555ac6f5bd75 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -993,11 +993,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && dso->kernel && !kmodule) {
 			*remap_kernel = false;
-			map->start = shdr->sh_addr + ref_reloc(kmap);
-			map->end = map__start(map) + shdr->sh_size;
-			map->pgoff = shdr->sh_offset;
-			map->map_ip = map__dso_map_ip;
-			map->unmap_ip = map__dso_unmap_ip;
+			RC_CHK_ACCESS(map)->start = shdr->sh_addr + ref_reloc(kmap);
+			RC_CHK_ACCESS(map)->end = map__start(map) + shdr->sh_size;
+			RC_CHK_ACCESS(map)->pgoff = shdr->sh_offset;
+			RC_CHK_ACCESS(map)->map_ip = map__dso_map_ip;
+			RC_CHK_ACCESS(map)->unmap_ip = map__dso_unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
@@ -1018,7 +1018,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && kmodule) {
 			*remap_kernel = false;
-			map->pgoff = shdr->sh_offset;
+			RC_CHK_ACCESS(map)->pgoff = shdr->sh_offset;
 		}
 
 		*curr_dsop = dso;
@@ -1052,12 +1052,13 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__kmap(curr_map)->kmaps = kmaps;
 
 		if (adjust_kernel_syms) {
-			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
-			curr_map->end	= map__start(curr_map) + shdr->sh_size;
-			curr_map->pgoff	= shdr->sh_offset;
+			RC_CHK_ACCESS(curr_map)->start  = shdr->sh_addr + ref_reloc(kmap);
+			RC_CHK_ACCESS(curr_map)->end	= map__start(curr_map) +
+							  shdr->sh_size;
+			RC_CHK_ACCESS(curr_map)->pgoff	= shdr->sh_offset;
 		} else {
-			curr_map->map_ip = map__identity_ip;
-			curr_map->unmap_ip = map__identity_ip;
+			RC_CHK_ACCESS(curr_map)->map_ip = map__identity_ip;
+			RC_CHK_ACCESS(curr_map)->unmap_ip = map__identity_ip;
 		}
 		curr_dso->symtab_type = dso->symtab_type;
 		if (maps__insert(kmaps, curr_map))
@@ -1161,7 +1162,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			if (strcmp(elf_name, kmap->ref_reloc_sym->name))
 				continue;
 			kmap->ref_reloc_sym->unrelocated_addr = sym.st_value;
-			map->reloc = kmap->ref_reloc_sym->addr -
+			RC_CHK_ACCESS(map)->reloc = kmap->ref_reloc_sym->addr -
 				     kmap->ref_reloc_sym->unrelocated_addr;
 			break;
 		}
@@ -1172,7 +1173,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * attempted to prelink vdso to its virtual address.
 	 */
 	if (dso__is_vdso(dso))
-		map->reloc = map__start(map) - dso->text_offset;
+		RC_CHK_ACCESS(map)->reloc = map__start(map) - dso->text_offset;
 
 	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
 	/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fdaeeebd6050..39a650322300 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -253,7 +253,7 @@ void maps__fixup_end(struct maps *maps)
 
 	maps__for_each_entry(maps, curr) {
 		if (prev != NULL && !map__end(prev->map))
-			prev->map->end = map__start(curr->map);
+			RC_CHK_ACCESS(prev->map)->end = map__start(curr->map);
 
 		prev = curr;
 	}
@@ -263,7 +263,7 @@ void maps__fixup_end(struct maps *maps)
 	 * last map final address.
 	 */
 	if (curr && !map__end(curr->map))
-		curr->map->end = ~0ULL;
+		RC_CHK_ACCESS(curr->map)->end = ~0ULL;
 
 	up_write(maps__lock(maps));
 }
@@ -831,7 +831,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			*module++ = '\0';
 
 			if (strcmp(map__dso(curr_map)->short_name, module)) {
-				if (curr_map != initial_map &&
+				if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map) &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
 					/*
@@ -910,8 +910,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 			}
 
-			curr_map->map_ip = map__identity_ip;
-			curr_map->unmap_ip = map__identity_ip;
+			RC_CHK_ACCESS(curr_map)->map_ip = map__identity_ip;
+			RC_CHK_ACCESS(curr_map)->unmap_ip = map__identity_ip;
 			if (maps__insert(kmaps, curr_map)) {
 				dso__put(ndso);
 				return -1;
@@ -1215,8 +1215,8 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 		return -ENOMEM;
 	}
 
-	list_node->map->end = map__start(list_node->map) + len;
-	list_node->map->pgoff = pgoff;
+	list_node->RC_CHK_ACCESS(map)->end = map__start(list_node->map) + len;
+	list_node->RC_CHK_ACCESS(map)->pgoff = pgoff;
 
 	list_add(&list_node->node, &md->maps);
 
@@ -1251,7 +1251,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 * |new......|     -> |new..|
 				 *       |old....| ->       |old....|
 				 */
-				new_map->end = map__start(old_map);
+				RC_CHK_ACCESS(new_map)->end = map__start(old_map);
 			} else {
 				/*
 				 * |new.............| -> |new..|       |new..|
@@ -1272,11 +1272,12 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 					goto out;
 				}
 
-				m->map->end = map__start(old_map);
+
+				RC_CHK_ACCESS(m->map)->end = map__start(old_map);
 				list_add_tail(&m->node, &merged);
-				new_map->pgoff +=
+				RC_CHK_ACCESS(new_map)->pgoff +=
 					map__end(old_map) - map__start(new_map);
-				new_map->start = map__end(old_map);
+				RC_CHK_ACCESS(new_map)->start = map__end(old_map);
 			}
 		} else {
 			/*
@@ -1296,9 +1297,10 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 *      |new......| ->         |new...|
 				 * |old....|        -> |old....|
 				 */
-				new_map->pgoff +=
+
+				RC_CHK_ACCESS(new_map)->pgoff +=
 					map__end(old_map) - map__start(new_map);
-				new_map->start = map__end(old_map);
+				RC_CHK_ACCESS(new_map)->start = map__end(old_map);
 			}
 		}
 	}
@@ -1411,14 +1413,14 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		new_node = list_entry(md.maps.next, struct map_list_node, node);
 		list_del_init(&new_node->node);
-		if (new_node->map == replacement_map) {
+		if (RC_CHK_ACCESS(new_node->map) == RC_CHK_ACCESS(replacement_map)) {
 			struct  map *updated;
 
-			map->start = map__start(new_node->map);
-			map->end   = map__end(new_node->map);
-			map->pgoff = map__pgoff(new_node->map);
-			map->map_ip = new_node->map->map_ip;
-			map->unmap_ip = new_node->map->unmap_ip;
+			RC_CHK_ACCESS(map)->start = map__start(new_node->map);
+			RC_CHK_ACCESS(map)->end   = map__end(new_node->map);
+			RC_CHK_ACCESS(map)->pgoff = map__pgoff(new_node->map);
+			RC_CHK_ACCESS(map)->map_ip = RC_CHK_ACCESS(new_node->map)->map_ip;
+			RC_CHK_ACCESS(map)->unmap_ip = RC_CHK_ACCESS(new_node->map)->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			updated = map__get(map);
 			maps__remove(kmaps, map);
@@ -2058,7 +2060,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	down_read(maps__lock(maps));
 
 	if (RC_CHK_ACCESS(maps)->last_search_by_name &&
-	    strcmp(map__dso(maps->last_search_by_name)->short_name, name) == 0) {
+	    strcmp(map__dso(RC_CHK_ACCESS(maps)->last_search_by_name)->short_name, name) == 0) {
 		map = RC_CHK_ACCESS(maps)->last_search_by_name;
 		goto out_unlock;
 	}
-- 
2.35.1.265.g69c8d7142f-goog

