Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE88519054
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242988AbiECVk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiECVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:40:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4540A07
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:37:21 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x9-20020a056a000bc900b0050d919e9c9bso8729432pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PGYU0nW8LJveDdJBlNtzADM9jDyH0JnoYUFg7J1RGr0=;
        b=eo4MPZeko/VswpaQqNoK94w/pDKrjxTMBbPGqYsNHJuY4qIm2xOoPGFzibW95nWQ8q
         6EYB6faix2uyoeF/pqgQtqNPuKM5nbikSVx+TNGYZuNP4xNuyYCe0z1IntO3IRiwhm6T
         XY/rHVUpAesTcoGvXXpYf/2E9nIc5DoWsNDMdmUGGDSGbRSoma3AGJHOPe0wSzJlEh6Q
         mGc+rdWsMGE+94uN2WujH1PicDoj63Ep41OCFrExw26SIVZp8MRp2GPtFiC+bsy5RXNx
         X7SrdZzmfF7sYoyV0mWCn2f1L+YWaP89IK+qbRkznnPvcQnXEZNI0B9fv50O/6iAm6PU
         3SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PGYU0nW8LJveDdJBlNtzADM9jDyH0JnoYUFg7J1RGr0=;
        b=u3tsR6SSGvRmvzhAFKdjvkg73R4B2xUruTRcsywL/q53HCpcwnTV22MrW8xF2PYwJe
         fLfDYRfKx2TCObsNUFLN2FRu6CWbmb5I8BWjB0ruvqFQgcBJ6v+ZZOt+ReuIFjoOjokn
         f3gx9rVs2jQPZ2AmVFOrgn2HlC6OU5tUPAQ7yOqEN8rNVsTq6VVVSVBMUKnW66jeLkip
         8FcFugTi/D9VxTgk5Eabh8jkhoiVaQ5EBTJa4yHCh1ZiUuGkXvs/PJAgTHW/c49vgm43
         aEpXnn4ry/Ar0xOplP7neC8zCN97b3UESouF0zGWfgQ8HU4FU8+mlFGl5zqOrq68FxuP
         jbeg==
X-Gm-Message-State: AOAM530TZL17O/AbCQ/3+8sR1Ra2MmxFRWuSpzqfplbMOHLVTsLo9J1K
        oaD2CDC0tLzppr8BNBtER47D62xyxWP4WsRv
X-Google-Smtp-Source: ABdhPJzgQvwW7F4F0ZNcWjFmA78kNk409gKHTxMMcmGsODW5timNYtJsVum+iW2jMqRrwYAAJ/2gZv1dx7Y+v88P
X-Received: from blakejones.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:411c])
 (user=blakejones job=sendgmr) by 2002:aa7:8104:0:b0:50d:374b:4568 with SMTP
 id b4-20020aa78104000000b0050d374b4568mr17935843pfi.45.1651613840682; Tue, 03
 May 2022 14:37:20 -0700 (PDT)
Date:   Tue,  3 May 2022 14:37:04 -0700
Message-Id: <20220503213704.2524229-1-blakejones@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] Add an "-m" option to "perf buildid-list".
From:   Blake Jones <blakejones@google.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Blake Jones <blakejones@google.com>
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

This new option displays all of the information needed to do external
BuildID-based symbolization of kernel stack traces, such as those collected
by bpf_get_stackid(). For each kernel module plus the main kernel, it
displays the BuildID, the start and end virtual addresses of that module's
text range (rounded out to page boundaries), and the pathname of the
module.

When run as a non-privileged user, the actual addresses of the modules'
text ranges are not available, so the tools displays "0, <text length>" for
kernel modules and "0, ffffffffffffffff" for the kernel itself.

Sample output:

root# perf buildid-list -m
cf6df852fd4da122d616153353cc8f560fd12fe0 ffffffffa5400000 ffffffffa6001e27 [kernel.kallsyms]
1aa7209aa2acb067d66ed6cf7676d65066384d61 ffffffffc0087000 ffffffffc008b000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/sha512_generic.ko
3857815b5bf0183697b68f8fe0ea06121644041e ffffffffc008c000 ffffffffc0098000 /lib/modules/5.15.15-1rodete2-amd64/kernel/arch/x86/crypto/sha512-ssse3.ko
4081fde0bca2bc097cb3e9d1efcb836047d485f1 ffffffffc0099000 ffffffffc009f000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/acpi/button.ko
1ef81ba4890552ea6b0314f9635fc43fc8cef568 ffffffffc00a4000 ffffffffc00aa000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/cryptd.ko
cc5c985506cb240d7d082b55ed260cbb851f983e ffffffffc00af000 ffffffffc00b6000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/i2c/busses/i2c-piix4.ko
[...]

