Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB17481A30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhL3HVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbhL3HVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDAC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so23366269yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zr180MbAuyMK3FOJ6p+f1v/pd05fFRyT7sFFspoiHfQ=;
        b=fP1j5ptzi9GlhwtnDvoqIyo74ilM6/YDYz1fP/LS32JpV9WtF2ADtQMONbQeWdcBNr
         OptvIPdqkgV4kFSvsZ1QsXNS2K/Fcf0b8RpyPjNxGoRbY1N1r2zcDhgqRSs2HDfVqH/+
         yXYctxMFAYB0cC6EnjxMGShfoysusAOtFsfnbfE3RPCFMncRBow/76+4W4Lad2WBCEHK
         2EiAKWKdDuKOuTbz8zTHq0zJxvWq16YJoFZyje/Ma+OF1LEZSt+XiXcUr6Gtz7wzmTZl
         ki3l4gK1+P/KlGJoKj19GUMOkhyCD2wB5KNtDjcyHF1aP97A4LhaJ7qQdZgUSvBcqdNv
         Prng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zr180MbAuyMK3FOJ6p+f1v/pd05fFRyT7sFFspoiHfQ=;
        b=Tf+bPsfZFn7sMIIXMcUPN21qMuwnB10UHGD4S/6bMT6akPe/ZDJbilxlnVWljToGMY
         HJBkAAgqZXva1Zdwv0DLn47tyoiwZCmL5Xupw+ct83QzQJFICfUoXcav7rBL9mT23Vp3
         pRe2Qlvw8F2j38/pYhfjY25zadAksXPEut6Dje8t2JDzjRG43mNR6HRhkKrzbpMm6jf+
         3FpmU5zvdltGfoaZ/t/jdk7vkgj5u5QiBnpQ7tyWsecuJS6v1guFFSqFzC8Fx6ZArcvW
         6A4qLRzDBz/VjhOKfqSUum9YEgnqIYe/q8NmtiZ+3T4AaoVPm9FUwmfc7zvz9bQQIBoy
         KWAA==
X-Gm-Message-State: AOAM530/LbyJEmkLSaxc4AKqRUg2zRIvL3QjtUoqjgJI9Al8l3H4ErZM
        Wc+xBBRBRJu2ZNsEOqfIrFJHA9V/JJ1N
X-Google-Smtp-Source: ABdhPJx7W8qgBsUFQ6UIrvbnMt3qUKs9cQzNi3g3VfufzTwauI827c+pL7b1ClFQ+Ed/Zjmjs5ush3YBLm1O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:aa34:: with SMTP id
 s49mr22340468ybi.356.1640848861508; Wed, 29 Dec 2021 23:21:01 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:51 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-11-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 09/48] perf cpumap: Remove map+index get_core
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

Migrate final users to appropriate cpu variant.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 2 +-
 tools/perf/util/cpumap.c    | 8 --------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ce085b6f379b..9a671670415a 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -121,7 +121,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_core(map, i, NULL);
+		id = cpu_map__get_core_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
 			session->header.env.cpu[map->map[i]].core_id == id.core);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ff91c32da688..e8149bcf8bfa 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -246,14 +246,6 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
-}
-
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 365ed69699e1..7e1829468bd6 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -36,7 +36,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
-- 
2.34.1.448.ga2b2bfdf31-goog

