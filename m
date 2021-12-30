Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1689481A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhL3HWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhL3HVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5EC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c5-20020a25f305000000b0060bbdf755f7so25225942ybs.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qNKIUlySFfRYFL3LsJVvo5UF9vFYVSjFaW2mryRhEhE=;
        b=gHS0SjBZ6BRQWd+TXVtPnKnWfJcnbY9nHdxIBK+Z7QvS0Q95E+qgPT9Ya5sOks/WiY
         4Zem4Fto7v+P7JwneQD9j1lXQ1LbUplJc3+2O8g7ONNy81WKHt6g4Ml2Xs6SkZX025Z8
         iDaQa1a1oP6oKjK3egsAXlt8/rJJBzky6vTRmNPGr87FjpRJRfHd7Vw8b0rPq6C+Um49
         gbfuwDDOX85qnbbek6UG5obuNQVIjsV0KggtY7T91qLF3UQqN2wlemYjCnF94P7r25UG
         J1D0DqMFHrItaIXAV0wQ5/imijprO7coWMKhIMUA/pLbQUWgXl1bEwwvk7ZoGd/ysO4o
         rk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qNKIUlySFfRYFL3LsJVvo5UF9vFYVSjFaW2mryRhEhE=;
        b=0/otvvlnDBEgSe1Qvv2ips19kSXoFmlT7jLvev7tEuYaBxrNjuMQ05ugsxwlQ2/+Z9
         1yIfMqOVuRI8GKuAuxZ/oiID425fWoMsiQPfbIsyuQEQLwteur8v1+aeu/G8r4fX/d94
         8OGQxJSkNw2c+6ly25tSSwtSgExQ/MrdhJqVLjTRzKgXdZQjz/JzsoQSzER0pSrEfE4G
         6vWMoMLJTUbdZF+II0wi4f6tz+D3LS1LsNM/Jm9Xq7ClUyKj6ALys8h3zGQ02IEN2tLS
         enONNwLfzT0mLDFoNnWlRmWI5EnHoJiPGdNmySutqmLMd9k0IoXdbW4aPJf8mvJn7/lO
         ZoOg==
X-Gm-Message-State: AOAM533s00VxwkF85ttVjbjDMUKTr4YrsnKxC+zZHBoa3RJgtL/II7nZ
        wRwzekFOJcK9igc9Bm9FQWD+hzj8KAcM
X-Google-Smtp-Source: ABdhPJx57wn5jbgLGLHvQD+JHSSIIVUaMPZPQ5HbrR5jNwrjUX9bWwqhME1VrhI9+q+Qzab4hM5N5+dYdEIJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:abc7:: with SMTP id
 v65mr13083631ybi.280.1640848890846; Wed, 29 Dec 2021 23:21:30 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:03 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-23-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 21/48] perf cpumap: Add some comments to cpu_aggr_map
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

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 832fc53f3c11..8acef8ff8753 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.448.ga2b2bfdf31-goog

