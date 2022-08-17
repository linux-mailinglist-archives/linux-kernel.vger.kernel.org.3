Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8095968BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiHQFj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiHQFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E05283D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-32a115757b6so139686057b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=QvlPD26rc1/ez9TK6XVR+aAU4WfudIohtAURVoM42AY=;
        b=oyGzJr1a9wSJ05iJdCn/kk9g+hzlMPzE/aDBspUMLFnT9ghiGfpSP+xGQ/Kuw+WNQp
         L3rkVWYehwGF/UgvRkqLB7tloY4hdr7IhSsX6n2xSA0vnaoA3I0ZcvqjQYvvfvVRRHA2
         hC7+iuYwrq7FEAkJ+nVUqJCnY2KoUNoLqkzMGAaL6oOBvoOkSFbZ3QmOjy0SfcQ5SRRU
         KP0OQAy3DrSOrOLd5J3PQWli4hVtG1J2ggur+iznf1vjIzlHWwf+naD4+77s7DuIZpi8
         5wjxejxkT55DFyixFf6vwCLT9JVIAnQsco63LOlwSz4gtLY3HF8RrFe4jyGVIJ9YWEor
         5ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=QvlPD26rc1/ez9TK6XVR+aAU4WfudIohtAURVoM42AY=;
        b=lChUjALaiFOpMOyfW47HoQbNbzOQOU9YbCRFX0yUD6sjUWkaN7PYSTVpFRioDqgpuG
         eBVaAUjFERgSx5diYw6b4rMhkdPRyes5RGt7eiN8xohEdKFZJU0ptfKXWzB9NdRXbYcc
         6O0ervlSSVjViyhaV0lcZq4711q+Nz5p4IRTvbu4A4fwUtaHSXldL0SIpLQMW5UiUFUn
         aG0joWAGiQ670eV9YtT3aY8FOrfw8nO07tjlVEdpXpl5P9/7flaZaqvgKvkZYzb1CcHU
         gP0HTbPFLr8pIbz7f+WJALGyTQwZ9kDtoyOFzHNr2Nk7uIPXpLaV8Mj/UpUhfxekefw1
         pMUQ==
X-Gm-Message-State: ACgBeo2aM/6qvzV2M8LiDcVa8SrdyHi7tC+ZOxEGXw3IoKepFUam03sy
        isq0bMzoxNdc7beg7eVr/MBhLBcF3FuT
X-Google-Smtp-Source: AA6agR5xSiQ5hXNj619DTu0KSJJb1Di6CDQ+3Qe0PWWdx0Bk8cs8NtUJGoPlzksK6JTTWK1DlsQYgJTl4Rh5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a25:b986:0:b0:671:a73:1ea6 with SMTP id
 r6-20020a25b986000000b006710a731ea6mr17925638ybg.405.1660714780300; Tue, 16
 Aug 2022 22:39:40 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:26 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-3-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 2/6] perf mutex: Update use of pthread mutex/cond
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavithra Gurushankar <gpavithrasha@gmail.com>

