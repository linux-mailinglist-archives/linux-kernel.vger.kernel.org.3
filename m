Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644F57C38C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiGUEhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGUEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:37:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597656D55B;
        Wed, 20 Jul 2022 21:36:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ku18so515757pjb.2;
        Wed, 20 Jul 2022 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlonJbiCrIbX27YpRbbAWUw/yuoyRGqchFM5XXg+n5s=;
        b=jYTsJqabEVdZqCboKQzgwmU1gBH4AyjwBBn+WDOuK65xpFrPrZeRtix5k8k+BAgxzR
         1OebIA7SzdRriwtEHZkZGYa5FD14zUDJRQiF/h8lIn5lbK9qMdqE0PAoy3wwDKEszFeV
         Xgo/meBsu+F+0OkbwWvk5xS/NglGibiNaoShRS0yYi9MeYdenAvEYGZtWsai2oKt4LDk
         BegdL7FhO6PlU2hCl26u3uydNjfU5Z7RIMObuvsiwJ3BdjtN1fOt2Q6lzVttFyGl7IPw
         GW9+P3OnILObxjgrd6JIxrW8XL+7ES2PxUgPBdDK3+XcmuB83xpDCIEoyiEMJENxsk9+
         NaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FlonJbiCrIbX27YpRbbAWUw/yuoyRGqchFM5XXg+n5s=;
        b=3QmGLRy9i8IHxcZQdab5IazwI25dwX/vx3mtapJGyzRt9/j5ik51fHBJD/OAxPb9JM
         Mkj6vJx0/wRkf+Jy0bC4KCHphu/JEe0xLtxdeMhTxQxdURTUj9Fia4zOWTfG0V2cwSfn
         La1T9zPqrjcUoD1t3atlu+esD/fNd5XIG0+H4sK9vM6RdgB441ChUDAPhf0GP81k7znM
         7DOjVb8MNKy7UMivbl4O/VYmvWtzjiUbKQMnHOJfkvi3gWaAnpcutuEEhHgFkJCffUbe
         aZgAtkcIL9jlVyEviwXq+zq4Sto/nXzQnRGJmrJLN2eFc5TBLzRMyidbAO/3jQGUtEYr
         lMgA==
X-Gm-Message-State: AJIora9I5w2hjfw9L//VMEGO2c7VlEAEmR6kEsPjV/zQExX6MbaqmGu2
        9GIgfDvpBbGsxmbOHutczRQ=
X-Google-Smtp-Source: AGRyM1smMrTRGnjELhAv6qdbmz+LTu533MNpRd0RAGLsSqwtyaRcbVuQccbHlYCtXb750wdQN5+tKw==
X-Received: by 2002:a17:902:d2c8:b0:16c:58d:727e with SMTP id n8-20020a170902d2c800b0016c058d727emr42037675plc.76.1658378215660;
        Wed, 20 Jul 2022 21:36:55 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:467:a1e4:c167:53fd:8047:7f62])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0016bea2a0a8dsm450824pla.91.2022.07.20.21.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:36:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/6] perf lock: Add lock aggregation enum
Date:   Wed, 20 Jul 2022 21:36:41 -0700
Message-Id: <20220721043644.153718-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721043644.153718-1-namhyung@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the aggr_mode variable to prepare the later code change.
The default is LOCK_AGGR_ADDR which aggregate the result for the lock
instances.  When -t/--threads option is given, it'd be set to
LOCK_AGGR_TASK.  The LOCK_AGGR_CALLER is for the contention analysis
and it'd aggregate the stat by comparing the callstacks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 93 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 1de459198b99..551bad905139 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -126,6 +126,12 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 
+static enum {
+	LOCK_AGGR_ADDR,
+	LOCK_AGGR_TASK,
+	LOCK_AGGR_CALLER,
+} aggr_mode = LOCK_AGGR_ADDR;
+
 /*
  * CONTENTION_STACK_DEPTH
  * Number of stack trace entries to find callers
@@ -622,12 +628,22 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	int flag = evsel__intval(evsel, sample, "flags");
+	u64 key;
 
-	/* abuse ls->addr for tid */
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
-	ls = lock_stat_findnew(addr, name, 0);
+	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -695,11 +711,22 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	u64 contended_term;
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	u64 key;
 
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
-	ls = lock_stat_findnew(addr, name, 0);
+	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -757,11 +784,22 @@ static int report_lock_contended_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	u64 key;
 
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
-	ls = lock_stat_findnew(addr, name, 0);
+	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -812,11 +850,22 @@ static int report_lock_release_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	u64 key;
 
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
-	ls = lock_stat_findnew(addr, name, 0);
+	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -980,11 +1029,22 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+	u64 key;
 
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
-	ls = lock_stat_find(addr);
+	ls = lock_stat_find(key);
 	if (!ls) {
 		char buf[128];
 		const char *caller = buf;
@@ -993,7 +1053,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
 			caller = "Unknown";
 
-		ls = lock_stat_findnew(addr, caller, flags);
+		ls = lock_stat_findnew(key, caller, flags);
 		if (!ls)
 			return -ENOMEM;
 	}
@@ -1050,9 +1110,20 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	u64 contended_term;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+	u64 key;
 
-	if (show_thread_stats)
-		addr = sample->tid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_ADDR:
+		key = addr;
+		break;
+	case LOCK_AGGR_TASK:
+		key = sample->tid;
+		break;
+	case LOCK_AGGR_CALLER:
+	default:
+		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
+		return -EINVAL;
+	}
 
 	ls = lock_stat_find(addr);
 	if (!ls)
@@ -1416,6 +1487,9 @@ static int __cmd_report(bool display_info)
 	if (select_key())
 		goto out_delete;
 
+	if (show_thread_stats)
+		aggr_mode = LOCK_AGGR_TASK;
+
 	err = perf_session__process_events(session);
 	if (err)
 		goto out_delete;
-- 
2.37.0.170.g444d1eabd0-goog

