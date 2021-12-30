Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA1481A46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhL3HWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhL3HWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946DC061191
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a256706000000b0060aa7315dd9so29858380ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=gd7scXcBk1yTnVwoiPe+9oH6SNITUOkpUrx9WTCnO9LW819DoLCEjIc4CjYDRfgbW8
         kpIcIaA0WXGx0A1JkH3+CNaDGqB3LbKNQy/dC69uwrapr1aB0K7K+nY8k+xsnN6eF4lR
         /nyWdqgi8c2eNr7SAmJDNL7ryVZ8uPy9AsDhfVRqK6mGUAbGuF5gKBfiymoyOc/lCu7g
         ZsKeKPIcAATBQs1wSFE96jQMWMX35qGZpKg86Ex1PLsLGuQ6bIj5+xVqZF25J4HmYKNJ
         9nc93dAkDv96SzZ07Mn1s0PVaixDu0PPpFVxb1RLChglabm5T7WAiOU71z4oo0XVwMfL
         9YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=1Rr5qG6MjL+EQXrecg+zTzyEIUwE0G4AexsPwtUBWN9QGH6Prx0cxfvnh0ESPnTj2D
         3tGWoj5D1ywXNOFsgroZhjqDckAHK8dPm1WF2O+mgec/lbBLieDEq3ttNjR/FH0uVQYj
         2HCPG1wq6SJaHIzkHsTUMAefwXFztZn4YUDi8GwjRR/gC3kza5X60wACN1pWKl3X04J2
         JldGvy7RaHFyNag2SOwSPcOIvnY4g28YCY3XsvAZbUb4qCS47pA1OqEMc1fZYyV/Nk5m
         IR1iUXI6PcSXxIkUzdM6BYQqvxZWHkYzlNiUfLw3BbNp007EnEYOA0bdjZHMy+me/LOX
         ORyw==
X-Gm-Message-State: AOAM533dggYT3rw7Ut4taSU6zQXnU/+j9dH6rKOCM54vL9oo93swgXOd
        o/iMNYNph2bv6HYa/3c/C1kCQLUJGaQg
X-Google-Smtp-Source: ABdhPJzroPIw7lL2p5xUk8nN/ROAI6MwcBgq9IhE3TcIDiuJTiQS4g8XAkhZduxh5XtQBLj5zuKGhd8qgHpF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:7b41:: with SMTP id
 w62mr37995471ybc.164.1640848920800; Wed, 29 Dec 2021 23:22:00 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:15 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-35-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 33/48] libperf: Allow NULL in perf_cpu_map__idx
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

Return -1, not found, if NULL is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3c36a06771af..eacea3ab965a 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -270,8 +270,13 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
-	int low = 0, high = cpus->nr;
+	int low, high;
 
+	if (!cpus)
+		return -1;
+
+	low = 0;
+	high = cpus->nr;
 	while (low < high) {
 		int idx = (low + high) / 2,
 		    cpu_at_idx = cpus->map[idx];
-- 
2.34.1.448.ga2b2bfdf31-goog

