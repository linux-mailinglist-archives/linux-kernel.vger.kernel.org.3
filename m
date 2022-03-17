Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD34DD113
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCQXSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQXSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:18:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AD1A7706
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:16:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so5605526ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hvoW0T1Jxa8buR1vUq7mHDbmRrmWB7evEEmXb00k+lk=;
        b=EtXmvJO9en2amaPkrnmu4Xi2E9HoWfDQIP1qHWBhasehZ0Js3ng9DDzb3y9dipxnUB
         tJkMpUjlnXmmQG8+/Z4NjP4BaY71AfTo28LuJepcfxKRJR1ERDZwTcZ+v8ZLC5SUXC4z
         2JED2DjpEw+go1rHx758n8RKcI+UaiCQ3diW1EtbbwWTUhn3qJYsl7r1pBROGXmWyuoT
         492o3BveZFBpi49Uuy90Z8h/USxSqgmJ67+bVC2J7KOlr3LWLvj2z1HDXM8ePZMaqzwE
         v5QwAMqFnE5DUR+G0ntw2c93sWJ/vBYfOdE9uzdPzhDXHoDK2sAdQ/6vRHpepqKpvSu3
         CQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hvoW0T1Jxa8buR1vUq7mHDbmRrmWB7evEEmXb00k+lk=;
        b=eruN4IiSjmDcrekA5bhqj8hh2aRjFK6lTyino63tOfs5RzS3kVAA6MLgcd3/iy6h01
         jCgQ0plT0k8g+y4o5kGHMsQW8lLOO0fe+i179T3sUNH/w0QiF2E3V8pX1FnPsmcFTuE9
         uLDMmpNRDy42wY7g0ykIek44+qHSen+IOAiYn2ss8zli7INk3UI6VnJDyYrCBdXJn1XW
         a/+ss0odaP+0yvJAyUNYqRhQEyji4dyr2pPC34gDAQBR+m+jIEGFGm4WyeItJVg8RA1F
         8Vf/50pemS4P+AFyWoEjdy7SzXQNclrRxKdPsDA7XDa7O8JQJKleCk6jfU4MzBz4h+8z
         zZRA==
X-Gm-Message-State: AOAM530IYkb7kuR8qgPAHLRD8IoEv97GVboMaD+NImS+LVbSOfVn3Ld/
        RY5+lLyAamdLtnHrfFD6eNbFA8Qg6kE0
X-Google-Smtp-Source: ABdhPJxiYWuxPZ+gOFx5nyIRI2ACj30mUOekasrtLlPHsJhLpmg75DvxfbzQm+haX3k7arH+uIq5nFB7RPmr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:cf47:0:b0:633:854f:b710 with SMTP id
 f68-20020a25cf47000000b00633854fb710mr7499660ybg.475.1647559009908; Thu, 17
 Mar 2022 16:16:49 -0700 (PDT)
Date:   Thu, 17 Mar 2022 16:16:43 -0700
Message-Id: <20220317231643.550902-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] perf evlist: Avoid iteration for empty evlist.
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ian Rogers <irogers@google.com>
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

As seen with 'perf stat --null ..' and reported in:
https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/

v2. Avoids setting evsel in the empty list case as suggested by Jiri
    Olsa <jolsa@kernel.org>.
Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8134d45e2164..9bb79e049957 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -346,7 +346,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 {
 	struct evlist_cpu_iterator itr = {
 		.container = evlist,
-		.evsel = evlist__first(evlist),
+		.evsel = NULL,
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
 		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
@@ -354,16 +354,22 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 		.affinity = affinity,
 	};
 
-	if (itr.affinity) {
-		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
-		affinity__set(itr.affinity, itr.cpu.cpu);
-		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
-		/*
-		 * If this CPU isn't in the evsel's cpu map then advance through
-		 * the list.
-		 */
-		if (itr.cpu_map_idx == -1)
-			evlist_cpu_iterator__next(&itr);
+	if (evlist__empty(evlist)) {
+		/* Ensure the empty list doesn't iterate. */
+		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
+	} else {
+		itr.evsel = evlist__first(evlist);
+		if (itr.affinity) {
+			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+			affinity__set(itr.affinity, itr.cpu.cpu);
+			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
+			/*
+			 * If this CPU isn't in the evsel's cpu map then advance
+			 * through the list.
+			 */
+			if (itr.cpu_map_idx == -1)
+				evlist_cpu_iterator__next(&itr);
+		}
 	}
 	return itr;
 }
-- 
2.35.1.894.gb6a874cedc-goog