pthread_mutex_t and pthread_cond_t were replaced with the new wrapped
struct/functions. To avoid default initialization values, use of
PTHREAD_MUTEX_INITIALIZER was replaced with mutex_init/destroy. This
wasn't done for dso__data_open_lock due to no clear early initialization
code.

Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/epoll-ctl.c               | 33 ++++----
 tools/perf/bench/epoll-wait.c              | 33 ++++----
 tools/perf/bench/futex-hash.c              | 33 ++++----
 tools/perf/bench/futex-lock-pi.c           | 33 ++++----
 tools/perf/bench/futex-requeue.c           | 33 ++++----
 tools/perf/bench/futex-wake-parallel.c     | 33 ++++----
 tools/perf/bench/futex-wake.c              | 33 ++++----
 tools/perf/bench/numa.c                    | 93 ++++++++--------------
 tools/perf/builtin-lock.c                  |  1 -
 tools/perf/builtin-record.c                | 13 ++-
 tools/perf/builtin-sched.c                 | 67 ++++++++--------
 tools/perf/builtin-top.c                   | 40 +++++-----
 tools/perf/tests/mmap-basic.c              |  2 -
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/perf-record.c             |  2 -
 tools/perf/ui/browser.c                    | 20 ++---
 tools/perf/ui/browsers/annotate.c          | 12 +--
 tools/perf/ui/setup.c                      |  5 +-
 tools/perf/ui/tui/helpline.c               |  5 +-
 tools/perf/ui/tui/progress.c               |  8 +-
 tools/perf/ui/tui/setup.c                  |  8 +-
 tools/perf/ui/tui/util.c                   | 18 ++---
 tools/perf/ui/ui.h                         |  4 +-
 tools/perf/util/annotate.c                 | 13 ++-
 tools/perf/util/annotate.h                 |  4 +-
 tools/perf/util/bpf-event.h                |  1 -
 tools/perf/util/dso.c                      | 12 +--
 tools/perf/util/dso.h                      |  4 +-
 tools/perf/util/hist.c                     |  6 +-
 tools/perf/util/hist.h                     |  4 +-
 tools/perf/util/mmap.h                     |  1 -
 tools/perf/util/symbol.c                   |  4 +-
 tools/perf/util/top.h                      |  5 +-
 33 files changed, 281 insertions(+), 304 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 4256dc5d6236..82309add47d1 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <perf/cpumap.h>
 
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
@@ -58,10 +59,10 @@ static unsigned int nested = 0;
 /* amount of fds to monitor, per thread */
 static unsigned int nfds = 64;
 
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats all_stats[EPOLL_NR_OPS];
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -174,12 +175,12 @@ static void *workerfn(void *arg)
 	struct timespec ts = { .tv_sec = 0,
 			       .tv_nsec = 250 };
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	/* Let 'em loose */
 	do {
@@ -367,9 +368,9 @@ int bench_epoll_ctl(int argc, const char **argv)
 	for (i = 0; i < EPOLL_NR_OPS; i++)
 		init_stats(&all_stats[i]);
 
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	threads_starting = nthreads;
 
@@ -377,11 +378,11 @@ int bench_epoll_ctl(int argc, const char **argv)
 
 	do_threads(worker, cpu);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(nsecs);
 	toggle_done(0, NULL, NULL);
@@ -394,9 +395,9 @@ int bench_epoll_ctl(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
 		unsigned long t[EPOLL_NR_OPS];
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 2728b0140853..2ed20c55105d 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -79,6 +79,7 @@
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
+#include "../util/mutex.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
 
@@ -109,10 +110,10 @@ static bool multiq; /* use an epoll instance per thread */
 /* amount of fds to monitor, per thread */
 static unsigned int nfds = 64;
 
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -189,12 +190,12 @@ static void *workerfn(void *arg)
 	int to = nonblocking? 0 : -1;
 	int efd = multiq ? w->epollfd : epollfd;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		/*
@@ -485,9 +486,9 @@ int bench_epoll_wait(int argc, const char **argv)
 	       getpid(), nthreads, oneshot ? " (EPOLLONESHOT semantics)": "", nfds, nsecs);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	threads_starting = nthreads;
 
@@ -495,11 +496,11 @@ int bench_epoll_wait(int argc, const char **argv)
 
 	do_threads(worker, cpu);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	/*
 	 * At this point the workers should be blocked waiting for read events
@@ -522,9 +523,9 @@ int bench_epoll_wait(int argc, const char **argv)
 		err(EXIT_FAILURE, "pthread_join");
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	/* sort the array back before reporting */
 	if (randomize)
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index f05db4cf983d..b564ff7ba9a0 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -23,6 +23,7 @@
 #include <sys/mman.h>
 #include <perf/cpumap.h>
 
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
@@ -34,10 +35,10 @@ static bool done = false;
 static int futex_flag = 0;
 
 struct timeval bench__start, bench__end, bench__runtime;
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -73,12 +74,12 @@ static void *workerfn(void *arg)
 	unsigned int i;
 	unsigned long ops = w->ops; /* avoid cacheline bouncing */
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		for (i = 0; i < params.nfutexes; i++, ops++) {
@@ -165,9 +166,9 @@ int bench_futex_hash(int argc, const char **argv)
 	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shared":"private", params.runtime);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
@@ -203,11 +204,11 @@ int bench_futex_hash(int argc, const char **argv)
 	CPU_FREE(cpuset);
 	pthread_attr_destroy(&thread_attr);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
@@ -219,9 +220,9 @@ int bench_futex_hash(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 0abb3f7ee24f..106b5554030f 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -8,6 +8,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,10 +35,10 @@ static u_int32_t global_futex = 0;
 static struct worker *worker;
 static bool done = false;
 static int futex_flag = 0;
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 static struct bench_futex_parameters params = {
 	.runtime  = 10,
@@ -83,12 +84,12 @@ static void *workerfn(void *arg)
 	struct worker *w = (struct worker *) arg;
 	unsigned long ops = w->ops;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		int ret;
@@ -197,9 +198,9 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	       getpid(), params.nthreads, params.runtime);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
@@ -208,11 +209,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	create_threads(worker, thread_attr, cpu);
 	pthread_attr_destroy(&thread_attr);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
@@ -224,9 +225,9 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index b6faabfafb8e..d09509289f1d 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -15,6 +15,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,8 +35,8 @@ static u_int32_t futex1 = 0, futex2 = 0;
 
 static pthread_t *worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
@@ -82,12 +83,12 @@ static void *workerfn(void *arg __maybe_unused)
 {
 	int ret;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) {
 		if (!params.pi) {
@@ -209,9 +210,9 @@ int bench_futex_requeue(int argc, const char **argv)
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		unsigned int nrequeued = 0, wakeups = 0;
@@ -221,11 +222,11 @@ int bench_futex_requeue(int argc, const char **argv)
 		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -297,9 +298,9 @@ int bench_futex_requeue(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index e47f46a3a47e..5eb2e5a2a813 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -10,6 +10,7 @@
 #include "bench.h"
 #include <linux/compiler.h>
 #include "../util/debug.h"
+#include "../util/mutex.h"
 
 #ifndef HAVE_PTHREAD_BARRIER
 int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe_unused)
@@ -49,8 +50,8 @@ static u_int32_t futex = 0;
 
 static pthread_t *blocked_worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static pthread_barrier_t barrier;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
@@ -125,12 +126,12 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 
 static void *blocked_workerfn(void *arg __maybe_unused)
 {
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) { /* handle spurious wakeups */
 		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
@@ -294,9 +295,9 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	init_stats(&waketime_stats);
 
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		waking_worker = calloc(params.nwakes, sizeof(*waking_worker));
@@ -307,11 +308,11 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		block_threads(blocked_worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -332,9 +333,9 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 201a3555f09a..eb161a755197 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -14,6 +14,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,8 +35,8 @@ static u_int32_t futex1 = 0;
 
 static pthread_t *worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
@@ -65,12 +66,12 @@ static const char * const bench_futex_wake_usage[] = {
 
 static void *workerfn(void *arg __maybe_unused)
 {
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) {
 		if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
@@ -178,9 +179,9 @@ int bench_futex_wake(int argc, const char **argv)
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock, /*pshared=*/false);
+	cond_init(&thread_parent, /*pshared=*/false);
+	cond_init(&thread_worker, /*pshared=*/false);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		unsigned int nwoken = 0;
@@ -190,11 +191,11 @@ int bench_futex_wake(int argc, const char **argv)
 		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -224,9 +225,9 @@ int bench_futex_wake(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 20eed1e53f80..934f1fb2d723 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -6,8 +6,6 @@
  */
 
 #include <inttypes.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
@@ -35,6 +33,7 @@
 #include <linux/zalloc.h>
 
 #include "../util/header.h"
+#include "../util/mutex.h"
 #include <numa.h>
 #include <numaif.h>
 
@@ -67,7 +66,7 @@ struct thread_data {
 	u64			system_time_ns;
 	u64			user_time_ns;
 	double			speed_gbs;
-	pthread_mutex_t		*process_lock;
+	struct mutex		*process_lock;
 };
 
 /* Parameters set by options: */
@@ -137,16 +136,16 @@ struct params {
 struct global_info {
 	u8			*data;
 
-	pthread_mutex_t		startup_mutex;
-	pthread_cond_t		startup_cond;
+	struct mutex		startup_mutex;
+	struct cond		startup_cond;
 	int			nr_tasks_started;
 
-	pthread_mutex_t		start_work_mutex;
-	pthread_cond_t		start_work_cond;
+	struct mutex		start_work_mutex;
+	struct cond		start_work_cond;
 	int			nr_tasks_working;
 	bool			start_work;
 
-	pthread_mutex_t		stop_work_mutex;
+	struct mutex		stop_work_mutex;
 	u64			bytes_done;
 
 	struct thread_data	*threads;
@@ -524,30 +523,6 @@ static void * setup_private_data(ssize_t bytes)
 	return alloc_data(bytes, MAP_PRIVATE, 0, g->p.init_cpu0,  g->p.thp, g->p.init_random);
 }
 
-/*
- * Return a process-shared (global) mutex:
- */
-static void init_global_mutex(pthread_mutex_t *mutex)
-{
-	pthread_mutexattr_t attr;
-
-	pthread_mutexattr_init(&attr);
-	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	pthread_mutex_init(mutex, &attr);
-}
-
-/*
- * Return a process-shared (global) condition variable:
- */
-static void init_global_cond(pthread_cond_t *cond)
-{
-	pthread_condattr_t attr;
-
-	pthread_condattr_init(&attr);
-	pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	pthread_cond_init(cond, &attr);
-}
-
 static int parse_cpu_list(const char *arg)
 {
 	p0.cpu_list_str = strdup(arg);
@@ -1220,22 +1195,22 @@ static void *worker_thread(void *__tdata)
 	}
 
 	if (g->p.serialize_startup) {
-		pthread_mutex_lock(&g->startup_mutex);
+		mutex_lock(&g->startup_mutex);
 		g->nr_tasks_started++;
 		/* The last thread wakes the main process. */
 		if (g->nr_tasks_started == g->p.nr_tasks)
-			pthread_cond_signal(&g->startup_cond);
+			cond_signal(&g->startup_cond);
 
-		pthread_mutex_unlock(&g->startup_mutex);
+		mutex_unlock(&g->startup_mutex);
 
 		/* Here we will wait for the main process to start us all at once: */
-		pthread_mutex_lock(&g->start_work_mutex);
+		mutex_lock(&g->start_work_mutex);
 		g->start_work = false;
 		g->nr_tasks_working++;
 		while (!g->start_work)
-			pthread_cond_wait(&g->start_work_cond, &g->start_work_mutex);
+			cond_wait(&g->start_work_cond, &g->start_work_mutex);
 
-		pthread_mutex_unlock(&g->start_work_mutex);
+		mutex_unlock(&g->start_work_mutex);
 	}
 
 	gettimeofday(&start0, NULL);
@@ -1254,17 +1229,17 @@ static void *worker_thread(void *__tdata)
 		val += do_work(thread_data,  g->p.bytes_thread,  0,          1,		l, val);
 
 		if (g->p.sleep_usecs) {
-			pthread_mutex_lock(td->process_lock);
+			mutex_lock(td->process_lock);
 			usleep(g->p.sleep_usecs);
-			pthread_mutex_unlock(td->process_lock);
+			mutex_unlock(td->process_lock);
 		}
 		/*
 		 * Amount of work to be done under a process-global lock:
 		 */
 		if (g->p.bytes_process_locked) {
-			pthread_mutex_lock(td->process_lock);
+			mutex_lock(td->process_lock);
 			val += do_work(process_data, g->p.bytes_process_locked, thread_nr,  g->p.nr_threads,	l, val);
-			pthread_mutex_unlock(td->process_lock);
+			mutex_unlock(td->process_lock);
 		}
 
 		work_done = g->p.bytes_global + g->p.bytes_process +
@@ -1361,9 +1336,9 @@ static void *worker_thread(void *__tdata)
 
 	free_data(thread_data, g->p.bytes_thread);
 
-	pthread_mutex_lock(&g->stop_work_mutex);
+	mutex_lock(&g->stop_work_mutex);
 	g->bytes_done += bytes_done;
-	pthread_mutex_unlock(&g->stop_work_mutex);
+	mutex_unlock(&g->stop_work_mutex);
 
 	return NULL;
 }
@@ -1373,7 +1348,7 @@ static void *worker_thread(void *__tdata)
  */
 static void worker_process(int process_nr)
 {
-	pthread_mutex_t process_lock;
+	struct mutex process_lock;
 	struct thread_data *td;
 	pthread_t *pthreads;
 	u8 *process_data;
@@ -1381,7 +1356,7 @@ static void worker_process(int process_nr)
 	int ret;
 	int t;
 
-	pthread_mutex_init(&process_lock, NULL);
+	mutex_init(&process_lock, /*pshared=*/false);
 	set_taskname("process %d", process_nr);
 
 	/*
@@ -1540,11 +1515,11 @@ static int init(void)
 	g->data = setup_shared_data(g->p.bytes_global);
 
 	/* Startup serialization: */
-	init_global_mutex(&g->start_work_mutex);
-	init_global_cond(&g->start_work_cond);
-	init_global_mutex(&g->startup_mutex);
-	init_global_cond(&g->startup_cond);
-	init_global_mutex(&g->stop_work_mutex);
+	mutex_init(&g->start_work_mutex, /*pshared=*/true);
+	cond_init(&g->start_work_cond, /*pshared=*/true);
+	mutex_init(&g->startup_mutex, /*pshared=*/true);
+	cond_init(&g->startup_cond, /*pshared=*/true);
+	mutex_init(&g->stop_work_mutex, /*pshared=*/true);
 
 	init_thread_data();
 
@@ -1633,17 +1608,17 @@ static int __bench_numa(const char *name)
 		 * Wait for all the threads to start up. The last thread will
 		 * signal this process.
 		 */
-		pthread_mutex_lock(&g->startup_mutex);
+		mutex_lock(&g->startup_mutex);
 		while (g->nr_tasks_started != g->p.nr_tasks)
-			pthread_cond_wait(&g->startup_cond, &g->startup_mutex);
+			cond_wait(&g->startup_cond, &g->startup_mutex);
 
-		pthread_mutex_unlock(&g->startup_mutex);
+		mutex_unlock(&g->startup_mutex);
 
 		/* Wait for all threads to be at the start_work_cond. */
 		while (!threads_ready) {
-			pthread_mutex_lock(&g->start_work_mutex);
+			mutex_lock(&g->start_work_mutex);
 			threads_ready = (g->nr_tasks_working == g->p.nr_tasks);
-			pthread_mutex_unlock(&g->start_work_mutex);
+			mutex_unlock(&g->start_work_mutex);
 			if (!threads_ready)
 				usleep(1);
 		}
@@ -1661,10 +1636,10 @@ static int __bench_numa(const char *name)
 
 		start = stop;
 		/* Start all threads running. */
-		pthread_mutex_lock(&g->start_work_mutex);
+		mutex_lock(&g->start_work_mutex);
 		g->start_work = true;
-		pthread_mutex_unlock(&g->start_work_mutex);
-		pthread_cond_broadcast(&g->start_work_cond);
+		mutex_unlock(&g->start_work_mutex);
+		cond_broadcast(&g->start_work_cond);
 	} else {
 		gettimeofday(&start, NULL);
 	}
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index dd11d3471baf..70197c0593b1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -28,7 +28,6 @@
 #include <sys/types.h>
 #include <sys/prctl.h>
 #include <semaphore.h>
-#include <pthread.h>
 #include <math.h>
 #include <limits.h>
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..02eb85677e99 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -21,6 +21,7 @@
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/mmap.h"
+#include "util/mutex.h"
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
@@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
+static struct mutex synth_lock;
+
 static int process_locked_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
-	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
 	int ret;
 
-	pthread_mutex_lock(&synth_lock);
+	mutex_lock(&synth_lock);
 	ret = process_synthesized_event(tool, event, sample, machine);
-	pthread_mutex_unlock(&synth_lock);
+	mutex_unlock(&synth_lock);
 	return ret;
 }
 
@@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
+		mutex_init(&synth_lock, /*pshared=*/false);
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
@@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
 						    rec->opts.nr_threads_synthesize);
 	}
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.nr_threads_synthesize > 1) {
 		perf_set_singlethreaded();
+		mutex_destroy(&synth_lock);
+	}
 
 out:
 	return err;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2f6cd1b8b662..0f52f73be896 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -7,6 +7,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
+#include "util/mutex.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
@@ -184,8 +185,8 @@ struct perf_sched {
 	struct task_desc **pid_to_task;
 	struct task_desc **tasks;
 	const struct trace_sched_handler *tp_handler;
-	pthread_mutex_t	 start_work_mutex;
-	pthread_mutex_t	 work_done_wait_mutex;
+	struct mutex	 start_work_mutex;
+	struct mutex	 work_done_wait_mutex;
 	int		 profile_cpu;
 /*
  * Track the current task - that way we can know whether there's any
@@ -635,10 +636,8 @@ static void *thread_func(void *ctx)
 again:
 	ret = sem_post(&this_task->ready_for_work);
 	BUG_ON(ret);
-	ret = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(ret);
-	ret = pthread_mutex_unlock(&sched->start_work_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->start_work_mutex);
+	mutex_unlock(&sched->start_work_mutex);
 
 	cpu_usage_0 = get_cpu_usage_nsec_self(fd);
 
@@ -652,10 +651,8 @@ static void *thread_func(void *ctx)
 	ret = sem_post(&this_task->work_done_sem);
 	BUG_ON(ret);
 
-	ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
-	ret = pthread_mutex_unlock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->work_done_wait_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 
 	goto again;
 }
@@ -672,10 +669,8 @@ static void create_tasks(struct perf_sched *sched)
 	err = pthread_attr_setstacksize(&attr,
 			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
-	err = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(err);
-	err = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(err);
+	mutex_lock(&sched->start_work_mutex);
+	mutex_lock(&sched->work_done_wait_mutex);
 	for (i = 0; i < sched->nr_tasks; i++) {
 		struct sched_thread_parms *parms = malloc(sizeof(*parms));
 		BUG_ON(parms == NULL);
@@ -699,7 +694,7 @@ static void wait_for_tasks(struct perf_sched *sched)
 
 	sched->start_time = get_nsecs();
 	sched->cpu_usage = 0;
-	pthread_mutex_unlock(&sched->work_done_wait_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -707,12 +702,11 @@ static void wait_for_tasks(struct perf_sched *sched)
 		BUG_ON(ret);
 		sem_init(&task->ready_for_work, 0, 0);
 	}
-	ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->work_done_wait_mutex);
 
 	cpu_usage_0 = get_cpu_usage_nsec_parent();
 
-	pthread_mutex_unlock(&sched->start_work_mutex);
+	mutex_unlock(&sched->start_work_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -734,8 +728,7 @@ static void wait_for_tasks(struct perf_sched *sched)
 	sched->runavg_parent_cpu_usage = (sched->runavg_parent_cpu_usage * (sched->replay_repeat - 1) +
 					 sched->parent_cpu_usage)/sched->replay_repeat;
 
-	ret = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->start_work_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -3430,8 +3423,6 @@ int cmd_sched(int argc, const char **argv)
 		},
 		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
 		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
-		.start_work_mutex     = PTHREAD_MUTEX_INITIALIZER,
-		.work_done_wait_mutex = PTHREAD_MUTEX_INITIALIZER,
 		.sort_order	      = default_sort_order,
 		.replay_repeat	      = 10,
 		.profile_cpu	      = -1,
@@ -3545,8 +3536,10 @@ int cmd_sched(int argc, const char **argv)
 		.fork_event	    = replay_fork_event,
 	};
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
+	mutex_init(&sched.start_work_mutex, /*pshared=*/false);
+	mutex_init(&sched.work_done_wait_mutex, /*pshared=*/false);
 	for (i = 0; i < ARRAY_SIZE(sched.curr_pid); i++)
 		sched.curr_pid[i] = -1;
 
@@ -3558,11 +3551,10 @@ int cmd_sched(int argc, const char **argv)
 	/*
 	 * Aliased to 'perf script' for now:
 	 */
-	if (!strcmp(argv[0], "script"))
-		return cmd_script(argc, argv);
-
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		return __cmd_record(argc, argv);
+	if (!strcmp(argv[0], "script")) {
+		ret = cmd_script(argc, argv);
+	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+		ret = __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
@@ -3571,7 +3563,7 @@ int cmd_sched(int argc, const char **argv)
 				usage_with_options(latency_usage, latency_options);
 		}
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__lat(&sched);
+		ret = perf_sched__lat(&sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
@@ -3580,7 +3572,7 @@ int cmd_sched(int argc, const char **argv)
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__map(&sched);
+		ret = perf_sched__map(&sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
@@ -3588,7 +3580,7 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		return perf_sched__replay(&sched);
+		ret = perf_sched__replay(&sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3604,16 +3596,21 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "w", true);
 			if (sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = symbol__validate_sym_arguments();
 		if (ret)
-			return ret;
+			goto out;
 
-		return perf_sched__timehist(&sched);
+		ret = perf_sched__timehist(&sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
 
-	return 0;
+out:
+	mutex_destroy(&sched.start_work_mutex);
+	mutex_destroy(&sched.work_done_wait_mutex);
+
+	return ret;
 }
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fd8fd913c533..3757292bfe86 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -136,10 +136,10 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(sym, top->evlist->core.nr_entries)) {
-		pthread_mutex_unlock(&notes->lock);
+		mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
 		sleep(1);
@@ -155,7 +155,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
 	}
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 	return err;
 }
 
@@ -208,19 +208,19 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	notes = symbol__annotation(sym);
 
-	if (pthread_mutex_trylock(&notes->lock))
+	if (!mutex_trylock(&notes->lock))
 		return;
 
 	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 
 	if (unlikely(err)) {
 		/*
 		 * This function is now called with he->hists->lock held.
 		 * Release it before going to sleep.
 		 */
-		pthread_mutex_unlock(&he->hists->lock);
+		mutex_unlock(&he->hists->lock);
 
 		if (err == -ERANGE && !he->ms.map->erange_warned)
 			ui__warn_map_erange(he->ms.map, sym, ip);
@@ -230,7 +230,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 			sleep(1);
 		}
 
-		pthread_mutex_lock(&he->hists->lock);
+		mutex_lock(&he->hists->lock);
 	}
 }
 
@@ -250,7 +250,7 @@ static void perf_top__show_details(struct perf_top *top)
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(symbol, evsel);
 
@@ -271,7 +271,7 @@ static void perf_top__show_details(struct perf_top *top)
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
 out_unlock:
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static void perf_top__resort_hists(struct perf_top *t)
@@ -836,12 +836,12 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		else
 			iter.ops = &hist_iter_normal;
 
-		pthread_mutex_lock(&hists->lock);
+		mutex_lock(&hists->lock);
 
 		if (hist_entry_iter__add(&iter, &al, top->max_stack, top) < 0)
 			pr_err("Problem incrementing symbol period, skipping event\n");
 
-		pthread_mutex_unlock(&hists->lock);
+		mutex_unlock(&hists->lock);
 	}
 
 	addr_location__put(&al);
@@ -893,10 +893,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		perf_mmap__consume(&md->core);
 
 		if (top->qe.rotate) {
-			pthread_mutex_lock(&top->qe.mutex);
+			mutex_lock(&top->qe.mutex);
 			top->qe.rotate = false;
-			pthread_cond_signal(&top->qe.cond);
-			pthread_mutex_unlock(&top->qe.mutex);
+			cond_signal(&top->qe.cond);
+			mutex_unlock(&top->qe.mutex);
 		}
 	}
 
@@ -1100,10 +1100,10 @@ static void *process_thread(void *arg)
 
 		out = rotate_queues(top);
 
-		pthread_mutex_lock(&top->qe.mutex);
+		mutex_lock(&top->qe.mutex);
 		top->qe.rotate = true;
-		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
-		pthread_mutex_unlock(&top->qe.mutex);
+		cond_wait(&top->qe.cond, &top->qe.mutex);
+		mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1217,8 +1217,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.mutex, NULL);
-	pthread_cond_init(&top->qe.cond, NULL);
+	mutex_init(&top->qe.mutex, /*pshared=*/false);
+	cond_init(&top->qe.cond, /*pshared=*/false);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1349,7 +1349,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
-	pthread_cond_signal(&top->qe.cond);
+	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	return ret;
 }
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index dfb6173b2a82..21b5e68179d7 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 90828ae03ef5..f3275be83a33 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -2,7 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 /* For the CPU_* macros */
-#include <pthread.h>
+#include <sched.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6a001fcfed68..b386ade9ed06 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -2,8 +2,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/string.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 
 #include <sched.h>
 #include <perf/mmap.h>
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index fa5bd5c20e96..78fb01d6ad63 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -268,9 +268,9 @@ void __ui_browser__show_title(struct ui_browser *browser, const char *title)
 
 void ui_browser__show_title(struct ui_browser *browser, const char *title)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 int ui_browser__show(struct ui_browser *browser, const char *title,
@@ -284,7 +284,7 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 
 	browser->refresh_dimensions(browser);
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
 
 	browser->title = title;
@@ -295,16 +295,16 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 	va_end(ap);
 	if (err > 0)
 		ui_helpline__push(browser->helpline);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 	return err ? 0 : -1;
 }
 
 void ui_browser__hide(struct ui_browser *browser)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	ui_helpline__pop();
 	zfree(&browser->helpline);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static void ui_browser__scrollbar_set(struct ui_browser *browser)
@@ -352,9 +352,9 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 
 int ui_browser__refresh(struct ui_browser *browser)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui_browser__refresh(browser);
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	return 0;
 }
