Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A939D484E39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiAEGQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiAEGPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541EC061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so60442493ybb.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z9Tf8Q4+BM5aumLuJFIjYqIwLRxLkiAzP1niqb/X+d4=;
        b=jkujgjBLTT3h9KKEmYDVCkFAPtUkFYS8HCyUVrge2WFiJckFCjZQRaJRCFebsjIrgm
         PY8DEABju9DTjD2PNiEwlMzMjVqttB57+VlG5QUg7/yPPUd/QXz+KnHE7mT2h0UDHvET
         B8fkSNSltuX8zDN40GxhCc3d7iYd/5UKXAclMyf5P9B0JDxBXnUWJeut6dYQMcpHr3Cy
         PI8h5t1+2ks0vLmUTH6tECasa4+ZYgaMN0s7gprIv+wPXNaP2SoF0TkUNKdIgpA/9OPo
         7rnORPwJdfdlldewDdZ+msIh4LfnbW4GNjnW848Ub2EJA/2VtLhIPqsw0YSht1iA0e9u
         Dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z9Tf8Q4+BM5aumLuJFIjYqIwLRxLkiAzP1niqb/X+d4=;
        b=hNPGEH7QdxrBSi8S/VO0hUxxJqwf/9eHTGs5MkL15oLEkUj75fwf9dEo1NrSwCrZTM
         +GBcWoNiP+pIjYAyCW223+FsvD1Zpo8k2Vj41PmN0xljH/48CVukaDAF18yTmVC9P8HL
         mUw7AoQF+f4+jyFyL5yJDdOU/L49Qld9Mh0DAVmK6AdP12hh5OkJtRtywcoiwhNweqq/
         ECpjSsCm5/NFg3BVdyuvaE/GvZHR15VLKeg027adfrM1xJTJ6mo69fkRLN8P2r46ldud
         kcqkuAaOrk4UsLaczMlQGQPB8m7DDJah6ndKrF7wphaFZ34C4LSiPJJBhvkdlJxXq8Z7
         16NA==
X-Gm-Message-State: AOAM530AvqZTImCrnWeJGzRegm2igtc+7RHI8qq6VjyZQAL6fvtf6qkp
        eA0ka1oq9tqVjjFPRD5zKESWWcjNHbm7
X-Google-Smtp-Source: ABdhPJyy6HehMHXqdWnhi7VRSyiwU6JJU89gF1Mo6uJqWqgqR8gsfo6YYt2sbh7jNyIMQxS6dRZR/H63Q3nM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:: with SMTP id
 r11mr34534690ybu.358.1641363332606; Tue, 04 Jan 2022 22:15:32 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:41 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-39-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 38/48] perf evsel: Reduce scope of evsel__ignore_missing_thread
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

