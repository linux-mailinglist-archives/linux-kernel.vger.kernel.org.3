Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8271C4FE519
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357333AbiDLPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357285AbiDLPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:50:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A415FF33
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ebf1d99068so88815507b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ao0b9SWr4K1uMMglAI9pQiJY6csgtAAxNiaqGNs4iMk=;
        b=CVmjJoHRp0cuWN+qWLxSv70lIZwKxS9l1PPkCmKoRyk4/PcDWbhUe1EZdXpxROHbqr
         MfatMkGlhosHFw9pelGvDgW0GjarZmyGkZqhK3+UkDeqSg0SJgS6koPtg3lZcTS2/3SB
         fXQfOoAymNNH7cZJhQzhvAlB59XOWl7DoGL4YyFg1jsgmX8U0xgZo78f4EkolbhTx6Wp
         tUS/VIM6bokV3JxvfJ7+ggcIyItJ1dvyOaZaQZ7sVEIuAIe/N/jC3VlKHCIVhnpeRIK9
         aPDwv/CDJG+szBn9xZmqE393Y/uSKwl7SA8to7FSChssTVey1Filxt8iWMyncmk3p91m
         IWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ao0b9SWr4K1uMMglAI9pQiJY6csgtAAxNiaqGNs4iMk=;
        b=CCruR01xrx2j9v0KjOdfqNAsKg/uAfWdM2owDZDZv2+RcHbLvjuQrF+Ris/gR76rw+
         BkP62IGiMmADk433umnBAHYjisCErsvpSMKS2CMdP2ZVHvDarsYqDCMaTyRQKL1zsBnx
         niKuaYhL8oP6UN1n9EguyarH35Hv5950PvZquceRUL6oxuZUum9tveVTKODIP1EpHqpb
         YCF7Epk9ss8bSmORDxa4cAnaoGlBpSy+ZDjmSK/bH0gPkOVIlermAktZncrBVTy2pxUr
         3wuRqXZ6sIZVEOb5i6uavGYgjFcopptC8n3rgRiS5ARGTqeWBi18fgKWj28meTLT8kZg
         dXIg==
X-Gm-Message-State: AOAM532VJZfGzjPSL93JWfAN2Egm4hRYpV4lTvM5D7oYclraEeA+mcy/
        1AafYO8TuhjANttKIE8XjIuEWrkofzr3
X-Google-Smtp-Source: ABdhPJxS981/qfGqVamAS7vUL+eulQvFZOOVJXsweJ0Mj0SFfDO4j+3T10ZZbBbE0xQWvNrqtMtTEsf15ari
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a25:3b8b:0:b0:63d:f010:ed04 with SMTP id
 i133-20020a253b8b000000b0063df010ed04mr24813034yba.591.1649778506887; Tue, 12
 Apr 2022 08:48:26 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:48:15 -0700
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
Message-Id: <20220412154817.2728324-3-irogers@google.com>
Mime-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 2/4] perf symbols: Add is_kernel argument to fixup end
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel fixups may be special so add a flag to quickly detect if they are
necessary.
---
 tools/perf/arch/arm64/util/machine.c   |  3 ++-
 tools/perf/arch/powerpc/util/machine.c |  4 +++-
 tools/perf/arch/s390/util/machine.c    |  3 ++-
 tools/perf/util/symbol-elf.c           |  2 +-
 tools/perf/util/symbol.c               | 11 ++++++-----
 tools/perf/util/symbol.h               |  4 ++--
 6 files changed, 16 insertions(+), 11 deletions(-)

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
index 394ad493c343..cc4c46563802 100644
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
@@ -1659,7 +1660,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 #undef bfd_asymbol_section
 #endif
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, dso->kernel != DSO_SPACE__USER);
 	symbols__fixup_duplicate(&dso->symbols);
 	dso->adjust_symbols = 1;
 
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

