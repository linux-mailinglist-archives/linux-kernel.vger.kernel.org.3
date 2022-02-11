Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB04B234B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbiBKKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiBKKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CDEA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso16800451ybb.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LrddYWyXaxH+uZEblaokvexEVHXPxvXvKHOPmBC4R1k=;
        b=gboZ5ClkY6spz9sr4lex4JowKWFRIODa8BnNB+0J/eM53aunePmHbmwrXGa2VVYu0S
         h44pCJ0owqOQWkdOADb/kkOqjf2XKeOBRnbXRiGutJzhiTcBzZMlyGxX5hhONJ7ppD5Y
         3Nis+UtoQLu2yDBDYRWajdMVZIVzz+sCx6QTIXGwJKSKWIjIyx/D6YANxzTzU9NUDBfu
         bw4iij9DDMk6X+d0y0S9I0mh6kJORZVSRSunVumvfewzfUjwSA9Fsm6NZQQif29qZBjK
         C9uQ9bfLaAeJDo5l9cW+khyVffjOSD6b/EHz5Jkir3fBJELG3cOg9eoMePBCpXccwiuq
         uTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LrddYWyXaxH+uZEblaokvexEVHXPxvXvKHOPmBC4R1k=;
        b=YRRBxO7fg3rtDXKmnJkJe2RSA71aUfWvk8L3jZxbiJLkrm+T2IBAe5UJR1dcYYQ4nZ
         /alxZspgSClFub449SI78WxiUmbSe0LIAaqWcia24R3UPzs6L3u8ZEjbb0mYCvaGpqvs
         meyYdDYOgTE4MCDQNlIoTw9YnGfW1Llk2xyRrtWv8vXr3fDegyhGVSYkosXdNBDdTAJx
         NN2/73iFTEuq+nljBbF1m57qg2MV/+4zs/JvGXr4NWs6jIwFYHHdMVl3A4h3XIPyJRWM
         IeL7Yxj9LL8j0W7JRKk0UnPkRTEsbEPSfSw4i0+9F3aYQ+t5u0pJVBsNQu58PF5kT5d5
         SFSA==
X-Gm-Message-State: AOAM5329aGvu745zs/3+hqxA98NO3OAx7SljjO9PtQCVm75RqtBaPCgq
        9zqQWdZ3eXyYDmZfg944e1aVG9nLeSG5
X-Google-Smtp-Source: ABdhPJxdLfLRjNuAEEl1K3PMh2J2PCTxrfmMUhlSmFlJyI9dq2vKAbqxWs5bvW44Gz7d6km33wgrZhU4kiAy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:c644:: with SMTP id
 k65mr653225ybf.288.1644575680446; Fri, 11 Feb 2022 02:34:40 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:01 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-9-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 08/22] perf maps: Move maps code to own C file
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

The maps code has its own header, move the corresponding C function
definitions to their own C file. In the process tidy and minimize
includes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build  |   1 +
 tools/perf/util/map.c  | 417 +----------------------------------------
 tools/perf/util/map.h  |   2 +
 tools/perf/util/maps.c | 403 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 414 insertions(+), 409 deletions(-)
 create mode 100644 tools/perf/util/maps.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2a403cefcaf2..9a7209a99e16 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -56,6 +56,7 @@ perf-y += debug.o
 perf-y += fncache.o
 perf-y += machine.o
 perf-y += map.o
+perf-y += maps.o
 perf-y += pstack.o
 perf-y += session.o
 perf-y += sample-raw.o
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 4d1de363c19a..2cfe5744b86c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1,31 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "symbol.h"
-#include <assert.h>
-#include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <stdio.h>
-#include <unistd.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
+#include "debug.h"
 #include "dso.h"
 #include "map.h"
-#include "map_symbol.h"
+#include "namespaces.h"
+#include "srcline.h"
+#include "symbol.h"
 #include "thread.h"
 #include "vdso.h"
