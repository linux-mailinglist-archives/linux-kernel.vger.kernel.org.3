Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79A359EED2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiHWWNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiHWWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:12:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2A7C778
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:11:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5960500bso260576957b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=K4oRiNn+G2rdtJsE6L2b3oylFpgb/KpBFNxvRzPUh68=;
        b=mPAPh3cEvyWdIZIF7pmnVaWOxwkdb/agfVPZLOISUSLKAOcBm6GD0GO984MB0BbI3h
         nLeod1OUEJerQDtGS66iqteAj4Zm/QF4FHJoo6k5jCF7oa7npVly5Z+afdgkK7DojHeE
         K8XhJDLxpv6UuKYEhvh3OXaCnHSBd81MS4q6MwEPHtSUGiZMhjf9hc0OnS34FCadQuwz
         1SoHhjdmqixqY3VKmSmcDFXYPCR4Nxk+7nq3/U2G43pCTfjljlWU06JiNxt6XIhCpDPk
         pZzBl3Mm1ZUgjxzQpUOIwQluQR+T8AvcaJs7Oz2ymxKbM2XVkwRHeMA2lI1ymtHkqfVg
         Lvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=K4oRiNn+G2rdtJsE6L2b3oylFpgb/KpBFNxvRzPUh68=;
        b=GPBq0LkJp8EJR2JJB0lLTpX4+MuMNIz0EiFHqqPgPLsYrXAyyzN5MpDg54sooI60bI
         C9kq+LLuKuEk3VvKLNU6cN0a/ec5WsKDzSlYpk9+RZuOjqR3/b7CPvz629zuu+pfucEl
         LAEBUVqU91DAAE8MJpGKmPx7xBRYXK5v30iSx5ZbZ8GPwEVNMc4s2X+/ILc/6m5b8qkE
         HjwkCmlFQs5xChRaOfvKs2tB4DpacxX4AbUMbjpamkhPK5ag/K7I8/hgoNXMLoudQOKE
         BSSQNA0PPjbKajsbhxnSxvhzAFnyNTLAidNeU/zcyrSUzmBKK4HxNMIq3SKQ2PdYT4wN
         jzMA==
X-Gm-Message-State: ACgBeo0dUhJnU+tAwV+7x+TODvKuRUSbN7OP2YMYr7JgwTAWijvC8v/J
        ULKjI83KQn84idUAILEFMJ74aCo/CAat
X-Google-Smtp-Source: AA6agR7GhAN18bhNP7OEUGzMVoWqbLNjvwo0Kz5W4Z6P+DPRLh4sVcdbaQ0WjCi4/p46vI8Uk3tw7Xot0K2W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a81:124c:0:b0:334:d633:f3c9 with SMTP id
 73-20020a81124c000000b00334d633f3c9mr28335053yws.437.1661292677181; Tue, 23
 Aug 2022 15:11:17 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:21 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-18-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 17/18] perf top: Fixes for thread safety analysis
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

Add annotations to describe lock behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3757292bfe86..e832f04e3076 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -196,6 +196,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
 					struct evsel *evsel, u64 ip)
+	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -724,13 +725,13 @@ static void *display_thread(void *arg)
 static int hist_iter__top_callback(struct hist_entry_iter *iter,
 				   struct addr_location *al, bool single,
 				   void *arg)
+	EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
 {
 	struct perf_top *top = arg;
-	struct hist_entry *he = iter->he;
 	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
+		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
-- 
2.37.2.609.g9ff673ca1a-goog

