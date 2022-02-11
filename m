Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C014B2347
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbiBKKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348950AbiBKKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF0EB4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j17-20020a25ec11000000b0061dabf74012so17894373ybh.15
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+vOkqY9ujgn8jSfYzqg46hBeUg4M5HreQws2W8UcU8Y=;
        b=tPuuDRE6WJC7bnfBoA28dPv83FT6FoKMQeGtZeMSpWXQALL6+dTtChTvyGeC+iT/Nk
         +s+ggMScw3vJsOiWa06ibucn2ixK71ZSDjFQrAaJzMLe3tTONDalV2bBy/DIWdT3Bnaz
         M5HKBclNdOh9ULkPxXrSxPNsAoA+UIDN+61OVLmgIDvHIygcwrzkiDPcSn7qH/fFaaTA
         p2/VQZ245a7r2mXjA/Nxo2ArOnBvWBD9lYCueIBdFBw7zCcAQO/WODyc3MOoW7LtSTBw
         SlUqh3YPj3BmD+kyQkqD8k+K1gUWzPSgtwdecN5ucaNcrGsyMbup8x5jMeq4oQcqws11
         vQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+vOkqY9ujgn8jSfYzqg46hBeUg4M5HreQws2W8UcU8Y=;
        b=DwVI1/8Po4JmHEjlsAR+Mqv35wm5BHNuEiIxtzfzoz7CQ+x5+7asA6tJNOI3eHu2Dj
         +6o/LbGsNMkHfGaJ5MTbVanMpnojvp27v9wVLirXqYXZ/BLX0VvpIpraGid71zs1i+Rs
         1TeHV+XP93NP6NlRtn4HFKxOMsBX/oD+aFKP5GlbGcmgUc8oVbnn4UOdFRVWC6BIKLl5
         RcasUWV/Jtgz3WYFvKNMS2EH9YRLYFoLdQ7AeTQwb1t/u5ZZgJrdVTVc0IxYAvGca5RL
         YOjGrWTXX6fmzH66GqDQCpFNr1wwjqn05INlH/+BsBULVnB5LK1rQRny/+PM1beagrM9
         UZqA==
X-Gm-Message-State: AOAM531XZfptnU//EhfuMcMnT8vvlbRafbzh+Xf0e9SrG0EhFJ/6Z8y4
        jSkWH11PCu5vyWaKGPL2e66UKDcQciX/
X-Google-Smtp-Source: ABdhPJyonsoIUZQUmjbnltCqHmTteIdPLW9jFfUL6XJGAvW1QrRbXzSVJ1ciNuSiL89/bIjjujvp6zxp+ryV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:2155:: with SMTP id
 h82mr645997ybh.606.1644575667809; Fri, 11 Feb 2022 02:34:27 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:56 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-4-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 03/22] perf dso: Make lock error check and add BUG_ONs
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
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
2.35.1.265.g69c8d7142f-goog

