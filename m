Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695445968C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiHQFjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiHQFjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A835208E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334228502a8so46272127b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=nFjjywYL+BVjt5EDUuhdhFDZkG96RDHku4lEiPwRqSM=;
        b=DY963OWNxbUetRHL/zVLldA9FoKtyoCuJj5av8/bni8HuabvoELzPFFmjhpQlDSZdm
         OSOeUg615k9F4HcUcvzSKEM05MsmcIqWYixSKqrzPQvZbtajf8wwkbZCbXUhwJqr3fND
         TgMkiwHIUn61iXvBYj/h08fm0qtwu35t/7AopPODtQCqszGMUvsegiIYG6mdBEN8kwbl
         mZyXAf5EghM28D8MJaot1nIAmoUOXJFk9VM+gKpLuLanNhiyq8VCr3eqtuInW8ncXzb8
         7ThAyVLtqSbedCRujaH6y/B9jG+RJlkbinII3b88rj1/oanhaMJlYioHzQgRUFKpBHaQ
         VzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=nFjjywYL+BVjt5EDUuhdhFDZkG96RDHku4lEiPwRqSM=;
        b=bU0/xYJuRmROx3JA8b2JLXXrrrl9s+8HzRxK29MMGcxFfdu4N778H9jIIlGTUGqXuC
         Wa9x5PYe5JYvBnU9Rx5+DbPeLddSW3Gml9nDJt5rKS2iZ5T1td3wH2o0/LHgFXmE6VSf
         ZTa/7bqg+kvorGC0HBj1UzYNwNe5ozEEGeZQdko2go50GYS+G5jlWFPU7aGPUTwVRBCW
         SpdIdx3hr+5VeGB9yiVgfJ3+l6s22m0faIfAqi6FhcLnhRqQLQIe5ZzawizI2u1vcwK9
         HM2WurwVeLsDcfOq6CnohHjZwOrpgX9Ia2RIUsTUSYp9TythdNsSXquIIVGxZlP3O+vF
         JSyw==
X-Gm-Message-State: ACgBeo3jHN3w03MIdPZl1QvBFO1FEqxxGl7x+xfUJOyBhHLeHPZnqvue
        a+Yn3PeHkfg0ugAYCy7hWVtbKbgCUXlD
X-Google-Smtp-Source: AA6agR6uvHiEAD8FKpS5Zq1mVo2EGqf4MDZxVAHCk2jlM44oEFgnPYVVKCVce46t56k7uUnIbgXr3gRUTs5f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a25:b5c9:0:b0:67b:a397:5e24 with SMTP id
 d9-20020a25b5c9000000b0067ba3975e24mr17396936ybg.108.1660714777306; Tue, 16
 Aug 2022 22:39:37 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:25 -0700
In-Reply-To: <20220817053930.769840-1-irogers@google.com>
Message-Id: <20220817053930.769840-2-irogers@google.com>
Mime-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 1/6] perf mutex: Wrapped usage of mutex and cond
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavithra Gurushankar <gpavithrasha@gmail.com>

Added a new header file mutex.h that wraps the usage of
pthread_mutex_t and pthread_cond_t. By abstracting these it is
possible to introduce error checking.

Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build   |  1 +
 tools/perf/util/mutex.c | 97 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mutex.h | 43 ++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9dfae1bda9cc..8fd6dc8de521 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -143,6 +143,7 @@ perf-y += branch.o
 perf-y += mem2node.o
 perf-y += clockid.o
 perf-y += list_sort.o
+perf-y += mutex.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
new file mode 100644
index 000000000000..d12cf0714268
--- /dev/null
+++ b/tools/perf/util/mutex.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mutex.h"
+
+#include "debug.h"
+#include <linux/string.h>
+#include <errno.h>
+
+static void check_err(const char *fn, int err)
+{
+	char sbuf[STRERR_BUFSIZE];
+
+	if (err == 0)
+		return;
+
+	pr_err("%s error: '%s'", fn, str_error_r(err, sbuf, sizeof(sbuf)));
+}
+
+#define CHECK_ERR(err) check_err(__func__, err)
+
+void mutex_init(struct mutex *mtx, bool pshared)
+{
+	pthread_mutexattr_t attr;
+
+	CHECK_ERR(pthread_mutexattr_init(&attr));
+
+#ifndef NDEBUG
+	/* In normal builds enable error checking, such as recursive usage. */
+	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
+#endif
+	if (pshared)
+		pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+
+	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
+	CHECK_ERR(pthread_mutexattr_destroy(&attr));
+}
+
+void mutex_destroy(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_destroy(&mtx->lock));
+}
+
+void mutex_lock(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
+}
+
+void mutex_unlock(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
+}
+
+bool mutex_trylock(struct mutex *mtx)
+{
+	int ret = pthread_mutex_trylock(&mtx->lock);
+
+	if (ret == 0)
+		return true; /* Lock acquired. */
+
+	if (ret == EBUSY)
+		return false; /* Lock busy. */
+
+	/* Print error. */
+	CHECK_ERR(ret);
+	return false;
+}
+
+void cond_init(struct cond *cnd, bool pshared)
+{
+	pthread_condattr_t attr;
+
+	CHECK_ERR(pthread_condattr_init(&attr));
+	if (pshared)
+		CHECK_ERR(pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
+
+	CHECK_ERR(pthread_cond_init(&cnd->cond, &attr));
+	CHECK_ERR(pthread_condattr_destroy(&attr));
+}
+
+void cond_destroy(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_destroy(&cnd->cond));
+}
+
+void cond_wait(struct cond *cnd, struct mutex *mtx)
+{
+	CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
+}
+
+void cond_signal(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_signal(&cnd->cond));
+}
+
+void cond_broadcast(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_broadcast(&cnd->cond));
+}
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
new file mode 100644
index 000000000000..952276ad83bd
--- /dev/null
+++ b/tools/perf/util/mutex.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_MUTEX_H
+#define __PERF_MUTEX_H
+
+#include <pthread.h>
+#include <stdbool.h>
+
+/*
+ * A wrapper around the mutex implementation that allows perf to error check
+ * usage, etc.
+ */
+struct mutex {
+	pthread_mutex_t lock;
+};
+
+/* A wrapper around the condition variable implementation. */
+struct cond {
+	pthread_cond_t cond;
+};
+
+/*
+ * Initialize the mtx struct, if pshared is set then specify the process-shared
+ * rather than default process-private attribute.
+ */
+void mutex_init(struct mutex *mtx, bool pshared);
+void mutex_destroy(struct mutex *mtx);
+
+void mutex_lock(struct mutex *mtx);
+void mutex_unlock(struct mutex *mtx);
+bool mutex_trylock(struct mutex *mtx);
+
+/*
+ * Initialize the cond struct, if pshared is set then specify the process-shared
+ * rather than default process-private attribute.
+ */
+void cond_init(struct cond *cnd, bool pshared);
+void cond_destroy(struct cond *cnd);
+
+void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_signal(struct cond *cnd);
+void cond_broadcast(struct cond *cnd);
+
+#endif /* __PERF_MUTEX_H */
-- 
2.37.1.595.g718a3a8f04-goog

