Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCB4FE51B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357355AbiDLPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357310AbiDLPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:50:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9560047
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so161685747b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cK/G+RqonStF/h6xatk1gRDJ5hKKNHxh+2wJ+78igxE=;
        b=EIM0xpglnrgdDge6VWgBXN8lvGL/IrrgKxb8vdaNjShzxCRJlvFBrPzOrFHL5lp+I7
         ugxJ9LYMkf/3GQfmoop9DJRQEjENOpNJfNzpxXmYPbZiWVJqpqBsRXdIa5RR1B6TQKWJ
         YJFpXMWb8qn2tkyio6rJzkXAQp98Uqc6E/PbJB6XFwzeMOX5Up+bWOHCWjdcJl1JfMUF
         3XcxNbsZ7xCBuT1vK7ZqYnntZGrY4Rf803wSA4ZHCk2z8RKwhFmxRj6poLOsQ7HchQBi
         mAv2YzmyYPUdeyA5x4QiTA6n9DQ01xkP3U8h8p/loJfnObWqyPkuG7JiAJQZe8RjcdoK
         73vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cK/G+RqonStF/h6xatk1gRDJ5hKKNHxh+2wJ+78igxE=;
        b=z6eT8A9ZjB5ht1vreQRj/GDWTHoTrvZeSZrR6raNX5qvns6sGo6CPMDdV/U8B+FOnd
         UqtkdxorynEfF1MPQnKqmMd1T5P9168r5ZjsxCsD0R061KpaUvPExI/As1U1yZkcNAdx
         vN1Pd1dRfHO6w7vKpU6Y25uFdJQjtVjlDii2VmJvOroahc3nPCZyU2cz0yCMtwMk7hhr
         cR5C9jUVWTDlISr1mr+xbP28Iq4kOBpgcteqTQZPiEP0sgQlU5qUfkIUro4kqZ6O61ac
         yWuGnMMKWg3m42wMNGXuUE1tMEdJM4+AttEG9DyE5OmrlFkrjb2vIpTvti0wZGuB1M+y
         he6Q==
X-Gm-Message-State: AOAM530aOtSXbB6CYVZnBPWYQj1/deigGeeyhC7DTwFvq4zs8w9F1gXs
        c5UjFxYARA4kdH1YflEtKYvlHTU2carW
X-Google-Smtp-Source: ABdhPJzeeAZlsCG5jbITUmxEHUU6RdnBefMiXkuXksPrPKjHyVQMHFGwRGaloelAD/z0+JPjBhMnEenrZx10
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:63e:5325:d6b0 with SMTP
 id v3-20020a056902108300b0063e5325d6b0mr18951794ybu.431.1649778512269; Tue,
 12 Apr 2022 08:48:32 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:48:17 -0700
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
Message-Id: <20220412154817.2728324-5-irogers@google.com>
Mime-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 4/4] perf symbols: More specific architecture end fixing
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

Make the conditions used for symbol fixup closer to the comments. The
logic aims to combine the current conditions as last modified in:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
---
 tools/perf/arch/arm64/util/machine.c   | 19 ++++++++++---------
 tools/perf/arch/powerpc/util/machine.c | 18 +++++++++---------
 tools/perf/arch/s390/util/machine.c    | 17 +++++++++--------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 54fb41de9931..f258c1ebac03 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -18,16 +18,17 @@
 
 #define SYMBOL_LIMIT (1 << 12) /* 4K */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 {
-	if (p->end == p->start || p->end != c->start) {
-		if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
-			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
-			/* Limit range of last symbol in module and kernel */
-			p->end += SYMBOL_LIMIT;
-		else
-			p->end = c->start;
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
+	     (strchr(p->name, '[') == NULL && strchr(c->name, '[')))) {
+		/* Limit range of last symbol in module and kernel */
+		p->end += SYMBOL_LIMIT;
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 	}
 }
diff --git a/tools/perf/arch/powerpc/util/machine.c b/tools/perf/arch/powerpc/util/machine.c
index a732601f951e..689a48040b64 100644
--- a/tools/perf/arch/powerpc/util/machine.c
+++ b/tools/perf/arch/powerpc/util/machine.c
@@ -14,16 +14,16 @@
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 )
 {
-	if (p->end == p->start || p->end != c->start) {
-		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-			/* Limit the range of last kernel symbol */
-			p->end += page_size;
-		else
-			p->end = c->start;
-		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    strchr(p->name, '[') == NULL && strchr(c->name, '[')) {
+		/* Limit the range of last kernel symbol */
+		p->end += page_size;
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 	}
+	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 }
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 8622a1b78748..790d98a39c83 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -42,15 +42,16 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
  * and beginning of first module's text segment is very big.
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
-			      bool is_kernel __maybe_unused)
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c, bool is_kernel)
 {
-	if (p->end == p->start || p->end != c->start) {
-		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-			/* Last kernel symbol mapped to end of page */
-			p->end = roundup(p->end, page_size);
-		else
-			p->end = c->start;
+	if (is_kernel && (p->end == p->start || p->end != c->start) &&
+	    strchr(p->name, '[') == NULL && strchr(c->name, '[')) {
+		/* Last kernel symbol mapped to end of page */
+		p->end = roundup(p->end, page_size);
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	} else if (p->end == p->start) {
+		/* Expand empty symbols. */
+		p->end = c->start;
 		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 	}
 }
-- 
2.35.1.1178.g4f1659d476-goog

