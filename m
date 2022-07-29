Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9C58563C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiG2Umo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiG2Umh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:42:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9347AB2E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id bu13-20020a056902090d00b00671743601f1so4644815ybb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YcX9tkQzrH9sB4h317wbWcOBzKxSJ9/RZT2Esmrsk2w=;
        b=rGKh0tBvb66K/MHO9JbKheNCzpNytfayiKqVNvDx3kYgKhdcBHWRi8ShIS79ej38Jb
         3FfLKVZQXGA5swIimNbE6wzvZFjOcGl6uPD6FjKZtSyLxfSdA8DbOOUEkPpYVhdZJt8z
         Bm2MX2kMELW/WKa9oBA9dbj4lC+lMjr8ypevaNDwx8kWvnc0sNEq4Y+p5I8dUfc+iezk
         C+246zIo4nxkcBvFDC+FRtcLMDLcZIPiW+Qu99+P/aa19+XxR8nHG4U/G5qJk7qpyU5M
         eT/VedXuvquptNnaNqmY32ueAQEmGrxLsg6odfJ3JKG1+lNpAors3hW768l8YGKua0Ke
         L4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YcX9tkQzrH9sB4h317wbWcOBzKxSJ9/RZT2Esmrsk2w=;
        b=1SNvxc1qPoOCtD28eo9P7qoCGFPNSFGvTdvh/tXTLzCpVh69j8QqY8vTRLkTEIyTCl
         dxu1du9fKhwFVuVpHHgWUP7sv2435DjEjaHZ16YRT0B7FSBPkNKFm8k/0TZYahH7Lnh4
         XySwYv1ah+RqLOPGMSNUrjxzjZd2WIZqMSx7o5h5S0IVf4spNvnfZTHv+7Z4/TvGJG00
         j/YExew7Y+6o3gwvQLDjSmQRN1bsI2FGEF6FP2pod/6OjskAEZtjwMts4TwYPjsS74Uy
         GMCPiTnbSFWapi8O1kmQVVWHYv6FqhablLvLARgJfHPt9kOM6PdJCAzMgpOFMJ+ZnC/X
         Miyw==
X-Gm-Message-State: ACgBeo3Uvj/1Dkm2/LHV6uuuXSIho7uzMmO7RroIqB/qjyfavmoq3kZE
        GZHKmKiVKqon4GH3feM1b6JCk0+5hTXe
X-Google-Smtp-Source: AA6agR5yj+QG4RKCrINMLJITJgub24eOdC326XP0ZKC358Q1rkuthvstRBs4buwZDcxd66eJdmd4tG1Kf0B2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr4758042ywb.218.1659127353487; Fri, 29
 Jul 2022 13:42:33 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:42:17 -0700
In-Reply-To: <20220729204217.250166-1-irogers@google.com>
Message-Id: <20220729204217.250166-3-irogers@google.com>
Mime-Version: 1.0
References: <20220729204217.250166-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 2/2] perf parse-events: Break out tracepoint and printing.
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move print_*_events functions out of parse-events.c into a new
print-events.c. Move tracepoint code into tracepoint.c or
trace-event-info.c (sole user). This reduces the dependencies of
parse-events.c and makes it more amenable to being a library in the
future.
Remove some unnecessary definitions from parse-events.h. Fix a
checkpatch.pl warning on using unsigned rather than unsigned int.
Fix some line length warnings too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c          |   2 +-
 tools/perf/builtin-lock.c          |   1 +
 tools/perf/builtin-timechart.c     |   1 +
 tools/perf/builtin-trace.c         |   1 +
 tools/perf/util/Build              |   2 +
 tools/perf/util/parse-events.c     | 713 +----------------------------
 tools/perf/util/parse-events.h     |  31 --
 tools/perf/util/print-events.c     | 571 +++++++++++++++++++++++
 tools/perf/util/print-events.h     |  22 +
 tools/perf/util/trace-event-info.c |  96 ++++
 tools/perf/util/tracepoint.c       |  63 +++
 tools/perf/util/tracepoint.h       |  25 +
 12 files changed, 790 insertions(+), 738 deletions(-)
 create mode 100644 tools/perf/util/print-events.c
 create mode 100644 tools/perf/util/print-events.h
 create mode 100644 tools/perf/util/tracepoint.c
 create mode 100644 tools/perf/util/tracepoint.h

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 468958154ed9..744dd3520584 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -10,7 +10,7 @@
  */
 #include "builtin.h"
 
-#include "util/parse-events.h"
+#include "util/print-events.h"
 #include "util/pmu.h"
 #include "util/pmu-hybrid.h"
 #include "util/debug.h"
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 041801d8b6ac..fcd5c009afec 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -14,6 +14,7 @@
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
+#include "util/tracepoint.h"
 
 #include "util/debug.h"
 #include "util/session.h"
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index afce731cec16..e2e9ad929baf 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -36,6 +36,7 @@
 #include "util/data.h"
 #include "util/debug.h"
 #include "util/string2.h"
+#include "util/tracepoint.h"
 #include <linux/err.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f075cf37a65e..1e1f10a1971d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -53,6 +53,7 @@
 #include "trace-event.h"
 #include "util/parse-events.h"
 #include "util/bpf-loader.h"
+#include "util/tracepoint.h"
 #include "callchain.h"
 #include "print_binary.h"
 #include "string2.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 66ad30cf65ec..6d0f7e29c42b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,6 +26,8 @@ perf-y += mmap.o
 perf-y += memswap.o
 perf-y += parse-events.o
 perf-y += parse-events-hybrid.o
+perf-y += print-events.o
+perf-y += tracepoint.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8012db830814..206c76623c06 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -5,18 +5,12 @@
 #include <dirent.h>
 #include <errno.h>
 #include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 #include <sys/param.h>
 #include "term.h"
-#include "build-id.h"
 #include "evlist.h"
 #include "evsel.h"
-#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "parse-events.h"
-#include <subcmd/exec-cmd.h>
 #include "string2.h"
 #include "strlist.h"
 #include "bpf-loader.h"
@@ -26,20 +20,22 @@
 #include "parse-events-bison.h"
 #include "parse-events-flex.h"
 #include "pmu.h"