@@ -390,10 +390,10 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
 	while (1) {
 		off_t offset;
 
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 		err = __ui_browser__refresh(browser);
 		SLsmg_refresh();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 		if (err < 0)
 			break;
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 44ba900828f6..9bc1076374ff 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -8,11 +8,11 @@
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
+#include "../../util/mutex.h"
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include <inttypes.h>
-#include <pthread.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -319,7 +319,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 	browser->entries = RB_ROOT;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	symbol__calc_percent(sym, evsel);
 
@@ -348,7 +348,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 		disasm_rb_tree__insert(browser, &pos->al);
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 
 	browser->curr_hot = rb_last(&browser->entries);
 }
@@ -474,10 +474,10 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	notes = symbol__annotation(dl->ops.target.sym);
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 
 	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr_entries)) {
-		pthread_mutex_unlock(&notes->lock);
+		mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
 		return true;
@@ -486,7 +486,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.maps = ms->maps;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 	symbol__tui_annotate(&target_ms, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 700335cde618..fd10dc6baf07 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <pthread.h>
 #include <dlfcn.h>
 #include <unistd.h>
 
@@ -8,7 +7,7 @@
 #include "../util/hist.h"
 #include "ui.h"
 
-pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
+struct mutex ui__lock;
 void *perf_gtk_handle;
 int use_browser = -1;
 
@@ -76,6 +75,7 @@ int stdio__config_color(const struct option *opt __maybe_unused,
 
 void setup_browser(bool fallback_to_pager)
 {
+	mutex_init(&ui__lock, /*pshared=*/false);
 	if (use_browser < 2 && (!isatty(1) || dump_trace))
 		use_browser = 0;
 
@@ -118,4 +118,5 @@ void exit_browser(bool wait_for_ok)
 	default:
 		break;
 	}
+	mutex_destroy(&ui__lock);
 }
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 298d6af82fdd..db4952f5990b 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -2,7 +2,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <pthread.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 
@@ -33,7 +32,7 @@ static int tui_helpline__show(const char *format, va_list ap)
 	int ret;
 	static int backlog;
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	ret = vscnprintf(ui_helpline__last_msg + backlog,
 			sizeof(ui_helpline__last_msg) - backlog, format, ap);
 	backlog += ret;
@@ -45,7 +44,7 @@ static int tui_helpline__show(const char *format, va_list ap)
 		SLsmg_refresh();
 		backlog = 0;
 	}
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	return ret;
 }
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index 3d74af5a7ece..71b6c8d9474f 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -45,7 +45,7 @@ static void tui_progress__update(struct ui_progress *p)
 	}
 
 	ui__refresh_dimensions(false);
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	y = SLtt_Screen_Rows / 2 - 2;
 	SLsmg_set_color(0);
 	SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
