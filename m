Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE84484E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiAEGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbiAEGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A382C0698CD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so71121304ybp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EYvYMoHkX/cH/EEuV/LiHLhSTbFzgAzJd57ZEVR8Iu4=;
        b=Fu3GC5iC8GhLJuK/H5hG+53FqKV9GpsBl5EeNh3cVKUvJW5BqD7gNbz3++7k0UzPMa
         ST+vMpnzYpkpJl1e1S9RjbHgF4DeTNvFY1lZZKztE5f8AruuKv//nYi623KS1cdDJkfx
         5h/5AMweEueOT+jPcWd9Wv80Od6m9FQHN53GLydmb7by5MflBlLj+mKvlZFUIpukuj5J
         xeI0Py99MDP/0kl6mvNDmBde6g8wbXaJGXFoR5If/Vbjq7aRfbnRD6HL/jsbw9+y1jj1
         QP+ivAEwolPqp0+ryVq7wjo2eecxgxlZt8jclFaFsIxJv2Pz/NxVaCFL5+d7Xtq7YJEE
         v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EYvYMoHkX/cH/EEuV/LiHLhSTbFzgAzJd57ZEVR8Iu4=;
        b=ArHC9NFooFchXC9YckRpCuzUpIkJhPezd/R7EFGV3wZ36lUDvH0dv/NMpSk8PbSJql
         qLgE9IbgWnbPlgtZdvDMI/HomHqZZcPdoBzXRzpakbj9iwbOOuEjViAZb7BqAQXnT7G2
         0zuPDzKtO8iK2hTPVh4J9rtRZU/LAVDfcDX6ewEjV2UMQ6BNzkwM8KvhQEdg8bRTtefN
         HDPW7ZZw7TRNP6fRVNXpu1eDHn+ygljVPntwC1td5arcg/+WGi42A+Ifq1W4pB/X3TAT
         NmLlSk9+/NR4883Nv0U+mvHN8W7wCc167OwFzwV5EMljn3PXPzDM9EsnhFyVep4r0N7/
         6Ufg==
X-Gm-Message-State: AOAM531ArtG6OqlkuQZX5bAtpqqZpw4aV9C9NtoBlnokp9nzQpdNwtr4
        Qo9ApbUVosaFRi7wjndpssCeR6gfUypH
X-Google-Smtp-Source: ABdhPJzh7+RbZq1k5ueTXFBeP+6MPU6d1EiyIuxj8Q2jS3heJuiBD2ox7DdBveTuHtCY6yyUEyi7vhmOML2v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:3748:: with SMTP id
 e69mr62345222yba.378.1641363344703; Tue, 04 Jan 2022 22:15:44 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:46 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-44-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 43/48] libperf: Sync evsel documentation
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

cpu was renamed cpu_map_idx, for clarity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index faef9ba3a540..32c5051c24eb 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -136,16 +136,16 @@ SYNOPSIS
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
-  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
   void perf_evsel__munmap(struct perf_evsel *evsel);
-  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
-  int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu_map_idx, int thread);
+  int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
-  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
-  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
-- 
2.34.1.448.ga2b2bfdf31-goog

