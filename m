Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD05968B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiHQFkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiHQFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4153D15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3328a211611so87240857b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=iLN5+FLnhYIWqoDWLTWymRmT3HSuCKQDMghp6cr49+4=;
        b=RmO9zVA/7Wz8b9GtpWsugHokUFgVDsG4vXhQNbDdnCDmm9BYfj+EyK6z57xrOuwSr5
         xEHy7nRGZdtn7j0pVRnsb79os9hz8xZ8L3I3H/+5RGvGbmAaY1KTeppz5YckCGTdlKFi
         WMmnxqPfR29q93koEqVqKV0oQyX6zZAGkY0X+m7nC1ZDpearMsBP/fqcS/s4uAbh7N4k
         VL5kJWQpBFQf16lVQU3Hz3d7rLu9p44+5RFbWVEZKnl4dC6PjnAHJBEy0jRaUu8zH2r1
         brJNcJN3Lg6IsHi6eP1cNqo9Kcsv7W71EYHmTabd6r3Bc8KeGw+RTkqsFBciOOgkRjzC
         qIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=iLN5+FLnhYIWqoDWLTWymRmT3HSuCKQDMghp6cr49+4=;
        b=49Eh2zHXQosNCiRBAQ26YOHa3MKRsV1nuOY4ebwKtF9PPL6JNp8uJj88zoGR2ysg0J
         6YC6Ru/hIDkjagR6SmU8+oqDF+WM9hOn3v9gkYSX5BcgmdT5FV802n270ixcKhX8RXK0
         h8Bt/Y1fVmTrAzA2fVkB7+uyrvIAHp9NsYXxrZPSTiwaDYgi980HxAhTukURf009d+ZY
         r/5N9LTZv7Ci960WzLJ6a6A4jTtF2sw5eTgSsV+uuYeDGVRHH5sbpNw/SFs2USTRt5Pj
         bFhAzxpcFMr5t/2bucTJ7LKICazCF0+g9yNzkvM7Xp0JCe/T7PShkVfxKX4mmwQQlo/9
         Suew==
X-Gm-Message-State: ACgBeo2pifAtlAOpzbOnbS9jr9HPnE01bUTFSs6yL65MAoB/oEs/P6zR
        51CUCgj5D5dNL0aZgaa4rtJAoqtp0NtV
X-Google-Smtp-Source: AA6agR5Ztfm8DnME40MFJ+L3pOkrk/LLHs6fSAOR1/U1JeP8TP+phIUcP0v3cVdGvdWh8ubaYa9KQriPDx3N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a05:6902:920:b0:68f:a286:2a2b with SMTP id
 bu32-20020a056902092000b0068fa2862a2bmr3041696ybb.612.1660714788460; Tue, 16
 Aug 2022 22:39:48 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:29 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-6-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 5/6] perf mutex: Fix thread safety analysis
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
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
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

Add annotations to describe lock behavior. Add missing unlocks to
perf_sched__replay. Alter hist_iter__top_callback as the thread-safety
analysis cannot follow pointers through local variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 8 ++++++++
 tools/perf/builtin-top.c   | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0f52f73be896..a8a765ed28ce 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -658,6 +658,8 @@ static void *thread_func(void *ctx)
 }
 
 static void create_tasks(struct perf_sched *sched)
+	EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
+	EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
 {
 	struct task_desc *task;
 	pthread_attr_t attr;
@@ -687,6 +689,8 @@ static void create_tasks(struct perf_sched *sched)
 }
 
 static void wait_for_tasks(struct perf_sched *sched)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
 {
 	u64 cpu_usage_0, cpu_usage_1;
 	struct task_desc *task;
@@ -738,6 +742,8 @@ static void wait_for_tasks(struct perf_sched *sched)
 }
 
 static void run_one_test(struct perf_sched *sched)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
 {
 	u64 T0, T1, delta, avg_delta, fluct;
 
@@ -3314,6 +3320,8 @@ static int perf_sched__replay(struct perf_sched *sched)
 	for (i = 0; i < sched->replay_repeat; i++)
 		run_one_test(sched);
 
+	mutex_unlock(&sched->start_work_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 	return 0;
 }
 
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
2.37.1.595.g718a3a8f04-goog

