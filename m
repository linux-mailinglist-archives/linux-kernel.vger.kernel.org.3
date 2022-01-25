Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2349BD66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiAYUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiAYUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:46:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4729C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso43799976ybt.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ttw3ezZDXz3Bj8XRopBgxWgM5+jUj8lF7+ns5vhVDzI=;
        b=q9vPMTSBJEIPFSMydYOZD0ou+ODqQP2XwKBHHFSrtjlSHcmC9J/wEx8GIPkmUXLq8r
         xAFbn9jg6LgL03xx8Wbw0xKUyr7Zvfd8u2YK+ajPGIFuhzqRH6Kgc+ubkfclW+aD1ho0
         7374Wh71EihFa3vJriEMdBO6t/9mgjV8lPZ1DsnM8ha7bI8MrkBhLmXfLaquGoeHAHFw
         ZXn/7x3WsVCfpgq+/Eundzc1eHkxRUk9ETDNR6XX93J9FTBIQNpPKaOsFrJEKcX8VypX
         Wipfk+09v3YiGaF0eaDjwWMv/JFt3EP+SfLA2CtIDCruo9X3IDLxTi0EmyqMqc6wpogr
         ubyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ttw3ezZDXz3Bj8XRopBgxWgM5+jUj8lF7+ns5vhVDzI=;
        b=Z3wzLH8gWpY1kC+iSpGHIqZxnRQ8SzlyaClV8V4oJx2pdpcK0R0sDUKYbRj2yRxb+D
         Crss69OFThR9I2LntD60dt46VfmR6+5bXfCxMn5iSQTQoXRNLTeahwEQmm42vjddf2NA
         +YPdO2keLtnPSMzNUiKbTIE+EWLLk5T84O5VVS9CnRvrxn6gnE4ZO15zwoY8g/bU3qQu
         EqEKZcvii57U8KBn0M+7wY/mIFPezN6i//T+wRGctck0zzS4WT9Qagn3ke3JmGHCd64p
         un3s9A/kwdyoKjvY0zzxiYOfpouQphpFsqVuM7Vm729aiVMhKDOBTTS3++NLf0zcKAu3
         oxDA==
X-Gm-Message-State: AOAM532kdPlydSotTqM9klY1xrKpVNQLaRPXlYDudukt6AJSZWftGHcC
        Sy0LWm2Cmgqq2LhgCyA981IR5kHIv08l
X-Google-Smtp-Source: ABdhPJxz475DQvm3Ccjx6M6G/w3kNupgMy08j/dfoAoF5agDnv2WwaHQH+svvED7I/79eEm2U9W7U4khslx1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1a99:924a:8878:c44a])
 (user=irogers job=sendgmr) by 2002:a81:1906:0:b0:2ca:287c:6c58 with SMTP id
 00721157ae682-2ca287c6ea4mr6642117b3.253.1643143574688; Tue, 25 Jan 2022
 12:46:14 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:46:01 -0800
In-Reply-To: <20220125204602.4137477-1-irogers@google.com>
Message-Id: <20220125204602.4137477-4-irogers@google.com>
Mime-Version: 1.0
References: <20220125204602.4137477-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2 3/4] perf dso: Hold lock when accessing nsinfo
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

There may be threads racing to update dso->nsinfo:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Holding the dso->lock avoids use-after-free, memory leaks and other
such bugs. Apply the fix in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
of there being a missing nsinfo__put now that the accesses are data race
free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   | 4 ++++
 tools/perf/util/dso.c         | 5 ++++-
 tools/perf/util/map.c         | 3 +++
 tools/perf/util/probe-event.c | 2 ++
 tools/perf/util/symbol.c      | 2 +-
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index fbf43a454cba..bede332bf0e2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -363,8 +363,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	if (dso) {
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		pthread_mutex_unlock(&dso->lock);
 	} else
 		nsinfo__put(nsi);
 
@@ -547,7 +549,9 @@ static int dso__read_build_id(struct dso *dso)
 	if (dso->has_build_id)
 		return 0;
 
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	pthread_mutex_unlock(&dso->lock);
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
 	nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6beccffeef7b..b2f570adba35 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -548,8 +548,11 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	int fd;
 	struct nscookie nsc;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 		nsinfo__mountns_enter(dso->nsinfo, &nsc);
+		pthread_mutex_unlock(&dso->lock);
+	}
 	fd = __open_dso(dso, machine);
 	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
 		nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8af693d9678c..ae99b52502d5 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -192,7 +192,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		pthread_mutex_unlock(&dso->lock);
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(dso, bid);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a834918a0a0d..7444e689ece7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -180,8 +180,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 
 		map = dso__new_map(target);
 		if (map && map->dso) {
+			BUG_ON(pthread_mutex_lock(&map->dso->lock) != 0);
 			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+			pthread_mutex_unlock(&map->dso->lock);
 		}
 		return map;
 	} else {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 43f47532696f..a504346feb05 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1774,6 +1774,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char newmapname[PATH_MAX];
 	const char *map_path = dso->long_name;
 
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
@@ -1783,7 +1784,6 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
-- 
2.35.0.rc0.227.g00780c9af4-goog

