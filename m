Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2966849BD65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiAYUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiAYUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:46:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA8C061749
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so43746626ybk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=100W4F2SZe3IWptV5RcjIMfgKhxT7aMM0DwnzM2uSwI=;
        b=AtZRyMJoLmRfImn6GijY+LOfXNuW5R979dWq2WEKkjVF5oC8JztYwcYuD2rH/cYe0p
         xiYe8ye9PRjpjWl5ItXl+LHdIwsUlUI5120zvJJsZuykYVj1PrfN1GGKtBQ8RcRSfMZq
         +SOGEc2PV7Wz4dtW5kXTrLPa68rmovr5r4PPcZAHxAYJ0Nd3OcCdvmcFQka3qp3oJBAO
         RVrxhaRUw4oDWPeJJbj3xxN/7NmqykbwzQwqsaKz79O5kFiAcLAEcHBHnb8cWj1MZVFW
         FHYtiMjMxghS6EkcvScsLJrBfT5C2ub634yFZs7q7Aq5RV4ZAZpWYfwq1gqr+ZjVinaA
         l4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=100W4F2SZe3IWptV5RcjIMfgKhxT7aMM0DwnzM2uSwI=;
        b=NILn+/lGCOEG8xZF4u8Ls5YSmVG1EgyjB2XbXm1/jVnCatLELcObZUguZo5YiRxsWj
         JgPJK5VoQtPr91fsroLfsTDj3P90YGT44/S80uygXvd5oEluzgI5w1EBWbGA3IJih2kv
         N1Cr8/XC99IPlQjvw51K0OFeGM1Bzeff/8JuDyBZT9PIiUYv3XYHhrPz40uJkb94MSzj
         kgQO88g5Q5MD5GM9UGXPHmXZkC16E6hlk6/jibz5N8i5c9xsmCjqvveZUyuwg11hTTFm
         NwWqi1pX1OoJPGjB2wqeuJV2+R3PgiXEZ4VeNql8HhcDUgt7cQXT5yjj/XWCpIrl/BUV
         8Nlw==
X-Gm-Message-State: AOAM531Fu6fjL97se8Z/pcDxVdBQr48P8w4w+MrYG8ipRhqNGDaZjgbJ
        DaB6ku/txVyDVKBKpbf2sAtfIxMtXmNe
X-Google-Smtp-Source: ABdhPJz2AIIoZgVx9s5C8xIPQXRhGrzFQOIyFCz9l/0X/Qe4+Z88KgE1Z4u1cAGgzmMAEZwt+iZ+joHSwBBP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1a99:924a:8878:c44a])
 (user=irogers job=sendgmr) by 2002:a25:a102:: with SMTP id
 z2mr32541998ybh.100.1643143572035; Tue, 25 Jan 2022 12:46:12 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:46:00 -0800
In-Reply-To: <20220125204602.4137477-1-irogers@google.com>
Message-Id: <20220125204602.4137477-3-irogers@google.com>
Mime-Version: 1.0
References: <20220125204602.4137477-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2 2/4] perf dso: Make lock error check and add BUG_ONs
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the pthread mutex on dso use the error check type. This allows
deadlock checking via the return type. Assert the returned value from
mutex lock is always 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 12 +++++++++---
 tools/perf/util/symbol.c |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9cc8a1772b4b..6beccffeef7b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -784,7 +784,7 @@ dso_cache__free(struct dso *dso)
 	struct rb_root *root = &dso->data.cache;
 	struct rb_node *next = rb_first(root);
 
-	pthread_mutex_lock(&dso->lock);
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	while (next) {
 		struct dso_cache *cache;
 
@@ -830,7 +830,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	pthread_mutex_lock(&dso->lock);
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	while (*p != NULL) {
 		u64 end;
 
@@ -1259,6 +1259,8 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 	struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
 
 	if (dso != NULL) {
+		pthread_mutexattr_t lock_attr;
+
 		strcpy(dso->name, name);
 		if (id)
 			dso->id = *id;
@@ -1286,8 +1288,12 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
-		pthread_mutex_init(&dso->lock, NULL);
+		pthread_mutexattr_init(&lock_attr);
+		pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
+		pthread_mutex_init(&dso->lock, &lock_attr);
+		pthread_mutexattr_destroy(&lock_attr);
 		refcount_set(&dso->refcnt, 1);
+
 	}
 
 	return dso;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b2ed3140a1fa..43f47532696f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1783,7 +1783,7 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	pthread_mutex_lock(&dso->lock);
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
-- 
2.35.0.rc0.227.g00780c9af4-goog