Signed-off-by: Blake Jones <blakejones@google.com>
---
 .../perf/Documentation/perf-buildid-list.txt  |  3 ++
 tools/perf/builtin-buildid-list.c             | 33 ++++++++++++++++++-
 tools/perf/util/dso.c                         | 23 +++++++++++++
 tools/perf/util/dso.h                         |  2 ++
 tools/perf/util/machine.c                     | 13 ++++++++
 tools/perf/util/machine.h                     |  5 +++
 6 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
index 25c52efcc7f0..a82e92c2667d 100644
--- a/tools/perf/Documentation/perf-buildid-list.txt
+++ b/tools/perf/Documentation/perf-buildid-list.txt
@@ -33,6 +33,9 @@ OPTIONS
 -k::
 --kernel::
 	Show running kernel build id.
+-m::
+--modules::
+	Show buildid, start/end text address, and path of kernel and modules.
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index cebadd632234..9a5587de8fd0 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -12,6 +12,7 @@
 #include "util/build-id.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/map.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/session.h"
@@ -20,6 +21,29 @@
 #include <errno.h>
 #include <linux/err.h>
 
+static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
+{
+	struct build_id build_id;
+	char bid_buf[SBUILD_ID_SIZE];
+	char modpath[255];
+
+	dso__get_build_id(map->dso, &build_id);
+	build_id__sprintf(&build_id, bid_buf);
+	dso__get_long_name(map->dso, modpath, sizeof(modpath));
+	printf("%s %16lx %16lx %s\n", bid_buf, map->start, map->end, modpath);
+
+	return 0;
+}
+
+static void buildid__show_kernel_modules(void)
+{
+	struct machine *machine;
+
+	machine = machine__new_host();
+	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
+	machine__delete(machine);
+}
+
 static int sysfs__fprintf_build_id(FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
@@ -99,6 +123,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 int cmd_buildid_list(int argc, const char **argv)
 {
 	bool show_kernel = false;
+	bool show_modules = false;
 	bool with_hits = false;
 	bool force = false;
 	const struct option options[] = {
@@ -106,6 +131,8 @@ int cmd_buildid_list(int argc, const char **argv)
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
+	OPT_BOOLEAN('m', "modules", &show_modules,
+	    "Show build id of current kernel + modules"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_END()
 	};
@@ -117,8 +144,12 @@ int cmd_buildid_list(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, buildid_list_usage, 0);
 	setup_pager();
 
-	if (show_kernel)
+	if (show_kernel) {
 		return !(sysfs__fprintf_build_id(stdout) > 0);
+	} else if (show_modules) {
+		buildid__show_kernel_modules();
+		return 0;
+	}
 
 	return perf_session__list_build_ids(force, with_hits);
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5ac13958d1bd..7c490b5ce449 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1227,6 +1227,19 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 	dso__set_long_name_id(dso, name, NULL, name_allocated);
 }
 
+void dso__get_long_name(const struct dso *dso, char *name, size_t len)
+{
+	if (len == 0)
+		return;
+	if (dso->long_name == NULL) {
+		name[0] = '\0';
+		return;
+	}
+
+	strncpy(name, dso->long_name, len);
+	name[len - 1] = '\0';
+}
+
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	if (name == NULL)
@@ -1359,6 +1372,16 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
 	dso->has_build_id = 1;
 }
 
+void dso__get_build_id(struct dso *dso, struct build_id *bid)
+{
+	if (dso->has_build_id) {
+		*bid = dso->bid;
+	} else {
+		bid->size = 0;
+		memset(bid->data, 0, sizeof(*bid->data));
+	}
+}
+
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 {
 	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3a9fd4d389b5..896ed335b562 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -237,6 +237,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+void dso__get_long_name(const struct dso *dso, char *name, size_t len);
 
 int dso__name_len(const struct dso *dso);
 
@@ -263,6 +264,7 @@ void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
 void dso__set_build_id(struct dso *dso, struct build_id *bid);
+void dso__get_build_id(struct dso *dso, struct build_id *bid);
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
 void dso__read_running_kernel_build_id(struct dso *dso,
 				       struct machine *machine);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 95391236f5f6..78e84eb037a6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3232,3 +3232,16 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
 	}
 	return err;
 }
+
+int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
+{
+	struct maps *maps = machine__kernel_maps(machine);
+	struct map *map;
+	int err = 0;
+
+	for (map = maps__first(maps); map != NULL; map = map__next(map)) {
+		if (fn(map, priv))
+			err = -1;
+	}
+	return err;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 0023165422aa..2a022259d373 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -259,6 +259,11 @@ typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *pr
 
 int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
 			  void *priv);
+
+typedef int (*machine__map_t)(struct map *map, void *priv);
+int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn,
+				 void *priv);
+
 int machine__for_each_thread(struct machine *machine,
 			     int (*fn)(struct thread *thread, void *p),
 			     void *priv);

base-commit: e0c1b8f9eba88173b30ba42eb492fd20582cf376
-- 
2.36.0.464.gb9c8b46e94-goog

