Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B42484E37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiAEGQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiAEGPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCEC061191
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so50722901ybb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=QZ2qFGHJYt+gz6xOXt1LhDiyGD+OPylHFok9czJlkdjuWFUMdmdaVPI6oWRcEqfwK3
         XwF3f8SH1obOmcA2aH+7S9uxsp/MnFT8O7h0CRlq921GR3uNm82uuW0G7VA049i6Fpod
         HDxG9APN7M8zfaIhi+5h71bK/cVV2YcEDiFdK7po8enphcw/uerbn6SaNgEaw/kuAWXk
         G3z0WkaYphAsdgTqS9FohJRPxxtzAgrLCLADCU4thPERKLo9avwHssOY5J1Vh6cGBvF9
         ilgXMJld057L5ODWQRYooaOgwVrE3hu/x9OdDD9OHAczymIIiU+ZHzvpKW/rF0CWy/Z1
         LDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XzElm/I104YF1oOu+ETkQDoVDrD7T7dkjmJMXov3Vlo=;
        b=RBG+xtJNsdiSsw2KVHHdCuHUbiSylkLBvJgVAQC6/rTZsG+nJl0+bzUsBSfZx9Ojmr
         FeyEY51ZQFbckdDUdfsqGb9NtnGshJAO9l6ETD9m0Mvi9sv+miSYGNBgjPymUj0xI1q1
         +8j2faAGDjmM/5O1/Nk9bwRzAlSFCUVsoLavm4Zvv1Walq2kuQmtHgGkZbdZ2bBk9lH2
         /JYs97Wqp8BRjvRAgUwPIXwLuZOrl5mk+Brz3H/Nth9lCAUoTq71QIiAycuam+YhqBQr
         wL/r6kjajH3vyImfTUEJ87wa1QmiaHJ3D4/DueFs96egM4xmxOemKPpWKvi6vKis08Nh
         4yrg==
X-Gm-Message-State: AOAM533x/T0UDxHYDNiFoE1AQDX6HXcNLP5srf/L7lzMWFZqtbPnJHyS
        lRwbWu4RFpHf0ahxE0N/Qd9zyxAuEUkJ
X-Google-Smtp-Source: ABdhPJwJ4RM9VYWq41fwhECqsHWaa6AOOt7H64isVIpH1h7i/JrS6rHORFMIbAVgnUhB8OfyDtXA7jZZ/TVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:ab4c:: with SMTP id
 u70mr56995726ybi.211.1641363329998; Tue, 04 Jan 2022 22:15:29 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:40 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-38-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 37/48] perf evsel: Rename CPU around get_group_fd
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

