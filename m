Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F5C580409
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiGYSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiGYSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:31:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157913D1F;
        Mon, 25 Jul 2022 11:31:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b9so11191070pfp.10;
        Mon, 25 Jul 2022 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1DcUEHBVE6rdnLWJkIE3FghXMPvrALLztQYWoRsMVg=;
        b=N8TRWbLD6wRwFzdOqbuRTyG3kxj1iTJd38OG59x/uR/iTh9LrCT/40EVXDlrcqLJI5
         j4Y5DbwDDXbLlGpXeDB8Ie9AYzIt1HgHPvgAu2XxUUqLmqjYmsmsQdR/mUNhHRYE3Rj4
         DwRftEGjWxU4ryQxe1GBC+S7IZ2w4jagihKeQN0DRW3OE4IPUgRG6uooG7f6tx50ormM
         sE9ooRP6nzgLuVmvr6WvuWG14i67CzwO9PLC4YdeaOUVVBkIRIMvw2/9mDy/cwWNuhLT
         WfUvuk88woJOVNF6b8mF5rjMKUZsIC4YACDAcca1e1bfGR+3kSJwXGwPEhcPuedKjUBO
         AnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=D1DcUEHBVE6rdnLWJkIE3FghXMPvrALLztQYWoRsMVg=;
        b=VmE9M82cWk3Key7cU5CoAuCSQ8I4lQuEmXYEEZpGlMGcSbpbpsD+DL3LJ0sO4ZcYVV
         4eiE3ogp1ZlCC+RFXXS+pspv30mLvd2+XzWN0UjOMnYrDKoLT96cjPW4Qwa1oOUQ9Ljx
         OcoA3IYID2AGeXILSTadpdewkKm5ofu0agQa6oTJMJVqhpviZduOVLW+MhsoMITtSLCA
         xw98Bkkcco2LQhvgeJEcvqOv8QdIUTES6A+Ptdi7EQgH6j0D8q40p2gAKCfkkkbvDzU2
         5v68O9NRnR7NKjh1zcT8Zd0dgy/FrgfaSkgREyDb9Mn4wv5KNQtUcxZJdg6WrEgIEzor
         HE0A==
X-Gm-Message-State: AJIora+EtwaVDIBDHbDk5SR/X56ewHDI8PsK9QA1RodFQbnlFWzqQnp7
        gYLA36m255bfiKgNPRWKYLE=
X-Google-Smtp-Source: AGRyM1uE3AMaS6p9c/1QuEVy1Img7bPKdHFPd1jlHho4x4t63Ntl0QFf/VfZ6rOHd+9BjKfV0YSWEA==
X-Received: by 2002:a05:6a00:cd5:b0:52b:1744:af86 with SMTP id b21-20020a056a000cd500b0052b1744af86mr13957094pfv.19.1658773889923;
        Mon, 25 Jul 2022 11:31:29 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:2c4d:e9cd:d086:4d46])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016be9d498d0sm9740556plh.211.2022.07.25.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:31:29 -0700 (PDT)
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
Subject: [PATCH 2/5] perf lock: Add lock aggregation enum
Date:   Mon, 25 Jul 2022 11:31:21 -0700
Message-Id: <20220725183124.368304-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220725183124.368304-1-namhyung@kernel.org>
References: <20220725183124.368304-1-namhyung@kernel.org>
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
 tools/perf/builtin-lock.c | 114 +++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 1de459198b99..b4e7a6e5c54e 100644
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
@@ -1050,11 +1110,22 @@ static int report_lock_contention_end_event(struct evsel *evsel,
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
 
-	ls = lock_stat_find(addr);
+	ls = lock_stat_find(key);
 	if (!ls)
 		return 0;
 
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
2.37.1.359.gd136c6c3e2-goog

