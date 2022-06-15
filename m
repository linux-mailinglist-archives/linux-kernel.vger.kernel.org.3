Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653A54BEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiFOAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiFOANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:13:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAA1582F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:13:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y8-20020a17090322c800b0016777c34c83so5609390plg.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VWOVk1jH/Ru1/0ssqOaKB13FZQZaZbbtFy4vR2AihMw=;
        b=LwBF5P4EWnhcmnqlfh220XsbVgQ40ho2vvijCuCVrq7gnnj/aW2PKau3PQwpWSTc0R
         WAwdHro0SkOGtQpjU1wPz1GxXhMYmKtFpiqUB7TJN31758mqmwuvV25zZ2OGDTxElC7z
         SOzGTN4LzCMcDgrtlaDrIdHq+8m9uphIJkux74OXeKbrpIKcqMo7EBHTFytmnRo3qAO9
         Sk4/b/sVysWZ8drQ1TJuzshwmozZC3qo8d6xRuvTa++Z+Xab7SnHQvlsqZ186Jv0yY6+
         QL3X3/3BTfZ2EFeXU0VNCOOtzRWxTe2LzcB34sG8cWjbhf7BI0bKuYoalC7ZhHFEob/v
         0EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VWOVk1jH/Ru1/0ssqOaKB13FZQZaZbbtFy4vR2AihMw=;
        b=Wq9BAE2XUhEccSVdKu5ERJDDl+VHVIGF2dG4OWfYP4J39jkDzAyotp1TRxOzqEBkEb
         ry5Y4kz28uh57acqLoSgpcVAz32dSFA3lWcxun7GDkiPmm/D5ZLKY+Oa8EHrAzW2Q/EG
         nJjzHyYFR3OesJh0QbiZTAHcfnT9jUaDROxfLHutVOurQKAs2JUjsxOAOtMRk7oO5ssc
         vxbyHrjb9eVNEpoQgUmOfdDl5LHIdVDFrv7xRkvOFqrYeElKu9qIiKlkORbCNZaoG/Tl
         aa7j/++U1Vbkz1ESWHpLih0PwY4/09ytrLvR4Z2kQnO4Tg7KVDBZ/cwVvNoMWHu2VLwL
         yv1A==
X-Gm-Message-State: AJIora9SJn7/9snWJY2LY834TiY7Q6VvM7BCpyd+IkthOMiMXIVE2+Zg
        fzq7gGp3ar81GjORV7XY3Q2ZFL0lDbekvn+2
X-Google-Smtp-Source: AGRyM1vGymm0xuf01VUXyVzBQro51MWVc/Eq45Kv64E7feWc10x4bxuGwSrgK5CdFJ0tBgDQz6uefp9zOxQKWKz7
X-Received: from blakejones.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:411c])
 (user=blakejones job=sendgmr) by 2002:a17:90a:fb90:b0:1e3:809:9296 with SMTP
 id cp16-20020a17090afb9000b001e308099296mr7056679pjb.26.1655252025667; Tue,
 14 Jun 2022 17:13:45 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:13:34 -0700
Message-Id: <20220615001334.611882-1-blakejones@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2] Add a "-m" option to "perf buildid-list".
From:   Blake Jones <blakejones@google.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Blake Jones <blakejones@google.com>
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

This new option displays all of the information needed to do external
BuildID-based symbolization of kernel stack traces, such as those collected
by bpf_get_stackid(). For each kernel module plus the main kernel, it
displays the BuildID, the start and end virtual addresses of that module's
text range (rounded out to page boundaries), and the pathname of the
module.

When run as a non-privileged user, the actual addresses of the modules'
text ranges are not available, so the tools displays "0, <text length>" for
kernel modules and "0, 0xffffffffffffffff" for the kernel itself.

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
 .../perf/Documentation/perf-buildid-list.txt  |  4 +++
 tools/perf/builtin-buildid-list.c             | 35 ++++++++++++++++++-
 tools/perf/util/machine.c                     | 13 +++++++
 tools/perf/util/machine.h                     |  5 +++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
index 25c52efcc7f0..e1e8fdbe06b9 100644
--- a/tools/perf/Documentation/perf-buildid-list.txt
+++ b/tools/perf/Documentation/perf-buildid-list.txt
@@ -33,6 +33,10 @@ OPTIONS
 -k::
 --kernel::
 	Show running kernel build id.
+-m::
+--kernel-maps::
+	Show buildid, start/end text address, and path of running kernel and
+	its modules.
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index cebadd632234..e73520190974 100644
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
@@ -20,6 +21,31 @@
 #include <errno.h>
 #include <linux/err.h>
 
+static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
+{
+	const struct dso *dso = map->dso;
+	char bid_buf[SBUILD_ID_SIZE];
+
+	memset(bid_buf, 0, sizeof(bid_buf));
+	if (dso->has_build_id)
+		build_id__sprintf(&dso->bid, bid_buf);
+	printf("%s %16lx %16lx", bid_buf, map->start, map->end);
+	if (dso->long_name != NULL)
+		printf(" %s", dso->long_name);
+	printf("\n");
+
+	return 0;
+}
+
+static void buildid__show_kernel_maps(void)
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
@@ -99,6 +125,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 int cmd_buildid_list(int argc, const char **argv)
 {
 	bool show_kernel = false;
+	bool show_kernel_maps = false;
 	bool with_hits = false;
 	bool force = false;
 	const struct option options[] = {
@@ -106,6 +133,8 @@ int cmd_buildid_list(int argc, const char **argv)
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
+	OPT_BOOLEAN('m', "kernel-maps", &show_kernel_maps,
+	    "Show build id of current kernel + modules"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_END()
 	};
@@ -117,8 +146,12 @@ int cmd_buildid_list(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, buildid_list_usage, 0);
 	setup_pager();
 
-	if (show_kernel)
+	if (show_kernel) {
 		return !(sysfs__fprintf_build_id(stdout) > 0);
+	} else if (show_kernel_maps) {
+		buildid__show_kernel_maps();
+		return 0;
+	}
 
 	return perf_session__list_build_ids(force, with_hits);
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 009061852808..28fff9a02ab0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3327,3 +3327,16 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
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
index 5d7daf7cb7bc..e1476343cbb2 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -262,6 +262,11 @@ typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *pr
 
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

base-commit: 1bcca2b1bd67f3c0e5c3a88ed16c6389f01a5b31
-- 
2.36.1.476.g0c4daa206d-goog

