Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467A2481A55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhL3HXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhL3HWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3987C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c5-20020a25f305000000b0060bbdf755f7so25228887ybs.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nzKeKFAPBZ6rzV0NFigpy2eDVIi9FKR8HBRsYCkfB/U=;
        b=UsntoWcISBfoeUdNkLtrkqLUCXuV3C/cSCX/5Y8o/iLgg/RnXmD9ffJx2/3iJFFAiR
         E9jN91+rDWflo53Ca44K7pMJOnOFdSn/F0o2YdLW+qFnBjEGt9hU4LgsHuHAYvCt09Y+
         RVanx7aw6p86GEW39zC3HrZjzIH9ExVTp/GX55VPjF9/WTETfPAiO2OYYhKJ4SORVii/
         cnyXDwLHR2X8gx2KccxG9IsjhzQQkzkAt3M+BgAPPrNi4S9jPcVhCACQVNEyLafg6JGY
         IX6SKhcIaHVeS8g6PfOWxtev4/4/J3ZFoxo9fG9qfjIICMoRZHkA6SXhwN6bVVqXS116
         42oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nzKeKFAPBZ6rzV0NFigpy2eDVIi9FKR8HBRsYCkfB/U=;
        b=LEtNp8fo24U9pLl2qByWpsyIVU/0yY0fB4qOiYde6uFzg3+EIPVPh4EVvzqmVj5E0O
         iK280sR3GRforpuQoGOOg0I3L46tU48bSMSjRlq1/xZeMp0lyoanmypLZSDIKvrsecqi
         B/vX0Rd9fcSbqEtJOtqvXFROSPZqDwF9GfcqBSC+GPXpnVUXJnDU26LcYJsEhV5f//C6
         t9Sl3w50IyXg8ap+pr/2+hJVRVVabmS1K+YmMVRUeJQxPKqvMm/Yg+XWTGuIoZnuHbMG
         NDospD0Pi3fCIp2ix/qbOfoOve3R0P0az318fZfYHpX3hfNvYgwy50OumPZWirMzwGJP
         UvEQ==
X-Gm-Message-State: AOAM530kcricgDVgaKNAccAlnyp2XIr2C4J5yUT7XFBXlWZZowvCh0/C
        p0aMKJ2MLSWjFOlNOtdvSO1QjNki9Wty
X-Google-Smtp-Source: ABdhPJzuD97DHHQINTddZQ7U07a5i/EHI+5mizcIFnBjhQnvGYZsTgq57fB9oUk9fU7E8+4CAaVUZrl3Zrbf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:cad1:: with SMTP id
 a200mr22061820ybg.183.1640848954194; Wed, 29 Dec 2021 23:22:34 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:28 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-48-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 46/48] perf script: Fix flipped index and cpu
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

perf_counts are accessed by the densely packed index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ce9c3c5d881d..935a6edcdcdc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2131,7 +2131,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
-			counts = perf_counts(counter->counts, cpu, thread);
+			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				cpu,
-- 
2.34.1.448.ga2b2bfdf31-goog

