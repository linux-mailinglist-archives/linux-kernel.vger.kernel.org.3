Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F29C481A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhL3HXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhL3HWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:14 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F71BC061394
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:14 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o4-20020a05620a2a0400b0046dbce64beaso13783646qkp.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z9Tf8Q4+BM5aumLuJFIjYqIwLRxLkiAzP1niqb/X+d4=;
        b=MXT7SOzW3mUO/kIlAAQ1kcE1y8TLKmLvjCZQz/QOX3ep0WbLoS3Law/ePU1YrUpVE8
         xRU0Z9yjFElnlqxBOpCu4x25LofrmfWuiN8sThs5JRDgUCHo6B6/ceEZngmkDoxK5c59
         mUJUyYJ5c1JksoFFiGij8J5BiTp15Pzvr5Znk9OzhqEZuNTI50rmvdtwAncFrqajsvzt
         DuvLPjm9dRoAEycbkTbmRCBMb3aWICHWKiVWoOSD7XXcr8L3kXJ3qjbbeSumO9ijpPoe
         vZBYNHiHOoIaoYh2yWmayyLQVl5qbkoF+/VgPTkPvqJKz5baYe4GzheldNdKV1JQbXA+
         6luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z9Tf8Q4+BM5aumLuJFIjYqIwLRxLkiAzP1niqb/X+d4=;
        b=mofS1mg/H5krQ3fw3Zq1YN33ZvNeDJRiTHzZBsbY8uhrtniW1nQ6ckJMcku+Ek1YSz
         ojQRNSRNV4dw3EL9LifHTQ0Fko6ghTlTwdezlQwAIExJVDrXkeG95aqf0RQQFlZ1wc7t
         CSA75AjhqxRKm0ITmlWVPEwGpsc7EgMPz/4wviNyCLu8yPSCf/Ostb12NFLUDsZ0AKL1
         qK4TO3IE+pKgXZq8xi72ee3kljRjHGH1kacJQ78er3r/TTpd+X0RQzzIqktYFSB814Kc
         oZc890HafZdvrX4TI9ZJLf5KCgABJpGzpq6TdPs/NAJgRe1fjkuCO4tb0u9y8VERzgTW
         D0og==
X-Gm-Message-State: AOAM531Ti/l9cdZjlKBFuVQoq2gEPRYwxnI+SOGOgBaAngc+fKb1xtot
        CttewRuB3KofMqFU+4ZyDlQLxbRsjisv
X-Google-Smtp-Source: ABdhPJyriU9EL/kaz5i6TWu0zvPwflHtymroAnCGFGjX5zO6Eb+Ly8LdUtfYPsbD0NzuYcHoLBLChDPV+Ita
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a05:622a:1790:: with SMTP id
 s16mr25339654qtk.634.1640848933373; Wed, 29 Dec 2021 23:22:13 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:20 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-40-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 38/48] perf evsel: Reduce scope of evsel__ignore_missing_thread
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to being static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 8 ++++----
 tools/perf/util/evsel.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4b3ba4408af2..8911ebde54d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1666,10 +1666,10 @@ static int update_fds(struct evsel *evsel,
 	return 0;
 }
 
-bool evsel__ignore_missing_thread(struct evsel *evsel,
-				  int nr_cpus, int cpu,
-				  struct perf_thread_map *threads,
-				  int thread, int err)
+static bool evsel__ignore_missing_thread(struct evsel *evsel,
+					 int nr_cpus, int cpu,
+					 struct perf_thread_map *threads,
+					 int thread, int err)
 {
 	pid_t ignore_pid = perf_thread_map__pid(threads, thread);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c3db41282400..84e597f6c395 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -301,10 +301,6 @@ bool evsel__detect_missing_features(struct evsel *evsel);
 enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
 bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
 
-bool evsel__ignore_missing_thread(struct evsel *evsel,
-				  int nr_cpus, int cpu,
-				  struct perf_thread_map *threads,
-				  int thread, int err);
 bool evsel__precise_ip_fallback(struct evsel *evsel);
 
 struct perf_sample;
-- 
2.34.1.448.ga2b2bfdf31-goog