@@ -56,7 +56,7 @@ static void tui_progress__update(struct ui_progress *p)
 	bar = ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
 	SLsmg_fill_region(y, 1, 1, bar, ' ');
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static void tui_progress__finish(void)
@@ -67,12 +67,12 @@ static void tui_progress__finish(void)
 		return;
 
 	ui__refresh_dimensions(false);
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	y = SLtt_Screen_Rows / 2 - 2;
 	SLsmg_set_color(0);
 	SLsmg_fill_region(y, 0, 3, SLtt_Screen_Cols, ' ');
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 static struct ui_progress_ops tui_progress__ops = {
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index b1be59b4e2a4..a3b8c397c24d 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -29,10 +29,10 @@ void ui__refresh_dimensions(bool force)
 {
 	if (force || ui__need_resize) {
 		ui__need_resize = 0;
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 		SLtt_get_screen_size();
 		SLsmg_reinit_smg();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 	}
 }
 
@@ -170,10 +170,10 @@ void ui__exit(bool wait_for_ok)
 				    "Press any key...", 0);
 
 	SLtt_set_cursor_visibility(1);
-	if (!pthread_mutex_trylock(&ui__lock)) {
+	if (mutex_trylock(&ui__lock)) {
 		SLsmg_refresh();
 		SLsmg_reset_smg();
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 	}
 	SLang_reset_tty();
 	perf_error__unregister(&perf_tui_eops);
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 0f562e2cb1e8..3c5174854ac8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -95,7 +95,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 		t = sep + 1;
 	}
 
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 
 	max_len += 2;
 	nr_lines += 8;
