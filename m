Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E2488D61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiAIXpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiAIXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:45:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22CC06173F;
        Sun,  9 Jan 2022 15:45:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w16so46725200edc.11;
        Sun, 09 Jan 2022 15:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMVKzWzTDkR0qm3suHIJabcOLRjs4Osz10LuFhuiBqQ=;
        b=qF2H6YQCKG5mK6HEF6v1TEfhR5giSM4UdtU5JQ+Wai88ek6ir4iysxX/o10d/v/PCa
         z0QWciGSY0zbmWfbrt74Pao6mVGeNPNXvQZQo+lmY5+68Ss8liZ6S07P3zlyf6V/i8WB
         +B8GMfLUlRr9H777q1RwWXtA+/uWvNrtyGK96FeiOGdov1Kh9FW61FqMdOhaAQ6ka4am
         Axyq4xec0qBcjUPVUlmwdqZv+TiQbZWrVlFZzyGTEPbJl3IeCOVlnqJKA/LuFRpHm8wX
         9oYOtS1A5luxTphAqWZ4b175Kkr+ohBQ+xoztyg1HmeY8AKseWZvgn49TCa7e97rfLko
         dDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMVKzWzTDkR0qm3suHIJabcOLRjs4Osz10LuFhuiBqQ=;
        b=HYhljqUpLDiSwG9ukmI+oZCSMxBgsgs0LS4WMLl7rsKcKKUwZhUI8WTPEfD8fsdk/Q
         SVp4INl2R88rd2hiWoK5Y07cXLVooBkGxorJO14C8ogsCYFEksq0ju7FP2MeRs358pyE
         9HliYbjrLu2gOoNInjF4BqbR2mtFCjnShhJVjAXGfKNYTwXWFvPziiGPUPjpGhO//BYh
         dBCrXNPLQWNuEFAlvyPuAc+olSOAalyEr3QZJkFG6RiSXc6eaXySG3OjYRkqhMoelPwz
         aZuSVIeinC9v1olfgEVY2zIhOKYuO05vGfVcvU/a1357wkLwwv2bGCdjrOXJ4yzygQ8N
         sxRw==
X-Gm-Message-State: AOAM532OBIuG1YeaXPa2zBGe6mzSxmuJjg4KcL1U10vIt1+dBmioZOmB
        JhWMn/F41z/geRjVGrc+tZy8hVKdxWq3CQ==
X-Google-Smtp-Source: ABdhPJzOTbCQjm+GkHz+iDH9OwEiyI+CzOOSB6eqLvqd8dIFttdcgGTi873z0pS3ZB48GBdoRGdTXw==
X-Received: by 2002:a17:906:d554:: with SMTP id cr20mr55865493ejc.356.1641771898951;
        Sun, 09 Jan 2022 15:44:58 -0800 (PST)
Received: from localhost.localdomain (host-79-18-211-221.retail.telecomitalia.it. [79.18.211.221])
        by smtp.gmail.com with ESMTPSA id kx21sm1783493ejc.155.2022.01.09.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 15:44:58 -0800 (PST)
From:   Dario Petrillo <dario.pk1@gmail.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dario Petrillo <dario.pk1@gmail.com>
Subject: [PATCH] perf tui: avoid crash when annotating recursive functions
Date:   Mon, 10 Jan 2022 00:44:41 +0100
Message-Id: <20220109234441.325106-1-dario.pk1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf report, entering a recursive function from inside of itself
(either directly of indirectly through some other function) results in
calling symbol__annotate2 multiple times, and freeing the whole disassembly
when exiting from the innermost instance. The first issue causes the
function's disassembly to be duplicated, and the latter a heap
use-after-free (and crash) when trying to access the disassembly again.

I reproduced the bug on perf 5.11.22 (Ubuntu 20.04.3 LTS) and 5.16.rc8
with the following testcase (compile with gcc recursive.c -o recursive).
To reproduce:
- perf record ./recursive
- perf report
- enter fibonacci and annotate it
- move the cursor on one of the "callq fibonacci" instructions and press enter
  - at this point there will be two copies of the function in the disassembly
- go back by pressing q, and perf will crash

#include <stdio.h>

int fibonacci(int n)
{
    if(n <= 2) return 1;
    return fibonacci(n-1) + fibonacci(n-2);
}

int main()
{
    printf("%d\n", fibonacci(40));
}

This patch addresses the issue by annotating a function and freeing the
associated memory on exit only if no annotation is already present,
so that a recursive function is only annotated on entry.

Signed-off-by: Dario Petrillo <dario.pk1@gmail.com>

---
 tools/perf/ui/browsers/annotate.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e81c2493efdf..44ba900828f6 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -966,6 +966,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		.opts = opts,
 	};
 	int ret = -1, err;
+	int not_annotated = list_empty(&notes->src->source);
 
 	if (sym == NULL)
 		return -1;
@@ -973,13 +974,15 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate2(ms, evsel, opts, &browser.arch);
-	if (err) {
-		char msg[BUFSIZ];
-		ms->map->dso->annotate_warned = true;
-		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-		ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
-		goto out_free_offsets;
+	if (not_annotated) {
+		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
+		if (err) {
+			char msg[BUFSIZ];
+			ms->map->dso->annotate_warned = true;
+			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
+			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+			goto out_free_offsets;
+		}
 	}
 
 	ui_helpline__push("Press ESC to exit");
@@ -994,9 +997,11 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
-	annotated_source__purge(notes->src);
+	if(not_annotated)
+		annotated_source__purge(notes->src);
 
 out_free_offsets:
-	zfree(&notes->offsets);
+	if(not_annotated)
+		zfree(&notes->offsets);
 	return ret;
 }
-- 
2.25.1

