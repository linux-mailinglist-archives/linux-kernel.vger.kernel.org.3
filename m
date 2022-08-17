Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2128E5968BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiHQFjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiHQFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA34F667
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so138317077b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=VkM79uf89xeQ9qFc9A5bUuDYRz5EWRncjylJ1j1cl8Q=;
        b=TpKExb6K4/FgBtiARrFl0maFT5kacEGjgS13MSq4nMcb1rY/NAKYdSkRUwo0cZvGLQ
         nVmt7R31EYgz8/3OAbL/ej5r/YQy+vbbQ6kjOsaUzYPArAa2dFFY4foFNiWT5n3cPk9A
         NDqGoimWlp50Opxx8m8Rhf/aIFa198L6t4kahaGBaTun4jXhqe6cwhcY/onJk4rJ+DPJ
         1HRk7em27jJVRLf+BdFSwreL315IRrhsN5jZSwTqlrCamOVYzmuYJFMVVvXeImlf1ZSi
         70IZroSyCeR/FpxI6y3nivSmmi+sdeaJ4VaJR5hDErG6o8tfe2jn0b24UVz4gd0WM2GC
         1/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=VkM79uf89xeQ9qFc9A5bUuDYRz5EWRncjylJ1j1cl8Q=;
        b=pfWD4zbSbeRLsq8BOvfl7/6sXfAgRCE0jw2cn4zfiSx4NOYp8Gf6GNA0H/F+1cgq/m
         J5EbJrg8skqGbq7EFVUvTJChXMpmWazrjAb+WmVHKp0Gbr7hhGorI0CDiBKlQ3uAy2+D
         gKCRsW2FPDDzH3B1YXm6yh4kLCJpDG8sd6h0Glb2PHOra/Qk4zCjJFuER51xP9hBUyEC
         3svO3D7gjhJjb3xnyMbu9nG/prnZEArptgz5hp2uTi9IVwQZnzWprbyX1XTittAgmXY2
         puSj6aPMkKwfT//+zQnpN33jQ+B68jQGTHmGxuhWdHLNDUNRY8kQoPrLBrXyN8C9MfTk
         5OPA==
X-Gm-Message-State: ACgBeo0d9fjaNDQqICrEJOJqnGVrXE0Dp1HzyrbV+okJPebXYn/AsUUV
        svzOrvMkNrkIhGMYHY9GI+23aiB2D/dj
X-Google-Smtp-Source: AA6agR49j963T7BConaaXi/0oWf0mWkxrSWi84UR5nMJIfrNEkbIwlSm4ueLbVQzRCuSzrdrZ2GnzGWrHeoX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a25:6002:0:b0:684:da54:e35 with SMTP id
 u2-20020a256002000000b00684da540e35mr15600368ybb.552.1660714782806; Tue, 16
 Aug 2022 22:39:42 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:27 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-4-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 3/6] perf dso: Hold lock when accessing nsinfo
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
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

There may be threads racing to update dso->nsinfo:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Holding the dso->lock avoids use-after-free, memory leaks and other
such bugs. Apply the fix in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
of there being a missing nsinfo__put now that the accesses are data race
free. Fixes test "Lookup mmap thread" when compiled with address
sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   |  4 ++++
 tools/perf/util/annotate.c    |  2 ++
 tools/perf/util/build-id.c    | 12 +++++++++---
 tools/perf/util/dso.c         |  7 ++++++-
 tools/perf/util/map.c         |  3 +++
 tools/perf/util/probe-event.c |  3 +++
 tools/perf/util/symbol.c      |  2 +-
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2a0f992ca0be..2a914eaf6425 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -433,8 +433,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	if (dso) {
+		mutex_lock(&dso->lock);
 		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		mutex_unlock(&dso->lock);
 	} else
 		nsinfo__put(nsi);
 
@@ -617,6 +619,7 @@ static int dso__read_build_id(struct dso *dso)
 	if (dso->has_build_id)
 		return 0;
 
+	mutex_lock(&dso->lock);
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
@@ -630,6 +633,7 @@ static int dso__read_build_id(struct dso *dso)
 		free(new_name);
 	}
 	nsinfo__mountns_exit(&nsc);
+	mutex_unlock(&dso->lock);
 
 	return dso->has_build_id ? 0 : -1;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 29d804d76145..1bbfbc8e1554 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1697,6 +1697,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 */
 		__symbol__join_symfs(filename, filename_size, dso->long_name);
 
+		mutex_lock(&dso->lock);
 		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
 			char *new_name = filename_with_chroot(dso->nsinfo->pid,
 							      filename);
@@ -1705,6 +1706,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 				free(new_name);
 			}
 		}
+		mutex_unlock(&dso->lock);
 	}
 
 	free(build_id_path);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index ec18ed5caf3e..a839b30c981b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -898,11 +898,15 @@ static int filename__read_build_id_ns(const char *filename,
 static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 {
 	struct build_id bid;
+	bool ret = false;
 
-	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) < 0)
-		return false;
+	mutex_lock(&dso->lock);
+	if (filename__read_build_id_ns(name, &bid, dso->nsinfo) >= 0)
+		ret = !dso__build_id_equal(dso, &bid);
 
-	return !dso__build_id_equal(dso, &bid);
+	mutex_unlock(&dso->lock);
+
+	return ret;
 }
 
 static int dso__cache_build_id(struct dso *dso, struct machine *machine,
@@ -941,8 +945,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	if (!is_kallsyms && dso__build_id_mismatch(dso, name))
 		goto out_free;
 
+	mutex_lock(&dso->lock);
 	ret = build_id_cache__add_b(&dso->bid, name, dso->nsinfo,
 				    is_kallsyms, is_vdso, proper_name, root_dir);
+	mutex_unlock(&dso->lock);
 out_free:
 	free(allocated_name);
 	return ret;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c7a5b42d1311..89e1b93cb874 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -501,6 +501,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	if (!name)
 		return -ENOMEM;
 
+	mutex_lock(&dso->lock);
 	if (machine)
 		root_dir = machine->root_dir;
 
@@ -541,6 +542,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		unlink(name);
 
 out:
+	mutex_unlock(&dso->lock);
 	free(name);
 	return fd;
 }
@@ -559,8 +561,11 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	int fd;
 	struct nscookie nsc;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+		mutex_lock(&dso->lock);
 		nsinfo__mountns_enter(dso->nsinfo, &nsc);
+		mutex_unlock(&dso->lock);
+	}
 	fd = __open_dso(dso, machine);
 	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
 		nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e0aa4a254583..f3a3d9b3a40d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -181,7 +181,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		mutex_lock(&dso->lock);
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		mutex_unlock(&dso->lock);
 
 		if (build_id__is_defined(bid)) {
 			dso__set_build_id(dso, bid);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 785246ff4179..0c24bc7afbca 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -29,6 +29,7 @@
 #include "color.h"
 #include "map.h"
 #include "maps.h"
+#include "mutex.h"
 #include "symbol.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
@@ -180,8 +181,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 
 		map = dso__new_map(target);
 		if (map && map->dso) {
+			mutex_lock(&map->dso->lock);
 			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+			mutex_unlock(&map->dso->lock);
 		}
 		return map;
 	} else {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 656d9b4dd456..a3a165ae933a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1791,6 +1791,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char newmapname[PATH_MAX];
 	const char *map_path = dso->long_name;
 
+	mutex_lock(&dso->lock);
 	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
@@ -1800,7 +1801,6 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
-- 
2.37.1.595.g718a3a8f04-goog