@@ -125,17 +125,17 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	SLsmg_write_nstring((char *)exit_msg, max_len);
 	SLsmg_refresh();
 
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 
 	x += 2;
 	len = 0;
 	key = ui__getch(delay_secs);
 	while (key != K_TIMER && key != K_ENTER && key != K_ESC) {
-		pthread_mutex_lock(&ui__lock);
+		mutex_lock(&ui__lock);
 
 		if (key == K_BKSPC) {
 			if (len == 0) {
-				pthread_mutex_unlock(&ui__lock);
+				mutex_unlock(&ui__lock);
 				goto next_key;
 			}
 			SLsmg_gotorc(y, x + --len);
@@ -147,7 +147,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 		}
 		SLsmg_refresh();
 
-		pthread_mutex_unlock(&ui__lock);
+		mutex_unlock(&ui__lock);
 
 		/* XXX more graceful overflow handling needed */
 		if (len == sizeof(buf) - 1) {
@@ -215,19 +215,19 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
 
 void ui__info_window(const char *title, const char *text)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui__info_window(title, text, NULL);
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 }
 
 int ui__question_window(const char *title, const char *text,
 			const char *exit_msg, int delay_secs)
 {
-	pthread_mutex_lock(&ui__lock);
+	mutex_lock(&ui__lock);
 	__ui__info_window(title, text, exit_msg);
 	SLsmg_refresh();
-	pthread_mutex_unlock(&ui__lock);
+	mutex_unlock(&ui__lock);
 	return ui__getch(delay_secs);
 }
 
diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
index 9b6fdf06e1d2..99f8d2fe9bc5 100644
--- a/tools/perf/ui/ui.h
+++ b/tools/perf/ui/ui.h
@@ -2,11 +2,11 @@
 #ifndef _PERF_UI_H_
 #define _PERF_UI_H_ 1
 
-#include <pthread.h>
+#include "../util/mutex.h"
 #include <stdbool.h>
 #include <linux/compiler.h>
 
-extern pthread_mutex_t ui__lock;
+extern struct mutex ui__lock;
 extern void *perf_gtk_handle;
 
 extern int use_browser;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2c6a485c3de5..29d804d76145 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -35,7 +35,6 @@
 #include "arch/common.h"
 #include "namespaces.h"
 #include <regex.h>
-#include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -821,7 +820,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
@@ -829,7 +828,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 			memset(notes->src->cycles_hist, 0,
 				symbol__size(sym) * sizeof(struct cyc_hist));
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 static int __symbol__account_cycles(struct cyc_hist *ch,
@@ -1086,7 +1085,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 	notes->hit_insn = 0;
 	notes->cover_insn = 0;
 
-	pthread_mutex_lock(&notes->lock);
+	mutex_lock(&notes->lock);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
@@ -1105,7 +1104,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			notes->have_cycles = true;
 		}
 	}