-#include "build-id.h"
-#include "debug.h"
-#include "machine.h"
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include "srcline.h"
-#include "namespaces.h"
-#include "unwind.h"
-#include "srccode.h"
-#include "ui/ui.h"
-
-static void __maps__insert(struct maps *maps, struct map *map);
 
 static inline int is_android_lib(const char *filename)
 {
@@ -527,403 +516,13 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-static void maps__init(struct maps *maps, struct machine *machine)
-{
-	maps->entries = RB_ROOT;
-	init_rwsem(&maps->lock);
-	maps->machine = machine;
-	maps->last_search_by_name = NULL;
-	maps->nr_maps = 0;
-	maps->maps_by_name = NULL;
-	refcount_set(&maps->refcnt, 1);
-}
-
-static void __maps__free_maps_by_name(struct maps *maps)
-{
-	/*
-	 * Free everything to try to do it from the rbtree in the next search
-	 */
-	zfree(&maps->maps_by_name);
-	maps->nr_maps_allocated = 0;
-}
-
-void maps__insert(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	__maps__insert(maps, map);
-	++maps->nr_maps;
-
-	if (map->dso && map->dso->kernel) {
-		struct kmap *kmap = map__kmap(map);
-
-		if (kmap)
-			kmap->kmaps = maps;
-		else
-			pr_err("Internal error: kernel dso with non kernel map\n");
-	}
-
-
-	/*
-	 * If we already performed some search by name, then we need to add the just
-	 * inserted map and resort.
-	 */
-	if (maps->maps_by_name) {
-		if (maps->nr_maps > maps->nr_maps_allocated) {
-			int nr_allocate = maps->nr_maps * 2;
-			struct map **maps_by_name = realloc(maps->maps_by_name, nr_allocate * sizeof(map));
-
-			if (maps_by_name == NULL) {
-				__maps__free_maps_by_name(maps);
-				up_write(&maps->lock);
-				return;
-			}
-
-			maps->maps_by_name = maps_by_name;
-			maps->nr_maps_allocated = nr_allocate;
-		}
-		maps->maps_by_name[maps->nr_maps - 1] = map;
-		__maps__sort_by_name(maps);
-	}
-	up_write(&maps->lock);
-}
-
-static void __maps__remove(struct maps *maps, struct map *map)
-{
-	rb_erase_init(&map->rb_node, &maps->entries);
-	map__put(map);
-}
-
-void maps__remove(struct maps *maps, struct map *map)
-{
-	down_write(&maps->lock);
-	if (maps->last_search_by_name == map)
-		maps->last_search_by_name = NULL;
-
-	__maps__remove(maps, map);
-	--maps->nr_maps;
-	if (maps->maps_by_name)
-		__maps__free_maps_by_name(maps);
-	up_write(&maps->lock);
-}
-
-static void __maps__purge(struct maps *maps)
-{
-	struct map *pos, *next;
-
-	maps__for_each_entry_safe(maps, pos, next) {
-		rb_erase_init(&pos->rb_node,  &maps->entries);
-		map__put(pos);
-	}
-}
-
-static void maps__exit(struct maps *maps)
-{
-	down_write(&maps->lock);
-	__maps__purge(maps);
-	up_write(&maps->lock);
-}
-
-bool maps__empty(struct maps *maps)
-{
-	return !maps__first(maps);
-}
-
-struct maps *maps__new(struct machine *machine)
-{
-	struct maps *maps = zalloc(sizeof(*maps));
-
-	if (maps != NULL)
-		maps__init(maps, machine);
-
-	return maps;
-}
-
-void maps__delete(struct maps *maps)
-{
-	maps__exit(maps);
-	unwind__finish_access(maps);
-	free(maps);
-}
-
-void maps__put(struct maps *maps)
-{
-	if (maps && refcount_dec_and_test(&maps->refcnt))
-		maps__delete(maps);
-}
-
-struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
-{
-	struct map *map = maps__find(maps, addr);
-
-	/* Ensure map is loaded before using map->map_ip */
-	if (map != NULL && map__load(map) >= 0) {
-		if (mapp != NULL)
-			*mapp = map;
-		return map__find_symbol(map, map->map_ip(map, addr));
-	}
-
-	return NULL;
-}
-
-static bool map__contains_symbol(struct map *map, struct symbol *sym)
+bool map__contains_symbol(struct map *map, struct symbol *sym)
 {
 	u64 ip = map->unmap_ip(map, sym->start);
 
 	return ip >= map->start && ip < map->end;
 }
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
-{
-	struct symbol *sym;
-	struct map *pos;
-
-	down_read(&maps->lock);
-
-	maps__for_each_entry(maps, pos) {
-		sym = map__find_symbol_by_name(pos, name);
-
-		if (sym == NULL)
-			continue;
-		if (!map__contains_symbol(pos, sym)) {
-			sym = NULL;
-			continue;
-		}
-		if (mapp != NULL)
-			*mapp = pos;
-		goto out;
-	}
-
-	sym = NULL;
-out:
-	up_read(&maps->lock);
-	return sym;
-}
-
-int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
-{
-	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
-		if (maps == NULL)
-			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);
-		if (ams->ms.map == NULL)
-			return -1;
-	}
-
-	ams->al_addr = ams->ms.map->map_ip(ams->ms.map, ams->addr);
-	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
-
-	return ams->ms.sym ? 0 : -1;
-}
-
-size_t maps__fprintf(struct maps *maps, FILE *fp)
-{
-	size_t printed = 0;
-	struct map *pos;
-
-	down_read(&maps->lock);
-
-	maps__for_each_entry(maps, pos) {
-		printed += fprintf(fp, "Map:");
-		printed += map__fprintf(pos, fp);
-		if (verbose > 2) {
-			printed += dso__fprintf(pos->dso, fp);
-			printed += fprintf(fp, "--\n");
-		}
-	}
-
-	up_read(&maps->lock);
-
-	return printed;
-}
-
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
-{
-	struct rb_root *root;
-	struct rb_node *next, *first;
-	int err = 0;
-
-	down_write(&maps->lock);
-
-	root = &maps->entries;
-
-	/*
-	 * Find first map where end > map->start.
-	 * Same as find_vma() in kernel.
-	 */
-	next = root->rb_node;
-	first = NULL;
-	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
-
-		if (pos->end > map->start) {
-			first = next;
-			if (pos->start <= map->start)
-				break;
-			next = next->rb_left;
-		} else
-			next = next->rb_right;
-	}
-
-	next = first;
-	while (next) {
-		struct map *pos = rb_entry(next, struct map, rb_node);
-		next = rb_next(&pos->rb_node);
-
-		/*
-		 * Stop if current map starts after map->end.
-		 * Maps are ordered by start: next will not overlap for sure.
-		 */
-		if (pos->start >= map->end)
-			break;
-
-		if (verbose >= 2) {
-
-			if (use_browser) {
-				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					   map->dso->name);
-			} else {
-				fputs("overlapping maps:\n", fp);
-				map__fprintf(map, fp);
-				map__fprintf(pos, fp);
-			}
-		}
-
-		rb_erase_init(&pos->rb_node, root);
-		/*
-		 * Now check if we need to create new maps for areas not
-		 * overlapped by the new map:
-		 */
-		if (map->start > pos->start) {
-			struct map *before = map__clone(pos);
-
-			if (before == NULL) {
-				err = -ENOMEM;
-				goto put_map;
-			}
-
-			before->end = map->start;
-			__maps__insert(maps, before);
-			if (verbose >= 2 && !use_browser)
-				map__fprintf(before, fp);
-			map__put(before);
-		}
-
-		if (map->end < pos->end) {
-			struct map *after = map__clone(pos);
-
-			if (after == NULL) {
-				err = -ENOMEM;
-				goto put_map;
-			}
-
-			after->start = map->end;
-			after->pgoff += map->end - pos->start;
-			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
-			__maps__insert(maps, after);
-			if (verbose >= 2 && !use_browser)
-				map__fprintf(after, fp);
-			map__put(after);
-		}
-put_map:
-		map__put(pos);
-
-		if (err)
-			goto out;
-	}
-
-	err = 0;
-out:
-	up_write(&maps->lock);
-	return err;
-}
-
-/*
- * XXX This should not really _copy_ te maps, but refcount them.
- */
-int maps__clone(struct thread *thread, struct maps *parent)
-{
-	struct maps *maps = thread->maps;
-	int err;
-	struct map *map;
-
-	down_read(&parent->lock);
-
-	maps__for_each_entry(parent, map) {
-		struct map *new = map__clone(map);
-
-		if (new == NULL) {
-			err = -ENOMEM;
-			goto out_unlock;
-		}
-
-		err = unwind__prepare_access(maps, new, NULL);
-		if (err)
-			goto out_unlock;
-
-		maps__insert(maps, new);
-		map__put(new);
-	}
-
-	err = 0;
-out_unlock:
-	up_read(&parent->lock);
-	return err;
-}
-
-static void __maps__insert(struct maps *maps, struct map *map)
-{
-	struct rb_node **p = &maps->entries.rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = map->start;
-	struct map *m;
-
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node);
-		if (ip < m->start)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
-
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color(&map->rb_node, &maps->entries);
-	map__get(map);
-}
-
-struct map *maps__find(struct maps *maps, u64 ip)
-{
-	struct rb_node *p;
-	struct map *m;
-
-	down_read(&maps->lock);
-
-	p = maps->entries.rb_node;
-	while (p != NULL) {
-		m = rb_entry(p, struct map, rb_node);
-		if (ip < m->start)
-			p = p->rb_left;
-		else if (ip >= m->end)
-			p = p->rb_right;
-		else
-			goto out;
-	}
-
-	m = NULL;
-out:
-	up_read(&maps->lock);
-	return m;
-}
-
-struct map *maps__first(struct maps *maps)
-{
-	struct rb_node *first = rb_first(&maps->entries);
-
-	if (first)
-		return rb_entry(first, struct map, rb_node);
-	return NULL;
-}
-
 static struct map *__map__next(struct map *map)
 {
 	struct rb_node *next = rb_next(&map->rb_node);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index d32f5b28c1fb..973dce27b253 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -160,6 +160,8 @@ static inline bool __map__is_kmodule(const struct map *map)
 
 bool map__has_symbols(const struct map *map);
 
+bool map__contains_symbol(struct map *map, struct symbol *sym);
+
 #define ENTRY_TRAMPOLINE_NAME "__entry_SYSCALL_64_trampoline"
 
 static inline bool is_entry_trampoline(const char *name)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
new file mode 100644
index 000000000000..ededabf0a230
--- /dev/null
+++ b/tools/perf/util/maps.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdlib.h>
+#include <linux/zalloc.h>
+#include "debug.h"
+#include "dso.h"
+#include "map.h"
+#include "maps.h"
+#include "thread.h"
+#include "ui/ui.h"
+#include "unwind.h"
+
+static void __maps__insert(struct maps *maps, struct map *map);
+
+void maps__init(struct maps *maps, struct machine *machine)
+{
+	maps->entries = RB_ROOT;
+	init_rwsem(&maps->lock);
+	maps->machine = machine;
+	maps->last_search_by_name = NULL;
+	maps->nr_maps = 0;
+	maps->maps_by_name = NULL;
+	refcount_set(&maps->refcnt, 1);
+}
+
+static void __maps__free_maps_by_name(struct maps *maps)
+{
+	/*
+	 * Free everything to try to do it from the rbtree in the next search
+	 */
+	zfree(&maps->maps_by_name);
+	maps->nr_maps_allocated = 0;
+}
+
+void maps__insert(struct maps *maps, struct map *map)
+{
+	down_write(&maps->lock);
+	__maps__insert(maps, map);
+	++maps->nr_maps;
+
+	if (map->dso && map->dso->kernel) {
+		struct kmap *kmap = map__kmap(map);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+
+
+	/*
+	 * If we already performed some search by name, then we need to add the just
+	 * inserted map and resort.
+	 */
+	if (maps->maps_by_name) {
+		if (maps->nr_maps > maps->nr_maps_allocated) {
+			int nr_allocate = maps->nr_maps * 2;
+			struct map **maps_by_name = realloc(maps->maps_by_name, nr_allocate * sizeof(map));
+
+			if (maps_by_name == NULL) {
+				__maps__free_maps_by_name(maps);
+				up_write(&maps->lock);
+				return;
+			}
+
+			maps->maps_by_name = maps_by_name;
+			maps->nr_maps_allocated = nr_allocate;
+		}
+		maps->maps_by_name[maps->nr_maps - 1] = map;
+		__maps__sort_by_name(maps);
+	}
+	up_write(&maps->lock);
+}
+
+static void __maps__remove(struct maps *maps, struct map *map)
+{
+	rb_erase_init(&map->rb_node, &maps->entries);
+	map__put(map);
+}
+
+void maps__remove(struct maps *maps, struct map *map)
+{
+	down_write(&maps->lock);
+	if (maps->last_search_by_name == map)
+		maps->last_search_by_name = NULL;
+
+	__maps__remove(maps, map);
+	--maps->nr_maps;
+	if (maps->maps_by_name)
+		__maps__free_maps_by_name(maps);
+	up_write(&maps->lock);
+}
+
+static void __maps__purge(struct maps *maps)
+{
+	struct map *pos, *next;
+
+	maps__for_each_entry_safe(maps, pos, next) {
+		rb_erase_init(&pos->rb_node,  &maps->entries);
+		map__put(pos);
+	}
+}
+
+void maps__exit(struct maps *maps)
+{
+	down_write(&maps->lock);
+	__maps__purge(maps);
+	up_write(&maps->lock);
+}
+
+bool maps__empty(struct maps *maps)
+{
+	return !maps__first(maps);
+}
+
+struct maps *maps__new(struct machine *machine)
+{
+	struct maps *maps = zalloc(sizeof(*maps));
+
+	if (maps != NULL)
+		maps__init(maps, machine);
+
+	return maps;
+}
+
+void maps__delete(struct maps *maps)
+{
+	maps__exit(maps);
+	unwind__finish_access(maps);
+	free(maps);
+}
+
+void maps__put(struct maps *maps)
+{
+	if (maps && refcount_dec_and_test(&maps->refcnt))
+		maps__delete(maps);
+}
+
+struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
+{
+	struct map *map = maps__find(maps, addr);
+
+	/* Ensure map is loaded before using map->map_ip */
+	if (map != NULL && map__load(map) >= 0) {
+		if (mapp != NULL)
+			*mapp = map;
+		return map__find_symbol(map, map->map_ip(map, addr));
+	}
+
+	return NULL;
+}
+
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
+{
+	struct symbol *sym;
+	struct map *pos;
+
+	down_read(&maps->lock);
+
+	maps__for_each_entry(maps, pos) {
+		sym = map__find_symbol_by_name(pos, name);
+
+		if (sym == NULL)
+			continue;
+		if (!map__contains_symbol(pos, sym)) {
+			sym = NULL;
+			continue;
+		}
+		if (mapp != NULL)
+			*mapp = pos;
+		goto out;
+	}
+
+	sym = NULL;
+out:
+	up_read(&maps->lock);
+	return sym;
+}
+
+int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
+{
+	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
+		if (maps == NULL)
+			return -1;
+		ams->ms.map = maps__find(maps, ams->addr);
+		if (ams->ms.map == NULL)
+			return -1;
+	}
+
+	ams->al_addr = ams->ms.map->map_ip(ams->ms.map, ams->addr);
+	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
+
+	return ams->ms.sym ? 0 : -1;
+}
+
+size_t maps__fprintf(struct maps *maps, FILE *fp)
+{
+	size_t printed = 0;
+	struct map *pos;
+
+	down_read(&maps->lock);
+
+	maps__for_each_entry(maps, pos) {
+		printed += fprintf(fp, "Map:");
+		printed += map__fprintf(pos, fp);
+		if (verbose > 2) {
+			printed += dso__fprintf(pos->dso, fp);
+			printed += fprintf(fp, "--\n");
+		}
+	}
+
+	up_read(&maps->lock);
+
+	return printed;
+}
+
+int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+{
+	struct rb_root *root;
+	struct rb_node *next, *first;
+	int err = 0;
+
+	down_write(&maps->lock);
+
+	root = &maps->entries;
+
+	/*
+	 * Find first map where end > map->start.
+	 * Same as find_vma() in kernel.
+	 */
+	next = root->rb_node;
+	first = NULL;
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node);
+
+		if (pos->end > map->start) {
+			first = next;
+			if (pos->start <= map->start)
+				break;
+			next = next->rb_left;
+		} else
+			next = next->rb_right;
+	}
+
+	next = first;
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node);
+		next = rb_next(&pos->rb_node);
+
+		/*
+		 * Stop if current map starts after map->end.
+		 * Maps are ordered by start: next will not overlap for sure.
+		 */
+		if (pos->start >= map->end)
+			break;
+
+		if (verbose >= 2) {
+
+			if (use_browser) {
+				pr_debug("overlapping maps in %s (disable tui for more info)\n",
+					   map->dso->name);
+			} else {
+				fputs("overlapping maps:\n", fp);
+				map__fprintf(map, fp);
+				map__fprintf(pos, fp);
+			}
+		}
+
+		rb_erase_init(&pos->rb_node, root);
+		/*
+		 * Now check if we need to create new maps for areas not
+		 * overlapped by the new map:
+		 */
+		if (map->start > pos->start) {
+			struct map *before = map__clone(pos);
+
+			if (before == NULL) {
+				err = -ENOMEM;
+				goto put_map;
+			}
+
+			before->end = map->start;
+			__maps__insert(maps, before);
+			if (verbose >= 2 && !use_browser)
+				map__fprintf(before, fp);
+			map__put(before);
+		}
+
+		if (map->end < pos->end) {
+			struct map *after = map__clone(pos);
+
+			if (after == NULL) {
+				err = -ENOMEM;
+				goto put_map;
+			}
+
+			after->start = map->end;
+			after->pgoff += map->end - pos->start;
+			assert(pos->map_ip(pos, map->end) == after->map_ip(after, map->end));
+			__maps__insert(maps, after);
+			if (verbose >= 2 && !use_browser)
+				map__fprintf(after, fp);
+			map__put(after);
+		}
+put_map:
+		map__put(pos);
+
+		if (err)
+			goto out;
+	}
+
+	err = 0;
+out:
+	up_write(&maps->lock);
+	return err;
+}
+
+/*
+ * XXX This should not really _copy_ te maps, but refcount them.
+ */
+int maps__clone(struct thread *thread, struct maps *parent)
+{
+	struct maps *maps = thread->maps;
+	int err;
+	struct map *map;
+
+	down_read(&parent->lock);
+
+	maps__for_each_entry(parent, map) {
+		struct map *new = map__clone(map);
+
+		if (new == NULL) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+
+		err = unwind__prepare_access(maps, new, NULL);
+		if (err)
+			goto out_unlock;
+
+		maps__insert(maps, new);
+		map__put(new);
+	}
+
+	err = 0;
+out_unlock:
+	up_read(&parent->lock);
+	return err;
+}
+
+static void __maps__insert(struct maps *maps, struct map *map)
+{
+	struct rb_node **p = &maps->entries.rb_node;
+	struct rb_node *parent = NULL;
+	const u64 ip = map->start;
+	struct map *m;
+
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map, rb_node);
+		if (ip < m->start)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&map->rb_node, parent, p);
+	rb_insert_color(&map->rb_node, &maps->entries);
+	map__get(map);
+}
+
+struct map *maps__find(struct maps *maps, u64 ip)
+{
+	struct rb_node *p;
+	struct map *m;
+
+	down_read(&maps->lock);
+
+	p = maps->entries.rb_node;
+	while (p != NULL) {
+		m = rb_entry(p, struct map, rb_node);
+		if (ip < m->start)
+			p = p->rb_left;
+		else if (ip >= m->end)
+			p = p->rb_right;
+		else
+			goto out;
+	}
+
+	m = NULL;
+out:
+	up_read(&maps->lock);
+	return m;
+}
+
+struct map *maps__first(struct maps *maps)
+{
+	struct rb_node *first = rb_first(&maps->entries);
+
+	if (first)
+		return rb_entry(first, struct map, rb_node);
+	return NULL;
+}
-- 
2.35.1.265.g69c8d7142f-goog

