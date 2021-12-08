Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A346CB29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbhLHCu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbhLHCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64595C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so2017311ybf.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hYpYTDFXxSsoVkYy1jHn2SbW1AkpRXTBOSg3x8hoE+I=;
        b=GntIqi16/FljhCbUDkDxPhC4LNIgdmOpV4dJ2So1aKxreCoBravORnxiUkLx2CkJSC
         /fykHQkCmpp/cgUMJsDhTmWrroVu6/9P7DmYDrsxAL2qZSteqaxrjS0X1Qd7HuyHpDL/
         Z9BsXQilrAepah9i00PdhQwh5hMbC/JDsg1bG1qcNX0wdRxQpJkDq04z06c8UZJvZZa/
         BJpDDv7pnentNA2/yL9xKIaUrCATNGB6ZmWNK3nJWq+5f6upaRZ3qk0vl2uFB+BhEtQq
         avlEWUMkSx8urdGqXGH9E03I5GrArF6VmNnHOkVtmhieHeYtr9bnVByHLt2dne2zHvXR
         8pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hYpYTDFXxSsoVkYy1jHn2SbW1AkpRXTBOSg3x8hoE+I=;
        b=y5lzBSqJtg9dx9k6L0lkL/EVYJEMcsjVSKtBPKRA2BXXGPBXHXHIBgNiO/QljMqlUR
         gfSevXFSSB64CNwifymU6r4mZ6Wpdcyu1eXKtNWjGpWGHQkFC6IdkvpqaxUxnywyqiAp
         sniqzzdu82AJMkx47subcrycG+qTdzy8SJ3cY6pUE8ZpUYyeQPitxcUOJd21MLaC285k
         qmQmCEiVEkbR546K3ZhWiGdpfB+0QUzqwHDvcZy9fXvOrFWp4tbzzdxwiiKJLn4oyTiZ
         Po7dy2Y2pH+VsT9vc6c950ZgCJzA3tG3uwnnrtv6i1peB+PuWbbxHzHhSUKg5l5SWhUA
         hJoQ==
X-Gm-Message-State: AOAM5331/vSoYN1J7OEPsqtFV89mMHIQuNunr+H17Fw5NIoN2cvfP7mo
        VJj6DYVJTJjO4jin0q71CLXfzuPUfu+V
X-Google-Smtp-Source: ABdhPJx7kRG0Cq7IEtCACy2YDjiPd148/ePqZzICbzkQF1J6EF6GkkDn5nMlQsggVp6E+BXz6gZDetGMfhFA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a05:6902:725:: with SMTP id
 l5mr60752110ybt.314.1638931610639; Tue, 07 Dec 2021 18:46:50 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:01 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-17-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 16/22] perf cpumap: Remove cpu_map__cpu, use libperf function.
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
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the remaining few users of cpu_map__cpu to perf_cpu_map__cpu and
remove the function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 tools/perf/util/cpumap.c    | 9 ++-------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 87cb11a7a3ee..5a65dc7a1580 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -303,7 +303,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 	int ret;
 	int last_cpu;
 
-	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
+	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1);
 	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e0d7f1da5858..32f9fc2dd389 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -485,11 +485,6 @@ bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
-{
-	return cpus->map[idx];
-}
-
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu, start = -1;
@@ -547,7 +542,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	int last_cpu = cpu_map__cpu(map, map->nr - 1);
+	int last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -559,7 +554,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	}
 
 	for (i = 0; i < map->nr; i++) {
-		cpu = cpu_map__cpu(map, i);
+		cpu = perf_cpu_map__cpu(map, i);
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a053bf31a3f0..87545bcd461d 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -80,7 +80,6 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
-- 
2.34.1.400.ga245620fadb-goog