-	pthread_mutex_unlock(&notes->lock);
+	mutex_unlock(&notes->lock);
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
@@ -1258,13 +1257,13 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 
 void annotation__init(struct annotation *notes)
 {
-	pthread_mutex_init(&notes->lock, NULL);
+	mutex_init(&notes->lock, /*pshared=*/false);
 }
 
 void annotation__exit(struct annotation *notes)
 {
 	annotated_source__delete(notes->src);
-	pthread_mutex_destroy(&notes->lock);
+	mutex_destroy(&notes->lock);
 }
 
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 986f2bbe4870..3cbd883e4d7a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -8,9 +8,9 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "mutex.h"
 #include "spark.h"
 
 struct hist_browser_timer;
@@ -273,7 +273,7 @@ struct annotated_source {
 };
 
 struct annotation {
-	pthread_mutex_t		lock;
+	struct mutex lock;
 	u64			max_coverage;
 	u64			start;
 	u64			hit_cycles;
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 144a8a24cc69..1bcbd4fb6c66 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <api/fd/array.h>
 #include <stdio.h>
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5ac13958d1bd..c7a5b42d1311 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
 	struct rb_root *root = &dso->data.cache;
 	struct rb_node *next = rb_first(root);
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (next) {
 		struct dso_cache *cache;
 
@@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
@@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (*p != NULL) {
 		u64 end;
 
@@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 
 	cache = NULL;
 out:
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	return cache;
 }
 
@@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
-		pthread_mutex_init(&dso->lock, NULL);
+		mutex_init(&dso->lock, /*pshared=*/false);
 		refcount_set(&dso->refcnt, 1);
 	}
 
@@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
 	nsinfo__zput(dso->nsinfo);
-	pthread_mutex_destroy(&dso->lock);
+	mutex_destroy(&dso->lock);
 	free(dso);
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 66981c7a9a18..58d94175e714 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_DSO
 #define __PERF_DSO
 
-#include <pthread.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
@@ -11,6 +10,7 @@
 #include <stdio.h>
 #include <linux/bitops.h>
 #include "build-id.h"
+#include "mutex.h"
 
 struct machine;
 struct map;
@@ -145,7 +145,7 @@ struct dso_cache {
 struct auxtrace_cache;
 
 struct dso {
-	pthread_mutex_t	 lock;
+	struct mutex	 lock;
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1c085ab56534..bfce88e5eb0d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1622,13 +1622,13 @@ struct rb_root_cached *hists__get_rotate_entries_in(struct hists *hists)
 {
 	struct rb_root_cached *root;
 
-	pthread_mutex_lock(&hists->lock);
+	mutex_lock(&hists->lock);
 
 	root = hists->entries_in;
 	if (++hists->entries_in > &hists->entries_in_array[1])
 		hists->entries_in = &hists->entries_in_array[0];
 
-	pthread_mutex_unlock(&hists->lock);
+	mutex_unlock(&hists->lock);
 
 	return root;
 }
@@ -2805,7 +2805,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries_in = &hists->entries_in_array[0];
 	hists->entries_collapsed = RB_ROOT_CACHED;
 	hists->entries = RB_ROOT_CACHED;
-	pthread_mutex_init(&hists->lock, NULL);
+	mutex_init(&hists->lock, /*pshared=*/false);
 	hists->socket_filter = -1;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7ed4648d2fc2..508428b2c1b2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -4,10 +4,10 @@
 
 #include <linux/rbtree.h>
 #include <linux/types.h>
-#include <pthread.h>
 #include "evsel.h"
 #include "color.h"
 #include "events_stats.h"
+#include "mutex.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -98,7 +98,7 @@ struct hists {
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
-	pthread_mutex_t		lock;
+	struct mutex		lock;
 	struct hists_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cd8b0777473b..cd4ccec7f361 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
 #include <stdbool.h>
-#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4b22caa7c24..656d9b4dd456 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 1c2c0a838430..a8b0d79bd96c 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "mutex.h"
 #include "ordered-events.h"
 #include "record.h"
 #include <linux/types.h>
@@ -53,8 +54,8 @@ struct perf_top {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
 		bool			 rotate;
-		pthread_mutex_t		 mutex;
-		pthread_cond_t		 cond;
+		struct mutex mutex;
+		struct cond cond;
 	} qe;
 };
 
-- 
2.37.1.595.g718a3a8f04-goog

