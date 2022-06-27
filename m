Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16555D333
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbiF0Wlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbiF0Wl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:41:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A991DA47
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:41:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i16-20020a170902cf1000b001540b6a09e3so5994048plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VWOVk1jH/Ru1/0ssqOaKB13FZQZaZbbtFy4vR2AihMw=;
        b=U3e8/1GURdwGIAAFUU81M/SVz+LRao4LLZWWl/OrbybdCl903JTylbP3MRKJDFx3gq
         JacHf+Tx3TJZ7D6oO5amJKBPhH2YNumbOb6/VhcXS2Sq9o62eMUMx//fhqiJrbQeJR/n
         sDqqMuk2IDEnlXTQbSS+KMpTi0dEp0JadMxZBltoN+CA+N5pqoapt28fdm3V6Bkl4GLQ
         tuoQB5syrnkVOGsFv4cgtDStG/ljMKhCUYtEBKuGLOPpbVNASgyFph368F7/ohHWVWF5
         xt6dvam+kTPw+38L7rWCLzNa7SDf3pToo2cku7NDNUkBk8pL2Z6ne8MsgA7Amc/k6rZl
         57eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VWOVk1jH/Ru1/0ssqOaKB13FZQZaZbbtFy4vR2AihMw=;
        b=A941J21VaQ50d4DC/gLUXaXbJONMo4TNjM59JHUSwtCSgKlwJ+P6S8HYDSIgk00LJ6
         dhVrpmUxDnMBvI1rAiSRJk3vDZ+uMwjKS7NCvM3ICjWFWWpCxhke+1Wt9XWJbLz9S1V4
         /PcdN8sec+hRWu/54GtVjAk44gDu3mxaV6HiWS6EeQ2GpSr0PgnyC1ym4Qb0hEP/YngC
         JDc4aDK3Chis8QOSo6z8wbOkqtRTtDzkR5GFTU3WZWW4xdUAlyRKRv4Lq1wXFI5aQ78M
         5hIVPucnBuRxodlKNT5Lqmz/xtxd3Vkh1jUAVR24KpUk/Bc6jH8BMn+Q2dIlLJMVVnvF
         28AQ==
X-Gm-Message-State: AJIora9zXuJulyFio5XL+idBgCds5tCywK4ven3tSq7Jns/ihhaBTgOt
        lGnPqXwA/LSov6hUdoUDSe5qtYL/qAVB89kR
X-Google-Smtp-Source: AGRyM1sOaDV3HTAdMOsEX1ae55WDsgGcPzNaJOi4lGRO74gADlY3yZSMYEvrQbf96KGJQ6hMm5tflxZfCphzwGD1
X-Received: from blakejones.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:411c])
 (user=blakejones job=sendgmr) by 2002:a17:903:2448:b0:16a:37de:89b3 with SMTP
 id l8-20020a170903244800b0016a37de89b3mr446772pls.68.1656369688408; Mon, 27
 Jun 2022 15:41:28 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:41:16 -0700
Message-Id: <20220627224116.3015376-1-blakejones@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 RESEND] Add a "-m" option to "perf buildid-list".
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