-#include "thread_map.h"
-#include "probe-file.h"
 #include "asm/bug.h"
 #include "util/parse-branch-options.h"
-#include "metricgroup.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
-#include "util/pfm.h"
+#include "perf.h"
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
-#include "perf.h"
+#include "tracepoint.h"
 
 #define MAX_NAME_LEN 100
 
+struct perf_pmu_event_symbol {
+	char	*symbol;
+	enum perf_pmu_event_symbol_type	type;
+};
+
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
@@ -153,21 +149,6 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
-	[PERF_TOOL_DURATION_TIME] = {
-		.symbol = "duration_time",
-		.alias  = "",
-	},
-	[PERF_TOOL_USER_TIME] = {
-		.symbol = "user_time",
-		.alias  = "",
-	},
-	[PERF_TOOL_SYSTEM_TIME] = {
-		.symbol = "system_time",
-		.alias  = "",
-	},
-};
-
 #define __PERF_EVENT_FIELD(config, name) \
 	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
 
@@ -176,121 +157,6 @@ struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
 #define PERF_EVENT_TYPE(config)		__PERF_EVENT_FIELD(config, TYPE)
 #define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
 
-#define for_each_subsystem(sys_dir, sys_dirent)			\
-	while ((sys_dirent = readdir(sys_dir)) != NULL)		\
-		if (sys_dirent->d_type == DT_DIR &&		\
-		    (strcmp(sys_dirent->d_name, ".")) &&	\
-		    (strcmp(sys_dirent->d_name, "..")))
-
-static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
-{
-	char evt_path[MAXPATHLEN];
-	int fd;
-
-	snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path, evt_dir->d_name);
-	fd = open(evt_path, O_RDONLY);
-	if (fd < 0)
-		return -EINVAL;
-	close(fd);
-
-	return 0;
-}
-
-#define for_each_event(dir_path, evt_dir, evt_dirent)		\
-	while ((evt_dirent = readdir(evt_dir)) != NULL)		\
-		if (evt_dirent->d_type == DT_DIR &&		\
-		    (strcmp(evt_dirent->d_name, ".")) &&	\
-		    (strcmp(evt_dirent->d_name, "..")) &&	\
-		    (!tp_event_has_id(dir_path, evt_dirent)))
-
-#define MAX_EVENT_LENGTH 512
-
-struct tracepoint_path *tracepoint_id_to_path(u64 config)
-{
-	struct tracepoint_path *path = NULL;
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char id_buf[24];
-	int fd;
-	u64 id;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return NULL;
-
-	for_each_subsystem(sys_dir, sys_dirent) {
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
-			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
-
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-
-			scnprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
-				  evt_dirent->d_name);
-			fd = open(evt_path, O_RDONLY);
-			if (fd < 0)
-				continue;
-			if (read(fd, id_buf, sizeof(id_buf)) < 0) {
-				close(fd);
-				continue;
-			}
-			close(fd);
-			id = atoll(id_buf);
-			if (id == config) {
-				put_events_file(dir_path);
-				closedir(evt_dir);
-				closedir(sys_dir);
-				path = zalloc(sizeof(*path));
-				if (!path)
-					return NULL;
-				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
-					free(path);
-					return NULL;
-				}
-				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
-					zfree(&path->system);
-					free(path);
-					return NULL;
-				}
-				return path;
-			}
-		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
-	}
-
-	closedir(sys_dir);
-	return NULL;
-}
-
-struct tracepoint_path *tracepoint_name_to_path(const char *name)
-{
-	struct tracepoint_path *path = zalloc(sizeof(*path));
-	char *str = strchr(name, ':');
-
-	if (path == NULL || str == NULL) {
-		free(path);
-		return NULL;
-	}
-
-	path->system = strndup(name, str - name);
-	path->name = strdup(str+1);
-
-	if (path->system == NULL || path->name == NULL) {
-		zfree(&path->system);
-		zfree(&path->name);
-		zfree(&path);
-	}
-
-	return path;
-}
-
 const char *event_type(int type)
 {
 	switch (type) {
@@ -2665,571 +2531,6 @@ int exclude_perf(const struct option *opt,
 					  NULL);
 }
 
-static const char * const event_type_descriptors[] = {
-	"Hardware event",
-	"Software event",
-	"Tracepoint event",
-	"Hardware cache event",
-	"Raw hardware event descriptor",
-	"Hardware breakpoint",
-};
-
-static int cmp_string(const void *a, const void *b)
-{
-	const char * const *as = a;
-	const char * const *bs = b;
-
-	return strcmp(*as, *bs);
-}
-
-/*
- * Print the events from <debugfs_mount_point>/tracing/events
- */
-
-void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
-			     bool name_only)
-{
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-	char **evt_list = NULL;
-	unsigned int evt_i = 0, evt_num = 0;
-	bool evt_num_known = false;
-
-restart:
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return;
-
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_close_sys_dir;
-	}
-
-	for_each_subsystem(sys_dir, sys_dirent) {
-		if (subsys_glob != NULL &&
-		    !strglobmatch(sys_dirent->d_name, subsys_glob))
-			continue;
-
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
-			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
-
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			if (event_glob != NULL &&
-			    !strglobmatch(evt_dirent->d_name, event_glob))
-				continue;
-
-			if (!evt_num_known) {
-				evt_num++;
-				continue;
-			}
-
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-
-			evt_list[evt_i] = strdup(evt_path);
-			if (evt_list[evt_i] == NULL) {
-				put_events_file(dir_path);
-				goto out_close_evt_dir;
-			}
-			evt_i++;
-		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
-	}
-	closedir(sys_dir);
-
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
-		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
-			continue;
-		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++],
-				event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	}
-	if (evt_num && pager_in_use())
-		printf("\n");
-
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-	return;
-
-out_close_evt_dir:
-	closedir(evt_dir);
-out_close_sys_dir:
-	closedir(sys_dir);
-
-	printf("FATAL: not enough memory to print %s\n",
-			event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	if (evt_list)
-		goto out_free;
-}
-
-/*
- * Check whether event is in <debugfs_mount_point>/tracing/events
- */
-
-int is_valid_tracepoint(const char *event_string)
-{
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return 0;
-
-	for_each_subsystem(sys_dir, sys_dirent) {
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
-			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
-
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-			if (!strcmp(evt_path, event_string)) {
-				closedir(evt_dir);
-				closedir(sys_dir);
-				return 1;
-			}
-		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
-	}
-	closedir(sys_dir);
-	return 0;
-}
-
-static bool is_event_supported(u8 type, u64 config)
-{
-	bool ret = true;
-	int open_return;
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = type,
-		.config = config,
-		.disabled = 1,
-	};
-	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
-
-	if (tmap == NULL)
-		return false;
-
-	evsel = evsel__new(&attr);
-	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
-
-		if (open_return == -EACCES) {
-			/*
-			 * This happens if the paranoid value
-			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
-			 */
-			evsel->core.attr.exclude_kernel = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-		evsel__delete(evsel);
-	}
-
-	perf_thread_map__put(tmap);
-	return ret;
-}
-
-void print_sdt_events(const char *subsys_glob, const char *event_glob,
-		      bool name_only)
-{
-	struct probe_cache *pcache;
-	struct probe_cache_entry *ent;
-	struct strlist *bidlist, *sdtlist;
-	struct strlist_config cfg = {.dont_dupstr = true};
-	struct str_node *nd, *nd2;
-	char *buf, *path, *ptr = NULL;
-	bool show_detail = false;
-	int ret;
-
-	sdtlist = strlist__new(NULL, &cfg);
-	if (!sdtlist) {
-		pr_debug("Failed to allocate new strlist for SDT\n");
-		return;
-	}
-	bidlist = build_id_cache__list_all(true);
-	if (!bidlist) {
-		pr_debug("Failed to get buildids: %d\n", errno);
-		return;
-	}
-	strlist__for_each_entry(nd, bidlist) {
-		pcache = probe_cache__new(nd->s, NULL);
-		if (!pcache)
-			continue;
-		list_for_each_entry(ent, &pcache->entries, node) {
-			if (!ent->sdt)
-				continue;
-			if (subsys_glob &&
-			    !strglobmatch(ent->pev.group, subsys_glob))
-				continue;
-			if (event_glob &&
-			    !strglobmatch(ent->pev.event, event_glob))
-				continue;
-			ret = asprintf(&buf, "%s:%s@%s", ent->pev.group,
-					ent->pev.event, nd->s);
-			if (ret > 0)
-				strlist__add(sdtlist, buf);
-		}
-		probe_cache__delete(pcache);
-	}
-	strlist__delete(bidlist);
-
-	strlist__for_each_entry(nd, sdtlist) {
-		buf = strchr(nd->s, '@');
-		if (buf)
-			*(buf++) = '\0';
-		if (name_only) {
-			printf("%s ", nd->s);
-			continue;
-		}
-		nd2 = strlist__next(nd);
-		if (nd2) {
-			ptr = strchr(nd2->s, '@');
-			if (ptr)
-				*ptr = '\0';
-			if (strcmp(nd->s, nd2->s) == 0)
-				show_detail = true;
-		}
-		if (show_detail) {
-			path = build_id_cache__origname(buf);
-			ret = asprintf(&buf, "%s@%s(%.12s)", nd->s, path, buf);
-			if (ret > 0) {
-				printf("  %-50s [%s]\n", buf, "SDT event");
-				free(buf);
-			}
-			free(path);
-		} else
-			printf("  %-50s [%s]\n", nd->s, "SDT event");
-		if (nd2) {
-			if (strcmp(nd->s, nd2->s) != 0)
-				show_detail = false;
-			if (ptr)
-				*ptr = '@';
-		}
-	}
-	strlist__delete(sdtlist);
-}
-
-int print_hwcache_events(const char *event_glob, bool name_only)
-{
-	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
-	char name[64], new_name[128];
-	char **evt_list = NULL, **evt_pmus = NULL;
-	bool evt_num_known = false;
-	struct perf_pmu *pmu = NULL;
-
-	if (perf_pmu__has_hybrid()) {
-		npmus = perf_pmu__hybrid_pmu_num();
-		evt_pmus = zalloc(sizeof(char *) * npmus);
-		if (!evt_pmus)
-			goto out_enomem;
-	}
-
-restart:
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_enomem;
-	}
-
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-			/* skip invalid cache type */
-			if (!evsel__is_cache_op_valid(type, op))
-				continue;
-
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				unsigned int hybrid_supported = 0, j;
-				bool supported;
-
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				if (event_glob != NULL && !strglobmatch(name, event_glob))
-					continue;
-
-				if (!perf_pmu__has_hybrid()) {
-					if (!is_event_supported(PERF_TYPE_HW_CACHE,
-								type | (op << 8) | (i << 16))) {
-						continue;
-					}
-				} else {
-					perf_pmu__for_each_hybrid_pmu(pmu) {
-						if (!evt_num_known) {
-							evt_num++;
-							continue;
-						}
-
-						supported = is_event_supported(
-									PERF_TYPE_HW_CACHE,
-									type | (op << 8) | (i << 16) |
-									((__u64)pmu->type << PERF_PMU_TYPE_SHIFT));
-						if (supported) {
-							snprintf(new_name, sizeof(new_name), "%s/%s/",
-								 pmu->name, name);
-							evt_pmus[hybrid_supported] = strdup(new_name);
-							hybrid_supported++;
-						}
-					}
-
-					if (hybrid_supported == 0)
-						continue;
-				}
-
-				if (!evt_num_known) {
-					evt_num++;
-					continue;
-				}
-
-				if ((hybrid_supported == 0) ||
-				    (hybrid_supported == npmus)) {
-					evt_list[evt_i] = strdup(name);
-					if (npmus > 0) {
-						for (j = 0; j < npmus; j++)
-							zfree(&evt_pmus[j]);
-					}
-				} else {
-					for (j = 0; j < hybrid_supported; j++) {
-						evt_list[evt_i++] = evt_pmus[j];
-						evt_pmus[j] = NULL;
-					}
-					continue;
-				}
-
-				if (evt_list[evt_i] == NULL)
-					goto out_enomem;
-				evt_i++;
-			}
-		}
-	}
-
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-
-	for (evt_i = 0; evt_i < evt_num; evt_i++) {
-		if (!evt_list[evt_i])
-			break;
-	}
-
-	evt_num = evt_i;
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
-		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
-			continue;
-		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++],
-				event_type_descriptors[PERF_TYPE_HW_CACHE]);
-	}
-	if (evt_num && pager_in_use())
-		printf("\n");
-
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-
-	for (evt_i = 0; evt_i < npmus; evt_i++)
-		zfree(&evt_pmus[evt_i]);
-	zfree(&evt_pmus);
-	return evt_num;
-
-out_enomem:
-	printf("FATAL: not enough memory to print %s\n", event_type_descriptors[PERF_TYPE_HW_CACHE]);
-	if (evt_list)
-		goto out_free;
-	return evt_num;
-}
-
-static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
-			     bool name_only)
-{
-	if (syms->symbol == NULL)
-		return;
-
-	if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
-	      (syms->alias && strglobmatch(syms->alias, event_glob))))
-		return;
-
-	if (name_only)
-		printf("%s ", syms->symbol);
-	else {
-		char name[MAX_NAME_LEN];
-		if (syms->alias && strlen(syms->alias))
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
-		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
-		printf("  %-50s [%s]\n", name, "Tool event");
-	}
-}
-
-void print_tool_events(const char *event_glob, bool name_only)
-{
-	// Start at 1 because the first enum entry symbols no tool event
-	for (int i = 1; i < PERF_TOOL_MAX; ++i) {
-		print_tool_event(event_symbols_tool + i, event_glob, name_only);
-	}
-	if (pager_in_use())
-		printf("\n");
-}
-
-void print_symbol_events(const char *event_glob, unsigned type,
-				struct event_symbol *syms, unsigned max,
-				bool name_only)
-{
-	unsigned int i, evt_i = 0, evt_num = 0;
-	char name[MAX_NAME_LEN];
-	char **evt_list = NULL;
-	bool evt_num_known = false;
-
-restart:
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_enomem;
-		syms -= max;
-	}
-
-	for (i = 0; i < max; i++, syms++) {
-		/*
-		 * New attr.config still not supported here, the latest
-		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
-		 */
-		if (syms->symbol == NULL)
-			continue;
-
-		if (event_glob != NULL && !(strglobmatch(syms->symbol, event_glob) ||
-		      (syms->alias && strglobmatch(syms->alias, event_glob))))
-			continue;
-
-		if (!is_event_supported(type, i))
-			continue;
-
-		if (!evt_num_known) {
-			evt_num++;
-			continue;
-		}
-
-		if (!name_only && strlen(syms->alias))
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
-		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
-
-		evt_list[evt_i] = strdup(name);
-		if (evt_list[evt_i] == NULL)
-			goto out_enomem;
-		evt_i++;
-	}
-
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
-		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
-			continue;
-		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++], event_type_descriptors[type]);
-	}
-	if (evt_num && pager_in_use())
-		printf("\n");
-
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-	return;
-
-out_enomem:
-	printf("FATAL: not enough memory to print %s\n", event_type_descriptors[type]);
-	if (evt_list)
-		goto out_free;
-}
-
-/*
- * Print the help text for the event symbols:
- */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated,
-			const char *pmu_name)
-{
-	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
-			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
-
-	print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
-			    event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
-	print_tool_events(event_glob, name_only);
-
-	print_hwcache_events(event_glob, name_only);
-
-	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
-			details_flag, deprecated, pmu_name);
-
-	if (event_glob != NULL)
-		return;
-
-	if (!name_only) {
-		printf("  %-50s [%s]\n",
-		       "rNNN",
-		       event_type_descriptors[PERF_TYPE_RAW]);
-		printf("  %-50s [%s]\n",
-		       "cpu/t1=v1[,t2=v2,t3 ...]/modifier",
-		       event_type_descriptors[PERF_TYPE_RAW]);
-		if (pager_in_use())
-			printf("   (see 'man perf-list' on how to encode it)\n\n");
-
-		printf("  %-50s [%s]\n",
-		       "mem:<addr>[/len][:access]",
-			event_type_descriptors[PERF_TYPE_BREAKPOINT]);
-		if (pager_in_use())
-			printf("\n");
-	}
-
-	print_tracepoint_events(NULL, NULL, name_only);
-
-	print_sdt_events(NULL, NULL, name_only);
-
-	metricgroup__print(true, true, NULL, name_only, details_flag,
-			   pmu_name);
-
-	print_libpfm_events(name_only, long_desc);
-}
-
 int parse_events__is_hardcoded_term(struct parse_events_term *term)
 {
 	return term->type_term != PARSE_EVENTS__TERM_TYPE_USER;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a38b8b160e80..ba9fa3ddaf6e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -11,7 +11,6 @@
 #include <linux/perf_event.h>
 #include <string.h>
 
-struct list_head;
 struct evsel;
 struct evlist;
 struct parse_events_error;
@@ -19,14 +18,6 @@ struct parse_events_error;
 struct option;
 struct perf_pmu;
 
-struct tracepoint_path {
-	char *system;
-	char *name;
-	struct tracepoint_path *next;
-};
-
-struct tracepoint_path *tracepoint_id_to_path(u64 config);
-struct tracepoint_path *tracepoint_name_to_path(const char *name);
 bool have_tracepoints(struct list_head *evlist);
 
 const char *event_type(int type);
@@ -46,8 +37,6 @@ int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
-#define EVENTS_HELP_MAX (128*1024)
-
 enum perf_pmu_event_symbol_type {
 	PMU_EVENT_SYMBOL_ERR,		/* not a PMU EVENT */
 	PMU_EVENT_SYMBOL,		/* normal style PMU event */
@@ -56,11 +45,6 @@ enum perf_pmu_event_symbol_type {
 	PMU_EVENT_SYMBOL_SUFFIX2,	/* suffix of pre-suf2 style event */
 };
 
-struct perf_pmu_event_symbol {
-	char	*symbol;
-	enum perf_pmu_event_symbol_type	type;
-};
-
 enum {
 	PARSE_EVENTS__TERM_TYPE_NUM,
 	PARSE_EVENTS__TERM_TYPE_STR,
@@ -219,28 +203,13 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only, bool quiet,
-		  bool long_desc, bool details_flag, bool deprecated,
-		  const char *pmu_name);
-
 struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
 extern struct event_symbol event_symbols_hw[];
 extern struct event_symbol event_symbols_sw[];
-void print_symbol_events(const char *event_glob, unsigned type,
-				struct event_symbol *syms, unsigned max,
-				bool name_only);
-void print_tool_events(const char *event_glob, bool name_only);
-void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
-			     bool name_only);
-int print_hwcache_events(const char *event_glob, bool name_only);
-void print_sdt_events(const char *subsys_glob, const char *event_glob,
-		      bool name_only);
-int is_valid_tracepoint(const char *event_string);
 
-int valid_event_mount(const char *eventfs);
 char *parse_events_formats_error_string(char *additional_terms);
 
 void parse_events_error__init(struct parse_events_error *err);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
new file mode 100644
index 000000000000..3b071e57b4a0
--- /dev/null
+++ b/tools/perf/util/print-events.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dirent.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/param.h>
+
+#include <api/fs/tracing_path.h>
+#include <linux/perf_event.h>
+#include <linux/zalloc.h>
+#include <subcmd/pager.h>
+
+#include "build-id.h"
+#include "debug.h"
+#include "evsel.h"
+#include "metricgroup.h"
+#include "parse-events.h"
+#include "pmu.h"
+#include "print-events.h"
+#include "probe-file.h"
+#include "string2.h"
+#include "strlist.h"
+#include "thread_map.h"
+#include "tracepoint.h"
+#include "pfm.h"
+#include "pmu-hybrid.h"
+
+#define MAX_NAME_LEN 100
+
+static const char * const event_type_descriptors[] = {
+	"Hardware event",
+	"Software event",
+	"Tracepoint event",
+	"Hardware cache event",
+	"Raw hardware event descriptor",
+	"Hardware breakpoint",
+};
+
+static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
+	[PERF_TOOL_DURATION_TIME] = {
+		.symbol = "duration_time",
+		.alias  = "",
+	},
+	[PERF_TOOL_USER_TIME] = {
+		.symbol = "user_time",
+		.alias  = "",
+	},
+	[PERF_TOOL_SYSTEM_TIME] = {
+		.symbol = "system_time",
+		.alias  = "",
+	},
+};
+
+static int cmp_string(const void *a, const void *b)
+{
+	const char * const *as = a;
+	const char * const *bs = b;
+
+	return strcmp(*as, *bs);
+}
+
+/*
+ * Print the events from <debugfs_mount_point>/tracing/events
+ */
+void print_tracepoint_events(const char *subsys_glob,
+			     const char *event_glob, bool name_only)
+{
+	DIR *sys_dir, *evt_dir;
+	struct dirent *sys_dirent, *evt_dirent;
+	char evt_path[MAXPATHLEN];
+	char *dir_path;
+	char **evt_list = NULL;
+	unsigned int evt_i = 0, evt_num = 0;
+	bool evt_num_known = false;
+
+restart:
+	sys_dir = tracing_events__opendir();
+	if (!sys_dir)
+		return;
+
+	if (evt_num_known) {
+		evt_list = zalloc(sizeof(char *) * evt_num);
+		if (!evt_list)
+			goto out_close_sys_dir;
+	}
+
+	for_each_subsystem(sys_dir, sys_dirent) {
+		if (subsys_glob != NULL &&
+		    !strglobmatch(sys_dirent->d_name, subsys_glob))
+			continue;
+
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
+		evt_dir = opendir(dir_path);
+		if (!evt_dir)
+			goto next;
+
+		for_each_event(dir_path, evt_dir, evt_dirent) {
+			if (event_glob != NULL &&
+			    !strglobmatch(evt_dirent->d_name, event_glob))
+				continue;
+
+			if (!evt_num_known) {
+				evt_num++;
+				continue;
+			}
+
+			snprintf(evt_path, MAXPATHLEN, "%s:%s",
+				 sys_dirent->d_name, evt_dirent->d_name);
+
+			evt_list[evt_i] = strdup(evt_path);
+			if (evt_list[evt_i] == NULL) {
+				put_events_file(dir_path);
+				goto out_close_evt_dir;
+			}
+			evt_i++;
+		}
+		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
+	}
+	closedir(sys_dir);
+
+	if (!evt_num_known) {
+		evt_num_known = true;
+		goto restart;
+	}
+	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
+	evt_i = 0;
+	while (evt_i < evt_num) {
+		if (name_only) {
+			printf("%s ", evt_list[evt_i++]);
+			continue;
+		}
+		printf("  %-50s [%s]\n", evt_list[evt_i++],
+				event_type_descriptors[PERF_TYPE_TRACEPOINT]);
+	}
+	if (evt_num && pager_in_use())
+		printf("\n");
+
+out_free:
+	evt_num = evt_i;
+	for (evt_i = 0; evt_i < evt_num; evt_i++)
+		zfree(&evt_list[evt_i]);
+	zfree(&evt_list);
+	return;
+
+out_close_evt_dir:
+	closedir(evt_dir);
+out_close_sys_dir:
+	closedir(sys_dir);
+
+	printf("FATAL: not enough memory to print %s\n",
+			event_type_descriptors[PERF_TYPE_TRACEPOINT]);
+	if (evt_list)
+		goto out_free;
+}
+
+void print_sdt_events(const char *subsys_glob, const char *event_glob,
+		      bool name_only)
+{
+	struct probe_cache *pcache;
+	struct probe_cache_entry *ent;
+	struct strlist *bidlist, *sdtlist;
+	struct strlist_config cfg = {.dont_dupstr = true};
+	struct str_node *nd, *nd2;
+	char *buf, *path, *ptr = NULL;
+	bool show_detail = false;
+	int ret;
+
+	sdtlist = strlist__new(NULL, &cfg);
+	if (!sdtlist) {
+		pr_debug("Failed to allocate new strlist for SDT\n");
+		return;
+	}
+	bidlist = build_id_cache__list_all(true);
+	if (!bidlist) {
+		pr_debug("Failed to get buildids: %d\n", errno);
+		return;
+	}
+	strlist__for_each_entry(nd, bidlist) {
+		pcache = probe_cache__new(nd->s, NULL);
+		if (!pcache)
+			continue;
+		list_for_each_entry(ent, &pcache->entries, node) {
+			if (!ent->sdt)
+				continue;
+			if (subsys_glob &&
+			    !strglobmatch(ent->pev.group, subsys_glob))
+				continue;
+			if (event_glob &&
+			    !strglobmatch(ent->pev.event, event_glob))
+				continue;
+			ret = asprintf(&buf, "%s:%s@%s", ent->pev.group,
+					ent->pev.event, nd->s);
+			if (ret > 0)
+				strlist__add(sdtlist, buf);
+		}
+		probe_cache__delete(pcache);
+	}
+	strlist__delete(bidlist);
+
+	strlist__for_each_entry(nd, sdtlist) {
+		buf = strchr(nd->s, '@');
+		if (buf)
+			*(buf++) = '\0';
+		if (name_only) {
+			printf("%s ", nd->s);
+			continue;
+		}
+		nd2 = strlist__next(nd);
+		if (nd2) {
+			ptr = strchr(nd2->s, '@');
+			if (ptr)
+				*ptr = '\0';
+			if (strcmp(nd->s, nd2->s) == 0)
+				show_detail = true;
+		}
+		if (show_detail) {
+			path = build_id_cache__origname(buf);
+			ret = asprintf(&buf, "%s@%s(%.12s)", nd->s, path, buf);
+			if (ret > 0) {
+				printf("  %-50s [%s]\n", buf, "SDT event");
+				free(buf);
+			}
+			free(path);
+		} else
+			printf("  %-50s [%s]\n", nd->s, "SDT event");
+		if (nd2) {
+			if (strcmp(nd->s, nd2->s) != 0)
+				show_detail = false;
+			if (ptr)
+				*ptr = '@';
+		}
+	}
+	strlist__delete(sdtlist);
+}
+
+static bool is_event_supported(u8 type, unsigned int config)
+{
+	bool ret = true;
+	int open_return;
+	struct evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.disabled = 1,
+	};
+	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
+
+	if (tmap == NULL)
+		return false;
+
+	evsel = evsel__new(&attr);
+	if (evsel) {
+		open_return = evsel__open(evsel, NULL, tmap);
+		ret = open_return >= 0;
+
+		if (open_return == -EACCES) {
+			/*
+			 * This happens if the paranoid value
+			 * /proc/sys/kernel/perf_event_paranoid is set to 2
+			 * Re-run with exclude_kernel set; we don't do that
+			 * by default as some ARM machines do not support it.
+			 *
+			 */
+			evsel->core.attr.exclude_kernel = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+		evsel__delete(evsel);
+	}
+
+	perf_thread_map__put(tmap);
+	return ret;
+}
+
+int print_hwcache_events(const char *event_glob, bool name_only)
+{
+	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
+	char name[64], new_name[128];
+	char **evt_list = NULL, **evt_pmus = NULL;
+	bool evt_num_known = false;
+	struct perf_pmu *pmu = NULL;
+
+	if (perf_pmu__has_hybrid()) {
+		npmus = perf_pmu__hybrid_pmu_num();
+		evt_pmus = zalloc(sizeof(char *) * npmus);
+		if (!evt_pmus)
+			goto out_enomem;
+	}
+
+restart:
+	if (evt_num_known) {
+		evt_list = zalloc(sizeof(char *) * evt_num);
+		if (!evt_list)
+			goto out_enomem;
+	}
+
+	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
+		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
+			/* skip invalid cache type */
+			if (!evsel__is_cache_op_valid(type, op))
+				continue;
+
+			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
+				unsigned int hybrid_supported = 0, j;
+				bool supported;
+
+				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
+				if (event_glob != NULL && !strglobmatch(name, event_glob))
+					continue;
+
+				if (!perf_pmu__has_hybrid()) {
+					if (!is_event_supported(PERF_TYPE_HW_CACHE,
+								type | (op << 8) | (i << 16))) {
+						continue;
+					}
+				} else {
+					perf_pmu__for_each_hybrid_pmu(pmu) {
+						if (!evt_num_known) {
+							evt_num++;
+							continue;
+						}
+
+						supported = is_event_supported(
+							PERF_TYPE_HW_CACHE,
+							type | (op << 8) | (i << 16) |
+							((__u64)pmu->type << PERF_PMU_TYPE_SHIFT));
+						if (supported) {
+							snprintf(new_name, sizeof(new_name),
+								 "%s/%s/", pmu->name, name);
+							evt_pmus[hybrid_supported] =
+								strdup(new_name);
+							hybrid_supported++;
+						}
+					}
+
+					if (hybrid_supported == 0)
+						continue;
+				}
+
+				if (!evt_num_known) {
+					evt_num++;
+					continue;
+				}
+
+				if ((hybrid_supported == 0) ||
+				    (hybrid_supported == npmus)) {
+					evt_list[evt_i] = strdup(name);
+					if (npmus > 0) {
+						for (j = 0; j < npmus; j++)
+							zfree(&evt_pmus[j]);
+					}
+				} else {
+					for (j = 0; j < hybrid_supported; j++) {
+						evt_list[evt_i++] = evt_pmus[j];
+						evt_pmus[j] = NULL;
+					}
+					continue;
+				}
+
+				if (evt_list[evt_i] == NULL)
+					goto out_enomem;
+				evt_i++;
+			}
+		}
+	}
+
+	if (!evt_num_known) {
+		evt_num_known = true;
+		goto restart;
+	}
+
+	for (evt_i = 0; evt_i < evt_num; evt_i++) {
+		if (!evt_list[evt_i])
+			break;
+	}
+
+	evt_num = evt_i;
+	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
+	evt_i = 0;
+	while (evt_i < evt_num) {
+		if (name_only) {
+			printf("%s ", evt_list[evt_i++]);
+			continue;
+		}
+		printf("  %-50s [%s]\n", evt_list[evt_i++],
+				event_type_descriptors[PERF_TYPE_HW_CACHE]);
+	}
+	if (evt_num && pager_in_use())
+		printf("\n");
+
+out_free:
+	evt_num = evt_i;
+	for (evt_i = 0; evt_i < evt_num; evt_i++)
+		zfree(&evt_list[evt_i]);
+	zfree(&evt_list);
+
+	for (evt_i = 0; evt_i < npmus; evt_i++)
+		zfree(&evt_pmus[evt_i]);
+	zfree(&evt_pmus);
+	return evt_num;
+
+out_enomem:
+	printf("FATAL: not enough memory to print %s\n",
+		event_type_descriptors[PERF_TYPE_HW_CACHE]);
+	if (evt_list)
+		goto out_free;
+	return evt_num;
+}
+
+static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
+			     bool name_only)
+{
+	if (syms->symbol == NULL)
+		return;
+
+	if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
+	      (syms->alias && strglobmatch(syms->alias, event_glob))))
+		return;
+
+	if (name_only)
+		printf("%s ", syms->symbol);
+	else {
+		char name[MAX_NAME_LEN];
+
+		if (syms->alias && strlen(syms->alias))
+			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
+		else
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
+		printf("  %-50s [%s]\n", name, "Tool event");
+	}
+}
+
+void print_tool_events(const char *event_glob, bool name_only)
+{
+	// Start at 1 because the first enum entry means no tool event.
+	for (int i = 1; i < PERF_TOOL_MAX; ++i)
+		print_tool_event(event_symbols_tool + i, event_glob, name_only);
+
+	if (pager_in_use())
+		printf("\n");
+}
+
+void print_symbol_events(const char *event_glob, unsigned int type,
+			 struct event_symbol *syms, unsigned int max,
+			 bool name_only)
+{
+	unsigned int i, evt_i = 0, evt_num = 0;
+	char name[MAX_NAME_LEN];
+	char **evt_list = NULL;
+	bool evt_num_known = false;
+
+restart:
+	if (evt_num_known) {
+		evt_list = zalloc(sizeof(char *) * evt_num);
+		if (!evt_list)
+			goto out_enomem;
+		syms -= max;
+	}
+
+	for (i = 0; i < max; i++, syms++) {
+		/*
+		 * New attr.config still not supported here, the latest
+		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
+		 */
+		if (syms->symbol == NULL)
+			continue;
+
+		if (event_glob != NULL && !(strglobmatch(syms->symbol, event_glob) ||
+		      (syms->alias && strglobmatch(syms->alias, event_glob))))
+			continue;
+
+		if (!is_event_supported(type, i))
+			continue;
+
+		if (!evt_num_known) {
+			evt_num++;
+			continue;
+		}
+
+		if (!name_only && strlen(syms->alias))
+			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
+		else
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
+
+		evt_list[evt_i] = strdup(name);
+		if (evt_list[evt_i] == NULL)
+			goto out_enomem;
+		evt_i++;
+	}
+
+	if (!evt_num_known) {
+		evt_num_known = true;
+		goto restart;
+	}
+	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
+	evt_i = 0;
+	while (evt_i < evt_num) {
+		if (name_only) {
+			printf("%s ", evt_list[evt_i++]);
+			continue;
+		}
+		printf("  %-50s [%s]\n", evt_list[evt_i++], event_type_descriptors[type]);
+	}
+	if (evt_num && pager_in_use())
+		printf("\n");
+
+out_free:
+	evt_num = evt_i;
+	for (evt_i = 0; evt_i < evt_num; evt_i++)
+		zfree(&evt_list[evt_i]);
+	zfree(&evt_list);
+	return;
+
+out_enomem:
+	printf("FATAL: not enough memory to print %s\n", event_type_descriptors[type]);
+	if (evt_list)
+		goto out_free;
+}
+
+/*
+ * Print the help text for the event symbols:
+ */
+void print_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc, bool details_flag, bool deprecated,
+			const char *pmu_name)
+{
+	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
+			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
+
+	print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
+			    event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
+	print_tool_events(event_glob, name_only);
+
+	print_hwcache_events(event_glob, name_only);
+
+	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
+			details_flag, deprecated, pmu_name);
+
+	if (event_glob != NULL)
+		return;
+
+	if (!name_only) {
+		printf("  %-50s [%s]\n",
+		       "rNNN",
+		       event_type_descriptors[PERF_TYPE_RAW]);
+		printf("  %-50s [%s]\n",
+		       "cpu/t1=v1[,t2=v2,t3 ...]/modifier",
+		       event_type_descriptors[PERF_TYPE_RAW]);
+		if (pager_in_use())
+			printf("   (see 'man perf-list' on how to encode it)\n\n");
+
+		printf("  %-50s [%s]\n",
+		       "mem:<addr>[/len][:access]",
+			event_type_descriptors[PERF_TYPE_BREAKPOINT]);
+		if (pager_in_use())
+			printf("\n");
+	}
+
+	print_tracepoint_events(NULL, NULL, name_only);
+
+	print_sdt_events(NULL, NULL, name_only);
+
+	metricgroup__print(true, true, NULL, name_only, details_flag,
+			   pmu_name);
+
+	print_libpfm_events(name_only, long_desc);
+}
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
new file mode 100644
index 000000000000..1da9910d83a6
--- /dev/null
+++ b/tools/perf/util/print-events.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_PRINT_EVENTS_H
+#define __PERF_PRINT_EVENTS_H
+
+#include <stdbool.h>
+
+struct event_symbol;
+
+void print_events(const char *event_glob, bool name_only, bool quiet_flag,
+		  bool long_desc, bool details_flag, bool deprecated,
+		  const char *pmu_name);
+int print_hwcache_events(const char *event_glob, bool name_only);
+void print_sdt_events(const char *subsys_glob, const char *event_glob,
+		      bool name_only);
+void print_symbol_events(const char *event_glob, unsigned int type,
+			 struct event_symbol *syms, unsigned int max,
+			 bool name_only);
+void print_tool_events(const char *event_glob, bool name_only);
+void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
+			     bool name_only);
+
+#endif /* __PERF_PRINT_EVENTS_H */
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index a65f65d0857e..892c323b4ac9 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -19,16 +19,24 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <internal/lib.h> // page_size
+#include <sys/param.h>
 
 #include "trace-event.h"
