Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53E95AFD32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIGHMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIGHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:12:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F6A222E;
        Wed,  7 Sep 2022 00:12:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o126so4724251pfb.6;
        Wed, 07 Sep 2022 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=6lTRwgbVAQzKBet64OF/KNo58h2SgV1oGkXH8Q9vXpc=;
        b=Qt5A4ogV0ru8hJtbs7yIS4YQsTRTxo/A7yEjip/KYlWOBIgQltdeiVqqba/eW2ALFl
         E8sOzUQ6saNXGhkF29R2CWmLVjKRKCsTW0GCxprfxLyrYCSFYZwufvRye+m7OIJMM7Ho
         CPhpYVpkxvP64SVJ9tNaCxd9t+EB3FeNlG/WsaagcoGP3PPYx8HjjZUyAYAjc6SihqlB
         iljF3Y4i/Jh4XgmY8NwlfKpA4Dt75lf5oLIwZ8AISoebRXneSAcR0L72TNF6zrTCa8UT
         z05cllVcPF94AStZjS+uctb2nYdN2HYWkja4V5rsGlqBam7fG1UCyaH5sjfTLCBFmVFE
         wQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=6lTRwgbVAQzKBet64OF/KNo58h2SgV1oGkXH8Q9vXpc=;
        b=jy1KG/YgmaRQRwALITpjaFuEYeJ7EAigM1Yo1ytRdE8bDwoZYsiuEx3THgAXfOZdU6
         TwaR7orB+MWPb2coeyPkqC8tfMGAiYBhfhS9DtZAoTccz98Dpp4RJe8VS0TbJsdfn/EJ
         Za07UXSy6hbq+zXiYptt/3mUg+YFvaoP0zttu7pAVcybR7XuwSUfruun1OK6UeFMLzBB
         2TiUhsYUbPshwgJQvxHdv63Yv2j3NhqQm9aojkGBOgx21UlS7TWb97/0tLKyLRM8B7oe
         8y8HQcNcU8wKtnuYUtgdFSFZtpoBXUtQdwTfWKtiyGa86Q2jxdE+GJG89avyUGpRXL/X
         KHWQ==
X-Gm-Message-State: ACgBeo1Wex0RgKiSPDxIRn+SpoOZ+hKR4A6nE92VbnhzIW/CryagHzfD
        wrnNLYVuK8pnbIb2lckWQMRsnnrycVw=
X-Google-Smtp-Source: AA6agR73rw+T4Ol8Sg0hDNU5vVcNF/JWnhpucIWDNLl33KGjbieyjKEZt3npyvWO0BGd8sqONN+tMw==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr2383242pfb.23.1662534733953;
        Wed, 07 Sep 2022 00:12:13 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:31b5:b507:23a9:c4ba])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001743be790b4sm11395999plx.215.2022.09.07.00.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:12:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3] perf test: Skip sigtrap test on old kernels
Date:   Wed,  7 Sep 2022 00:12:03 -0700
Message-Id: <20220907071203.2729746-1-namhyung@kernel.org>
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

Let's check BTF if it has the perf_event_attr.sigtrap field.

Cc: Marco Elver <elver@google.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* move #include under #ifdef
* return true when BPF is not supported
* update comment

 tools/perf/tests/sigtrap.c | 50 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index e32ece90e164..cdf75eab6a8a 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -54,6 +54,48 @@ static struct perf_event_attr make_event_attr(void)
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
+	/* to maintain current behavior */
+	return true;
+}
+#endif  /* HAVE_BPF_SKEL */
+
 static void
 sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
 {
@@ -139,7 +181,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 
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

