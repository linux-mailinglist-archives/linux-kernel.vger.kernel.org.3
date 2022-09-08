Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BFF5B29D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIHXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIHXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:02:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C02529B;
        Thu,  8 Sep 2022 16:02:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jm11so120172plb.13;
        Thu, 08 Sep 2022 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=NHcEwmsstqIOlIz3moRAOT/hW63/MeqC/fZR0hJqwjs=;
        b=DRYwpjUFac0zr2ZfI4cOt/nxoEYrZpIuOj8NBQQbxFW9hiO8nZ8goqkWx+af5btkHR
         1RFlvGVTY6aMH3Y8M5C2dJ1Z7cCgWxL/cPqc6cBbFcqP7YQaaeKp1Q74DovwXxDStTU6
         fSKFeVYuTBwCw/DhTK6aujw3kLDKtT59ixHvE3Sio303oDuotDAy1FnQa9z7eLnmzPlk
         SRiTJ+DHQYJdiDjM3y2KVNqRz46wW7WTfLEA/pw0ndgtbu/IjPQ1taOLMD8oovHOYXPD
         gVrUp19mCCSPQG2m4vqbhZ91dkOkDI2ntCV/dDuQJgaUR49lWAzn3hsaHdj5vTSJI7VO
         2EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=NHcEwmsstqIOlIz3moRAOT/hW63/MeqC/fZR0hJqwjs=;
        b=MRzU6J26u486KnKQkPXOMVlsiOLVf3lE+ALqKFX9uYNFCMt/KNWCT9SGm89SYrK51r
         ylu90k/+6L5Dj8lyJXkf+zx0m55RrI4x99TpMU+KCai8xnwfeFVaSTAlWxzOINcUj791
         HRnKGdAGxIqxitocJfEjK9wIraOHtIV7THT8gAYipXgVoS87F1SGcaKenp5Sghs9Bn7L
         7TFvbqMktGW0fO4D8PV9fG0Yw1W+EYoZ8zvacWfz0NhYR6oyjWEA8YvyBZaZXrZ8d3+E
         HmlV0n9SE6SV+6DE06T8tvOflt6X/RI37zzyfVjnkMhONoYv/2697ARU03sIa5THt187
         XspQ==
X-Gm-Message-State: ACgBeo0U2/6h6bIVhrl0m0IQaejKu00LjPif7LfOk8mDZsS99LzYecu0
        AwzQeBmpA3uEhbJe8qKdOjo=
X-Google-Smtp-Source: AA6agR4j0GT838XqGLx0/jhdoTsv4JzUgzMbNuTXzxMxzLpAXdnv8miR9iH5jIRpD+bgIW6eF2sIBQ==
X-Received: by 2002:a17:903:1248:b0:172:f3c7:97a6 with SMTP id u8-20020a170903124800b00172f3c797a6mr10994327plh.128.1662678125654;
        Thu, 08 Sep 2022 16:02:05 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id o7-20020a656a47000000b004308422060csm12872839pgu.69.2022.09.08.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:02:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3] perf test: Skip sigtrap test on old kernels
Date:   Thu,  8 Sep 2022 16:01:50 -0700
Message-Id: <20220908230150.4105955-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it runs on an old kernel, perf_event_open would fail because of the
new fields sigtrap and sig_data.  Just skipping the test could miss an
actual bug in the kernel.

Let's check BTF (when we have libbpf) if it has the sigtrap field in the
perf_event_attr.  Otherwise, we can check it with a minimal event config.

Cc: Marco Elver <elver@google.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sigtrap.c | 65 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index e32ece90e164..1de7478ec189 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -54,6 +54,63 @@ static struct perf_event_attr make_event_attr(void)
 	return attr;
 }
 
+#ifdef HAVE_BPF_SKEL
+#include <bpf/btf.h>
+
+static bool attr_has_sigtrap(void)
+{
+	bool ret = false;
+	struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_member *m;
+	const char *name;
+	int i, id;
+
+	btf = btf__load_vmlinux_btf();
+	if (btf == NULL) {
+		/* should be an old kernel */
+		return false;
+	}
+
+	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
+	if (id < 0)
+		goto out;
+
+	t = btf__type_by_id(btf, id);
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!strcmp(name, "sigtrap")) {
+			ret = true;
+			break;
+		}
+	}
+out:
+	btf__free(btf);
+	return ret;
+}
+#else  /* !HAVE_BPF_SKEL */
+static bool attr_has_sigtrap(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_SOFTWARE,
+		.config		= PERF_COUNT_SW_DUMMY,
+		.size		= sizeof(attr),
+		.remove_on_exec = 1, /* Required by sigtrap. */
+		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
+	};
+	int fd;
+	bool ret = false;
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
+	if (fd >= 0) {
+		ret = true;
+		close(fd);
+	}
+
+	return ret;
+}
+#endif  /* HAVE_BPF_SKEL */
+
 static void
 sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
 {
@@ -139,7 +196,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 
 	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
 	if (fd < 0) {
-		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
+		if (attr_has_sigtrap()) {
+			pr_debug("FAILED sys_perf_event_open(): %s\n",
+				 str_error_r(errno, sbuf, sizeof(sbuf)));
+		} else {
+			pr_debug("perf_event_attr doesn't have sigtrap\n");
+			ret = TEST_SKIP;
+		}
 		goto out_restore_sigaction;
 	}
 
-- 
2.37.2.789.g6183377224-goog

