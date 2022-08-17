Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1964E5968BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiHQFkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiHQFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67C67CA3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so138318347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=dvXHlanNSMpb8+NK6h6mlaZdJjvFNZm2U3e/25BiLG8=;
        b=mYp9/Sr/BzctNpEaunppnamILdm+vQXkxgyXNAS6a0QaWmaKLlm25oxAnyn2IJgmtz
         hagzDnnPKhwIAXUv2ZJRYc6IVqAhuRHaPODwh3Q563t+oe1lRL+ErStXbEi+tYxHBYVm
         nOYkDy4xuwbYmK786oVtKub1xhTwScQLqC/olf/AcIja9xAmoFNAO1qun/tLqpY88wfx
         jGc+cEZ5xN7ZWQenIRMnd3rNV0LkdxZXhZuN1mi8DVDhGzh6BkGnKSIbVeO/KfclhoWe
         T2vm6MQAyKt5N0pAEKl2X9GH+ZjBDy2ZaFbCvk15+KpKHTWUJBzLv0Mc4IJ2lKsVojKz
         h4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dvXHlanNSMpb8+NK6h6mlaZdJjvFNZm2U3e/25BiLG8=;
        b=lTzk/ncrWpjkuKj8/nDT4Z76+yqhu21sUmc4lHYPObKj5QeGVQJqBPgYNebqiJ6U51
         LBkHgz8cSPPcFvHhK5V5wtxTD1GUQaHzSFKZCt1+uDwpZ5kCNjScs/mXofQzsOU68RuI
         HCPl+aLKIVTRF28EVNnon3P7u6B2zi4hjMOO24Il87ntMQ8Cs716+RP6ZAo+NuIJzK3k
         RK5YVEmyENoNEwnekchG9LLyhNPPInWpixI8BBzyxlpAHausKbax8/cVx/o44Ay91KbY
         X66Zane1maTjbWKTJ0XvjNFLClkjgTJh6VutBBN8ZdQHajFmIUCWTYLx3zuJrJY1fBd6
         953Q==
X-Gm-Message-State: ACgBeo1a65NOfQZm9EWKs0JD4R+iRTT2gRUkbA8McfWDekK17o6QPrEJ
        nXcSx4YDPBuox7YR3KBXec/4+qE+EBYX
X-Google-Smtp-Source: AA6agR6zSnCmpG7kuPNJMbVm7HIrXY4YLPDkRXnjRDSwn6ZhR4GqOHvFVK+oQ64A8/6nWhOOENcY693gBv1U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a5b:83:0:b0:689:7b36:5307 with SMTP id
 b3-20020a5b0083000000b006897b365307mr10169676ybp.328.1660714785978; Tue, 16
 Aug 2022 22:39:45 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:28 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-5-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 4/6] perf mutex: Add thread safety annotations
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

Add thread safety annotations to struct mutex so that when compiled with
clang's -Wthread-safety warnings are generated for erroneous lock
patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.c |  2 ++
 tools/perf/util/mutex.h | 72 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index d12cf0714268..c936557d8bbb 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -40,11 +40,13 @@ void mutex_destroy(struct mutex *mtx)
 }
 
 void mutex_lock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
 }
 
 void mutex_unlock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
 }
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 952276ad83bd..6c2062d41a4e 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -5,11 +5,73 @@
 #include <pthread.h>
 #include <stdbool.h>
 
+/*
+ * A function-like feature checking macro that is a wrapper around
+ * `__has_attribute`, which is defined by GCC 5+ and Clang and evaluates to a
+ * nonzero constant integer if the attribute is supported or 0 if not.
+ */
+#ifdef __has_attribute
+#define HAVE_ATTRIBUTE(x) __has_attribute(x)
+#else
+#define HAVE_ATTRIBUTE(x) 0
+#endif
+
+
+#if HAVE_ATTRIBUTE(guarded_by) && HAVE_ATTRIBUTE(pt_guarded_by) && \
+	HAVE_ATTRIBUTE(lockable) && HAVE_ATTRIBUTE(exclusive_lock_function) && \
+	HAVE_ATTRIBUTE(exclusive_trylock_function) && HAVE_ATTRIBUTE(exclusive_locks_required) && \
+	HAVE_ATTRIBUTE(no_thread_safety_analysis)
+
+/* Documents if a shared field or global variable needs to be protected by a mutex. */
+#define GUARDED_BY(x) __attribute__((guarded_by(x)))
+
+/*
+ * Documents if the memory location pointed to by a pointer should be guarded by
+ * a mutex when dereferencing the pointer.
+ */
+#define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
+
+/* Documents if a type is a lockable type. */
+#define LOCKABLE __attribute__((capability("lockable")))
+
+/* Documents functions that acquire a lock in the body of a function, and do not release it. */
+#define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
+
+/*
+ * Documents functions that expect a lock to be held on entry to the function,
+ * and release it in the body of the function.
+ */
+#define UNLOCK_FUNCTION(...) __attribute__((unlock_function(__VA_ARGS__)))
+
+/* Documents functions that try to acquire a lock, and return success or failure. */
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
+	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
+
+
+/* Documents a function that expects a mutex to be held prior to entry. */
+#define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
+
+/* Turns off thread safety checking within the body of a particular function. */
+#define NO_THREAD_SAFETY_ANALYSIS __attribute__((no_thread_safety_analysis))
+
+#else
+
+#define GUARDED_BY(x)
+#define PT_GUARDED_BY(x)
+#define LOCKABLE
+#define EXCLUSIVE_LOCK_FUNCTION(...)
+#define UNLOCK_FUNCTION(...)
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...)
+#define EXCLUSIVE_LOCKS_REQUIRED(...)
+#define NO_THREAD_SAFETY_ANALYSIS
+
+#endif
+
 /*
  * A wrapper around the mutex implementation that allows perf to error check
  * usage, etc.
  */
-struct mutex {
+struct LOCKABLE mutex {
 	pthread_mutex_t lock;
 };
 
@@ -25,9 +87,9 @@ struct cond {
 void mutex_init(struct mutex *mtx, bool pshared);
 void mutex_destroy(struct mutex *mtx);
 
-void mutex_lock(struct mutex *mtx);
-void mutex_unlock(struct mutex *mtx);
-bool mutex_trylock(struct mutex *mtx);
+void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
+void mutex_unlock(struct mutex *mtx) UNLOCK_FUNCTION(*mtx);
+bool mutex_trylock(struct mutex *mtx) EXCLUSIVE_TRYLOCK_FUNCTION(true, *mtx);
 
 /*
  * Initialize the cond struct, if pshared is set then specify the process-shared
@@ -36,7 +98,7 @@ bool mutex_trylock(struct mutex *mtx);
 void cond_init(struct cond *cnd, bool pshared);
 void cond_destroy(struct cond *cnd);
 
-void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_wait(struct cond *cnd, struct mutex *mtx) EXCLUSIVE_LOCKS_REQUIRED(mtx);
 void cond_signal(struct cond *cnd);
 void cond_broadcast(struct cond *cnd);
 
-- 
2.37.1.595.g718a3a8f04-goog

