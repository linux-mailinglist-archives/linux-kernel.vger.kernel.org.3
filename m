Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B94F8BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiDGXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiDGXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91546DA6F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:05:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e61c5a0eb7so60233027b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xuahj0daJES831OYl0Fkgb0vM1zVKd68GzYFqhf9BfQ=;
        b=PCx5eSsv7v0+PzFFN0c8bH9dab4pORvVPuQqmn3xB8c+/kojL5tIPi1xKduPAAJx/X
         J1Rapz27A01ixG1Ww4arEC4Gm6FbmtQ5j+++F76q4pnZu371efhghIE5ojZQmbJKwyzD
         XH7KVhKbIF8HaSHQKcAULmtF8JzxdQmFr12xyZQDKcAT6v2sf+xJdasSZBOGrpPVSNbl
         BtllOmbDFVN0OlfpjiCILvK8m+vSh5N52b4fOYX/54tRkQlhXYnlggd+dEef1Y7uKple
         OGyNWHK1PY2AQAUVo5YCDFM4JckuDGnzgWM7DylByHMRwUEtopheDSlH7/VXo3qzLw7k
         SGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xuahj0daJES831OYl0Fkgb0vM1zVKd68GzYFqhf9BfQ=;
        b=5OxGKACaze0x8toYC0dHKpR9S7lAO38aLPjegCsu8L2f6yE1+pB++aBwv4db8SzftM
         QTLCkIgjgqa2KAbZb1JGcSVVyVykbwgAL+KZVSE8WWxss92bDaaJMbd1rCW39GxYedQe
         yVbcAM2mArimXcsKO2ZdcNWD6QuSkN17xNe7dic46WDNraEkzWHTe1j80E1Vm18eYvJP
         hxLf1MGE7e6QHjtHB3ujk3Bk8v8tpq66TAoy8gFfWDuKBUS0Yp0ITEOHm7pYW2mQloHL
         vWaj/89anT51gu+w/1wobpinXfcU5qBUqdGQwqnFUzEO2gV0hSAaEPBN9KVLcmIv+aQj
         +7Fg==
X-Gm-Message-State: AOAM530DG8O4n/Lsf8x9RjjiHY8FnIdYc88H2F4kdNChjWel5f5RLc7e
        t4Wq3tDUO2FO4AoFJ0nOm+cI4Z6636IP
X-Google-Smtp-Source: ABdhPJw3MtR/8U6P+0OZrpAACVCj/fTCBkATcW2PyD/L2Y0Pf7n4jyr+fEe1BhjcG1AtDHHo12kIwXZlYS27
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:f305:0:b0:63e:76f4:4643 with SMTP id
 c5-20020a25f305000000b0063e76f44643mr2596405ybs.580.1649372716693; Thu, 07
 Apr 2022 16:05:16 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:05:00 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-3-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 2/5] perf symbols: Always do architecture specific fixups
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

The change:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
modified the condition for architecture specific fixups motivated by a
PowerPC case. So that architectures can independently modify their
condition, move the if into the called architecture symbols__fixup_end
function and always call it.

Signed-off-by: Ian Rogers <irogers@google.com>
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

