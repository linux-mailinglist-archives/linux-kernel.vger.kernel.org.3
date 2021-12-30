Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452D1481A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhL3HXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhL3HWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEBC061799
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so42329910ybp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=Zws7ZZxJY7H+IitPKKiJtRpYWgmcOU08af02CnBL0E0ZTp0HsEyFIQ/E+urT/Mcy/I
         ACtTpg8FOnc33cCYqZZWs7dKvfmWuNniCUe/LaB5nlMvKX1Ht8DiH95Zmh5nm1NFw0aW
         zqhVEf/A4A9EvkY4KVaaxGnfeo5OVLPAe42kalPtva5lEH/qq8VRtIokk1FRzPhXtZfz
         4SRYvc1feavUGmqNvsJJrCoxuSiwPcAnIdgcPENaWfro2NGedd4CW526lrWGozH3WVEM
         6XXxcxnMQnKzvTIIP8WRvmjAwLMeGe8CqTSio+lOi5QBmRlP1m9vlF67du5W8NGUT/Ny
         lgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=qMi3oOslU/DN5ggd5ic8gV6GWiFHXWRS9JnGMU4lLUHM8t40CAUf5itFtns4a+N8tv
         2ST3lwuo6szm55QvCd3OqK05wS0b0govaL9B+pgovuKJDP6CmMmu194ma88bbq56/11n
         61x9jepKv4RQ/yFkIrxCExF5l8yJOfGsltm2nk4oSvZuJu7JQuzJ+eHj2FdVcTFYQzyc
         dlQxG/dBWNUxVUx3w51acEkIPNntRxXWrwOMiH0bl66OJkgnkwfa2kKLyEXOMvBXxVuh
         5zKOPmkKpOewN+dMq2ojpUIOMgPzZiCbuOFCv3Ol0Z9Wi6C2pGkiPnXr956npGMEJeRK
         e3rQ==
X-Gm-Message-State: AOAM53245vtUAxBwQb8PgESeMXpTRc3ug8rTDGHfgMpx/wK4EbHdv5Ft
        NCDDxnp0onGd+oV/30TB3rFYkhYmS2T2
X-Google-Smtp-Source: ABdhPJwigVjXJYZ9ikakB8ZfTP6TpnqITXpuLBJ7OkrF2/KN+V54VA0H735gemfSniV3qXoGU0lsfQ8xraR9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:db8e:: with SMTP id
 g136mr26355395ybf.401.1640848931018; Wed, 29 Dec 2021 23:22:11 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:19 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-39-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 37/48] perf evsel: Rename CPU around get_group_fd
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

CPU is really a cpu map index, change names to make code more intention
revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b4a2c5034cfe..4b3ba4408af2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1591,27 +1591,27 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool
 }
 
 static int evsel__match_other_cpu(struct evsel *evsel, struct evsel *other,
-				  int cpu)
+				  int cpu_map_idx)
 {
-	int cpuid;
+	int cpu;
 
-	cpuid = perf_cpu_map__cpu(evsel->core.cpus, cpu);
-	return perf_cpu_map__idx(other->core.cpus, cpuid);
+	cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
+	return perf_cpu_map__idx(other->core.cpus, cpu);
 }
 
-static int evsel__hybrid_group_cpu(struct evsel *evsel, int cpu)
+static int evsel__hybrid_group_cpu_map_idx(struct evsel *evsel, int cpu_map_idx)
 {
 	struct evsel *leader = evsel__leader(evsel);
 
 	if ((evsel__is_hybrid(evsel) && !evsel__is_hybrid(leader)) ||
 	    (!evsel__is_hybrid(evsel) && evsel__is_hybrid(leader))) {
-		return evsel__match_other_cpu(evsel, leader, cpu);
+		return evsel__match_other_cpu(evsel, leader, cpu_map_idx);
 	}
 
-	return cpu;
+	return cpu_map_idx;
 }
 
-static int get_group_fd(struct evsel *evsel, int cpu, int thread)
+static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	struct evsel *leader = evsel__leader(evsel);
 	int fd;
@@ -1625,11 +1625,11 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	 */
 	BUG_ON(!leader->core.fd);
 
-	cpu = evsel__hybrid_group_cpu(evsel, cpu);
-	if (cpu == -1)
+	cpu_map_idx = evsel__hybrid_group_cpu_map_idx(evsel, cpu_map_idx);
+	if (cpu_map_idx == -1)
 		return -1;
 
-	fd = FD(leader, cpu, thread);
+	fd = FD(leader, cpu_map_idx, thread);
 	BUG_ON(fd == -1);
 
 	return fd;
-- 
2.34.1.448.ga2b2bfdf31-goog

