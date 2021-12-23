Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336C47DFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347065AbhLWHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347016AbhLWHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD07C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p133-20020a255b8b000000b006086e19f89fso8555579ybb.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eEInaxEsEve0QLZ8igLVk6cMHD2TdWaDtxRpGZXeF78=;
        b=N0vrtFwLQU1q7abSqGMyKyZMpqH7TqawrR8F7sIDWlmeD8nJn1YMTHJnwzJzlGNmvt
         J7WxUSGU94JZE5zGQuPjqwRW1QkzYmMweoDdwYwwGCf0pmyb+cpjlMtiS+YlKlkPw1iR
         rq2SRy1jE+wFvR8RfYGvtYgC/UDaNpaeceparnLTY8Q648j1CTfvwCA0dFPnZrmtN8F9
         LHH3JcdArfNeGgnKwRr259ANm1LntQ4ThbBOyJxjc30YV9B/DPBPfHHyDPQhEULzvcne
         F3Od8Oj9uCQlNj7Gt4gC51eGmleTyedGxODKnOiBAUIFEaWS6Xfp4OcikxSR+E991UE2
         EZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eEInaxEsEve0QLZ8igLVk6cMHD2TdWaDtxRpGZXeF78=;
        b=2xg+Qy/JekfX77sJooOSg0STFZuEHSjnhzRJ6Fh7gWIZr4XardZrHoec+HokcwgUH7
         Ez0ey81FReqkXHw7X2GkVA15NMMUY+40Fg+Au0mhsv6pKE886WhzVqIA71M0WlVjh+AB
         htLvrH2+8g0b3aiuwz1IjPGb8ya50eLrK2lRbQlWLwdkqzZ+Lw3V0w8QHFTtaEsouoTv
         JCY82t7sHc+paVsvxXyvDgUyQ9DMfTeJtMXigOWNuS+yGQpcTdk1/2jUtuiiQQaTtuz8
         IF7lwfRw/YtYDGwJWUhiw2J5yG8qZkBEf9JjFSRBdYCLpbVq/l8spzSYW+K2TMN6/TvU
         CKyQ==
X-Gm-Message-State: AOAM53026vw+VfWYx9+2D34WreDUyicUhyH04DYPfU/6ZN3tDaZ3ymrd
        U0/Q67X4dwpoyd0HC3FQGA4ji1HiD909
X-Google-Smtp-Source: ABdhPJyMV9p5dilbpJj9lZFv4lwVDJfkQWdmjSih72KOOnbXd0DtxzUGLUbt+Dwd++RBqmm/x3rguqLNwJzC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:bbc7:: with SMTP id
 c7mr1571216ybk.725.1640245597478; Wed, 22 Dec 2021 23:46:37 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:05 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-13-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 12/48] perf cpumap: Remove unused cpu_map__socket
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

Unused function so remove.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index edd93e1db36a..22e53fd54657 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -53,13 +53,6 @@ int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **cor
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
-static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
-{
-	if (!sock || s > sock->nr || s < 0)
-		return 0;
-	return sock->map[s];
-}
-
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
-- 
2.34.1.307.g9b7440fafd-goog

