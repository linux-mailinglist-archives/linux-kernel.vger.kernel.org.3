Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94BD4FE51A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357311AbiDLPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353342AbiDLPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:50:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB645FF3D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so161713577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MNOrivzCB1IEcfUHpsPArN3av86pSVn5LI+JFeA009c=;
        b=Jxfcw41rIapSLBYY08oP79pW5QErfm0BlHMc9JOvIieL951+KQwxEyz9TwCoKjg5ia
         ti5O1h3vb0jWEPqVVl//CM9xr5kJ5zPlDjSWm+vWxVFjzTQBRAGF5u4FbK2UyoDSDkuj
         DS0FxeIAgTgE/ydppsuZWDV3puxDGvxQiY00VfHoimJhhNrx1mI7YG88+b0wdKV51Ifr
         BJznapmMQh2xGpvRKO/1uyO2wjRgvC2awCco39UmxwoZZjOV0NHOTYSqX+EC5Q4Y0vFw
         /xzhlk8w7udKnct+AFWq56O39PGQTRWntQjSn/cJKZt5HEA0zu7dpJG5iURk+3EDgf8F
         AoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MNOrivzCB1IEcfUHpsPArN3av86pSVn5LI+JFeA009c=;
        b=5zmPgriCWqqu4B3LKa7nuVuOICsrynnuica6YhwMSNAko9pitNOmI71aNq+cFwBJWO
         9+HYDyLmfLe7XnjjEPwaMiaAte4091G5Ityg79dIRsUgy+ddghpNLIemaApBeYVykclH
         1PQk1Z4f1G50X/8sHPXoFKTcJ/ubXRg50iIl6uNtWUxYz9agtKzYAkqXJU+rLApzjdqi
         r5eNv7OLdya1PK502CopA5qEHZnjKzBlX5SzSiCPrElK146niJvD98CtaBAaYPb9BtxE
         P0qB8fgLYAL4EQf81QN1FKqOn+sP/lNkh2OZ8osVucBvp3J8iLYFdgf846cKrwZ48dhR
         OpjQ==
X-Gm-Message-State: AOAM531N5SXRqXELupPLyaUSGZJN+jecuFzM9hhQx+JpOzBQFMsVULnW
        cJ2Tjs4S9O7duNAtV+QXFPvBG1nq08fk
X-Google-Smtp-Source: ABdhPJwGRXJ4fhz3KDb9CRYJODouALMvz33H5HzPda/tm0sxnTSEU0EVIgx3og/+Sbbhdq3eUBWkMUmwdzDj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr30798226ywa.301.1649778504446; Tue, 12
 Apr 2022 08:48:24 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:48:14 -0700
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
Message-Id: <20220412154817.2728324-2-irogers@google.com>
Mime-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 1/4] perf symbols: Always do architecture specific fixups
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

The change:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
modified the condition for architecture specific fixups motivated by a
PowerPC case. So that architectures can independently modify their
condition, move the if into the called architecture symbols__fixup_end
function and always call it.
---
 tools/perf/arch/arm64/util/machine.c   | 14 ++++++++------
 tools/perf/arch/powerpc/util/machine.c | 14 ++++++++------
 tools/perf/arch/s390/util/machine.c    | 14 ++++++++------
 tools/perf/util/symbol.c               |  6 +++---
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index d2ce31e28cd7..1cc33b323c3f 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -20,13 +20,15 @@
 
 void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 {
-	if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
+	if (p->end == p->start || p->end != c->start) {
+		if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
 			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
-		/* Limit range of last symbol in module and kernel */
-		p->end += SYMBOL_LIMIT;
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+			/* Limit range of last symbol in module and kernel */
+			p->end += SYMBOL_LIMIT;
+		else
+			p->end = c->start;
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	}
 }
 
 void arch__add_leaf_frame_record_opts(struct record_opts *opts)
diff --git a/tools/perf/arch/powerpc/util/machine.c b/tools/perf/arch/powerpc/util/machine.c
index e652a1aa8132..88a8abf98a57 100644
--- a/tools/perf/arch/powerpc/util/machine.c
+++ b/tools/perf/arch/powerpc/util/machine.c
@@ -16,10 +16,12 @@
 
 void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 {
-	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-		/* Limit the range of last kernel symbol */
-		p->end += page_size;
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	if (p->end == p->start || p->end != c->start) {
+		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
+			/* Limit the range of last kernel symbol */
+			p->end += page_size;
+		else
+			p->end = c->start;
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	}
 }
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 7644a4f6d4a4..0b750738ec68 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -44,10 +44,12 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
  */
 void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 {
-	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-		/* Last kernel symbol mapped to end of page */
-		p->end = roundup(p->end, page_size);
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	if (p->end == p->start || p->end != c->start) {
+		if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
+			/* Last kernel symbol mapped to end of page */
+			p->end = roundup(p->end, page_size);
+		else
+			p->end = c->start;
+		pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
+	}
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dea0fc495185..394ad493c343 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -103,7 +103,8 @@ static int prefix_underscores_count(const char *str)
 
 void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 {
-	p->end = c->start;
+	if (p->end == p->start || p->end != c->start)
+		p->end = c->start;
 }
 
 const char * __weak arch__normalize_symbol_name(const char *name)
@@ -231,8 +232,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		prev = curr;
 		curr = rb_entry(nd, struct symbol, rb_node);
 
-		if (prev->end == prev->start || prev->end != curr->start)
-			arch__symbols__fixup_end(prev, curr);
+		arch__symbols__fixup_end(prev, curr);
 	}
 
 	/* Last entry */
-- 
2.35.1.1178.g4f1659d476-goog