+#include "tracepoint.h"
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
 #include "debug.h"
 
 #define VERSION "0.6"
+#define MAX_EVENT_LENGTH 512
 
 static int output_fd;
 
+struct tracepoint_path {
+	char *system;
+	char *name;
+	struct tracepoint_path *next;
+};
 
 int bigendian(void)
 {
@@ -400,6 +408,94 @@ put_tracepoints_path(struct tracepoint_path *tps)
 	}
 }
 
+static struct tracepoint_path *tracepoint_id_to_path(u64 config)
+{
+	struct tracepoint_path *path = NULL;
+	DIR *sys_dir, *evt_dir;
+	struct dirent *sys_dirent, *evt_dirent;
+	char id_buf[24];
+	int fd;
+	u64 id;
+	char evt_path[MAXPATHLEN];
+	char *dir_path;
+
+	sys_dir = tracing_events__opendir();
+	if (!sys_dir)
+		return NULL;
+
+	for_each_subsystem(sys_dir, sys_dirent) {
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
+		evt_dir = opendir(dir_path);
+		if (!evt_dir)
+			goto next;
+
+		for_each_event(dir_path, evt_dir, evt_dirent) {
+
+			scnprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path,
+				  evt_dirent->d_name);
+			fd = open(evt_path, O_RDONLY);
+			if (fd < 0)
+				continue;
+			if (read(fd, id_buf, sizeof(id_buf)) < 0) {
+				close(fd);
+				continue;
+			}
+			close(fd);
+			id = atoll(id_buf);
+			if (id == config) {
+				put_events_file(dir_path);
+				closedir(evt_dir);
+				closedir(sys_dir);
+				path = zalloc(sizeof(*path));
+				if (!path)
+					return NULL;
+				if (asprintf(&path->system, "%.*s",
+					     MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
+					free(path);
+					return NULL;
+				}
+				if (asprintf(&path->name, "%.*s",
+					     MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
+					zfree(&path->system);
+					free(path);
+					return NULL;
+				}
+				return path;
+			}
+		}
+		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
+	}
+
+	closedir(sys_dir);
+	return NULL;
+}
+
+static struct tracepoint_path *tracepoint_name_to_path(const char *name)
+{
+	struct tracepoint_path *path = zalloc(sizeof(*path));
+	char *str = strchr(name, ':');
+
+	if (path == NULL || str == NULL) {
+		free(path);
+		return NULL;
+	}
+
+	path->system = strndup(name, str - name);
+	path->name = strdup(str+1);
+
+	if (path->system == NULL || path->name == NULL) {
+		zfree(&path->system);
+		zfree(&path->name);
+		zfree(&path);
+	}
+
+	return path;
+}
+
 static struct tracepoint_path *
 get_tracepoints_path(struct list_head *pattrs)
 {
diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
new file mode 100644
index 000000000000..89ef56c43311
--- /dev/null
+++ b/tools/perf/util/tracepoint.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tracepoint.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/param.h>
+#include <unistd.h>
+
+#include <api/fs/tracing_path.h>
+
+int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
+{
+	char evt_path[MAXPATHLEN];
+	int fd;
+
+	snprintf(evt_path, MAXPATHLEN, "%s/%s/id", dir_path, evt_dir->d_name);
+	fd = open(evt_path, O_RDONLY);
+	if (fd < 0)
+		return -EINVAL;
+	close(fd);
+
+	return 0;
+}
+
+/*
+ * Check whether event is in <debugfs_mount_point>/tracing/events
+ */
+int is_valid_tracepoint(const char *event_string)
+{
+	DIR *sys_dir, *evt_dir;
+	struct dirent *sys_dirent, *evt_dirent;
+	char evt_path[MAXPATHLEN];
+	char *dir_path;
+
+	sys_dir = tracing_events__opendir();
+	if (!sys_dir)
+		return 0;
+
+	for_each_subsystem(sys_dir, sys_dirent) {
+		dir_path = get_events_file(sys_dirent->d_name);
+		if (!dir_path)
+			continue;
+		evt_dir = opendir(dir_path);
+		if (!evt_dir)
+			goto next;
+
+		for_each_event(dir_path, evt_dir, evt_dirent) {
+			snprintf(evt_path, MAXPATHLEN, "%s:%s",
+				 sys_dirent->d_name, evt_dirent->d_name);
+			if (!strcmp(evt_path, event_string)) {
+				closedir(evt_dir);
+				closedir(sys_dir);
+				return 1;
+			}
+		}
+		closedir(evt_dir);
+next:
+		put_events_file(dir_path);
+	}
+	closedir(sys_dir);
+	return 0;
+}
diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint.h
new file mode 100644
index 000000000000..c4a110fe87d7
--- /dev/null
+++ b/tools/perf/util/tracepoint.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_TRACEPOINT_H
+#define __PERF_TRACEPOINT_H
+
+#include <dirent.h>
+#include <string.h>
+
+int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
+
+#define for_each_event(dir_path, evt_dir, evt_dirent)		\
+	while ((evt_dirent = readdir(evt_dir)) != NULL)		\
+		if (evt_dirent->d_type == DT_DIR &&		\
+		    (strcmp(evt_dirent->d_name, ".")) &&	\
+		    (strcmp(evt_dirent->d_name, "..")) &&	\
+		    (!tp_event_has_id(dir_path, evt_dirent)))
+
+#define for_each_subsystem(sys_dir, sys_dirent)			\
+	while ((sys_dirent = readdir(sys_dir)) != NULL)		\
+		if (sys_dirent->d_type == DT_DIR &&		\
+		    (strcmp(sys_dirent->d_name, ".")) &&	\
+		    (strcmp(sys_dirent->d_name, "..")))
+
+int is_valid_tracepoint(const char *event_string);
+
+#endif /* __PERF_TRACEPOINT_H */
-- 
2.37.1.455.g008518b4e5-goog

