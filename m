Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310FF4F8AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiDGXHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiDGXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26115EBAC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:05:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb689106e3so60227007b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cgF/pihI368V1FzITLW8N4wweJzsyz+om7JJReNSZ+4=;
        b=CJH8ftCXfs8lgiSmEvudTtaUdZe73HrhwI3Rm82nLUQbHZZD5KC8Wkiur+6D0xVcCZ
         mDkWDry/JEXw8XvS1ZFYniUquKCmjtKiXrJz0ReaV1r7HO/dq8JdMQGbmQQRDS6rdgDE
         GIcr7NhbwnxkDtGPp95BRQ2qKbyrpLBr9BsBrcFZ1BWbDcufruKIZqJGVttMFCaJslx5
         TpJmhGy50f+Ejx/Bt5saLeT6GzSCoDnkNgzBevgt4KJsinPd6C54nwf8XKMQhCz6iUMe
         U2J7zrXwKNK42rXr31UInQkhsCMw7CbfrsXWjMki2yiY62a/dV0RgKRB3N7SfzDRr0fE
         tLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cgF/pihI368V1FzITLW8N4wweJzsyz+om7JJReNSZ+4=;
        b=wD/5WMRyJmUGEQGGBy6pQjaCtYnhSyC1R9eQclKDS/3bbjR6+pC9Crp4pWqGXqe5ZZ
         cbNtmFu18DUPl3S/5sEY7uF3BYQ3e9s2+2EoL0XeAQYySsuyToEz1YOgblCR5RrVtBBK
         Cw85/d/ErUFdbRqsy0chi0Afim7Ki5d4UBUTp9tX8dOHsh0RI/RP4vdrFXiVsR2wHIw0
         WEWH/Ie9WZm8XbXsZKeeKKTilwAb0K3xrJU84S3lvtG+1G0fomJ+/pgvbzBZZKumFtNr
         FEBHkwxpLwVL8pskhPJZoiH+jJedgxe90mCcX7ymCpetAAf5JTCDX7YOoyoO5bFXZidx
         l1Og==
X-Gm-Message-State: AOAM532r5OOgHbrpu92ew626rLptPI6TAEaFf739qxAkasufbzqM0qTe
        vuRz8TBNH0xss7V3i7EYS+hpW3pb1ZoH
X-Google-Smtp-Source: ABdhPJywzI8+vrcC1is9V+TFv8P9n+XT9Rg9h/gTvBLj628PYmkwX7hEAqXLXvDbPHGUQhWGYR+FwWBprC0v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP id
 c2-20020a5b0982000000b0063e7d7ee2f2mr2100238ybq.549.1649372719358; Thu, 07
 Apr 2022 16:05:19 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:05:01 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-4-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 3/5] perf symbols: Add is_kernel argument to fixup end
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

Kernel fixups may be special so add a flag to quickly detect if they are
necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/machine.c   | 3 ++-
 tools/perf/arch/powerpc/util/machine.c | 4 +++-
 tools/perf/arch/s390/util/machine.c    | 3 ++-
 tools/perf/util/symbol-elf.c           | 2 +-
 tools/perf/util/symbol.c               | 9 +++++----
 tools/perf/util/symbol.h               | 4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 1cc33b323c3f..54fb41de9931 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -18,7 +18,8 @@
 
 #define SYMBOL_LIMIT (1 << 12) /* 4K */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
+			      bool is_kernel __maybe_unused)
 {
 	if (p->end == p->start || p->end != c->start) {
 		if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
diff --git a/tools/perf/arch/powerpc/util/machine.c b/tools/perf/arch/powerpc/util/machine.c
index 88a8abf98a57..a732601f951e 100644
--- a/tools/perf/arch/powerpc/util/machine.c
+++ b/tools/perf/arch/powerpc/util/machine.c
@@ -14,7 +14,9 @@
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
+			      bool is_kernel __maybe_unused)
+)
 {
 	if (p->end == p->start || p->end != c->start) {
 		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 0b750738ec68..8622a1b78748 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -42,7 +42,8 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
  * and beginning of first module's text segment is very big.
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
+			      bool is_kernel __maybe_unused)
 {
 	if (p->end == p->start || p->end != c->start) {
 		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 31cd59a2b66e..6598a5d9f223 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1290,7 +1290,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * For misannotated, zeroed, ASM function sizes.
 	 */
 	if (nr > 0) {
-		symbols__fixup_end(&dso->symbols);
+		symbols__fixup_end(&dso->symbols, dso->kernel != DSO_SPACE__USER);
 		symbols__fixup_duplicate(&dso->symbols);
 		if (kmap) {
 			/*
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 394ad493c343..087cdf2a58c9 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -101,7 +101,8 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
-void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
+				     bool is_kernel __maybe_unused)
 {
 	if (p->end == p->start || p->end != c->start)
 		p->end = c->start;
@@ -218,7 +219,7 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 	}
 }
 
-void symbols__fixup_end(struct rb_root_cached *symbols)
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kernel)
 {
 	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
@@ -232,7 +233,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		prev = curr;
 		curr = rb_entry(nd, struct symbol, rb_node);
 
-		arch__symbols__fixup_end(prev, curr);
+		arch__symbols__fixup_end(prev, curr, is_kernel);
 	}
 
 	/* Last entry */
@@ -1467,7 +1468,7 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, /*is_kernel=*/true);
 	symbols__fixup_duplicate(&dso->symbols);
 
 	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index fbf866d82dcc..8428f24e67df 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -203,7 +203,7 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
 		       bool kernel);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
-void symbols__fixup_end(struct rb_root_cached *symbols);
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kernel);
 void maps__fixup_end(struct maps *maps);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
@@ -241,7 +241,7 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c);
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel);
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
-- 
2.35.1.1178.g4f1659d476-goog

